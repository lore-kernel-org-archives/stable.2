Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2F3DAAAF;
	Wed, 16 Sep 2026 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582433; cv=none; b=Fszn+e616tJcJKg2a7+JFQ6KGB2s1q1SP2mtSzAq71X3sfqpQglWQGZ3NnH/8Bqn2Uduu4MRdEqnoN6WZwsj4You37GTV3o8X4CsXGWi5xYcX7VmqaKPXvQcEqB4rUj0xIzWWCyCw7yNv2V8aclVsIb3Vh+9qaTZkFscrqwhhW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582433; c=relaxed/simple;
	bh=YNCF9zXpl7BclJy2vQTGEe+agcML92SIO46Rgj9QuA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C8/OxperBtm92S9T4WdxDNH/WsBqToT7zMoNd8WwgRWBlmVO0s/qyR0tEo1qfneJaYDdPXy3g3QZG8VO2wPEbw9DKqqtUNhvu2FQV97njl8N6XsYwdBkBkh0kUwHtTtF418IfXm7O9U0nsMIjzfMwOPGt2C2keRRk1zqeK6cg/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXwz1S3KpqnUpvCA--.24366S2;
	Thu, 17 Sep 2026 02:13:38 +0800 (CST)
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
Subject: [PATCH] drm/rockchip: dsi: Fix second reference leak in dw_mipi_dsi_rockchip_host_attach()
Date: Wed, 16 Sep 2026 18:13:10 +0000
Message-Id: <20260916181310.2090958-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXwz1S3KpqnUpvCA--.24366S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy8ZFyUZFykWw1UuF48WFg_yoWDWFX_K3
	4jqr1UWr4xJrnIk3WxA3y3urZFkasF9r48ta1jvFsxAa9rJr1Iq3yFgr1YqF1UAF47AFy7
	G3W0qr1rGa13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJV
	W0obIYCTnIWIevJa73UjIFyTuYvjfUw5l8UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgEMA2qqok9-DQABsW

The reference to the dual-DSI partner device obtained through
dw_mipi_dsi_rockchip_find_second() is dropped on neither the success
path nor when adding the partner as a component fails.  Release it on
both paths.

Fixes: cf6d100dd238 ("drm/rockchip: dsi: add dual mipi support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 4ab29410b2c0..2c1f1c53ddda 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1079,8 +1079,10 @@ static int dw_mipi_dsi_rockchip_host_attach(void *priv_data,
 			DRM_DEV_ERROR(second,
 				      "Failed to register component: %d\n",
 				      ret);
+			put_device(second);
 			goto out;
 		}
+		put_device(second);
 	}
 
 	return 0;
-- 
2.34.1

