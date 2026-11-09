Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200563;
	b=F2aW6pJUGh3lHvEo4Cnr96wmYNnviVGRZeYQHkyo/l7Zi97wE3tWZe9X/GGLCSz6cpYN
	 Dx8V8LWcj3+EbsJrTxF1yGnbVpJ17nGldALxQSUaPgQcKpHxdVNDxXZxuCa+XnhSglXpU
	 T++tRNODxzduChuM5HOMCjHy5Le2HhLGX5Hyn59/E5o+mkrhLuGNgMs0iI78GhgC15V93
	 Ye7OK0Ep57wB4mHnBBpciCtqjOPV6V1wT8VB+79Mn1d//mYgospai1XLHV8ga47f8DiXh
	 9KA6ad5o6NWkyb5n0YkkWCs0PHQyai76WTajUdTHg7K4xCb31WMO5uYE1wzAxI1folg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=YeFAvqaFBjTDbwHpdVBu+3G5WzX84h/1VRkYo0vld38=;
	b=wkeHKbhUN+NraC9JddB4V9lctvlHH6NK9tJoY+bWMi3nNl9fyUPMS7wYJ3C0vsK6mHZJ
	 Mx039trx6ZymTpe8s5Md6yfgPQnozrBhRJNyVn3q8SupRw49/LAWouiTQVM/nBUBtUzxo
	 nCC1roV6QHcBdfw7SocFbFxrUFco2qlH3VVZ0QTJjQOjiXAHqz6iaGbidd3q1wtnTN2fX
	 GeS8Fn4moE2GJta3OvvbXjXm+PYySnhiucOQSntZKpLh59gf8Gbr7MA+76UQOA+IdqWxK
	 +VOfUD3oIvCRasP5X6zAsae+qJ7MKfZUkEOFgEJ82qjjXNozENCEGkTm5+2uMqigY4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNu9PZcY;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74A606D803
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 05:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF74A606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNu9PZcY
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b190cdc9feso254742b6e.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 21:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794200562; x=1794805362; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YeFAvqaFBjTDbwHpdVBu+3G5WzX84h/1VRkYo0vld38=;
        b=WNu9PZcY7TxOXyoWPWzBuRH9pbkVd+P/ZOLuHkQI15l10MtCNqSJuQsITVb21JP30q
         dGXavCQ/ecYJIncDXhoVZ1yv1S7pPEdBKbwDVcl7+UbYve8jTxz6XTHQb3koywSZ5OHF
         xmeiO6o1VM9Baqh3BS0bLTm463i0lro22JEeFh7lol9tewxyIimf/24HToDd6p5KuXa3
         LRRjjV+uYEQOe7dAXIBwqS5k5IrRh3ppk7h/W6gZh9lr0zSXMd/yibyOBSUJ0oCPSHqD
         V2E4VLdsL7+P6pirEGsIWjvcmvxqEZY48v8gD8LAFlpHax4FFQ1IHm5efcbL+uiatUEC
         Aqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794200562; x=1794805362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YeFAvqaFBjTDbwHpdVBu+3G5WzX84h/1VRkYo0vld38=;
        b=1t4URzM1PZG+/0LJl/iMLO6zCbt1EjreHnZPc1KwnUY86BkJPYxdwf4XbygGmbDoQx
         tDv6bWFnLOtM4WxOwiryz57+Qug84Ht1MlK1IwK8YSt7Ueyg63kjvIHRy2XB+0wzbwzw
         vHmmlX7DQ9EOfg5/Y6ftSr2suLVK7AE74J+xE6taQP3BT4DMWY/KZP90w9HxawDP3NqG
         VLX/hTd2jz35E9JNfrA4pJnBM2zq0GpqNH/QNAyQU3npOZuS7iXk+ynOqM5JOTKezhMx
         SVhuHr2jEECjhFNIRuwKvW8yAfuGMwyr3K6Hq9lkYFzkXisjnyUwrXqOkXflpWOtMpE5
         AnEQ==
X-Forwarded-Encrypted: i=1; AL+hErGWjK2G+2+YlU+VqFLN+0+46pNnL+poNdw2zaYj//DcGdJL2pgqPnePF6VToDFlOEWX1k/log0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9okQ6rP/Pvb2hbmUHY73rAzLx93uoSRheuMz3CssQWFvWDZbDR
	oIK7MqnLxHSO8MLCJEKSFzm9NCgiMY7hU6s7i1ubZxHIZPbO3C+E4nT/
