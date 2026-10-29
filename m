Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269519;
	b=aRBnIntwdNkpLckSgj3JK+PZLmNtepTfgd9IEDrmamlgvP6IoQt9xJVcMlDgUhBZs+jJ
	 ABoUF/H0DFFUSN0r8aINyS3CO0xX91UVM5INW6t8UMKjBbXeLmC+hS/5bTn5jfEVuitiZ
	 2p1eLm7rm+zwHkAeR4ykrEWdZXZWt95Y5bWr2O+HGeHahFI6nGOtvPApCI9AGC86+gA0G
	 sicDDVSa6GUsbWooXEwELVVvy2W6w7OtbNDQxmeKue0PqBFvgDSjSWDJIyTCWPGAurVaO
	 vO5JGWvFOZRNaKFakvXsOJPYKZ9MpSQCC1zb4zAsxBDS59CTMK+UkEQkFG7iY3VUMTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OtSElUmkgSMBmtpp69kzqh/LAyhlzAFVWeVHo7DNDyY=;
	b=5fijiWxf/IfmEw/tHIwmVsQZctTqot3QYTg20ftV6Y+A31MhhgXg3wkqWNGpoj/6+yqO
	 nM8PX6IVKF8LfTZxlgzrhhFwGkxto4q2qzUmesWCTjZhjfoDfRjOohQi9OQN7B6NpbS2d
	 /VxeewywgG3TSEQQws3zk1VNHsR6+2qGM50PIHF+6R8Ei3ymUfQwms90GNnqN+KtAcWPQ
	 B1VoE4z58sV6IvRjVge/qcsp2MrKlRO0MTUiXKuCTPI0M8knkJQ+XH87K52yUORj8UQwx
	 XyjSmVtszF0+TyKbhJDdTGdx0e+KLT1Y8ckIr6LZ5+KizifDEPLjYyDUPKTnmnx0XrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRbWJS9S;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15D606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC15D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRbWJS9S
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so18252105e9.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793269517; x=1793874317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OtSElUmkgSMBmtpp69kzqh/LAyhlzAFVWeVHo7DNDyY=;
        b=bRbWJS9Sq3WUrvm1K5CCDr/2/y8KgqJiqm0xxnpw/ojea8hd/zgAwmJrEL71ITjiqZ
         t4aGIfbQtGFCXTpFU5selcxPoZVOx81+BOYn78zUeUvDXX92flM8Ncdm2ekyE1btDhn+
         xE2vof3zAVSlu0LpRS+SkvNBvrfGH3o2EShZVHeTDrQuPYXRifPOLwmr7TJNBcv76PG3
         VKVW2hDUXmw/+Q1JHgqUL1Uy8jnA1dL0RWSA9Ss/UFFAmOvD0b6it/Yc3FXIxoA5+hZ5
         H5KSat7xyYQQ+6tHt00CexmB3azBzcPyGeXfKUwIKmd7nKBOwScnTDtG4osQsIaGxvqQ
         CJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269517; x=1793874317;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtSElUmkgSMBmtpp69kzqh/LAyhlzAFVWeVHo7DNDyY=;
        b=oYqpuz1ZBk9Jbq7Yi5A3/s6mrCCisqHIxqbAs0xLk3cA8n194sCrlmDeJSqbCt16yf
         boXooH8ommAYpPjLVbWfP+tKrWV8kXmwqxvvrFqAI84gN5GzgZcavg73DfOYV6NJPZF1
         tbM+6FYJSg9RFsFvgGBVy6cBSxltBLxkpeCs+6jeXKTMM6f16P4X1Guricf0bbBrZAYF
         ZNW9la2YwIrk2NN8u/k+LNk265ZjbfaFiw6dLZoX0tUvDUSI+obgDW6E56daaDcd3B9E
         fDovpMEWTOw7s74KaNO9zIXZW1Odb6eh9eI3cHijRcIwbu7Y45Q5FKVYaoPZAeVS0/zn
         8JmA==
