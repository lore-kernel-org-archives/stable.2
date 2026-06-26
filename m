Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504B3CE0AE;
	Fri, 26 Jun 2026 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479995; cv=none; b=gOrrTq9tlsatLxi0jhmrQwggojS3dDUOjfTc5WP+cROhrJaDc7mNPRJ9HnELNwhDTNqMCY3HWhaRuUKHADDBh1JUtPD/rqWUg1QLk0ybGyrj0kIvzziI8oNTmzCvsDgC2myzwViGhW1BXynuWboXbWwE19AnyFr2+mM488IiHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479995; c=relaxed/simple;
	bh=4y8wUcGKIweeu0hn0uqjOp8CjSx9yjvRdoPJebgYLuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJWbzAGGysrr6/Q/gshX2/pGWQ+NBW8TwiHuMtAznKPhkIAs06dbGENTAldvQamFlJdUwaAepIEMQl25EWCuucRlyTGWs1nC31Nm5GWaDU8lYRQ6PHNJcOD39XJykDUlg2NdxnGRC0VC4ltIv/0djD865d4KH0DwJhZ9xiwlwy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowACX_uFvfD5qFxJqFQ--.11251S2;
	Fri, 26 Jun 2026 21:19:45 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: xinliang.liu@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: sumit.semwal@linaro.org,
	yongqin.liu@linaro.org,
	jstultz@google.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: drm/hisilicon: kirin_drm_crtc_init: premature of_node_put leaves   crtc->port as dangling pointer
Date: Fri, 26 Jun 2026 21:19:42 +0800
Message-Id: <20260626131942.38072-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX_uFvfD5qFxJqFQ--.11251S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtFWxur1fKFyrCw17tFWUArb_yoW8JryfpF
	W7urWayry5A3yftFyjkFy29FWYka1UtFZ7uF1xCw1avrs0vFyUJasIvryvqF98AryxJaya
	vr4kta13Zr18CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU5iihUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsKA2o+TTuNqAAAsC

of_get_child_by_name acquires a reference on the port node, but
  of_node_put is called before crtc->port is assigned. This releases the
  reference while crtc->port still holds the pointer for later use by
  drm_of_find_possible_crtcs. Fix by moving of_node_put after crtc->port
  assignment.

Cc: stable@vger.kernel.org
Fixes: 89a565dba1a0 ("drm: kirin: Move ade drm init to kirin drm drv")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 8a11c2df5b88..cc453b29b22c 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -53,8 +53,8 @@ static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		DRM_ERROR("no port node found in %pOF\n", dev->dev->of_node);
 		return -EINVAL;
 	}
-	of_node_put(port);
 	crtc->port = port;
+	of_node_put(port);
 
 	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
 					driver_data->crtc_funcs, NULL);
-- 
2.39.5 (Apple Git-154)

