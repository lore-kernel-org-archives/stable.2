Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279266;
	b=hfznUHhJRatBXR8p9y5scCHvcS0c1lqyksr4/4nEPodixoNba3uobT1VNcspabYpPOFE
	 RYUDXqvsZqLbmtImboqMGYNOVp89mgi72V2SxqHh7jynKQwZUh+43BT2DzBPLSan0xYyz
	 CJyQAXK3Jp+FlcEDVGno7qUdKLbOsdGk69RgnQt/Lnvn+yhwR7dF9dCmYCzScI1JRob2q
	 GYp2r4rXM3eQj4J6WLCdeajiLkykx/ILD91iM9BYfMOUViL4o0DQa3jhEVQ/KdDLDemVX
	 IXDE9QxfhhrMM6lDOm/ykKZ2MXHzFT7FAU9f4oERpFhMcUzc2BVdvedfpNW/a00aL5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279266;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hAJqK4rg6LMZIqGmBmBqgzj2iZkEo3peRYww/W032IU=;
	b=w4pqeEcfzonE8NddAR/H6IWyAHGDHBd3gH45EpAUQkTc6lLIs8gYAvyw43U8F3Ee9ibD
	 8DhMR3GeuRQV4Hy4rQ4ax7oRXq6H18R+6rayRTPJdw6ZNKqmYR0ZGcRRXCSOWDbbVmADo
	 z92OiETzt19tjRZBRNdDXURMpAkrXaOBPtwDy2MH5E6WMx0JnWmeI3h3CPrmQnXidLfw+
	 FRCJ873zNgdOiG7VMW9oXL2Xj1g9LiONPQkQvGCu8apnw6BvCX5zFOyP8ljzUeFRqgoXz
	 XZrAVh4ioYy65/0x43/9wvpa/DBM7wQLp6gzqJwjyW8zfpcvdkABfL/L8Swo84sh3hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZK5fHr4y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZK5fHr4y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3784F1F0089F;
	Tue, 10 Nov 2026 02:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279265;
	bh=hAJqK4rg6LMZIqGmBmBqgzj2iZkEo3peRYww/W032IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZK5fHr4yyopvZLPIWJuLgkt76qdfbwRTE+VbChgcoyH8iSmhPkNU3/z9wTS+tDqMq
	 pj2l1kA2+Y/CAUGF7U+qV4V9TYl/xYszfLJmzkXXrYyjj/4Gm2kEGeh4IAqRROSfvS
	 kCOTlQmo/FNUy7wH6B10E8oH2wB/0TJdAHf8kN/6JdprgbMwUbnBRUJeRqfQ0TOOcy
	 7O1pk5FPntTrDgWrHHSxlj6MWNuhpSIJOnAX/AjaDzrUCn0ol8ocRX1+zRedL9UxTb
	 4UlB+dBvMgdfu8r0kH2k6m5j1q4ffSVq4vXhvaSEZYR6gMVGa+BaZPxxFzFBM0U789
	 v4BaH7WALPUZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhenhao Wan <whi4ed0g@gmail.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/nouveau/svm: drain fault handler before freeing svmm
Date: Mon,  9 Nov 2026 21:54:23 -0500
Message-ID: <20261110025400.3851438-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055706-failed-5.15-b46ddaf08234@kernel.org>
References: <20261107055706-failed-5.15-b46ddaf08234@kernel.org>
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
index 9985bfde015a6..4cbd5c4ce8267 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -305,6 +305,19 @@ nouveau_svmm_fini(struct nouveau_svmm **psvmm)
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

