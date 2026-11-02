Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648070;
	b=zBqIzLildloNQaRO5wlRmL9PGRY6cXa62P5Uru3H3b5XUDC/OR75SLQGFV6v/90wxjcP
	 XuL2lzGRTnAdgPff1sKuWkV8Jgnw0uRM/+G9jcWrfe8KHFRSjgI0LHXp88LQxu3CTGJ9t
	 ZE7e3vJi9j8DzWPVDtGgA56EJNP/mR4lFvAt9s9IC/e9JUsXITBtx3XnVBoUCtHjwI92z
	 TpCU/saQs/faAQ5rHw7ZBGjdhxmadA80rR5CF53r1cN9TAdX9Qxx7OlBnRhdt3hKYM4YS
	 6iA+sBk5HljxoNb8l93M4alZmyzqsjjE/sciAPe1z9In5SObA/bagAJGxSVrpFajf+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=oUn0wNxtDa8bpouBdwU2UFn6Se8GBim30o0tIkBNdNI=;
	b=sFgD5sYcy2MrmTWCA8FwKMCMLeV0c+p0+A0EQhNPPUNZyagxl6b4M8ZDppjcst5PDy1h
	 +QhvZLDx5M72LY+1DhJhrZ+xQGL3om3obDJDiecvNRqmPP+LIiX5ebKf0aId160I1GRUW
	 7V89qCw8mN7k8oonKNKNR3JHXtWhIC/MTkLXsLaQPNS1G2V8NcQWiYeFtw80AuxlARTqR
	 lHMYbOqhfK6M5H3PLF7ZLBnP0HKQRfLh/muKlMxnjS6pA0M8+RFW4z+BDzoR4LM8gKeYV
	 /e1npxcvHLnbXLh2yJ370nim4ZZ887SrGvU09qXSAGXqM36sSTBRobUSSyzM059YcYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhM0ad6Q;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1386082BE1
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA1386082BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhM0ad6Q
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4af81963f35so2477687b6e.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648069; x=1794252869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUn0wNxtDa8bpouBdwU2UFn6Se8GBim30o0tIkBNdNI=;
        b=hhM0ad6QHyVqiEjyneE0zJvRxpNSObqwc3qxsOSrjU1K3PjqHOTkJE8dvYU9YcSNK1
         IxfVhKRrOX/pGJ7bnvR5Idy92TGHuqMJ0oGG5Lw3MYTIlzG0Cby65e1NytNHwrL8kbYg
         Harw+Jy6aA4WPDNsRmZqRODsgdCvqtfuoVAPXtNmMm1TnPOIb4AxPBEapIpotaR3m/wl
         gX9kAYscBUbUh9ez0s1LdrK1rajxcPWOxFL6fAk1FPzapf9UIZYtU22UvCZCE5k/Q9/l
         EZT0x67FMSUvG2akiUPyNUqMwCBz/Did+1cPHcD5B78z5w4481VQM8MKhgrj+z3FgJpV
         utXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648069; x=1794252869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oUn0wNxtDa8bpouBdwU2UFn6Se8GBim30o0tIkBNdNI=;
        b=AaNwRQ+RWm0ipYqqdb58yuyhw302dBl43+ht/t+EJUntVWDE+UZtfmuvYYQ5WgrVNF
         FVeNx1/etKS5LFxN7xM9hGPf1WJxFxRF44wlvSR7culYQdWV1DGjeQOx3OUG3Oq28oic
         xMpLCVugfqf33kcgBpSPJQjNZ77xFbJSBzoGUyfcpHEy0rsN9zg08dpcLaxdgUMTUYvH
         TfsQzAwZBCBUjH3LD/REjaRy6fu/c7f22ihzNVj8ZMfkFN8688NkYo+qaG3A/RYxmy9K
         egkVh+m7ABF/hcZdqLTwl/ftDiSNwTk5fWG6pGk18GSS+Jvbm1QZsB0THJpNTKQr+jwP
         xbqg==
X-Forwarded-Encrypted: i=1; AKwUvBzZkmGN9ajc8xsFLyv4+JkL479zmvz2q62uDZJqvqBs1p2hUd8oCNFXxATY73QWp/B2dpT/gX0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1JuBSWIHU3J3bA2ZjajWhhHT9UlC5kFOhbfN3ptTM7OKOmYxv
	10bbM48zYwJ/u1PpGjt+hymNpzt4lUVtr4u4ptoaJEi3X+f7lsl4J6Vi/3KBrA==