X-Forwarded-Encrypted: i=1; AKwUvBzCB4+2i4yI5+LGKtpdC5ENncEMJZqjOiikMrzvWhckpYwtF16+CUt1VbzNxsDGYD3s8SML1Rs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxvdIGFBowEfncowYKg/ex15SyuTqB8qS1eFW6afLZjHxrZm73
	QpLdJ0ATCpm4+0VkFdY/jr4LZddUrwvEVa+5ho+dGYFRv6+E4IAbS4k=
X-Gm-Gg: AYBFou3DyL4g4c3W8PwdjlP1SIL0CNWdXNnOWhwjfT8B9ta+QCC4Wjv+FP5UbrprgCx
	Tg7LazC63OA0w7thVGeVV/FVcPVAFfQxjtIQ4gjbSYCg0+UpYhkycG6OK6S435nCVEYjjEfLVeA
	V5gaC9xbOGLzRc43e+OPB/a6gOhy3kM2Y/kLafka6eyqpOiaREadK9gPy2WHdKi6pqoPH0kPkYx
	RuTKlEHSh0iXm/QmeFwk5e8QAsnT2n3YkM/NFAElc+2b+UPGW1m2MaHEvir8kNsLx2+L06WM7hq
	xsyo29jUBnSyCAtLZiyZiuWMGp7lw2YJ3ikrAW8RyJ5Qm5aQ7VXF4sA7Spb2tpyUyNMRPh1e18Q
	fIesVrQF1fS5hJsl2VbWjAqE2PbEDYubwQfjV5EjF2CRpS4Stl4rVGrABMLGhbJAuhPlKCe+ibK
	gV2UmrTc0APSYJoCfCIB3KK6VDK0/cgf1MSDG7DJt9NVlof1VWGtQxWsGxnmL3jInRi8ckiPicH
	ZiNAV7xaphlNck7tV598DYBo1wKSdcEtvMhHjz0IBJX0vl8yFpiXYFSKV3Zk1pFEb/jF85zcA==
X-Received: by 2002:a05:600c:1391:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a966c41a4emr112142115e9.9.1793269517096;
        Thu, 29 Oct 2026 03:25:17 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd49afsm34041196f8f.35.2026.10.29.03.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:25:16 -0700 (PDT)
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
Subject: [PATCH v9] ASoC: wm8994: drain delayed works on remove and probe error
Date: Thu, 29 Oct 2026 10:25:15 +0000
Message-ID: <20261029102515.3417777-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026112212.2519775-1-tristmd@gmail.com>
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

Fixes: 99af79dff5a6 ("ASoC: wm8994: Ensure we get a notification on startup for jackdet")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes since v8 [4/4]:
- Guard cancel_delayed_work_sync(&wm8994->mic_work) with type check
  (WM8994 || WM1811), as mic_work is only initialized in those code
  paths — addresses Mark Brown review comment
- Add cleanup to probe error path (err_irq label), not just remove

 sound/soc/codecs/wm8994.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index fc9894975a1d5..30a164796fd48 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4563,6 +4563,11 @@ static int wm8994_component_probe(struct snd_soc_component *component)
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, component);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, component);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, component);
+	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
+	cancel_delayed_work_sync(&wm8994->mic_complete_work);
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->open_circuit_work);
 
 	return ret;
 }
@@ -4604,6 +4609,11 @@ static void wm8994_component_remove(struct snd_soc_component *component)
 			free_irq(wm8994->micdet_irq, wm8994);
 		break;
 	}
+	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
+	cancel_delayed_work_sync(&wm8994->mic_complete_work);
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->open_circuit_work);
 	release_firmware(wm8994->mbc);
 	release_firmware(wm8994->mbc_vss);
 	release_firmware(wm8994->enh_eq);
-- 
2.47.3

