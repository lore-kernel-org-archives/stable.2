Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374927;
	b=kfs9D6dIEmer2lUlUetxmP/0XZkUoTb+Ur4Drr60/zuLrFIMhGif0bVSlHy+8bx1oWyu
	 1WyIUnb5aVWMeh1n+M8UZde0iXjtf4W/V51M4rsfWMUjmuM6L5FePHyZqx4t+ya0n/9av
	 Cmq290cNyBvU7gNyx1Sf/sA7AKQwil4gSD4G33WdNLSjrm5CkJ50qcIU4w00ggAoLiDh4
	 7FTvEnlqir5NkEqD/8DYGQnAKDYAC8w9sIJbVBH9ct1hL2Ux5fOvq9OGAFPik07KwdejA
	 2jcse/p7GhawXF9m93ylrEM0g+VBDYxDsWkzwwC3x/1VkhaVsRXGY7dtR/Qxvjem1wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oT6zOKuMmrGX2JEsJt0a3oM6O2BasGKB2xgXzQNQ0cA=;
	b=tuG/oXpZK6p6jVhY9ZtK6Ymd5D18U+6pdAkhU+2ecH2vunpaGTenRVaCckPNWQQuCVde
	 qog5TsWbFm4WKrURo44JX/VOALjiqABrh7OD7dsEXyX93RzIa7xgrZLyVeicafQfiBPu5
	 8ho2+hnb0E6eB5LAqZX0E78o/PzJLDaRv5nsQl3sZ0ZEWPbk+AhtlQr4ItGMlQR2Q2GZ/
	 mFsiqavG7wur6cCjH2p/LPxci9kTeEwM/v7ePuPe3ntokzaZQyx8U7r/2WMmPc2g7rfH1
	 JqKKop3Tez7I0T7BsgcaofKw+qWWOUw/77ScBvl5DHd+oByRRFNVqqUjmixGjZtvs7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAtPukdo;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF8606A322
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EABF8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAtPukdo
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso10089035e9.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374925; x=1793979725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oT6zOKuMmrGX2JEsJt0a3oM6O2BasGKB2xgXzQNQ0cA=;
        b=pAtPukdo/UiYKxal4WaukbEkirnB8ZnJjxuUIQ9b7lb5XpvR6D9hdNS4DkNfM/KdnN
         ogkuhRNg835ghSmmMJ3g5odlK5UJSEIeuAgjvtychRea9DxvLE3IFyaxaYKFMHcOs5da
         CqvcGndHhFAO9QfGOdrOjaV9Ps7zSQGYD6gZ1HLi1BeA+3qwzZG9pfHq/j6jC64xmEZv
         d3296XRVx5Gd7Jta8YIf27M2Pskpy9J0NMtY176S7+U+MzOo4o61u1bA/le8LaugyFiQ
         DJTRREcNf4/T7L/izZ+/NPqNch80PP3D5BvHTb32JkAMGioDbB7BTdsKvOOovEdTWP1L
         Dhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374925; x=1793979725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oT6zOKuMmrGX2JEsJt0a3oM6O2BasGKB2xgXzQNQ0cA=;
        b=fry+SiC7ado2xuxkB7EQlnKfPBGmLRrxa8HfL/ZNqWxDh33uWA7cgGIXiEjnlFr25W
         /sRl3wLHJQN+cG/OsCxXG51ugsTWpT/3cDF9LBr45EaRiKyJp7LZTuds7Rm7hY4olbXE
         j4L3rCr0sTLt4z1yyGNIWoOxj25rPaPEq0SS7FkpOPk8umBllGs8CsAlvmjxCp3dl2Sq
         dhwpnGKRqV6CtiQbGB79lQ6Ra8SDJ5UMSO0cnhEqaU3hYQZo+nKMA+4+TactmpEoegZ0
         5X0NhSI+LWjj1082HwlcgUoInfU5nn8bdNNtIR6OOXEDnWFGL4awSWnnekNMVV3rlz6H
         bNnw==
