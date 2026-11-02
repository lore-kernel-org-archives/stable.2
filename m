Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638434;
	b=d99YSRrOGXp9+DiWj8dw+Uuih5okc+3XY7ZkfFh7McX+pomTWhs5/DnfQaqlcf+y87pG
	 UsGL3cI/D5UkYMS6SmoenO3VudHyU3wJ635YxbNfpHGRaS2y1qxaHBrb8ZINtBvBEJapA
	 +IS1yjDgXu3JdJaNgHadOHd4Lh5ZgjgowGIMHQLxWY2N1ewaN7T8GhffNQW7PeQe4pktv
	 p8BSaO7KIDYzh8CLhbPmCrOO94Wdpo4RFZPyvnD7nm6KStY4odO4XxfxEHtvH/KnJfckU
	 qg3VTYY2tmgHZ1fX0OODfTn21s7InSiTkSELSsw7fWEGkvSJ6efGFVJiJl4ckBhz5Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6P4yu7uY1XHER0rpA+7RszULXr82chqbIS0XERr58wE=;
	b=Gg1lkGUPMYv0cst2bYcbLkiHfp0K9yZi2Ci8P8xBFtoGAypVybkau5v7hKZR82Bn4U8M
	 tjsVct2lAKiJCmWAPHSGevmSINp+Gt8loZsGvEgTx9n0mm3SsEqe2uX7Bs1NyDOdl1MJ4
	 ngLFKGsdsmWZPBN42HX7dEdqLuVNVBO4YbJDBFUNyG/6/orB5frY8fgAUSnTTaKZJnpgC
	 I6kLUzg3nwMWLminIhj/iy+TSYDTZm+9Mq0ZpQGj245Ut/JrtltWk+DgJqhLeTzeZGFpT
	 ttaw8hmfzeDC7wDbSLBPUVyWP2sHmot0Jj6ak1q958zN411+7u6i6+vmPZqCl8e6SeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWyRE4g7;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3F6079930
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0B3F6079930
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWyRE4g7
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48df8fe8513so2796962f8f.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638432; x=1794243232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6P4yu7uY1XHER0rpA+7RszULXr82chqbIS0XERr58wE=;
        b=lWyRE4g7MbcJRQSiaYnWMAmAuyAnyx/GKHZArn2tjAiM3GzrvoRlTxM7e5TRa4Z7Ua
         BDFqZCmdiyoUVa90o4mRx77A0KzOovn3vqutBnD/62HMDst3YvjH/jBYcWjBQCYOlXuY
         JrdEHXaFqMPlceLcz3vsAc8QVWl+mtJ83ZtH5G8YifLOJLXAncAC3zi9zpz2PFmudjjM
         M1i+5w/nnzj49wYGiyB4Cb6b2OaZzwVN3PK/0nLRo941gW5K5dJ7aC6LT6Qq2Gx7L2aC
         R79KLyzJuim3LXD0tHtXbYgsk2B+Yerh05QdxBnyVp8XjsDGyMJWmI+w4RFHhX8hqmwF
         qJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638432; x=1794243232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6P4yu7uY1XHER0rpA+7RszULXr82chqbIS0XERr58wE=;
        b=iGGBEyIDx2WBVFShT3Ik+bs8rjMc7xpIV5M8PslhXZ8H3q42VVBNBpbi4/LRkD/tri
         VtdrNa7l8e+26f67jjJfxu1k37jpicDghqL2XDV7dszrkCaz+Ti1E065W+1y4OnKQwFm
         QJuL1p7SOWMMpy8NnJl48aGSPlq/3aGhdydHsJn7kOxr4kulNe3xOnu0cm59s8lZ1/2O
         CghIWosP36ucsdudnoGsOyeS+W4KaJi3cuKz/l7WoXN/aOxiITCcUe/WnI5KPafF0SQg
         2jyI6RyArycLtM1wCWABKeILqObZ01KdlO9GxVwD3SSrpG7gbMFFA5XHB0EA0nB9iArW
         fMPw==
