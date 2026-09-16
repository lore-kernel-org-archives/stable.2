Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B384BB5C5;
	Wed, 16 Sep 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554029; cv=none; b=Bya9j5E1RE3zTMSGa9RW0qKoNQJUC2ukE9m2qaYsbyG6j9a9dKPhlpEmogWoDPgDOReMtJ4RSuzKk1Lfb7EtKV7jwYQlSovwdADm8dtk7w/gBGKC+Igueq5wEGfhne0LkESt/5PuRO62W5blWKPjv89c6wWyOUcwEjUvS9sNAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554029; c=relaxed/simple;
	bh=JnG1JuvwKW9oTgJMKov9H6l9zRvdE/vDrMtLBm/qcSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JbeJGk50a8Yyc07lwBKRbjF8ReSucmnXNQopzXp0ol8y+aD7vOqzcQ9B3Em6OBvmq6oKrMKJu53Od+4LuP7Mpwrkl0b8vJxgSXob9FfsXYSkqwCGCgMCc50MAPsfTLCcP66UiRldDAqh2AogVDr+Wr77/kbKa09EPOqiH8SWG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wkBGbapqD_3gBw--.1931S2;
	Wed, 16 Sep 2026 18:19:50 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Laurent.pinchart@ideasonboard.com
Cc: airlied@gmail.com,
	andrzej.hajda@intel.com,
	dharma.b@microchip.com,
	dri-devel@lists.freedesktop.org,
	hari.prasathge@microchip.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	linux-kernel@vger.kernel.org,
	lumag@kernel.org,
	maarten.lankhorst@linux.intel.com,
	manikandan.m@microchip.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: microchip-lvds: Fix runtime PM leak in mchp_lvds_enable()
Date: Wed, 16 Sep 2026 10:19:22 +0000
Message-Id: <20260916101922.2018259-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wkBGbapqD_3gBw--.1931S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1UGry5try8WF1fWF1rWFg_yoWkKwb_Ca
	s5Zrn7Xw4FkFWqkr47A3y3Z3saq3WDurW8Wa1rtan3trWUAF1DA347XrZ8ArnrXw4UtF9r
	Kw4qkF18ArnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
	JvcSsGvfC2KfnxnUUI43ZEXa7sRRznmtUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQMA2qqP4ezawABsz

mchp_lvds_enable() resumes the device with pm_runtime_get_sync() and
returns early when the resume fails.  pm_runtime_get_sync() increments
the runtime PM usage count even when it fails, so returning without
dropping the reference leaks it and prevents the device from ever
suspending again once the error has been hit.

Drop the runtime PM reference with pm_runtime_put_noidle() on the
resume failure path before returning.

Fixes: 179b0769fc5f ("drm/bridge: add lvds controller support for sam9x7")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/microchip-lvds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/bridge/microchip-lvds.c
index 9f4ff82bc6b4..b77ec6ae0a97 100644
--- a/drivers/gpu/drm/bridge/microchip-lvds.c
+++ b/drivers/gpu/drm/bridge/microchip-lvds.c
@@ -127,6 +127,7 @@ static void mchp_lvds_enable(struct drm_bridge *bridge)
 	ret = pm_runtime_get_sync(lvds->dev);
 	if (ret < 0) {
 		dev_err(lvds->dev, "failed to get pm runtime: %d\n", ret);
+		pm_runtime_put_noidle(lvds->dev);
 		return;
 	}
 
-- 
2.34.1

