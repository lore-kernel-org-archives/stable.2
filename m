Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309117;
	b=HbKwuK6NYykeVMQcpvl6vPQ7trFpD0NVs/Z36b8aSUdtSA2qAAAubT68H8om6FvCJX+v
	 K5ywdBKYgoIa4AkOBZ6yNLzpoIctpml1vPafG63RXL50H3RNKFHk2fEZzj/Xr/Ry4YktV
	 ut6BwEbZ+JthadNlUQpNpsHOXy3esD2dtATB4kdkDQFtYvtH2wSFDuMBZQBo6Vs3T5I71
	 r1cOwYvjD1Txxe2vzCh1Dv4lUtLJWPC/QroHvhwSqucQaMaOYfFiPR4DLTC8PWmYHmDEm
	 T1L5PIpqX2k1PWDVvup/9b1UHbO1B2tII9lmV0nsj99JiDCRpt4sa8WZVrmKPDITVyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YsEaBkCIxknBVMj/WhDHccQuJ+3nt9IxBGjxscUMLpo=;
	b=vD8tTJ+t2i+BGdC/dlU4XiZXijikQgjZXJL3XTOxsPm9q+ftaoBH/0AaDj6PigpPRiRn
	 CLfFiIR/L8YSlwJGG34PORh1NdTWtVCxd3zke04SJyNfM43zcEWUz7sohRJX6MWVxF19c
	 UNNL905srSER0OZ/rpETFk3QeoS7XO12lwAS/9wRguox8VTxxSYh+br+ELFTCReq+cmKU
	 8we0h4YkEM0sFwDn5H6E7uF2jAG4CIXXpvOgEGBw2T95Bwh1WqbwQGLdnBjCRYiwg3CgM
	 qVMgio/3N4xCbUhIqnmOk/OcoA4lN59M4pFN/k8JyasJR60byMWu/izgUKDKEBOHqRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQ0cWYmw;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF5606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25BF5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQ0cWYmw
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so745073f8f.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793309115; x=1793913915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YsEaBkCIxknBVMj/WhDHccQuJ+3nt9IxBGjxscUMLpo=;
        b=UQ0cWYmwB3jJfwAG1106aCDhGfB+TsoimabA+dF1hok5/iBCt3JQKmDHk02G/0cmh+
         S1v+KjLNJ8XUQ2ZmEIazHxY8DWuD2guxi8g/zeYUNgINSbaUpVCEFT0Aum8Zu3F6OgLw
         iGKzFHnggWahtTRtD7Z2ar6Nj8irExEQqiEbrtuFIcf+Cpb/cMvG36YAIYghUKt5MbEj
         gdr0CjXCsOI83WApEB/CY0nJIivNhMk+a13p+b08dCGwv5jt89fRJ/1xum+o9tybC/2o
         PA30y1k3ev9gUbJx1t6Tg7/bizxzsnJBHuR/7z89qADMBQl9D3JBpr4kGU58lOqEXDzJ
         NbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309115; x=1793913915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YsEaBkCIxknBVMj/WhDHccQuJ+3nt9IxBGjxscUMLpo=;
        b=Z69/5AP9hUUx7Nu94kbloGGl6OCicJRW7ICsIv1mLuEjFom2Xv4w7JlbxwFZmuPHd7
         BVJgCwz4h9d9yfDUtshnPAMvqbEtf1xfcTFT/akvE4CbiwquTYN6grTeQ2CEJ5lqoJUy
         NkW7JESRDbBsZH7WZrQ4UMfZpJI9SiH8t2gs7pxcI4kGePd4lM4obg3CO1UkdTYufarH
         4lhwEcLMkPgZFrT85AMqlABkihafHBb36NLC7nsFf2MD4DM4q70OwwLUDsRzs9aALP5W
         3FB/vBk1Oso+7yt7gDbl7844QVXqsmgxOF+V4dd2rT3AP+MWmN3MJMjdpSQCgJAFnbpE
         Jd9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxBotI0CD595jzjr8DflDXgNKgfPFskxGTig6xYgfmL/rAMzSOg0MRHIm+uKIM15HK0T32d/IA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJd7zjVPqQhhJg1OnEavUQ8pcbuZWuEfeScEGXaZVgfv/v69wN
	n+OHqNSe6IL+bh/nP/1SN/dk89QG2p7H6zKRS09Mzb78JtlgaMiQ6VY=
