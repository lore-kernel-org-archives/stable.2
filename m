Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808883;
	b=omWRHvfx8rSfOIq8gUBDaycLEwbiH2b6oRlk4/+EYXhkLdl524tsdoltpzakgCCuYi2N
	 hJGIJsIaDeqPhsV54qBbZ8EEyw0kePSO47aIn2PBqippCeqZQz6tOPE//XhAGAvSQejW0
	 KY5+awGt5XjCcrrg3Wj6PFGJ8f9Z+c7IKrX9GzmqL22aGjJxZwD25LleVr029HuBiA7JD
	 H521u8BxTkYwg9htL1iEA4AAWf8C6JZYXNm0qLxdGfEuzuGkyl8iwZhYRyJedqVPXPeJx
	 26TUOlWqRK0Vq2v/VOC3tE05L2IHz5VWiLnRAC2G3apTpdysa4k1BJ4H0Y6FDr2+7MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
	b=n4QdmsqLR6ljysZ4+5XC+LuMSNQ83hqybLFmgk3cXU9F2IR0JecQ5GH4Da9sKqFTgZ1T
	 eRcXDLFjYHOLFcZvpdCNzWWCK5URGYuxWZ77OoR9ULE34tLdsxJY2s9Mm2IKD5mRi0SwY
	 oWrMKd0+s59kqEXOjT2iFqwj0KRoVxogqPYNN166Ds/cjp2jvX3HCDRB3hnBCq+NJ4tTf
	 Y7rmspuG5wug9V4QE1EUwknzAU4zVBg3qGvYUWZVGDdNDjcBoFOXTlu43CeH7TD7S4ObI
	 1mQixnAkriLd3/MAaNVe1qV8vohsQqzynqXs7Y4SoW0JNJj+VvXZcD5ZUe1IaKpEKXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pgsBwVID;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C1606A8B4
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C5C1606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pgsBwVID
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f84a55e31aso2507110a34.2
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 22:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808882; x=1795413682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
        b=pgsBwVIDHici6eujMavjEja2MEUfJMeh/TBaeGD9M+4EvBTY3zyWjpf9JRTOMyYWJf
         22OqVv4nnp99NV+q6v6NXjBtw+AthV2blL614liTUoajd/31BdCiAwL+iZtTzuYh7MU4
         IXvSMZZ5GtR/ZCl6PhLM/RLn+E/4pNAZ0b0TdL6jj+dWqI3xGtxwNUwa1fisaQSsr+aq
         g9TSvrtc4YLWFtl/4Nau4ijj6ueKNZU5IptpiL/vMkH1ydKLWwIbGY8Ix/OTWUOJGoEw
         YPY6vi4dZ26NUXjmTCYCOda0Svqqz4DquG+FTX4UeBUa2veNrjqyOMZlTuxO3aDqVYrm
         fSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808882; x=1795413682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
        b=c2IF9X1EPz59lddvyHpDwxmm+BKlh6BtmrcbuoI5lXH7vrCM2TWlNwNQIdOhMS/lot
         IttFv5RNPjc19pKDwx4hsFJEfIlHfS1Tu5qQPAOQqi66s34opUtfv9fsOm+ruI4uz/jO
         mX10sXmAVp6Wxz9gz6q5uvhrGnytJjpPZ5rNwb1CEzwleU1GVvyJ6VRgyz0XFcDe6DDN
         CvC+pBqr/VKwee+3TBYSww/a2Yhc5Ktsoa4PUmO7AjuiXrqNdJJA0uVqslQs0CiH/qFq
         5KSCuAnLU8YqNgVo9L1Dn+3Qy/05Iv3M7zHLD4PbBZ1zrMUlQcf1S+gED6E7qoSBYt+l
         xXBQ==
X-Forwarded-Encrypted: i=1; AL+hErHI2lDTimaUtbY1x1oflumxq+AQgyBNZ+7pbMxIwzvkHGllUdfjQrrZXiQ/rIhRblANv8LP1dU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4Um4KLgES55pSUAb16XiQSXdxeadJ+TkKk0HjL9fYH4MDzvZ+
	y67PR0rNIkvklWBVz9tESqpOqgPfpZ2ievG8m40RMbx6tSX7iw+bFLh0
