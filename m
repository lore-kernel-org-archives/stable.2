Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4516F2494D8;
	Sun, 23 Aug 2026 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787491194; cv=pass; b=tbj2AxbduaW2z/jwW1QngVCB76dBifFUL0zZSLt2ImmCYyaaiQ/6+oWhp0NZhX++1B8VoCEPgcODvzzj8koKr7iKC9CUzRM1LYpP7r8o/WiYP7ybKgTDDqapGsjfhtO7K3Td9vIeGxn+ZSPQtLYgahCFZCVOcNjcKkv92E6jrUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787491194; c=relaxed/simple;
	bh=F77TIlrH5jg5omDfZ6mV7ngxrkDjIqT9xs0/aDx+oG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jr86UfB/G1nkCcY9zti88i0gOKBRIa4U4QWAYnoy0pEZfA/5AzJa72hWMdAIokOMJFt/E5+0guEPiK/2tPgjPjvHvroBJ3lrKVmce9rL44m+l5SzMuyxXg0Vpo1NC6MzSYliFRmoH4sNz/0PRGCL3jg48mMoWMaTK8H1xeZk28I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=oOM1N+cf; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=3tb96ryA; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="oOM1N+cf";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="3tb96ryA"
ARC-Seal: i=1; a=rsa-sha256; t=1787491156; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hvlkDMLjA/M0zPOn32U043+j1tFE14nKERob1IkX2lE78gVER5EtImXC4xeRQrAriE
    f7OhycjoG9Dj3E8gUlM3IwzGbQhIQNcYdRrKtg7RSO47yqqTUumX4N4tPIQnlp+pq22+
    K8m7ULvflbttb6SLejxIdXkL/PBm1p9iAmb9294+42f4dRY75Nv1CL1ik1oH8oWBw0vX
    7M9393ICFiwfJlLCKRKbuRAIfGnanq2LyXNb8tIzfHVb7Pt8zoZhLPSCL1QHbccP9pVo
    L5j0asQ0PAsmXiLZGqNH+I8ekUBya78bP0G41vm3o+fYv7h8fSZNCUmoWfA/VCLYXHVT
    zMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787491156;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=cZZjI4eLpLnix7X9ZVP8dmFoM/H1s5Z0L0LHnAMxqQk=;
    b=gFbFYns5YhpMeig95/vAADWwQnq2OKJ79VMumsoDGmDHyIP9TmN4yJIEqkOqqXGAIi
    Aij3i1f6fkgVVPsB+kzX0pYKeHsDjyH5MA3Jcfft+C63SNZry8gMnThcuXXDoAr/otBr
    7GEjZhI6lxOo2nkvUKJ2miqCgayCHe24zlnbkGc5Ic7v0aSpiqn7Eq4hHPomIAbvLxnW
    qoFGhG8FVF6KHYo0IJawQk4NwXCGXS3hVObwKVkJYm8m0hz9LW5WgAmAujrOhPiPDHAI
    4C+ejNFT1yZey1mTkhjym4tdylED2dlD08s2QdLhanXDHaaQp2bSyMNs2NaEYuurfHWo
    Hs4w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787491156;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=cZZjI4eLpLnix7X9ZVP8dmFoM/H1s5Z0L0LHnAMxqQk=;
    b=oOM1N+cfKuIoblEiiaHQs26eSMYiawgIE9yKLeIo+svehR53E7qZaaybtyeEhShuX3
    TbtT6fgiwrr4MWcBDdgvZDekncdq0DqlQ/xFP4AfbZbLS/7ZEfsUVxkt/S81riWW8Wxb
    utF3ND4R8AietOgj9duTtACA74bxR3GSmivnU0GCOzXoOZ0dUDhEgPz8wY7mPvnooDS4
    BlSzOmMOf+i5TBflmeQiXytaGxVAfJBV956uLJUa8GlvTzsqn3eSdDTx539q7SjL9NE8
    DX8AdQVLXe4ii2hxj5bzvJzDjwzw/FQWsqJ2S6ojuCbJxs8caHl+39ZMCYRN+o9a2hiI
    FSYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787491156;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=cZZjI4eLpLnix7X9ZVP8dmFoM/H1s5Z0L0LHnAMxqQk=;
    b=3tb96ryALPZJyXYTlbHJHzY3wOMdrgX3suIzTV6vhB6F4wqxGW4NF5b/0kBUmpKWb7
    VLWGpCdLiTRHc7SDDsDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ25oKnciHHK5OAyYE8yLD5e6WBWpu+g6xSmk="
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id Qfefb327NDJEX8V
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 23 Aug 2026 15:19:14 +0200 (CEST)
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
Subject: [PATCH v2] drm/ingenic: fix bridge allocation
Date: Sun, 23 Aug 2026 15:19:06 +0200
Message-ID: <5db9a2ad762f1515431fff714fc7d6d93363ccb2.1787491144.git.hns@goldelico.com>
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
    v2: removed ib->bridge->ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT as suggested by Sashiko-reviews
        https://sashiko.dev/#/patchset/400ba2fe0d4f76484e929d2efaa32f67a940163a.1787477392.git.hns@goldelico.com?part=1

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 42c86f195c66b3..fb78bdef8ec9e8 100644
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
@@ -1314,10 +1314,26 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 
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
 
 		ret = drm_bridge_attach(encoder, &ib->bridge, NULL,
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

