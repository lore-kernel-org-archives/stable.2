Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795822917;
	b=jS2NO3e5+qOnc+DlnknuGcoYQ+Wtld2mwoV07na9MHqvyK5QuhTA4VB7KGEsU8xm5fu6
	 zb9+66IVUDtJHVijU/29edeZQT9siDCcEo4Yr3pENmcanVPiDNHE/AqaIrF8nLp3BatdL
	 3Ntqfbc7lS9wUenZ3X/5WQkPCUEo7lm6cxGYAFOJA+QroEQnw8M39CFLod4p9BqJ7+9vP
	 vyAgVVb//Y7MOASMItjZyUvnDEae9XAG1escfIYf6JeFG8vsTl/69sylonwHMLI1ZZl8W
	 H6Io7h98r5kRoggd2B5pFkuLdvYVCBF/kSxKVquYhOqRcZIyOdu/W6e9TI1iDJFffhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795822917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NQVMeYk3238ZN7qJr+WJxeI68VVfmiTTOo9wXCm9I/o=;
	b=I9F6acqxcjifPoPqMbpvKqP+hv132mxgdySOuSW8zXvGKoYhH21wYkS4u1djGlf4GA+/
	 XC6mh0xDajD7Rb594M/e0YzECn/lTLhLh7pkotKlNWi7s22HKLasLzISweHAPS835/Oh+
	 A0C9j2JY/J312L0MZZtk10vYIfkI0JTl+6IbhtAgO+RAf0v8xVGC9XLjJq4TW0iI8gbkk
	 sE8+EMN4umrMj2xDsOUA/boDJ5J7Rq6vsHTiELCiuTgO80L4sC8VpzHTARQnyf9BzXppt
	 nV409qcMdwFRLnYcQA7cmYQj8SFETHpav+6JHanarcPBxr0n/nFP0pGflewC5GovwSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lzEj3xvW;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5461C606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 23:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5461C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lzEj3xvW
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso31401555e9.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 15:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795822916; x=1796427716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NQVMeYk3238ZN7qJr+WJxeI68VVfmiTTOo9wXCm9I/o=;
        b=lzEj3xvW8xnb5LoGrBeLAyqPkKTm4b09slkX8QukgNJSARWEdE+M1+CYoYoFGTDzVb
         gut58XOXTzCNtaVMgHzlGC0XE3NpVTAbcCltHQz64CCsf4KgHs0Fb600nHkRp6SG5qUD
         K2wgLIk93KjTTbywCBZNVN/uITTR+rZYcJLcdWMp8OgAJVzUE49dCbnhyqHzM5nc8fKT
         u5uvEl9OIJXIuOXCHwSUxVSKcaLv+5CQg+VcjLSvNLoRFytZdPXU6OMawzg+ylU29Bf3
         sW4zizsbRRJ+Tp/1+GQyiu+/bDYsLfezFoi4rR/1hBmUpZJixygViMzv5rot8it8IalD
         1VjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795822916; x=1796427716;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NQVMeYk3238ZN7qJr+WJxeI68VVfmiTTOo9wXCm9I/o=;
        b=FMnim57DV5TmFNfdC6njwz4IXZlJdWAxL+Wds/V/gSd6d1zAPypDkfPM76lAQom3Or
         xjn4jdlxLr271hVU9Oak9B10nMoqVdOMfRtwEuYhVCJlJXqu2uy916qi5AWdvdwJhBYx
         IIdgNp56eFGlvBs+Pm5dISBcThQQ6mFuyL0RjKmFgigrcSo4tiv7XiLMbRTLVqLZoyfl
         bUAONy+vGRfI4tThuybTGVtpE2HlU0yJkxgWo4YdKRREcevKUMevSKSc1o19VVMg8jKy
         3tJw0lECIJk0vR+Z9mJUPJnmTFF06n7br5A/Vsi2Nt5wHrJSwd+MX0Nwc5l9AMSrpTT2
         kf+Q==
X-Forwarded-Encrypted: i=1; AL+hErH+FQderhD3RszDYd3R+xKAxfCGlKYqQKi9nuEHmSS6jyTJ26kOXSz+SLPpLhGh9Eo64vOeBFo=@vger.kernel.org
X-Gm-Message-State: APuU4Z96fxlGYcMPOsiNZpIODqyHYT+LuCL+yk8d8Tmyz/24mlSVMXSu
	Z15g5EVhgZYoaUZMiyLHz8Ol1RhxKuHRD6j/D8aQv6F6JLa/X1kddkCM
