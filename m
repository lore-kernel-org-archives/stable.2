Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F894472F8E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546631; cv=none; b=Pnx9AvNwKvx9E1QtoLUI+988ALrRdGT61xZ1Jxd6hninmtuBBzzN3hrAIIx3GoRQHVGWvBGoK/I+OZOZVJT/wipjsAbEmiVQsBhiydOJTnEqNXfB6PQlQ2u3pO93UshSfOMX7i37DHi4mbIlyIWfUMndLXtxXuVSmyeKmzTm9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546631; c=relaxed/simple;
	bh=FdyxRhhBKZiYZz3arqKV848UtUVhcBBrpdMBwG2g/dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EGx1+nmycKhf6ysHD80RsnGAsy8Vysf8iIAzjvNYb5/f1VLNHUJgYtS+2uwtyVfcYzRpKSVfA513RNg4rRrPrKyxQd5dKaLuIS+TaLtjbO/RasA77Go9+HVD14QEeZahe6rSq/Nb+iBQJmTXi0TLXdSB3pq+o56+3bv/mePtjq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAImTJA+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAImTJA+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ced3386430so13460545ad.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546623; x=1787151423; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YJqzV4FfWSH2549UJL4Hdtad7cbUf0wdUKVbd4knoqE=;
        b=qAImTJA+Yyu3BTpmbZsZWFWlulxKNHEeisg4eI/sTTi2LwkJdO1O5m86xKZhaijakQ
         5DvnNLDOG+X7Dj7AANQCYLdOooKI2i0mYyQwWt1FVPacHMURKg7+svf8G09Y3SiJhJdE
         FP2fyn2savUXxFK0z83oZRW/bHkVdIdWpzEHIW+QfvaJzLNOwcqA+GjjV1fo6tMpd+5n
         qHFa8Y5d2cMZ0ZOU7QCRU0laLLh3aQBsMBlooMpgGxMcbpOt4An7BF20NqhwJhgwL9rv
         b6Nl/bQKIkkCnbsWVNplI3s2cy8L+J6THa4LB1Fn3hJFpBr9UNfVSaz1XTCc6Xv6pbMi
         j2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546623; x=1787151423;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YJqzV4FfWSH2549UJL4Hdtad7cbUf0wdUKVbd4knoqE=;
        b=Gd2o3OkFXO3Tzqs2Vu2WOX8tyqi4vds+4akW3MjRircObMdk8IESMCiNdDrOdpzPtj
         3G3lsmKVuHXl7esteFIn5gvNeaa8fLfruoffgwIepidI0HJbc0NX7j7i9ct7gjMfy3xW
         kUD0REJkRhrH1ISMftCJPul3f5PIPbcmJ7Xr8raKn0YsDZEQo9xRgV0wx1FywBrcY7iI
         VoXKoVyp+bREwRWVGGlD47iXUE0NOK1f9b52JF0osGiF/JgAlwGs5imNucaW7BXd0mUH
         3+Qf49qR/WxPXOaeobJNoPKHFZPe/Xnnvo0dyO6wblZJ1Y8cNrlq1CYpJbEefSUPJsr/
         rFbA==
X-Forwarded-Encrypted: i=1; AHgh+RqYPSE21VBSqwzPsJ8xo/n3Pi5hNJVrNkos+IvgpvxnRsPTMRkOwhul8bVMDjIr9tv8k1uNy1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZBMO/aQePq20pKDdKTMoAThOKEdqBPZv+aY7Y72J844EIJXeN
	FTTbRmhnQVqq8ZlGs2uc9XXpyhFTvKX8pR7Pw8lB+C1+wN0uz4CFA2Bj
