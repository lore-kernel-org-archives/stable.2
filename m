Received: from mail-lr2-f4.google.com (mail-lr2-f4.google.com [74.125.230.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DC4AA3E0
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379227; cv=none; b=WnDCgJ2jUJiN7cyMoBFotKT2nvtUS96+ft5fVKUN1azZ0HyJruWMUg+7sYM127n6tde92+SX+VJ6ass0wPpzNbbmuOrTisAxBxALM6ShYvuBK+d0EYAarSDYF9mfi6twGwLCUjkIXEozHMwjQu+3XV7PyLDYpMIeZ9A6j2s41sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379227; c=relaxed/simple;
	bh=dt+iyPLWpcF360xLAM30G1ETFTnzVRW86LsgH6o0f5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nyAQFiJWq+avr3PG28rrEyfbT8VBbzTFIUBDLXPWfakYe/aFjSsIbqn1cNbhLp9id5UlmtDQX92uEREsw81e0UKmNhMQirxub+Y2CuMLhpWBDZ/u44zWGB6xGjCefLaxvRU22jDHYCA2B6HWV4Big4XXcsozcEX2qvwc1v0xh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIvKpJpb; arc=none smtp.client-ip=74.125.230.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIvKpJpb"
Received: by mail-lr2-f4.google.com with SMTP id 38308e7fff4ca-3a777133146so24683521fa.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791379214; x=1791984014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPdX/wtfrIoJuU3T/PjxExDIh/LQdp4FgVNwlqulZuM=;
        b=EIvKpJpbbLYq6BqGe9TlyJ+taarNEtMHAdIMHLWtjhNe1uh5WzqQKMGSt/x3aknKY7
         aXWaKwaCtQb797mDCgfg1pMiGpf+C2+qPN5c5zpr4clHJ0gthIAqNBnIPQIbzU5fQkWx
         GjCf/dJWHJwi4Xn/mu6t8ldQvwSMNv5hTAohsD0Eoz5SR+JqYfXVWS5bp2FDrwBBEd4V
         Koi+uvwei7YTABYL0sXUE8u7uGiR0wHyvwAzqj/wDaDTMWpa2fJhZwE3P3Ftw4XjTnCA
         g1NUCCWRwyn7AZwEleKhKTkobM+oZVv+JlK861ZjiFsifL94d8RO3CbBOm2xm6VySSWz
         52rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379214; x=1791984014;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FPdX/wtfrIoJuU3T/PjxExDIh/LQdp4FgVNwlqulZuM=;
        b=bhETSFsYOPdkImunGVFOyTTm0BxJ6GEdBIdtVYbJuwwIBApskAkbs5xOEhbMul/D+Z
         N6EABLEq+Hn7apecNFmDKFPUmHO3J3GwHQOzaw5UMP2XFFoSqEvNJHaCGNEIbzXfSMDL
         eKO3kipx82G6Zj+dxOoBBLMHgderyIVQMhWkdIju70gGE7HQpYDqivffWAGoCUCYT7RK
         rXTXhFhIp+dq9kOBDHfc6vJ5/jJ/FZjojisy3yGdF4uNqcf8T6iKuBXjaudle0Ad0a0C
         93G9JVcD0J5cX9b+LbYLS+e6OISzN+kFQS0/CyN/mpALh+FjzOWKDMJEDXIyMH3t66+k
         og4g==
X-Gm-Message-State: AFq9FYJYDu6O1OR9MaOz4EHcnzGyx8fNwetXOxM+YeLGXqzgrn3zunrO
	g7qU2Nw5bVpy1xOYdjvC8g6SDm0EV3TiL3gvlP2oy/ehM4+7zu+lvSXIX7roM4ge
X-Gm-Gg: AYBFou1LQt7Gb8WMDU+FHjbJuVuA+wmYcguXiN/57uyJIy/Wfvhq72queZGnSwKgzfW
	gMUvu9vqba+2RwnXvX51yau5sQCdJXueVubusKlQnZOJ/jls0YVLABkojeRumXpd5fAk1Qu1s6e
	KQCatJSBJ1A+qiSlTMt7Ey0756cmmvgpS8jcUbK06gYguN34BICtY1PfNEKBdGAF94NM/AbtV51
	vRKo2fqwbikGqfKHh5fP7+n68qfqRi2PjXlvVaFkkIyZRMW1PCXbK0WYc62nk9ZYYYrrS9cqMvH
	kvEKa0wE9gKuP2wjvFOMbCz64SYv4g/eEe/mk+chtZjDJ9N5CJJ061ZYgpmImb01edL/Kob47WM
	5ThSe8QGIhWCjtcrquk4hWdumbBfz48q14lnTKg569SH5ZS0/JHoVt7/P8Fk3+p5urCy/EPM9gz
	u2TixG+RnwY6OholqM6Mc/5g0GzP+ak4vvkMIyvoXGW9SP+2cXcmLn8FozPZhJAf/bIbNwi/l2G
	s863tsKlrMThPdDog==
X-Received: by 2002:a05:651c:553:b0:3a2:f233:5c6e with SMTP id 38308e7fff4ca-3a9a2c65959mr5044541fa.6.1791379213808;
        Wed, 07 Oct 2026 06:20:13 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9a1a9c423sm6097951fa.0.2026.10.07.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:20:06 -0700 (PDT)
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
Subject: [PATCH 5.10/5.15/6.1] drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring
Date: Wed,  7 Oct 2026 16:19:36 +0300
Message-ID: <20261007131939.120898-1-roman.demidov.nn@gmail.com>
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

commit e5f612dc91650561fe2b5b76dd6d2898ec9ad480 upstream.

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: 6ac27241106b ("drm/amdgpu: add JPEG v2.0 function supports")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 96179da0c6b059eb31706a0abe8dd6381c533143)
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-63848

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 3301ad980f28..af8f244e9c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -762,6 +762,7 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v2_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_0_dec_ring_get_wptr,
-- 
2.53.0

