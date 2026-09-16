Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB395C613;
	Wed, 16 Sep 2026 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582018; cv=none; b=SBlPHINJtLFpFUdqz7Cp6O51mjuM6OK04B/3U+d7tJEahS1bvkCnLHfKWT9q/ElwJXE9V7oCrg8y0T/rOR3TkrthSQP9IzPEGz1YF47HOKorablHJOLIZnkkpvbq1OYkaJSa57h0m4lu06fNBS87JBOwk7pCPV96xsEB1ZT//Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582018; c=relaxed/simple;
	bh=4AnRJ1XeQlYuEAo8rWrIHNuSrlOvPwd4usuLRJNZnSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F/MKRrtsWocD+ks3Zta/6Zih6BwnpDRXLWMtF1wl27Y7TcrqzzfrmtUA7a8qekd0zFRtIgW3tnEn0jPZcQkAdidPnaxnhLnVTJDQCrFB5EF3ty0tXT2H3uVF3xNMNf10cEo6lHw9ozFVW08RpuWWmONj/t4elCHBEYS7EEy3sM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXiEKZ2qpqHS1vCA--.23862S2;
	Thu, 17 Sep 2026 02:06:17 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: architt@codeaurora.org,
	bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	eric@anholt.net,
	florian.fainelli@broadcom.com,
	jesszhan0024@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	simona@ffwll.ch,
	treding@nvidia.com,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panel: Fix node reference leak in rpi_touchscreen_probe()
Date: Wed, 16 Sep 2026 18:05:49 +0000
Message-Id: <20260916180549.2090497-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXiEKZ2qpqHS1vCA--.23862S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4ktrW5ZryUXw1rKw1rWFg_yoWkArXEkr
	yFqF9rXr1UJFyDur17A3ZxArsakFn8urWfAa18ta4Sk347urnrXayfW34UXr1DGF4jyr98
	Xw17XF1FgrsrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJV
	W0obIYCTnIWIevJa73UjIFyTuYvjTRRD7VDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUMA2qqozV7RgAAs4

of_graph_get_remote_port() returns a reference to the remote port
node.  On the success path that reference is passed to the registered
DSI device and released with it, but if mipi_dsi_device_register_full()
fails the reference is never dropped.  Release it on the error path.

Fixes: 2f733d6194bd ("drm/panel: Add support for the Raspberry Pi 7" Touchscreen.")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index dc4bb8ad9131..c14776561623 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -428,6 +428,7 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c)
 	if (IS_ERR(ts->dsi)) {
 		dev_err(dev, "DSI device registration failed: %ld\n",
 			PTR_ERR(ts->dsi));
+		of_node_put(info.node);
 		return PTR_ERR(ts->dsi);
 	}
 
-- 
2.34.1

