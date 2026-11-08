Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171963;
	b=ksPiM74Bg5ZQL0ked7/nbpT0m8lh4BaVDUt8G/C+dL39VJXLjYVBt9iX9U88LEvUbDZx
	 nwtm2PqR/JUhpC/J5wXZdJTfwyhtAGHMNYfs8J3rn6e3kFseCPstfg4/KpFUK3D37+F+q
	 rhBEDJtE2eILIItCNwar3YLnEDTLZqbdbhr2WkExpMe8+xIOch/HBsdbn5X48DianVVEj
	 fIEkiXV94Hy5HiECdKssxt+KgA8kK8nyRkQSTdt8YLfCSH/eGJhOovYi6SV3uN97jfhpf
	 AJcH1dd9x106bSOdxGa6JIpVT3CHd78yBCgC9fua4/EIG5iDPb0z6eNX+TevZ1jRWFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=GNWXWN4JgZ7053uqaoeB99xmhmDCtwvTAn5dZkJ9Sik=;
	b=vFQKQV6pCA+5Jcro/DnagrDPQ8oqmOsxJko1qrk6b8SGhr1NymEPrOnxfwtbDSjUDp25
	 TGnSKLFzg0DPVidszWQ03CKAz/kOnuZc0Fif76hn5vM7qAeFX8BqmzOGKqJMNRK3Wc/Oo
	 dJs36PlobUk2kOaLcld0o9vB5CZWt8xWSbQMky8MiPdxgSUhhmvSPaKeSDSlKsmkmf/Gg
	 oaoe/zYGhUZZOBGykZZemZiqnohZE+/P9FXZKXqjp0UJ6YngcgdS4BlUTtsBpEv19mLKs
	 IOsBEGmOTakHKIcNrRL65UDI3C/nV95wExt4CPxsufi7aNwwaZ6AAQ8zuC6386rLNLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pEOmnNMk;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDCF606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CDCF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pEOmnNMk
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-85f39332862so91716a34.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794171962; x=1794776762; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GNWXWN4JgZ7053uqaoeB99xmhmDCtwvTAn5dZkJ9Sik=;
        b=pEOmnNMkD8sFntj+FkOJGpjj8rcZAQMLRp/9VvuUb3AzT1pihw3SfSA61TPxtOUEGm
         GUX4v1V6qJWUWjzC7Hvb0FWsyBA8Ch9EZ87VthO/0eR9SJ0oDdX3CDZf0K6sOzeE0Fot
         kaYJ+xE09txht8kdIuA8zNWdlKagXEkqGEwb3iKZGFv+Di8zv94zFDZphOnH0Q+w16th
         73EOxV0NT0/ycAsVR9EOuvPddp0N6ASIopAqFHlOYJdz69r4xaLeiCRlItlvC9HWAcQw
         WCN62W3WMtcDViHj2vYEXVwI71BiAJoBQeNmDKMLVrzqvR7k4sw+29YdGbvAhhZNqL2X
         rciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794171962; x=1794776762;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GNWXWN4JgZ7053uqaoeB99xmhmDCtwvTAn5dZkJ9Sik=;
        b=2m69aBrbK5+cBAuHdqv2B0rzEppWTJUYiQR8aE1KwgH+SZ62WzfPEw+TBtI7MvqSyt
         uWSS2uc3uZ06Sm8WOjNvkP0ghjrBxAl0qeU+uM7kn90yxtz4ehz+0U5HMkqZB7Z8SkhE
         WwN7IKevSH9Tniu41EBR4AQiWUuVeZyM0Yab0LPzhCWt8f6eXsvp5+9g8NgsAwmLyhWT
         PIm7kWSDlgT9q2xtnUHBpungxyrkjnbmMI04kGRxRTiyPTU6BDgRuFBmdwvUbIFf+cCM
         xPw3kjXAu0bpX2dXaBhgSBL4zxZI3pC1payqULnTPHcQmpP24P6dHhO04/x14ca7eN+J
         SI6w==
X-Forwarded-Encrypted: i=1; AL+hErHazrtokNSJIFaWXQT2UQ9iAk6bxcwmNEMj7jXq09qLtxaHikpwdWSr5+BoyTXfNhb1WvPrK+c=@vger.kernel.org
X-Gm-Message-State: APuU4Z86DURWrqNQ7GsqzzIpAsVdFHe5n29sx8C4VYkQx1M6neWyMB0K
	8oxTfipmbUwwfFavysp93o4vD5oIDSi1tJ69wb1andt8AZBt9RUuU/VP
