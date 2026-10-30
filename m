Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374930;
	b=re7NDq/gMZYKntFAztLxX5+CT/muCYQQAUZqSMY+ovtUDYkhgciDdTUPrAOzEjevKO0r
	 YDao7VG6uXbggDjfK8b4rI9G6TA6bo0uO0jDLwSIviAd9AGnbiCyImMRq2T5w/TLt4l01
	 4Sz0ENzVzp299xddh8Ay3oOoxpAbKFushgv9CNpcMUMt96XoUqWKBw8XJ8Yk5MyZT6iwL
	 CmNaMBAbNRFSbu49i1hGeuss3I2qki57/7aziA9GBeTnzynrj5c/B+obk6E3v4U05oRfn
	 ir5Rn1J1vTn9OrsXJtGrFbMq4q2pOGMxqHK7jhFl+dqOHM/Z11VMLdQkOViUKwZuKQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2chJiSmeM/KHh0ZbqVdM0zVWtYPHgi3wnKH/o05KMYU=;
	b=f4vTaNm6td5Y85VGSBjJhkoZRJdimYvwPxXhR4JPGS3+Nw5w0Qaz9EzWOiX7kuJLD7t4
	 P0UC6nbQUeLLIF4bVpxhmBXdvtGJgwVY1eaNediQjkF6bNrabJz2/dyJ1jlfa4ysO2XdR
	 nXTIdIbgQY6Oy5WLG0yxWY9/lldV9Ornm61fpSVeF47GZULRB52RyNYpf4uf4b1oH72O5
	 gHc0Ranz2kt8esoozMpVtCbra9ZMYuwSrDQKExg9UAEHlIi9XA5mk+UixZjJZ2H5InFAL
	 WaQk6gg+mHjKVtRi+jLLN4EefTD544oASxMHUETots+M/QtrROwVH53ILbwmWw/gV9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QCNiLo/b";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D672606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D672606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QCNiLo/b
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a7992e2f7dso9066105e9.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374929; x=1793979729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2chJiSmeM/KHh0ZbqVdM0zVWtYPHgi3wnKH/o05KMYU=;
        b=QCNiLo/b9Ovh4wyt4IeJSLMrw/6R57uC95QRYqdDCPGzdog+dsas4/Hqr8CtQalpWH
         FRo2ZblFfijeN0G7REGTrKlgCvOvpkd/zVSePu/G4qC4knLNCVlnQzvjh88SDpgWLkRK
         lZZCAdp3WsrptS0kt+f5Sn/sb5noMuJ6OBWDtz2pa15rGhnVkLruyDIdb9RDpAzGCLIW
         HytaufkZurmQjt2+WpV6zLUxEWwvAEjmNj+6TgDTIqn1jyLSiraZXOAWHJRcDN6rM3Ve
         a25ke2ROHnZgj2qeg2Sxd8K85JNI28UTQCIqjUXZn3XTNMSmcmrRWSfti8H5nq2Z8rvK
         4WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374929; x=1793979729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2chJiSmeM/KHh0ZbqVdM0zVWtYPHgi3wnKH/o05KMYU=;
        b=tR43RMWzfTCdBWIul6OmRcbYeCQ5eTGNjs/xA7UGWjdBTbe7f62mGYQ0KjtA54EqLl
         61jkU8eXr6Extpn7rwmWHbxkHSflC/5/OH/qRZ4HnJrfYcAfxWxaZiZf7USlJEruEx9b
         lPkuIdyBCOBKOZjY74ozYq2DH1oPdhu4jQAkLBRYo5uiKPBPmWXcTzbMq0PihVQVLwNB
         3tbZCf22E66RtXdmb6CHNrF//BTCaCaak5o6I4ZhiWbxi/egiNXL1IPWrneIfvWisLf8
         Ra3K4IPYcNc8AnbqmlL2GEoWH7z76SHSua7nFmKlZqQSo3ywz8mRN+GN0KNuVI/TMSzg
         gytQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpXke+ttmkz851Wgp9hsyaDpzJ03aEepZAcLH10k+srKmSvhDz+tqYN0F0ci1U72Dou0KRa3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYI73yg7xrfo5qWNaSkVCHnQjGVIXnhMrxRi+H+z1JzYfX5XnAzm
	WqVFct/EA7U5xTIvf3xsy+qCtKrqRTRORPwJAT1eg1mJj4aga3qyoNE=
X-Gm-Gg: AYBFou2kxi5g0JDXR7SAS98bc32/WN2gTPfBJFcdak+BnD+0btTCDxj0PZcyw5+WRJN
	fA162zkhaRASZzVxwumETK3G9LX1MnZ8uSZzBaHk8tvCPNL2tSOrtPQk+mLjI3lipG3Hdi+Z8d0
	yiWG2C7tqEnsDq9wApe6uoYFrMJK9txZD/RFJ4SlX/JVqEl1cK77lWYum7OYiydbUObQxtxJXUk
	ZrCEcGF2eAVLo0QwPaZSN404uyzp48gWb+Ys/h94RkwNL6Ox/aa0RMF35DrUtPj/9JEtOBlu5IA
	gi+q2w/SF3WPWMtnnz5Zsu7+jbvqM+9NzfvnxyE04eO5OrxG4VP06ndXtoDC4EpUwa8SytU+vCK
	JlOBD9xD+Qc5a2skpnHgD99LZrMhzSYqi7zek5f44aQ8u3Rp+OIpO+pjI5WHfJ+iKZi1pv1dRTt
	VYtewtolVKFzZAV82k7mRx3M+XxzX7HzYeGACI5t59I/ZUE75L5i4/ludDsx8n9kbmlAIZWsvl5
	tYKzUQ0ftPcie5duHRzO/gzBBQNAyvPBtdpoa2Hvib4oahjD+3ClAYaVYDrDoqCv/rB7gqoTtE3
	YxgO+5QfqAY=
X-Received: by 2002:a05:600c:609a:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4ac1709aa77mr55928965e9.16.1793374928702;
        Fri, 30 Oct 2026 08:42:08 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f047bfsm144419935e9.3.2026.10.30.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:42:08 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 4/4] ASoC: wm8994: drain delayed works on remove and probe error
Date: Fri, 30 Oct 2026 15:42:02 +0000
Message-ID: <20261030154202.2989936-5-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030154202.2989936-1-tristan@talencesecurity.com>
References: <20261030154202.2989936-1-tristan@talencesecurity.com>
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

Changes in v3:
  - No code change from v2

Changes in v2:
  - Resend as part of unified series
  - Cancel mic_work before and after jackdet_bootstrap for cyclic re-arm
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

