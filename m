Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790C37E5F6;
	Mon, 24 Aug 2026 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593618; cv=pass; b=N0dc/ibLUkAwPOJHkDTF97fZvWbHOQe8vZi77WGcRzT/zO4S7QKl2rFe4nxJdK2zDShoTiyd/FmpYnWHVeGSj9inOJPcmg+NrZRKYlEPC6GpaPbDRdvswMJyb2X6Qct5AwcmmuXBj2tRx1PmI5drHAE7PnKiWw8VKkvMFr2HWSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593618; c=relaxed/simple;
	bh=8nZxBamknf/OFOioSsACX4ODxiHurXZyiTxkHcvf674=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iX1WBEC61PV/Wo0EMhkbFTU6SlvxyVdtTy453gXQMY+N4oJYdxqMFFz0J1uivFB0HkfUJS0dmSf8Bqv+c9xT9w9We+vAkFRp5NoefKRGkiy1CZZIZx3NbrOkW4vYso5SpjUFS2IualYDniTcbxRyXrlVjLJYGTTU2MN5jaIOPRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=AY4ZHYWh; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=+s0V0IZ7; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="AY4ZHYWh";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="+s0V0IZ7"
ARC-Seal: i=1; a=rsa-sha256; t=1787593590; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hksTicEBzUtDdUH4l4tvdtyyLHT4Bg0gCPsCXND5tyNU44WOPeqMeLGHZzo4txXBdI
    73NwOpRuWIHZuXmRVST7GSV+5pGCwPbqwmbImiRcRTp+KtlUEm8ygm7TaEU1MFpQugtG
    WdMPaNx2YGPbk8m5620l+KlXAiBbEZOqIP7AV8VU2QGYW06sjWkN8pjjnwjyTqu4nbKa
    jp26YPOHpsxPXZDM9dfwL/HbJyLT2CwirH5ZJaTixjCK6nMvPcDZVz81m+twn1Bg9XI2
    dMekEj1K8Kh0texQlXe9g1KKIEBs7Gk8Ts9MpatBHaqEN1sIRRwK6vVzqJtRy4uzafnD
    RYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787593590;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=lmIPS2M+ohVUGOXc3DV05sJ1OsGWycb6IquOKMK8x6U=;
    b=VeYlbgp4WmRBARgZEV9+DN+CMLqJvaSZDh+Zr5WONtfIM7ivWTMomBhPkcd1JfCOZv
    VxLXkfUyX/o+tYpTaxBmXMJ2ReD+LtjZNwg7jb3Z3VkiUHnsku8uHK6E6r7ctS8lB+L+
    Ob7LfU4dUtFcBbkavhwd0m0PZR8KpUZzgmhIW7H9N39ZGMdZlu4lcUZQU+1Dp9GcaiGn
    A9GNK0PPjVvWl8XdwuL3fvA/1Qwm7QHhNRydhV5RQCSAS9ZUPKtaR20twrriP5FOU0Np
    5IR2LtdFKfNoW1+K8i3fAZKux8hbDS5Y2X4IChtcrtq7goAPXZh5k669jsQ2BJfWaVLu
    iS/A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787593590;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=lmIPS2M+ohVUGOXc3DV05sJ1OsGWycb6IquOKMK8x6U=;
    b=AY4ZHYWhJF+tjwlERGlDHYaSQxWmeP+WS/j7vNfp+/9qgLFGpmQGkjSejVj9AMGJnf
    BuroFYVYiCUXHcC7SIsuboTTUP5I4w2ML6tr3y4CWSZekV2vwJhmj0R8ogGG6qLQ54AC
    h+rn32Ore5k0jcEBksUNaSY6jog0O5JNhEp+WCVtI+qaAmiq82ukLdokZtUmgiZvTBdU
    AWHbu3QloB1QiD2P1QGzY/tm3/tojvQYD4VM8Wv7DcqmvWJ8PqmLLDQuhnckYlyzsS4f
    cdCjJT6rJO+P3r+nwNvxNJSi7mXG4ah1Czy+j7DW5H9dxPX57IPZZvIdKh9chwAyg3O+
    MW7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787593590;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=lmIPS2M+ohVUGOXc3DV05sJ1OsGWycb6IquOKMK8x6U=;
    b=+s0V0IZ7xxpljPTbIy39vXPODqmpkVz9mxdovQDRyPFU5tD2zliJjp8w4Q7172xoF2
    AqxiQCIwTLj46bpS+SCg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQipoOy8iN9EQCaJvpc3APUCy9LxWOnfZGxS9c"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id Qfefb327OHkTbu0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 24 Aug 2026 19:46:29 +0200 (CEST)
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
Subject: [PATCH v5] drm/ingenic: fix bridge allocation
Date: Mon, 24 Aug 2026 19:46:26 +0200
Message-ID: <f77ed4e1547e452668a6549e3966471a6b638a6b.1787593585.git.hns@goldelico.com>
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

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 27 +++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 42c86f195c66b3..1eeee9d29b6abb 100644
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
@@ -1314,13 +1319,27 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 
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
+		drm_bridge_add(ib->bridge);
+
+		ret = drm_bridge_attach(encoder, ib->bridge, NULL,
 					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret) {
 			dev_err(dev, "Unable to attach bridge\n");
+			drm_bridge_remove(ib->bridge);
 			goto err_drvdata;
 		}
 
-- 
2.55.0

