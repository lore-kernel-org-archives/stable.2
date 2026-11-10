Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344865;
	b=bS+aBKD81Ueawa9eyqmaAI2BPsUpw+OU0QpS8m5NOUaNGgklZiJQ1VKJ/SMvnJqX5fZK
	 Qxav3o/QeBa6NEXpf1ygtKsO/3bIsmp2rYth5zCFMtZkOf8urAIxmkF96DxD/pKHkh7Qx
	 4uTbiWHnyJvFiwKATfB83jHoNOji8JJFlD8RAf1rVlEx2ISOM2kUxss0kwr/vtDvId+q3
	 JlJfqvKOBI+ohBquN7SU18tLK0c8Jj7yP88JmW7+OzsTbscUrdvZyTXX0u9ZmbmWtGOhf
	 yA4FNzO9ITcuhQxCMJy1vUI1td0KQSEMGL/Cx13dsYKfB23hurDGN6/dmxX9dm5m/bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JE7mqktlFvqy5/VunWNYnwXkQ12KkIQ8/9/Gyny8Sv0=;
	b=Q5vgSnPxk15Kvbg9sdUUvRJGlZq2ERcxwO4MNWVbBB4tBEs1EhhcDnDeZWvd9fCZK6v4
	 qXG8U8b8qNyYl9fiXodvAtC9BftbXtvH4pfrr45tzLjZuIWHaXC8VFx8IA2cjBYtfJFxg
	 nS3h3QWuLA7Luazbe79uvDKXHgcPcz9Z02HYXQR1hy1R3K/bzlpRprzyzcMPJy4wcuOzL
	 +pElFUZMs/gVQNJ1UPM9lT/KSUisoLos0WNipM3KjcvhhDSmxN/kyzIhANIk5qlLUbXaw
	 Gz1f0Z8UtI2bYLSuJXtH9eqrjCDVZ/d8TX2GyJcXAVyXf4vOx7JW98Y4zeFOUCp+k0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMGS39dQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83645606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMGS39dQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0901F008A3;
	Tue, 10 Nov 2026 21:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344865;
	bh=JE7mqktlFvqy5/VunWNYnwXkQ12KkIQ8/9/Gyny8Sv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cMGS39dQy/nLfcekW5DKXXlCFnIf5Zm9hBO3dUjt3vWGcZ90J1GRmOvPeTBLCk2An
	 qOQ3aGU0RKXw4IX5G7OWnClFwLxlommPKtGfpJGK2TFbbZQFy3fVIgnP1UST2qMUt1
	 CFtRMln5xqdTVJNYxV8lmAyVBXTb/Zt798kzom4fcQDS9ej70sYMnPWsgJWPE23wsB
	 4jxabVBr0QV8WRhwd4rlNXCtW1GaLN8VutP7+4EMmClVYqBd+r11tChpw+RwDJJK7F
	 4K8dV7cGAHVJxDkM4JTVeYu9RCADfw4BVC1jtZ1GChXHiaLnoVcLw2VNC3XvjHbfzP
	 HNckGtsGxrpdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] serial: exar: fix checkpach warnings
Date: Tue, 10 Nov 2026 16:07:40 -0500
Message-ID: <20261110210731.3853158-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110210731.3853158-1-sashal@kernel.org>
References: <20261107060524-failed-5.15-33d337816e00@kernel.org>
 <20261110210731.3853158-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parker Newman <pnewman@connecttech.com>

[ Upstream commit c6795fbffc4547b40933ec368200bd4926a41b44 ]

-Fix several "missing identifier name" warnings from checkpatch in
struct exar8250_platform and struct exar8250_board.
Example:

WARNING: function definition argument <arg> should also have an
identifier name

- Fix space before tab warning from checkpatch:
WARNING: please, no space before tabs
+ * 0^I^I2 ^IMode bit 0$

Signed-off-by: Parker Newman <pnewman@connecttech.com>
Link: https://lore.kernel.org/r/f7fa6c16cb5f2c8c1c7cb7d29f80bc7be53f91ab.1713382717.git.pnewman@connecttech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 33d337816e00 ("serial: 8250_exar: store the GPIO platform device in struct exar8250")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_exar.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 2740840679d78..b5275cad4a69b 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -133,7 +133,7 @@
  *
  * MPIO		Port	Function
  * ----		----	--------
- * 0		2 	Mode bit 0
+ * 0		2	Mode bit 0
  * 1		2	Mode bit 1
  * 2		2	Terminate bus
  * 3		-	<reserved>
@@ -168,8 +168,8 @@ struct exar8250;
 struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
 	const struct serial_rs485 *rs485_supported;
-	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
-	void (*unregister_gpio)(struct uart_8250_port *);
+	int (*register_gpio)(struct pci_dev *pcidev, struct uart_8250_port *port);
+	void (*unregister_gpio)(struct uart_8250_port *port);
 };
 
 /**
@@ -184,8 +184,8 @@ struct exar8250_board {
 	unsigned int num_ports;
 	unsigned int reg_shift;
 	int     (*board_init)(struct exar8250 *priv, struct pci_dev *pcidev);
-	int	(*setup)(struct exar8250 *, struct pci_dev *,
-			 struct uart_8250_port *, int);
+	int	(*setup)(struct exar8250 *priv, struct pci_dev *pcidev,
+			 struct uart_8250_port *port, int idx);
 	void	(*exit)(struct pci_dev *pcidev);
 };
 
-- 
2.53.0

