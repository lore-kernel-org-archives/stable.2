Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA983AFCFE;
	Sat,  6 Jun 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761389; cv=none; b=SobVK1k10N06kDTnm/OrOxoebkN8GjiSdScn3Umqs0Q85CvIuvZvHmd9vwiWG3KOTjEqeeHZH8iYp/QbspGZWH3r4t21qcZSKKIrtMNVWGrvdWudat02PZqmCmK7LSDykI/Z79CFu2SfMvsBC394Jhn2yt4GuHFusvaJr0q2hRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761389; c=relaxed/simple;
	bh=MEsDFD+1Z/O5zMYKGU2N+EcE6BFk7o2WKQltlsBeVPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RZ7CBIHUaJtsfGIeLGneB3C0t+JQSzt6QCXN3uP7YeVVBxms6FRBNPi0ivkFWfC4jqtPdFIvZT/Y0l5uonexDdxeZp62z8JZB7V8QB0PIFpkOmHrv/kuftbKah7tGpGH9bvDNE9zBHoBbX7q/pSWOo2wW5PFOtNAg6h81jEFJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXr9IiQyRqIdiEEg--.22962S2;
	Sat, 06 Jun 2026 23:56:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: lyude@redhat.com,
	dakr@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/acr: fix missing nvkm_done() in error path of nvkm_acr_oneinit()
Date: Sat,  6 Jun 2026 15:56:06 +0000
Message-Id: <20260606155606.77593-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXr9IiQyRqIdiEEg--.22962S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4UCw4xCr4DJw1UCFWrAFb_yoW8Xr1rpF
	47WFyayr4xJa1ftayktF18CFyruwsYkrWIk34DK3s8ZwnxAryavr4Fya1UZryFyrnxCr13
	XFsrJa45AryYyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU1eWlPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkKA2okN20QHQAAse

In nvkm_acr_oneinit(), nvkm_kmap(acr->wpr) is invoked unconditionally
at line 309 to obtain a mapping reference. Additionally, when both
acr->wpr_fw and acr->wpr_comp are present, a second nvkm_kmap() is
called inside the conditional block. Both mappings are expected to be
released by nvkm_done(acr->wpr) at line 320 before the function returns
successfully.

However, when a mismatch is detected during the loop within the
conditional block, the function returns -EINVAL at line 318 without
calling nvkm_done(). This results in a leak of the kmap reference(s)
acquired earlier.

Fix the issue by invoking nvkm_done(acr->wpr) prior to the early return
to ensure proper release of the mapping references.

Fixes: 22dcda45a3d1 ("drm/nouveau/acr: implement new subdev to replace "secure boot"")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
index 4c7745cd6ae5..7fd967a2554f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
@@ -315,6 +315,7 @@ nvkm_acr_oneinit(struct nvkm_subdev *subdev)
 					  i, us, fw);
 			}
 		}
+		nvkm_done(acr->wpr);
 		return -EINVAL;
 	}
 	nvkm_done(acr->wpr);
-- 
2.34.1

