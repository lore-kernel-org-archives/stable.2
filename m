Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282141D64C
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786701629; cv=none; b=pJpoJRm6fgzvbA6boPKQRK64mujtjybSPQ8Ew3MGKxPc0yno5LIbdADyLB/EN3EUTdRBwACNkWVgNBRmbNhdETVit2wAxooS7IyKdv1GO+/jbKijHHsIP3IyMnznq0biP7vOeLFwW5/6L0ukZGlG5/39/8fIoMzuEapoQA0/TdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786701629; c=relaxed/simple;
	bh=Xa5VtHj3w4sPlc/TppIcRh1BbFj+6tLTdDnsIWhMORY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HLBw/76thxcto1cqBIqbbCXA8giw9jmrOqykqlAmCk33jC1qUmnKc1/LwYEE7XdRUCDd71lI8tSZTknUG/9L36GNFC6fJSquYeW1vK4i1KQQc7KlF03RzKmX2kspLe9jnI9z5v4XGg/swUxrYDSqvB+oYPLmJqR/v4fzxjZljMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2ulGjz7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2ulGjz7"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so712858b3a.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786701621; x=1787306421; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CEq/gI0mam4/U63KJoUcke2lMf2q5gb8Kb5V1dW24Zo=;
        b=R2ulGjz7928lsG1BmYIKZtyKV9hrc5WZVCh9iEfO1XXxnyr+e5LbxJ+Mhko4pvSyAS
         NeXwgKU4B57uSomM2C0uljvMSlYQgfkavnbwHOvBCyV7flxl1uDN/tdMO5HglFXCuHFg
         OtTU9sBzvnsMi1xeMMO2WhYh0YWBgl6qe443tMc9BGSgcS1rRnSEYsagMdh0pwmVcFE1
         +cKG5MgTr2iAeQvzRQkQD1RwzqbBMQglT14+lypKaYfYIqRJAqKs8mCbsooLMcFmn+gZ
         lia7iCHqg3UyPER6ynuTWm7S87lLKjD5Io3c5IAWx9hWwQFQgAxoB7NeMjxDqK+TNLVb
         6qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786701621; x=1787306421;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CEq/gI0mam4/U63KJoUcke2lMf2q5gb8Kb5V1dW24Zo=;
        b=MqRQ35k1YJ9lHg289W2oQ3GlAKXQCXnANWa8cy72htdE66SE7xpOXwclhBWfLs+/Tn
         vKCnreyVN3Hxx0PWu+k4tscLFvX/hm/0iiWtAStLLIv5OPmZeOrp/lWy4jggLz968dzk
         sbwdxP2k62WVbcCeBRuZqEmmbzVDVbZ5cXotMvP1jgs192ehxBnhoyYWQdtEg/1ka28u
         x2QzsWtce6R8JoT3AyDXQfyTdJu44ei8Wc8B1ypf5a2nJ3x9+EuV8jB8bnm2gjpN0ROT
         oH222pN/wNdCBhlNKkTCIRzfKDVxin8lwRYsSqLThmUT5hP1bg6rAOr1dE1eCc70jQnK
         Bxng==
X-Forwarded-Encrypted: i=1; AHgh+RqqqFb1q3ZRSW4YhVrzo5+/HjD6wDx7yLz+astJ1r7cgm9otqulJ2q5JB1g7h7Lkug2w/UbdL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RJXNDTgxc2RAZgly3B+KoOIod8JBPej8gfxQLIP/+/fgEOvR
	H/TnfbRd2iVIgI8eweMRX67wNnZOVNh//uGcTRqC7rb0aBinFZoHIOXK77IcI5iW
X-Gm-Gg: AR+sD13tQOBcxMsBMc7QP2HprUU7+xLflJ3hji0QAPC2D8vL6BYp4cvrDvEWduBy09k
	nMmxLzrBI28GaVf494dhRy6Mw35I5FGoDzmJnJdm7sNgHZTn7zKcpT6ZQCp4cqABM8ATRssh7z+
	vgtdRAkTzXMY92YqnvHEs1sx5mOMJ26NfDP4rzzf+eqScQWFOpCcKwMk0PBU8C/j6pebM2yFWU0
	h/pQ0QSu0qhRc9/5livui5dMQsSpBTjg+M4UqHjM6Nb9AwfXBTHmGf67qd4UhdmndPqemJqwTqM
	PhUs7bYw08x71nJVL5WYS94Yu/U1Nv0IvAofkopngwaczGXM7l9td6TeVMt/MexS7ctgpk5duUH
	7lGb/IODj8KAo0kqwwHHOaLi8LAVCn5x6vT4ueC6YFW04XOB0foaw22nCSAEUMsgdf4wBZCDH8H
	MAx4SmpfaLBn7MBntTsYogvtj45YEeVmdKz/AAKMeLNP8K8KWC5Zdhkcm/LUC8S3Xo
