Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344865;
	b=zsArg0KRqsnbSNagATsaGpXMWfhmHJlOJhjSwgOHhplssK32lIncwNZBZF0j+fDWYpCu
	 T9tbTM/ha2BgQXlYO714uPLgpt/+sKQ75/Qr/E7TPc5frTKVG6wUX189FpTfCk1kaKDhT
	 oR0CDZyzJc2fj0/rBJ7KL84JZN883SWXtmg1RLnPFH6Dc2EIo1DO5XkuQja6zP5zkDOnX
	 nLFQ+UOl1FOc9T4HJH442mM/gsxp9eSMFXGbdtestRHs+lPNU5HiOs335TXgvACx+yG3U
	 8jJ9WPyW/osH60QA9D9aD0pUZ2iGIt3uoRmLi4Au3HoHJ6WRMRHds9oNbZnY1dcfjKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CxtQ15hqanswlIuVOQx3IDtPj0z5bC9YA1WOH3fBXcA=;
	b=ZH/3GJiKD566lsrqKBJqNxC+PEhMWm8f1RmJm0O7ofda7wfpvbrieTnJDMnI3xrb1TK2
	 ymQYPITemtbbA7b1wqEJWMWrFTFB0seDP67gVgEzDyg70yRACS7iQWQqw8FdYknBbeBXX
	 a7zgzf6AeSR691HalFWn7ZroCTLgBhOdTTY1Uk9iHIy0cUkIjPlewD+MIuCb4iPSQDDei
	 4+QYb/Izz76PB1+fm0AwBKA853S3WxWEQcVlsTXHF5foW0/d0dpLA8fVKvK3WkUeDko4T
	 VA1Zq+8bqFIn/zSah3ifwV5A7CyMPj6s7G1ct4TgszHsVdtux7DaXSRmUwOv3tGiuiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUoqY+bS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2C606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUoqY+bS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9BE1F008A2;
	Tue, 10 Nov 2026 21:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344864;
	bh=CxtQ15hqanswlIuVOQx3IDtPj0z5bC9YA1WOH3fBXcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CUoqY+bSRb27g3Y3w9etgdjU3iXVo97O3obMNRxv5eJqvC7QRWg2rqzFmI+XBC8nK
	 8i0ZQ32Em9hIP4VIOVOxdJ5S+C7UwTrYyzM79O18LdYLg4K4aRs2t+VcDGfezY6hG/
	 E5/PVb4Qxbt8hTlVrkFQHZClNnTzdeySBFeeCkWN9HqwpBU/1csuiWIuGUR1lPGh1q
	 POqMoQ3hevvJQKfHGeGPDWtU7di1UANRXmtkVGMCpWR0dUAYMA+HNSRHwsZn3r/JGS
	 m5T9Q1wEK/VwJFsDht2hIcWsBA6xynxQSy+aYteDSdXV46qm73m+Ei0JNPBQzhs1ow
	 zGRqqg1z1FlUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] serial: exar: add optional board_init function
Date: Tue, 10 Nov 2026 16:07:39 -0500
Message-ID: <20261110210731.3853158-2-sashal@kernel.org>
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
index 8672c8d06a89e..2740840679d78 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -176,12 +176,14 @@ struct exar8250_platform {
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
@@ -727,6 +729,15 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
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

