Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548F2D838E;
	Sat,  6 Jun 2026 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780742153; cv=none; b=Fz5G7Jl5l+6ah0BPDLeSKPhDPpbtUvzz06lxgfjeU1l+d9RHDt/45vfj4hZUm9Lksq6D568SikMELPTDr+CXnpq16EccWpeAA8Uics4oj3okZJ//qlBlEcGzUO1dnHs3lRci4jDbuNw6PgAJFXsn/1BtxqSLZctPB51/jK78aLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780742153; c=relaxed/simple;
	bh=S41fMxN7wSq5p4jw92k5gzf+TfAogwVktM9ITXVVlDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HMarEvYfqUxIjJ2W9TeiHf1TpmbUnTr8k+98b1Gy9PpNwRGybqSTIo8xU6Wdf+O5XUUoA5IZY8oONE37ZTUlxF1ILKZKFpjlbj4dr6LVPgeA9TScX9U8u+JoSeRNyIK+6C5yRXe004l/KWwFjijWEDrcTo9N8LW0yBAQr/byx/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAA329P+9yNqhGG8AA--.9968S2;
	Sat, 06 Jun 2026 18:35:42 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: zhenyuw.linux@gmail.com,
	zhi.wang.linux@gmail.com,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gvt: fix refcount leak in intel_vgpu_shadow_mm_pin()
Date: Sat,  6 Jun 2026 10:35:19 +0000
Message-Id: <20260606103519.57715-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA329P+9yNqhGG8AA--.9968S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4rtw1fGFWUCw48CFy5XFb_yoW8XF4fpr
	WrXry3ArsxAr4aq3yDAw1FkFy3Ca1Ik345Wr1kGwnrK3Z0ya4jyFyYka4UWry8GrWxXw1S
	vryUGay3uF1DZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUG_M-UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4KA2ojcpPxkgAAsF

intel_vgpu_pin_mm() unconditionally increments the mm's pincount at
the start.  If the subsequent shadow ppgtt creation fails, the
function returns an error but leaves the pincount incremented.
Callers must therefore always call intel_vgpu_unpin_mm() after
intel_vgpu_pin_mm() returns, regardless of success or failure, to
balance the reference.

In intel_vgpu_shadow_mm_pin(), when the pinning of the shadow mm
fails, the error path returns immediately without unpinning.  This
leaks the pincount reference that was already taken.  All other error
paths in the same function correctly unpin on failure, making this an
obvious omission.

Add the missing intel_vgpu_unpin_mm() call before returning the error.

Cc: stable@vger.kernel.org
Fixes: d8235b5e5584 ("drm/i915/gvt: Move common workload preparation into prepare_workload()")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gvt/scheduler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index 15fdd514ca83..30d879b37c84 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -698,6 +698,7 @@ intel_vgpu_shadow_mm_pin(struct intel_vgpu_workload *workload)
 
 	ret = intel_vgpu_pin_mm(workload->shadow_mm);
 	if (ret) {
+		intel_vgpu_unpin_mm(workload->shadow_mm);
 		gvt_vgpu_err("fail to vgpu pin mm\n");
 		return ret;
 	}
-- 
2.34.1

