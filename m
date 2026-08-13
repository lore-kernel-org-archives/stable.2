Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F243B2F260C
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627336; cv=none; b=ENY1/FvaXLDZ1ITM487Xhj69UFuQQhFH8PNpm3VAaCvKZlCeAUFT7r2m0pBCeZkTHIXbyUt6ln7zcjEpaPA7jGYeyywwlgFdZhc1e7jDDSAllYx78ENamoWM0o6YtrOECIS+V2b7V8S1kL4edpf0tcSDy7Niab872wbu24nLhgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627336; c=relaxed/simple;
	bh=MkqdAWdWz0lutQb8l1T1yO7gmyXKQ04Cgj/5wL4FwHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V2a0bLJSyk9q9EqHmm1eQCz0CHdg0gRtMnbYD9HFzStAFoFeG0I/35KnoYCKqWYSKk/anxSCURf0OCONjj1OvE1PzSMEZChAjUuMXnOnfrR5Tixec2LZg9G7JdsPcM8jxMBiojQke1OjVZHXDXmsNaxlEAcWn8rTde8sbGzYEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aabF1RGQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aabF1RGQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d0407aedd6so9651265ad.0
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786627334; x=1787232134; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TVWNuYas/MOMOGJWvOzXANfSQQ0qHMRR18n7cjmi/E0=;
        b=aabF1RGQsKgyr2E/h3KX+AqJbj1sbo9wCA1IJPyStUGbW7pM2E1XfA5Es06Jfcv9XL
         YG8pnAsWJ4YHViK8oGIq9xkXY2I+txxBACrRF/tQnvp4NUroyh6PNH81lKf+J08dyW22
         7gcLauNpoOUjfDvKHa/J1wnkvjLMSbZWVBxRrnuDHi7Xny244zXwu6of8JhEEcAmPMJI
         NXeHaTRXg5TxlE2IQQeJSMGhFoXV4gDwC0GFMXdjjYvvdTiHzOYXmk7N9Kkb92UFiW7j
         vgfryAxD7dfG6Axs2N/Rmzhw7EfsECl+K3znAYCDqgJGJKYyouHMROOxkTQv5qAnMGAA
         L8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786627334; x=1787232134;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TVWNuYas/MOMOGJWvOzXANfSQQ0qHMRR18n7cjmi/E0=;
        b=gaIkZaWoF8r6UgMdzuzricWS2RthMJXggysJf3QXY7ISkkweR61jS9BsM88W4jjHdp
         tdkmj++Tia6HebtJdqJoQGuNClcd498BfgOF777RmSri3eVjaOqv1tZ17EodERUklzno
         2TnuLAxkyt4C3MXM2u8N0eNr15IdB+mUNUAsN0gPNRgiTz7ea5lI89Le1/5Rvac7fmuz
         uTDFcetbt5cFrmsezFuZHpMUlhH4WEjh+N/LDJUNOoGI6g8kbvs3IZpx5OQit+n9mXKG
         hTxjlY4pR4mNpeuXhpnZNEB61la5Hzgg4Rd2YUGWSmPPfYf7qv46XPCl21C5iyUe+AAN
         06BA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0znVMVsAZ7HWIqkpZd1XG7gKjwWtIMoYS4I+3oJgWiS9SrmBluj3WPVaG4z+exa6evOUBxBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr15WDXUKWhrkz9MInofB2ZgUJvziwQqWjOM35mV6C9ULR6H6l
	84dp9H2blgc4EnE+0G/3+JSi2m5s8UXs+9HvCD7jcuj01tNndylGg4oI
X-Gm-Gg: AR+sD11jxqHZ6SzHj1dCpYqTsikDF9bUo3N5hlEamIN3O54CaIb6rsfVKFk20VNRN7R
	a91DPoz0CD/kpexp1dWvnNybIkHkiC+EGrXQF5t5nTsE9Ld/UpbucMwhz1trf78KmvFsT1Bo2fD
	biPuBArod7hCrDhr/GFeuUoM2FfsgAEOTE7lU5H+Pch9IEK8ytODvbKBIohBKDR8BabvNyxmU3f
	tY7UsFwOK/uamGyQ9ZIGlf1fGDyCmfZGqo+RJORZKxsO7zgehYV3rcV1mcxD9Ls1bOjjtNMMXFQ
	4ZfIlv/NNNNKYRNd/Y7JbI7nTVYnOI0NM2QzukfyMe9D/YE4zI1pnAVkAvcOORi9pEh8cWaQsLs
	L+7jLRBp683wG4I+lQboZZ6VboiZJmrxC6XmXrZBnVZZDYpWxPuIRgveEVe64Y3kXtaYkk7TY+0
	9jjlqwSSKHKQqgoIHPRp0owWHWenP7bfTy7rvyF14tdOjN2uF3ah2pWZ0u5No=
