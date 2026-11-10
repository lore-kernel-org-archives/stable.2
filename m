Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342065;
	b=kgwrjkOOZz5/p1Fi6RRxqp6cVZ52EMY1RALm6TXxDDmbpn5t8kpwaKtVpV0nBZgik5p3
	 PNwffRSk+sRmB5QbT7WOZLKIJNTV8jcOTcS3iNINYfzYGdyaztvYdg01wYi6OyH+4QMQP
	 +EVYzpwaGA6XO8NDsdUCPrx0mXTCA0Q+OqDXfelaRgfmUR6LHFOPKxCzAc2jJgKbsaRIg
	 cdUITNTGcZijB/J643MRd6qS3a3uTlq/Ymv5dh7xvEv/my3TXOKzONN+f4D2A6+y/iVDv
	 g2hKL43BJu+ZO+pgCc2+QuLrStPVpbgND4e50aztHLxzJm6HbMuTX1K86+CO/uB29oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342065;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W0i0SayVhR6VHQZ75dHrAcMdoxlHzNF4qCcZkfoYLBA=;
	b=DWp4BwM+d9y6vNm1p5S/pnv5UqnHtZc7LAkiDggJ3ZTKyYVSywYiPc6Bv839VrGtaitp
	 w4/E3TB3/FW5aVd8fI3+37x9bH3sDliuOFpmHqc5YHx4Ds2zB2AjerBQXTXqhu6KdbUWp
	 4vvWvc1CxoR9/THvj6goE5+ts8oEvoOVKsjiNp1JhkHUeyNu1cwssjns4JnwdZaWQDhkN
	 Q31mwOJPup/NY5jMU+/46SsVK1MvZGjQ6DknfWznaQEhOfzl+NKxrLdrK5W3eSGpqNo8X
	 SYkyQGp2h2/4+Sse8RshJoxjKQ1SzOebKqR+BlczMV2W074cqln4dzZ14U55AgWr4dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AAu/hnVO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5208606B5FA
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AAu/hnVO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74591F008A1;
	Tue, 10 Nov 2026 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342065;
	bh=W0i0SayVhR6VHQZ75dHrAcMdoxlHzNF4qCcZkfoYLBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AAu/hnVOSGl0V5i1Gl0Fs7Hnt5lngQEWnpqODfqGCLvhKJyv7d8+BZwBrX1NDYDEf
	 l1RbWmC4iiJSxLbB6ZmAkbzXkjJV1IIH+8Ir+RZgi1+cQXJ0TOS6EQrF+WqppWBAhl
	 56YIxtbLWHGz+9em3ELeDtpGC/H+/vAP8NMgpCePM/vQpQNs5P9QbA4Fw89RjodB6m
	 Z5d+LjNqTLNgXoQ6NyBcLYw16djnk/ToSkWn6RnHNtoEUmc6XeJa99JxKBHtqb62bL
	 JvsKfPrtTXpGLlxuzbd+cGnQGDAD3H6YQUJaF2IkAQMzyJaP+ZCRrre/IIJFPmgvs6
	 79gEGoFToYd5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] serial: exar: add optional board_init function
Date: Tue, 10 Nov 2026 15:21:00 -0500
Message-ID: <20261110202051.3754797-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110202051.3754797-1-sashal@kernel.org>
References: <20261107053424-failed-6.6-33d337816e00@kernel.org>
 <20261110202051.3754797-1-sashal@kernel.org>
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

[ Upstream commit 393b520a99b21d9ec6d4bb32e7c05bbb4f6dc777 ]

Add an optional "board_init()" function pointer to struct exar8250_board
which is called once during probe prior to setting up the ports. It will
be used in subsequent patches of this series.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
Link: https://lore.kernel.org/r/0e72a3154114c733283ff273bc1e31456ee101f4.1713382717.git.pnewman@connecttech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 33d337816e00 ("serial: 8250_exar: store the GPIO platform device in struct exar8250")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_exar.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 95cde2c001118..d8e2dd5a2451e 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -177,12 +177,14 @@ struct exar8250_platform {
  * struct exar8250_board - board information
  * @num_ports: number of serial ports
  * @reg_shift: describes UART register mapping in PCI memory
- * @setup: quirk run at ->probe() stage
+ * @board_init: quirk run once at ->probe() stage before setting up ports
+ * @setup: quirk run at ->probe() stage for each port
  * @exit: quirk run at ->remove() stage
  */
 struct exar8250_board {
 	unsigned int num_ports;
 	unsigned int reg_shift;
+	int     (*board_init)(struct exar8250 *priv, struct pci_dev *pcidev);
 	int	(*setup)(struct exar8250 *, struct pci_dev *,
 			 struct uart_8250_port *, int);
 	void	(*exit)(struct pci_dev *pcidev);
@@ -730,6 +732,15 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
+	if (board->board_init) {
+		rc = board->board_init(priv, pcidev);
+		if (rc) {
+			dev_err_probe(&pcidev->dev, rc,
+					"failed to init serial board\n");
+			return rc;
+		}
+	}
+
 	for (i = 0; i < nr_ports && i < maxnr; i++) {
 		rc = board->setup(priv, pcidev, &uart, i);
 		if (rc) {
-- 
2.53.0

