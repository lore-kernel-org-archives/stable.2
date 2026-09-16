Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB034B5CC3;
	Wed, 16 Sep 2026 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552407; cv=none; b=kCr1LqYClA27V1FncbMB4bpTDRBi7n9IhwQpSKYMzBK+GV+Yd8pPSpvfhqaKuMjQVF1hks6nRB5oG2VvjNkH1sY+K4fN6GNqSIEvft1C034Un/G5d7NT72/PDhljANhdLhBJQuabtxbzT8hbHvA3Vj6uFQS9ceqTPKNKw6ZT7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552407; c=relaxed/simple;
	bh=QMrT+8IKwmMOlrAGhe74MK5taGi6puci2h80Q5LU5C0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vE19OwUpFSsDFSnlOf3mGCCjG4RWVqNXh6trYX0QCMbqyju9EFWUh44GxS4RPwjDS9GVBliymhAl30PyXvtTgWYjtCoKm8TJsOIUIq2XTPvLNwSHTIb0yKpKnXQiLjpuPrVsiz0sWlU/NzQaMUAL92IXCSUgdjz4OztS7qduPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXoT_9ZqpqEbPgBw--.16820S2;
	Wed, 16 Sep 2026 17:53:01 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: David.Francis@amd.com
Cc: airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	simona@ffwll.ch,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix GEM object leak in amdgpu_gem_op_ioctl()
Date: Wed, 16 Sep 2026 09:52:33 +0000
Message-Id: <20260916095233.2009025-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXoT_9ZqpqEbPgBw--.16820S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWUWFWDZw48Jw4rArykuFg_yoW8Xr1DpF
	s3Xr1jyrWUZF4Ut347Z3Wkuas0kw4IgFW8GF4293ya9w1rJF93XFy5CryjqF97ArZruF42
	qryqyrWFgFnYvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7VUbtl1PUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQMA2qqP7mgDwAAsu

In the AMDGPU_GEM_OP_GET_MAPPING_INFO case, amdgpu_gem_op_ioctl()
takes a reference to the GEM object with drm_gem_object_lookup() and
holds the buffer object locked through drm_exec.  When the allocation
of the mapping array fails, the function returns -ENOMEM directly,
leaving the exec locks held and leaking the GEM object reference
returned by drm_gem_object_lookup().

Jump to the out_exec label instead so that drm_exec_fini() and
drm_gem_object_put() release the locks and the GEM object reference.

Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 123d4a09114d..06dd2e8a5b47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1094,8 +1094,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		 * be retried.
 		 */
 		vm_entries = kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL);
-		if (!vm_entries)
-			return -ENOMEM;
+		if (!vm_entries) {
+			r = -ENOMEM;
+			goto out_exec;
+		}
 
 		amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
 			if (num_mappings < args->num_entries) {
-- 
2.34.1

