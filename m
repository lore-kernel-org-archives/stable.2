Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3B3D9DA8;
	Wed, 16 Sep 2026 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581246; cv=none; b=eil8E6JOb+ABZnlfZHGiiYJKic0mwiY1qt5L4Kz7B/E+dQ/b1c/kZhZXZylCLzxgWk3GCzg08SQgv8ksJw+BKGJYrgkukOUKtk2SI9fd53dOB/wJ9JCv1ZNgs5N4AljyPb9RyXZUm07FRSqIHoZf7JLIKmwGYKy0aUEZ2RACszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581246; c=relaxed/simple;
	bh=R4HqXppZEUY4+IfGjq0X2iLDH3NiLu09nBUKcHayQX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s1zOw5yCjnh6eXvAO3mI2cZjvqMT7iJ//zbAmf5mrNVhEmdQf7F94J7KRsACToBEcr15TdXj0gVZK84cOnGLnVOWrebW/xFdxuP/fh2FwiXkUjzh3EGwk4BSw51UKIRvoSGloCyLP5HfZxF/yJRf1ugdbEmXj4RGYsLv7UgTdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXATya16pq1PhuCA--.23488S2;
	Thu, 17 Sep 2026 01:53:30 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: christian.koenig@amd.com,
	dmitry.osipenko@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	robin.clark@oss.qualcomm.com,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/syncobj: Fix syncobj leak in drm_syncobj_import_sync_file_fence()
Date: Wed, 16 Sep 2026 17:53:03 +0000
Message-Id: <20260916175303.2089579-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXATya16pq1PhuCA--.23488S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWUtw13ur47XFyrXFW5KFg_yoW8Wr4UpF
	sxGryqkrykta10yrWfCFWqvFyrCw12qFW0gr18Awn5A3Z5tr1jy345GrWqga4DAr97Cryf
	twnFkFWYvFn8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMMA2qqpO9v9gABsT

When importing a sync file fence into a timeline syncobj with a non-zero
point, drm_syncobj_import_sync_file_fence() allocates a dma_fence_chain
with dma_fence_chain_alloc(). If that allocation fails the function
returns -ENOMEM directly, leaking the reference on the syncobj taken by
drm_syncobj_find() (and the reference on the fence taken by
sync_file_get_fence()).

Jump to a cleanup path that drops both references before returning the
error.

Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline syncobjs")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_syncobj.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 8d9fd1917c6e..7e1502cbd852 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -742,7 +742,7 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
 		struct dma_fence_chain *chain = dma_fence_chain_alloc();
 
 		if (!chain)
-			return -ENOMEM;
+			goto err_put;
 
 		drm_syncobj_add_point(syncobj, chain, fence, point);
 	} else {
@@ -752,6 +752,10 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
 	dma_fence_put(fence);
 	drm_syncobj_put(syncobj);
 	return 0;
+err_put:
+	dma_fence_put(fence);
+	drm_syncobj_put(syncobj);
+	return -ENOMEM;
 }
 
 static int drm_syncobj_export_sync_file(struct drm_file *file_private,
-- 
2.34.1

