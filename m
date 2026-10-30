Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382525;
	b=X7+Xgwze48CTJQjN7H3+k2pNlej363SrAdAP6Y4P4hBKxVdEqhOA6d2vyDGLXsrvZyRW
	 tPcgC3+HkIdJIVW9F7AWh/S5oQvA1uG+gjBdwbGZar2/zfy/H2sTrpZrILaxkJZCUV2w8
	 zcwo05mEMr3KPy1DP1NPzQzQ8/L35YDyrbUc+ejWyuvI7MeFcHe6dktIEADu179SdFFBB
	 aq69MuAKkLpqG5JB1SPJcdCzZVTpwGwuEYwm6nvpCzICN43Ok1nWdZF1i3qBheGhGM9J5
	 1JCSPB4kam8+cDCWzfGrI4HyXu7PGfyUY9WADUGADvPdlrAShrNdyByD0yQsmpanxPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e5+c9AXhONOxMQgPc6CEGvMQHwLZrqKxnpe3CnRk/A4=;
	b=j8J5tmSa4T3lD2CFMJYGiX7gRSA56JTYyYiSKSM2WIuaoZvq1Let27j4PnLrpWA0L9p1
	 EXlRaBTosvAbBCXXF/w7SVLi8NZ/XHhD3AboDIXxXdY7yVH/Dr8m56npKKKwcbp3prQIQ
	 HAlEk8saOcLqaFLMtIwOggP5MCu3mhQyz5BwNoGzHvsJKYITUnx6n/FsU+gGnmwkBYwn8
	 maRyPM597wRla7DHazjhKgPLOAWcRPS3rPVh4xaUfk37yM4wndCQZMOcEavcTY+A0PVIx
	 dcZFyFyQ3Ax74j8BVDdJVNSuJC6BHKW/lt3OGWhvRhVxC6yOer3vvZZsKAnI7JHWVrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BV5ekKLA;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B460A2620
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A81B460A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BV5ekKLA
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so11373885e9.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793382523; x=1793987323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e5+c9AXhONOxMQgPc6CEGvMQHwLZrqKxnpe3CnRk/A4=;
        b=BV5ekKLAyI6bQJ94BR+NHhbOkaImM8rAugfPQ2zSa9dzkSCFNdMv7xz1OG8bFdY7JC
         xWqF8ieeO0KwXJNVEw20ealfDpq/HqTN1f4XZltm5eEP3ykBIycrMgZ05Kjpa4xlrgy/
         x+CbRWxiD3nn6C3QM+83u5tPbEU4AmoWCPXCo/bNbvCkhRqZ3xOVM3GgySyg9S4Tq0rO
         HbUqBnx4GOduJzdl0hbIEIScyo8aqgnmakf4qvYPJ1gAp0GjGpE+bepYNIJzt+jzu9dp
         PEFaWe4+GOdygU/7zdapjmnbY1Oh5XMwGmAILMdhG8DQh4tpm8eSU7yhUcUp5ezZesch
         6jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382523; x=1793987323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e5+c9AXhONOxMQgPc6CEGvMQHwLZrqKxnpe3CnRk/A4=;
        b=rKF+ZWuOS3xVHd6X7JjiqmDGNcLPvIYS80cnksToLzcsREF7udznISHAt3SWFYYXxz
         5rdfHq3LAdf0bR8pUdiWX8T1L16WVUhJrIIzsoGm6C/4SAjcGR09waSPecbnFSAxFuBr
         CA5IJ+zEFmCHNfwDTe+IKw2V0zyDuW/he2RGLcBeS3drIztK58Y/fixMLuVIgameJqxL
         gE/lbVnLI/yuxWmUpC1uKxS4BReC6TwU+TKA7GPttZDWwAm56VIafQck+f0tei4z0e51
         +rwGTHax/seey9aL+YfXcrdU3EPubemnj2xKAb6Zu53s6jg10DCJHrodHI4MAyMHypt9
         uCKQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6UhFZVXXCb2J7F+dmya3JZoXv2BSGY/BeZVl1AUJso4a/MYWDinSrd+V4IwE/A+oR7A5JALA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvBSn3LbdNr16X4EEYTksNgu7mxZ7du/aNOvuP5XA/0upcqnDI
	CGLlGoZ3Xx9R9U8XDlm2BVmFUnTSnALrBmfunVELGJ2opKJ5FkJy+PM=
X-Gm-Gg: AYBFou1j3F6FGqAon2G5eCRMP22USrc0r7ODqxhs+OGbph9v1RbMwFTrUTLAxEQ4B4N
	59+jMkKaoncMme7RYYub4qSmPZ+SdkTRj5oKa9j6pJo/8fGEZOPGWVKqmapodpc3+jGkq0WgE65
	yR1tEGmZfLma8tEyVOKlHEA0ba+XgA7mk9N+HdSbT9SsIkglRK0zQr9R0BU6GRhWvEYTGdcucRY
	cGbjIgziu0fLYDOX/lAjBOE6oIzlJhmVg/xm00OOQptQ6HQ0Q9ybZeiGnL0eJoIL3iuityhLwX4
	l9RAKZbyOACUuWwTmr93JllrWrSHvec1hqYoDmts+tZNfpdcbzABl6aKpMSMlMkgtXPaUcEzKGS
	Em/NaaFHFQB1FQtiHXLT4gh12ANlCuQ+6dx8R/w4gB3zYkzHYNmFbFrh0dRuGtQVPEmN3Yevpf4
	qFHYfb7IpQWPbbqfODQnIkzh5Hz79Xa5cw61HZWLst4KKy+gj6lNy6QYgilkdPDfP1HhmHfju+t
	zylCoFfkick4iA4yVNytaixIeq+hsJheCfFYLwUaf7D/U+ArpZV/D20TUJS8rvfMykJXotDmyOe
	VHlSAlBPzw4=
X-Received: by 2002:a05:600c:5d6:b0:49e:795e:ba89 with SMTP id 5b1f17b1804b1-4aa8a0f4e16mr107659595e9.6.1793382523018;
        Fri, 30 Oct 2026 10:48:43 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8e5f4sm4492926f8f.40.2026.10.30.10.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:48:42 -0700 (PDT)
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
Subject: [PATCH v5 4/4] ASoC: wm8994: drain delayed works on remove and probe error
Date: Fri, 30 Oct 2026 17:48:37 +0000
Message-ID: <20261030174837.1839402-5-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030174837.1839402-1-tristan@talencesecurity.com>
References: <20261030174837.1839402-1-tristan@talencesecurity.com>
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

