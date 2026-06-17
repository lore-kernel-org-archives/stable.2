Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE3175A8F;
	Wed, 17 Jun 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706414; cv=none; b=gWLNkK9eSL/FNEUfGQDh0bDITbmh4kC4SWODJwjSvpNRDkI3sCpw0GGnIGJegkzthedicsUS39GHx0UG7GtrCCb3wrnalLVh7/dBwWdZ/ZQmYF2b+22YP5vknyY2CuNZ6x3SvA5qF1kiwR+rcgT7Md9ENw0sxJ6JBv3fi9ZD1ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706414; c=relaxed/simple;
	bh=3y0gEXamMe0owhrK09QNOqshLwEU+gZ9iv/DESOXGlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ih2BTTJKXoi5NNxDq16j38f4x9JWTuvNXvhoCuPURjJLj/vmPg7HJOLjhJX2FOZ8SJoGTpJ9h7c2ZULAowPdWe2UGmuWbr1TV0SHGxTyEkx8e1e8I32phLkqJwkAG0+OUD73sT+CYBpemufNWSWJiSgeEcVVM8PAw6Jvms0incA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAB3HNWbrjJqafsOAg--.697S2;
	Wed, 17 Jun 2026 22:26:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/guc: Fix invalid kfree() call via __cleanup on pointer
Date: Wed, 17 Jun 2026 14:26:32 +0000
Message-Id: <20260617142632.3298984-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3HNWbrjJqafsOAg--.697S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy3ZryDWw48Zr4xtF43ZFb_yoW8Ww4fpa
	9aqr1jyrW3XF1xtanrZa10vF15Can8JF92gwsrAwsruw15tw1fAr95AayUXr97ZrWxAF12
	yFZIywsrG3sFyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW0oVWYowAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VU1bTmDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYBA2oybL66kQABso

The variable `buf` in `fast_req_dump()` is declared with
`__cleanup(kfree)`, which passes `&buf` (the stack address of the
pointer variable) to kfree() rather than the heap address stored
in `buf`.  This would cause an invalid free of a stack address,
leading to memory corruption or a crash.

`__cleanup(func)` is designed for value-typed variables where the
cleanup function should receive a pointer to the variable.  For
heap-allocated pointers, `__free(kfree)` must be used instead,
since DEFINE_FREE creates a wrapper that correctly dereferences
the pointer before passing it to kfree().

This is the same class of bug recorded in CVE-2026-45959 and fixed by
commit d5abcc33ee76 ("crypto: ccp - Fix a crash due to incorrect
cleanup usage of kfree").

Fixes: ea944d57eac7 ("drm/xe/guc_ct: Cleanup ifdef'ry")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/xe/xe_guc_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index a11cff7a20be..73867a5cbe3a 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -116,7 +116,7 @@ static void fast_req_dump(struct xe_guc_ct *ct, u16 fence, unsigned int slot)
 {
 	struct xe_gt *gt = ct_to_gt(ct);
 #if IS_ENABLED(CONFIG_DRM_XE_DEBUG_GUC)
-	char *buf __cleanup(kfree) = kmalloc(SZ_4K, GFP_NOWAIT);
+	char *buf __free(kfree) = kmalloc(SZ_4K, GFP_NOWAIT);
 
 	if (buf && stack_depot_snprint(ct->fast_req[slot].stack, buf, SZ_4K, 0))
 		xe_gt_err(gt, "Fence 0x%x was used by action %#04x sent at:\n%s\n",
-- 
2.34.1

