Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158255;
	b=5MWaZof1QTxkAKWoGpTpK8l9M6CaRhpaEu3kaJonVbUhrr86hgmlwp2Pf10WrK1WgCdO
	 /gMXlTeLsfUQF4E/WS0yv/AY/Z8wODEw7C0cDTSA63lA+8ZwD4qklB3WPkNFZ9Nf+7347
	 t7haEnRMwK2iErmWKHvdRV3RuprHToZCQObc8PYeDUy5sDYqvZNpVFjGYIc9iD2ohLKnL
	 aImLhVJK2AH0mjf6E0SgDE2LotfDDaBzOvzF+8QGrqXG/Ec1jBouxcSt4/+rZ3XW6LFuJ
	 1hOXaMfucAcb2jUMtxTR9FVsac9mlLVDVYDxFv+aXtfTjix0ABL16/y6XRtfww1lOMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xrZCsGFBJGE8YTdUW/NXxb7L9++8m8GQvAjnd7WRUIM=;
	b=r4YxsUg5LSybY/R4YwW62LKxXqOw4C6QTrezhbY1TqsmUjufaHdl0nvfB8y5F3VpsX8o
	 czcxoMNLqx3EN9JkTrSuz67D2H8LrYBZ6QomHdthCOQyoeIUdRABfPNJ0mRyIJyBp8L+W
	 6TIiZLb1J0E7TMXjBj8Yx/14Jv+ydKZiyYJo+ffZ5LuO9HSUJTW//qT9s6RFeGkayzGTy
	 KcO1LinPS4S3Da9L+bkqVaEZv0pepOBgqgRJLwyx7aMohbJjh7PQtcn2pmf/4YxdakGIp
	 d7hZwL0nQmQwY4Hxv/O98YVAS63hjS8Aq/BjS+2Rk+6AlKverFnibsRozl/06Ls4zLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sNb13mES;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89CB606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 17:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D89CB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sNb13mES
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-170135e43c7so258632c88.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 09:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794158254; x=1794763054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xrZCsGFBJGE8YTdUW/NXxb7L9++8m8GQvAjnd7WRUIM=;
        b=sNb13mES/0f5ALwDbw037sVMGFFC0HaA8P4+YFzDQeOJ9X+bYg58bAe6mzpznfMO/O
         N3GTYiFjgrsMlyZgqiDrzrP98P1TNa/lnt/pEKOq/kZQAWzRhrUaQRxNRuELAip+Cplh
         AFyFh0UZlkcs3++yk+c5i2fwiZcw47AsEKeQnNTd8lPThdwwl5hg7CdO/N9YM996ZgeB
         ZLtv2NUqiHBNXgnesgmnkfp/z2WbZAKoDQCINcD9l3tSN9CmrEKzHrl5Jl6JnC/kFuOu
         qTefALObcsdqTqhhlvNZZRCaFBmmuKh3mamo3V1V/DHLAMrGUODC6PNXXdiEbxOds5eg
         Sekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794158254; x=1794763054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xrZCsGFBJGE8YTdUW/NXxb7L9++8m8GQvAjnd7WRUIM=;
        b=opzwLxEett1aLssk5zukWU3RVCKHdy1n5tmE/qrab1QniLlfM4qF8xhMAcvWv6bIiT
         njTsZGN7BtWkF2JGIRykEG1skRA/6uBzYr3wIbZX+WNQ0l4BwuPG/hRKPJYSC9mu2Zgh
         qV2whYiRay6iiRpGI0+JPN8irmiOYmDMpV2a9H3T/9j9Z/PNY8CyWfyXVM9gOEPB0rEs
         0Z4FNB5Mhy2sWhzGw50BclU+De+8gQ9uRM4DoZooOi0NC9SFufU4LXYt42N6T9+dnfxY
         GlqfNBnYaGXoU0P0UdFhAX7djMTzFrEY7B6hGyMPKZ+VNzww10lpUc0GJyAk+/fQyzXo
         W3WQ==
X-Forwarded-Encrypted: i=1; AL+hErFycKMJUZDTwLw87rEpUXeKUQg/YngsipFUMGegALuxClRDONG9dMhqcuzcI0BL675XMW556IM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YDoMgFbCDsKYvqK+/KIjYnmjLsjCZwPo8dr9HQkcTvaGM9241
	xCV+9mxkoazX/1bKJF5BchDVMDGFd4TG7E2WrSdibXEZo3V9/WD3pS79
X-Gm-Gg: AYBFou0nT7Le0obzRpRw33RuCVaphE3sm4lXuOmN5QtmZySK/NHJRbRZXKQ2Lh0EUed
	8VoWCEh33fXx1ftg8gGhI62eXCHUeeuIDb6baPhZQoi2QFlcEiIbh3jSr3W1hR2TUtJvETmYAE4
	g/rOxiRsargyEVxJ/oqQKZnXlMzOt/ZGyAvxzkJlHxbH0Wbk+uPjEGlc3Ozda0utBT628k7a9hl
	2iK7SSZWd2AanU1PI8gzUrTuTa+Fzuw43ixoMogDXYj4I93gM8EGTD46sUIuIhTjFfL46XKR/8m
	qyEIkrCCaSObh/SZI/+yvudpsiKECallq62ygHjaLBqwQ7HPsKjhxfxPc5x3Ee0iPCqe4n49a4P
	oWjza7eUyxIIbU9+4b1BfJqQe+ln+gbsZsKAW0Xe90yXlWe8ykiiHuwv2S2hMaQFQ5ROvhMDdW5
	/l+PGuYBJ032SttwudChnA0GtOCzKKM8MsCHevHrco1bNGhaPQ830qpBF4PeBHR6Cc8HwHEH2Yw
	L81oYUt6dxb7vh1k9KpbvR2AgDgUmG22FTKxVR3uCjPbRag5J/x5I1DEszWr2rfHl/wNm30f14w
	347ru+TENNTNzrItY5hIUQXTRC6aAchbfGkC02y2HeQO0bc0
X-Received: by 2002:a05:7023:a42:b0:195:1a77:85f4 with SMTP id a92af1059eb24-1b39feefaa6mr2960462c88.24.1794158253619;
        Sun, 08 Nov 2026 09:17:33 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372665db8bbsm5983442eec.22.2026.11.08.09.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 09:17:33 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] ASoC: twl6040: cancel jack-detect work on component remove
Date: Mon,  9 Nov 2026 02:17:22 +0900
Message-ID: <20261108171722.695360-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

twl6040_remove() frees the plug IRQ but does not drain the delayed
jack-detect work (hs_jack.work, twl6040_accessory_work) that the IRQ arms.
hs_jack lives in the devm-allocated twl6040_data, so a work still pending
at remove runs after the private data is freed -- a use-after-free.

Cancel it after free_irq(), which stops the work from being re-armed.

Fixes: a2d2362edf9f ("ASoC: twl6040: Add jack support for headset and handset")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v2: Rebase onto current ASoC (did not apply, per Mark's note); trim the
    commit message to the essentials.
 sound/soc/codecs/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 650836f..826bde1 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1136,6 +1136,7 @@ static void twl6040_remove(struct snd_soc_component *component)
 	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	free_irq(priv->plug_irq, component);
+	cancel_delayed_work_sync(&priv->hs_jack.work);
 }
 
 static const struct snd_soc_component_driver soc_component_dev_twl6040 = {
-- 
2.43.0

