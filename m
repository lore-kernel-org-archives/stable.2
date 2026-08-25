Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C915853B
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616900; cv=none; b=Cgbbsgu1knH6kzvDaX1x6FeC1MM6pekmoRSOInUNv1t9smzQu3484fVfchJV10br9HC0oKQlnV6IMIJHG3CWRQOOxI0HlWhoO7quD9fAc7XBpuV5G1S/Ist3nky+066wRkiF+se5dEq8p9UPT7mQpYE9vxIGgYciIaQhknISVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616900; c=relaxed/simple;
	bh=kNredZuAlzjuDwRpspH7wjFFwwIUPwrovOTOeiItUDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/01N9YEt2qnTBUZVC3austW6zDmpNoaeU4tpKHiMBlNMYUVMfsjDwPzUVb761EFdb++8bAWCoZLUOoSkYKf9JsIKXSmV0r4ovQREMRdU8ikINdGyvquVQ6zRTJkC/Xqx6ipodtbiBiLTVvRtXCZPk2h7JP7Gd3EDpZowv7wi4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh8iEzPQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh8iEzPQ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482d9ddf129so184963f8f.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 17:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787616897; x=1788221697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d/NYE+hsr/DHtPZiO0MS/H4/xrbfs8tes2shrGKnSKU=;
        b=Vh8iEzPQYeXV0ywZY1Mf57XTZgwyJ3uookqLBBqheco/54FnbUSEDiahCIsmIxNl1R
         BEEyM0tU8c6QFgTLn8mVZHoFNf8tnROf4G8c75COnjz/ifL5U1oPIX+njT69dDHvW3Gt
         W6iEYD8yRxiveJOp4iSVsPHuExOCneIOuHYIYKhcZ701yHhl38TiQD3/h3Iz3dXHPTjA
         4fpE4G/BMirMFwc0HCSdKBOoAZ69T9E7Pl8wZU9jMIz8cKRWnxpNk8JylLQg1n3mGeZN
         ivliYWM4A2/ADmfYvvPnUXIyeegj9OiVEuWNOSU7UuqdEPMTKW9mhd+TIrnQo7hkVCJ5
         C49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616897; x=1788221697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d/NYE+hsr/DHtPZiO0MS/H4/xrbfs8tes2shrGKnSKU=;
        b=CyiODBJGVbdpqEYyE0EEU9SR4nohqWMTLWBEYsf6Y+I4lCRXPCPZtWeKEvtjeubiU6
         k+5aCpx/Q2roa2NkwN6QDqtnOWl9do+KYiFJC5lRekKQKaCfRDtKlhs4Yot+372kPnzd
         vESm72hfIk1LnEv4L0xH9X6of7DH6vSMhfBonm02tNGDXtaY/ERD2N+NYBG8sciMU8yN
         xzsEDwjJMo3IySQXJxYqooK9KEQ/p3CfVxBf00cy9MvV1WFBOVza8r9ZWVG4aJDViRRV
         aR5buUkkWFKKJj3fnoKBsYrVntE/gOskP1K1Vo/MqcojNIpf2mv0fLR8z6a6qQ6qFPih
         5iMA==
X-Forwarded-Encrypted: i=1; AHgh+RpTHmqTMDEL4YBj5AqJzDZW3HXC3Ofy8/grPt5UwXhWKGS8lZ+FDHQJNWcMoXQ1vjGK9v9FrE8=@vger.kernel.org
X-Gm-Message-State: AFuF++mL1+0cHJWDVG4GiLT6YJyPcxhOaULUBQu81xuyN0uJJK5p2l6K
	/Ge11/PCjk797aM2m6MBghU68xZG7mkqbvl+eHyLSDitQW5yQ1lvxyeH
X-Gm-Gg: AR+sD101JxR5KT3Y/S0vDfTv1z2WTasIcpADkXwAUunyWkW0Sey7/EqaoPAq+kXnMQh
	m8v4ZhyPS5MeQsnm9Ne0DRQ6furl6Fqtyq6QZlTTwkOuMTq+H7p5rOCRMFEkGWMjsfJEiBfjZLf
	u3a+UttrYfWWyAAZlW+lOqxWc+gEnsyM+j9ie2b6Fm4658LtCIc/fs+y42mqzb1H+FJDcSjcXaP
	n7cdWp8bmUZGtlNLkIP7NSK10edH+hJPSqhAKBpO2jUKPV0c/xOrfidd/4z23UkFCREu3uElLD0
	506yH9C3y0evJGMt5pe0foA2u5lr9QU8xOYoKPRsNmnlJpW8ER+o5pfH5YJiCWT3OknOH+mN20J
	/dGSzAoZpc3QMg4IqkTKix5igl9uMIY/fhtg/fO9O9Uos/iGJ/XcPq4Jl7ln4WUdSErP1DC2Dh7
	x3l685cOSAqbpy8rLi8/ULL5lbZOHUvHrd/3Lj72bn5sP2X6fGA2euW3UxAvwlOnWfZKV1cmzKF
	xFJ3A==
