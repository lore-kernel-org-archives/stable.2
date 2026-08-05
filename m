Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58EB4457B2
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931266; cv=none; b=JpUgEuQa+m6P9URrccnTRvJt/ngUMbUg6nncW/glR/b6IN9oZA8UZ3FZc3ng1vWoTF5OUEWwfRPKE6/u6XSCVUuT3jMlrig8yIsDHI0mpXUMu3CI1baE+cMUV7sH2jthp8cktsOAzKIHOUnfRN5P2Q+9E+ENWyNyCnN3Bcf8ZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931266; c=relaxed/simple;
	bh=zkA0kB3+1fo+NRdKIccvrm6ecPgFK5lC+rfrCLON0qM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D3k73t3rQXvdgeT47BDtKAeTW/YsxzvgCdlnas3LvRzKt17Sev4+LRYV0/afT2yX6JH+qlINRhaj9eHyV1bmly+olMUBiQOcFfJZ40cIIvXDxiTzB6d2XGCmP821jGOhyd22W2Q86yEIW++ZNyBJ7McwA9HNCMVjLH1hUzf86hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EIOHykW6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EIOHykW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7C21F000E9;
	Wed,  5 Aug 2026 12:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931264;
	bh=IQF36ADVu8g6r4vYUMUc2DQi4P+Kw6AcnxVqA5544Zo=;
	h=Subject:To:Cc:From:Date;
	b=EIOHykW6J8cX/t1DQMLW6PjS/WZsBCA/2O+JZaQCN7CRQMwef5bdHyknWkOqihECu
	 j9aSfdIuNpzk02/Vki+mF2LaYeP9FrzIIdBjwlO0/EFbK3AnA4dpNiSX2rQ9+9S8DX
	 GVUZ1NO8HRT4+x/f3EI1X5F3ydAXoNtWve5Vt7E4=
Subject: FAILED: patch "[PATCH] drm/bridge: display-connector: Fix I2C adapter resource leak" failed to apply to 6.6-stable tree
To: laurent.pinchart+renesas@ideasonboard.com,johan@kernel.org,luca.ceresoli@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:57:23 +0200
Message-ID: <2026080523-kinship-open-fce1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6a39ca1286dd97ad02bb8e03bbb65ee05368d778
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080523-kinship-open-fce1@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

