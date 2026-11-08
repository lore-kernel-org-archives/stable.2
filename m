Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172055;
	b=fzAoKJh7ye8i2rHtXa70i3Nc90rHkxe+akNqsN0fPzwaXzuT6oR43sbBRDX3uQIxTcj0
	 DkNqHf7Bl5Les7JwhfEsYdZ1d09ilJ0OQXe1ZhYOmtZvbUXA/a9gLe1fiJyQPuPZpV0e7
	 XK1bZyP9JCrHFk1e62g2RpjTLMl9+yBKGRfgS/t9uDoslGf0KtXs7wV0y8FgGNZNQK4Zb
	 +t8E+Mn6jYPcvIhddZdkyVMN28Uo2HO5IH/anNjzZP2RU2jjxpWRIWxR9tuDWu8lRxrrw
	 8MjlQA/g3qcGecbelQN6z2wglvVkK17YyJKadI67xUP2hmd+unjvN5dHZGXIg2SC8EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=EEsTvDHWsy6BHKFJlVpg36WKPFu4YHw4KdAe6UCxLUM=;
	b=nJSYZMJXmzwM/HJKDKoTZ4LE4nTIRF+wE9LFBZPVfkFq2NNpLFbwziMcXD+70V5NPSnu
	 OMphifw/Ah0mKpjhXGgXEzkbIdq8RV4Dxt2DbRFWwLM5eLji7YozkRVxB8n/BUAAPIRY/
	 whV5d+3bMSBmhlNNMWj92U7CMfF9/yD8ShmnSJ5lzYKU375AB4HnQgGPnUadC37/oPNlK
	 d4KWyhzHc9f7ie/Y+oOpYLm32um3fD2Q2bffvp+S7O41qUmJwCLUOB0j+n4ZpPo1eKWZc
	 +AtIrdaS6TfxpZUJ3jvHQelJ1fJKcrPZa5PCHjCh9ayhaRlSyeO4JNRrPzQQduZiBFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUlW3VUY;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB0606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AB0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUlW3VUY
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-85a6c747dc9so213558a34.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794172054; x=1794776854; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EEsTvDHWsy6BHKFJlVpg36WKPFu4YHw4KdAe6UCxLUM=;
        b=nUlW3VUYxv/20AOy5He78UCiODQk+rJyY8JBf+kdnoHP1JRRcvrwXc+HhkmVg2gx9A
         B8jM0YaNJW7we1B6F6cXugT6AiupWGZYIkBtZubLUXVgyUHO58fwg5dt3V8pMXJjvis0
         rHuJQ7f0sQdIuuvnKxbHKv2Mlnln8sLDqtT2FmeXT2Xb8dsYASJ5BRLQb68HTgCOyUwO
         o89857EcWhaTI5IdVEF9zreguiEEoJm1RjuKAac2Xjh6vJHYb5i0FSXVXGqpNbcWyzeW
         YyzZlPwebAkL50Ak86re4I+mKVLiezfULIjFlkO5w4HuUMmNzl7oH+EBp7TCZbI1DRw1
         DurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794172054; x=1794776854;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EEsTvDHWsy6BHKFJlVpg36WKPFu4YHw4KdAe6UCxLUM=;
        b=m3g0lFczSMZyryogwezJyLyqRn2lM+FFoxwUz4ZoBSY3Cli2G9rP9zR6L1oQKyOxYK
         HhvBh7MMqSfqeHb7Q/bWChuImKU274KvB+KYijaEsznoti/JhZDvkI0SLK6UClghR8ek
         hjhq6sq0MJY5sik3QcJCEFeGo4z9KUdpaxOhRhWGNQN3FJkicveWIfUTBs0y0MCVtv2t
         LpxN29c+GYJZfpKeTSecc64I6IUBV+bDwDhwR/2IRFgF/guf1V4E5ktNXsx4uGwjPEi0
         DS4n5P0KeeiLbEAhmtyZojrMyw+rnmGHqD3PNTZawfzsAnQDgZjrxG7YTCjoIP4r9DP/
         mvww==
X-Forwarded-Encrypted: i=1; AL+hErExs6YJ70BzOT7JLsq7tySsWseWv7pmBHjk2vukclmkixMoXZpKVPXCdzgfITlQ/TVOV+oLAkk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eKQmwXVYUHHcXEzmJUq376JHQnZDZHGZ9yhiSIrpT1lt4Uy9E
	Npq2L+FgDzl1vO452AEmqQnWSmKYbe10U9TolNR6G9jdlrahcTzdz9BU
