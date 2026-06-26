Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01F3F4DCC;
	Fri, 26 Jun 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479601; cv=none; b=Dk23UbAZOM4/wpmhEbjr/SwHTcoqBzLrX8+g+89S+08DtNiuEGuEBw6IdQlhwWF1RwBrTOGjPWfyCFpIEorLnNB8Gete8ZnPpkDKF5vFKiGgdcEY+FhHdlMchEuN+PR0G0rlEdF9JYc+ZJ2yLOxtmyvSXhgyECQ6XJenjP9bF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479601; c=relaxed/simple;
	bh=yghLBSQTZS9kEHyuVgI/MF/OYvrlnW4IWjLAqGCgn+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sQPDMPJRp73+W2qzVfwkf/03fptmV7/71FlzjcBSUwvuxfSb7/w0eEdfJ+0Y6TG73Dx8TGYCycfptY+L+rrOtfrnyTuqtJmEL9pSg/dV0dVGxR7NagdqXeb9v6QVl7YfM8en60uCmWRt5XoTu1SP2DGIOUuGhJzp6odX5w7aB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowABHkcTmej5q09ppFQ--.22955S2;
	Fri, 26 Jun 2026 21:13:12 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: drm: drm_mode_obj_get_properties_ioctl: DRM_MODESET_LOCK_ALL_BEGIN   retry leaks drm_mode_object reference
Date: Fri, 26 Jun 2026 21:13:08 +0800
Message-Id: <20260626131308.37604-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHkcTmej5q09ppFQ--.22955S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4fCr1UAr15tryrtF18Xwb_yoW8Xr48pr
	43K34jkrW0yrZ7KFs7CFWv9F9Yya129rWrGF1Sk3Wag3ZYyF1UZFy5ur4DtFy7tr93Jr1a
	qFnIyF9xAay7Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqeHgUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0KA2o+SxmZGAAAsF

The DRM_MODESET_LOCK_ALL_BEGIN macro retries the ioctl on -EDEADLK. Each
  retry re-executes drm_mode_object_find, overwriting the obj pointer
  without releasing the previous reference via drm_mode_object_put. The
  out_unref label only releases the final obj, leaking references from
  earlier retry iterations.

Cc: stable@vger.kernel.org
Fixes: 949619f32eee ("drm: Extract drm_mode_object.[hc]")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_mode_object.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 2d943a610b88..10fce40f7020 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -479,7 +479,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
 				      struct drm_file *file_priv)
 {
 	struct drm_mode_obj_get_properties *arg = data;
-	struct drm_mode_object *obj;
+	struct drm_mode_object *obj = NULL;
 	struct drm_modeset_acquire_ctx ctx;
 	int ret = 0;
 
@@ -487,7 +487,9 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
 		return -EOPNOTSUPP;
 
 	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
-
+	if (obj)
+		drm_mode_object_put(obj);
+
 	obj = drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type);
 	if (!obj) {
 		ret = -ENOENT;
-- 
2.39.5 (Apple Git-154)

