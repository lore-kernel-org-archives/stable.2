Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B52450414
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931268; cv=none; b=sLNh/p/0ooo9Ww8i8TMoqqRt7J6DJS484RtsuaASYDNBM8ABdbehJvHo1D/5vTdvcPGmA1ZYFblXdiDLxqfXGhooRXu8Br8aWzJ6YmbFOt0+pFAXsTAspQIXOHz254TyaTJwRZHeRDNqB39C2TwF1dlL3vXoM9Guj1+vVZnWUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931268; c=relaxed/simple;
	bh=DA8U4VAOW585jFlypRV697khZNn4ZypNHl7Zism8hE0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GPRwvHfmKxJ/1H7mfG9Fa1asYeFrsrBdxHh6VrBzKOVilpVDO077/fE2ct5XHSVOviKe4nQAMOadBhlIo9xB1IfFaHH9Bipzrg55RdQA/0TEGHnMrgr6vDhLVj6ojt3n8d8VFxLmSZIRsTa/YP2gFLFtxChqLXDNVsPmxfimhbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PL6k2SSi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PL6k2SSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171BC1F00A3A;
	Wed,  5 Aug 2026 12:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931267;
	bh=QRTPx2kmUTtjry8gffSKLdFrSHXDe9tGwynpSZ4uoIA=;
	h=Subject:To:Cc:From:Date;
	b=PL6k2SSi3sep8WK7S0OXODXC+QLqnFnyyXJofWv2J50H9tn5agLD/9lBtE/o4oBFz
	 41cQs6jAiFfoqIUKmAVCAdz35xL3LvFrvRT10fsiKswThKGL/TNOY8J/KGeS4zIeJ6
	 NeJP3e16nGFfuM2C/d8kKLjjR7hiDafbq84NNSow=
Subject: FAILED: patch "[PATCH] drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable" failed to apply to 7.1-stable tree
To: angelogioacchino.delregno@collabora.com,chunkuang.hu@kernel.org,ck.hu@mediatek.com,me@adamthiede.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:58:03 +0200
Message-ID: <2026080503-borough-upstroke-2a33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3e191eddbdcb8bf7beb1e9b58209073bd5450719
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080503-borough-upstroke-2a33@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e191eddbdcb8bf7beb1e9b58209073bd5450719 Mon Sep 17 00:00:00 2001
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Tue, 28 Jul 2026 17:31:45 +0200
Subject: [PATCH] drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable

Commit 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock
during pre-enable") rightfully moves the HS clock enablement to
before atomic_enable(), but it's moving it to mtk_dsi_poweron(),
which is not only called in the .atomic_pre_enable() callback
for the DRM bridge, but also in the MediaTek DRM's .ddp_start()
callback, which happens way before the bridge ones.

The HS clock enablement should be done at just the right time,
otherwise some bridge chips (or some Display Driver ICs) may
not work correctly: this is seen at least with a Parade DSI to
eDP bridge (PS8640) on the MT8173 Elm Chromebook.

This resolves a regression that was seen on the aforementioned
machine, which was happening only after a suspend-resume cycle.

Cc: <stable@vger.kernel.org> # 7.1.x
Fixes: 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock during pre-enable")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Adam Thiede <me@adamthiede.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260728153145.578404-1-angelogioacchino.delregno@collabora.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index eb325e68aa59..49dfc0f825cb 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -743,8 +743,6 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	mtk_dsi_set_vm_cmd(dsi);
 	mtk_dsi_config_vdo_timing(dsi);
 	mtk_dsi_set_interrupt_enable(dsi);
-	mtk_dsi_lane_ready(dsi);
-	mtk_dsi_clk_hs_mode(dsi, 1);
 
 	return 0;
 err_disable_engine_clk:
@@ -858,6 +856,9 @@ static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	ret = mtk_dsi_poweron(dsi);
 	if (ret < 0)
 		drm_err(drm, "failed to power on dsi\n");
+
+	mtk_dsi_lane_ready(dsi);
+	mtk_dsi_clk_hs_mode(dsi, 1);
 }
 
 static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,