X-Received: by 2002:a17:903:468e:b0:2ce:7563:70a5 with SMTP id d9443c01a7336-2d37d577d92mr68447035ad.6.1786627333851;
        Thu, 13 Aug 2026 06:22:13 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c4947cfsm9509705ad.65.2026.08.13.06.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:22:13 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Thu, 13 Aug 2026 21:21:42 +0800
Subject: [PATCH] drm/nouveau/svm: drain fault handler before freeing svmm
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-nouveau-svm-svmm-uaf-v1-1-2d3112dea734@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOXEfWoC/yXMQQqDMBCF4avIrDugEYP0KsXFJE7qFIwl04SCe
 PdGu3iLb/H+HZSTsMK92SFxEZUtVnS3BvxC8ckoczWY1th27HqMWy5MGbWs51bMFNA5H3pr7EB
 EUK/vxEG+V/Yx/a3Zvdh/zhYcxw/7gCVYeAAAAA==
X-Change-ID: 20260813-nouveau-svm-svmm-uaf-bbcf36265aaa
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786627329; l=2616;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=MkqdAWdWz0lutQb8l1T1yO7gmyXKQ04Cgj/5wL4FwHI=;
 b=yWyApmq3N/iL78hHvscIOIj2yoIsiORxcfjfAjWEf97XuifNnsE4SSw4ljisawH+utDwbmttv
 3Ei8K0VW84RAFRxr9ixUgqc/R/yxG9hg5HPCQE6XMJo06un1mFjA9V1
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

The SVM fault handler nouveau_svm_fault() looks up each fault's
nouveau_svmm from the per-device instance list under svm->mutex, caches
it in the fault array, then drops svm->mutex and dereferences the svmm
across blocking faults (mmu_interval_notifier_insert(), hmm_range_fault()),
taking svmm->mutex and touching svmm->vmm.

nouveau_svmm has no reference of its own. It is freed on DRM file close,
via nouveau_svmm_fini() -> mmu_notifier_put(), which frees asynchronously
through call_srcu() without waiting for the handler; svm->mutex is not
held during the dereference, and mmget_not_zero() pins the mm, not the
svmm. A fault handled concurrently with a close can therefore dereference
a freed svmm. flush_work() on the fault buffer otherwise runs only at
device removal and suspend, never on the per-client close path.

The instance is already unlinked earlier in the same close, by
nouveau_svmm_part(), so no new fault can resolve to this svmm. Drain the
fault handler in nouveau_svmm_fini() before the free, so any handler that
cached the pointer has completed. nouveau_cli_fini() already flushes
cli->work here, and device-scope teardown already uses the same idiom.

Fixes: eeaf06ac1a55 ("drm/nouveau/svm: initial support for shared virtual memory")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index dcc92131488e..01191b126be5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -304,6 +304,17 @@ nouveau_svmm_fini(struct nouveau_svmm **psvmm)
 {
 	struct nouveau_svmm *svmm = *psvmm;
 	if (svmm) {
+		struct nouveau_svm *svm = svmm->vmm->cli->drm->svm;
+
+		/* The fault handler caches svmm pointers looked up under
+		 * svm->mutex and then dereferences them after dropping it,
+		 * across blocking faults.  The instance has already been
+		 * unlinked (nouveau_svmm_part), so no new fault can resolve to
+		 * this svmm; drain the handler to release any in-flight
+		 * reference before the svmm is freed.
+		 */
+		flush_work(&svm->buffer[0].work);
+
 		mutex_lock(&svmm->mutex);
 		svmm->vmm = NULL;
 		mutex_unlock(&svmm->mutex);

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260813-nouveau-svm-svmm-uaf-bbcf36265aaa

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

