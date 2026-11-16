Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839077;
	b=AERM4btPCH2zBuad5oGjiz9+0wFXQ3eAxpM+tfo2EgxyO0JZm0ak/GbNg3ymW9QlXlkl
	 KOJqtrU7/gdl4h9wOnIUFQxNsbOZyxnFiEBdYsW7NL5Df687lTz2vMItRigD4WV10M6ed
	 Jf0q69NlD/6M7eknD3mT8q1/LSMOvuoUoI2oM7CZKg5I7imgrRtC6G+QdO+aGph+lXD5U
	 4PC2cMDQyXmngqMmtAA9g40D15XFkHZmOoyWrprfZAMylX9hHpaQUh+Z+C31cwp1RAEA3
	 7mhOvXCU5R0bnincxO79+cGDUXOmSsrqd0aKmYezQCawQhkfEU+G4GKYRXMz8MRozqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839077;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=vsitf1gCOt+86OlSnGNHzwq1zmuiy2PBWHlc3qqYy+Q=;
	b=Whc8ru+vmIhGqpIVDJSZXd4U8tujRJlDVYQ+VtyjbJ/sUXNhSljNmt65TyIJf8EEmRN0
	 mUCQxliJjnWo4s2P54jviOXH6x+jjuckdOGc6S7lhdWIzVjISEF9CfUB9vuWDsItxr0BW
	 nEyu4PQYmreV0aJh5IFQAIum6gV+5IG2mPV1fTuTZZdhS7JhOKOTsVNaO5glnFDlHAmV1
	 JGJNQt7vbGLYQLZUp/m8xGd/2QbOAMsifqeyq91Q7PWaGt8Akev1wAChqlpx1+IyrPkfR
	 0avBiF7HGz8spR2cdYLcA/INthmDNAYraiMLE+MXunxel0bT+b9lPee2/81Sja/mbtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XISsBhif;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E0606A32A;
	Mon, 16 Nov 2026 14:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D40E0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XISsBhif
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54dbcb476;
	Mon, 16 Nov 2026 22:24:29 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: [PATCH] serial: 8250_aspeed_vuart: Fix potential stale port on probe failure
Date: Mon, 16 Nov 2026 22:24:28 +0800
Message-ID: <20261116-c29ba55625-serial-aspeed@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1e4bec2f203a1kunm8be27f0910e50c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0NKVkhOTR9JGh5CGE9MSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=XISsBhifYCn6xh7OaTRbFGgVwiNZZiOpkthsG6JNvk/Z/i6mtIwSCXIOBml8hm6ef4Hr0L+SAmpO8kJt09+6ziFv1NkOJ838dmKWYaXigNYLolHm7Ss50Jr10pdVwp/2F8qJqvoI1xFDpiNrm/dRw8kN0YJ7F/Vx/F2d3LdYnjA=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=vsitf1gCOt+86OlSnGNHzwq1zmuiy2PBWHlc3qqYy+Q=;
	h=date:mime-version:subject:message-id:from;

Invalid LPC configuration can fail probe after the UART port has been
registered. Removing only the sysfs group leaves a port whose private
data and mappings are released by device-managed cleanup.

Disable the VUART, shut down its timer and unregister the port before
returning from these failures.

This issue was found by our static analysis tool under development.

Fixes: ca03042f0f12 ("serial: 8250_aspeed_vuart: add aspeed, lpc-io-reg and aspeed, lpc-interrupts DT properties")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index c8dc87f6886c..2cd1c9146ec8 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -513,7 +513,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	rc = aspeed_vuart_set_lpc_address(vuart, prop);
 	if (rc < 0) {
 		dev_err_probe(dev, rc, "invalid value in aspeed,lpc-io-reg property\n");
-		goto err_sysfs_remove;
+		goto err_unregister_port;
 	}
 
 	rc = of_property_read_u32_array(np, "aspeed,lpc-interrupts", sirq, 2);
@@ -525,14 +525,14 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	rc = aspeed_vuart_set_sirq(vuart, sirq[0]);
 	if (rc < 0) {
 		dev_err_probe(dev, rc, "invalid sirq number in aspeed,lpc-interrupts property\n");
-		goto err_sysfs_remove;
+		goto err_unregister_port;
 	}
 
 	sirq_polarity = aspeed_vuart_map_irq_polarity(sirq[1]);
 	if (sirq_polarity < 0) {
 		rc = dev_err_probe(dev, sirq_polarity,
 				   "invalid sirq polarity in aspeed,lpc-interrupts property\n");
-		goto err_sysfs_remove;
+		goto err_unregister_port;
 	}
 
 	aspeed_vuart_set_sirq_polarity(vuart, sirq_polarity);
@@ -543,6 +543,10 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_unregister_port:
+	aspeed_vuart_set_enabled(vuart, false);
+	timer_shutdown_sync(&vuart->unthrottle_timer);
+	serial8250_unregister_port(vuart->port);
 err_sysfs_remove:
 	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 	return rc;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
