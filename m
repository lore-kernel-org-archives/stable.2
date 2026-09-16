Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95DD463B87;
	Wed, 16 Sep 2026 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552156; cv=none; b=I/LdLlvGYEyMjhsvnv42Kgsj4vBKSkoPeYMdEfrqibZ18GlE1XDDxSow3e1ClGcFObF6iJPSI/Kri2TMmxn518o37lABGBhFZiL2bfpSIg3ydc2DD8+nhh16hdiiXvdx2Dlkqvs8QEx6l/HYqyGv0OLSq+b4U3xjrG2qNdFuwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552156; c=relaxed/simple;
	bh=nxEa1SHRcp4QPJ98V/dVdmArJyWqotnwbQb8eMyfAIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j0/H44+YG7U6RkYuzORAPKgnZcM0oDFd39qFLOvNBeNMjcDWSAoTzIj1Z/kZdBEkWzdOXdCsrCE9v0eMBSNvXUrgFPXHX9XnzxIfpyXg13umvtLID/9OLIainNAQoCGCuLN5pO4DN4FH1tP3SC5ic8QilcDtCOdsVOOV3qG8dIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADX2jj+ZapqO6XgBw--.42993S2;
	Wed, 16 Sep 2026 17:48:46 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: airlied@redhat.com,
	dri-devel@lists.freedesktop.org,
	gregkh@linuxfoundation.org,
	jeff.hugo@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	mwen@igalia.com,
	ogabbay@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm: Fix device leak in drm_dev_init()
Date: Wed, 16 Sep 2026 09:48:18 +0000
Message-Id: <20260916094818.2007896-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX2jj+ZapqO6XgBw--.42993S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWkuw13Jr48Wr4DWw47twb_yoWkurc_CF
	15Zr9rXr1vkrykJrnIy3W3ZrWayF4j9rZ3Jr17tayfKrWUXF12vrWj9r90qw1UWr43AFZ8
	Jas7ur4Syr1xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUogAwDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMMA2qqP4efBgAAs0

drm_dev_init() takes a reference to the parent device with
get_device() and releases it later through the drm_dev_init_release()
drmm action, which is only registered later in the initialization.
The check rejecting a driver that is both a compute acceleration and
a graphics driver returns -EINVAL before that action is armed, leaking
the device reference.

Drop the device reference on the feature check error path before
returning.

Fixes: 7428ff70a18a ("drm: initialize accel framework")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 675675480da4..b4c0a3b03b6f 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -729,6 +729,7 @@ static int drm_dev_init(struct drm_device *dev,
 				(drm_core_check_feature(dev, DRIVER_RENDER) ||
 				drm_core_check_feature(dev, DRIVER_MODESET))) {
 		DRM_ERROR("DRM driver can't be both a compute acceleration and graphics driver\n");
+		put_device(dev->dev);
 		return -EINVAL;
 	}
 
-- 
2.34.1

