Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605519D07A;
	Fri, 26 Jun 2026 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485831; cv=none; b=oDlD7HYZOpoNsVqhfHgu3aqcQWCgwL9TeGoEIZG1SMlVoBkgDHrixS3MrcQhpr5VdTV8aD7K+3xqIsWKnEAHBSaCStlJQ+puXiXyYMPX05CPxFewAq/7Mn4wnPRsVUjsZOg0js2lvAhn1KHTb5rZNycRzt8V/0YbRrvh+EEClgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485831; c=relaxed/simple;
	bh=gIg2Cw00dZdNs1YqB/9Tp+YAf6cLEqAJbSnXlBKlJBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jiBeMPmektomZvRTrdaNjA2tANqPTmRKm0tZOSbT3hjuhBjImSussYP+16uofd6MgYmb2ngzqFvZNTgotgc5HAw3wnFbsq8dG46i521W/watZVXWv6+pZ8os6MCqGbkQ+XF3xaDbbsJ+iXqZ0xyaPsvNTeUDMLH5VRjoUcXxT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowACXMco4kz5qPxlrAw--.16494S2;
	Fri, 26 Jun 2026 22:56:57 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	dri-devel@lists.freedesktop.org
Cc: Maira Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andre Almeida <andrealmeid@igalia.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: drm/vc4: vc4_cl_lookup_bos: fix NULL pointer dereference on   drm_gem_objects_lookup failure
Date: Fri, 26 Jun 2026 22:56:55 +0800
Message-Id: <20260626145655.49508-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXMco4kz5qPxlrAw--.16494S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw1kJr4DKF15tF4xZr4DCFg_yoW8JrWxpr
	srJryIgFy8GF4xt3ZIqF4kXas0ka15tFZ7CF1a93y3ur1rJF1Ykrnxua48XFyUAFWxtF1x
	Xr1qka92vF40yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMKA2o+iCgemQAAsg

When drm_gem_objects_lookup fails, it sets *objs_out to NULL, leaving
  exec->bo as NULL. The fail_put_bo error handler unconditionally iterates
  over exec->bo[i] without checking for NULL, causing a NULL pointer
  dereference.

Add a NULL check for exec->bo before accessing its entries in the
  fail_put_bo error path.

Cc: stable@vger.kernel.org
Fixes: ba3f6db4afee ("drm/vc4: replace obj lookup steps with drm_gem_objects_lookup")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index ab3c6d5d4eb4..f79c0171e43e 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -724,10 +724,12 @@ vc4_cl_lookup_bos(struct drm_device *dev,
 
 fail_put_bo:
 	/* Release any reference to acquired objects. */
-	for (i = 0; i < exec->bo_count && exec->bo[i]; i++)
-		drm_gem_object_put(exec->bo[i]);
+	if (exec->bo) {
+		for (i = 0; i < exec->bo_count && exec->bo[i]; i++)
+			drm_gem_object_put(exec->bo[i]);
 
-	kvfree(exec->bo);
+		kvfree(exec->bo);
+	}
 	exec->bo = NULL;
 	return ret;
 }
-- 
2.39.5 (Apple Git-154)

