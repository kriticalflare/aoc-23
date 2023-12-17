package com.kriticalflare;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;



public class Part1 {

    private static class Node {
        String value;
        Node left;
        Node right;

        public Node(String value, Node left, Node right) {
            this.value = value;
            this.left = left;
            this.right = right;
        }

        public String getValue() {
            return value;
        }

        public void setValue(String value) {
            this.value = value;
        }

        public Node getLeft() {
            return left;
        }

        public void setLeft(Node left) {
            this.left = left;
        }

        public Node getRight() {
            return right;
        }

        public void setRight(Node right) {
            this.right = right;
        }

        @Override
        public String toString() {
            return "Node{" +
                    "value='" + value + '\'' +
                    ", left=" + left.getValue() +
                    ", right=" + right.getValue() +
                    '}';
        }
    }

    static int solve(String path)  {
        List<String> lines;
        try {
            lines = Files.readAllLines(Path.of(path));
           } catch (IOException e) {
            e.printStackTrace();
            return -1;
        }

        String directions = lines.getFirst();

        HashMap<String, Node> map = new HashMap<>();
        for(int idx = 2; idx < lines.size(); idx++){
            String line = lines.get(idx);
            String key = line.split("=")[0].trim();
            String[] children = line.split("=")[1].split(", ");
            children[0] = children[0].replace("(", "").trim();
            children[1] = children[1].replace(")", "").trim();
            Node node = new Node(key, null, null);
            map.put(key, node);
        }

        for(int idx = 2; idx < lines.size(); idx++){
            String line = lines.get(idx);
            String key = line.split("=")[0].trim();
            String[] children = line.split("=")[1].split(", ");
            children[0] = children[0].replace("(", "").trim();
            children[1] = children[1].replace(")", "").trim();

            Node leftChild = map.get(children[0]);
            Node rightChild = map.get(children[1]);

            Node node = map.get(key);
            node.setLeft(leftChild);
            node.setRight(rightChild);
        }
        System.out.println(map);

        var steps = 0;
        Node curr = map.get("AAA");
        while (true) {
            var direction = directions.charAt(steps % directions.length());
            if (direction == 'L') {
                curr = curr.left;
            } else {
                curr = curr.right;
            }
            steps++;
            if (curr.getValue().equals("ZZZ")) {
                break;
            }
        }

        return steps;
    }
}
