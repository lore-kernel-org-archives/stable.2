Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471787;
	b=OQ9t8PuAIiBrsHasVGJTcszQTLDdAIBenrhggqs9ZIkZWuhXILFCqOklCxwqqbd9HXKo
	 fJacRKLma47lXb8tjhcV8mX3Wp+qk5cedMEWGusc6rlKJ90IJSoZwH2/HHjMx7gJMEzNh
	 JSE7UUTVQwkzY09NPtnAHipHrleCB/iIb1hFPXwUAkbWWW7TGd7cxjwYnMfr0Io9CGx7c
	 kQIRSkVyo7psrHAujCCCHhDETgO5+Pca611FxATOpm2EOC11m+lc5GgTDb4p6YXX7wp3z
	 ep4tYops9PJwIHW6GaFI0ZSLqBMag2eOgm6dGaW8gajffDq0hnBTxv2OH7VU/M0xmZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
	b=ecd9r9HNCpgR4G51CYI8dlvSIb0ddHsJPQeU+4nXZDpsN+Vd6NNbruNOxgRZZxEjrN/O
	 uMAclwjCVnmHI4xBW31NEyFJhEq0Yp2VQJQ4xaQovOGP4OMyppLdzkyjaQKIZ2qtzaZZx
	 ysoRRzL4jbjquRqgN+9SyMO6rLiMLjR9ZgukhLAm6W+SXCI+sp513zSGcO8lAdy7AKgEE
	 ObsipTmQt7yyN6Z5SbNWwdX3RRwozGBp0prrov7n4CtWR/sBUKR3gQNM7hzQON4wBB/Um
	 ZbkcnSjH2a5+ocO1lCv7KZsGzMi3rdcRuxh9TYzHJZHx1nY1p8RXLkGoqaNUTZ7ct6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WFBgQacY;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A4606A8AF
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 439A4606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WFBgQacY
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-85a5455bd3cso2242945a34.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471786; x=1795076586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
        b=WFBgQacY4SAYWRfsBSBaJ6s6QX4C9BAJ0aB8ds6qsiTOL5oDQPmfG59kRdjQvuUmwt
         /x6HX+86LluMIeu7fayNo+Fd4dt6Xa+sLBw3Ag8mU2O0I7kKUx00CkUOVSqFdJ6RoIl5
         hi6ySBXZiO7tbbDUloV3DoanZjjwmmTVXu+HR7MBMO+GfUxQW5+7zNwD62RrTaxPGCbM
         J52bzQek19rJmAFKiDSHndRguJ67IsXWUhCEw009QqtbquYGFUhNvX7GSSRxpsAfiqvm
         LpHGruBAnQxWETG6R8LGuDRFOhjHnv/bjhivshJQq9OKqp+3WXRNG9zmJDBqfwyflDde
         nxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471786; x=1795076586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
        b=OQOzqkPAYYj4pN+jM6+odLKHLoUpaqdZZuQ2zuenTi9qccDt6I9a41WOlTud1kTXMD
         yVG43+Xgilhhlksv1bKR+MpuMvzKEtP/UZT42bJIlU6ZCC10UPfhq21IL0yDY9wYiEmu
         20+nZGAKmmaaOSOmAaf0cHmwSCSACU01FLNbSRQOcTxMgwlBTPnv/kBSpSixevIt8soJ
         kcJl3dt1YcTksXLQfVLdCUS1i1cvqFR9Fjzf0i/8YJbwzQXz7xQcmuyxFQItKSGqwRfT
         PvLoBrfK4CI/+5+2cJTDwA8T6aja2zBbyLzEestd+Mc/f32YMbOd06swRiS9quRiUOGM
         bFQA==
X-Forwarded-Encrypted: i=1; AL+hErHU6nFQ54gPDJgyRvJSuQ6UZ6O9jp1gk7ABF2qCMN70qmplVyfx8SyyEh8fnPQsAFUv/02+0CY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rz3RHuyI2uHtqGkM1Ix7HV7uFcdNubqv8/RaK+v/lde73PnqD
	jUoW7WAp7BZZOMdmSxp8yUm4zeo+92h/eYATs/P7ecFO+pQeUBbPaH8R
X-Gm-Gg: AYBFou3ZOKIwFBVNzeeMULFiJjCOWeyjKfIZQUz8+cP5KcpbZ8z4qNwpQFcV3LBjS9O
	vE7GX1S8EtMjsXBDERBU6IBzjR2p2Wrc5Nmwwi4Gqpu/6wkIBoUR/WU33gZNVBxwKxbQBtOAAdw
	QNeftWLplmETP1zpKV+mkTmXBjrGsXNJ48xKmfkaGJQPRU8vf6DY+WmIayqWOJ2Jnv+I5D01X/9
	HHi5OA1wrRAv2W3bPEHT4Adbly6Ffq4kCPiaJZxY5FSSmERD+eTkCFzh99f3MbNDrbV4zIHRNsn
	44WdXFRgl2o34RndhTg2loQQfgK70ql9Ge1VXlFaMOOF4+7S6Hw6sfJIE4URUg4zZ1gRdIoFHFp
	TtmztjU0nFNSuIWkkBmRP7h6ET9vRPSUrq0FcLFd7hboEEs/1BYwXFOiajthrk3SiplA89fsqfQ
	7t7olF1CvvBNfbjpvuahCTKAMMAOaHN+9hYDJvxziXXsJpaO5Wn/9aBgWt3pZFtD/74O7nwnAGE
	V/7wKdowL4GHyR/+/MvYU7pzNhxNib3nYwtgU1X6FQItx61NetkI4P1sV2DuhQhirnnvFOmc63d
	cMs6epK8vDpGBbCPMztwwscbcf6snT627Ahqlf64gpTNUzRBU2fWMLb7RK7L/w5W61IoU0RE9Eg
	gYpDBhT4oRLqup+h7+h3V8E2RpKPBZnb+AlgOgZE3xFaEIzyJIzFaIdKmj0POQaXgxXQMoUpYgU
	XwcaSWsYYnJW9TXPqXvRAvTJE3e4jN6K84aYBUliP3epRYfX7503mU
X-Received: by 2002:a05:6809:24a:10b0:56b:220d:cc5d with SMTP id 5614622812f47-56b961943b0mr3378225b6e.10.1794471786165;
        Thu, 12 Nov 2026 00:23:06 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905d3bab2sm7411157b6e.12.2026.11.12.00.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:23:05 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 12 Nov 2026 01:22:52 -0700
Subject: [PATCH v4 3/5] dmaengine: dw-axi-dmac: retain descriptors when
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
Message-Id: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-3-3ebc24b243db@gmail.com>
References: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
In-Reply-To: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
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
index 405ab9a78955..040c12d07db2 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1185,22 +1185,25 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	int ret;
 	LIST_HEAD(head);
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
 	axi_chan_disable(chan);
 
 	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan,
 					enabled, !enabled,
 					1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
-	if (ret)
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
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);

-- 
2.53.0

