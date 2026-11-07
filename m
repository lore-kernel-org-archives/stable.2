Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061220;
	b=3hVDitHPgjYswjt/744RgojNDdkHi5MicYywFZe26HuFLeMP9Nef/mA4STWXDCC35IJq
	 dyRROQHnPS+vrt0scbxWslsZxDwKlt/Da6cq7E9i9MyDvEuba9Y73a+/+gNwgTltgDMKN
	 HkcPzT0o2dJoxXaOo5vpAu5AisfnjxEkBmRljuYGbhUuLzOg5P6vsCx27H32+P3zbN2VU
	 zsuz/W3MTJIjDPvIQsQ29oz+vlk/nZys+LIg23Ab4anzwzwfwe9k5XioJSCpYq47jPhmh
	 jDe13NSGo8ABERnrOtkvQqyjhS/zGmm9Sn7TbPRbS+ndHFWJW/CS+tGj8YbM3CNJaGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Nq7TMgdP67AQJEH8b+kZWGdLv4SVRS2B3Pui2dDDqM8=;
	b=C8lShMwTSEn0BYWHw43i+G7WU+9GuL3SOxXZ20CF7N2JrCT4MQ3ef2hzxu8ZyjUAEWnv
	 k68Lp7woV/Jg+qmQJRKe0WQqAiQfjCDdkJ0C5qxc/Rp0C5rRMKoZjOrSxaM2F/aOlpC24
	 3AxsEfhlsVkpX6y065YyTOMHK7YL1mKgkfQ2y/KbuRM5gNVT4cT87uFenBh+HoVPV9pCy
	 GvTc7wNFOoRzLD8xj2zvOdIE1HVYJ9qqimrKvV8pKlESLapXzWgcsBx/fYBoyNg9zpO5m
	 Iuv1a+dWPiWUNf21ADPUyJaHdaGVqyl33zj3Rl7mFxCJ8eSW5z15f5aGgaCF2LoFOag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TUT02lU/";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10297606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10297606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TUT02lU/
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2569895eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061219; x=1794666019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nq7TMgdP67AQJEH8b+kZWGdLv4SVRS2B3Pui2dDDqM8=;
        b=TUT02lU/jlFCsnVOhUhT1N8m20Y35Z/eHxf9abrzTZo/VbEolQzmTQ1NyySvYShKST
         qDkW4MslSeAxqdfKUCxB5x9bfeszVmSa8xeNMAIi5jYAYkyWhsBt/ZmhKodeE2UYMWkj
         Pvgoc8ClyIDxNZ7HXXxS1OjnxD07Qk9mRV3+L8xPKu3h3XHcL/QaHVrS+HYHou7O8D0F
         wV2F9p87PoNrS/DXeeqe6cRmiBBHWuLTbr0ZXGfLqJRR85W/4zRogGPxEGi4/fa3MGQl
         dSyTaUnYo80o1EsVy4T2k1SK2Fp9GwnOSe4PIdEfiSGgAvLEJiUQ/8ItEdoZuVcuaTZB
         ZhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061219; x=1794666019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nq7TMgdP67AQJEH8b+kZWGdLv4SVRS2B3Pui2dDDqM8=;
        b=UDwi9OfvctR1H8bu/klHnJrsA3yL+F7tSSdzPfEMvWJySvzclR/48tS26EBwIvQPp1
         4FX1k4NBYZmEwvf2o3Ak4FdBF7jakp98FKb97IxqbLV5IaT7eqTUmzyW0NDNgBh3M0Yt
         auOlIa4DVlODRmFuyXnnolrw9B+yH7Kp2o5n/E5N8zqDtCJtk/03pU2iLqHb1mOLEPl3
         26bSpuk6uIifklIW4j/BWq7RoK1LUloSS11dVWn0HHa1yotn1//TVdkzKR+FHwUW9Pb/
         XqYSfU0rD32+Twf53SZzdptv3dYwI6anXL9U371qxP4l7en2xYOkx4N+o4jU1WQHnz+z
         mqhQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+fPp5j4lhgKJM38H7oZQ7/9/C0wg3XAQs87fCDXMUFfmehqpbz8FhdGygR4UgygynlwvnZP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z95//z11yv578ELy6V12aSBoCWwDGgUzQcAMd1o/GYZy4tipaz5
	2OEYdgqx6kHKWYThBHKzxA1Jj991/Dt6MDP4rJmRsrzbGmvZ7DssrtsG
