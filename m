Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048049;
	b=EjeWsByu4VECWQSxNluKKIZEyi+076vbhujB1jqHZ3JjlmhPF/czeBW+aEnRRPg+wZsv
	 RFWQiL10mcrClSORVCqfXQPLY7epZGdKKMi4/ThymwVq4q4/YQOZHlrYHHWZnGTOluhaz
	 dsajHabWd3qRZe316VWBF7ttguy2HvSu/Ylbb/qBWwsTsFWl3VR/2T4u2Me7aFI9To0NC
	 mpNCyKZG8KDuqL3CTU5vEOkqe31o73Mlw9Z0Psy+VqMxUYS9Zhc4AI73bI6+fMvH7JLga
	 3gowgLIM0oAlRD56s/MqxmgETeuymFynm0w0VfFPQ2HhVFksuOlCD2k3rApH4nHCy7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048049;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yMmKjAxPmczaP3pMbG4p05bUKDj169dSyQWfhFEt2U8=;
	b=xvq7k6j9xfUoqrmTvkS5WGlAqeGZ1wGI3L8szTh1MhEbAjakxx1gkkCQeFt0dfjtB4wy
	 4xRdvy1PKdrTafWD6kIx6n2EaQnYqhE8GJzvhJC8+8Cp5PiPiEJ4UEs8LmnqpNYlCssQe
	 en0k189k9rcLdxL4AG2sOo5O3QlDoPwtgYCp9J6ZAkM6YpmY4Nqg+sJGsrSjFmSSCJ9U9
	 Uw/HaOY9ki53eaS03eNA+yp5KiI1objAkE1jEID7Y3/qo+H5wEQ3PXhymJQ+wySgFwlJs
	 cypy+0uRdJm8vnb8YdKExHTbdExM1vbZ8meR3Bgv3wqzZzAJX+D/nGqFShbhnmeWobg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=moDPeIiJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=moDPeIiJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3631F0089F;
	Sat,  7 Nov 2026 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048049;
	bh=yMmKjAxPmczaP3pMbG4p05bUKDj169dSyQWfhFEt2U8=;
	h=From:To:Cc:Subject:Date;
	b=moDPeIiJzYx9U14A6CSbS7CporP1ot5+V12C1ZKTqkN1r8TNOjCGJpd+FhIhMaLrF
	 72ZaOJHG40yqHJn2e+bDa5zkuSIBaHMavy0QGeUY+G+TNdf+xuQN8d8rhEIF/zwMOB
	 a2eoM6xfNxZIxggDE0D2tuk03rcE7Bgrc8SWcICObj5hdMdYDTb6hoIUAZizicxo45
	 hZFy0ggG2NBnHIeUoa+Zf7lbh68ryaDFU8Pt/wvpU4OGTor4sRS8A5aMi5r35TSfNf
	 sSpb3ZmyBLeJsP8g+tm4UqHewrr1CYd3jADWhRmypB7vDULO53DDIGlIVqBAtEiMQe
	 IAfF2wChyGWbw==
From: Sasha Levin <sashal@kernel.org>
To: whi4ed0g@gmail.com,
	danisjiang@gmail.com,
	lyude@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/nouveau/svm: drain fault handler before freeing svmm" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:40:47 -0500
Message-ID: <20261107054047-failed-6.1-b46ddaf08234@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b46ddaf0823405f81e681eb26ec98508f3eb9a07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054047-failed-6.1-b46ddaf08234@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




