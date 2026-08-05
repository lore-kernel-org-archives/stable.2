Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89B35F8B9
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931260; cv=none; b=eBiZVFr/7J3i3MLZT9vexl3ZC6CkhavxWfSysbbHlBO/nIdevU5IsOgR3+chSBARAi6qYq/aVExJQksbosF66rxcUmOZWTyJ1C1YDGb2vE4KGDl1etjhZV4/Bc4xOFoyQgBHKO2dRfm56UFrtRgqa4l6spx6Bi0KNLOaIlIPudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931260; c=relaxed/simple;
	bh=FKiRt4cGdGAwhcmYn+u11TsqbfW8AIlF71GxKxbKP6E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tmT7XTLFi9+sRKqL+WMWm6sA93TeGRuuJwegcJROpoFWiGu00YyB279txRKLbnVJMd743mqWvRZ49eKFlRWTYiBAEv1utejCVW0QeIeBnAQmUrwUEC896pku0zhXpuYM36EDgHxVex4NemT04ud3yF6I1PN9+vD4oUjxgowftec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0baslAmc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0baslAmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897D91F000E9;
	Wed,  5 Aug 2026 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931259;
	bh=BCOOkUMiZZ/efvmfiijsqNzcg4lH9lNiSg03P35SMJI=;
	h=Subject:To:Cc:From:Date;
	b=0baslAmc96UWb1g03sfg/VmZG/zVkNXej0RlccB8lcWGDsGhU87fnUQAB1RXjf9ax
	 BdMtlnMDTEsZtbxPrmjUNhDIBkYrDEEAsYARKZV7+QKPIb0boUKNXAw1ho7blFb/Gn
	 PBM1DFil3dbEW1Bhh7UyRd0Jcd2DX/tqmiREBAr0=
Subject: FAILED: patch "[PATCH] drm/bridge: display-connector: Fix I2C adapter resource leak" failed to apply to 6.1-stable tree
To: laurent.pinchart+renesas@ideasonboard.com,johan@kernel.org,luca.ceresoli@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:57:23 +0200
Message-ID: <2026080523-reputably-fantasize-8520@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6a39ca1286dd97ad02bb8e03bbb65ee05368d778
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080523-reputably-fantasize-8520@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a39ca1286dd97ad02bb8e03bbb65ee05368d778 Mon Sep 17 00:00:00 2001
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 17 Jul 2026 21:48:36 +0300
Subject: [PATCH] drm/bridge: display-connector: Fix I2C adapter resource leak

If the probe function returns an error after getting the I2C adapter for
DDC, the reference to the adapter is never released. Fix it by releasing
it in the bridge .destroy() handler.

There is no need to test the ddc pointer with !IS_ERR(), as
of_get_i2c_adapter_by_node() returns NULL on error.

Fixes: 2e2bf3a5584d ("drm/bridge: display-connector: add DP support")
Cc: stable@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20260717184836.2017386-1-laurent.pinchart+renesas@ideasonboard.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index 16c0631adeb1..6b128fabe3a9 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -40,6 +40,13 @@ static int display_connector_attach(struct drm_bridge *bridge,
 	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
 }
 
+static void display_connector_destroy(struct drm_bridge *bridge)
+{
+	struct display_connector *conn = to_display_connector(bridge);
+
+	i2c_put_adapter(conn->bridge.ddc);
+}
+
 static enum drm_connector_status display_connector_detect(struct drm_bridge *bridge)
 {
 	struct display_connector *conn = to_display_connector(bridge);
@@ -177,6 +184,7 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.attach = display_connector_attach,
+	.destroy = display_connector_destroy,
 	.detect = display_connector_bridge_detect,
 	.edid_read = display_connector_edid_read,
 	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
@@ -403,9 +411,6 @@ static void display_connector_remove(struct platform_device *pdev)
 		regulator_disable(conn->supply);
 
 	drm_bridge_remove(&conn->bridge);
-
-	if (!IS_ERR(conn->bridge.ddc))
-		i2c_put_adapter(conn->bridge.ddc);
 }
 
 static const struct of_device_id display_connector_match[] = {

