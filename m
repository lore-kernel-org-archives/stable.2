Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295108;
	b=jA3mGT+XLTnplOqbk4zrcTPFAI2k7qMZH1HXGOor1AxYVEIrtJABOlSj5q/wPAddiYAJ
	 CMXuT8tFjPFdsaBPzx2QYeDwPWLjZhXTtBxO01UYUnJcPFuyzIW66IF8qiR/LebAOaeBi
	 n1EiSmW2samkqDB3EYruw4HeU+ELjxw+1zAKTI/RBApUsDvWpXrwWtDMQvs7HC3Cz1fI4
	 Sev1l38PQD8LuPzaxGI2XI9FsCUn1e1BGswqpc9dbphAsV9goDimrQ3ccp1T+M9TPt7ll
	 LfojE/+P1T4QGAX62lr6e5BbPx5BzM8kDKZRepGRp74aZF/H4T/hQCwQeBC6AgQpueA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=eFxpYc2J759AQ02dlWk5Z0/72E8zxFaWSsvkbV2ZYjv1wTSTODPKhJas+tMkFG/tG/3t
	 Qj0WFBiraN0zH8//znL7Q2QZO6A2NSUUXLrbPXvUJ1mArtdFLhDCpjKisH1ePj28Kt47T
	 d9/hE5szSWgnSmjMcYnxNJ19cTfmOcM8l3p9Dh2BgFPzGuuD9EgczhKiyBlLKGRzozg6Z
	 F9a2L7t9MBRV1FR+DJ6t87AskRJdUNuZoLWpEib4qsuj0zk6R1yEFW0X7HIPq3EO060vZ
	 gaJnM9xBPDyfNvmy3eHH9vYOKx8i6Ad7VdmBo+mRpOKwRTJYWInB4EevRsvBUeBGnqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ScglfkVr;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5671606A330
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5671606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ScglfkVr
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-71ad5f20016so1420699eaf.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795295107; x=1795899907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=ScglfkVrQoDBqFhOeralbC4w/qT4T6PObOz6mK+IdCelxDotSwRIhwn2xFhIq58UCw
         9Ws9TLsKxgZ+df5vHvYjs7AfVWtkqkmO4z5IYuDMwTB53bvSWCWrm80PVAD8qVLFE1bi
         51aAiOrtNxJrb//NaKrtnDcPW2DSoWag4FYoSMSILeZxKZvwxDKAlpKCqWzFhPtciMvl
         2um69p/pZRns+nP59bF0WvIurw3GI1OdbFyPBnYiXd1Vc2FifLWKuactqr5GgX83VGxv
         iMDbEynITUiVK78dkIMLSTi864Jh9Lbw6F1+P+vkJ7DAZWwCM1maohG/hTKi9roYkkRC
         N77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795295107; x=1795899907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=xmGOI3jZyFu6wuKrEqB9YDlUuYylztkGyXQmpOXz5/5rcjPEmf2yd0pui+baQeuAM/
         v6yEkOmNoRML+/X7WiUduuFQDylF1WmB9JH1Q0UR34UErCFwOrEF9J3h1N9QUOMG0UO1
         GB/kISyk35vX8Tl9CTCZOuAqGljIOvQ3Fj7Y5DKA45h9VctKGb6rAe2Xqy2CAvxBDYAi
         8nbq1n0keNnHZ5khy9TYOyzA8WKYTtS+iIIAAfNx4UaGf+SCVl1PELspJF8b7WDQa0Xc
         iE0CKOslfhdzl8EkBqb3H7T5iW3bS0vvZrIdLq0Kb6vu8g5Lp9JFu6EmOWOSJBs4bzPj
         52hQ==
X-Forwarded-Encrypted: i=1; AL+hErEceONn66BfrUshusxPjNJUuy/H4sqJbcttef9wPcKJV9YAqWT9nv/6ImpZT//mLVdB5yaWgaU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lq3qB0Kt07BhTPKo8O79zHWqfaQcAaD5QvwtaHDtzR4poISxA
	CjjfxE76eKLoIL13Xg836IFhY2fsVflhlHSwjgD4p62mFDjJHBLMFpQx
