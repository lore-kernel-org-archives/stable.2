Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAAA3F4DEE;
	Fri, 26 Jun 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486003; cv=none; b=ulXYtderxdxIpsybghQEmSQaA+708VI5jJH90pUA6JclFKKPKOyJP2wnHfNkxK6SamuhK2qdl2NRsScAUIgw+oYhZiPaLt8r0kyotidjdrAXj3TLVxftMIOhXAxSkgZgJwPyRQGoNx1tGFyUl4UXbl8Ap945Ovszs/9KdMbghV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486003; c=relaxed/simple;
	bh=VQbZlpDuqmshKQyH4r0BKnsoumPqx6eI7Jz+xXXG2vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a+7FTHoh0LzoafmXsygeIPc99AwYTP0CpazNNGXr5zUI14KJI7dFwwn4lOnqpEjVdsd3zzWwPJ6PmbjLdd7eUAJ1lmOFuXBwUw/qs0wL5gDrmxgWN9RYNEioKPGfMAEvOg6YZmnDFQ6cdhBu2vaJZr5/hkEcAJGjLdUCjT4zXZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowACHLtfjkz5qSjlrAw--.37345S2;
	Fri, 26 Jun 2026 22:59:48 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Zack Rusin <zack.rusin@broadcom.com>,
	dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Christian Koenig <christian.koenig@amd.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: drm/vmwgfx: ttm_base_object_init: fix tfile reference leak on error   paths
Date: Fri, 26 Jun 2026 22:59:46 +0800
Message-Id: <20260626145946.49620-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHLtfjkz5qSjlrAw--.37345S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWUZFy8Gw4kZrW5GFy8Xwb_yoW8Wr1kpa
	yaqry3AryrJr48KrZrAan5XFnIy3sF9rn8KFyYv3ZxZr15Za43Crs5ta1qgFWUGrs7Ar42
	qF4j9F9xZFWUZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAKA2o+idsaBAAAsd

ttm_base_object_init calls ttm_object_file_ref(tfile) to acquire a tfile
  reference early in the function. On error paths (idr_alloc failure and
  ttm_ref_object_add failure), the function returns without calling
  ttm_object_file_unref to release this reference, causing a tfile
  reference leak.

Add proper cleanup in the error paths to release the tfile reference via
  ttm_object_file_unref.

Cc: stable@vger.kernel.org
Fixes: 0b8762e997df ("drm/ttm, drm/vmwgfx: Move the lock- and object functionality to the vmwgfx driver")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vmwgfx/ttm_object.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 2421b0dd057c..93ae5a07d70a 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -204,7 +204,7 @@ int ttm_base_object_init(struct ttm_object_file *tfile,
 	spin_unlock(&tdev->object_lock);
 	idr_preload_end();
 	if (ret < 0)
-		return ret;
+		goto err_unref_tfile;
 
 	base->handle = ret;
 	ret = ttm_ref_object_add(tfile, base, NULL, false);
@@ -218,6 +218,10 @@ int ttm_base_object_init(struct ttm_object_file *tfile,
 	spin_lock(&tdev->object_lock);
 	idr_remove(&tdev->idr, base->handle);
 	spin_unlock(&tdev->object_lock);
+	ttm_object_file_unref(&base->tfile);
+	return ret;
+err_unref_tfile:
+	ttm_object_file_unref(&base->tfile);
 	return ret;
 }
 
-- 
2.39.5 (Apple Git-154)

