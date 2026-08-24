Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335218DB01;
	Mon, 24 Aug 2026 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604263; cv=pass; b=mbgRbsqa42dqCGITUN/wRrZRT7EaiRMz8KATweBhnHrXFM9xIr1mV83ZkVnm7Zzf/PC0NmyQ/N+VbMpHa38A+Zbp1Ei0K4irN5zxQCc/u/WWcKnWt2lJbXjOni+VoifMhqX6cui6l4WQUs4GL/xvX/re1YA5k9RjjANhU7Aq9JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604263; c=relaxed/simple;
	bh=2ZBEgTiwS4+ust8Haib6K0glNq7q0TrHt5DDCyKYnWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnGZ76zMOZ3KKFluzBvAGXXxDTRWhArXShY+/P36G8KSqcNosAXWfTRJMmiCIuaK8Woxi/VpkXguIOGWifz9URD1gg1t9ff1H7os2AZm59F9b3Sv7LvK7ASse8FUFJ4z2CGfjqpWiJ3pzFHlMAaxGQx6ah4HEMHiJChM+lwuPuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=jk406l48; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=j0OjE5CO; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="jk406l48";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="j0OjE5CO"
ARC-Seal: i=1; a=rsa-sha256; t=1787604228; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=s8qJyTJqMbLeN3cNggxgodnkmGIdc1MV7BoOV+8DA8W7pQZqxAXmWRROi90rn/Rr/e
    vJp1mYo3e7kT4P4c1T59arKO74J/M6ng4WBySxanR0nOLOjfbtOhhw6rqt0wF55yVCs+
    DITGUOU4OIYeIblckcGLOLd43hdj7ah9FujYWbPRbBg7GKLopgDWDISNPDqdLltmL9F/
    uO3S/5IGRW5xTT9/iVi1o7+nZPVTHAozeAv+XdMWCOP2a2IjV6CzbZjPl2FBXFhsl22G
    0eSjwRcrP9aSdFaBG3NnHBkaYQIX3boJXVMkPJQrlH/7Z4qe3x7h1qbS20ifP0ZCjRsy
    /OSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787604228;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yS+NX2fkPUZetLVqc3eSo3aOe1P1fcv4VjpZQ+6pKBM=;
    b=DdhrLpPKoeKKZGZcK+77kNRUWaxSl51QF/c4VcY4PpGp1b84b2TlUXVTbsO3hSg558
    9xeIbpL297pCWMMtKn5Ptp4q224xV+Teq/LMlv3hXEGc0LNXrKXifEfr51Wl1s7pICer
    qOGtvEDdbga2fUnUObokr/ZuXjPhhEdA/GirJBYaS4uevB+eRrWHxTqrstKm0jTSFX3R
    4/gi3ANkdYWVwIErzUWflNRi7QFfqzi+ezejA1nJrX7FEvhxmLERI37o7oo80vDigHzT
    fenbI0pBqm2hbfKAxGWa+egtTJKI6aI787HGOq6v2vCWRwt7ngIQrDGCKjen22H8CikW
    DINw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787604228;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yS+NX2fkPUZetLVqc3eSo3aOe1P1fcv4VjpZQ+6pKBM=;
    b=jk406l48CyXSpZjVrllc/8ZRmLC5ix0/7DqcU62XJT1uTxWJ8ZgRSFUlT1hn933SX7
    r3D2Eh7VbJALUsIXf3HhI/nsRyULtGc6GPUvRrXoTR66DM0PqkVNmeV9Dbflw1qSqjtj
    xKvMe0K+84B/vybEw9jyPEEnAHcpSufD1T4yadalbloUUjBAkMQELTDs3vdd4gyHKqHO
    5nQ+uKubi/jjmzcQ6HdpadjR3nPsjEWNoGWCItFFIWv9r62MCLlKKsbocUpPPD4EC4xm
    sFtJrAH2jRDyXAXPcESzxX65wK8CqWZO+5+XpURDHW3mqnIr1OZAVfsJsrfY9cR3Z65M
    nHgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787604228;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yS+NX2fkPUZetLVqc3eSo3aOe1P1fcv4VjpZQ+6pKBM=;
    b=j0OjE5COH9nNie4mN9LP2GLdZA60llJ5nAx9JKdQDKjoxo4VJhD9I/vXoYb4iwx7xT
    qTv3TkFqj3DSH2JxogAw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQipoOy8iN9EQCaJvpc3APUCy9LxWOnfZGxS9c"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id Qfefb327OKhmcFM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 24 Aug 2026 22:43:48 +0200 (CEST)
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
Subject: [PATCH v6] drm/ingenic: fix bridge allocation
Date: Mon, 24 Aug 2026 22:43:45 +0200
Message-ID: <4f30341735d77c77a9a4952abd91879007bc00fd.1787604223.git.hns@goldelico.com>
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
    v6: Sashiko found another weakness in the v5 object lifecycle repair attempt...
        https://sashiko.dev/#/patchset/f77ed4e1547e452668a6549e3966471a6b638a6b.1787593585.git.hns@goldelico.com?part=1
    
    v5: fixed a potential issue with directly allocating struct drm_bridge and
        depending on its internal structure. Solve by allocating a stable
        driver-specific container struct ingenic_drm_bridge_alloc that embeds
        a struct drm_bridge.
        Also revisit and adjust object lifecycle by doing drm_bridge_add() before
        drm_bridge_attach().
        Suggested by Sashiko-reviews:
        https://sashiko.dev/#/patchset/1630a544a26fac0b87187885374ebe59fc92df3b.1787575203.git.hns@goldelico.com?part=1
    
    v4: remove setting interlaced mode (would be new feature and not a fix)
        as suggested by paul@crapouillou.net
    
    v3: fixed a malformed diff in v2
    
    v2: removed ib->bridge->ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT
        as suggested by Sashiko-reviews:
        https://sashiko.dev/#/patchset/400ba2fe0d4f76484e929d2efaa32f67a940163a.1787477392.git.hns@goldelico.com?part=1

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 30 ++++++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 42c86f195c66b3..b3dc28f78f3807 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -122,11 +122,15 @@ struct ingenic_drm {
 
 struct ingenic_drm_bridge {
 	struct drm_encoder encoder;
-	struct drm_bridge bridge, *next_bridge;
+	struct drm_bridge *bridge, *next_bridge;
 
 	struct drm_bus_cfg bus_cfg;
 };
 
+struct ingenic_drm_bridge_alloc {
+	struct drm_bridge bridge;
+};
+
 static inline struct ingenic_drm_bridge *
 to_ingenic_drm_bridge(struct drm_encoder *encoder)
 {
@@ -802,7 +806,7 @@ static int ingenic_drm_bridge_attach(struct drm_bridge *bridge,
 	struct ingenic_drm_bridge *ib = to_ingenic_drm_bridge(encoder);
 
 	return drm_bridge_attach(encoder, ib->next_bridge,
-				 &ib->bridge, flags);
+				 bridge, flags);
 }
 
 static int ingenic_drm_bridge_atomic_check(struct drm_bridge *bridge,
@@ -1107,6 +1111,7 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	struct clk *parent_clk;
 	struct drm_plane *primary;
 	struct drm_bridge *bridge;
+	struct ingenic_drm_bridge_alloc *bridge_alloc;
 	struct drm_panel *panel;
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
@@ -1314,10 +1319,27 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 
 		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
 
-		ib->bridge.funcs = &ingenic_drm_bridge_funcs;
+		bridge_alloc = devm_drm_bridge_alloc(priv->dev,
+						     struct ingenic_drm_bridge_alloc,
+						     bridge,
+						     &ingenic_drm_bridge_funcs);
+		if (IS_ERR(bridge_alloc)) {
+			ret = PTR_ERR(bridge_alloc);
+			goto err_drvdata;
+		}
+
+		ib->bridge = &bridge_alloc->bridge;
+		ib->bridge->of_node = priv->dev->of_node;
+
 		ib->next_bridge = bridge;
 
-		ret = drm_bridge_attach(encoder, &ib->bridge, NULL,
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

