Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B822E8B64;
	Sun, 23 Aug 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494572; cv=pass; b=TmkVowL5kNIiYRIA4kZptuX9WNFzB3JMKzTkapBTipG5/1ML3X7xHSIoXqtoZieP0qRq6Ew8cz3DspGM+fLVIkDPGlV0eFFrhaieMjpioyw+oqWyJ30uk2vIywScIq0bo+mWOkivHC2buGPWg8gpYo7FMJ8pGyAR0skRP1zPpwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494572; c=relaxed/simple;
	bh=FQ0kRK3qDi1g6QU2My9ljln7CMF7doAwW+GU7Ab45eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jApcFw8hkD1ljkTTy0LKH+p08xyyZpLV2xNu/ZAg5cuc0tkydr0qNojO6l3HSEu+ZPSHPkPyWGLjmtVPjPIlMrI3oQKAF8GlppwgzfzgrOFviQA9QfDNLA07zbOog6J4YKQXSUVEYNG9yb6/psXl04zL4OnIj2tsAEpw0tcY9ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=BWyxgd6J; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=1i4oTS0d; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="BWyxgd6J";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="1i4oTS0d"
ARC-Seal: i=1; a=rsa-sha256; t=1787494382; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a31vi44m/e9yvdsbtPUJGGE8NsVux40oceIHEvn4Xw/brbKTvzMllpZOIPaoAPmpNy
    HHDOGTNcZvlXfCbmnA/ORNvdwyh4Oc946up8Bsuqw6/8ynfzAmaCE6BwXCRSRXWkeWTG
    cYokZY+lA80xX4bDllJuriODRRLGVwLqGE7zvRIrv6Iz4rQAcDCETAuo8+ki0A0o2+24
    AoWMdeLkQ47eA+lfO7QB9/xMVnd/y2fE0nxNS0NaqutR5VYB12i5Gk+zfBOtcv8mizuY
    wm3gJkINv8W5AGnqeJGjZKAwIPh1cx1+P2zrOoCCVEFEDygqyi/gpwIZhFlgQ6Pm04rz
    N1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787494382;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=bx8qmMcJOQgMC5a8FWvNCXzF/v0fxTbnF9dvEYIpR/U=;
    b=F/dJieoJ1JKuT+48VuPOSyruN6Hn5UCAPO0Hjq3derjsU3edBdYqkIHp3SbuCwUZJg
    xid+Do1473DrjtAt4JjD/6d1XypuNqNSvEjxCo8kI7xwLNY3F6Ryt/iX8f3/a+6m5Ql0
    F51pvLcOGAKv4vXfYUZUoneIARs/Cq1A/Bm4WSIHUDNgLlW0poGVGDKb+C6NM68ut64s
    rgbPXXdgxirJF5rWx4GUkL2a/nvNdWeqUpr6iYi8G8N4wnYcSy4CfCjzEpb6tPWGeBlS
    xjBcr2PauxlIDusX/KgCCQupl1/PxVvD6Pp2lCLtpO4xBAsZ3IBlTjykDcCXsnMBUa7R
    SEHg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787494382;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=bx8qmMcJOQgMC5a8FWvNCXzF/v0fxTbnF9dvEYIpR/U=;
    b=BWyxgd6JQSBZTBJybevRjw6i/Nq/cgirgbX+fYIq1DX4uUQy7CvcU4wgkfGNYBtnQD
    HTlnQnnUd+p6QmsjN5lVm4vn4Zkk62ounxqQ9HLvnZxeC89X/bAoHGtPSljFdOvizRKG
    Cfcx1mketo9PAGt3NYNccN0UZyvBRDNqp6hqIP8tVB8mvuBCVXAgGa2f7YRCnvp+oWpm
    Si1svFOrnY5wCaj2r9Rytvi0MJbwUQ/kwsK0taL8uewDaQysoG8/Kqj0ALgwlT9SA+UU
    kWIon22SKI2InqgyG17SLPxLWiMm3w0hdNoO5axIYNN5eW080RUBa3iDRVzwK7Ng7qw5
    AQUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787494382;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=bx8qmMcJOQgMC5a8FWvNCXzF/v0fxTbnF9dvEYIpR/U=;
    b=1i4oTS0d4eFTC0iTO3lhw9H0huVVtMH1+OwXGm8+26ehOoX9tfu4fKJrNzgzVaKYVB
    arR7c8zS8oiEhj7rCcAw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ25oKnciHHK5OAyYE8yLD5e6WBWpu+g6xSmk="
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id Qfefb327NED2XDO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 23 Aug 2026 16:13:02 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Paul Cercueil <paul@crapouillou.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-mips@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	wbx@openadk.org,
	kernel@pyra-handheld.com,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/ingenic: fix bridge allocation
