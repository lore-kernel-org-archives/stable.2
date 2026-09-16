Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D554DAF8D;
	Wed, 16 Sep 2026 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580200; cv=none; b=iR9x8hmufBXbqnOhhyzevdDp0D9MxkHZYthQ79y6rzKXxQ79TXD+4FQd6NFZSG+8KEIqo0A3PZ1fHVMSYSYerf2PuULKtBRUKjAcZaYjMWpdZTqJvIN0EYJLbypBd/uFDsFB42TsfQ7FS72IM0nBz5h+3J9cFbFVGbYHaKSkrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580200; c=relaxed/simple;
	bh=NWJmNT1Fvyd7kqwcYs8QnnYpWQJJEBXHyPmEH70TqNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tf9AlgRiU/LUFh6/5vLnBVm3nt+6ANhf3NuD/e0L48vq+V+vRu5OBetD6OWcC78aEeMwXp8DZtQ8/+WQlK39d5kXG9LutFDRwgIe7vqr02VhnQMWPYUp3ZtTa2HBoXo2RV51wbxPhIiOft9hSjWAfjGttvkg3jq1wE4iGtrU36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnUDud06pq_bluCA--.22964S2;
	Thu, 17 Sep 2026 01:36:29 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: John.C.Harrison@Intel.com
Cc: airlied@gmail.com,
	daniele.ceraolospurio@intel.com,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	matthew.brost@intel.com,
	rodrigo.vivi@intel.com,
	simona@ffwll.ch,
	tursulin@ursulin.net,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/guc: Fix sched_engine reference leak in guc_create_virtual()
Date: Wed, 16 Sep 2026 17:36:01 +0000
Message-Id: <20260916173601.2088347-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnUDud06pq_bluCA--.22964S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyUtF1xJF48CryDAryfCrg_yoWkWFb_Ca
	4Yvr93GFy7AFn3Cw12yrnxZrWvkFyUZr4Fyw18t3yrA3yjvr4UXwsI9F98Xr13KF4UJFWD
	Aa18uF1fAFn3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
	1UYxBIdaVFxhVjvjDU0xZFpf9x0JUtgA7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMMA2qqpO9oaQAAsK

guc_create_virtual() takes a reference on guc->sched_engine for the
virtual engine, mirroring execlists, but the GuC destroy path never
drops it; rcu_virtual_context_destroy() does. Release the reference in
__guc_context_destroy() alongside the breadcrumbs reference.

Fixes: 556120256ecd ("drm/i915/guc: GuC virtual engines")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 788e59cdfac9..7b88e081c76d 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -3487,6 +3487,8 @@ static void __guc_context_destroy(struct intel_context *ce)
 
 		if (ve->base.breadcrumbs)
 			intel_breadcrumbs_put(ve->base.breadcrumbs);
+		if (ve->base.sched_engine)
+			i915_sched_engine_put(ve->base.sched_engine);
 
 		kfree(ve);
 	} else {
-- 
2.34.1

