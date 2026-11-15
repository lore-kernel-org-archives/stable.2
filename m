Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727185;
	b=gQNvPWO8XRf0lG6TnRnLkB76yWnolt1PbtSHZ3YwX3GGf02TtmvNsszgTMaBVKAL9WD/
	 0hMxUAvORmVo6jAFA1/TcBpirZeBpaqvMWK2ojISvKNdf1oJy67o+epyRSh0gp+h6WKmk
	 niUzhoVjkWvwacFaqEznaTqEM1se5FH70I6OAFakNCmRP2S1FT/MvsE2CUUPeEhIs4YZ2
	 zFExQ6rIM2RMb+T5JdKWeT9ENYs16CQPyenEYlRXcvxRhjSBLWtjgx+RQcaFyuuw0RWE/
	 XLAro2hMOPOioRC3g8Z59MLFNh7XILl0xCahvXqoHBwBewqqs3GtbnSreC1afijJAvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
	b=o94pqjt8CEh/tJfmL7o3FzT7EsMsJh6NxbsQ41qmCHKgDV0jRgMYUw/+Tu5uYk7i83Is
	 ELU912AgM8/D34ULo13iS7GUTItgRBUOMjtsilCO+ceCJNUX9XDxkAsCnnjJq66p9UCda
	 ZDp0bfuH1auSAqWLeew9T5itjRKmUbkbeyOUAJRv5WuLhqlTcqxAyLLdddLqEGE7Tu/uD
	 8++VeGpcwYy2lA+rHtTBDQB5G5ZUXIAu783tsVc0xSKlu2m60RzrQQ0JbwxK4QUrZCzbB
	 PPehmrciHPlN8QGmEH0ewxNlLqyyhulYWg/lKC6fLFk5FRxKVin3V8GP/lewIFMETsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uRn0TwYq;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF6606A8A4
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34FF6606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uRn0TwYq
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6b19e291cc6so3312478eaf.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 23:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727184; x=1795331984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
        b=uRn0TwYq0Gb0fpk0mP20sjt6CpvvbvkADkw2qkfVXtpiHQq5PfBNkutEUH/QORBwQv
         jQtNTqnBOVun7M9D7Vg1Qzi5tpDrcc0yJitXLcPEc+Up5gsjCi4lawckRX38IMrSizWP
         lIvAJIhm0Bt6cNrihvtfmGgHekZrcmtJQe0+nckg+TndixACw2fx4AhpTCkm6icg1NQz
         llq2x1pPJ0WrenKDlsUZU1WZd22uih6+rEbbMqHmQwzxy7VEDDNELyKloigV4SbdeUfj
         gBLAm75aTAkbaYElZa6UsGft5bvJtBtqm/6R3F4I5UfPsAJrIttmXmwFGSAC0KrvzaBk
         l3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727184; x=1795331984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
        b=isa5J/85S3sI3ajd2dPjZmVJPDMCDKCvz2ngVfWLK7tok6mrDHUTTAkdn17DZIOZjF
         d4v8euFTG59LDNhcafJ05dmH1msbBRf4Z1x4JbWHNsbG2JGXGbq0enCimczzehstijsx
         sySQktiI9S6E6VlBDaBovW6lxESIWuLw2FaWY8u+waRK+Ot++Bc//7EzwVu94kX9Uypy
         EQjffXB3sFbgw/fZOR5vy/x5LuiNzxbTio4SI437J/LvmNO2zOJmsW5F87MRIM2wT8rB
         WTqF7ec5Tl8fhwtKUENVTIYzhLX2I55P4rfaNSYga1dYhzRIJ97LCFt8bRFbEhdGx87O
         bNbg==
X-Forwarded-Encrypted: i=1; AL+hErF5zBjKpIyrF9iKJqgTR9MOn0Lrp5JKZr+LJyAQGHcIr4Hh+jsH18Lp3S7JqyuUs3cJv6Hk1IU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pVzzoNmHYpuDq68pXpNaP8yePQK8PrwkMpAS6phQO067Ulr3z
	WBBgO71CtB+Kb19lEKS4cMfwpSpRxAllnRase/5vYkPb5dKSING2QBKK