X-Gm-Gg: AYBFou1UNUnGg6OyMDH3hkz4f6P09045N5Fjx97jrhBO9D0B3VU9mb8yWeN0ZdG9A6t
	6MdpkhUPiUdUl7Y4eEiRf8saRGzSFhBtn+Ggf1iobN6nnekOJtpf/OXfRBM9LnBlGfaxvD6SdP+
	L2X8mgM+A4xEpJHmokmL0eFzLt+XjUrUFO9RdH7HPaEmenZv+X+yQMBvPz8jShW3Tz7H+Vra6q9
	02e8s1cweViI9KJXcbyh/1UWe8rxTVTU6ACx89Nslo6CE4Ar+3Gv/YrWP3i3Km5nwUXfTKj1NGf
	HrmoyMPdIkPbQF7BSGnKwK9kbMFC9GtJwlRUt8cQP8lMcqE69XTu+76NrTe/kRXISlQBLoleEuI
	XggSvH80E5RRP3taVEkUWhNI29tWlKYHxhkuPQzy2t6APahTNQP28YHaT9q65f4OLpdBUcpcsm8
	NOrDNx6bCKcBvCkCFfdkGT3ltw2+AKYGXmhs09kUBVetAoxk7YrHhezrt/FbXS0RtiyxmH2ONCT
	WhS41rEZUDT/4hLzwXvtiOXMph1APy3dOoWOhlGhq1wrNLBtqAY6p9KMip7x3UZX1QnrgVb73xb
	CdVODZEBAcOgrkDgIPzFNGBDV5alQ/DTp1sMPHeXePJgoOF9Ow+63A/xhyBr9rZgFsSou1eeshW
	9b5XK81V6h0SzbOK2c7t7oXSfaGkF4h9jfXN7cNRBt+M/ZOdF87YrXj2R9YqeHwmhntHdHj82It
	ATdBnBNiI4NiG5wq24iqdaYLIUfRVLl1igdqS4iXP1u5zet6bCvktWT4cWKOoWetL0yHW13+sK
X-Received: by 2002:a05:6830:2704:b0:85f:49ec:c96b with SMTP id 46e09a7af769-862898682e9mr8769881a34.16.1794808882430;
        Sun, 15 Nov 2026 22:01:22 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm9375160a34.25.2026.11.15.22.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 22:01:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 23:00:45 -0700
Subject: [PATCH v6 4/7] dmaengine: dw-axi-dmac: use atomic polling for
 suspend acknowledgment
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
Message-Id: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-4-bcb23d1e7029@gmail.com>
References: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
In-Reply-To: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

The pause loop delays after its final status read, so an acknowledgment
that arrives during that delay is cleared without being observed and
the caller receives -EAGAIN.

Use readx_poll_timeout_atomic() to check the status after the final delay.
Keep the two-microsecond polling interval, 40-microsecond timeout and
-EAGAIN return value when suspension is not acknowledged.

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 040c12d07db2..1a53fbc951a9 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1219,7 +1219,8 @@ static int dma_chan_pause(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	unsigned long flags;
-	unsigned int timeout = 20; /* timeout iterations */
+	u32 status;
+	int ret;
 	u64 val;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
@@ -1250,12 +1251,9 @@ static int dma_chan_pause(struct dma_chan *dchan)
 		}
 	}
 
-	do  {
-		if (axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED)
-			break;
-
-		udelay(2);
-	} while (--timeout);
+	ret = readx_poll_timeout_atomic(axi_chan_irq_read, chan,
+					status, status & DWAXIDMAC_IRQ_SUSPENDED,
+					2, 40);
 
 	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
 
@@ -1263,7 +1261,7 @@ static int dma_chan_pause(struct dma_chan *dchan)
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-	return timeout ? 0 : -EAGAIN;
+	return ret ? -EAGAIN : 0;
 }
 
 /* Called in chan locked context */

-- 
2.53.0