X-Gm-Gg: AYBFou0Fjv2pOAk5SI8PeiyZB3PCJz7DfXzyCPF/iKcvn50tuBACipROy9sYTPXtGUu
	NJAEXt1KZKn01vMr1u4zKDgym/Gn/Pyj2Xxtn0HMcSL8K9v60iyFf6SnwjVR0BttGuJjj6Uqeq3
	NxvgyOeM0kWsjTx6TwVpBF0fygG32bDZEadWmt+5uHwgltOjcscFhh6DMLcfSY8gKkCEYeYZSwj
	uKwKF3AAd2uznqYDBLbdIVdFo7GgAbgrGdslQt55wqp0NfNVRJWUNUOP2gNGP4bDsXfvpaDFIg6
	Nea+C1wqzTDwPOTmUK/kECU5k8ZY1+hlVKpmI90XmJppbBTUZK4hUd93+mWxpw51Zm83hbJ8WLD
	xivDeME2+fWdkAbj2CEfCrM+RxKUjjDZXBxATnNRvbvFhww8ocD6e6uWkc1twyVetYG/CdfoQ0C
	b1T9OkNd1f2BqnVc83/e5nLRzBAiNTtMAp/Ka154LPR03C3BjnCWtOtmJi67mktsVjtIKqjW6oV
	yYkuPaR5BVcEZ+xM7bNz7+wbTUXgsRWWfvMOxBNL4CZfJZryFNqX6XXRf6hTDrkv6E8ychFHyEb
	1+AegodRNfDq57uHr8Pd8Thi7WMFDfYe2lw3oXOj9oCNhnFbi/H/rBzAJFTKYVlRolsSIcE=
X-Received: by 2002:a05:701b:2505:b0:185:fd0c:4585 with SMTP id a92af1059eb24-1b25d346ecbmr6821632c88.33.1794061218976;
        Sat, 07 Nov 2026 06:20:18 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4840f3sm25727366c88.5.2026.11.07.06.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:20:18 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: twl6040: cancel jack-detect work on component remove
Date: Sat,  7 Nov 2026 23:20:06 +0900
Message-ID: <20261107142006.3711973-1-hj351016@gmail.com>
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
jack-detect work that the IRQ arms, so the work can run after the
component and its devm-allocated private data have been freed.

The plug IRQ handler twl6040_audio_handler() queues hs_jack.work with a
200 ms delay, and the worker twl6040_accessory_work() dereferences the
component via container_of():

	struct twl6040_data *priv = container_of(work,
				struct twl6040_data, hs_jack.work.work);
	struct snd_soc_component *component = priv->component;
	...
	twl6040_hs_jack_report(component, hs_jack->jack, hs_jack->report);

priv is devm_kzalloc(component->dev) and is released by devres once
component removal completes. twl6040_remove() only calls
free_irq(priv->plug_irq, component); it does not cancel hs_jack.work. A
jack event that fires in the ~200 ms window before removal leaves the
delayed work queued; it then runs against the freed priv/component after
twl6040_remove() returns and devres frees priv (use-after-free).

Cancel the work after free_irq() (so the now-detached IRQ handler can no
longer re-arm it) in twl6040_remove().

Found by static analysis and code review; not tested on real hardware
(needs a TWL6040 audio codec with headset-detect wiring).

Fixes: a2d2362edf9f ("ASoC: twl6040: Add jack support for headset and handset")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
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

