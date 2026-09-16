Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E94D7D38;
	Wed, 16 Sep 2026 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579913; cv=none; b=rpizdAbPLrWsvRGpyLAgpDfhsLGvp69KDv3K/bSJWHlyq6dt/r4Wa2WJgIBNorDttWx1uKRobaNaYgdTpC8xVsZJ0OlcgnM8pmbqUvJROVHdLrpGjpsTgVqeU1Ep2zlW2f1XrCTr4bnn6zHCkoFpFx73Wu5EaWGyISHN43gjuIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579913; c=relaxed/simple;
	bh=DTh8EqC0HXrZxEjbphEcqBqo+kVsUBYpL+Y1Ze7Dg7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pbwy3X/f3TSBn67UgJ8daUnHQtp8z6mZjNS7mXLYFUg11RcOezRA6IX4wIHvrGGIAuRInnY5RPC/sVWkdQ68RmvHRiLnkjHTUt9yPh3yhV+glBDusl4qq9I9/AQwY/O50I33GE/X+F5GOdQaUom+MkvXa0VfKz2WcHBrjpFs/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXADt60qpqpKduCA--.22649S2;
	Thu, 17 Sep 2026 01:31:38 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	john.c.harrison@intel.com,
	joonas.lahtinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	matthew.brost@intel.com,
	rodrigo.vivi@intel.com,
	simona@ffwll.ch,
	tursulin@ursulin.net,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/guc: Fix ce use-after-free in scrub_guc_desc_for_outstanding_g2h()
Date: Wed, 16 Sep 2026 17:31:10 +0000
Message-Id: <20260916173110.2088036-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXADt60qpqpKduCA--.22649S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw13KF47XrWkAFWfXw48Crg_yoW8Ww17pr
	4aqw1Y9Fy5AF4SvF9rA3WjqFyfK3WrJa4xWw1DGw15Jas5J3WDGr92yay5tFyDAr1xJ3sa
	yF17KrW3W3Wa9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJbIYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAMA2qqpVhkigAAsb

A context flagged SCHED_STATE_DESTROYED has already dropped its final
reference, and __guc_context_destroy() frees it immediately (virtual
engine contexts are kfree'd outright). The pending_disable block is not
mutually exclusive with the destroyed state and kept using the context
after that destroy. Defer __guc_context_destroy() until after the
pending_disable handling.

Fixes: eb5e7da736f3 ("drm/i915/guc: Reset implementation for new GuC interface")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 7b88e081c76d..5eab2baa1f7f 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -1122,7 +1122,6 @@ static void scrub_guc_desc_for_outstanding_g2h(struct intel_guc *guc)
 			if (destroyed) {
 				intel_gt_pm_put_async_untracked(guc_to_gt(guc));
 				release_guc_id(guc, ce);
-				__guc_context_destroy(ce);
 			}
 			if (pending_enable || deregister)
 				intel_context_put(ce);
@@ -1145,6 +1144,13 @@ static void scrub_guc_desc_for_outstanding_g2h(struct intel_guc *guc)
 			intel_context_put(ce);
 		}
 
+		/*
+		 * Finish the destroy last, as it may free the context while
+		 * the above states still need to access it.
+		 */
+		if (destroyed)
+			__guc_context_destroy(ce);
+
 		if (do_put)
 			intel_context_put(ce);
 		xa_lock(&guc->context_lookup);
-- 
2.34.1

