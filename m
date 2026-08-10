Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9323644CA
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394334; cv=none; b=PhaJ9brnfpj+BcM+r0+ddcB9B14QIfgxganb8KPvokvv23NHZFEimhDEohp5M6d0SHpMPmHf3S5lDYZktE4uxUgr2UsIG57eTnRLIBGZ0GkoIdHeuNQ8lqDsZ7hwe2oTNKApsEhR832l8em2O2UOgdhg7Od8g4C0F2q04SNrQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394334; c=relaxed/simple;
	bh=+VNmEkXChlpNLC2AYrdH2/Brvmpt3yR/AE4J9z9THqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzILK/rBPuyUOzDZCUAkG2Ydj1oxtnQe+Ko7f3aHfNcSke2C4URa0OE08TP9NBqCZ5cnNullLTmKKCTWBt/DeN3XUiySG6uE+HpwZi4k8f6dTgxj72PshDHpPwWEeHrmG/1c8DWWMrmcysT/QeOqTYYYiXOL6yvbIeSGaj2f3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjWzjuwD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjWzjuwD"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso2383006b3a.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786394333; x=1786999133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vyASNIeLKFmcfAoI/F9+fyrmwfgxdyCWxlnFqPLO/WQ=;
        b=XjWzjuwDer5XSrHfRIRRJdOQlrbfJCxfTdywX1FVrDnoqM9wPtZTSMRJ8YG5LEUfKR
         Zr8YO+d/pv0NWK84OSiNNPh4Rdp190NqpTmZmSbRON/Qw7UBXfPqNLwbpclqxhDBKXy+
         7fmj8xq+YL5Hf8PvQniWLJ6WZ8NGmLUVXAjy9riqPvg676MsNB9s8G/j5TjITmIK7P1D
         GV56V39VKDRc1aoiXgO6Fiw+xBNPGdjXgXWEvcihScQBvR/fcYPV65X3MXDn95eS/tyt
         pqw7+guUmFZ71kwmaeeJlj+f5O/4xKCPahDRkxqo6YU/a5WQGWATE34ObGzkdDA/hB0H
         stDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394333; x=1786999133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vyASNIeLKFmcfAoI/F9+fyrmwfgxdyCWxlnFqPLO/WQ=;
        b=ZvDq+esVbihzKlOAsNDxOWeg5/8kKzTRRyaRfLRkejn7paP2xB27NsYdWOilM3LHll
         MylUB5pZAu52CR1VRjxdWjYHnVjAeZVBtmpzl/YUcXNQw6yJnOttN7J59SjzrYD6VW0O
         OssJdKyIZYVptiA8orEGN++BCLeJcifDqee2lLqms0/dBm/wfcclRNm0A9qWlmhKCT09
         7yHpxvUUDw7EaUsTg2XVw0Xn4SxPSOkDgoHidK3tvb36V/c9vikOkYVRO7UOFF/dCHZj
         vLkCernV/7+XBJPgtwALB4vympqbe0+ltklrRnakyeiFc0rWchVP4FbMNh0bLzaTFW+j
         RAdg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7pksEb8LiTlYiuI0wM4qhdSVLwD+gFaBfPpTfS6yBFojPr1Zu2nObOQyoYRBKbf+2DKG0XxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHvGwfLOU8sArT5Uxa48b6gnlzd5CJrP9hPgaFXS6/oD8s5RUX
	TIHiCwJ1GoSQWRyEnpI+npgnuE6HJvuiCucf4qurcwOZ9sWrFkBT3i4b
X-Gm-Gg: AR+sD10Eeja2Tg/6gQaj+tEZF5nwCDtR26qAkO+jowKl8mwjnMye7NxkqDj5t6Kt8tx
	P7O5t4wpL2uIQudX9AxH3/uBMI89q3JI4zuPqZOmNpte9mezEd0OfU/qStM6Xv357PUHoOulSfS
	HTPJwJbvwGBLzvvgcFwFQZYS9TdlW599ffHKgKTOTJmnQfN0iYw/S0AD2SRncg1PNsMUzJ7pH/K
	oU94C4EeWKVD5yPfHrWHS1im/E9LJlo/3AzD5x3iCvdVCu4Cy09IX8mW5cML0lKQmRmYSjYD4ZU
	PHCBC1t1ZsohlmxBfUBeEl362a0mnyKV1jP8FS4yHu4aYjP10YmSrgKloTsiXZFUsetWIxqXmJY
	fvnb/jVHYDFvj+6YwyBMGTSsKgqIPiVEO8IWP2fK8Xth+41HH+faBUW53sJYj0ECBg/vEWUu/Nd
	Vr1K/HSlD1ZmnVMLxY/jfzyWsyxzBMyfsx+IY/uQG9XB3E/A4PtWQVXQgOVBnm
X-Received: by 2002:a05:6a00:a16:b0:845:e9e8:645c with SMTP id d2e1a72fcca58-84f694201bemr23429295b3a.6.1786394332889;
        Mon, 10 Aug 2026 13:38:52 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm4324001b3a.43.2026.08.10.13.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:38:52 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 04:38:19 +0800
Subject: [PATCH 1/3] drm/nouveau/uvmm: fix NULL deref unwinding an
 OP_MAP_SPARSE op
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v1-1-40df1c046b49@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com>
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786394315; l=1520;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=+VNmEkXChlpNLC2AYrdH2/Brvmpt3yR/AE4J9z9THqs=;
 b=2NVSFVBq7bbrQhlqYPoKCXTQi2womiUgrJtriPaq6KwXJpxK/aMIt6Q0SRgkjDUwQ4FsKnysG
 32+jbbJ1TuXArtF2le4b7Uu4n1tGts8GEPg7Dc/xL8VuPg1ju8U6qyn
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

Each bind_job_op is zeroed by kzalloc_obj() in bind_job_op_from_uop(),
and the OP_MAP_SPARSE case in nouveau_uvmm_bind_job_submit() only creates
a region, so op->ops stays NULL for a successfully processed sparse map.

If a later op in the same job fails, the reverse unwind loop revisits that
op and calls drm_gpuva_ops_free(&uvmm->base, op->ops) unconditionally.
drm_gpuva_ops_free() dereferences its argument right away
(list_for_each_entry_safe on &ops->list), so a NULL op->ops oopses. The
path is reachable by any render-node fd holder, since NOUVEAU_VM_BIND is
DRM_RENDER_ALLOW.

Guard the free with IS_ERR_OR_NULL(), as nouveau_uvmm_bind_job_cleanup()
already does for the identical free.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 36445915aa58..849bf42c124e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1489,7 +1489,8 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 			break;
 		}
 
-		drm_gpuva_ops_free(&uvmm->base, op->ops);
+		if (!IS_ERR_OR_NULL(op->ops))
+			drm_gpuva_ops_free(&uvmm->base, op->ops);
 		op->ops = NULL;
 		op->reg = NULL;
 	}

-- 
2.34.1

