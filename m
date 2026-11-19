Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104109;
	b=q5tNVjNif4FcMgugGvbvJsBhVxuqzhfMEzseiZbwC5qa7/tbQ8WpfOhbwvziBx7S5DKX
	 ZmZjyNMwag96qIcci2a9OkjchpO1J7HqPF2VY+/dQU488NzBi5NZAkAfFXQVnNCldLJhl
	 ZUpcegU15FhG3NTSaZw17a1yDEcgoUjOYuLVDS/ztbJLFCRT3ch8tZ5LYutjGL9Auqz3Q
	 7I97WgDlfqY/KiKUu7ctMX4FzCytxp74j5TKHEuDnIp7wbBraQgI917CHlxgap4uc01uq
	 2oU83GZ+RK5SsMIp1Mpftt6PjjiKjfsNQcaoCAVC6K1iDICNogBibj8vh6BpWUd7pwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=YjkX+SIhmCFu9w6Er5NTY8ZxVe8WqPbD/o8Zqp+diPw=;
	b=zfAlX6SkmnRzmPt5e/FCIwW2D6KHBi3UdRH6kzXZ4+TxRCtP2bCS+KsJB88wi0EMko5S
	 WhpW6KNYPpFgzDX7NaZiHylcs7v+M6UxN4V3EBmv3HY4DNB01SUJUHOxVMZ70XM1m2UEg
	 l4LPQIclnw6T5CpjgN7LHyGi6XNNt9xvgmLCQkrZM4yocX0ofBuFzO/u8I5FU87xfPNGY
	 V514FDDTavqmnOy2hojmphSZaGSZZfvFMB8aXKHAtvtwO2PE0lLVm6W+12A7mVci2sgbi
	 8MIsVC9b9dwyvWDDqZbAVOTQTRUcx7hBWivQd1cqJmKuCaL9IxUaSTglX4KrSEYQ3oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gsF6tYcY;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74BC606A330
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D74BC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gsF6tYcY
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b335eeb340so21734647b3.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795104108; x=1795708908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YjkX+SIhmCFu9w6Er5NTY8ZxVe8WqPbD/o8Zqp+diPw=;
        b=gsF6tYcYJ8FC3cel931aNMGVn5nCBhw8tRjL8x+3fFjZEU2LMzexo+lcuHehFyBpfk
         suq7g2olxPfa0mZWy5fNnqXsQzLqdOwK6HtIaDW8tjK6jUbszUBul8YFd5T/gtVurhd/
         9GyaWFHTFsU4RE4Q0YUa9ll2eyoh3NHel7ynrhJZ6VOLWDATgM0l6YZK48ZLvZ+EURvH
         rIk5UvJwM75ceh8djNUXar/9weE7ol6em6D+tdeH0HD4wuSysrjL3L5NILFhYDc5DmD/
         nf1ZE7cjZSos43rc58Q8Zk8UZI3cv6FoRmdY3Fva29SR/tC0VDNgfzq14EMEMYnWzEa8
         HrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795104108; x=1795708908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YjkX+SIhmCFu9w6Er5NTY8ZxVe8WqPbD/o8Zqp+diPw=;
        b=0HMhFQmWFdrSpMHKDwlG1ppihZ8xptjZziXCiOAellRHd8bgy1QKJDNTFb9QhnvMgz
         6gYlRv93vCWvNGrqppiUolvWRHyhgmYDRCkSMCJ6S//PiEWsLPUa47FAoI+SDofY4dFs
         BXXq9ZmxSDqS28ElVBUpMzaPrQNKwmSqmI7cNqkVHpMmYAy6ZveIRF/1hsrA1h4rWDrI
         lFTVGf1F6AN2Va4S5+pqKtincEwspJy+77x+wkCpsU74H/9/RRGZz5Osvq1C9aYHLhrA
         8MOGn0y+6MliekczMx9o7fD3e7pjYhk+pOmD7gYGCfiK2dd4Bm39fTv1EExM6Zn9/rAA
         ASrw==
X-Forwarded-Encrypted: i=1; AL+hErGQ1JPoEuT/nMLmo3EvwDCKZ5PAWGu+2Lk9Vi+FNY8YB7S4kLgbwrRZ7zENkSAaLboW5MLxIg8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DJx0g0XAXm8Q0h1YkH8kuYUkzMm8fDsPm1PEKodC8ZrQrM3wn
	SknTJYFl/ekVP6ZnhxNTVZ7GkI1I9QzrGppNROnJO+oqmIJ8UxLt9rpd
