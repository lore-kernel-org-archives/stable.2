Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8193D813C;
	Wed, 16 Sep 2026 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582297; cv=none; b=CY7WkWzh9DWTFCYf9OVqooKsu7rOh5cBCwN9SZsUuGuCWMrvW/Cxe2JI4/oWjGZZ5Yh18fDEX9aDwQp1M6dYNpzMWQB5uaCsT7QBMktQ0Gn9gf0efvDrDCDAo66A62ZIxceKIQMSxfMoYty9UKLZrVHSJGn8ms0qYlSz/WabIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582297; c=relaxed/simple;
	bh=aCn5FX863NOXRQyBaJN6Q73xp3cWUBN+H04UrFkEI1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YaRRVTy/L5jNUwzkarlc3FmEbV6mUmnPyIMbWzTWCJLXJR0MuC15DkuZ9B6CmWWWuI+bZTiDzzBSQ5mT0L6sUaYsYHsKxfYV4TlikKBPV9/6ZoZlBQHYYOwWcoth/yhfEVytBa6ztfBM/6nGcQTgLmrMm/p9+8D9lHemjJ4SoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnFUC926pq_UBvCA--.24651S2;
	Thu, 17 Sep 2026 02:11:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: andrzej.hajda@intel.com,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/rockchip: dsi: Fix second reference leak in dw_mipi_dsi_rockchip_bind()
Date: Wed, 16 Sep 2026 18:10:42 +0000
Message-Id: <20260916181042.2090801-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnFUC926pq_UBvCA--.24651S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFykXF1kXF1kuF48Xr1DKFg_yoW8XF4xpw
	s8Ja4YgrW8uFnFqrnrArZ8GF4FywnIyay8GFs7J3s2kan5AF1Ut345Wa4kX347JFn7AF1x
	Ar47Ga4rWF4xZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr
	0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1go2UUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAMA2qqpO93ZQAAsa

dw_mipi_dsi_rockchip_find_second() hands back the dual-DSI partner
device with a reference from of_find_device_by_node().  The bind path
only drops it after a successful master setup; the four early returns
(both/no clock-master, the slave shortcut and a missing slave drvdata)
leave the reference behind.  Drop it on all of them.

Fixes: cf6d100dd238 ("drm/rockchip: dsi: add dual mipi support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 3547d91b25d3..4ab29410b2c0 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -933,23 +933,27 @@ static int dw_mipi_dsi_rockchip_bind(struct device *dev,
 
 		if (master1 && master2) {
 			DRM_DEV_ERROR(dsi->dev, "only one clock-master allowed\n");
+			put_device(second);
 			return -EINVAL;
 		}
 
 		if (!master1 && !master2) {
 			DRM_DEV_ERROR(dsi->dev, "no clock-master defined\n");
+			put_device(second);
 			return -EINVAL;
 		}
 
 		/* we are the slave in dual-DSI */
 		if (!master1) {
 			dsi->is_slave = true;
+			put_device(second);
 			return 0;
 		}
 
 		dsi->slave = dev_get_drvdata(second);
 		if (!dsi->slave) {
 			DRM_DEV_ERROR(dev, "could not get slaves data\n");
+			put_device(second);
 			return -ENODEV;
 		}
 
-- 
2.34.1

