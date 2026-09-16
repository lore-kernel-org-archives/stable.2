Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37984B7166;
	Wed, 16 Sep 2026 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553094; cv=none; b=St0gFt5Fgl5E5E20YJhl8/S0W8Z/AfdMPTvwj/CcJiCU9J7vLeoTSbqEKwadmYCF3uDuna0PADHyC9BI4xZIC6YOIgOc9y5Qo0m94XPg7LQg7qFSIPWQN2CjEa49+1Wc0uJUg6XgtCZKvzFtZ/U/4t2/yEs0fMpomBNMvEhWE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553094; c=relaxed/simple;
	bh=OI+yoHit86yXZwNiytxw7fJ0exFumjpm8EEW57HUNKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fV03aeI2cjAOjGFeVRIW1rWsQwchnKDGjAVBzb34uXKZOlNTAjlyzPDqIzc/Jfg0HnbGyiaQjORsjtIyFSuW+0inUCoV6h+aV+/rCqyFc4eUwydfFfRecV3HJ3vu8cVShHpntg/buFKtbeR9GGZPQk0BnlpGTrqc3UT/LXjpp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHijixaapqONXgBw--.42711S2;
	Wed, 16 Sep 2026 18:04:34 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Laurent.pinchart@ideasonboard.com
Cc: airlied@gmail.com,
	andrzej.hajda@intel.com,
	architt@codeaurora.org,
	bbrezillon@kernel.org,
	dri-devel@lists.freedesktop.org,
	eric@anholt.net,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: cdns-dsi: Fix runtime PM leak in cdns_dsi_bridge_atomic_pre_enable()
Date: Wed, 16 Sep 2026 10:04:05 +0000
Message-Id: <20260916100405.2012604-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHijixaapqONXgBw--.42711S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWfXF4fJw4DKF1rKFykXwb_yoW8Xr4fpF
	4vga4YkrZ7Za1ay3ykArnFqa45Ca9rtayrGrZ7tw1vvr1rG3WUJr9xAryaqF1vkas2qF13
	Jwn7K347GF4xtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7sRiNeOPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUMA2qqP4eqpwAAsm

cdns_dsi_bridge_atomic_pre_enable() resumes the DSI controller with
pm_runtime_get_sync() and returns early with a WARN_ON() when the
resume fails.  pm_runtime_get_sync() increments the runtime PM usage
count even when it fails, so returning without dropping the reference
leaks it and prevents the device from ever suspending again once the
error has been hit.

Drop the runtime PM reference with pm_runtime_put_noidle() on the
resume failure path before returning.

Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 0dd85e26248c..fca4528edfa6 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -733,8 +733,10 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	 * enable their streams.
 	 */
 
-	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
+	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0)) {
+		pm_runtime_put_noidle(dsi->base.dev);
 		return;
+	}
 
 	new_bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
 	if (WARN_ON(!new_bridge_state))
-- 
2.34.1

