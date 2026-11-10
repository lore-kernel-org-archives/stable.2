Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285017;
	b=N38NEN+ORJ5q1GJD/dKiYW34tvnOZ9Qm+FhcHGmGgdSQz3DhrcxYhTwe0AxULQhqxKrh
	 cR2SB2le5NLfkyH8FfADJT6bkeGZdAbEcid7Yv+rn8/hHG8BSOdN9NUlna2DfgXQxdu0Y
	 6g6aq3xnoY9jDLf4c00Iauv/uV11L4i3TMV8tAEqvZXgPS+IMA30XYnF7g7sKAS04lmJk
	 mkE+NedTbm/Ie8pcgC5UfgPnZ2b7IcRLfVrRSEAyD5aG+VjAD/ozm/aA6KiVMv1xKU/7F
	 XK2dRgAjjoHo7BhvDSXYn8jfawnBDZyu+LA8Hzw3P2gKIax3pm5eenygz35nPenSDQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m9ZiqV3STCrg3BhaNCa8Qlk+MJM+GYUBrMPf7KJLgGU=;
	b=d0Z6K1tbSWvHUMR3ULLTWzvrHBccKtP400w2juVh2BhlvMa6lmW1ym3qh07PhMscaHDv
	 VhGkjFiYpO2/pnpTSEocJJBDR4WrKdfdYb/dO+Nilzk7hx6Q3Vqc16AvxpF6lJnO4l74y
	 2OKoCKyyF4qvwElWOKRpp0V2GMau0RaONcxAEg3mUsIogLs1sOShx8xl6Ko/vyKAbWLxL
	 XHrjjBrKavNDPw3YLchoYousjPsqtII7DNtkEw2OgWI3WbO4mfUjgABhbiDQP6wdD7DC5
	 JZ3aRbgn5BRyCZmIiCYxU7M5tQFDy4mQPnyAqMQymL007TVS9me5H/McH0BYb93onog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I/BfnfVJ";
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A0606A33C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E2A0606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I/BfnfVJ
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5430f70c827so16637421cf.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285016; x=1794889816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m9ZiqV3STCrg3BhaNCa8Qlk+MJM+GYUBrMPf7KJLgGU=;
        b=I/BfnfVJEqNAcIncWiFEIEy0CQgE8VyTmVPyGTEK9+2XgrwtAyUnpxVxpxY92ZjhyX
         BmtrZe6nKvuI7XLyxZopfOU9phHDG8Xviv2Q2F39ASFwCmIysXw01oylmpU9ez85AcvK
         m+PkqK747ScC6FvPS7Pz8zLV5HvdxcevK4yUERburF5YekQ8PL6STG7yc2QHA63vr0er
         67Tube1HToUSX3RGCqO67FfnDJpqxN9oVoI72yTCY1EU573b2zyOcksy7GcP8hL6gmrv
         JmZ4rmtwX6CsfcbOQM67UstmBvZZorZHwz14M/egE1IZ/IhGYFC8hv/wkxAXYIWkk71H
         ghtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285016; x=1794889816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m9ZiqV3STCrg3BhaNCa8Qlk+MJM+GYUBrMPf7KJLgGU=;
        b=jTZcrkuIQCO/Gtqn3/ICcQOyLbEi2jUpUTO2jx1ZKeIlWWP8Frsfu4k+6V3+OdomGm
         HjRmJLvHJ0NCCP/0Z2MiJq0VY+vBtPB45xMvNAw9JJqq5pD9mJIvhAslh6n0F4FJ5v40
         zqeFuqjA95J/OjKPlJsp6qQ+aPjMHYCCu+MhPBiNXIxzd6Kxxxib9fMI9TFcT/9ZPcZN
         acIhBT9QlF/NBB202bp/AoBsXbT+KTIYARLKKoI0N5u610p5FojYdvojas5TGivuTumI
         3WkPBJK3wzS3Sk/YxKfok3+2ew2Z+bBVEDr4hDG1vKjhVJM2Doeak0BJLN7JYVYMI2qQ
         O+eA==
