import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class PaletaColoresFrame extends JFrame {

    private int xMouse, yMouse;

    public PaletaColoresFrame() {
        // Ventana plana estilo Material Design
        setUndecorated(true);
        setSize(450, 600);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Panel Principal
        JPanel mainPanel = new JPanel();
        mainPanel.setBackground(Color.WHITE);
        mainPanel.setLayout(null);
        add(mainPanel);
        mainPanel.setBorder(BorderFactory.createLineBorder(new Color(218, 220, 224), 1));

        // Barra de arrastre superior
        JPanel headerPanel = new JPanel();
        headerPanel.setBounds(1, 1, 448, 40);
        headerPanel.setBackground(Color.WHITE);
        headerPanel.setLayout(null);
        mainPanel.add(headerPanel);

        // Botón cerrar (X)
        JPanel btnClose = new JPanel();
        btnClose.setBounds(408, 0, 40, 40);
        btnClose.setBackground(Color.WHITE);
        btnClose.setLayout(new GridBagLayout());
        JLabel txtClose = new JLabel("X");
        txtClose.setFont(new Font("Segoe UI", Font.BOLD, 16));
        txtClose.setForeground(new Color(33, 33, 33));
        btnClose.add(txtClose);
        headerPanel.add(btnClose);

        btnClose.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) { System.exit(0); }
            @Override
            public void mouseEntered(MouseEvent e) {
                btnClose.setBackground(Color.RED);
                txtClose.setForeground(Color.WHITE);
            }
            @Override
            public void mouseExited(MouseEvent e) {
                btnClose.setBackground(Color.WHITE);
                txtClose.setForeground(new Color(33, 33, 33));
            }
        });

        headerPanel.addMouseListener(new MouseAdapter() {
            @Override
            public void mousePressed(MouseEvent e) {
                xMouse = e.getX();
                yMouse = e.getY();
            }
        });
        headerPanel.addMouseMotionListener(new MouseMotionAdapter() {
            @Override
            public void mouseDragged(MouseEvent e) {
                setLocation(e.getXOnScreen() - xMouse, e.getYOnScreen() - yMouse);
            }
        });

        // Título de la ventana
        JLabel lblTitle = new JLabel("Paleta de Colores (Figma a Java)", SwingConstants.CENTER);
        lblTitle.setFont(new Font("Segoe UI", Font.BOLD, 20));
        lblTitle.setForeground(new Color(33, 33, 33));
        lblTitle.setBounds(20, 50, 410, 30);
        mainPanel.add(lblTitle);

        // --- FILAS DE LA PALETA DE COLORES ---
        // Estructura: crearColorRow(Nombre, Objeto Color, Hexadecimal, Componente UI, Y_Position, Panel)
        
        crearColorRow("Azul Primario", new Color(0, 74, 224), "#004AE0", "Botón Continuar", 110, mainPanel);
        crearColorRow("Azul Hover", new Color(0, 55, 180), "#0037B4", "Botón Enfoque / Hover", 180, mainPanel);
        crearColorRow("Texto Oscuro", new Color(33, 33, 33), "#212121", "Títulos y Textos Principales", 250, mainPanel);
        crearColorRow("Texto Gris", new Color(153, 153, 153), "#999999", "Placeholders y Separadores", 320, mainPanel);
        crearColorRow("Borde Suave", new Color(218, 220, 224), "#DADCE0", "Líneas de Input y Divisiones", 390, mainPanel);
        crearColorRow("Fondo Social", new Color(250, 250, 250), "#FAFAFA", "Botones de Google y Apple", 460, mainPanel);
        crearColorRow("Fondo General", new Color(255, 255, 255), "#FFFFFF", "Fondo de la Aplicación", 530, mainPanel);
    }

    // Método para dibujar cada fila de color de forma limpia y ordenada
    private void crearColorRow(String nombre, Color colorObj, String hex, String uso, int yPos, JPanel contenedor) {
        // 1. Muestra visual del color (Cuadro sólido)
        JPanel muestraColor = new JPanel();
        muestraColor.setBounds(30, yPos, 45, 45);
        muestraColor.setBackground(colorObj);
        muestraColor.setBorder(BorderFactory.createLineBorder(new Color(200, 200, 200), 1));
        contenedor.add(muestraColor);

        // 2. Nombre del Rol del Color
        JLabel lblNombre = new JLabel(nombre);
        lblNombre.setFont(new Font("Segoe UI", Font.BOLD, 14));
        lblNombre.setForeground(new Color(33, 33, 33));
        lblNombre.setBounds(90, yPos, 150, 20);
        contenedor.add(lblNombre);

        // 3. Uso sugerido en la UI (Subtítulo corto)
        JLabel lblUso = new JLabel(uso);
        lblUso.setFont(new Font("Segoe UI", Font.ITALIC, 12));
        lblUso.setForeground(new Color(120, 120, 120));
        lblUso.setBounds(90, yPos + 22, 200, 20);
        contenedor.add(lblUso);

        // 4. Código en sintaxis de programación Java
        JLabel lblJavaCode = new JLabel("new Color(" + colorObj.getRed() + ", " + colorObj.getGreen() + ", " + colorObj.getBlue() + ");");
        lblJavaCode.setFont(new Font("Consolas", Font.PLAIN, 12));
        lblJavaCode.setForeground(new Color(0, 100, 0)); // Color verde código
        lblJavaCode.setBounds(260, yPos + 3, 180, 20);
        contenedor.add(lblJavaCode);

        // 5. Código Hexadecimal de Figma
        JLabel lblHex = new JLabel("HEX: " + hex);
        lblHex.setFont(new Font("Consolas", Font.PLAIN, 11));
        lblHex.setForeground(new Color(66, 133, 244));
        lblHex.setBounds(260, yPos + 22, 100, 20);
        contenedor.add(lblHex);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new PaletaColoresFrame().setVisible(true);
        });
    }
}