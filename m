Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104111;
	b=jR4W7cpVOeMaHPb+vuaUmAecipltPS7KwIXkN4enwKPAryy5EtdL5TBBtaQE3Bkj29Jv
	 4Nmi+fY1ptK+U00UgtjI/D5fqEu6KW4MLpKotR41rAop+xiZfvPGJVRgF7ihP2lXb2EhT
	 QQDZjtG8cXyMkrZkaNI1f7hegDxKzQzQrWBJXy7Y+yxKYOgDzvmPAEuUIjQrywYJPV5Ig
	 Y9r2CqH7kEVbLbs7+47dvHNYDE5xqE0XNszpr4qQ8mzq+AuUYJtajWakjXJRW9FW5Ofef
	 teVN9TNHDLoLVKOZkvAA5HBxJmPZuK57LuyghDIKbH/fyGVaZKmFPE5Hwa+n0WFHZ1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=aV02K7POjUQdpzVMLX1IIwtAJIBw0/JKJjqJMtm26W8=;
	b=tbcxK82t+It28dKgJH1r1ETI+KCtMc9jAo4VrO1oROPtYVhclveAU4OBiV2YvppyRyk0
	 HgFt3oRlGuZu/kKyFuQeUoRkI8kcbb0rJEHMXWkMuA2PLHDu2qQqGKUmvwEkhOvyNQbjs
	 fZqoimSWecafSkjTn7ECICB1NmHINXXbUZdEB4R9jvILNtDB8tsdkbzY14nNbWEMbDTea
	 qEjAZTCpHrescXHtHOlgs4lY5RhO3BNWJn+tJFKKRZlCpNia7kZsZCZm/BgHuMCPato31
	 +5Pgf78VL61N/I7ESaagGODFK3oV19HycRcA79oUBZpyvwZHhXJ+VMaEKAGvojhvvjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHNxJ5Rz;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D760A2614
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D0D760A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHNxJ5Rz
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b2d14968c9so23058677b3.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795104110; x=1795708910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aV02K7POjUQdpzVMLX1IIwtAJIBw0/JKJjqJMtm26W8=;
        b=SHNxJ5Rz6m9M6ibwX1PpoV0iR6Z2biKXg0buZWVV4/dTD3uyanyG0DuwB5KGIHEmbG
         nHCMAoptTfCxeieIrhdGHiqHyUjaWmEju/BXWuOIioCSDeErhylTlkQGJVvrdNTEr6Ue
         BXWeyOC4Mh76Ya8kugMSQyah+DQvSPLsq9lIY5bCjACpEGSBXDSNpiHyPeeG/FPvrZzJ
         K45vJJjG8hJY8XHCSOWW+znRFChP/Auie0w4j+WIkZilCHNSYb/yy/KfT8ULyy9xQGtz
         ED8ROQCy5QlBY+HXlQvM75N640gbDSwCMbKtCuXBxzgNp5HHTAgJUWj3EDOV3PZj/ng8
         oL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795104110; x=1795708910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aV02K7POjUQdpzVMLX1IIwtAJIBw0/JKJjqJMtm26W8=;
        b=WlEiGr2ZcUbbJ7P4XLJwbKwdZEKQB507vg05lpE4XTOFCI/Km5eOACq1cEyEJUgbET
         dZwGRULEMV8RMCkVkg83Lre205ykWHTsU6YPsfAA2vJ6EbO4gsky3oai9PygZWDuR3x9
         vjH4IcPOfTEJ1W9QNy6QIhzIxVrS4CvjRrl25t6Ytqg+72dQfUee/5uep69SQnj7Gq4D
         Zi/A1WuKRI1TXxnEqjJ0KBVOnsJYQjN5h6db+Mtj3sUYpTLXDk4aGZA4Az2u1wFNhYDI
         L0n29Lq1gD2Q+nfjtFcCTFu6WM2YYc59xETjzhV/YM4uwy5kBOKsIcp9nYXUa8eFPf26
         nP7w==
X-Forwarded-Encrypted: i=1; AL+hErGLay5dMiMaCIxyFnJmGG6w3ha/GAnhq2WLF7ZcmH5g8eYnMWRYtzgj7tL+uUAxXnLogKnNIGQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KwD/vafecqHU7TiC77x3mtPdIA8B+QbN1ZtDK0m5zxa/m73+m
	BrWUNezu3zx9iaV1pCmQWfHiH17GjFVGwfFETFc+BVbE1kbFcq4bIMXm5Y8RzQ==
