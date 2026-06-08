Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6A71D5CD1;
	Mon,  8 Jun 2026 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780881330; cv=none; b=pPF1M4nQQg2dUhTDL8jKUcUiHX65ZDVQ/Ze7Si68/dvJfi5/rWXfNnWFZyj/340+V2EXldONXvMMR+OIxjxNmUJ5JQmpdVD4BdmKUdOBUVkEdJoOD6bH2IfrCXbyPMTeMQFUokfDKH8Y+F3Gr3hZ+ZgLhYJ9/y2T4BiWfeCwC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780881330; c=relaxed/simple;
	bh=W7tHzDZ/6aNpSc4Q0AaLnpWD8NFpG+xww8G9Ri25Jio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mX5pEfE7Gms1Vs5rbjMTN+ZVgdqtIvrVCy93ofs9/s3Fw8BsuxSNURK+b4a5OrHwptgDKCO+QMk+HNqytCqghEJ0X93lq5lsaSXGlRJ1L2iFD78ZW0jLT0PGDztMZ/b/6TakiC9LVNH+tJwRv86MV82oiIqpmwH4Kqm8yA4LCuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAA33tafFyZqsF7bAA--.3072S2;
	Mon, 08 Jun 2026 09:15:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: fix refcount leak in vmw_resource_do_validate()
Date: Mon,  8 Jun 2026 01:15:03 +0000
Message-Id: <20260608011503.102981-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA33tafFyZqsF7bAA--.3072S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18WF1Dur45tw18AF48Crg_yoW8XF1UpF
	4fGw1j9r98XFnrtFZIyws8Aa9IvasFkFWFgF13Cw1fZw4avryUJr45JrWF9r17CrW8tr1Y
	vrZ5A3y8CFyDGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7VU1eWlPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREMA2oliLqe2wABsu

If the call to func->dirty_alloc() fails in vmw_resource_do_validate(),
the function returns without releasing the resource created by
func->create() (or the previously existing resource), leaking the
dev_priv->num_fifo_resources reference counter. This counter tracks
active FIFO resources and must be balanced by calling func->destroy()
on failure.

The existing error path for binding failures already jumps to the
out_bind_failed label which calls func->destroy(). Extend this
handling to the dirty_alloc() failure case.

Fix the leak by jumping to out_bind_failed when dirty_alloc() fails.

Cc: stable@vger.kernel.org
Fixes: b7468b15d271 ("drm/vmwgfx: Implement an infrastructure for write-coherent resources")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index 388011696941..93a5835e485a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -402,7 +402,7 @@ static int vmw_resource_do_validate(struct vmw_resource *res,
 		if (res->guest_memory_bo->dirty && !res->dirty) {
 			ret = func->dirty_alloc(res);
 			if (ret)
-				return ret;
+				goto out_bind_failed;
 		} else if (!res->guest_memory_bo->dirty && res->dirty) {
 			func->dirty_free(res);
 		}
-- 
2.34.1