X-Gm-Gg: AZFdTZcBYGbntCtuNN38cxIHvqM2xHgR+vZTRkAuydcZ0GZAWCFT62OduDc/gm60HM2
	6muFiqPYhwTBS7rzc91VKQ0OO0SlD0EYunFKAVbBsm8AG8WmWzoqIXrp+UPl7cNZm1mJdrNBq5V
	ijH2TLqCYjxX0rcIv2yO87Dy4/MXo5GXLPBFK/D3BvFHfPN3pBJnBjXaHo9k9L7QYR04Fz5Hc3P
	gPKU9Kh+QjGmWqjW/1QLt4KvGkIKYJNVdcMjGk4quVYDjJUihd2GfWJxMUKarNaBwWU7fou84Ai
	8b/oZfgb/rTG56rn/TOZJTaJHVBehIo5vcCO0c3cY1KOi7mFDqJhfle34gXbuG6w0k5644oIy2H
	Sg0zv5RxLBz9LWx6n4EuOKhoZ11wa6S2IZp1IvAj/O/VdeNK66KbGMpdwRxFVDAsX2pksh/LCr1
	hz8I0l1f+SlHsBBAxNX8PEmeGLJIh2ctEZs2/bj+aD9ld8mieVzIW8u7iTb33IQC9Cx5BSY/39Z
	shNcCSBQUpEobu6cnqikusM73eREd8uuROoeBwUnZo0BXGD0xstnFfaA0jy21LSiMVe2lCggNRS
	lWeRMz81taDrBLdClrurKWAih5QXqzV6aITsdZMU5vwqw/4ANWrxPsWI73dM9As3+j/r1nh0Xin
	TDQBBNr748zuJtH7pbZT/qRaT8h0708Z51RSk0aksu43VuOATHK4H4zHwQuSzLPh2wt6PJ4/ANu
	Zm6e5AC8ZEhbwKuXXawgkU/PrCXUcs/t8SZj3AjnkEUi8e3lIfZpo=
X-Received: by 2002:a05:690c:4448:b0:8b3:5969:f25c with SMTP id 00721157ae682-8b520435b4cmr656757b3.31.1795104107663;
        Thu, 19 Nov 2026 08:01:47 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52031aa4bsm623267b3.34.2026.11.19.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:01:47 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 09:00:56 -0700
Subject: [PATCH v8 1/9] dmaengine: dw-axi-dmac: keep cyclic mode in the
 descriptor
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
Message-Id: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-1-f8e7fe60594c@gmail.com>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.17-dev

dw_axi_dma_chan_prep_cyclic() sets chan->cyclic before allocating all the
hardware descriptors and leaves it set when preparation fails. The flag
also survives cyclic transfer errors and channel resource release. A
subsequent noncyclic transfer then takes the cyclic completion path,
leaving its cookie incomplete and its descriptor on the issued list.
Its zero period_len can also cause a division by zero.

Resetting the flag on failure or channel allocation is not sufficient:
preparing cyclic work while an ordinary transfer is active changes how
that transfer's completion interrupt is handled.

Store the mode in each descriptor and use the completed descriptor's
mode in the interrupt handler. Cyclic preparation sets only its own
descriptor's flag, while the zero-initialized noncyclic descriptors keep
it clear. Error recovery and channel reuse then use the next descriptor's
mode without relying on channel-wide cleanup.

Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Closes: https://lore.kernel.org/r/sashiko-outbox-208213@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 35 ++++++++++++--------------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  2 +-
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 7520c78f55cc..6dae63024721 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -801,7 +801,7 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 
 	chan->direction = direction;
 	desc->chan = chan;
-	chan->cyclic = true;
+	desc->cyclic = true;
 	desc->length = 0;
 	desc->period_len = period_len;
 
@@ -1117,25 +1117,23 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 		goto out;
 	}
 
-	if (chan->cyclic) {
-		desc = vd_to_axi_desc(vd);
-		if (desc) {
-			llp = lo_hi_readq(chan->chan_regs + CH_LLP);
-			for (i = 0; i < count; i++) {
-				hw_desc = &desc->hw_desc[i];
-				if (hw_desc->llp == llp) {
-					axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
-					hw_desc->lli->ctl_hi |= cpu_to_le32(CH_CTL_H_LLI_VALID);
-					desc->completed_blocks = i;
-
-					if (((hw_desc->len * (i + 1)) % desc->period_len) == 0)
-						vchan_cyclic_callback(vd);
-					break;
-				}
+	desc = vd_to_axi_desc(vd);
+	if (desc->cyclic) {
+		llp = lo_hi_readq(chan->chan_regs + CH_LLP);
+		for (i = 0; i < count; i++) {
+			hw_desc = &desc->hw_desc[i];
+			if (hw_desc->llp == llp) {
+				axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
+				hw_desc->lli->ctl_hi |= cpu_to_le32(CH_CTL_H_LLI_VALID);
+				desc->completed_blocks = i;
+
+				if (((hw_desc->len * (i + 1)) % desc->period_len) == 0)
+					vchan_cyclic_callback(vd);
+				break;
 			}
-
-			axi_chan_enable(chan);
 		}
+
+		axi_chan_enable(chan);
 	} else {
 		/* Remove the completed descriptor from issued list before completing */
 		list_del(&vd->node);
@@ -1204,7 +1202,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 
 	vchan_get_all_descriptors(&chan->vc, &head);
 
-	chan->cyclic = false;
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	vchan_dma_desc_free_list(&chan->vc, &head);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index d8dd07efe60f..3c86e5d468ea 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -50,7 +50,6 @@ struct axi_dma_chan {
 	struct axi_dma_desc		*desc;
 	struct dma_slave_config		config;
 	enum dma_transfer_direction	direction;
-	bool				cyclic;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
 };
@@ -105,6 +104,7 @@ struct axi_dma_desc {
 	u32				length;
 	u32				period_len;
 	u32				nr_hw_descs;
+	bool				cyclic;
 };
 
 struct axi_dma_chan_config {

-- 
2.53.0

