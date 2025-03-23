class Stack<E> {
  final list = <E>[];

  void push(E value) => list.add(value);

  E pop() => list.removeLast();

  E get peek => list.last;

  bool get isEmpty => list.isEmpty;

  bool get isNotEmpty => list.isNotEmpty;

  @override
  String toString() => list.toString();
}

class Queue<T> {
  List<T> elements = [];

  void enqueue(T element) {
    elements.add(element);
  }

  T dequeue() {
    return elements.removeAt(0);
  }

  bool isNotEmpty() {
    return elements.isNotEmpty;
  }

  void clear() {
    elements.clear();
  }
}

class PriorityQueue<T> {
  List<PriorityQueueNode<T>> _heap = [];

  int get size => _heap.length;

  bool get isEmpty => _heap.isEmpty;

  void enqueue(T element, int priority) {
    _heap.add(PriorityQueueNode(element, priority));
    _heapifyUp();
  }

  T dequeue() {
    if (isEmpty) {
      throw StateError('PriorityQueue is empty');
    }

    final T top = _heap[0].element;

    if (size > 1) {
      _heap[0] = _heap.removeLast();
      _heapifyDown();
    } else {
      _heap.clear();
    }

    return top;
  }

  void _heapifyUp() {
    int index = size - 1;

    while (index > 0) {
      final int parentIndex = (index - 1) ~/ 2;
      if (_heap[index].priority < _heap[parentIndex].priority) {
        _swap(index, parentIndex);
        index = parentIndex;
      } else {
        break;
      }
    }
  }

  void _heapifyDown() {
    int index = 0;

    while (true) {
      final int leftChildIndex = 2 * index + 1;
      final int rightChildIndex = 2 * index + 2;
      int smallestChildIndex = index;

      if (leftChildIndex < size &&
          _heap[leftChildIndex].priority < _heap[smallestChildIndex].priority) {
        smallestChildIndex = leftChildIndex;
      }

      if (rightChildIndex < size &&
          _heap[rightChildIndex].priority <
              _heap[smallestChildIndex].priority) {
        smallestChildIndex = rightChildIndex;
      }

      if (smallestChildIndex != index) {
        _swap(index, smallestChildIndex);
        index = smallestChildIndex;
      } else {
        break;
      }
    }
  }

  void _swap(int i, int j) {
    final temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }

  List toList() {
    return _heap;
  }

  bool replace(T oldValue, T newValue, int newPriority) {
    int index = _heap.indexWhere((element) => element.element == oldValue);
    if (index == -1) {
      return false;
    }

    _heap[index] = PriorityQueueNode(newValue, newPriority);
    _heapifyUp();
    _heapifyDown();
    return true;
  }
}

class PriorityQueueNode<T> {
  final T element;
  final int priority;

  PriorityQueueNode(this.element, this.priority);
}
