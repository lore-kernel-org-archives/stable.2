Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA26256C84;
	Fri,  5 Jun 2026 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652927; cv=none; b=LsJhwZ7tKqHbIVYS803fICUfKkx6wRXuvD7mCECvJDQPo6DA8SE95+OGGxPcVDWW1KGAojxXJiEgt3nRUB+0JN9WPXIQXG4zYwFYDrMaFC/abYlEPNY2uBmP5CY9E0EDOyyoYQMypJsVTYbf3Fwgs824EEkf95Z1lJ7p3qdNsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652927; c=relaxed/simple;
	bh=tMgzKAHWYr/sdN1SOcMhZaNqa7jH4TgTIQZ+Dn6SmDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g5+KtnCZm1O6YEf51RxJHyPbjxIBVdSV1/REPpIDHP4+ssK3hiAPk3lSZz/oPp/6AFc4l3W+dguo8FzOlR82/vd8838vn8NL6FcUw9FMHhuv2gSPLXQ9MHHN2sLxam9TJdY2eaRMDmtEeXclzmJFF7P1j/Nh6WsPvPoSlR9dauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADHadJ1myJqYJWrAA--.847S2;
	Fri, 05 Jun 2026 17:48:37 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: pierre-eric.pelloux-prayer@amd.com,
	lijo.lazar@amd.com,
	felix.kuehling@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix refcount leak in amdgpu_ttm_clear_buffer()
Date: Fri,  5 Jun 2026 09:48:27 +0000
Message-Id: <20260605094827.7982-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHadJ1myJqYJWrAA--.847S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy7ur4fXrW5Jr17JF4fZrb_yoWkCFg_KF
	WFqr1rJryakFs0qr1Ivr13Zws2kFy5uFW8Gr1IqFZ3K3yUZ3y5AryDWr1rXa1xWan7uFWD
	XwnYgw15AwnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUogAwDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4JA2oiXZfjMQAAsd

In amdgpu_ttm_clear_buffer(), the *fence pointer is initialized with
a stub fence via dma_fence_get_stub() and may be overwritten with
job fences in the loop. On the error path (goto err), the last
reference from *fence is not released, leaking a fence reference.

The sibling function amdgpu_fill_buffer() properly releases its
local fence reference on error, confirming this is a missing
cleanup. Drop the fence reference in the error path to fix the
leak.

Cc: stable@vger.kernel.org
Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3d2e00efc741..d65f1df3574f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2585,6 +2585,8 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
 	}
 err:
 	mutex_unlock(&entity->lock);
+	dma_fence_put(*fence);
+	*fence = NULL;
 
 	return r;
 }
-- 
2.34.1

