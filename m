Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744787;
	b=amRsLFqAnEmOf/s5bS/VXvIg1ThecIjLJa+AZuxv2dqY1qiiR2vpbgpnJKkzbhkje3Ju
	 gx/ygXeOozklT4nneK/p3AUCTjyoR6AxwAmnz1wetoAdCj7CXhyOvIoWb7pb14SNtwNJt
	 SUlaNWUm9RlDDY2jxhrtW8zxZGtkXxELc8kndEW7BaIyNl3/4Q7NHhjMLqlDP6aG+QXSj
	 PE+dPIspxeAqFfJaYy/pW3MyZ8SY8meuGlpoWtYGOcKnpiIm6dzNfgwinaOrBlYQpuSQU
	 xB6orCZD0uJ10C7rIBAQV7AZMG1tU19xb3qz5virc2IxYsWinwt/s0R8X9n3Mx7fLBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
	b=OJyf26EvQi2V2oOlONSeN+afmxnx64QyxsfjohwvmOh+hVDFfFDqd9x444/mFaHqWuCP
	 Xc3jJKDrRnyYbD/BuZkAdGkohgVvX1U35ENMuuADsF65jKLDeQP8g256pN1V8TLkZMUyl
	 y0TpVjbkdRf4uHuzPjULuyh16yx/aHfp5DZlweBGlNHAnUt7f+bIfRMJurB/tivr+AxPX
	 0Gnji/XRWtZ0+0IAvqTeQtN3bZokzkCmogCuU0BCTJ8Q0WvrMAHaYdySVPjKeOCeZavBL
	 RIagPk16cd/NzMjJmvEHtJcZq+P4CvXntm0EEwm1tX8qMK+tKooaQWhe6GK1/paloQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oDSEy2y4;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50754606EE9E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50754606EE9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oDSEy2y4
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4f48d91ba7dso48347b6e.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744786; x=1794349586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
        b=oDSEy2y4mEoyput0d7HZH2+P/CQt1HWNoVOHRzV7uXjZRzBiBfrK280iUJNwnrPmCY
         adEdVT9w+OEfyqm1bRn66R9kzEta31zqSn7dNPQH6jFVbLWMMxif2s+pPcJS4lO7dy2A
         kftW40Lq0X8YxXi0eNL59JdGlQ2J2i/+OxPv3CG4kIzjhFEmGCAtE4bTDFm/9O+pcrt2
         I/jQyvzgpQBv+wW3bdk3UJi4RbfNKjpRSUt3ZeNM2EkDjiFyxPow152UY7BqlI1YMPao
         XYhHgryLEJuiNUgeVoHJOJ4Z9tEhfByrBlWvEoJeO/tMafA+u9ig6YxN4MwPEpdsS7IZ
         hi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744786; x=1794349586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
        b=RjfgLqEhAXHeTZhl3yC+9yopAleDLVa/bn16/FBD/DLciVkMjTM/pnC7mizWvuuqJA
         Ch+SjOBnGD66YYuBMJYoaCe9b55RxNmVK4RJxhCPi5OET+/Jg0ly+Pl5RtVYRy4Dn0PN
         F/+auv0/8FLoiXkIZWmUH7pTkdLPZDLaB569+Zein01hrH4YK08vmbfm5bIlHZG93+dy
         dG+0R/8TFL7pzVd3WTVmufOtzx7Wqk1YGvIul7b2Wb8WK6eMoq1E0pYzMy4GaZnfxaDi
         yWU0KvBbzc1BbCw/PNUu6Igd0YmymsgFcFHtAPD1eUqbC9so8zcHdn6oXrH3UWkJauKQ
         hwrw==
X-Forwarded-Encrypted: i=1; AKwUvBwVzbKxBjM/d3yAyBzwC0Is+WAW+guNi8I/+Hf0M2McuYBRXcKANOqc9MmN35yFAVdvt2mYI/U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Lonb2lTVUBIqYQIk7pwdE/b7O1393e9jLDw/gn+vHK8fEWcMV
	6vCVwBkO5jKlAGpzLuRviIh2paw1XrFiL8NobpSRCz7OxZ7M71sQI6eY
X-Gm-Gg: AYBFou3dvi1Oe6QOLKHOtdyght48rAfCMA4GqX1DeMEoMaQ05DFRpBZhz1dOi+1WN06
	rpMa8A79O4mHQDi4Dk9N8h7+5drQaRFGH7P04tqS5z+4XUE4U+lX+OO117PNCd9OeHIvG0r50Fz
	ldwSrxuYK0zbdhcx5fJP72lNnEQA2rpiyrkBJERH2f4jcvJKTIEdeUwC+jX+yg7SfcTkOYVxcnh
	vZQdyKShEvZ4u+1lAFMxp88RVvaweGFW9SabY80FqhREykpDsKkx1PzH/y5DVKadAkkq1wsSye5
	I0zhGWwKiXv0R4wfkyM5NzGLZC29RVDBs2u2XQup7QPEwTRHl6mel/WOEc9A+ZGIGfGItiVEwSL
	ctYS8gA0sBMbUA8p34yFkbjAJPvbPAfZrg1oVDZcdrPIfrBkowKZWEwhJ+UtxC/miH1cUfP3DAK
	SKIt19Z7AYD3jnGmB8iDEs+fuZxX/vYCG9Xbt+LDewiRzutYV/x+VhuHzEFWEA04ekgy1fRDYEm
	Xv7HItFwhmbBdQPw9griLAxcfoV/ugkBEFFj2pfPIHuzHeLP8aUPkX8uizS1lvwXHk9WgOkwAz4
	XJdrB/SBKB5cm3MDvWxVS8rrHvQis8Q+gbtlvsoetVfYVKFEpxOn51nFMlQMpqVS1SWyClyZDDt
	SYDKyYn5mpx24tb3gfTA9L3U5NIERLnkt0IPgaFZbM3AfaOYvYC5aFS0fVhNdHrHAse0dEg/zIb
	UzDNH5vL8rKT9F26eBSI1F2OqSbqUR820KNaNoWQr90KoGUNLyevk=
X-Received: by 2002:a05:6808:10cf:b0:4f8:4a95:9b3b with SMTP id 5614622812f47-5640df9396cmr10547961b6e.68.1793744786246;
        Tue, 03 Nov 2026 14:26:26 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:25 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:11 -0700
Subject: [PATCH v6 09/10] dmaengine: dw: synchronize completion callbacks
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-9-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
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
index 56a422ba14c1..6f863fae7455 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -923,6 +923,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
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

