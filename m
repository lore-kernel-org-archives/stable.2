Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970CC1FE47B;
	Sat,  6 Jun 2026 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780758108; cv=none; b=WtHen80Ou0fD9X4Yx4jPAxX/luPIjQsq+T+rporuqrOZnV+suAJxwEk/QHPm1QFisDVsX0MKcqLnooKdJq6m6QBbEfDrlFEm5ReMitLb9vhgMCeuj0g3PMe6uJQDNaT2wlASW4wb6rgkwCZ9uJZKcC9E2hUqkOhXZQCGjJSk/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780758108; c=relaxed/simple;
	bh=JgFmZ0nWjS6CPChVlabwG4U5C6WGb1uswB9w+Fhyo0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TjjrF4wuLjPFa8AA7Xm8gwR+BZ+HadarVt8O9qWuUM3ky2DwJ0qcrvHdV+3O+IvNDRhx7Htkmy6Sns2gTIed9IFKtSC1RsRFQfEO0m73VI3NIucmuvrzkvtrWvU2jKWKklOjaHtPaKOonQ3tuRShQ6hOPl9hJwVEHpMx97euIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACX+NtRNiRqgOyDEg--.18311S2;
	Sat, 06 Jun 2026 23:01:37 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: koby.elbaz@intel.com,
	konstantin.sinyuk@intel.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/msm: fix refcount leak in msm_gem_vm_sm_step_remap()
Date: Sat,  6 Jun 2026 15:01:28 +0000
Message-Id: <20260606150128.70023-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX+NtRNiRqgOyDEg--.18311S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar47Kw17tr18ZFWrKryUJrb_yoW8uF1Dpw
	4DAw1DZFWSyF4aqa43JF4v93s8Ga42gayrC395W3Z3ur13tr45Cr1rAw4jqF45GF97ur13
	tFn7Ga4kZa1Fva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbWv35
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsKA2ojcVH2CQACsQ

In msm_gem_vm_sm_step_remap(), a temporary reference on vm_bo is
acquired via drm_gpuvm_bo_get() to keep the object alive during
vma close and creation. On success, the reference is released with
drm_gpuvm_bo_put(). However, when vma_from_op() fails for prev_vma
or next_vma, the function returns directly without releasing the
reference, causing a leak.

Fix by converting the error returns to a common error path that
releases the temporary reference before returning.

Cc: stable@vger.kernel.org
Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 1a952b171ed7..69289bea7a66 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -602,8 +602,10 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 
 	if (op->remap.prev) {
 		prev_vma = vma_from_op(arg, op->remap.prev);
-		if (WARN_ON(IS_ERR(prev_vma)))
-			return PTR_ERR(prev_vma);
+		if (WARN_ON(IS_ERR(prev_vma))) {
+			ret = PTR_ERR(prev_vma);
+			goto drop_ref;
+		}
 
 		vm_dbg("prev_vma: %p:%p: %016llx %016llx", vm, prev_vma, prev_vma->va.addr, prev_vma->va.range);
 		to_msm_vma(prev_vma)->mapped = mapped;
@@ -612,8 +614,10 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 
 	if (op->remap.next) {
 		next_vma = vma_from_op(arg, op->remap.next);
-		if (WARN_ON(IS_ERR(next_vma)))
-			return PTR_ERR(next_vma);
+		if (WARN_ON(IS_ERR(next_vma))) {
+			ret = PTR_ERR(next_vma);
+			goto drop_ref;
+		}
 
 		vm_dbg("next_vma: %p:%p: %016llx %016llx", vm, next_vma, next_vma->va.addr, next_vma->va.range);
 		to_msm_vma(next_vma)->mapped = mapped;
@@ -623,6 +627,7 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 	if (!mapped)
 		drm_gpuvm_bo_evict(vm_bo, true);
 
+drop_ref:
 	/* Drop the previous ref: */
 	drm_gpuvm_bo_put(vm_bo);
 
-- 
2.34.1

