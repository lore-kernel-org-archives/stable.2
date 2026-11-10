Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343375;
	b=W3QM5Ml+YpOfonfQFFuF0ANZSFmkjSYdYW8IO5upc7mUAveDDuIEPEgOGA2o0dRdSX8x
	 mmdCBnTLDNhHVnV2W7R//wtznda+/lvYL0EXMyRT2vXFGLgxUaydYLfiHqSDaLSKyI+gS
	 0er9isMjvhe16gnGK/uaI2nQg8M17nCn9FSIzNl6cApZPcqh4Jw6P6B2SwECCJb+g6qoi
	 3wXfc8y6Ha4ru7VM3nqLoPK4WxU+HK71eu/JdC725RNhmIRguX4tyoL9oDHVHcxfsASey
	 9wYpBBBjiVy4DyKe76gRyfscP7Q+w/XR00iJB812cr69tmDjvpI/nXwUrhpBXpoqSAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343375;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AJdXVKKMpKiB8LfhNt9bVF9b30/2kKpO6YaE6Z3NiB0=;
	b=PRtDFyhV/GNl/Nv54a0CPeWs9X5SYgi65IfyxbapxWQIC2CS7QZ19Tg10Eo0VA6GV+h5
	 ODqqFGOHpuib/qr6XU8tTLoIkME/p1xdLnRuPBHPA4VDgra7wA8gUpUk7iL/LFXfqmMXA
	 jB8wM0Mct8I/id+cGAQYaYGeHHPTYdVGaIH3aIuNpEyur0mEd/d6NgSexjyV5+8QBup1s
	 pHOe5ARCQtpdFcy+6j7R3+Srxzb5nsmM3bfOfiOcn3eSBcJw0/KyU1Ak0mBSXDwhO25tR
	 YM8F6mIbTWZyj9p9Ven82rhxiWmeoQMvrsOK5lNFZapX33GyxHP66M7QbQeiWIzh4PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVReMBkP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65F606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVReMBkP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF231F008A2;
	Tue, 10 Nov 2026 20:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343374;
	bh=AJdXVKKMpKiB8LfhNt9bVF9b30/2kKpO6YaE6Z3NiB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SVReMBkPLpxC762DDc9nvoEWLFHY459xi8PicoXsDa4dgRJ/7vOD5p94d1Ms852Vs
	 VW2yrAxY265nGeeKEqqTLHgPBDYhtW0OPoDJbAmdhWOBv9e1c1CDt0yzJ+ZKInvkk+
	 KPn5bQvTUSsZ9+nAEOsgsnHNB63B/5TKVJR9AoHiQViopNrmx5iQTjpSA92+xTKEqG
	 4bk9X/VQNYuf35i67zuPDWk1F7MnvkdhT/qADwy84l4Ks2kqsSybcMcus05Ou/9zuH
	 ZPEjyFvX21l/TMix84Bs2MzpuHXIN4cxrHEt9znce+NEYM7IhbEgOtbCie57QB6LJF
	 OFYXygEv9ryPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] serial: exar: fix checkpach warnings
Date: Tue, 10 Nov 2026 15:42:50 -0500
Message-ID: <20261110204132.3796786-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110204132.3796786-1-sashal@kernel.org>
References: <20261107054802-failed-6.1-33d337816e00@kernel.org>
 <20261110204132.3796786-1-sashal@kernel.org>
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
index 060090adabac6..9326a7bd4e2a1 100644
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
@@ -169,8 +169,8 @@ struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
 			    struct serial_rs485 *rs485);
 	const struct serial_rs485 *rs485_supported;
-	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
-	void (*unregister_gpio)(struct uart_8250_port *);
+	int (*register_gpio)(struct pci_dev *pcidev, struct uart_8250_port *port);
+	void (*unregister_gpio)(struct uart_8250_port *port);
 };
 
 /**
@@ -185,8 +185,8 @@ struct exar8250_board {
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