X-Gm-Gg: AZFdTZfNER6+TQxallX0Y6NQuX0IrYb8Mr0FBGOp2I7sWtHnJJoUxkBfJ8nrjlPGkQm
	Y5MUzyyPzQnCScLx4K9HRw+u1vP+wsJkvTV95mEogf+cF0EJv4MMirvDYAiXOPNfxq997S9cI8o
	6yN6vGB6EKy14AEkqZVJjtA729nQkBUyHwAnlGWaL+q4igMFSI/0irAoXHbvPIr/miJ/psjCJFY
	5YxlHUclb7F0urmSvYq/PUCK9iPGv7+mpIZq19FA4WdyjoTRnQimo/z6qPDUXPb8MjPSnzhaElP
	GxX0uxZ2GW43I9cTl10h3jemXP18xszB1RTL/ujlk4FqGmR1bi0yj8U+3MG9pTb9LSSX/mhjAL+
	xaVf8M2fQBn/BgzMU8+lsMX0MpMFWr0ZNChB6Adr2IOZHm+TAjuhbsTMQZC2oxVluDZUpg7i+Po
	nUM99eeCpQsQ8tHpN1sNmKgbsi0MRsGpGLsHEZ0ofenke9R6kv3ED0An/YxY4kPTKIUsUrV0Zou
	6moYMDOUP4i2iEohYl195AsoP3pnUn7oGIZaiYYJTiQTV7Byfm41wYF0dvZjWCZTcWRP9w/PiKk
	XsfW0dCXgXdWQIsqrVj/mtDJo/vnhZIqowup7yx15Cnh+6QNwEVYx1+wIrUtt85xlEa/XKg+GY1
	OdO0WsFP7P44xFfVwYqVqMC/wUSRul+UTu8qMajGr5KPHFAMDBtGCgIMzk4QVKpcZD3PoTN6ha7
	ZWhmBe02kSlhFs3yj0N23kHWVz6pjY0DMcWKGJzVOjEMvdw5V02S47dJ23OprZZbv1tSLRgvWw
X-Received: by 2002:a05:690c:63c8:b0:8b4:cb03:c8ed with SMTP id 00721157ae682-8b5204d5e7bmr651417b3.46.1795104110368;
        Thu, 19 Nov 2026 08:01:50 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52031aa4bsm623267b3.34.2026.11.19.08.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:01:49 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 09:00:58 -0700
Subject: [PATCH v8 3/9] dmaengine: dw-axi-dmac: retain descriptors when
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
Message-Id: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-3-f8e7fe60594c@gmail.com>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

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
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 37 ++++++++++++++------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index f17a71183050..def591fc75ce 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dmaengine.h>
@@ -1180,30 +1181,32 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
-	unsigned long flags;
-	bool enabled;
 	int ret;
 	LIST_HEAD(head);
 
-	axi_chan_disable(chan);
-
-	ret = read_poll_timeout_atomic(axi_chan_is_hw_enable, enabled, !enabled,
-				       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
-				       false, chan);
-	if (ret)
-		dev_warn(dmaengine_chan_dev(dchan),
-			 "%s failed to stop\n", axi_chan_name(chan));
+	scoped_guard(spinlock_irqsave, &chan->vc.lock) {
+		bool enabled;
 
-	if (chan->direction != DMA_MEM_TO_MEM)
-		dw_axi_dma_set_hw_channel(chan, false);
-	if (chan->direction == DMA_MEM_TO_DEV)
-		dw_axi_dma_set_byte_halfword(chan, false);
+		axi_chan_disable(chan);
+		ret = read_poll_timeout_atomic(axi_chan_is_hw_enable, enabled, !enabled,
+					       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
+					       false, chan);
+		if (ret)
+			break;
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
+		if (chan->direction != DMA_MEM_TO_MEM)
+			dw_axi_dma_set_hw_channel(chan, false);
+		if (chan->direction == DMA_MEM_TO_DEV)
+			dw_axi_dma_set_byte_halfword(chan, false);
 
-	vchan_get_all_descriptors(&chan->vc, &head);
+		vchan_get_all_descriptors(&chan->vc, &head);
+	}
 
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	if (ret) {
+		dev_warn(dmaengine_chan_dev(dchan),
+			 "%s failed to stop\n", axi_chan_name(chan));
+		return ret;
+	}
 
 	vchan_dma_desc_free_list(&chan->vc, &head);
 

-- 
2.53.0

