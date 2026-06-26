import java.awt.*;
import java.awt.event.*;
import java.awt.geom.*;
import javax.swing.*;

public class LoginFrame extends JFrame {

    // Variables globales para mover la ventana con el mouse
    private int xMouse, yMouse;
    
    // Paleta de colores (Sacados de Figma)
    private final Color clrBackground = Color.WHITE;
    private final Color clrPrimaryBlue = new Color(0, 74, 224);
    private final Color clrHoverBlue = new Color(0, 55, 180);
    private final Color clrTextDark = new Color(33, 33, 33);
    private final Color clrTextGray = new Color(153, 153, 153);
    private final Color clrBorder = new Color(218, 220, 224);
    private final Color clrBtnSecondary = new Color(250, 250, 250);
    private final Color clrBtnSecondaryHover = new Color(235, 235, 235);

    public LoginFrame() {
        // === PASO 1: CONFIGURAR LA VENTANA BASE ===
        setUndecorated(true); // Quita los bordes nativos de Windows
        setSize(400, 650);    // Tamaño estilo pantalla móvil
        setLocationRelativeTo(null); // Centra la app
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Panel contenedor principal
        JPanel mainPanel = new JPanel();
        mainPanel.setBackground(clrBackground);
        mainPanel.setLayout(null); // Absolute Layout activo
        add(mainPanel);
        mainPanel.setBorder(BorderFactory.createLineBorder(clrBorder, 1));

        // === PASO 2: BARRA SUPERIOR DE ARRASTRE Y BOTÓN X ===
        JPanel headerPanel = new JPanel();
        headerPanel.setBounds(1, 1, 398, 40);
        headerPanel.setBackground(clrBackground);
        headerPanel.setLayout(null);
        mainPanel.add(headerPanel);

        JPanel btnClose = new JPanel();
        btnClose.setBounds(358, 0, 40, 40);
        btnClose.setBackground(clrBackground);
        btnClose.setLayout(new GridBagLayout());

        JLabel txtClose = new JLabel("X");
        txtClose.setFont(new Font("Segoe UI", Font.BOLD, 16));
        txtClose.setForeground(clrTextDark);
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
                btnClose.setBackground(clrBackground);
                txtClose.setForeground(clrTextDark);
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

        // === PASO 3: TÍTULO ===
        JLabel lblTitle = new JLabel("Introduce tu correo", SwingConstants.CENTER);
        lblTitle.setFont(new Font("Segoe UI", Font.BOLD, 24));
        lblTitle.setForeground(clrTextDark);
        lblTitle.setBounds(30, 100, 340, 40);
        mainPanel.add(lblTitle);

        // === PASO 4: INPUT CON PLACEHOLDER ===
        JTextField txtEmail = new JTextField("Ej: correo@ejemplo.com");
        txtEmail.setFont(new Font("Segoe UI", Font.PLAIN, 15));
        txtEmail.setForeground(clrTextGray);
        txtEmail.setBounds(30, 170, 340, 45);
        txtEmail.setBorder(BorderFactory.createCompoundBorder(
            BorderFactory.createLineBorder(clrBorder, 1),
            BorderFactory.createEmptyBorder(0, 12, 0, 12)
        ));

        txtEmail.addFocusListener(new FocusAdapter() {
            @Override
            public void focusGained(FocusEvent e) {
                if (txtEmail.getText().equals("Ej: correo@ejemplo.com")) {
                    txtEmail.setText("");
                    txtEmail.setForeground(clrTextDark);
                }
                txtEmail.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(clrPrimaryBlue, 2),
                    BorderFactory.createEmptyBorder(0, 11, 0, 11)
                ));
            }
            @Override
            public void focusLost(FocusEvent e) {
                if (txtEmail.getText().isEmpty()) {
                    txtEmail.setText("Ej: correo@ejemplo.com");
                    txtEmail.setForeground(clrTextGray);
                }
                txtEmail.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(clrBorder, 1),
                    BorderFactory.createEmptyBorder(0, 12, 0, 12)
                ));
            }
        });
        mainPanel.add(txtEmail);

        // === PASO 5: BOTÓN CONTINUAR ===
        JPanel btnContinue = new JPanel();
        btnContinue.setBounds(30, 240, 340, 45);
        btnContinue.setBackground(clrPrimaryBlue);
        btnContinue.setLayout(new GridBagLayout());
        btnContinue.setCursor(new Cursor(Cursor.HAND_CURSOR));

        JLabel txtContinue = new JLabel("Continuar");
        txtContinue.setFont(new Font("Segoe UI", Font.BOLD, 15));
        txtContinue.setForeground(Color.WHITE);
        btnContinue.add(txtContinue);

        btnContinue.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseEntered(MouseEvent e) { btnContinue.setBackground(clrHoverBlue); }
            @Override
            public void mouseExited(MouseEvent e) { btnContinue.setBackground(clrPrimaryBlue); }
        });
        mainPanel.add(btnContinue);

        // === PASO 6: SEPARADOR "TAMBIÉN PUEDES" ===
        JLabel lblSepLeft = new JLabel();
        lblSepLeft.setBorder(BorderFactory.createMatteBorder(1, 0, 0, 0, clrBorder));
        lblSepLeft.setBounds(30, 330, 100, 1);
        mainPanel.add(lblSepLeft);

        JLabel lblDividerText = new JLabel("TAMBIÉN PUEDES", SwingConstants.CENTER);
        lblDividerText.setFont(new Font("Segoe UI", Font.BOLD, 11));
        lblDividerText.setForeground(clrTextGray);
        lblDividerText.setBounds(135, 320, 130, 20);
        mainPanel.add(lblDividerText);

        JLabel lblSepRight = new JLabel();
        lblSepRight.setBorder(BorderFactory.createMatteBorder(1, 0, 0, 0, clrBorder));
        lblSepRight.setBounds(270, 330, 100, 1);
        mainPanel.add(lblSepRight);

        // === PASO 7: BOTONES SOCIALES CON LOGOS DIBUJADOS ===
        
        // Botón Google
        JPanel btnGoogle = createSocialButton("Continue with Google", 30, 370, true, mainPanel);
        // Botón Apple
        JPanel btnApple = createSocialButton("Continue with Apple", 30, 430, false, mainPanel);
    }

    // Método Dinámico para generar los botones sociales
    private JPanel createSocialButton(String text, int x, int y, boolean isGoogle, JPanel container) {
        // Usamos una subclase anónima de JPanel para interceptar el método paintComponent y dibujar el logo
        JPanel btn = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                Graphics2D g2 = (Graphics2D) g.create();
                g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
                
                if (isGoogle) {
                    drawGoogleLogo(g2, 25, 13); // Coordenadas del icono dentro del panel
                } else {
                    drawAppleLogo(g2, 27, 12);
                }
                g2.dispose();
            }
        };

        btn.setBounds(x, y, 340, 45);
        btn.setBackground(clrBtnSecondary);
        btn.setBorder(BorderFactory.createLineBorder(clrBorder, 1));
        btn.setLayout(null); // Layout nulo interno para posicionar el texto exacto al lado del logo
        btn.setCursor(new Cursor(Cursor.HAND_CURSOR));

        JLabel lblText = new JLabel(text, SwingConstants.CENTER);
        lblText.setFont(new Font("Segoe UI", Font.PLAIN, 15));
        lblText.setForeground(clrTextDark);
        lblText.setBounds(60, 0, 220, 45); // Desplazado a la derecha para no encimar el logo
        btn.add(lblText);

        btn.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseEntered(MouseEvent e) { btn.setBackground(clrBtnSecondaryHover); }
            @Override
            public void mouseExited(MouseEvent e) { btn.setBackground(clrBtnSecondary); }
        });

        container.add(btn);
        return btn;
    }

    // Dibuja el clásico logo 'G' de Google usando trazos vectoriales geométricos
    private void drawGoogleLogo(Graphics2D g2, int x, int y) {
        g2.setStroke(new BasicStroke(3.5f, BasicStroke.CAP_BUTT, BasicStroke.JOIN_ROUND));
        
        // Arco Rojo (Superior)
        g2.setColor(new Color(234, 67, 53));
        g2.draw(new Arc2D.Double(x, y, 18, 18, 45, 135, Arc2D.OPEN));
        
        // Arco Amarillo (Izquierdo)
        g2.setColor(new Color(251, 188, 5));
        g2.draw(new Arc2D.Double(x, y, 18, 18, 135, 90, Arc2D.OPEN));
        
        // Arco Verde (Inferior)
        g2.setColor(new Color(52, 168, 83));
        g2.draw(new Arc2D.Double(x, y, 18, 18, 225, 90, Arc2D.OPEN));
        
        // Arco Azul y Barra Horizontal (Derecho)
        g2.setColor(new Color(66, 133, 244));
        g2.draw(new Arc2D.Double(x, y, 18, 18, 315, 50, Arc2D.OPEN));
        g2.drawLine(x + 9, y + 9, x + 18, y + 9);
    }

    // Dibuja la manzana de Apple basada en curvas de Bézier planas
    private void drawAppleLogo(Graphics2D g2, int x, int y) {
        g2.setColor(Color.BLACK);
        
        // Cuerpo de la manzana
        GeneralPath body = new GeneralPath();
        body.moveTo(x + 7, y + 4);
        body.curveTo(x + 5, y + 4, x + 2, y + 6, x + 2, y + 11);
        body.curveTo(x + 2, y + 17, x + 5, y + 20, x + 7, y + 20);
        body.curveTo(x + 9, y + 20, x + 10, y + 18, x + 12, y + 18);
        body.curveTo(x + 14, y + 18, x + 15, y + 20, x + 17, y + 20);
        body.curveTo(x + 19, y + 20, x + 21, y + 16, x + 21, y + 13);
        body.curveTo(x + 16, y + 12, x + 16, y + 7, x + 21, y + 6);
        body.curveTo(x + 19, y + 3, x + 16, y + 4, x + 14, y + 4);
        body.curveTo(x + 12, y + 4, x + 10, y + 4, x + 7, y + 4);
        body.closePath();
        g2.fill(body);

        // Hoja de la manzana
        GeneralPath leaf = new GeneralPath();
        leaf.moveTo(x + 12, y + 3);
        leaf.curveTo(x + 12, y + 1, x + 15, y, x + 16, y);
        leaf.curveTo(x + 17, y + 2, x + 15, y + 4, x + 13, y + 4);
        leaf.closePath();
        g2.fill(leaf);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new LoginFrame().setVisible(true);
        });
    }
}