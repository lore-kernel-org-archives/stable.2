Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77A3E3140;
	Fri, 26 Jun 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485250; cv=none; b=SeN/xyCC0Wmc1eQUk4+2tlnds0lKmi8C9IzZnyKGXAoQdB3kuhzvzmICj9goUFLu7Tll8Ir+pGnUyoG9NTsVJiRujzbpWTXOMLKZJSaNtJ3b/qWutl97AYCDAb1TabNlq9dsZnsh/EJcI4ievnkTq/NqO05PDPla5YHLpROBVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485250; c=relaxed/simple;
	bh=1vjQHuX9PQnCY8FWRqMVwwefR+USU0fT39QjDUBfKnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=STkwaptn0qoC+BJrEN8soShc/t4SnNvAB4qw8jhmJDiRO4St+MEC6p3/tlyco6mQu2ERfHQxDsZQ1NSUWHj/m28MhmXD5jrrOMi5xn/VYd5O8NuUu11eOXB99y7zTHE/iEKrNnYpTtv7TXZSjhhCTY515SUU4EOUOEDNarMtxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowACXO9T1kD5qibBqAw--.4140S2;
	Fri, 26 Jun 2026 22:47:20 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ben Skeggs <bskeggs@redhat.com>,
	nouveau@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: drm/nouveau: nvkm_ucgrp_new: nvkm_cgrp_new failure leaks ucgrp   object and engine reference
Date: Fri, 26 Jun 2026 22:47:17 +0800
Message-Id: <20260626144717.49109-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXO9T1kD5qibBqAw--.4140S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW5Gw45WF15trWkKr45KFg_yoW8JFW8pr
	s3Jw1avrW5JF4rtF48A3W8uFyfZan0qFyFkas0y343Zrn8ZrW8Cr4Fy34qqFyrZr47Ga1Y
	yFn2yrZYqF1YyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOlkVUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcKA2o+h0EXvAABsw

nvkm_object_ctor initializes ucgrp with an embedded kref and increments
  the engine's reference count. When nvkm_cgrp_new subsequently fails, the
  function jumps to done without calling nvkm_object_del to release ucgrp.
  The caller ignores *pobject on error, so the ucgrp object and its engine
  reference are permanently leaked.

Cc: stable@vger.kernel.org
Fixes: 06db7fded6de ("drm/nouveau/fifo: add new channel classes")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c
index dfa3c7dbdf34..7d11b92f946b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c
@@ -113,8 +113,10 @@ nvkm_ucgrp_new(struct nvkm_fifo *fifo, const struct nvkm_oclass *oclass, void *a
 	*pobject = &ucgrp->object;
 
 	ret = nvkm_cgrp_new(runl, args->v0.name, vmm, true, &ucgrp->cgrp);
-	if (ret)
+	if (ret) {
+		nvkm_object_del(pobject);
 		goto done;
+	}
 
 	/* Return channel group info to caller. */
 	args->v0.cgid = ucgrp->cgrp->id;
-- 
2.39.5 (Apple Git-154)

