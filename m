Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA644213C
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394342; cv=none; b=X6QYjkAeXXr6iK3CAZWDZ7ozRGOyiN3KZW+olgCWEOgI+R7q59QZcR/gyMxBQk1qvfKW5c5YMthw3RY8SU7IZYOpLF2wMa8kTfZW+ELBXxjtt+BrFVOHRtK1x3sOpYDeP5aJEP6h/xAL2fxzd3m0faAlhjxebvdyTEDbX+6oGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394342; c=relaxed/simple;
	bh=Os1DpKb5DvVXnV4vccSHoH512pnwHk/C+aJ0z4dVEGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifs2Gp6hMN1HQDoB3oNBynMz8IPNhMNCOgkAyI8bHe3/STdG2hyA4TmH2rehRH/KSVCGLjEpb+OzBJTHaWCuDF7X2Zp8akPGCz8OXWgr1UUNRlkr02Rsq3ya5f1aRgnyzTPZUggfqcO6xQUXdJ53DEsc0YybHF/QEfzF2/h2ydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMLqWyXi; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMLqWyXi"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84864086bfeso421453b3a.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786394340; x=1786999140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGxAuLzZZuFS+OONE5xJE8lS88pl+UeA90EgJEUUW6g=;
        b=lMLqWyXi7/0bBp0Cfeli4PqiAOgcl4vmFc41upU6XAGFSMyJmgUO62UplOYmlwR/T0
         u90oZMekcTtgC/8bVjgfUCBEBXmeXljZ5EcvodyyEweWUUmk71B9aFKGZIaaX8PqgV2d
         VjsKdQX/pc+04sAq2u97n31h7vyINuyjJBg7E0Z7Ov/ZuTJxSmBGOkQ2eBPR/fQZIF10
         pnGCEQFz8aorLSRgSFt9AJHQyE9/YgBxvfR6ueBYs00D6dJjhHXK/1nQD2Mw54Z8byuw
         tZxDdh796y8IV4FMkseTI+qh0wdLdrZ59z8lyovqFZ+KdT5QaLHFPdcjQJQWMumOCkfJ
         WBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394340; x=1786999140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGxAuLzZZuFS+OONE5xJE8lS88pl+UeA90EgJEUUW6g=;
        b=NMIhLGvNalYFEEGLEAiNq38j4vsgfBNzEJSALqRmTwwGt97dxFrOJ3kgCxO/AVBYbC
         YZemTJYqjCthFD+md6aGvsFuOwg/9uTry6Nx+vLTIaO5fvrDa+/9ch35AroYiUsltOeI
         aBrmUxF0+nncKYpkPAhmRu+Sj8CVVvtBlaf3lGUpJZ2yNf0H4WSpK8hS7XEXAAXoIN5r
         etp9dZVg7kmBiPqVacTIoXJZGRs6Uh/LFoXPNJl9fZtnWYel4GYXRMdXCmK1nIjaxreT
         j9mIpGoCZTA0ACcz54S/g3+Mk+RpIDuy6JfUFvBLhKMGCXy2uWb93ayUvVoh5fu7BKs3
         7fBQ==
X-Forwarded-Encrypted: i=1; AHgh+RoeIJCaW08TbmQRIL1jMr4iFV+k7Js7zOHSN1HWiI9nyiwC4yETVbpm0ioZnF3D7FcVj468Ibk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTlORqdp1Qcm3gBfCrlkTA2vS6Ja7G8hc/fCRDX2DTJ5xdgeMd
	0ZuYV+CqhkAsVRiuMtz9VKqr1ll6FIcaRl562NlYRMQM6seOGEh1lW6B
X-Gm-Gg: AR+sD10/d1+kKenQ6B8+f1D96Ndyqb3jGt20SX3vHLLnAm37r9PDlT6fWz+jJCuJWAv
	pF5nLG6KxYKSxueIApb3jC06p/DJIhFhCU/KEJ71UgcMxobDDFsLUqIeCpLcpS0hcs7ipJW+a34
	lOswjaN5BcL+PidqQkXeM1GzVNrvmBsm8nptBXVFkwviC4l/l2BYrfhKizV06IqlP9Dqe4n1qmR
	7crpLM2l99l99zRlO2t+GLpck/84Zv01nJcYz3wGEbqoyPnXdb3vXgs3t0TosROiJuapiciMBuC
	Wtf2yL7TdIIA+HmWWEwqMZCmLL3FkUL9p6cQawZEjEGGXfm6YBYHbp/5NHVr1g7yZw7Cbhy2D/A
	lj+bkAX+mG2qfGtPnTnQvsOGThKxKasE2UnpoL58aHwYtJ/QLG98t2h33DQxEUCNM/hPKMjk0Tz
	AVwBeS6MdF14WvbsFCECFPBJ3AwZC7uuX0SGQZG/aQa3k/3oAg8N/CfYWt1QTJv/dCUIVrSA==
X-Received: by 2002:a05:6a00:809:b0:84e:915:d7eb with SMTP id d2e1a72fcca58-84f9c9b2da1mr4339437b3a.37.1786394340150;
        Mon, 10 Aug 2026 13:39:00 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm4324001b3a.43.2026.08.10.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:38:59 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 04:38:20 +0800
Subject: [PATCH 2/3] drm/nouveau/uvmm: fix premature region free on failed
 OP_UNMAP_SPARSE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v1-2-40df1c046b49@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786394315; l=2150;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=Os1DpKb5DvVXnV4vccSHoH512pnwHk/C+aJ0z4dVEGA=;
 b=02MtHdx4r3dcWF4OJYpzk/u7l1R5qAALQu/9EvZjdicY+x1blHF50oc+amQtWtok05bowqco2
 GB8XXhKK5NaCpHbdzLxx9r4Ic66enivHaHfyhRMZvNxhLhbx+KR24fL
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

In nouveau_uvmm_bind_job_submit()'s OP_UNMAP_SPARSE arm, op->reg is set
from nouveau_uvma_region_find(), which only looks the region up and takes
no reference; a region's sole reference is its membership in
uvmm->region_mt. Two failure paths leave op->reg set: the -ENOENT check
when the region is busy, and the drm_gpuvm_sm_unmap_ops_create() failure.
The sibling nouveau_uvmm_sm_unmap_prepare() failure just below clears
op->reg; these two do not.

unwind_continue steps back one op, so the failing op is skipped by the
unwind loop and its op->reg stays set. nouveau_uvmm_bind_job_cleanup()
then enters its if (op->reg) branch and calls nouveau_uvma_region_remove()
and nouveau_uvma_region_put() on it, dropping the tree's sole reference
and freeing a region this job never created. The comment above the
cleanup loop documents the broken invariant: op->reg must be NULL on
submit failure.

This frees a live region on an unrelated failure, reachable single-job
when drm_gpuvm_sm_unmap_ops_create() returns -ENOMEM; if another job owns
the same region, its cleanup then removes and puts the freed region, a
use-after-free. Clear op->reg on both failure paths.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 849bf42c124e..3412200b21fd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1319,6 +1319,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 							   op->va.range);
 			if (!op->reg || op->reg->dirty) {
 				ret = -ENOENT;
+				op->reg = NULL;
 				goto unwind_continue;
 			}
 
@@ -1327,6 +1328,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 								op->va.range);
 			if (IS_ERR(op->ops)) {
 				ret = PTR_ERR(op->ops);
+				op->reg = NULL;
 				goto unwind_continue;
 			}
 

-- 
2.34.1