X-Gm-Gg: AR+sD131KkU1UU87R2I5An1iTdr4ovaZPG70WuQSIE6GdEcMdqDJCY6OvgtxXTkhild
	l+ByKDTTwbWtbqzb35LKrTyjsCuoOy+xHrXYKZR7d5lgM4oDyNaIxj7JCrkPYqxGH2xcxPsJEZV
	Ctn4c6h1Zg70ellmzn1dpLpulVwvvXmVc0NJUet5t1YALcRoJsWsqwADSo//nVt83LYjLKwpprU
	FvY6xKSmboHgR0bi/c9AT1oO4LCK9kOsRa5xiQMbyDCtFXWUuINBL6GnB7X5S6lEdOREm87fuJn
	cX7n6lGtNxN+T0Eo28iIth90THsZ9/Z1k9es/rGMRYVmRuJ7NuW9CN+jci3WoONKB/OYZlswPIF
	qRwY/vMDAOrzLsWGHxMuIKTRwnZor4r15gOLJ3cdqV2M73k1uFAfPI8JoPIHAqCkyyJDFtYrXw8
	u9RWqMPwcYut43RPBJ7M4joyx8iQA8JN1D5xB7yYUXSevLflUMoiFXMA2o8Qo=
X-Received: by 2002:a17:903:324d:b0:2ca:4f33:e86f with SMTP id d9443c01a7336-2d3455870eamr75737575ad.12.1786546622846;
        Wed, 12 Aug 2026 07:57:02 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d352208543sm8003165ad.60.2026.08.12.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:57:02 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 12 Aug 2026 22:56:46 +0800
Subject: [PATCH] drm/nouveau/uvmm: reject zero-length range in
 validate_range
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-nouveau-uvmm-pt-fixes-v1-1-ab3a823f946e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK2JfGoC/yXMQQqDMBCF4avIrB1IImjrVcRFjGM7BaNkTBDEu
 5vq8uPxvwOEApNAWxwQKLHw4jN0WYD7Wv8h5DEbjDK1emmDfomJbMSY5hnXDSfeSfDdqHq02qr
 KTZDbNdA95LTrH0scfuS2/xmc5wUrhSUxeQAAAA==
X-Change-ID: 20260812-nouveau-uvmm-pt-fixes-9706da1a03cf
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786546618; l=1968;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=FdyxRhhBKZiYZz3arqKV848UtUVhcBBrpdMBwG2g/dM=;
 b=ar5RYS5eT7jVtxn2WyhdU/5ZUt+UbSy5eflTkgD7wLRWZEeSTi2xLVN1+tdVDVmKDg8elm2v3
 1ZlEgthYLiQCWaVIbnBvP5OHkT64+EpC1XNJ887M4atJGbdz4l+31Wx
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

nouveau_uvmm_validate_range() rejects misaligned addresses and ranges and
defers the remaining bounds check to drm_gpuvm_range_valid(), but neither
rejects a zero range: 0 is page-aligned and addr + 0 does not overflow, so
a zero-length VM_BIND request from userspace passes validation. It then
reaches the generic GPUVA interval-tree insertion, where the node last key
is computed as addr + range - 1. With range == 0 this underflows to
addr - 1, producing an interval whose end lies below its start. The
resulting malformed node corrupts the augmented interval tree and misleads
the overlap checks of later map/unmap operations on the same VM.

drm_gpuvm_range_valid() intentionally leaves the zero-range rejection to
its callers; drm/imagination does exactly this with an explicit "size != 0"
test next to its drm_gpuvm_range_valid() call. nouveau simply omitted it.

Reject range == 0 alongside the existing alignment test.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index f5e4756b4de4..0efedd9ecc75 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1008,7 +1008,7 @@ nouveau_uvmm_validate_range(struct nouveau_uvmm *uvmm, u64 addr, u64 range)
 	if (addr & ~PAGE_MASK)
 		return -EINVAL;
 
-	if (range & ~PAGE_MASK)
+	if (!range || range & ~PAGE_MASK)
 		return -EINVAL;
 
 	if (!drm_gpuvm_range_valid(&uvmm->base, addr, range))

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260812-nouveau-uvmm-pt-fixes-9706da1a03cf

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

