Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201316;
	b=yGboytLn+5qtR5k90bvnJ+YpWklOlX5Q+nkgO3raZa9d9T/GJmuHRuJbVTONax1W4mTl
	 W3m7z2kxYjenAj78sANkhFvLkcEr00YtMP5ysouLRzGUTheVSzBNlT335+KP7SxvhX7Rq
	 4aH99Tkr46BjpDei2a/b41pZiQDCqiWGYtDW1mH1DcwjRePLEnmONK7Kv6Afe+pvHN2V+
	 l5lpD3pZdVQttfQIhHg1U5JcGfM7r4JmnEW01R4M3VA5x4npiBlwE3qLecOa987NDO624
	 gh8JcsX2b06goCZ5VEAAZgw4tr2tsttza/W9LFtYW2jUvTF0m/ZxiMJzhge8+vjdn8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3EFnvh6M4nOfo//zmUowr8B+BehGN6D7OuDC+mfDQMA=;
	b=eBrr5iWFwOUHxqs5nRdi1FuJd7WfBlxGV1iFbORPJ3jH1fkoeXDKWcsZliviG8BFkg36
	 z+RlwfydI5iDtRLTs1HcPnBJhs7McGGYAYXJPfj6KEx6lbaj38SoDhwj1rVJAVf1Revj5
	 kalo+Y7iFOfPwXCbxE3XKae+uG6sz3Vwg0LEI7HRuEeUZ/MFmuW3ItELFnaUgi+DbujCO
	 uqvQ2fSk7J9jEYMVP5rJjDdZaYCYgXPXjxZ7mMI76A5PTn1TBrMDoAYApec8jxM3H2Ulb
	 r7/9wE3G2ZWRqGhfqgCY+dPnT0y9Ocee51YqIb6+35ZVGFv+hAgeepuc2NRfrqCTjYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kpm/IOYq";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACB60A260F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8ACB60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpm/IOYq
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so727612a91.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793201315; x=1793806115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3EFnvh6M4nOfo//zmUowr8B+BehGN6D7OuDC+mfDQMA=;
        b=kpm/IOYqo+7GqMVydqZfXf3rnJJTuYH1+qm3m2pLTRv75gikPP66iIbuBbx1Y6PNnv
         C6lyWrdTrj0S+aonvY15svJzwqeK74XMt0QjRRK3VgNAPM2l8osz/bXluVR6FKfr4ngB
         P/RbmkzJTISw6aiu7gNJxgodbWiY/woHTdPvadWGLVBhQOE6SW2Z7O0INuCxJk0HhK+z
         peuearw8wWupxSrOMfsHK5qpj6PI5PlMeqTGNh85b2noNxwAQH1Xg3Ehup8wRVYDEuU9
         rrmwY9cTpusi3QqywHV8Mesgjh7fILq13Zohicc/uuQ336iCEvoF4jYMxiI1kQPrkjr8
         /EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201315; x=1793806115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3EFnvh6M4nOfo//zmUowr8B+BehGN6D7OuDC+mfDQMA=;
        b=wRoCa7Rudld0qfQDXKnoUcrwpcDeoO2AAQmGZpJQUbrRptxnBb+nCTPb1c4XlGVupV
         Jj78ILCZSWs0jCxyScRNHlzTDp29F3lMdb20vKCRFfb0aXIB8iyCTe5AGV1QeyB5OTSD
         l/Dpy+NhQ7y1/+/pjV62PmQY8WTVrOdKv2N/bA9/vCiCjGviBktfGPD63SBEH3FhA7Mx
         Z9HRdZDek6LPYUYD09lYDd/EL1OzIeAF/TFVrEyxlNxXicpwy1UhDNJsBEhryT8kP9Ki
         BEYcpeBhJgJ4fL4csT4x6GR0oTdKVflap4bId5Pbk91c4nvkC/vbglpa6DSPslKufoxn
         XUfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxvr44Rg+KJpQPHZYfrRp1nUx20N/zDKt0VGrfpGJT3Tx99Q/V2N8hVEYPFckJzO+py431k3k=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3I56cDmEScpeiZg4B+5S1KlKqu9WA9mxDOweUJA5c71Qw3r9v
	AUKo+DJQmAxti5ytz8T6jjRqx40ffMCT7t2Lq89uhD8Q5Ois5tkaZRFf
