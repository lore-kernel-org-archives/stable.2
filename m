Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271473;
	b=u6DFS3bpy8Yilswx+ZY4cs3tqif7s3ZB5YgyE1DJpKCRZ/KFrG7dHq9eTD46jes8sV+o
	 INFeXloCSomK7aAVasIBB2ClhDWcF2za2UG5D7YfuBfkc2grSemlbVfCgdn6669i07RHV
	 WNSxmtGk2QFX9SYoWmsJ7sjUkH+R5viGtvXRfwL8QZl96lpKtGXrjAt2ay/zRYgosDLi8
	 QW7c8BMWn4qMVI5ph6Xu0foAMcHaQsgUNZ1iclewHEdU1lUZfTNoIHW6DsHoO2V9OrmTQ
	 3fgizQDqdU5Zm5gJr2EaKMAleIDxI/0Z5sLVAjZNLWGCyL+sSdwtfrJ1pqPYoDx+dsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=601ZkybHQcnvafMGUUE2oSmb4D2juyrdkTa8YoClJ1s=;
	b=vCZ52aD2WL434MTEymc7gb4J+7/A3PayJzP/deQJK0aPM4dF6gKQj5Nom//2kCRNTGuX
	 30S/zy2Qtt+7CYZ5pNIhan14KlOB2tj3Y1XBX0CsE6ayt6BVDfB290vg4ysS+BnG/8f8W
	 +8YRPt7TgDGlmdQw+x1QR1HNWxeHs2lAQ1EBkrbcrOtk0VEKU5gnFxaBY8xiks45qafqS
	 q17+IurrHM/WgLu7lHWLgzWdJrQdYtLLQj3hOu6n1T4KmjAJf3NpQDn/6Rg/w+4gR+7dg
	 3HrUnEwwt3Vq9xpmUs/a9yGvxKj0ShHDM4xlXm+HwnNcQAuXmWJhLK4vNtcRs3trVeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xyYIWigl;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9194606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9194606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xyYIWigl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so20170695e9.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271471; x=1793876271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=601ZkybHQcnvafMGUUE2oSmb4D2juyrdkTa8YoClJ1s=;
        b=xyYIWigletM3AaiSoW7Gm83b5oZGFoU1gBNWUVWY0uqCrHeYIP4E6XsdyD5y/9CnFk
         CoZuOJQxLbkvlwA5JwOIGgCFB6d1WGtj46QjQszuw9GUWYGx/LFuTBtNKflrDHR0HHmE
         Hjp2xWluDNkY4YfRY2UVdqyPnsbmFrOiYfPiVhZzVUu4Wmh8ZZQBusFWkWzbsqlwLJ96
         wMexiVZZRKkFouJCcSKVGQ6oKZVypkxJfZkaM7mW4pxJYYn2GrArH1eRggEouKRV2KnQ
         ADrVioo9iZSutbOhTkCgJHduvsDPBHO8E4b3WkhkW2bMbeOvwJNPa4mxbDt++kaCEyv7
         zNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271471; x=1793876271;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=601ZkybHQcnvafMGUUE2oSmb4D2juyrdkTa8YoClJ1s=;
        b=m+w/Is2A2y/JyrpVi/PRR2t8UF6A6PfzKoG3ws6aXBuGNTw2f14yG81F1kV+lMYseO
         XUBboIp/pWUbJ7uQLTSsSsbfT15u+6Fuko2mz1GPjHqipOmYPuWIQq+JbOMoUhUaTIax
         R9B8PyjmpkmxpYXjTl7ymYw6l369EEO5i9bjsq5GdMpVEFxnXuUx/IPq75L9kssSB9ci
         ymSnbxeaIoOmLUkx4vgdFkq/CmCbtqttXyHcs+zbyBPkeQfgAYtaN9KvvP+kStAnOdGr
         8CGt21zStzUSQzS6uQCrLHPMCT4Y++nS9Fflzux/l4/FtROEmnVFHe3XuM3qUNN8PGR+
         RcDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLfC394diqSikR6tF1jyGXRGR8ZAXfnBborVa7YAPzZR668u1nF/hUXTA+UZtRPPo6wmb8HMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOQQHAg7eTsXS1Xjk7et/DVNCzKG5yJ7mZoegR6ItyJvLIr3rW
	1Due/cVhrYwSA2nt+Hbz1mBIrd0XiLHVqICB6WW/pXzvzodPvZSUcjo=
