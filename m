Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F3369D64;
	Fri, 26 Jun 2026 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480190; cv=none; b=fdxQxEkJABDrgPV01KhvoWONPpfdfoW3XyXTVQUPRJE2gjLXNDD1eSNEXpMmSvCw7CmY0PbsT1n6qYBVin/JTuAjuEqkUMgxrJfDsKsLQnNlbnKYnTUKa8Xx4JApn/ltXXZiIbhvjkxJEXOGUUdoRBaoISXnhboFjAYOxTFLTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480190; c=relaxed/simple;
	bh=Au/m1wuC5g5C048DzsZASpMRcOg6hzQNcX0wuLCuOjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mrTlNCSI9k8BVDfR5ev8uQQh2ss1sHTuQ5TNwWfmrfCjXj8qS0tJ1v62TaT+mdCeFfc1fDVmqOQDFopsBGeUFVw73OW9DOf/lrixzKpyFmsCvn3YSu0e4cpGXKurTBo2kwoMxqi5sfooVSKPVdBfjPPs/POfFzPlBN4bLJRl5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowABn8QQtfT5qxTFqFQ--.11227S2;
	Fri, 26 Jun 2026 21:22:54 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: vulab@iscas.ac.cn,
	christian.koenig@amd.com,
	kees@kernel.org,
	tzimmermann@suse.de,
	matthew.brost@intel.com,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fix: drm/i915: __live_active_setup: kfree bypasses kref_put in early   error path
Date: Fri, 26 Jun 2026 21:22:52 +0800
Message-Id: <20260626132252.38377-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn8QQtfT5qxTFqFQ--.11227S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF4kWr1xXw1rtw48Gr4DJwb_yoWkGFcEkr
	Wjvrn7XrW2yF1q9r1fCrs8XFyak3W8uF4xtwn7Ka43tryIyr4jvrZ3ZF18J3W7WayUtFy2
	q3WDZF4DAr17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUyMKtUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsKA2o+TTuNwAABsr

When heap_fence_create fails, the early error path calls kfree(active)
  directly instead of __live_put(active), bypassing the kref_put path that
  would call i915_active_fini for proper resource teardown. This skips
  cleanup of the i915_active state while the initial kref from kref_init
  remains unbalanced.

Cc: stable@vger.kernel.org
Fixes: 5361db1a33c7 ("drm/i915: Track i915_active using debugobjects")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/selftests/i915_active.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
index 9fea2fabeac4..8ec7859da762 100644
--- a/drivers/gpu/drm/i915/selftests/i915_active.c
+++ b/drivers/gpu/drm/i915/selftests/i915_active.c
@@ -91,7 +91,7 @@ __live_active_setup(struct drm_i915_private *i915)
 
 	submit = heap_fence_create(GFP_KERNEL);
 	if (!submit) {
-		kfree(active);
+		__live_put(active);
 		return ERR_PTR(-ENOMEM);
 	}
 
-- 
2.39.5 (Apple Git-154)

