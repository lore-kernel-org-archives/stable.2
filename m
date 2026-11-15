Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743292;
	b=Y6Aq+Zefr5vdJ7n0mAmJLzuwOaHsqgX4yfWw+71OucYoe/z4xOiR47rnskPZFxS82nRf
	 dHwWLtbesXaDYB2j8Pi1BpKdnRDE/b6ep6Uw6BY96pyVkHN4A4WYMUcbmnfegWVKdMxs3
	 UPPsGpFpiPw3rmN0x55t87t5L+YhMm+z2reOf3nhci6Qcau/Ev57ZOBVJo3ul2nX6ENjD
	 N8sK+nHsJQVIxHVz5iFnEZzPLqIoXqE2i0vqEgut3QRD5Nfqj8flOTeF14AIIuE8w9GUo
	 ZHwiGOGKLwWgQkf53fKmEv8ZtbqLMOgYpgOyvbwJEbvySUMafbyJguGMCFujRd5WXEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743292;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Bv9gCevH/+FIfoLSK2kJbM2sZfdEGa7J4pwZ68VLq/8=;
	b=TRrpLvWOnR/MoXO8vFcdZENeZXHNXWt1/jOP7aKqTwE9JywlESFEEeTGnRqUpV0XX3pr
	 FEA1Z+XG9igx2ggwvX3WuBJ3Hj7Iw3Fyv1KBC7n46FA1f6twRuL8tj4KfWhBCE/SzDVCe
	 4trINB7g32c/EY62LRk25bU4HH5wL9FrFmhOxuenf6/OWum2E9rucrm1FgrExPjXildd1
	 kfISH8T4cjbfuJK6jJUS5hXwwtYLJhuMuF3l95GTqbVo1zjWt2P1trEMqlAh8mg/KpkVh
	 ljyNTHofuxzdlM0d67QF3IGZbQobjAB2zSH6NwqELY++QE+qe7MhCfOINEGtz683COw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b="X/wwuzMV";
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A4E606A898;
	Sun, 15 Nov 2026 11:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23A4E606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=X/wwuzMV
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04ef;
	Sun, 15 Nov 2026 19:48:06 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v2] usb: host: ehci-atmel: stop clocks before releasing HCD
Date: Sun, 15 Nov 2026 19:48:04 +0800
Message-ID: <179474328429.103840.11561415733183356947@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df093c5203a1kunmbac61c98bf7b1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0xDVh4YH0sYTk9CTBhISVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=X/wwuzMV9fd4pTJMLSh/sPgRmss8WvxtM8Je4yrIJJwkPg7+8qsbuiuetIta7X+lkqw2Pxzgq4u5nZfQKUJP7Mx52h0vqC+UQe2QJeGg372qv4E86bQQ2uG2CxuAcM8UpwMNNUmQV1p4IfKkD4SZoLym8aOsAKc0amVxh4mToBI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Bv9gCevH/+FIfoLSK2kJbM2sZfdEGa7J4pwZ68VLq/8=;
	h=date:mime-version:subject:message-id:from;

usb_put_hcd() can release the HCD and its private data. Calling
atmel_stop_ehci() afterwards retrieves that HCD from platform data
and accesses its private clock state.

Stop the controller clocks after usb_remove_hcd() has quiesced the
host, but before dropping the driver's HCD reference. This matches
the probe error unwind, which already stops the clocks before
usb_put_hcd().

Found by the author's in-house static analysis tool.

Fixes: 501c9c0802d9 ("USB: at91: Add USB EHCI driver for at91sam9g45 series")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260806060557.1747-1-getshell@seu.edu.cn/
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/usb/host/ehci-atmel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 6574727..bcd56f8 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -177,9 +177,8 @@ static void ehci_atmel_drv_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	usb_remove_hcd(hcd);
-	usb_put_hcd(hcd);
-
 	atmel_stop_ehci(pdev);
+	usb_put_hcd(hcd);
 }
 
 static int __maybe_unused ehci_atmel_drv_suspend(struct device *dev)
-- 
2.50.1.windows.1
