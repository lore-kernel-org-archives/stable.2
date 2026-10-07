Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A34AF9EF
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379636; cv=none; b=n6Eli5MlYVkSu+I+mjA4qylyTrHKKu3F/m3pwOnxs0roWkrjdZ4jeYN+EaZw23HnQEtl55g0UlzTET/MwuOi/3ovGStGTzTppSY1IpCaQ1CsYj7W3iDFGwxODQFoxDccYMpdFe4jcJWntViy33/K/+T1vgqROMGOTZ6BDF7ATew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379636; c=relaxed/simple;
	bh=9FFiBZzNjNWizqOL3HznxfsDwaJdYIPdTLjkyHpckoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ftBunZjL2bMHv7ilAgSMXSy+svxmOohvpv6uQlFySlBnS4WclV+1cyDMIo4KBfFrzzkur2n0MDff5Pb56ye31O7oJfbWffWtmgEpirEvtBUZaU200lHwaPmIsQX8t/DT2l2D8PUm+9n5Gh8od4qc98ciSnED8M1iiyznvs8VA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phn8VEFb; arc=none smtp.client-ip=74.125.230.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phn8VEFb"
Received: by mail-lr2-f3.google.com with SMTP id 38308e7fff4ca-3a77df9781eso23106231fa.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791379616; x=1791984416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDQwNh3Y7ViZN9kSjBt6rSxx3bjORoWLA033ou0tHZw=;
        b=Phn8VEFb6xWOkHeeaUtUMeN1rdzOKNssukJec3P+McjRuy1frUzt2Ydk7nXScKlGNA
         vZ+80p8gSADAV3DT8Cxp+Dr17X94ZbyTLX0eqgYQtnEx7cZVnVTOLoTkAGWfjmK2aA6v
         EOVBj2bwt9uRyaEQmJ0q9nRaw32aErgGeClKCf9tJ25l9P8DGu2DHzVVcTu9QzM7/w9/
         zAiuBKH8AYaqEWd6rVCnQMjzFZApFGnxfHY86RlzBiSnhoSh00EfBURJEyeb7GM+/4ld
         gHlgdJsSkauJBjG+EhPeW7rr3HKccDC/WCnSJM/jPemfBmeLAec4gmKThp1P4kS3n8Ib
         9f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379616; x=1791984416;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GDQwNh3Y7ViZN9kSjBt6rSxx3bjORoWLA033ou0tHZw=;
        b=ODtWOugPUh7RA59jAf+yoDgM6SzGodsFPfYiEJvmoXu6P6e52uQDm/6qEGJPnFiOXC
         B3AP8HJPGz3fbmATGrrteD+Bme0tXUreuO6g3Qpa9MiVAxfgNSi0qs9ppfNGfMDg/5po
         v+M/TKhFWQwyGEllrKnn6gOaV+l+KtAcKRUlmAms/XSsEKL7Vv77WksIMTiokRc2eDgm
         tipK0yTYZidKV/ZiEjHzBgpBIpSXJt8Q3idzQiKw5riGZTR0WcYhD90K8Z/t0MhKQI8f
         LpBQiaTF+hy3XLr877lZPFmwEy26QT75MCwaG+0jKY34JjLfX+ZhiKzyWWVNGgLRbapq
         7rHg==
X-Gm-Message-State: AFq9FYL61bANFr9zdG3ZeRTM1sdTGwwkjhxl38RpX7gAw/t8lm2644Wk
	p2kOLdY0Up4FwLhNWztqvkXXwGIBR7ovKN4A8ccO1h/uuPkPFpqBXjmzoGy8ruO2
X-Gm-Gg: AYBFou1xSMeAwM0efVPnAfhk6V78bhOhTQETzEXwKLyIaEJmM8CdOXC6V5TOMFY0WW2
	BLgCAJI/m0u0YPlCKSm2XCP/i+ln3eJXzTz5tRm2At7nLmFxoireRqqYtRHmoHPhSSnb+5p3j7j
	FNHm/kSza6YII43AJ0vG+SZmbobmAg3Ix/eMZMc4Kaq23smF51kP9ltli9XLtGA7VUcZxcF1zqA
	cxnMFdjkcnFt4ai8MhM/HquxenPyEvLBg7bdV5sIVw55A9Lz8zSSVzjs+C726CxZvRB3yOO54un
	nA1x5tKarg4KeDgrNqR+2r5uVQw1qkVAXfGq3Dry2FA0Hv6jJlJMSlNUqee+tRkd0E1R8cmWWH4
	9dW/JhCa+crtXXzrhQ5XFu96cYY0+2jrjMhYL+5B5LtC+Ea9S0JtrXBM2qSUt0KuesHaHqwMHeo
	9sSMOCSetneTEPCDU+ADWM7hJSj2h0xmAp6Imq10YXqo5NUZRZJvcD/AZYR7fsSaVDHXi20zzgR
	S4T6J7/Z/j2k6sa
X-Received: by 2002:a05:6512:3a87:b0:5bc:b962:ccb2 with SMTP id 2adb3069b0e04-5bcd074b8f1mr877734e87.63.1791379616009;
        Wed, 07 Oct 2026 06:26:56 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcd3083558sm32201e87.39.2026.10.07.06.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:26:52 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Leo Liu <leo.liu@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Yinjie Yao <yinjie.yao@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15/6.1] drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
Date: Wed,  7 Oct 2026 16:26:46 +0300
Message-ID: <20261007132647.121360-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yinjie Yao <yinjie.yao@amd.com>

commit 79405e774ede411c6b47ed41c651e40b92de64a2 upstream.

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: 14f43e8f88c5 ("drm/amdgpu: move JPEG2.5 out from VCN2.5")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3216a7f4e2642bda5fd14f57586e835ae9202587)
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-63847

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index f87d0f6ffc93..a094dd138c0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -641,6 +641,7 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
@@ -671,6 +672,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
-- 
2.53.0

