Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615905;
	b=LxywMywrqVdMnlYUSQgcTYMxvSxzlGX/jplZtWiOtLZRCRVFIb4PlDugxo7dlrzx04xl
	 2GI1WDW4okn4SRLyj2rfCsd9R+Vg5OQGiDYr/7m7uUnJfYKHtY8YKNoAMna43rdmEnQXf
	 QzjrVb2gXImVMAY8KQQScLM9UkmzDArW1pRcyhFBMWxze6g9zAZmpNiOHIG4BmGX8Lix/
	 vkFqbUE3H+cqSdNwjqAbi7p60faqCtymATeKPKBTWvw2URmh5LpxzsDY+t4AMDnXgw6sM
	 JG4IuKmR5yjEBHbZvEnp6+2wDuHvpLgtjwX/w6NCaYEYWljXqoUtHl9vCVIJxTLSyvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=nIaLyIlOqzSWlOX7liBCjVqH7iW6BW00x93u2nQ8ElU=;
	b=CDBSBC01sWZBIZP6eJQPqL3k0Qgp39pKnB3cgIR/IueYdv3ga3Zz1X+FVXE+AM4BhSAw
	 eWF2rcV4iFsp016asvxZIbTVks0oeXV7dnzy6r07FUO9LYl8trAskVFyXasrKqAd/pk9o
	 W6R+FpEPIjnOoHGh3V9l6TrNDok5YWI6yyW78kSdHsDcx3qg3O042V7pWUNeF3lr9q087
	 PWDDZ7sywmLQHveOifAIv8oWYd3AMkJvDuglSMISdzUMCEwf05K8I+NEkTwaE7YoMTXHP
	 wsx6kQWyVOne0tqdGBboKfzPkhCVTUqJe8M4DqjX4IRU7aLwbQEUx7LZMT9mihkYzyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=szB0Yr4R;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56326606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56326606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=szB0Yr4R
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso27709735e9.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 02:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793615904; x=1794220704; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nIaLyIlOqzSWlOX7liBCjVqH7iW6BW00x93u2nQ8ElU=;
        b=szB0Yr4RS7GVzNm6ov4UD6fvIgW8zvUVaq9qtRt3+5RK26LjawimA6ac29kSy8p1nX
         8FrJFAATcbLiy93Z1mVUiu2uO41XtaUvDYLymoD9AN5Q+KXplAKKmdqe5aX+CLJRhp0h
         cJNRIo9Uzm5NfYd4mcObcIpwospHuNEcPjFOwZmmYQ9YjMYm0qt2LgTACfSw0EgXtjms
         OcTWMQcdw88yrKaMksxQTy+1fAYTBbcMOHLc3rRcW1QSIWQVYitUOTzGASe8Qe4g/Dju
         Hmy0GD17gItr/i7g4OOrBfyeLoL6b+v+CcapjLYR7Oav62C/HX2YUXjObP4e3ljfJdwR
         YA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793615904; x=1794220704;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nIaLyIlOqzSWlOX7liBCjVqH7iW6BW00x93u2nQ8ElU=;
        b=X90QFqoPYyyFkLK5oEX/dITu6S702ih0OZ7ExnFTQTBtZtlb5cLDftcUH5FINpReIC
         AZ3Y9iVohOqJBSb2lJ21GXCVrk8lQ4+prWWSueExJKe8dVd1dZ2Kl6+Iu4kDVnynbM9N
         w7swDakyTzJ4ORQidGdQfqWql0RmpG7qVvnMjyBPAii1Cdl0z5kXd09SAJwA7j5Gxavv
         /ENeDu7+zj4uQkE/xRr0NTPW3+ByWA7a4IwwYjt8v23fhAZ6UBVmlcGH7Cwk1zGzdFs7
         YHosmL7ZuUgxRJK+8GedLRzaFf7aMT8PvhfEyv4uX9QpRLiSkwwax94YXh32Nf9oxnR7
         bsHA==
X-Forwarded-Encrypted: i=1; AKwUvBy6mlzPGQEywRIp4yfXDxIUvKMbNRhxYyBydgYQ2tUIfM1aV0/UtLGNyFx/RPSsBupVDql71RQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIGU//RDgcARrjtEx12cINrfPODFJ8wHvs5iONCfh5DkW1gznF
	E+FCwjPI2VtJ4DxJE2TuIDWtTAhPcTmdGHZY20uOBov9AMFMub5QYOjB
