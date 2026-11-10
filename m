Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289512;
	b=We/WR2FeKMY7yQ2xG9YHIMD/kWPUTRpp7MyP0RvGMwWTndJ2iImso/ZzMtdAvjwI1fMW
	 wiKxsZ0e/LojI6StTl48WVeC5PvJJkeajkM846DM8rH9Dh2XjQAjFqCfOoYQvjRnfTdGf
	 2uW4ZX/VpPrhYQZXxf7qauJZ/6J72QvpChHSOiMSSwKq/hpSmwsJynw8B4SdeFsrgVxKz
	 rb0y2Tl5oUfWItviob5gBCIezUHIVULwELObksvnwD+5iu+AKhyvhI84kKLbLmuOQoGFq
	 9JPR/DIOMuS63P6srxlbQEsOZoxZjnf3c/lakoPVMxI7YQdqloAxWE5OnbhBD/iVIRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Et+Zb5EdR7iyJthKkThJ4eFs29yWr3uUx0op6Z4LpU4=;
	b=F1pm3DwWUTh/MYRFqpcLEOPfirYSRQkYpl9b3VU2UkL+DiJg1OueezFUt8ZbpetP1ekP
	 70jgrOXWIAQ/IziSgdR0s3xzvbQmiH+Ip9zcZeDCpoKPdJteklfUF+GRt1h7Q1L1faPtb
	 2W2J8eJ4Cdy1tYViH60VNuq/OzVYxHZLWeodz6CAQgQhBMELM54sE4rpv6q32n7461TjX
	 oG3lhnINtM2aCWkWUHI9kK9YQrnaZ1TmERKNGVNopj5ZcRGDGn+CAGuRyTSGQWuxQ7HrN
	 WpUH7zwuzymD1JBdYPnZMJ4EK1Kqaat3XIC89tIvqdd8MvPCZMN0vVfKfSjAIR1Ia0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjxUazJX;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C6606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E3C6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjxUazJX
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36ff9c9da34so2826313eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 21:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794289511; x=1794894311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Et+Zb5EdR7iyJthKkThJ4eFs29yWr3uUx0op6Z4LpU4=;
        b=wjxUazJX3FsrAGCWTXLFOUZlYc92KL2tlO9GPsGNDKzm21dwnGGJFJTPdTkzrhE1Da
         O7yVhekIWNpO5UxKE4+PYt1sEetjA0Wbrl3Bkn69NBMIwjUCyi3SFnmZksThjK/imLqG
         L6kVu87FDOmftCamupWn0CnIAa4EhaSsQoOg5oEKHXbV626ag/XrZE+qiO5ANBEdzMYM
         Yz69Zsrcsk1kyL4hkgKvMMGMbxhswuNwgVxmfUyMoiZw0Io1erp0suJVBoO0QnsTiRmU
         o5Z5yjfjLkq+ZfMNxgJEarEQ2F6LamJjqCQsGwEvmArjyvaYcwLUb7qrA08ZJQtRdrKl
         svYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289511; x=1794894311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Et+Zb5EdR7iyJthKkThJ4eFs29yWr3uUx0op6Z4LpU4=;
        b=q0buBqz/7UA+RSdeAOxETl2xE8ChVfQy+hslETlb5yMbDzV9uXYPasRDJdJyHTWIU0
         7/Cz6h0M1vozjBY9egpvPk25NPOweC7sOV3XLrWxANGWvYNTtFZpc/tW8P1u1m0FV31z
         ADNCAa2mJMuo2e4n4eAWPR2L/OM9xf+I+U6AWAFHRH6ATCohjhTGPjYjKyTqZWUiiAGS
         vT8q9QKZ+mKGC0rOgqUxghV5kKgkMmZroJtvPYpIEHfLpJI5tz7lgaMK4amntMb9cZvE
         ysnQqx3l1N6RQBH6hY85OsRQrDbaEBDegAE0ohxHNilcx3+gZmawYoq/vjJxmZF6NzPa
         KG6Q==
