Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED734B95DC;
	Wed, 16 Sep 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573258; cv=none; b=ZErs1Q7OAGT/ccCZg4suyFyYUfK0078O+R2K2Nu8y5Am0lnMpHAbcFP1mT77kUFDRz1miJzW5H7YQ6kXdV+0WuFXaVyEYWzhzBRdaxJUb/UiqwKK/SJ197AfdOxxIJ4eMO05TqrP6TS3QxEW8osfXXE/WiRCE/PU/ldI1MXMmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573258; c=relaxed/simple;
	bh=uQKMKpHE7Ee9ME9tbD5SxWzfLhUHj1dEcESId5XcjzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Am93B5G1IuVRHyPyJ557nNK7CP6gs6edTGQ4QnTtTYmIQisBatXUFBcqzeAPr+Q4hzMgnym4pFH9CLSuJzO4iDU3zJ/m++vygyAz6RtSW1tEBR011xMLiPCHqBFtougtBHcljtj6Ulybt0nYP7Xt24Vn/qZYOxijLen7F2oJYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXATx7uKpqrPxsCA--.21197S2;
	Wed, 16 Sep 2026 23:40:43 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dave.stevenson@raspberrypi.com,
	dri-devel@lists.freedesktop.org,
	javierm@redhat.com,
	kernel-list@raspberrypi.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mcanal@igalia.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vc4: Fix firmware reference leak in vc4_drm_bind()
Date: Wed, 16 Sep 2026 15:40:15 +0000
Message-Id: <20260916154015.2056797-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXATx7uKpqrPxsCA--.21197S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW5Ww45XryxKFykArW3GFg_yoWDtFc_ur
	18ZrZ7XrW8uFWq9r9rCw47Ar9Ik3yDWFWFva1ayayfJr13JF4jqFya93y5Xry7Cr47AFyD
	A3WDXrWrCa17GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCT
	nIWIevJa73UjIFyTuYvjfUwFApDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcMA2qqok86DAABsU

The firmware reference obtained via rpi_firmware_get() is leaked when
aperture_remove_all_conflicting_devices() fails, as the error label
returns without putting it. This happens before the firmware is
consumed and put further down in the function.

Put the firmware reference before jumping to err.

Fixes: c406ad5e4a85 ("drm/vc4: Notify the firmware when DRM is in charge")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index a14ecb769461..7953d4f781d8 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -362,8 +362,11 @@ static int vc4_drm_bind(struct device *dev)
 	}
 
 	ret = aperture_remove_all_conflicting_devices(driver->name);
-	if (ret)
+	if (ret) {
+		if (firmware)
+			rpi_firmware_put(firmware);
 		goto err;
+	}
 
 	if (firmware) {
 		ret = rpi_firmware_property(firmware,
-- 
2.34.1