X-Gm-Gg: AZFdTZckQ/INeVIsnxvuqym4/wTtZw+NnUyo3Kpk4SJidyeHGYS2/QMGaSpY/DX0vg1
	0BKmc6BXctO3rVmXAF5mvAcr91egFvWQxp9252Nlcik4c11fzAdx82lW/OYvug/N4jffqqBgddt
	5psfMjuxKHLTfL3iGzkOcQ9UfOJ8cq2pSOyzbhncOrd7oQ2NyfQDSDbpg2501N7DHJKu+QaWGGz
	3faSC/SVCt6afgrcRYKPoEFSPXSGnKGTyb9Memo6GyG+GnpbP+F0LunwlgHsL1ENBy2mqDQoMWr
	fOiS8NXSD30I7h6m+SeEAeOrkETpLUeaZ/Szfkfw9FwUnXMO/73oeH2Lb28oaqeVgcETvae+WLl
	/CSoR8QBu2JsQquPTlkUxwQeWG7Y/P528E5V0kDFTZH7ARvsVxwl3roZbeu0sEOVY0rZvDcqyVy
	N8nqqbJ2o/8QCyjS9CYpKeRcBUqn89HGzHD7sXTiO4sNuhVVVtbD61lG0Pz7tWFjX+4YtRJh7Ou
	8VXlSHWy/kw+ptgSvhsE44a8UHNbyubvRilkJb+ul7BCRoGw++Js2QneXwRnq2cCRIPNapTn6hT
	lpzxC4xBpGpoWowKqE+aS+qEvmDMa8i3Eze6lUjh1PzpVqanKV0ocnlbwnFFhOI3vnDND0gBDuc
	+wjGD
X-Received: by 2002:a05:600c:5308:b0:4bb:76d6:1f5d with SMTP id 5b1f17b1804b1-4bb887ca192mr532417645e9.2.1795822915457;
        Fri, 27 Nov 2026 15:41:55 -0800 (PST)
Received: from utux ([86.49.161.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b216esm789171825e9.12.2026.11.27.15.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 15:41:53 -0800 (PST)
From: =?UTF-8?q?Lud=C4=9Bk=20Habarta?= <habarta.ludek@gmail.com>
To: lyude@redhat.com,
	dakr@kernel.org
Cc: airlied@redhat.com,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Lud=C4=9Bk=20Habarta?= <habarta.ludek@gmail.com>
Subject: [PATCH] drm/nouveau: fix 64-bit divisor truncation in DP SST calculation
Date: Sat, 28 Nov 2026 00:41:26 +0100
Message-ID: <20261127234126.4539-1-habarta.ludek@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The DP SST watermark calculation uses div_u64() to divide ratioF
by the total link bandwidth. However, div_u64() takes a 32-bit
divisor, while the calculated bandwidth can exceed U32_MAX.

For a four-lane HBR3 link, the divisor is 25920000000, which
is truncated to 150196224. This results in ratioF exceeding
PrecisionFactor and causes nv50_sor_dp_watermark_sst() to
return prematurely without configuring the DP SST stream.

This was observed on an NVIDIA GA102 (GeForce RTX 3080) with
GSP firmware 570.144 and a Dell AW5520QF connected via
DisplayPort. Video output worked, but audio remained silent
despite valid ELD data and successful ALSA playback.

Use div64_u64() to preserve the full 64-bit divisor, restoring
the original arithmetic semantics before the conversion to
kernel division helpers.

Tested on GA102 with Linux 7.3.6. DisplayPort audio works
after the fix at 3840x2160 and 120 Hz.

Fixes: 7e6bd6409b66 ("nouveau/disp: fix post-gsp build on 32-bit arm.")
Cc: stable@vger.kernel.org
Signed-off-by: Luděk Habarta <habarta.ludek@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e91130f93db6..7634147c01ac 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1661,7 +1661,7 @@ nv50_sor_dp_watermark_sst(struct nouveau_encoder *outp,
 	//
 	ratioF = div_u64((u64)pixelClockHz * depth * PrecisionFactor, DSC_FACTOR);
 
-	ratioF = div_u64(ratioF, 8 * (u64) minRate * outp->dp.link_nr);
+	ratioF = div64_u64(ratioF, 8 * minRate * outp->dp.link_nr);
 
 	if (PrecisionFactor < ratioF) // Assert if we will end up with a negative number in below
 		return false;
-- 
2.56.1

