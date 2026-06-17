Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CE3B47E0
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678762; cv=none; b=Qoex34qWYwDufZ+MlX0WsYjqIPFEXHMlGeU7/s5Trd15yfT7WiCyh3KwPQzkcNwfNII+maeboFOEFDN0pfDiXA2SaE+AHwMzPKVR+PgV1TsgtQlJCGTdNQBRTJWcsFH0lIChitDgqC5cxPQU6QxpCHq3xibTHTIzkHgRUvPDnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678762; c=relaxed/simple;
	bh=XzhCB5GzyvJph4pAksg0ijeF4yJPIDyIY2jjs6KRlQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeUY1Pq9ve/wrc8UhbztZ+S1E5mWyyrm2haX0I61ESQiz9BcT+Fi5Q3CyNF7rUNHr/g8Vu5vuc/+fsU+CK266rpTwYCYimo3YXePRWnpe24EQ622KKkgIqd4O1DyEx/00zG2u0e1pSB+B9bxrUGTVUWijnB76q8b1qVWHLXvPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=exW6vLQl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="exW6vLQl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c6bc87f4d5so2135515ad.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 23:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781678758; x=1782283558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjucF5goefZfuxikv7tCuZJMVpoPtgqO36vnpR26lfo=;
        b=exW6vLQlCk4OWLIY7PuS5bPGQs51kES9/dB2xSaro+zZuzpc1J2kUhzdsikASJCDoP
         35P7imjOtRehuZAglxbetAF02mxS1f/jxbYMNy+xn1ssq3rXOUr9W8xdpvIFr52jBdWo
         4OZr7enL9TwcDrszAztymRxhxO/3LIuO9ZWZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781678758; x=1782283558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjucF5goefZfuxikv7tCuZJMVpoPtgqO36vnpR26lfo=;
        b=LWtLPJKp3zPP5JIIXxnPaTsBXlO21yfUCeZsLEQJN0y5in58jPoAxDnTN/LkzsdVZD
         QwkaWRLmUBNZ3G+XM00sKug61Cv9pyQ18s09SglUDksuMDJrnD9Jc7Y1h3WoHr5y2hb2
         bGTc4cIH27AaXTWQc7sjQjdLgvuCDvifpM9996DKwqsuITlWH3zQ/3UwSMNclV0XBy9x
         QYsmd9Td7QKWkm3KRgqPYdiS0Zs0ait+0MY+AkiTCAQTnVONwdwTqMeYO93o8YN27lWH
         s1Z20ToLrP6Y7yWElidjwghwR5Y73UDu/LJ+/h4Fl+voSYuaHXoKCevVawADkpAe5TQT
         J5VQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dW1jt6prIdxDlUw4djBYCTre//eOyfIuViwDNrysDRjAFg2WVKedhUQwBR3aVM3tHQ0nJiG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiwezBq+3hgvK06z/8BEL2wvwPyc8QxvqfcKoMBnY0aPc6SFjU
	gxFggJQA0yQP3HKW0Rxseu4TgK4H83XUDmkZZUdhh+dyD3TMV2qE6MpfmmaRjfClbA==
X-Gm-Gg: AfdE7clEiyYuW3tHj4GkasSRs/bF1tUsxOqFb5pPzsr8uVYYhf34W1wgfUuuydEbatj
	Nskc4PDsepbPnXBDLhLpv+Xk+6p/y2KMs5AFdmXFdgCnEB9Gb920WdT3+L1GQw52KHX4NbWUrrV
	KDyReiWT8n7TDIDa9Bz38MFKUbnR7phZ3Nzp5MSfNYHIHzmASEXTal1S4xcjYP44vsZIVJy3Ew7
	nF+D5I1ZaaRyzN0R5EGD0QEH8xwbrPeLRT54lLEtwRJOQmu4osNgSxp5CN4/iGdWMsKgPCSdwJa
	ZX6pHYJv9VepzOaw4uUtS52WRsf/evUeSNz+FkvX4cVcPHo6D7MKKCZIchLJ4OcZBwk95IKM8vE
	6LlDlgd9GQLCfjFO6W1l7UWKNUm+Wvis4whpuSyEoa344KzQ2ud1lxSfVAeQytKmWKyll/M1wT4
	axxY7yM6YRVVI4/QaPLO6PvyEpm+z7sQWl3PFBFg7iHvBOFJt/Jwi+7HJaDFiT8s5PuXNjfmTH6
	Iyqia2nclaUrw==
X-Received: by 2002:a17:903:1b4d:b0:2c6:9358:3ad5 with SMTP id d9443c01a7336-2c6bc20f6d4mr26872555ad.17.1781678758360;
        Tue, 16 Jun 2026 23:45:58 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:20ef:efdb:f2c9:836f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6af931f19sm24365675ad.74.2026.06.16.23.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:45:57 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mark-yw Chen <mark-yw.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: btmtksdio: call cancel_work_sync() outside of host lock scope
Date: Wed, 17 Jun 2026 15:45:32 +0900
Message-ID: <20260617064543.574704-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260617064543.574704-1-senozhatsky@chromium.org>
References: <20260617064543.574704-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cancel_work_sync() should be called outside of host lock scope
in order to avoid circular locking scenario:

CPU0					CPU1
					close()/reset()
					sdio_claim_host()
txrx_work
  sdio_claim_host() // sleeps
					cancel_work_sync() // sleeps

In addition, when txrx_work() runs concurrently with close()/reset()
it better not to re-enable interrupts by testing for BTMTKSDIO_FUNC_ENABLED
and not BTMTKSDIO_HW_RESET_ACTIVE before C_INT_EN_SET write.  However,
btmtksdio_close() clears the BTMTKSDIO_FUNC_ENABLED too late (after
cancel_work_sync() call).  Move BTMTKSDIO_FUNC_ENABLED bit-clear earlier
so that txrx_work can see concurrent close().

Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to work")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/bluetooth/btmtksdio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index d8c8d2857527..207d04cc2282 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -625,7 +625,9 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	} while (int_status && time_is_after_jiffies(txrx_timeout));
 
 	/* Enable interrupt */
-	if (bdev->func->irq_handler)
+	if (bdev->func->irq_handler &&
+	    test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state) &&
+	    !test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
 		sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
 
 	sdio_release_host(bdev->func);
@@ -741,6 +743,8 @@ static int btmtksdio_close(struct hci_dev *hdev)
 	if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
 		return 0;
 
+	clear_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state);
+
 	sdio_claim_host(bdev->func);
 
 	/* Disable interrupt */
@@ -748,11 +752,12 @@ static int btmtksdio_close(struct hci_dev *hdev)
 
 	sdio_release_irq(bdev->func);
 
+	sdio_release_host(bdev->func);
 	cancel_work_sync(&bdev->txrx_work);
+	sdio_claim_host(bdev->func);
 
 	btmtksdio_fw_pmctrl(bdev);
 
-	clear_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state);
 	sdio_disable_func(bdev->func);
 
 	sdio_release_host(bdev->func);
@@ -1295,7 +1300,10 @@ static void btmtksdio_reset(struct hci_dev *hdev)
 
 	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
 	skb_queue_purge(&bdev->txq);
+
+	sdio_release_host(bdev->func);
 	cancel_work_sync(&bdev->txrx_work);
+	sdio_claim_host(bdev->func);
 
 	gpiod_set_value_cansleep(bdev->reset, 1);
 	msleep(100);
-- 
2.54.0.1136.gdb2ca164c4-goog