X-Forwarded-Encrypted: i=1; AL+hErFay1jfTo7BSm/yVJ819dvhp+cDQMBrA4gBaZhKONQQknfGiVNye/tG+sYZlc4s3muLiWNzlTA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ydbc5qLbPlQtL7eL4PPiq4udCtDLbHYX5o1vBB9/jAIkqT7Oy
	ltho04COPyVH3BlYjDQKB4Fx/H49aYfTZGazi/8v66fowbteWp0tr6pL
X-Gm-Gg: AYBFou3e+2+qFUoygSqxwHgWmqe8iOTyAUOL/SvXgidr+VTNPytc8ukkTDTZyhj0QME
	xWZhESOhtyXEN/G1ojVyDlzG6vkudSxWrlehLg92UjRbZTz9OGdCx0QpjZcHz0Nw0f0XVyTxiho
	OEYkMjLN/CClA0V9YWzcoDo02J2hIyhBSCLNlFlhHTQoObcDFjwIEEGZBACqsWorJ1hzu9p0eAc
	hHhRnz2edc+wHT7P749cQUnKlhEhlsPOVCNqBaffwtXL0wf6X2wavVBb9C5gbOdsASh8neMkR8t
	Ft7zhQY609YqFkqfACZsZZag/z0nTsISsKX95c5TboD8JaDx8t5d+4HLXFSM1JOwWOOhnZuNHYG
	xNR/8VN6cggKIBVvIo3Wim/GeagjdE3qHnQiyauSGgn3O2JUiujh3TqdqXjihdp0Qp3GQZQgZUj
	BnKXkIqovvw06dT7EPNykcJ0qXTW7/OOiRGc/1K/UuHF97OW9MEyAtkNm0/UahudG76uaRTCAWf
	qgqgxDbUXsA8r2qSAhJMBF/+AZ4RjXE3Ld99P5KKtfysNotHmeuO6YQhN04NbP9ZXg05z9FlIF7
	RbdFB549hHwteYZl7ryykVKTw6H/HApmCNlavJhRmsQcdQ0x
X-Received: by 2002:a05:7022:1701:b0:1a8:9857:2102 with SMTP id a92af1059eb24-1b3b6185abamr1807080c88.30.1794289511064;
        Mon, 09 Nov 2026 21:45:11 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm3466120eec.0.2026.11.09.21.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:45:10 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] ASoC: ak4613: cancel dummy write work on component removal
Date: Tue, 10 Nov 2026 14:44:53 +0900
Message-ID: <20261110054453.2286414-1-hj351016@gmail.com>
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

ak4613_dai_trigger() schedules priv->dummy_write_work on playback start
to issue the PW_MGMT1/PW_MGMT3 dummy writes from a non-atomic context.
The worker dereferences ak4613_priv and accesses the component over I2C.

priv is allocated with devm_kzalloc() and the component driver has no
remove callback, so nothing cancels the work on unbind. If the device is
unbound while the work is still pending, the worker runs after priv has
been freed by devres, resulting in a use-after-free.

Cancel the work from a component remove callback, which runs while priv
and the component are still valid.

Fixes: 03bbf9f5e4eb ("ASoC: ak4613: call dummy write for PW_MGMT1/3 when Playback")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 sound/soc/codecs/ak4613.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 0000000..0000000 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -807,7 +807,15 @@ static int ak4613_resume(struct snd_soc_component *component)
 	return regcache_sync(regmap);
 }

+static void ak4613_remove(struct snd_soc_component *component)
+{
+	struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
+
+	cancel_work_sync(&priv->dummy_write_work);
+}
+
 static const struct snd_soc_component_driver soc_component_dev_ak4613 = {
+	.remove			= ak4613_remove,
 	.suspend		= ak4613_suspend,
 	.resume			= ak4613_resume,
 	.set_bias_level		= ak4613_set_bias_level,
--
2.43.0
