Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199362;
	b=nUeJ5RRhw+xqMmlQQ/ZjKud0Yqrb0l5rlWJb3IreXlUhM9l0SFwNpOUG2jGAGtySy+I2
	 bTg2sVBsz5TdMq7IxPyd8pGGWCeM4Q/XzdoWaxOG55jKts5SRpcOzRk6VtwEifyr7Rw1p
	 BnAPvmDhRVqtEpGgnxWJb4GXh8tfeIQ/XlGTNtZPz44hjAaCPEPYY7dzHE+eGkvBRRCuV
	 vsb6T8hcGzUvYwOt1tYTwqXfQbedXxXS+cekCv9Q6mbvfg3sXXcsYKs18uvheco+TOqBg
	 BJDlIEtZ6OBPhta0iZM3LUYRMQIq/9NQENzURlyHtlugUJpktiSrir0is3j7gJgxb2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GcfSxz5aPzlv2aH/G/YIDcSJdDCU+Fm7JWkQ7b1zh2Q=;
	b=zNJWYM392vg8fWm2WB8RsKwtUpKqHQvQJMk2w0mja4LLubIDUBcinlSZrpFzPkw7hW9z
	 R/KjyxUEUWUpEU8fUB7+MHe8o7JlQpn/47AoQnJucOHbLAgKVDmjUiyuNrrYUFMz9UQIL
	 QSoF6/hX91+qbkte93A0Cjng4oHjZRZ5yQSE/iAzDoOwqMde1chCmRuCleD4DZJHimMsR
	 5PAcJs7UMuNj4uJMh0VhkQMrljdzEuPaXRZw8FJCxXdm14DzigCdahnicIU5ZNBhA7DYG
	 gnu+6aMNXu9xIFUAXZCiGpMBxu7BFvhS/LgyglO8NlhzZij7zxq4+JZLwUwcEqfhirA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PqESUav5;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAE606A32A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 04:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15BAE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PqESUav5
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so1185369eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 20:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199361; x=1794804161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GcfSxz5aPzlv2aH/G/YIDcSJdDCU+Fm7JWkQ7b1zh2Q=;
        b=PqESUav5JLJfB7GFHFz4pi6OqzbIh2Lvb5yh1tDk8V+bR7Ts/QMMBHdwae7EREGtit
         JWNMDiD2JgjyyvBKcxNAKe+0Z5jYqbKUfgozwI2As473RcWJ8wGjpw/mGCrUgzllpHnQ
         f0CMCtUl/7r0kP5jQ88Mf9qyV/ay3eKbfqIQ2lerbKUVE2BFFnbpgj6TGuDrsQHXO1mt
         KGVmWw8dhlgjzrJ3GVoC+rm7OMXaNXcsZL6WDiGhvegrkDxpBQD4tbjbH+tkGPipqdJ5
         X/U8YFOeulDeDbmHBGVsNKi2sqiozYmrShupL0LnNkFu49a2kkyQaU/qCrPab0lCXZA7
         bX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199361; x=1794804161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GcfSxz5aPzlv2aH/G/YIDcSJdDCU+Fm7JWkQ7b1zh2Q=;
        b=PfXYhtBfnFkco+BsBrpWDJB5T9D/toibfX7S4iH2sNouRn8/3dT/q0JOMcF8qXzMQy
         95Lqe4EEnXfj066zK31qv+7Kq/HoSZuWjuCIgc8B+2nO2rHSIPyIxZII4Kb5ansxXAMG
         f3tWB874eXfPSuQGaxP0GlXtWMOz/oz2t9rAALM85dn42iwSb3icogxfG1xHFo1V31dp
         B0lDW/yeXBaXAky6HXvgE4PGdrvObT3I8zoKQqNcwCjRGWprAq4RvBhy2gwsm7D9gJ6U
         1pkE8f6vyi7K1qvVIwkXABGaW6LIDWuy87svrYG/6ezbL0q4+qCKWCzRqBIc7dR8IgoP
         yL+w==