X-Received: by 2002:a05:6000:2f88:b0:47f:6f6a:6a7f with SMTP id ffacd0b85a97d-482c817b196mr24504551f8f.8.1787616896742;
        Mon, 24 Aug 2026 17:14:56 -0700 (PDT)
Received: from fedora ([5.31.134.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:14:55 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mary Guillemard <mary@mary.zone>,
	nouveau@lists.freedesktop.org,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 03/10] drm/nouveau/disp: route GSP-RM display MMIO through nvkm_disp_func hooks
Date: Tue, 25 Aug 2026 04:14:01 +0400
Message-ID: <20260825001408.14219-4-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
References: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GSP-RM display code in rm/r535/disp.c borrows a few
register-programming routines from engine/disp (the head-timing
interrupt handler, vblank enables, armed head state and scanout position
readback, the AVI/VSI infoframe writers and the GCP AVMute write) and so
far picked them by name, which means it has to know which chip it runs
on the moment a generation changes any of them.

Give nvkm_disp_func a .gsp table that each chip fills with exactly those
hooks, add tu102_gsp_disp (TU1xx) and ga102_gsp_disp (GA10x onwards)
carrying the current functions, hand them to r535_disp_new() instead of
the full hardware tables, and make rm/r535/disp.c call through the
hooks. The head hooks are a whole nvkm_head_func, so r535_head goes away
and the chip's own table is handed to nvkm_head_new_(). r535_sor_hdmi
gets infoframe forwarders, r535_sor_hdmi_audio() calls the GCP hook, and
the interrupt handler comes from the table. The tables are per chip even
though the two currently coincide, so a generation that changes a hook
only touches its own file.
rm/r535/disp.c no longer contains chip-specific register code, and a new
display generation only has to provide its own table. No functional
change.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/ga102.c  | 13 +++++++-
 .../gpu/drm/nouveau/nvkm/engine/disp/head.h   |  1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/priv.h   | 14 +++++++++
 .../gpu/drm/nouveau/nvkm/engine/disp/tu102.c  | 21 ++++++++++++-
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 31 +++++++++++--------
 5 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c
index ab0a85c92430..820834b5ee9b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c
@@ -144,12 +144,23 @@ ga102_disp = {
 	},
 };
 
+static const struct nvkm_disp_func
+ga102_gsp_disp = {
+	.uevent = &gv100_disp_chan_uevent,
+	.ramht_size = 0x2000,
+	.gsp.intr = tu102_disp_intr,
+	.gsp.head = &tu102_gsp_head,
+	.gsp.hdmi_gcp = tu102_sor_hdmi_gcp,
+	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
+	.gsp.hdmi_infoframe_vsi = gv100_sor_hdmi_infoframe_vsi,
+};
+
 int
 ga102_disp_new(struct nvkm_device *device, enum nvkm_subdev_type type, int inst,
 	       struct nvkm_disp **pdisp)
 {
 	if (nvkm_gsp_rm(device->gsp))
-		return r535_disp_new(&ga102_disp, device, type, inst, pdisp);
+		return r535_disp_new(&ga102_gsp_disp, device, type, inst, pdisp);
 
 	return nvkm_disp_new_(&ga102_disp, device, type, inst, pdisp);
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
index 986043e87554..784521c2aca1 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
@@ -58,6 +58,7 @@ void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline);
 
 void tu102_head_vblank_get(struct nvkm_head *);
 void tu102_head_vblank_put(struct nvkm_head *);
+extern const struct nvkm_head_func tu102_gsp_head;
 
 #define HEAD_MSG(h,l,f,a...) do {                                              \
 	struct nvkm_head *_h = (h);                                            \
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
index 722ec340e12a..a9dbda67a7d4 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
@@ -5,6 +5,8 @@
 #include <engine/disp.h>
 #include <core/enum.h>
 struct nvkm_head;
+struct nvkm_head_func;
+struct nvkm_ior;
 struct nvkm_outp;
 struct dcb_output;
 
@@ -34,6 +36,18 @@ struct nvkm_disp_func {
 		int (*new)(struct nvkm_disp *, int id);
 	} wndw, head, dac, sor, pior;
 
+	/* Register programming that the GSP-RM display path (rm/r535) needs from
+	 * the chip, everything else on that path goes through RM. The hooks are
+	 * called unconditionally and the head table is handed to nvkm_head_new_().
+	 */
+	struct {
+		irqreturn_t (*intr)(struct nvkm_inth *);
+		const struct nvkm_head_func *head;
+		void (*hdmi_gcp)(struct nvkm_ior *, int head, bool enable);
+		void (*hdmi_infoframe_avi)(struct nvkm_ior *, int head, void *data, u32 size);
+		void (*hdmi_infoframe_vsi)(struct nvkm_ior *, int head, void *data, u32 size);
+	} gsp;
+
 	u16 ramht_size;
 
 	struct nvkm_sclass root;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
