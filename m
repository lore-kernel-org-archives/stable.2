Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103D3812D2
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168447; cv=none; b=gx4jbkk4Ud3yXsKi77torkPjfOPezmpFB4AHr/1H/rWCRCBVoFr70AQjX6OFuoa3JoWRjvdcP4aTwvYz4DT5eHz7GgbXEr7OusQB6KwXJ2En2myalv5XodNg35sxKfJvQ8E/pkWYGFw5l0hPPVElpMXAYQDiUb+BNs0+7F9vnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168447; c=relaxed/simple;
	bh=qiRAXZkRJEXPmqs8IIFVKCH0Z9Kb5ltx/zf1mIOnkpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7pK1110r6baHK3JpOvk3SB/s1KX8V2wqXvOU9vgtyh0dGS3kSyHMGl0Ffboow0gRx41r1N2p4PiMNj/E0xMKdayGP1vMkOiIAnMxumfv9SkNYRdLM3MaAPCC4nfHX3RvxBHFs6fQscMtKZ/dCoXCcU6amAK3v6iywT14ikP8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMryacOp; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMryacOp"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f1cf92c9eso11858485a.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168445; x=1792773245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hHrZ44E7mwbp2nfJxIBL5668mhyMNf3IrRHINSdc80I=;
        b=gMryacOp8OWOdnsjDfFoTn8t8hmkzwqNlobI0iYqM7L86wd8LtgLd9xDswuqApgHiT
         OqJ8mcsHshjwy9LbrNuu/JYC4K3SMkLY7RLcJmkt7pcRAs9oyMVGyVKibvaB7pTl4eS9
         oznDAaLfB9LHGYgVA9IxXyuA/Eq15F1kxhnZppNHTMY6/pLRPlKMw2409G6mWEjhVCzK
         khyy94UVbgzDUjAY4sjwefWJLpfQARWUWPat0aYwAc1G+jitJAUk8Mk8x+Fw6VHr9Q2f
         yFMA4jyA3rNdbP3+l+B2Nh5HQAjSPmRZ+kH6N8GnPlsiWeYtVM92Ma1ywOriLhcsGmOC
         /r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168445; x=1792773245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hHrZ44E7mwbp2nfJxIBL5668mhyMNf3IrRHINSdc80I=;
        b=jY0bDhZWJHzxdL1utaEMnZZYMTJxKO0PVE+bwqOYRtc5TB2vekQUXX1qp+uvNtRVF5
         7KXojwov/dPgyCj4gJjet6NEsVo8J4TiinW+kwXKtlxisAFNQekzpV/BLITMN1f6y0FK
         /tdaFZ9IcroNso9wFr23UE2iv+HqlPVHk/uIMy9fBjAO9ooT2McBbEYeB07NiG8rwSGh
         ttAsuqepBnfTPmn3/lvvOOiBCEcGTpKZIui+aZGURGRKe2kgacDghlzx3NQzKvTFJU91
         qngzGLk9LJbET9uuk06Si+KV8gdXRPsaGYteVvUILtuFEJJnAA3Jxs9yOcmp24FMEj2F
         ApSA==
X-Forwarded-Encrypted: i=1; AKwUvBxnoIt/tmelfBURUhe+RqBSpgB1TcTUbzhgLAyxvvsYq2p4Ul+I/wswU6iaxHpDBhG1SbYhR9c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHJJMR7rpGhuueQHPY9mgt3kfsEyJawld4YCMkXkxvC1iifMS3
	CNcA5bbeT4wV9XidevJ3oBXey2U1kiZlZH4NvfUlqM+na72W8mGCiqfG
X-Gm-Gg: AYBFou1wVO/ecnUlCNI50u22/vBMdB3cjyUUlqejZWJaAlTh+iI0LbaZl+Sz+Zz0NkO
	hggs9nNFvovRpuKjHzBIaUEQGWEjcx5ML7EUIO4GpAsS0cnqKSbMRzDm6Gy1g0rm4ZGxY5xKHec
	B/9AspSaf9wMd87z9iRDV9V6RAuUF9C44VE5Iz09zJBEDRg0byOlh6ghCEImNYSmt2nm49PuvZi
	qqmqcuGwSQT9E6gCbcZarQ8Kz4Jju8Oish2YQ5SjwQRyJ+gL2RDnCbJHuMGHMdc8mgZWJ4eukeG
	uYKc6DVxsueZMU/tt3MN3A8W53kU8VAGDpqJstqyrLWoj8X2P/LVJUMte05MPN4iU03hb7iAx2P
	K6rMYFZJH/WSHjb7DyKYWwnY/MJoVVIG745RLzf8NxqdsWI3JU3zq/zV+z96x/ToL7K5/Bo+hBK
	brseb9zyY804zCaj2Z0qlvwAEyn1dponKAa5lDAd9ARUfNrMkJ7mHWPRXmeblJ/TU=
X-Received: by 2002:a05:620a:439b:b0:939:4a44:5f99 with SMTP id af79cd13be357-93f29b7eac0mr63046685a.10.1792168444661;
        Fri, 16 Oct 2026 09:34:04 -0700 (PDT)
Received: from beelink ([187.15.139.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcc47bccasm25272806d6.20.2026.10.16.09.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:34:04 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v7 0/2] HID: multitouch: fix use-after-free of haptic data on delayed input release
Date: Fri, 16 Oct 2026 13:33:47 -0300
Message-ID: <20261016163349.3293666-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016151343.3120300-1-qwe.aldo@gmail.com>
References: <20261016151343.3120300-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7 fixes issues found by Sashiko on v5 and v6.

Patch 1 now moves input_set_capability(EV_FF) after input_ff_create()
so the capability is not advertised when FF setup fails -- the caller
masks the error and EVIOCGEFFECTS would deref a NULL dev->ff.

Patch 2 keeps the devm_add_action() design.  Changes since v5:
  - module_put in hid_haptic_destroy (not devm_release) so the module
    stays loaded until FF is done; __module_get for devm_release itself
  - guard against double-init (return 0 when haptic->wq is set)
  - NULL haptic->hdev and haptic->input_dev after put in devm_release
  - restore dev->flush/event on devm_add_action failure

v6: https://lore.kernel.org/linux-input/20261016151343.3120300-1-qwe.aldo@gmail.com/
v5: https://lore.kernel.org/linux-input/20261016135516.2957381-1-qwe.aldo@gmail.com/
v4: https://lore.kernel.org/linux-input/20261009103333.2476105-1-qwe.aldo@gmail.com/
v1: https://lore.kernel.org/linux-input/20261009031207.3233206-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: reorder try_module_get/get_device before input_ff_create
  HID: multitouch: fix use-after-free of haptic data on delayed input
    release

 drivers/hid/hid-haptic.c | 105 +++++++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 26 deletions(-)

--
2.53.0
