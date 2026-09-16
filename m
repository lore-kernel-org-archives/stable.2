Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE207377A87;
	Wed, 16 Sep 2026 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581404; cv=none; b=grwzoTE0YuTyXwGmEseENnRB9E+LDD7s8OkeUVFwzlb+THGWzPqgIqFnwvghu4VrtM6R8OrqV4lAMQGyKNs7pPtveXzFHZASjpbnKOJ2dXwCelCAENKAigMPozg2RTaoLmhKvVjESP80J3B504oNN3NO/CAeC9Zz9QkwaojMVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581404; c=relaxed/simple;
	bh=GlguQDwb/6GXu5gtToy4a+aT+1RblGzJL2MylIrvdMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltwtJvjz3N15MUVb7dNtnSuSDbcv3vpEU3j/++2jcja2aBb1ZAcfg8xLQ7Mi09faBX9WBF4zlxjA6Bmdb377tI0+/DxCZi+dzr7sgepFfdt1fCzrXjtsJhDc45EjjigfCnJxI9UOA08iuuoxgln0vo1/0ej/gixIj5bZ9oN+0Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADHMTw_2KpqKQRvCA--.23195S2;
	Thu, 17 Sep 2026 01:56:16 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: abhinav.kumar@linux.dev
Cc: airlied@gmail.com,
	antomani103@gmail.com,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	jesszhan0024@gmail.com,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lumag@kernel.org,
	marijn.suijten@somainline.org,
	robin.clark@oss.qualcomm.com,
	sean@poorly.run,
	simona@ffwll.ch,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/msm: Fix vm_bo use-after-free in with_vm_locks()
Date: Wed, 16 Sep 2026 17:55:48 +0000
Message-Id: <20260916175548.2089821-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHMTw_2KpqKQRvCA--.23195S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyrWw1xWFy5JF1UXr1kKrg_yoW8GF1Upa
	9xu3y29r4Fvr42qan7u3WDuFyakw12ga1UGrWjq345XwnYq3WDur1Skws0qrWrJFWxAF13
	tFn3GFWIqrWjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr
	0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1VHq7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcMA2qqok941AAAsP

The unwind loop drops the vm_bo reference taken while locking before
advancing to the next entry.  drm_gpuvm_bo_put() may drop the last
reference, removing and freeing the vm_bo, after which the plain list
iterator dereferences freed memory to advance.

Use the safe iterator, which saves the next entry before the body runs.

Fixes: fe4952b5f27cca5d ("drm/msm: Convert vm locking")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index c8dda2b68cff..27b45165b213 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -51,6 +51,7 @@ with_vm_locks(void (*fn)(struct drm_gem_object *obj),
 	 * success paths
 	 */
 	struct drm_gpuvm_bo *vm_bo, *last_locked = NULL;
+	struct drm_gpuvm_bo *next;
 	bool locked = true;
 
 	drm_gem_for_each_gpuvm_bo (vm_bo, obj) {
@@ -82,7 +83,7 @@ with_vm_locks(void (*fn)(struct drm_gem_object *obj),
 
 out_unlock:
 	if (last_locked) {
-		drm_gem_for_each_gpuvm_bo (vm_bo, obj) {
+		drm_gem_for_each_gpuvm_bo_safe(vm_bo, next, obj) {
 			struct dma_resv *resv = drm_gpuvm_resv(vm_bo->vm);
 
 			if (resv == obj->resv)
-- 
2.34.1