X-Gm-Gg: AYBFou2Q6E8KM5sinepJ0hYdcx9y/JCVN69ZjspqDaxmQUAUtmhG7xRs0zqtIbpeW+f
	nzZtM6mIu/iPNBNYUPBoEPQjEpKw+3LOUDAHPn876iI9h2D7fKoa7ECCy6EQfcZ4zfFy1KrUKAM
	Vp3Q9WAAPypourrYekSEkSoJ/xyk8MhH/eAJxEbQzvaVyIkN8JZwyR0w4sSB0xNwZnsQnIekKip
	FjCdQ2yFEnvMntTWLy5QCKlH1oyD7pdOkFw6I9LdpN78usOyahr9WrgRdWDMFpI0IAUNpmrDtNP
	sUs+sMgxDw2ICEokPYzuwV9RPDAiVIxH/aGR2COLVmkDnNDJhca0XqDw7n7W+fVOSBa5mFRmtdb
	+hXvXNigxl3Wn0i50gSEy1LX3wS2wWHKVTMEv7iJ+FfGzHKzosA0bUg8bVmgPcYAxvnC8FGVxZB
	ttrviSJ/tEWCQpj8REHYv2TZyQTNj2K6j+DdaHiMmMdthjFh+HL/j9D7crflDswQG62MfvmUzAw
	PRPVA4Cm3DhyAR12VvHYtedKZ9fD7pbXjnZplKWLopJUBTm+FPrN/AS+2oTD2ugtvQ6qjVYUr6c
	q7/8TjII0TbitMakSrlbSxHP1M2OF/AqtbleHJEqsvonI569
X-Received: by 2002:a17:90b:2e48:b0:3a4:a592:4cfa with SMTP id 98e67ed59e1d1-3ae58250508mr2028733a91.45.1793201315127;
        Wed, 28 Oct 2026 08:28:35 -0700 (PDT)
Received: from spidy ([2401:4900:e01c:35d:d4a0:a769:c60:258c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9f286fsm3445533a91.15.2026.10.28.08.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:28:34 -0700 (PDT)
From: Gowtham S Bhushan <gowtham398gs@gmail.com>
To: song@kernel.org,
	yukuai@fygo.io
Cc: magiclinan@didiglobal.com,
	xiao@kernel.org,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com,
	Gowtham S Bhushan <gowtham398gs@gmail.com>,
	syzbot+75f49ec552cc74d9d69b@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] md/raid1: Prevent excessively large memory allocations
Date: Wed, 28 Oct 2026 20:57:55 +0530
Message-ID: <20261028152755.383821-1-gowtham398gs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Validate mddev->raid_disks before memory allocation to prevent integer
wrap-around or allocating an unreasonably large chunk of memory that
exceeds KMALLOC_MAX_SIZE boundaries.

Reported-by: syzbot+75f49ec552cc74d9d69b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=75f49ec552cc74d9d69b
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: syzbot+75f49ec552cc74d9d69b@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com

Signed-off-by: Gowtham S Bhushan <gowtham398gs@gmail.com>
---
 drivers/md/raid1.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index f0646fb24371..88038d535727 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3050,6 +3050,16 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 	struct md_rdev *rdev;
 	size_t r1bio_size;
 	int err = -ENOMEM;
+	size_t calculated_size;
+
+	/* prevent baseline integer wrap-around anomalies first*/
+	/* Safely calculate size; overflows automatically saturate to SIZE_MAX */
+
+	calculated_size = size_add(sizeof(struct r1conf),
+				   size_mul(mddev->raid_disks, sizeof(struct r1bio)));
+
+	if (mddev->raid_disks <= 0 || calculated_size >= KMALLOC_MAX_SIZE)
+		return ERR_PTR(-EINVAL);
 
 	conf = kzalloc_obj(struct r1conf);
 	if (!conf)
-- 
2.56.0