X-Gm-Gg: AYBFou0Z2MhXv263hGhmgJGbMMcdMvHuV87RMnB4wKvoNRQmGsX6ctvX6PjZiHMLn5S
	GgcjZhgLqpzg9+7+uCnYiuyGzhYtiXMq1oPvAmYKOmzyELR0KVw74ajz4Iy4D7nWNqUOoIt6vJz
	LXnV/02yzhHf9JF15XFJFGaRNfcyufPJapKttiNQZTIxQPNdEfIgsb9OKDwxGYdu9zxGqH154IF
	VIySHaIS91Id0h32aJTeF67k5gqLzSnqnsqznmTQXNrSfum/kySNUmvQi7/yNhxMEWlk5Jq9Brv
	XU1fiRVbJYb7c3KG6/qDB2Y9lJzysgtP1lE8K8kndaqwK6WWuMn3/B0L/V9xf+/48gXUruXDA5t
	hk22qW6yLEvobwhh/sWNJw6w3cn5961ive8nU2sJ9gQGnOrEnoCuuzxWClIuPIYkNkL2yNJax3k
	kwv3VAPMf58joBx6eAp19EvBb4fsjXTuQoV31Ee9fspKEc4Hf0WniBZAP8Yh9hkSWWaAhheP9SG
	Ty2KYlrlMWVygPYy/LwYvAwwouklRVsDbXn7VMrEFHAHRVyCIDkPW+8q0/pHl8jJWv8tU7BkvLK
	fVuosy+F85KWmw2PChLavRVIIAUFWst4KVq7Od/yeqaH4ic11UD6wf9kh1IeXWRG22jTONGtT9E
	43ByXVh4fPHyenF41AFwgp5SqrWNoys4D0Tx9ptF4RNjwDC2GD7i5HbnRW82tmzoaL+1I44jc+T
	zE00+/GnLM++uMRJ/GRJUAkpCSownO4Dtx39VSnhslgCjxFxhJHfs=
X-Received: by 2002:a05:6820:c44e:10b0:716:cfac:bc29 with SMTP id 006d021491bc7-71ab5221abfmr3034088eaf.85.1794727184038;
        Sat, 14 Nov 2026 23:19:44 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:43 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:36 -0700
Subject: [PATCH v7 03/10] dmaengine: dw: complete cookies before releasing
 the channel lock
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-3-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

Completion detaches a descriptor from the active list under the channel
lock, but updates its cookie later when freeing it. Termination can take
the lock in between and complete newer descriptors. Completing the older
cookie afterwards moves completed_cookie backwards and makes an already
terminated transfer appear outstanding again.

Complete cookies while detaching descriptors in the completion, error
recovery and termination paths. Keep the active-before-queued ordering
when terminating so completed_cookie advances in submission order.
Descriptor freeing and client notification no longer update cookies.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index f7ca9da5af90..2d69fab06601 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -231,18 +231,17 @@ static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
 /*----------------------------------------------------------------------*/
 
 static void
-dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
-		bool callback_required)
+dwc_descriptor_free(struct dw_dma_chan *dwc, struct dw_desc *desc,
+		    bool callback_required)
 {
 	struct dma_async_tx_descriptor	*txd = &desc->txd;
 	struct dw_desc			*child;
 	unsigned long			flags;
 	struct dmaengine_desc_callback	cb;
 
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
+	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "freeing descriptor %p\n", desc);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dma_cookie_complete(txd);
 	if (callback_required)
 		dmaengine_desc_get_callback(txd, &cb);
 	else
@@ -329,12 +328,14 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 		/* Detach the completed transfer before starting queued work. */
 		list_splice_init(&dwc->active_list, &list);
+		list_for_each_entry(desc, &list, desc_node)
+			dma_cookie_complete(&desc->txd);
 		dwc_dostart_first_queued(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 
 		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
 			list_del_init(&desc->desc_node);
-			dwc_descriptor_complete(dwc, desc, true);
+			dwc_descriptor_free(dwc, desc, true);
 		}
 		return;
 	}
@@ -436,10 +437,11 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
 		dwc_dump_lli(dwc, child);
 
+	/* Pretend the descriptor completed successfully */
+	dma_cookie_complete(&bad_desc->txd);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	/* Pretend the descriptor completed successfully */
-	dwc_descriptor_complete(dwc, bad_desc, true);
+	dwc_descriptor_free(dwc, bad_desc, true);
 	return;
 
 unlock:
@@ -940,12 +942,16 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	/* active_list entries will end up before queued entries */
 	list_splice_init(&dwc->queue, &list);
 	list_splice_init(&dwc->active_list, &list);
+	list_for_each_entry(desc, &list, desc_node)
+		dma_cookie_complete(&desc->txd);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	/* Flush all pending and queued descriptors */
-	list_for_each_entry_safe(desc, _desc, &list, desc_node)
-		dwc_descriptor_complete(dwc, desc, false);
+	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
+		list_del_init(&desc->desc_node);
+		dwc_descriptor_free(dwc, desc, false);
+	}
 
 	return 0;
 }

-- 
2.53.0