X-Forwarded-Encrypted: i=1; AKwUvBx3pBYm18FkYXEZIgRM/teeM14ndBDvn8uYINSXF9xrWKhvfJdny69MIaCjEu9R9zk4Hdk82Mg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLx3AonBE0KNjoSBLVBNbH+a0rii0uNVum0P7TCuizg7f+F+Gzt
	5D0GPdtbLTXVafoMRgoX90ujEP4PduVfcsgkqvL8gp8J1AnpcxkahX0=
X-Gm-Gg: AYBFou2m6UQkHsqBK3RJ4/HqjN23cL9GpNj2bkZs1YVKdXY8Mca4XSgo4qO8lqYe3uN
	SvfQ3FrYq9chOX+C+WGOhxBq8fY+Y7Dwrd8kbjS66PE20H0NUWFqatuJbOQ4xf9XhhazWjrjZTC
	mKtF/+hZ6I2P6KJu37j1ArACK6av5bufsA4AgTYCdW+zwB7DrbYjVpZ5+Y77c0MYKMfPAjMb12E
	I2NWfpfyCwPdz4HNrNxaJwGXEe+Holbzw5gMl/6kV7F9d+oyU9Eom0pjO83qlmPyV/ufrOyMK/s
	4fdmrFoCyE+gX1R8LhYWXRE6zSwBdTFe3jGKpgmmVEOcxWt06NrteWxCfQKTMmSDQA7/HsVaghX
	u278+FYSu5RMG7XID8YUYtiXwV06Dv2lXWfe/boJFyFaHKyOvradtGg/1kW59WdqK2cvgzlzVg4
	aqYUephDv/l0si2G0noK0BsGWC02DYcZm3tBIxLdd3pCToGC286HospZGwOocfpkdn8w+po/uyx
	R9EtRqijduwOip/xML577T1QSN+ZfC/o/xQm1wiZ1YeE1wUVsPJi3sNbrgrNslVI/mV8jJzBXLZ
	n7ensd0NReA=
X-Received: by 2002:a05:600c:3f10:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4ac1889cc2fmr54045215e9.19.1793374925337;
        Fri, 30 Oct 2026 08:42:05 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f047bfsm144419935e9.3.2026.10.30.08.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:42:04 -0700 (PDT)
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
Subject: [PATCH v3 1/4] ASoC: rt5668: cancel delayed works on component removal
Date: Fri, 30 Oct 2026 15:41:59 +0000
Message-ID: <20261030154202.2989936-2-tristan@talencesecurity.com>
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

The rt5668 codec driver initializes jack_detect_work and jd_check_work
but neither is cancelled during component removal.  If the device is
unbound while work is pending, the handler can access freed memory.

The jack_detect_work handler schedules jd_check_work, which re-arms
itself every 500 jiffies while a jack remains inserted, so both must
be cancelled.

Because the IRQ is registered via devm_request_threaded_irq(), it
remains active until after the component remove callback returns.
Disable the IRQ first to synchronize with any running handler and
prevent new work from being scheduled, then cancel both works
synchronously.

Fixes: d59fb28562232 ("ASoC: rt5668: add rt5668B codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes in v3:
  - Also cancel jd_check_work (self-rearming every 500 jiffies)
  - Disable IRQ before cancel to prevent handler re-queueing

Changes in v2:
  - Resend as part of unified series (no code changes from v1)
 sound/soc/codecs/rt5668.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 4154bad276101..b273449fac9db 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -2222,6 +2222,13 @@ static int rt5668_probe(struct snd_soc_component *component)
 static void rt5668_remove(struct snd_soc_component *component)
 {
 	struct rt5668_priv *rt5668 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
+
+	if (i2c->irq)
+		disable_irq(i2c->irq);
+
+	cancel_delayed_work_sync(&rt5668->jack_detect_work);
+	cancel_delayed_work_sync(&rt5668->jd_check_work);
 
 	rt5668_reset(rt5668->regmap);
 }
-- 
2.47.3

