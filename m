Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A73423A9A
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438043; cv=none; b=l3Gr/1NEQwOIs3LMtgMSk5ccnnzC+ZLtv4I9QHVRVJ5KugguLe5VUKaLvM+ac/Vl9+btcM+m63ESPYUeKsaX2ePA4LJOffoytZ+uBQD8PME0afMR55eKvG+A697DrV0VKSE4H2nmKeqamTgELuBDdEDhul8QeteaRSGUTciyRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438043; c=relaxed/simple;
	bh=lIptHHN9gxorlm/NvGtJXIbFnkM/mVFweQW+foQRg4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5ddgNlQRU1ipfavV7J6XEBkY3Tz7X1Rta2+hK+TrhxzYTf8N8Lsr2HMK2QFr109a6N5h736D5QDXeyOYGgDFMgYGjwJD7j6EhYFIYBHl45JkjgFh4DtTjC/a4YADOS4OABWg80/e8Cfp0580LBYJoDzDeqJ2Q3rZEV454590EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRsqQS5W; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRsqQS5W"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e041ea211so3248280a91.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786438041; x=1787042841; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHAeoyo5cMJf1W0mZYzZjfd/SrG8usIZS6fsxweLRlk=;
        b=SRsqQS5WCI8mVw51RuYcG8PtAm2hM96fg6OO998ADmOq6kad5xDWf4vAjZylX/5Fqn
         W3qc1KHizeXOJI7H5KRktGYVvTSTgjdBGXIi7K5REMhCXQKthUyaMrRq37f1xtIqm5Eu
         uodNBVU074Vmmuo9Z5ZS2DljfpkeL8427C/K0cQ1wkIwO3N8GhuAfE05wQBUxM/E1tgm
         OznC3YLD3MBKOyclCwFLlYNaZaOscvhqsBketHLMN2ZbrqQHXdpmdYXvgjyzZMKD/njf
         H0VbNu/NKmrXwz/mvGNur57iB40lacDxrjQowM/a1oaJxOAgFqx283LFovnWiUSqiAUC
         bgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438041; x=1787042841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHAeoyo5cMJf1W0mZYzZjfd/SrG8usIZS6fsxweLRlk=;
        b=Ibx5AQ0boC5R/WsqG4sNl2XgdpQAJiKDS20kY3Deude2hwJYkQr16diaBC7uCH/q6K
         FXxmKjzBKBjiA+nhIYQsBavje4T2pR5N/Dv5V14qS6exCTaUYuJlpVip85/0qENQAcdF
         u63CL6Ejb9Gbo43qLqiHRXLJGPtw2HYYYytvFu9pvwMG3M2maNNk+FZoAc7YmaIeNy4r
         7eYtPRocKWf08S6/5WIW6V9TpODB+F04yJGuMrlj11zCIjR7SShZyOoIPq/n4jiyKLYj
         EF5YtkGg4gr2WQvTUbgONV99ljPbiYwRp8Y+uYWTfgS1zB8Hn3pDoWJp5dsFSyAOZ5W6
         7uxw==
X-Forwarded-Encrypted: i=1; AHgh+Rqw3J1D3jxG7Q9GcpJnFUFEQW91UDn30oH/LegwIcqIp1YDaiDFkHA1+VMH0VG2O1nz4gKa0w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxeenCx7sbmKvJNWM4mj7IQNJZc/Nxs1ygJzqA9/w1upkUuJFg
	EAX/jrSmicafH7u86oAhbEVr8k28xH+SH7p3Rf7PfEnTc7J9D4OZqGQUiO8QpPU+2G4=
X-Gm-Gg: AR+sD12Cl3TtyvPTpzvSjKKya4LAHBSb+1uLzENpJyMe1H0khxxnWiAvJ4Vt9S3FUWk
	rUANBs9I3IQf80XH9C4qMK86u8nMbdNUmvy+yqPNBq91rGhixk4vySXNWqhlBWR49coWmiqyqpy
	XuLAQn1pjuLmRc+k489BHAfodTF6OkGvq2oEGxxtLUApCauRlEtPOY+YHIaYr17QXfovlQmDdoX
	bkoheCjR/4G+Pw/ZYeiRftjBWjewdU9mrFMM5IIC8gXE54JcQiCT/oROD2wM5q11dAqD4hjkEvA
	ASndXU509LSW9zk8EdlJf4DR4elG+ys/zkVvtC4FFvnk7jVr1SDYMnni46sFct9j3oW7WjvzoVn
	0PYQfhrcZf7SNgY3svJYt18Em4cfCHFlmamFieHfS2UpippA+MMokh0pTtAoFr7YLLB6ZGf8Fks
	sdkUvHbczbtZxg6KNAGzSoCi5I9xyI+dsOOGmtuyh91mGlYLTJZdmrR4/jKWs=
X-Received: by 2002:a17:90b:5483:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-392ec4cf8e2mr1886740a91.8.1786438041538;
        Tue, 11 Aug 2026 01:47:21 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392e58a94aasm633058a91.4.2026.08.11.01.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:47:21 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 16:46:30 +0800
Subject: [PATCH v2 3/3] drm/nouveau/uvmm: clear the dirty flag when
 unwinding an OP_UNMAP_SPARSE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v2-3-aaee4b395d04@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786438000; l=1623;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=lIptHHN9gxorlm/NvGtJXIbFnkM/mVFweQW+foQRg4s=;
 b=BbY3eudDUU3rCJhubXR1NqITi9+XwlsZJYkYbjnHMrEnfLQTsJ3piqBsNjdoamVkGcHZ/Oh66
 8ZouVLyJEukCAvYeXRa06MN6LzT6WFM2hlbqZHknRlcvNwKCxLz3JDA
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

A successful OP_UNMAP_SPARSE marks its region dirty with
nouveau_uvma_region_dirty() and defers the teardown to
nouveau_uvmm_bind_job_cleanup(); it does not remove the region from
uvmm->region_mt.

If a later op in the job fails, the unwind path never clears reg->dirty
(set in one place, cleared nowhere) and sets op->reg = NULL, so cleanup
skips the teardown. The region is left in the tree with dirty set and its
completion never signalled. Later binds over that range then fail
permanently -- -ENOENT or -EINVAL from the dirty checks, or an unkillable
wait_for_completion() in bind_validate_region() -- for the lifetime of
the uvmm.

Clear reg->dirty when the unwind reverts the sparse unmap, restoring the
region to the state it was found in.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 3412200b21fd..76ab377f0e2c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1475,6 +1475,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 						    op->va.range);
 			break;
 		case OP_UNMAP_SPARSE:
+			op->reg->dirty = false;
 			__nouveau_uvma_region_insert(uvmm, op->reg);
 			nouveau_uvmm_sm_unmap_prepare_unwind(uvmm, &op->new,
 							     op->ops);

-- 
2.34.1

