Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379880;
	b=cL0AK7oSPZxVWOTHNt3JAAnNyKCl7v9UAhaPhvKV0vNc+Lpti+mHRY7S3KP3lTDisNKV
	 7o9BSrGWXCcXo26ebTYiDd6KilZHs2aTWcMXcnraDC8ElwcdJHSF5Mrjas3ZsxjqeGa5T
	 TO8XAOJuh7XKiZss92hhFCzgHp5mXDuDSl6SGkoaPbA4OA0wyPh3OXryZNO5znLO4y9R1
	 zMlR86orpG2bgVTNikb8U1Vm/mU2YOCDs9JHCX5XriY632tXhr+zx8ZFNKUJgUR/F+Hsh
	 Z34fmphdT8w7zLgUnJng2YcFq0snQZM6Vzdh/vTbfJgaw1ZnJALQHPdobnEQVGiD7OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e5+c9AXhONOxMQgPc6CEGvMQHwLZrqKxnpe3CnRk/A4=;
	b=gSIjah6007+V6H/c92y6OekbKxq6j2H66WtoA0KBqAKtg0RsoF4dsPmwopMMDeLijlHJ
	 68JkBujGBJIRNgxBoLvsLvRn6YzAn3zQYdLGLOVYUi05cUQF+3BweL4jqjYAo9fAl7WXO
	 VC3OoniLqPB8ELheZ1CiKCLqV2DLoPgK/pzfXmx3x9bKy7526h9JOMjtfU/48XZyfrdTi
	 rPxq290tJsF7G6d2c8fVMVsi7yTrBsY8fh6aKsxn8Lz9DLdoTXtfrX7ecRxOEi51ADQhK
	 qVOHHBmwUF5kH11ZrAfKJXA9W7hD9+qeGaTrsW4FBMbC6DnHgUlKvB326304zpoSIDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkayg9It;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA07606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EA07606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkayg9It
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso1795378a12.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379879; x=1793984679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e5+c9AXhONOxMQgPc6CEGvMQHwLZrqKxnpe3CnRk/A4=;
        b=nkayg9ItWzxMNCzU3NeFuBygS75kj29Ch049Bs3LK6W65Dq1/Kj/fOlMadvexMreav
         Q7PyGDVJEphPEORQSXxw8QVaCKzE01zHq2ricdU2j1rNCOO+zK5udlNxRC7hg3VKhWOM
         r2ryhObNhehRbTpw8j9MpL92GsfWCFbv4YWaTyRRhMZwTlOGYR4Vsf7wRaHntUPRCtwS
         A5Yz4Qi/ZyifJhBiKHaD2+9us4doS0czfz3RRHSm4+kG3xALHzc7XGKVKaYuohWvdltI
         bV/0mNYV/4FmovEf1W9ITylR2yGmmmwWYa9xD8T3yy7mGZIhKN4gGE21aJm9DGpH+ZWz
         gZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379879; x=1793984679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e5+c9AXhONOxMQgPc6CEGvMQHwLZrqKxnpe3CnRk/A4=;
        b=sZEiCta/sugecc3X3D8cNW3d9FlXYi4wOGaENQK3rhUwSz48Ieyb010tiznOCMG3+1
         iW2sQe7xk/bhC4u6zU6nCVKlhuH7vvqgWO7D/R0oeKU5Goyh5HpH5IqWO/nEhkEPgg6T
         mGv3gfdDaMa10pvffFtHykUVoFddzMGmt0vacrLmDxm5dmD53l1v2NJybohj0RVHepd0
         Z/hvMJmZIvGcBt8VTKhHSzLHPcVIwebDet8SQwinWjNbbn6rpcp8d2Zh+zfJec8NAx6o
         F9IlsAM7IjNtlqBfoNQFmQDV5wnlAdJ8jQRxGbKf7u0mjBoyFlG2E4Gj0mZyJo6a//Dy
         /+Qw==
X-Forwarded-Encrypted: i=1; AKwUvBzXgt809kKTUZ5kh+RMvkQozCwwiQrSgiarNDLMLrqA+iH27YZyMwkayyi+JSySdnAfOiknojw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqEMZIzxip8i8znFlHNIz0J8b/7LUrida/2HYgdCKVncSA3d5G
	VgTcyZBDTscZEvnJL8dVJRK7y0zXC3ui77St/Zr3ykULyudU2cv/TvCRYX4A
X-Gm-Gg: AYBFou0A29cv03a8/C3xDPv0B3sinZ3YKS76ggeTWN/mb+m9AzBq8aTWR8mBV5sVSZG
	NIWSP/fJJQhJ2YsNPC5J8HvzRKp1xEc/XSAnrIunW0QqGphetvolIgb6lNVKdvLAzUvjHkaUonW
	xnQbCl7byaycxzZv3HxwAn34UJXXa12bAR8E2IcUKC9Fwb+D+E96H8FuFQP2s/+9GAOUVx5f3BI
	my7HAFaucXWRFfum6yVOmakguyQNlxAeUkgAhQr5Se6tVN1689rjNRJmdw923UQch8gcUKc4WPW
	iTUY0myX3VNgwFVzN6Os9uu1yUZZEbSeOgmdzAFAasqeWFlUf/ONx2U0udeNuSamKiQCWWM0/Bv
	Jby8rxt+fhh9LNSmgTHIBpMBQz7sAN6JM/pM7iKJWnt56WhG6GTLSkJazIGGfh1goMjPX7JoqPp
	32iqM1aDV13BKX7wfDdsIECq7KsNu2aRRcF70t59MmTmkl1GbdO4DuOCdb4utEBAxTyEPUEKErn
	++QaIZZNMxX4nzGfs56DvyAGOsbioBvkUssGUrOCWgDSDmgZRkD1C3xJP7qTvYkmr9pDxEvJbrM
	41X/Q+xd40U=
X-Received: by 2002:a05:600c:6089:b0:4a2:a8c:22b0 with SMTP id 5b1f17b1804b1-4ac14ec75fbmr62918775e9.1.1793379868131;
        Fri, 30 Oct 2026 10:04:28 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf7146621sm75121785e9.13.2026.10.30.10.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:04:26 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Mark Brown <broonie@kernel.org>,
	Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v4 4/4] ASoC: wm8994: drain delayed works on remove and probe error
Date: Fri, 30 Oct 2026 17:04:16 +0000
Message-ID: <20261030170416.3561618-5-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030170416.3561618-1-tristan@talencesecurity.com>
References: <20261030170416.3561618-1-tristan@talencesecurity.com>
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
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
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

