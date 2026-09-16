Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6694BB5C1;
	Wed, 16 Sep 2026 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553849; cv=none; b=qDuSazqN2O/ssQGh/ZN/bvXys6davhDbrkIL83AUdPvMtgZLGQWelkYsMw2iJz8HlcMxcCmo6Rf4RnP0eHZXu/9egHJVj0aTvXRzs32++8VkOBG/BX5CMWmIeHOpUQDCSXdsHqedSUXh1OvT2oQzP1ggiyNuP8QmF9XazCHB6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553849; c=relaxed/simple;
	bh=GVkwIxuFT18VCMsx2q2ahzAHTO92OQow3Xrd748OWj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oSUWcSY6tOGSEJx4P8Uh3fVMEFMN5EeeD2lykuj9w89S1POlYPawNlVb/yForU8OIH4mkiYyWNfYKVpOPvhJUgMjwh6wJkV4Vq+QGVzy93BwF/IA5w4Dh+l3p9Y4Im9qJyn3zuQ/3Ts147OPtoHPbPnmb/jMywABYWp0OfmSxMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHCzmZbKpqwvXgBw--.35051S2;
	Wed, 16 Sep 2026 18:16:57 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Laurent.pinchart@ideasonboard.com
Cc: airlied@gmail.com,
	andrzej.hajda@intel.com,
	dri-devel@lists.freedesktop.org,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	linux-kernel@vger.kernel.org,
	lumag@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	sam@ravnborg.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: lt9611uxc: Fix DSI device node leak in lt9611uxc_probe()
Date: Wed, 16 Sep 2026 10:16:29 +0000
Message-Id: <20260916101629.2017781-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHCzmZbKpqwvXgBw--.35051S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy8XF4kuFW7ZF4xGFWxZwb_yoW8Xr1rpa
	17CFyFkryUCF4xKrZrAF1UGa9IyanrtrWfCF9rGa409wnxXF47Aw4av3WFgF18Wa4UArya
	yF15trWUGa4kZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9S14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6r
	xdYxBIdaVFxhVjvjDU0xZFpf9x0pRWGQhUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAMA2qqQJWs5wAAsW

lt9611uxc_parse_dt() obtains references to the primary and secondary
DSI remote nodes with of_graph_get_remote_node() and stores them in
dsi0_node and dsi1_node.  If the following lookup of the panel or
bridge with drm_of_find_panel_or_bridge() fails, lt9611uxc_probe()
returns without calling of_node_put() on the DSI nodes, leaking the
references taken by of_graph_get_remote_node().

The error paths further down in lt9611uxc_probe() already release both
nodes through the err_of_put label.  Route the device tree parsing
failure to that label as well so the node references are dropped on
that error path too.

Fixes: 0cbbd5b1a012 ("drm: bridge: add support for lontium LT9611UXC bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 11aab07d88df..16ca26212d78 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -765,7 +765,7 @@ static int lt9611uxc_probe(struct i2c_client *client)
 	ret = lt9611uxc_parse_dt(dev, lt9611uxc);
 	if (ret) {
 		dev_err(dev, "failed to parse device tree\n");
-		return ret;
+		goto err_of_put;
 	}
 
 	ret = lt9611uxc_gpio_init(lt9611uxc);
-- 
2.34.1