X-Gm-Gg: AYBFou18rSGmKIux70OEyP8VoVspHDY9Kpqf5zbf6jTi/jbUfdWofO/sBTARhyD4Z6E
	Y8bXyvjCEWoD9SigP9/AUCE1QesLoncOOFDD0IQPEoTxG18o5r+BmCAAAdiWKxkS2DPPWe0LEOl
	vwveDTsBPkxcEhHnj+6g5Vdns+bDcfFGFGw8JK7qM7anuI8yeYS5YDmBmfwJgFkj198JRYFQPad
	DZ6n1n3NGkWFZWD9wiLguyS8MRgKPg9mF3hLKiWDih8mBToI22W9iMkDfBWgKWgwWQkZ/sa2LPh
	sDotebcKkCJMmqQB0ygSG2VBqXTKoi2B3uc/gXa6fVJB5BDeswrVmLZSCirlCXVFCu1skFMwEGY
	BvjDNOsSRozbvCOJDxSb1nJ526Y09W/4jGNSezJ7cK9q+jfoeyBMQxKClj+NFrVYISXj2zZpIc3
	q47TDVOURzI+QMmNGTRe2//aYYt+VemWsdUzRynN23SomJp93+nN6o3xmu3e8Cb1zf9y2NcywS5
	aVHuqRCMocIN+dmIKCnL3vddeagIZwG8ce3wGvT812tsi8Y7SMbYO52rZUGMpe+BLyRqbj0APoF
	v2A03Q7PWyvt2ch5Dgw=
X-Received: by 2002:a05:6000:3102:b0:48e:22fd:1ea3 with SMTP id ffacd0b85a97d-48e64d02817mr9721213f8f.28.1793309115564;
        Thu, 29 Oct 2026 14:25:15 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb82584sm714873f8f.27.2026.10.29.14.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:13 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] ASoC: wm8994: drain delayed works on remove and probe error
Date: Thu, 29 Oct 2026 21:25:04 +0000
Message-ID: <20261029212504.2997364-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029212504.2997364-1-tristmd@gmail.com>
References: <20261029212504.2997364-1-tristmd@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wm8994_component_probe() schedules several delayed works to handle jack
detection and microphone status polling.  If the component is removed or
probe fails after these works are scheduled, they can execute after
resources are freed.

Cancel all pending delayed works in the error and removal paths.  Guard
cancel_delayed_work_sync(&wm8994->mic_work) with a type check because
INIT_DELAYED_WORK for mic_work only runs in the WM8994 and WM1811 code
paths.

Cancel mic_work before and after jackdet_bootstrap because the two can
re-arm each other: wm1811_mic_work() can re-arm jackdet_bootstrap
through the DAPM power-up chain (force-enabling MICBIAS2 triggers
clk_sys_event which queues jackdet_bootstrap), and
wm1811_jackdet_bootstrap() detects a jack and ultimately queues
mic_work.  The second mic_work cancel catches any re-arm from a
jackdet_bootstrap handler that was in flight during the first cancel.

Fixes: 99af79dff5a6 ("ASoC: wm8994: Ensure we get a notification on startup for jackdet")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristmd@gmail.com>
---
Changes in v2:
- Resend as part of unified series
- Cancel mic_work both before and after jackdet_bootstrap to handle
  cyclic re-arming through DAPM power-up chain

 sound/soc/codecs/wm8994.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 8bf58a6a8af7c..b9e0df83b9bfe 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4551,6 +4551,13 @@ static int wm8994_component_probe(struct snd_soc_component *component)
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, component);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, component);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, component);
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->mic_complete_work);
+	cancel_delayed_work_sync(&wm8994->open_circuit_work);
 
 	return ret;
 }
@@ -4592,6 +4599,13 @@ static void wm8994_component_remove(struct snd_soc_component *component)
 			free_irq(wm8994->micdet_irq, wm8994);
 		break;
 	}
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->mic_complete_work);
+	cancel_delayed_work_sync(&wm8994->open_circuit_work);
 	release_firmware(wm8994->mbc);
 	release_firmware(wm8994->mbc_vss);
 	release_firmware(wm8994->enh_eq);
-- 
2.47.3