X-Gm-Gg: AYBFou2HpQZBVx1tg5WQHJJUMWDrzZ74I6kHsxyJvAbQ/8or19/lZqVj2kmFCIwSso3
	xweZihILRtKr3OOpnY8lA5DriAwGdVZqA7Vi7NsfWuEFmYImqQ4QAtjeU4sxzS5O8FWGp03g4NA
	DNY0OoeLYtzPE3SRckkfRIeQx4kCdw1NMfhQItmMGswi8mdbb+Z6e4Z+hBAhuYTWUQkq4TnedjZ
	usfrmuv9ap2RslEoFHffjEoJgQg1pkctYAm9QGO9HABJN9cN9JNAzO6Hqvk5y5CNb1ogAN9GXwR
	ZdJeZSpElF68H/j8z/HRpAWJUj8e6u+P6HCfApUllwOcajeirpGP/JHjoop49Yh1uQJ8pBBTKo7
	wefR1jfytsrnOCUwENKv51sS33M7vPieT/XzfI/0OGfehsouJuaE2Wr5PH+0U4SiWXybHx0eza+
	kAB4Q/nqSDYH6Qmi+TKsYaxfhYZL5JjCaBUpMm2aIof+z70A5ietO+JkrJOxVOkw0z9siUakzjQ
	oGVh9DVYUnsSddY4n6lU4Kj+rSM7NHbXP6NDKsk2xNvQYWuX0it9zLGS//TAY26jOJ3OL4KYhAd
	spbFmzYUdAFq1uHmQ9Z8cKOQEY3R9RivYPaIcqoP8Kdnkv/5oaj1spOSnBgwQPftSxSq8uNqsmw
	Fx5yvNyYv8WQK9OHYuVZo7XxLJq+zKK16U6R8Qc3No0oKFDj4mtpAakMvPLdeIiYgaQPQEvVNat
	sIK6xACtj/DxTXz4fqpnUUyW7UJAeKBm7nE8mGUaHkvSWkWGbRkWlyH3uCfy3gABUVLuJvQ0O0r
	A==
X-Received: by 2002:a05:6808:13cc:b0:567:aa7b:4836 with SMTP id 5614622812f47-568144b6c0emr1886261b6e.26.1794200561873;
        Sun, 08 Nov 2026 21:02:41 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813ac6352sm3570841b6e.1.2026.11.08.21.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:02:41 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 22:02:37 -0700
Subject: [PATCH 2/3] dmaengine: dw-axi-dmac: retain descriptors when
 termination times out
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
Message-Id: <20261108-submit-dw-axi-dma-stop-pause-v1-v1-2-c48ec19e9ee4@gmail.com>
References: <20261108-submit-dw-axi-dma-stop-pause-v1-v1-0-c48ec19e9ee4@gmail.com>
In-Reply-To: <20261108-submit-dw-axi-dma-stop-pause-v1-v1-0-c48ec19e9ee4@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

dma_chan_terminate_all() warns when the channel enable bit does not clear,
but then frees the descriptors and returns success. Its synchronize
callback only drains virtual-channel callbacks, so terminate_sync() can
also report success while hardware still accesses the transfer.

Return the polling error before detaching descriptors or changing the
peripheral routing. This keeps the transfer resources available while
the channel remains enabled and lets the caller retry termination without
treating the timeout as a successful stop.

Hold the channel lock across disabling, polling and descriptor detachment
so an interrupt handler cannot restart the channel between the stop check
and cleanup.

Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 49f65486e862..de092f190528 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1186,21 +1186,24 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	int ret;
 	LIST_HEAD(head);
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
 	axi_chan_disable(chan);
 
 	ret = read_poll_timeout_atomic(axi_chan_is_hw_enable, enabled, !enabled,
 				      1000, 50000, false, chan);
-	if (ret == -ETIMEDOUT)
+	if (ret) {
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
 		dev_warn(dmaengine_chan_dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));
+		return ret;
+	}
 
 	if (chan->direction != DMA_MEM_TO_MEM)
 		dw_axi_dma_set_hw_channel(chan, false);
 	if (chan->direction == DMA_MEM_TO_DEV)
 		dw_axi_dma_set_byte_halfword(chan, false);
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
-
 	vchan_get_all_descriptors(&chan->vc, &head);
 
 	chan->cyclic = false;

-- 
2.53.0

