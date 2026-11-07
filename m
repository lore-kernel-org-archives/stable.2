Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049029;
	b=EmBDOJronu3WJlOoYgMEAPyX7CGo8V8fK6UgaxiQtF2OuGQr/upzc3IXEAj+u5pxxsoO
	 jTQlOlIFE4CFpYZAyCrWBDKeXCYTfIwODJ+5U3MegRqz4Zc6WO1xBLHvzGi2lewaX9Hn+
	 c/jF0AnLo/qU8rJUYkJ4xCSnnx7l4QXecTcgs3YzQ8xtGfORINcviQJtJd0r3jDJmLs4p
	 D63oD32ucB8Y77RxZc/9GkZITUBg7q7vIrqJ5/aJO97qCJyli9prGCFFa0X8bU81kIO7f
	 bC3eqFaGLvV1/bbJzlBIr9VKnSIDjMnAme8hzl+KefxAd5FJrdEaELO+KJMgI3pejvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049029;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p8Qi2Vx7iuIO/0P8qF7cGwH8c7n/1r9BIuX66riZs+U=;
	b=pPJ3A4pF5uYwrVV7wRMSayZc+aCoNvAbo7fQKyqmVVJVoBAaOP/1Bs8O0LWJnzXx+gX+
	 UMVSi/592WxMy1xrW8KaZR6YgOFXBkFIeCjT6UnCLdfOtB3QeAL4tSSPCeZJ11+D4IFNa
	 sdwkMeULc9EivW4IyvpoBDM0lV/YH+fvEwOBbwc43f/ogQpas5Z/8jT7lvROwQVI9oftx
	 5MD6XS0AE+WtqJS/IZrABjlGeiBKrxWEDRkDZc/fsdeggp2T01lki05chwcx+M89pDJYm
	 GKvNtXiMOJYY7kGRdeRstqgGUDvvDZUjOKEA6CF7uO3EkQRPO1HHnq12IwP5KfO4TwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzIqd1JV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzIqd1JV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBA51F008A2;
	Sat,  7 Nov 2026 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049028;
	bh=p8Qi2Vx7iuIO/0P8qF7cGwH8c7n/1r9BIuX66riZs+U=;
	h=From:To:Cc:Subject:Date;
	b=ZzIqd1JV9K+yvl2l0TB9EtjPdx5blYkHaOgC6MvGKgZESF124N9d77DDBy5fVJx78
	 T84cQ1D4xTNh87k5Dvi+CaP6oiEQF5jAeLIuoFPAyX5W5hCc2rwOJBMgKxmPK6ztIq
	 dv5ES0TzGxy5p1otKvM5warDPxL9MBmtyZvJOhy+LGYTQj4sELgP+w7S67LMMfTawx
	 SLcFGJPbsVSCHM2oGwcRgViBSS+1t30znz6k6rbtukHO6ajLH/+MCs8ce3ylU2jEhW
	 mkESnkQpqVvDjVLVDBz4bMfLHr9a+NnB0Taa99Ccs0AReOZoN91IoVIwhHUCY7Et6h
	 dbmTgMH7xaNUg==
From: Sasha Levin <sashal@kernel.org>
To: whi4ed0g@gmail.com,
	danisjiang@gmail.com,
	lyude@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/nouveau/svm: drain fault handler before freeing svmm" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:06 -0500
Message-ID: <20261107055706-failed-5.15-b46ddaf08234@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b46ddaf0823405f81e681eb26ec98508f3eb9a07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055706-failed-5.15-b46ddaf08234@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b46ddaf0823405f81e681eb26ec98508f3eb9a07 Mon Sep 17 00:00:00 2001
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 14 Aug 2026 18:00:05 +0800
Subject: [PATCH] drm/nouveau/svm: drain fault handler before freeing svmm

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
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index dcc92131488ea..a87406d3da300 100644
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
-- 
2.53.0