X-Forwarded-Encrypted: i=1; AL+hErHmUnzKr9LfW3Zwo+ZOQo4PzmQsFZhhvqghMVoVmHTM24ShfpCV7ND5cmgIGgyjZM2aPJ2QNU8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gv2+Qx0TdghFuiBhDT+tW0yu069cAfKxbUrU+lVgznsVVs9rt
	k0NzT16MQ9yDFfe4CeD/bjRdXZoCYj/9Z1xZqMtySc6+zzG40r8HSnc=
X-Gm-Gg: AYBFou3huFSlMIvL0RY8wk/fHSCEI+j9FTCKy5GjyQBa5pF27bzkk2yMGTvjPc8RFpY
	UPIZ7NCDPjQnYjNTD5RBE0C3OfG6gMOQqkYurRXdU086sNcu+8U0ARbXOfawk6BddGM0FUjqHQo
	eiOZwME2o+wr91XmjYqtalaCMjbT4RyYr0GUZd07epPusHOoUENf7+lD6EqtOi2f63NjiSskTR4
	65OoMMZuXB9jeFZQ2NSH2291zN6QydV/FcXc4z/onZx3BeHe1pwCFB45IM8rsjfo0pezyHGG9WT
	4rzMQMih/i7nuDSM9EVWkzZzTFYBk3DYgpovfu8tAIdolLUFIGdKYGsLXPzwAwmIGP32S1Fr5Er
	hQCY+GswP753JOu4BtfM8x94Yox8DYvBbvFj9vltSTB5fZMdS7s1xSvlIop6gDl4DFeD4+a2D7V
	G9YqheDatuSeAYUTdG4i9KBILt7QVZzKKe0kEBnbOZdFnVjavY/wZduOtBAE3Hd/GyscxExTyDw
	jBwydUIg6fpPM+YSsi626XkSI+Spg0Rv40L/t69KI5T3/rKOooJMWbzCwNvq3QAwu4bzdhSRaxG
	s5x/vLdkvak8heBBscBQIiQZ3AHc35SjuI6HpT/nIRC3FwVSsFzP1q3YvyFu9sxLuUSYq0UoRg7
	gKtNqAMEUZ3Piuz3Ggm8o+SAfRg9IFvTu9lFl5giKX+Sipa50U5oImcQAvyiqM6H6
X-Received: by 2002:ac8:5a51:0:b0:535:1b18:202 with SMTP id d75a77b69052e-55527f0f4f9mr20274411cf.16.1794285016367;
        Mon, 09 Nov 2026 20:30:16 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-555093d9c3fsm14579281cf.3.2026.11.09.20.30.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:15 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] ASoC: rt5682: disable jack detection works on shutdown
Date: Mon,  9 Nov 2026 23:30:13 -0500
Message-ID: <20261110043013.56937-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

rt5682_i2c_shutdown(), which is also the remove path, cancels
jack_detect_work before jd_check_work. With a headset button held,
jd_check_work can observe jack removal and queue jack_detect_work
after the first cancel. That work can then run after the codec is
reset or, on remove, after the driver data is freed.

Use disable_delayed_work_sync() for both works, which can queue each
other, to drain them and prevent requeueing. Probe initializes fresh
work on rebind.

Found by a static analysis tool under development.

Fixes: 45a2702ce109 ("ASoC: rt5682: Fix panic in rt5682_jack_detect_handler happening during system shutdown")
Cc: stable@vger.kernel.org # v6.10+
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

 sound/soc/codecs/rt5682-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 43132943f6a7..db820cd9acba 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -299,8 +299,8 @@ static void rt5682_i2c_shutdown(struct i2c_client *client)
 	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
 
 	disable_irq(client->irq);
-	cancel_delayed_work_sync(&rt5682->jack_detect_work);
-	cancel_delayed_work_sync(&rt5682->jd_check_work);
+	disable_delayed_work_sync(&rt5682->jack_detect_work);
+	disable_delayed_work_sync(&rt5682->jd_check_work);
 
 	rt5682_reset(rt5682);
 }

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