X-Forwarded-Encrypted: i=1; AKwUvByE1VBwqRVyU0zo3FQjgy2oYSWwY8w2o5MzbzQf+fgGW7Bl+4aKxsD8agYVMVP+/lZuBinePJ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Bdcde0zRxJUR0LgL0yu9Aqt5dW4bt5CPTB2a1+o3uZd2odM9u
	gF/QWhl3RqABkcG+uaQG13HQb+RRF+hAQmRGxK4M37KYG1FxkvXN2zk=
X-Gm-Gg: AYBFou1baJeCSSjwvXUgf3c/zMOCa/CXt6+8VlkV9xrxRY14R2wayT51COMe3YTL9HU
	mebeSgPBLMauIe6fVfhJC0tvA5Po/ZtLLllCJOK5BI3FZ1xYTRMR1sJaYH04iw+SzR84QgqEUW4
	B+cyq2G1l2sRaB21ovw52uTpQvJwDModNBWkkwy0PONllj2zAzgNmNj/MgBxwk8wC34i4eln6L7
	9wb6zBKnTFWVkFIt20HkMf1QtWWJIK2kL7+qmrUoyrxrfn3UrDgf7vTLCsUrlYqvr3X39mz0HKt
	SBXTZIWIG6Rf6nHJlELtvS0FpUgA+uzPGsWKq5H0J9h2UrmZDVVXFkPcFeOgwlO56GvuqP+dPY9
	ZwjTA3yvsMYcYNk/bRMhd3p+bfZw4OVQ71e6y8mxgeAobASvfyJkF3FoBmUXagwhJY7hoD5DLvI
	T6dqZ++mPF92N7dZ1YioYqlZaEawqzX00pvyn+yRFTnhZUud+ykN5ZRQibZfHZs0sWrP/Yt9gmV
	PQIgD+wQWfzGCTk6/Tzd2U38jJec6R+U3dt/4WHqF05u+HDU9AYOwYu6wkb/x6uX3EqfaPCRA==
X-Received: by 2002:a5d:588e:0:b0:48e:6652:fdc9 with SMTP id ffacd0b85a97d-48e6e4f54f1mr22387436f8f.17.1793638431954;
        Mon, 02 Nov 2026 08:53:51 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8e5f4sm21479385f8f.40.2026.11.02.08.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:53:50 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Bard Liao <bardliao@realtek.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jorge Eduardo Candelaria <jorge.candelaria@ti.com>,
	Margarita Olaya Cabrera <magi.olaya@ti.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH v6 4/4] ASoC: wm8994: drain delayed works on remove and probe error
Date: Mon,  2 Nov 2026 16:53:40 +0000
Message-ID: <20261102165340.1558853-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102165340.1558853-1-tristmd@gmail.com>
References: <20261102165340.1558853-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

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
Changes in v6:
- Add comments clarifying why mic_work is cancelled twice, per
  Charles Keepax review.  No functional change.

 sound/soc/codecs/wm8994.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 6b91e02f130b3..6a790479c8a7e 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4595,6 +4595,14 @@ static int wm8994_component_probe(struct snd_soc_component *component)
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, component);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, component);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, component);
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
+	/* Catch mic_work re-armed by jackdet_bootstrap running concurrently. */
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->mic_complete_work);
+	cancel_delayed_work_sync(&wm8994->open_circuit_work);
 
 	return ret;
 }
@@ -4636,6 +4644,14 @@ static void wm8994_component_remove(struct snd_soc_component *component)
 			free_irq(wm8994->micdet_irq, wm8994);
 		break;
 	}
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
+	/* Catch mic_work re-armed by jackdet_bootstrap running concurrently. */
+	if (control->type == WM8994 || control->type == WM1811)
+		cancel_delayed_work_sync(&wm8994->mic_work);
+	cancel_delayed_work_sync(&wm8994->mic_complete_work);
+	cancel_delayed_work_sync(&wm8994->open_circuit_work);
 	release_firmware(wm8994->mbc);
 	release_firmware(wm8994->mbc_vss);
 	release_firmware(wm8994->enh_eq);
-- 
2.47.3