X-Gm-Gg: AYBFou1GbbzcZILYVE5TFC6CHX8qdguJ3UGIbDHnP2lq/c2WpYq2bb7offkHiaS/0Fc
	Gq1KPSG39DHAWpUpJ6pECcivM8MdjNrObE1arBWfvqwoeLfHDiU6iTo6XMmYin2c1Px31UZWT4h
	aMkFm5hnPR+kaUIhb3gLPZLr8ZzIBO01QuTM/eXbV2hsz6pAId2yuqYUqLI+Q7Ch7ReYFTAV6rN
	LSkDC7vWp4pF0grpggZ3gBYu8RQzmlf3BKaWmVOmCwL6z7sWAKcj5OSxT7LIc1lO/YxBSNsU8Vp
	83etvOP2rDJTLkh6LLx9Pr+7n9jrR7MnvnRXkevPbPfghBYM6hnzOlxLJgOzQUzlpifCMiUG2zY
	0Y57KY/0yoqG7w03ugBpWYVa1Eyt3olS0lKcfv1PJGmaxlQfPd2Inoxuy+JWktKKToa/tvE3MUe
	oBWyjZ72ljJU/KjZ1BK+5UwyuYktzLq2958hqAGwUM+zs86Zzg1fHTOMHwXozVepo8XN9sSgFun
	+WqLYx0ZJagLPqhkmU8xv7PVC9JXRxPJTCNUDKqccawuOhnYQfDygChmV1SK81tEhmQRBVuPMUq
	OP5dvS47mGhiW63Rd8mRJfHX/k0OhODn1TCa3ZOjls8rSQ/Dry9e6GdLUtx6QOjLVzLlQXj/Gh6
	Srn2qgvY7XUoWPVAcG0PPx7x2bRf+maDFGUdXwYTz027NWymRNY8/Lvjb2XxbIHRvhjsCwoazUm
	DGEcKpEAGdeRG2vbVwD/MhmWN+QWD07HUauzQ8rIQLszG/BQ0GuedYdvr4CvSx4gWOHatXf8odi
	g==
X-Received: by 2002:a05:6830:2317:b0:804:ec69:3979 with SMTP id 46e09a7af769-85f50854422mr1625444a34.21.1794171962292;
        Sun, 08 Nov 2026 13:06:02 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fbcef97sm2275583a34.21.2026.11.08.13.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:06:01 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:05:55 -0700
Subject: [PATCH] mtd: rawnand: tegra: drain the IRQ before disabling the
 clock
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
Message-Id: <20261108-submit-tegra-nand-irq-teardown-v1-v1-1-2c570ad4a22c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN3Q6CMAyG4VshPbZhA4M/t2I82E+BmVC0m0hCu
 Hc3PXy/NE83iCSBIlyrDYSWEMPMOfShAjcaHgiDzw2Najqt1Qnj204hYaJBDLJhj0FeOY34+cO
 4aOxU3x0vrWrt2UF2nkJ9WH8/bvd/Z+RBLhW4XFgTCa0YdmOZpuTrItdMa4J9/wI6p3S/pQAAA
 A==
X-Change-ID: 20261107-submit-tegra-nand-irq-teardown-v1-60f649303b8c
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The managed IRQ handler remains installed until devres cleanup, after
removal or a late probe failure has suspended the controller and disabled
its clock. The handler can still be accessing registers at that point:
it signals the command and DMA completions before its final register
accesses, so waiting for a NAND operation does not drain the IRQ handler.

Mask controller interrupts and release the managed IRQ before dropping
the runtime PM reference. Apply the same ordering when chip initialization
fails after the IRQ has been requested.

Fixes: d7d9f8ec77fe ("mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/tegra_nand.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 7f9eb5f042a7..1104d75b6cbe 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -1212,10 +1212,13 @@ static int tegra_nand_probe(struct platform_device *pdev)
 
 	err = tegra_nand_chips_init(ctrl->dev, ctrl);
 	if (err)
-		goto err_put_pm;
+		goto err_free_irq;
 
 	return 0;
 
+err_free_irq:
+	writel_relaxed(0, ctrl->regs + IER);
+	devm_free_irq(ctrl->dev, ctrl->irq, ctrl);
 err_put_pm:
 	pm_runtime_put_sync_suspend(ctrl->dev);
 	pm_runtime_force_suspend(ctrl->dev);
@@ -1234,6 +1237,9 @@ static void tegra_nand_remove(struct platform_device *pdev)
 
 	nand_cleanup(chip);
 
+	writel_relaxed(0, ctrl->regs + IER);
+	devm_free_irq(ctrl->dev, ctrl->irq, ctrl);
+
 	pm_runtime_put_sync_suspend(ctrl->dev);
 	pm_runtime_force_suspend(ctrl->dev);
 }

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261107-submit-tegra-nand-irq-teardown-v1-60f649303b8c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