X-Gm-Gg: AYBFou1XSNpgj5HDOABG2UjSu5Ovl2rVoGfeUYDmJ+flFvLOAD8ZR2u74FJvqcuaAva
	iS0BL5kpUryEJ06M+KCpo4Ok7cIgCuLMwmr/xM1H+PhMcE6znz6Fn6C/y7bPYwwL0rUTc+PomVv
	TZ2896kspJ0OncKZaMCCdzkK2WT6nKfyXdtF6mtBJAi66/rFavCLPxvaJQVyKRXownMyxYc9UmZ
	FTACPRsTvANUBNOTU5/e9Bed/rnieoJq/hsrHPbE2YFw1phyDpPAvPA4ME+9AXsv+tvzxosrc/O
	mBC49lLZXQ84E9wEUpohDcM4Pch8pGO7UBbO/hP5+jHmWV00GfvSfQS/7CHHRNXSdoQvun1VtbL
	UTAL0SEciu2oNkf7VT8yhruSenCq7J7bCOj+k3l9HSZyCn+8XQuVGLBqwKMIkmg8yN0azA1ewHD
	7Blh28YPYimpIykyyuZWldp599irysLR0he5gO0jM1uGMDYNmgcd0Ia3BdF5OD5TxivZuK02kDz
	p0qmlZvyjNCqbCRBdFmXj3NUL3BmpISfSpe9QpmomLckuiWOCmFxq9yO32Vl1ikzU2AxsweuY3D
	FLhlou7fcEGbn6CaQQo4RGpgvjg01wHTwMCq5orRHVNU8GS9Oo35rY8HG2Tsl08YbRIcWDq4Gp5
	8ZXB1n5NlvHblIfZklPX5Sftnfqh5kS3Y391YUtYwTG7ZKaXyjGljysY4Ozbc3MrqlKarN/1D7M
	dxUFq5fjiXmneBb9rLCb5xGv3G97sPrxVFkyk84dMXRsBRxou1u3k=
X-Received: by 2002:a05:6808:5395:b0:55c:836:5955 with SMTP id 5614622812f47-5640dfcca02mr6963810b6e.44.1793648068831;
        Mon, 02 Nov 2026 11:34:28 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:28 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:21 -0700
Subject: [PATCH v5 09/10] dmaengine: dw: synchronize completion callbacks
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-9-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
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

The controller tasklet can detach completed descriptors and invoke their
callbacks outside the channel lock. Terminating the channel does not wait
for those callbacks, and there is no device_synchronize hook. A client can
therefore reuse callback state or release its buffers after
dmaengine_synchronize() while an old callback still uses them.

Disable and re-enable the controller tasklet from device_synchronize,
outside the channel lock. Disabling waits for an executing tasklet,
including descriptors it already removed from the channel lists. After
termination, a later tasklet run cannot acquire another descriptor from
the terminated channel. Clients must continue to exclude new submissions
on that channel until synchronization finishes.

The tasklet is shared, so other channels may schedule it while this wait
is in progress. Preserve those pending runs: tasklet_kill() temporarily
owns the scheduling bit and can consume a concurrent scheduling request,
leaving controller interrupts masked. The disable/enable pair leaves the
scheduling bit and pending tasklet queue intact. Other channels' hardware
transfers continue, though their callbacks may be briefly deferred.

Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-180707@kernel.org
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 339ca85952fa..6371b9156882 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -897,6 +897,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
+static void dwc_synchronize(struct dma_chan *chan)
+{
+	struct dw_dma *dw = to_dw_dma(chan->device);
+
+	/*
+	 * Termination removes the channel's descriptors from the lists, but a
+	 * running tasklet may still own a completed descriptor and its callback.
+	 * Wait for that run without losing schedules from the other channels.
+	 */
+	tasklet_disable(&dw->tasklet);
+	tasklet_enable(&dw->tasklet);
+}
+
 static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 {
 	struct dw_desc *desc;
@@ -1290,6 +1303,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
 	dw->dma.device_terminate_all = dwc_terminate_all;
+	dw->dma.device_synchronize = dwc_synchronize;
 
 	dw->dma.device_tx_status = dwc_tx_status;
 	dw->dma.device_issue_pending = dwc_issue_pending;

-- 
2.53.0