X-Forwarded-Encrypted: i=1; AL+hErFK4kFCZuhrYRMxDTNoKNEpIIR/5aaR8fpHcIHAUEhP+ZnbGv3EpHvzTdjApEMCEZbnjF6NHtE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RZuXJzHhL8U6XSZuEan6rWjK4ipYkyymXVomUGNE+p3M6islw
	VU/x0S1PDfXmXXS+Bee0AQ4KSBfPcBnFpc+TvX+Ml3fb+Cz+v7qCHnKt
X-Gm-Gg: AYBFou2Ik/67YeOzGzAJMyF9VetWENF2tu1fxQPue6Tg8agEc293VVFkvBM9zR0yV8Z
	Q+7Osl3AqJFQX0l4BWs/x3/ZOy/3Of/qlwakYUUUKs2f66/5DUOIMvfybwTnuNRnIWITxIhjUnM
	D1hYAKgx+YFJJxBijKKuh1cvxVevmskixbzgNAqG218ctPINE5nheyZeQnhKmU81Zg/rIlufKsO
	sywpCfmDST0ZadOiqStAb3/d3aWdVqqkG8n/F8ptXK48zbG+Zat9FADcLI9Y+pgp1gAW9ckSDQM
	SB4LSweOJoEXIW2svuqqMQlDbQa5fPpiBrz1Kl1nqQty0ApimiIoTRpmqBLSGuZ4hvnVRNuLKEr
	cXWUPwpkiMGT9JQc/Wvf6rJtuTNTIgIbWzrrKR4GOsuvP3ELCAvLM+9uGyHCQD47xizHhZD1LDN
	+J18XZTru/qnmvmOf7O8unCsZPml0E93soTFCqcH0UH3pFJ0T5bWq0SfRozsRPof09hqw6+g6yt
	P7RFkQSwdDt3g5au1HzJQaosZiPVf7Ypi0a4pgg1+vp3NQcNPxV84D5HCCgaOw0xc5PID6j32HQ
	RDqotLqHjI1u5GkShGxOOU4UsenOvEV67L7xZSKpZdqsH4bo
X-Received: by 2002:a05:7300:1c0b:b0:366:2893:7421 with SMTP id 5a478bee46e88-3725d77d5a3mr5516181eec.10.1794199361082;
        Sun, 08 Nov 2026 20:42:41 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561851esm10154026eec.4.2026.11.08.20.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:42:40 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] power: supply: ltc2941: drain poll work before unregistering the supply
Date: Mon,  9 Nov 2026 13:42:10 +0900
Message-ID: <20261109044212.1157357-2-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109044212.1157357-1-hj351016@gmail.com>
References: <20261109044212.1157357-1-hj351016@gmail.com>
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

ltc294x_i2c_probe() registers the poll work for devm cancellation before
devm_power_supply_register(). devres unwinds in reverse, so on unbind the
power supply is freed first and the work cancelled last. ltc294x_work()
re-queues itself and calls power_supply_changed(info->supply), so a poll
instance running in that window dereferences the freed supply.

Register the work cancellation after the power supply so devres drains it
first. Nothing queues the work before the schedule_delayed_work() that
follows, so the move is safe.

Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 6ebb555..8f8a8f6 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -531,11 +531,6 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 
 	psy_cfg.drv_data = info;
 
-	ret = devm_delayed_work_autocancel(&client->dev, &info->work,
-					   ltc294x_work);
-	if (ret)
-		return ret;
-
 	ret = ltc294x_reset(info, prescaler_exp);
 	if (ret < 0)
 		return dev_err_probe(&client->dev, ret,
@@ -547,6 +542,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(info->supply),
 			"failed to register ltc2941\n");
 
+	ret = devm_delayed_work_autocancel(&client->dev, &info->work,
+					   ltc294x_work);
+	if (ret)
+		return ret;
+
 	schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
 
 	return 0;
-- 
2.43.0

-- 
2.43.0

