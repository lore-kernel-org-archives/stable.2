Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6D13DBD5E;
	Thu, 25 Jun 2026 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387173; cv=none; b=jLpo/bS6k4F2pjR79x8lPUo+r7G4ATs6KhJk30zRcvBuZoDQV3gffM1ZUZ5uFe7+BljJ11k0D5F8ZpWwDEA6nxh9gz3RL1yyYthReSZYJ939WLxOYbiaclPRBaYkcQTX4YDLKOjQCb40d7xrpkFCZgpJcGsL1POzpkSLTMnIHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387173; c=relaxed/simple;
	bh=jjI9ppPkTyZaQPEY1IgNokEQW+d3si723qUvqFs0Cdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=o/FzVlP0Obnk80QCU0tbCzQfyV0WtCbd4y7yeWAs1trkHp+C2Cvs7SRwqWe4BYzER5qSbqn0dRmMXthNAxkRBwsHXjlt4mra3ZkUdvAdnJl0zk0MUdHUket1D8k7nTLDuSpcxaplueFY84vsfwLbWcpM1jgu0eRO4z8hwI4shcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowABXr9LaET1qLRs0FQ--.11371S2;
	Thu, 25 Jun 2026 19:32:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] accel/amdxdna: Fix use-after-free in amdxdna_gem_dmabuf_mmap()
Date: Thu, 25 Jun 2026 19:32:39 +0800
Message-Id: <20260625113239.49764-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXr9LaET1qLRs0FQ--.11371S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryDtw4DXry7tw1xAw43Wrg_yoW8GF1fpF
	sxur15AFZ8Xw40qFsrZ3WDua4F9F13t3yrJryktw4fur15XF4UtFWfC3saqFs0ka4kCw4a
	qF47tFW5X3WqyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREJA2o84AnBZQAAsJ

When vm_insert_pages() fails, the error path calls vma->vm_ops->close(vma)
which internally calls drm_gem_vm_close() → drm_gem_object_put(), 
releasing the GEM object reference acquired at the start of the function.
However, the close_vma label then falls through to put_obj, which calls
drm_gem_object_put() a second time on the same object.

If the first put releases the last reference, the object is freed and the
second put accesses freed memory, causing a use-after-free.

Fix by returning directly from close_vma instead of falling through to
put_obj, since the close handler already performs all necessary cleanup
including the object put.

Cc: stable@vger.kernel.org
Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 6e367ddb9e1b..fec9763c518c 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -469,6 +469,7 @@ static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struc
 
 close_vma:
 	vma->vm_ops->close(vma);
+	return ret;
 put_obj:
 	drm_gem_object_put(gobj);
 	return ret;
-- 
2.39.5 (Apple Git-154)