Date: Sun, 23 Aug 2026 16:12:59 +0200
Message-ID: <a3b64245250cd092776cf23cddffe18318b48995.1787494377.git.hns@goldelico.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Bridge allocation API has changed and ingenic/drm was broken
leading to

[   54.997593] dw-hdmi-ingenic 10180000.hdmi: Detected HDMI \X controller v1.31a with HDCP (DWC HDMI 3D TX PHY)
[   55.491338] dw-hdmi-ingenic 10180000.hdmi: registered DesignWare HDMI I2C bus driver
[   55.899132] [drm] DRM bridge corrupted or not allocated by devm_drm_bridge_alloc()
[   55.904136] ------------[ cut here ]------------
[   55.908753] WARNING: lib/refcount.c:25 at drm_bridge_get+0x58/0x6c [drm], CPU#0: kworker/u4:2/36
[   55.917538] refcount_t: addition on 0; use-after-free.
...
[   56.354928] [<c04898b8>] drm_bridge_attach+0x80/0x208 [drm]
...

Fixes: 9347f2fbb0183b0 ("drm/bridge: add warning for bridges using neither devm_drm_bridge_alloc() nor drm_bridge_add()")
Tested-by: Waldemar Brodkorb <wbx@openadk.org> (on CI20 with HDMI)
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Waldemar Brodkorb <wbx@openadk.org>
Cc: stable@vger.kernel.org
---

Notes:
    v3: fixed a malformed diff
    
    v2: removed ib->bridge->ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT as suggested by Sashiko-reviews
        https://sashiko.dev/#/patchset/400ba2fe0d4f76484e929d2efaa32f67a940163a.1787477392.git.hns@goldelico.com?part=1

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 42c86f195c66b3..8d7979a7859332 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -122,7 +122,7 @@ struct ingenic_drm {
 
 struct ingenic_drm_bridge {
 	struct drm_encoder encoder;
-	struct drm_bridge bridge, *next_bridge;
+	struct drm_bridge *bridge, *next_bridge;
 
 	struct drm_bus_cfg bus_cfg;
 };
@@ -802,7 +802,7 @@ static int ingenic_drm_bridge_attach(struct drm_bridge *bridge,
 	struct ingenic_drm_bridge *ib = to_ingenic_drm_bridge(encoder);
 
 	return drm_bridge_attach(encoder, ib->next_bridge,
-				 &ib->bridge, flags);
+				 bridge, flags);
 }
 
 static int ingenic_drm_bridge_atomic_check(struct drm_bridge *bridge,
@@ -1314,10 +1314,25 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 
 		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
 
-		ib->bridge.funcs = &ingenic_drm_bridge_funcs;
+		ib->bridge = devm_drm_bridge_alloc(priv->dev, struct drm_bridge,
+						   base, &ingenic_drm_bridge_funcs);
+		if (IS_ERR(ib->bridge)) {
+			ret = PTR_ERR(ib->bridge);
+			goto err_drvdata;
+		}
+
+		ib->bridge->of_node = priv->dev->of_node;
 		ib->next_bridge = bridge;
 
-		ret = drm_bridge_attach(encoder, &ib->bridge, NULL,
+		ib->bridge->interlace_allowed = true;
+
+		ret = devm_drm_bridge_add(priv->dev, ib->bridge);
+		if (ret) {
+			dev_err(dev, "Failed to register DRM bridge: %d\n", ret);
+			goto err_drvdata;
+		}
+
+		ret = drm_bridge_attach(encoder, ib->bridge, NULL,
 					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret) {
 			dev_err(dev, "Unable to attach bridge\n");
-- 
2.55.0