X-Gm-Gg: AYBFou0mNhr3A8xJ41fmw/tYCsLD+aFRv0WTV1jfBRmUV2yXCMnGUlY7AZMbVGvoCpf
	gU+a/hzT5exTrctMgVOKI4DdJg2+6fU2LXAG2G+f/3Y6HIfirA6S8OjbHYVrzh3uu9xTov39DgL
	KwSFgB6OQ5jHf7Z8MZziMrMe7GA3UwHf3a7sADavup2FgVwOlV1C4BPkvy5jRA9yRBFbYyw9bLD
	xoVYs3uVPS9yn2IyG5MwFw64e7zX0OX5S9u1jFB4udRMt6mMD6a8YlVd7mS6RZq7aqkVnCCCjhK
	4d8x3OSB4po3HSfhL7JRf5qWS4izpz4qH5vq+Hqz+oWHW28JalLL8Gc5HW98qvOrr6Rk7fyu7i6
	FxaFUEW44Mvcohb4V0j49qClAqKyrrRa7PI+H2zLqic1Raws8yNStpI8LwLFiZhCdqpy1g/PfNZ
	CL/TaYtm4GEwV+Y/lLaBYY3zPfjeAd31338eAdqI1vjBOpydjyIve/u/gG5+wme0IesvnfixmAx
	pawdC1x1TaVf6SKirclUhticK90KGEVqZuCHwpr8vcgl7fjd9MXPFkR0hOjBrjwtsKgsNklRQ==
X-Received: by 2002:a05:600c:a10d:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4a96639b049mr82589655e9.7.1793271471052;
        Thu, 29 Oct 2026 03:57:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm34266064f8f.9.2026.10.29.03.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:57:50 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v10] ASoC: wm8994: drain delayed works on remove and probe error
Date: Thu, 29 Oct 2026 10:57:49 +0000
Message-ID: <20261029105749.3732334-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029102515.3417777-1-tristmd@gmail.com>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

wm8994_component_probe() schedules several delayed works to handle jack
detection and microphone status polling.  If the component is removed or
probe fails after these works are scheduled, they can execute after
resources are freed.

Cancel all pending delayed works in the error and removal paths.  Guard
cancel_delayed_work_sync(&wm8994->mic_work) with a type check because
INIT_DELAYED_WORK for mic_work only runs in the WM8994 and WM1811 code
paths.

Cancel mic_work before jackdet_bootstrap and mic_complete_work because
wm1811_mic_work() can re-arm jackdet_bootstrap through the DAPM power-up
chain (force-enabling MICBIAS2 triggers clk_sys_event which queues
jackdet_bootstrap), and enabling microphone detection in hardware can
cause WM8994_IRQ_MIC1_DET to fire and re-queue mic_complete_work.

Fixes: 99af79dff5a6 ("ASoC: wm8994: Ensure we get a notification on startup for jackdet")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes since v9:
- Reorder cancel_delayed_work_sync calls: cancel mic_work first,
  then jackdet_bootstrap, mic_complete_work, open_circuit_work.
  wm1811_mic_work() can re-arm jackdet_bootstrap through the DAPM
  power-up chain (MICBIAS2 -> CLK_SYS -> clk_sys_event) and can
  trigger MIC1_DET which re-queues mic_complete_work, so cancelling
  mic_work before its downstream consumers prevents re-arming after
  cancel.

Changes since v8 [4/4]:
- Guard cancel_delayed_work_sync(&wm8994->mic_work) with type check
  (WM8994 || WM1811), as mic_work is only initialized in those code
  paths — addresses Mark Brown review comment
- Add cleanup to probe error path (err_irq label), not just remove

 sound/soc/codecs/wm8994.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index fc9894975a1d5..5a493f29c2ca3 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4563,6 +4563,11 @@ static int wm8994_component_probe(struct snd_soc_component *component)
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, component);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, component);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, component);
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
+	cancel_delayed_work_sync(&wm8994->mic_complete_work);
+	cancel_delayed_work_sync(&wm8994->open_circuit_work);
 
 	return ret;
 }
@@ -4604,6 +4609,11 @@ static void wm8994_component_remove(struct snd_soc_component *component)
 			free_irq(wm8994->micdet_irq, wm8994);
 		break;
 	}
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
+	cancel_delayed_work_sync(&wm8994->mic_complete_work);
+	cancel_delayed_work_sync(&wm8994->open_circuit_work);
 	release_firmware(wm8994->mbc);
 	release_firmware(wm8994->mbc_vss);
 	release_firmware(wm8994->enh_eq);
-- 
2.47.3