index 6cfd52c9056f..948b1d2f954c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
@@ -140,6 +140,14 @@ tu102_head_vblank_get(struct nvkm_head *head)
 	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
 }
 
+const struct nvkm_head_func
+tu102_gsp_head = {
+	.state = gv100_head_state,
+	.rgpos = gv100_head_rgpos,
+	.vblank_get = tu102_head_vblank_get,
+	.vblank_put = tu102_head_vblank_put,
+};
+
 static void
 tu102_disp_intr_head_timing(struct nvkm_disp *disp, int head)
 {
@@ -295,12 +303,23 @@ tu102_disp = {
 	},
 };
 
+static const struct nvkm_disp_func
+tu102_gsp_disp = {
+	.uevent = &gv100_disp_chan_uevent,
+	.ramht_size = 0x2000,
+	.gsp.intr = tu102_disp_intr,
+	.gsp.head = &tu102_gsp_head,
+	.gsp.hdmi_gcp = tu102_sor_hdmi_gcp,
+	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
+	.gsp.hdmi_infoframe_vsi = gv100_sor_hdmi_infoframe_vsi,
+};
+
 int
 tu102_disp_new(struct nvkm_device *device, enum nvkm_subdev_type type, int inst,
 	       struct nvkm_disp **pdisp)
 {
 	if (nvkm_gsp_rm(device->gsp))
-		return r535_disp_new(&tu102_disp, device, type, inst, pdisp);
+		return r535_disp_new(&tu102_gsp_disp, device, type, inst, pdisp);
 
 	return nvkm_disp_new_(&tu102_disp, device, type, inst, pdisp);
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index cd4451e62512..bf97edcdfc95 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -547,7 +547,19 @@ r535_sor_hdmi_audio(struct nvkm_ior *sor, int head, bool enable)
 {
 	r535_sor_hdmi_ctrl_audio(sor->asy.outp, enable);
 	r535_sor_hdmi_ctrl_audio_mute(sor->asy.outp, !enable);
-	tu102_sor_hdmi_gcp(sor, head, enable);
+	sor->disp->func->gsp.hdmi_gcp(sor, head, enable);
+}
+
+static void
+r535_sor_hdmi_infoframe_avi(struct nvkm_ior *sor, int head, void *data, u32 size)
+{
+	sor->disp->func->gsp.hdmi_infoframe_avi(sor, head, data, size);
+}
+
+static void
+r535_sor_hdmi_infoframe_vsi(struct nvkm_ior *sor, int head, void *data, u32 size)
+{
+	sor->disp->func->gsp.hdmi_infoframe_vsi(sor, head, data, size);
 }
 
 static void
@@ -575,8 +587,8 @@ r535_sor_hdmi = {
 	.ctrl = r535_sor_hdmi_ctrl,
 	.scdc = r535_sor_hdmi_scdc,
 	/*TODO: SF_USER -> KMS. */
-	.infoframe_avi = gv100_sor_hdmi_infoframe_avi,
-	.infoframe_vsi = gv100_sor_hdmi_infoframe_vsi,
+	.infoframe_avi = r535_sor_hdmi_infoframe_avi,
+	.infoframe_vsi = r535_sor_hdmi_infoframe_vsi,
 	.audio = r535_sor_hdmi_audio,
 };
 
@@ -601,14 +613,6 @@ r535_sor_cnt(struct nvkm_disp *disp, unsigned long *pmask)
 	return 4;
 }
 
-static const struct nvkm_head_func
-r535_head = {
-	.state = gv100_head_state,
-	.rgpos = gv100_head_rgpos,
-	.vblank_get = tu102_head_vblank_get,
-	.vblank_put = tu102_head_vblank_put,
-};
-
 static struct nvkm_conn *
 r535_conn_new(struct nvkm_disp *disp, u32 id)
 {
@@ -1606,7 +1610,7 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 		nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
 
 		for_each_set_bit(i, &disp->head.mask, disp->head.nr) {
-			ret = nvkm_head_new_(&r535_head, disp, i);
+			ret = nvkm_head_new_(disp->func->gsp.head, disp, i);
 			if (ret)
 				return ret;
 		}
@@ -1655,7 +1659,7 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 		return ret;
 
 	ret = nvkm_inth_add(&device->vfn->intr, ret, NVKM_INTR_PRIO_NORMAL, &disp->engine.subdev,
-			    tu102_disp_intr, &disp->engine.subdev.inth);
+			    disp->func->gsp.intr, &disp->engine.subdev.inth);
 	if (ret)
 		return ret;
 
@@ -1688,6 +1692,7 @@ r535_disp_new(const struct nvkm_disp_func *hw, struct nvkm_device *device,
 	rm->uevent = hw->uevent;
 	rm->sor.cnt = r535_sor_cnt;
 	rm->sor.new = r535_sor_new;
+	rm->gsp = hw->gsp;
 	rm->ramht_size = hw->ramht_size;
 
 	rm->root.oclass = gpu->disp.class.root;
-- 
2.55.0

