Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280816;
	b=dXimQrmd6u8w1cEn5sIUnUhvUomrGrRU+O5fd27W7oF3sE72DuMv3q+jhVV3nsyG4h7g
	 b1k2UOuA5Y855MiRLo5q0WN7D0LCnhmkkX49zeBRMwZWF4QYQ0LRWxUMrUq/xoD+QUJIM
	 vJ7Y7iXLBOCpSsVablytiKNfprf4KyW/wZtvY9L+pU44KGE3oItyJIJfAVPGFaERL/cUa
	 sFfX0xHewD/MsyFIn8yqXptuhO2kLME9dOvWXC3cX02kj4Sn/aWSXrTc6NmgHWm/UUepU
	 dkYdBTCZ07/JQgtn1XUrxzz7F4LDldtU5ojp4WbFiIego+3yaOKnXFj3onocM5DkXuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280816;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EQWiNIPgp0Y3iWcclCHTXLZX0urPoSdIN9jt7HQUM44=;
	b=BWPEScp4XF4qPK1f6PtlG5B0C7JR883MdpRYXrYrW8h5yEtgD88J7Kn8jLjMR6y6z63o
	 mln6CkYI1cbgoqh5s9YSi1pOR4IuuFSphH3FOnQ/oILNu2fqTjIEmmWPQ3IjzBbIivdIA
	 EiweTXsJPRICj0FhJAnKxfljRfaWESIkaXD6Oa5ZCXUsOK+GR0Lhb8Rf49ZyMXUMC1rTo
	 8hr84qLKlcCwvNCEjE5dK6NJN0pUuW82cl/W6eYO+2KtUEqgUXrk/TOLd2R/ojR8mA8TC
	 SlXDklJZYoT3FfzcQjbDr9R+wPEDvKf5fDpByh/Eb5K65dyNP9P5WDpY8AB2Vgz1dfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nude62pb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C9A606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nude62pb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F5B1F008A3;
	Tue, 10 Nov 2026 03:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280815;
	bh=EQWiNIPgp0Y3iWcclCHTXLZX0urPoSdIN9jt7HQUM44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nude62pbXaIWGbmMjeCUwLCC1zdR2bbw93V7DWLPGtmxvsn/hjUieRRYNQdoLu3Fp
	 v24wm4zKouiLQvFwjjGRa5EbQ7u1uHcRWqVq6aw/8ypKDP9SFXgQIXiwy/4brsGEkZ
	 gzrjVd68RmnzMEhSFcCNlSg4Wa/XA2VTU5EXAoqVpiG3YtK0GeK21U1ciOO1D6sWBK
	 a+6FxXHtH5Ftyy/RaIu1bh5bVfm6lOxMjhf7irwR78FMQK4knST8KbQrdklLXB2893
	 g6OjKx1ynGXfMyP3DXEotJPiOLDCnOyfmZQLMZ8ykkPzrojFn9IUU14sbUayJBaw5g
	 5rcnyeZIsFsYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhenhao Wan <whi4ed0g@gmail.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/nouveau/svm: drain fault handler before freeing svmm
Date: Mon,  9 Nov 2026 22:20:13 -0500
Message-ID: <20261110031959.50827-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061408-failed-5.10-b46ddaf08234@kernel.org>
References: <20261107061408-failed-5.10-b46ddaf08234@kernel.org>
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
index f67700c028c75..a723c72049df0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -302,6 +302,19 @@ nouveau_svmm_fini(struct nouveau_svmm **psvmm)
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

