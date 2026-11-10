Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277813;
	b=FpM2G6vKZ1SQ34zwe0AtUS7mSurUKPlGq5Ai7yDEBycX20L4n9a9G7Z3at4Z+D+Y66Kv
	 fB/bDYJte860N1SvsnNdrqJy7DcdXtL2GnSFPk/j5wkrQbIL/Jc69NlrIaJSWvSOY3g2D
	 +h4JAqukpPLtIoAWtfDlyYmv+NKSO1rpmbPmrLIxJ95j/s7e53+m+WxKcjJNzth8Tczr/
	 Ow8qnAK+IpkE84HR5H8eVbsQ7U5HSiFRBb2tkImNjEpv3kck3a0RHmt4c6AbzGlKFisTo
	 /8MfKumavS1BSMnlnETkLs630BIa+JEitmwFqeyMStq3gGZkP7AFo98Xvlcp15gnjNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+otYdCm2morbchruc3afFNrp/Rhr/Ayc5NQneL5aO78=;
	b=ywXpOeu86SWxJ1i8IsZm+IjAYibcuCipYdoAw+RuyqNnHaGETOJPiexQwxCXa/JQvlG1
	 kLiS+gvLYqM84/AEDkuH+PRjJJZ+1vJQ6n4Az6naHtEFuYDF4k86gEk+eOikexCxzbiGx
	 6AwSprTducZFktATQpXLPWno4fCsQL8iODT3Yg8oCIP6msmf13zbt4Eb8EL8NlJsfTbP9
	 XfqrT71rpaBiCDZYMfC+Exy+5sCuFI2pUcpdlKLC8m8LMImGbKwyoydoP/IBgJJkaPDT2
	 H+5YuOV9b6fPzzO8ZEZiJGpLQfjQ2qMx/ATkn7au/vMYHGcm/xkl+RN36trULeoSRTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4zHwxJE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE38606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4zHwxJE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984031F0089F;
	Tue, 10 Nov 2026 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794277813;
	bh=+otYdCm2morbchruc3afFNrp/Rhr/Ayc5NQneL5aO78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4zHwxJEMNBGbjairN3oEs1QSdE+oYfNuKKVUZ1UUuzGF3thcC9awr1NmrJf1KUa7
	 AZ74HeuahATVpnkLLZ3gN77EK7ojeAvIGiHfZEHuiwooLMxqhTuecBY3/W7o5oJ1pa
	 4kyBzA1eRfIy/w82aJHeUW1tVAD67XNqksBIH6br8/52sWwAZgKirUhp+FY91QkTU7
	 HToYI7jFWGBZTfzvmM4WPDKKNnwlZAvzuECwrEIfxHIEvs1D3JkKfJ3CrNWwS0iN2a
	 mPjfv66J6rRZriGXyqCz9WqpkJuOsafP+IAWCKHs/Hr9O9dZfoHCHpKC6C+t8Eb8z1
	 gMVTBVugSn0Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhenhao Wan <whi4ed0g@gmail.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/nouveau/svm: drain fault handler before freeing svmm
Date: Mon,  9 Nov 2026 21:30:11 -0500
Message-ID: <20261110022953.3763851-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054047-failed-6.1-b46ddaf08234@kernel.org>
References: <20261107054047-failed-6.1-b46ddaf08234@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenhao Wan <whi4ed0g@gmail.com>

[ Upstream commit b46ddaf0823405f81e681eb26ec98508f3eb9a07 ]

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
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/20260814-nouveau-svm-svmm-uaf-v2-1-8e6590519f07@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index d0bff13ac758d..75218519c29e0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -306,6 +306,19 @@ nouveau_svmm_fini(struct nouveau_svmm **psvmm)
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
+			flush_work(&svm->buffer[0].notify.work);
+
 		mutex_lock(&svmm->mutex);
 		svmm->vmm = NULL;
 		mutex_unlock(&svmm->mutex);
-- 
2.53.0