X-Received: by 2002:a05:6a00:338f:b0:848:467d:293a with SMTP id d2e1a72fcca58-84fde38d267mr5281242b3a.35.1786701620572;
        Fri, 14 Aug 2026 03:00:20 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517cfeb3cesm243681b3a.3.2026.08.14.03.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:00:20 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 14 Aug 2026 18:00:05 +0800
Subject: [PATCH v2] drm/nouveau/svm: drain fault handler before freeing
 svmm
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-nouveau-svm-svmm-uaf-v2-1-8e6590519f07@gmail.com>
X-B4-Tracking: v=1; b=H4sIACTnfmoC/4WNQQ6CMBBFr0Jm7RjaKhpX3sOwGMoANZaSljYaw
 t2leAAXf/GS//9bILA3HOBWLOA5mWDcuIE8FKAHGntG024MspRVeRUKRxcTU8SQbI7FSB02je5
 UJaszEcE2nTx35r3fPuofh9g8Wc/5KzcGE2bnP7s3idz7o0gCBcpWCSFbpos63XtL5nXUzkK9r
 usX6v8BRsoAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786701615; l=3566;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=Xa5VtHj3w4sPlc/TppIcRh1BbFj+6tLTdDnsIWhMORY=;
 b=TBxXokJK8M7vP1OhEP1hGzukGoCRT8H3Zet+dNfTg4l0/uLvvpsPxPmHtEGUTfqyZsKlDo9E4
 ofOpy7NU5suA8CQXNc7SFLTq0vitYWUEzCqlR4zth9V1vglhRYM545G
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

The SVM fault handler nouveau_svm_fault() looks up each fault's
nouveau_svmm under svm->mutex, caches it in the fault array, then drops
svm->mutex and dereferences the svmm across blocking faults
(mmu_interval_notifier_insert(), hmm_range_fault()).

nouveau_svmm is not refcounted. On DRM file close nouveau_svmm_fini() ->
mmu_notifier_put() frees it asynchronously via call_srcu() without
waiting for the handler, and mmget_not_zero() pins the mm, not the svmm.
flush_work() on the fault buffer otherwise runs only at device removal
and suspend, never on close, so a fault handled concurrently with a close
can dereference a freed svmm.

The instance is already unlinked by nouveau_svmm_part() earlier in the
same close, so no new fault can resolve to it. Drain the handler in
nouveau_svmm_fini() before the free, guarding the flush with a NULL check
on drm->svm: on device teardown nouveau_svm_fini() runs first and frees
drm->svm (NULL) after blocking the notify and flushing the buffer, so the
handler is already drained; on per-client close drm->svm is alive and the
flush runs.

Fixes: eeaf06ac1a55 ("drm/nouveau/svm: initial support for shared virtual memory")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Changes in v2:
- Fix a NULL deref introduced in v1: guard flush_work() with a NULL
  check on drm->svm.  On device teardown nouveau_svm_fini() frees
  drm->svm before the per-client svmm teardown, so nouveau_svmm_fini()
  would deref NULL (reported by Sashiko AI review); the handler is
  already drained there, so there is nothing left to flush.
- Tighten the commit message and the code comment; no functional change.
- Link to v1: https://patch.msgid.link/20260813-nouveau-svm-svmm-uaf-v1-1-2d3112dea734@gmail.com

To: Lyude Paul <lyude@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index dcc92131488e..a87406d3da30 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -304,6 +304,19 @@ nouveau_svmm_fini(struct nouveau_svmm **psvmm)
 {
 	struct nouveau_svmm *svmm = *psvmm;
 	if (svmm) {
+		struct nouveau_svm *svm = svmm->vmm->cli->drm->svm;
+
+		/* The fault handler caches svmm pointers under svm->mutex and
+		 * dereferences them after dropping it, across blocking faults.
+		 * The instance is already unlinked (nouveau_svmm_part), so drain
+		 * the handler before the free to release any in-flight reference.
+		 *
+		 * On device teardown nouveau_svm_fini() ran first and freed
+		 * drm->svm (NULL) after draining the buffer; nothing to flush.
+		 */
+		if (svm)
+			flush_work(&svm->buffer[0].work);
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