X-Gm-Gg: AZFdTZeBanbCGS0O5qq6LSbus+6ZdJTSbzzWMF1UJvsgucwL7wa6WSSbyH4x7MJV9Dd
	wvAzHP/vhEqJ2cjkHvS2sfC4rfrkYEi7BstwQjuj2bvThLd9MuwZbaL3XkMl/lm02gm0EkOE+JP
	EeQ3INVuZBcGDP+EI0J1L3Ydc4h7k6XSkC8V8cUoXqzhifWzKn/3BefhQy95QP+RIFQdLAe4f/t
	oJ+tYhrDzSrzG57sd7WVj7pfxnn2JQ/aojFnRzR1BlNApivpA7HVTitUgSyW5fv+wJoQNm707Yf
	4/iyqAUEdSd8hZ3dH7F8uxjcS4gRYMKhYcwyBEv1ozrvAVvNVbUpeJBU7XGypJBph2fH7yq6Evb
	upFSrYHdAy5uFrYUczuAM+Vr4luyslvnjEhudN5H4jHPBjVIjRwM5Hnl2pjQSiXyXKxd2grIS9M
	y1/97TO/b9QtzsyaCmtR8DF/rTunlUl5km4sOr3fNQ5OglaWYzGxaLM+ylRvZfKaL+5AC7EPvWP
	mlLTieOuP5Om990MslOS4CmrnhoT2u/Fcf2s98lb1+gNZagYXy0a/UuEk33cJJyB6yshPe+bPLl
	vPIl4UQ/1DR2G0xqMW7osRck50yWr4LbaT6iEkYx/speiUwVI0CYFsN/aKLfTTtFcrb03hmRfSY
	iZe2hKK1nHdd6iRaLUiHhRGlvuNOfTvR914zT0jFAr2yvrMzFOavSp+AsncThcJxRc2j/+4hodN
	1/jsrwEYGqZSgn7DZs72VehH0+BjtbqGBhhtiYw4LMy2twGH0DmSUv
X-Received: by 2002:a05:6820:5081:b0:71a:e645:ddc3 with SMTP id 006d021491bc7-71b39483a3bmr4673731eaf.34.1795295106782;
        Sat, 21 Nov 2026 13:05:06 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4635728eaf.13.2026.11.21.13.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:05:06 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 21 Nov 2026 14:03:17 -0700
Subject: [PATCH v12 2/7] dmaengine: dw: serialize error recovery with
 channel termination
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
Message-Id: <20261121-submit-dw-dma-synchronize-v1-v12-2-f51eb635209d@gmail.com>
References: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
In-Reply-To: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
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
X-Mailer: b4 0.17-dev

The tasklet samples RAW.ERROR before taking the channel lock. A
concurrent termination can empty the active list before dwc_handle_error()
uses that cached error to select a descriptor. The list head is then
interpreted as a descriptor. Even with an active descriptor, moving
queue.next unconditionally can put an empty queue's head on the active
list and pass it to dwc_dostart().

Recheck the error status under the channel lock and stop the channel
before selecting its failed descriptor. Only one transaction is issued
at a time, so take that descriptor directly instead of scanning for
completions first. The scan can otherwise complete it and start queued
work before the error handler has identified the failed transaction.

Detach the failed descriptor under the same lock and use the queued-start
helper, which leaves an empty queue alone. Clear the software-LLP flag
before restarting so a failed multiblock transfer does not prevent the
next transaction from starting. Keep the completion callback outside the
lock, with the detached descriptor owned by the tasklet.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Fixes: f336e42f73d9 ("dw_dmac: Move single descriptor from dwc->queue to dwc->active_list in dwc_complete_all")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 2a9db9e39f5f..f7ca9da5af90 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -403,10 +403,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	struct dw_desc *child;
 	unsigned long flags;
 
-	dwc_scan_descriptors(dw, dwc);
-
 	spin_lock_irqsave(&dwc->lock, flags);
 
+	/* Termination may have cleared the error since the tasklet sampled it. */
+	if (!(dma_readl(dw, RAW.ERROR) & dwc->mask))
+		goto unlock;
+
+	dwc_chan_disable(dw, dwc);
+	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
+	if (list_empty(&dwc->active_list))
+		goto unlock;
+
 	/*
 	 * The descriptor currently at the head of the active list is
 	 * borked. Since we don't have any way to report errors, we'll
@@ -414,12 +421,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	 */
 	bad_desc = dwc_first_active(dwc);
 	list_del_init(&bad_desc->desc_node);
-	list_move(dwc->queue.next, dwc->active_list.prev);
-
-	/* Clear the error flag and try to restart the controller */
-	dma_writel(dw, CLEAR.ERROR, dwc->mask);
-	if (!list_empty(&dwc->active_list))
-		dwc_dostart(dwc, dwc_first_active(dwc));
+	dwc_dostart_first_queued(dwc);
 
 	/*
 	 * WARN may seem harsh, but since this only happens
@@ -438,6 +440,10 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 	/* Pretend the descriptor completed successfully */
 	dwc_descriptor_complete(dwc, bad_desc, true);
+	return;
+
+unlock:
+	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
 static void dw_dma_tasklet(struct tasklet_struct *t)

-- 
2.53.0