X-Gm-Gg: AYBFou28mpUWHlW83T7muoa9n8ZU7oQSdi8EYkC9xcxdAYKZ/zNmXjzAFgjN7jhigvK
	vS8lEPOfDV+ef0vs8hnaWsEGCboRujjbnUvshy6tTtgMBOg6E9YTMkAw6S3iTMsxfWiwtwxlWow
	OXPGiMARK/PmCaRE15iIoW69PqqbSzXOgx65MfwR4AneKq8vN7NPSivjDl9Zdc4nwO3WGQpYut1
	UE98NPWJuTfoQwcDIHn5ppWtYKyEhpp+pxFQDDh3Q1Ja5ouBTaZRz0FRtkhSMyTYKWjtH+VeBLJ
	FkadTI+nKDVVQKlkGqGcQbpNxSFYwsefw0DI+x56cSHpsslSsYBaPPmdDHsFpEXzRY0YZ5SZDLI
	bB696A05rOt5QGBW3XiK5axIJqIdp2GkfgkK9E8BErm6BkBKNmYaJFUhdswqYADAmdkiADUlE34
	OL+6TEpMH2pKaFMzmIB+oz2ew7x1qnh0CWOkBr77gLMZBvjpNK7NyzB6wGSUr8qxs7OcfvRqt/o
	n9YFBHVfC4CVR2Da6HNjlK4On23LHQVkTt4jcrPkq9P8H/Ux6n0twPP4Am6y+x9xdwmuGWgdYYJ
	mR6ToiL19NItw5Y59RG3saDYRBpVfCBDwKrRuAmdBcRCwSqSLCG/Ri9iUBPSb5z+l0gQY1EOz59
	UdPP6K9ErdebJr/0db/zqsxffd3giuulitXeeLwKY2zIdiGGO6/4=
X-Received: by 2002:a05:600d:e:b0:4ad:181a:4350 with SMTP id 5b1f17b1804b1-4ad181a44a0mr139552635e9.21.1793615903562;
        Mon, 02 Nov 2026 02:38:23 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at. [80.108.121.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm282109515e9.10.2026.11.02.02.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:38:22 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 02 Nov 2026 11:38:17 +0100
Subject: [PATCH] drm/etnaviv: Fix NULL dereference on unbind without PPU
 flop reset
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-etnaviv-unbind-flop-fix-v1-1-588fd16f6768@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7biElE/pKdChdayG20JIg+nvSc
 QZmHkgUmRL01QORMifepYCqK3DrJAsh+8KgG90p1WikU6bMGS+ZWTyGbT8w8I3GWRus8dSaAKU
 +IhX9n4fxfT8KF+MpaQAAAA==
X-Change-ID: 20261102-etnaviv-unbind-flop-fix-5c77f75de45f
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gert Wollny <gert.wollny@collabora.com>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

From: Christian Gmeiner <cgmeiner@igalia.com>

flop_reset_data_ppu is only allocated on GPUs that need the PPU flop
reset. However, etnaviv_unbind(..) frees it unconditionally, and
etnaviv_cmdbuf_free(..) dereferences cmdbuf->suballoc before checking
whether cmdbuf is NULL.

As a result, unloading the driver on GPUs that do not need the PPU
flop reset causes a NULL pointer dereference at address 0.

Fixes: 85ba57ad88cf ("drm/etnaviv: Add PPU flop reset")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 08aca9035fc1..ec1352c1b09f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -601,8 +601,10 @@ static void etnaviv_unbind(struct device *dev)
 
 	component_unbind_all(dev, drm);
 
-	etnaviv_cmdbuf_free(priv->flop_reset_data_ppu);
-	kfree(priv->flop_reset_data_ppu);
+	if (priv->flop_reset_data_ppu) {
+		etnaviv_cmdbuf_free(priv->flop_reset_data_ppu);
+		kfree(priv->flop_reset_data_ppu);
+	}
 
 	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-etnaviv-unbind-flop-fix-5c77f75de45f

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