X-Gm-Gg: AYBFou1f6MH149unieXW4Y39+oFvGOQbroS+XdEfmzrvFYlK0Q12sPbJA4FlIatpt1S
	V9Kvf7tw2dagxZgngE+3vysLeqCtvPxjSQew3hXndRkdC4jRU6w/TeYgjVSe8OU/72UZWb2x5UH
	EJmFyDgOPQ0nh8JDJQgJvYrarV8lYviIOaEChbyCRXqQagIy6467WhZshM9FHtxZiNXzRp/1nJd
	Elmi57QkPbKkHlNJHacrIslkG8wmfw8kWKhkhU9jgGXUj1VHPo/cJS4ybpAwzJMFBKHYYnWVqZf
	mRoRtPBbX5ZAezf31kuU+NLB0pBrOprLeyGuhjZWDUZzwsTYOc85pw+Q470durr2wYqlJqRIV8K
	osBGPWfFXHvQRPhEagCfnzLjf7bog7QFNXQ8ISkz+fLWOolOUEbb4P8L2sPXP3QQRm9zXDsDLp5
	2r/5wmUgVoKse+TuUhEMZFFN7obcVtDbQJHP+oy2I7Q9wg0tSXhaBwwx/rtwgGhWRpcBrH0MKw1
	H4qG11DhIAsRm/ceUPaDA5yG9MgBgbAMlmwDf4NYTvTQZFP+/lVe0h3zAd796n2HbpoENUMaQNx
	cg7ad50p689woLjnQXe7FPkWvPeH4yPfDi/htso+aIl+JIloMqN6xph0QUGKtY0zpyX4Vy4i8GU
	8BH7sm4I9FepvXIGCNa1LXUgK199X7Fjx//9qcqwaiQrHL9VtHYK/QxWlCgo81jI4VhAq5q6OCU
	QnNA+nZwLjs3voRcvEEuxnNNAIia3HSc4QIrN8Uh1COdBQpuAJ9YWx
X-Received: by 2002:a05:6830:82f4:b0:85c:e511:ee04 with SMTP id 46e09a7af769-85f34abf688mr2547935a34.16.1794172053785;
        Sun, 08 Nov 2026 13:07:33 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fb2b331sm2147379a34.10.2026.11.08.13.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:07:33 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:07:31 -0700
Subject: [PATCH] mtd: rawnand: atmel: release the NFC IRQ before controller
 cleanup
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-submit-atmel-nand-irq-teardown-v1-v1-1-341643c83ee3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN3Q6CMAyG4VshPbZhm4mot2I82E+RGim6TSQh3
 LubHr5fmqcrJIpMCc7NCpFmTjxJCb1rwA9WboQcSoNR5qC16jC93cgZbR7pgWIlIMcXZrIxTB/
 BWWN/UmavOq+PwUFxnpF6Xn4/Ltd/F+ROPle4XjibCF204oc6jTm0VW6Flgzb9gWEzj8YpQAAA
 A==
X-Change-ID: 20261107-submit-atmel-nand-irq-teardown-v1-f902307c18db
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The NFC interrupt is shared and devm-managed. Controller removal disables
the clock used by the legacy binding before devres releases the handler.
An interrupt from another device on the shared line can therefore make
atmel_nfc_interrupt() read the NFC status with its clock disabled.

Release and drain the handler before freeing the controller resources.
Track successful IRQ registration because probe also uses this cleanup
path when requesting the IRQ itself fails.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 0bdbcbb50d94..9a724de67624 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -263,6 +263,7 @@ struct atmel_hsmc_nand_controller {
 	struct completion complete;
 	u32 cfg;
 	int irq;
+	bool irq_requested;
 
 	/* Only used when instantiating from legacy DT bindings. */
 	struct clk *clk;
@@ -2334,6 +2335,9 @@ atmel_hsmc_nand_controller_remove(struct atmel_nand_controller *nc)
 	regmap_write(hsmc_nc->base.smc, ATMEL_HSMC_NFC_CTRL,
 		     ATMEL_HSMC_NFC_CTRL_DIS);
 
+	if (hsmc_nc->irq_requested)
+		devm_free_irq(nc->dev, hsmc_nc->irq, hsmc_nc);
+
 	if (hsmc_nc->sram.pool)
 		gen_pool_free(hsmc_nc->sram.pool,
 			      (unsigned long)hsmc_nc->sram.virt,
@@ -2383,6 +2387,8 @@ static int atmel_hsmc_nand_controller_probe(struct platform_device *pdev,
 		goto err;
 	}
 
+	nc->irq_requested = true;
+
 	/* Initial NFC configuration. */
 	regmap_write(nc->base.smc, ATMEL_HSMC_NFC_CFG,
 		     ATMEL_HSMC_NFC_CFG_DTO_MAX);

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261107-submit-atmel-nand-irq-teardown-v1-f902307c18db

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

