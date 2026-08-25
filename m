Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737C202C48
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616939; cv=none; b=NSbYakZOWbh9YEnWJF9AwtoVJWyqXOks+GVqRWUot6Xb9JVvHGV7p5bkMHcSPOvgCkwa4kaStOEghw5pYlgkMRPMtvaMb5pECS8QNRil21Ux/XJ3uXcGdhTPqR0EffnoA9YcseV7f3wdZuFJ/Fotj3UU3uYl+b1HXUkWEFyiG2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616939; c=relaxed/simple;
	bh=UJ5NzQN/avXyDqMtAQsiOW+ECU1cubzClqTXY4dYees=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5Zq8kxsmhcnWyewObkdSEOGlem4/OhTdHPTRDhPSqxiRt2CBk9xkrimkyricALYPNNBfMLTXRE8tML1Hy5ChX/CiG3C+UCTdAZBv2c/DLG07bZ8p8KsnyJe4HA+BF+NWd1WuQQo382VDSnYqcPfz1fBVi4n81CTKGMe+Cuyu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qO8rQOjx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qO8rQOjx"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3514112f8f.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 17:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787616936; x=1788221736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QlXM8+B98Oj3ld9axn0pjcyRcs37xmSxRCU/3qFuJS0=;
        b=qO8rQOjx0zfMxoL2oCnP9waKWRIKvFDLN54nhTUc4wjmFMyyK2jI4BsIgnu8qHYaO6
         /pCQfKtEdacneJBUjojPtmg6VRLocBKPcYba++Z51LGIl2SrjBNnK6pIek2Ig6Xi6V5O
         An72E+2qXo9Dom5lLATDN4N9XZ6TGFcOt3q80xrCgptFAl/52ew+cG/kb4o7cFmWcCOo
         HNHspa+2nZ+NdRfDVZ1K59rwe7JugQap7ikPTqiYojDMgFjq0nF29VhcvHuHeb9cQGNi
         yynDIWkUEV8i9Hu8dNy2whzyJihJgrAqKMMWCdaPmv6h4jnR02XeVtWJcjlYpOrp+sE5
         K0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616936; x=1788221736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QlXM8+B98Oj3ld9axn0pjcyRcs37xmSxRCU/3qFuJS0=;
        b=nzeSbZZKUxvvnls2jNdaWkdYmEWO23rp7kmJO0mkvwiqBOb3CeA4EPVpp5jeVkxs3v
         KYQPZjq+KWh0fJ4HYggzcDdLvxxiT/3jFSUg6BLVFczLQW+WEQ0cCnGqiMWBmkbR49hk
         L0/MGp4U4ck00aQehgIh430R4aj7g/Gg557lVt6UFmcIdPloj6x+OgdeIYSs+2AnfAgO
         nxH+HJ18sbiemeaZRdtRycp/r17vOW8kUFDZBiQgzwrGrCpiib9/zmFpWszzDdnR9SPa
         PnBLLpJajTOq8mMOBw77kpEzwMCoCgRPrsRUjKR0djJk5QvoLivIbKxWDsiGlIwC8Tr8
         Xl5g==
X-Forwarded-Encrypted: i=1; AHgh+Rrw3fpwAKHSa0V8jsijJlsGeelQ6j+yEojuvANa0FNSQCViKOQ2vVmy4hmCKPJSa8/5/Hyr3s8=@vger.kernel.org
X-Gm-Message-State: AFuF++kcsc1T/Q2J39NVQlAwDl53ZZ8lAytLrBWb9ZcmzwgJ11I+qe5s
	DUnEVU+PKp9EXYfsEMCWL9q/MODbApVBLqFQGGiCRemjInkJAqqGcyk2
X-Gm-Gg: AR+sD113S48p80+BOnqmX2xr39sw6BIyjGNpoE3bhRVCcd9wJfvbIv1kOaIR+SmezT4
	rueh9WLeAu07/Yg8RcrI0w1eUulU9v5fqx4ffATsSD2AWI8M8dVVu7HFGxD6OhhTDjPwlvTowOB
	H8EOudWmFnz004GXFKrhNuJjfe7qch4uaApps4k5OTuEetQwiZToVyxw0l1vAHSFGMKyiNgNHCn
	alpYvOBI/GkNpcf+V0an5mR5tRGArYKmBXKoboEZxxc7IEbzvq64N6XBN5jWZf6J01BVERZrn8u
	3AZJleNWfhE1G4JQlVbCzl30NXquzh6AHhiZZ7nM0lbXKB/AxdHxJzlOQHgpU0LM9peQ95VR905
	rAqr2rYiOamHLh/Esx/vsVkhQKODUlL0MMF2PVUPTW9Ca/4hsAn32U1syaxQNZQYG3TVjct8S94
	NWu1VvIkwqrMHAZGi4bV0noG5oWXsOFFS7heBrT6U7VFSCQH0r20ZKlogJglpPb58ANed7083Vx
	svvvgg=
X-Received: by 2002:a05:6000:2dc6:b0:47f:9266:9bde with SMTP id ffacd0b85a97d-482d9ed6576mr2374878f8f.4.1787616936020;
        Mon, 24 Aug 2026 17:15:36 -0700 (PDT)
Received: from fedora ([5.31.134.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:15:34 -0700 (PDT)
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
Subject: [PATCH v3 08/10] drm/nouveau/gsp: fix vblank interrupts on GB20x
Date: Tue, 25 Aug 2026 04:14:06 +0400
Message-ID: <20260825001408.14219-9-mohamedahmedegypt2001@gmail.com>
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

The GSP path programs per-head timing (vblank) interrupts the same way on
every generation. NVD5.0 (GB20x) reworked the FE interrupt frontend
around four message-based kernel vectors (high latency, low latency, PMU,
and GSP) and moved RM head-timing interrupts to the dedicated low-latency
vector:

 - The enable is NV_PDISP_FE_RM_INTR_EN1_HEAD_TIMING, 0x611ef0 +
   head*4 (570.144 kernel_head_0501.c, renamed kernel_head_0502.c from
   575.51.02 on, and v05_01 dev_disp.h).

 - The vector is reported as a separate interrupt table entry,
   MC_ENGINE_IDX_DISP_LOW (intr_gb202.c, intrCacheDispIntrVectors).

 - The vector must be re-armed through NV_PDISP_FE_INTR_RETRIGGER(1)
   at 0x611f34 after servicing (kdispServiceInterrupt ->
   kdispIntrRetrigger_v05_01).

The event latch (0x611800), per-head status (0x611c00), and dispatch
summary (0x611ec0) the interrupt handler uses are unchanged on GB20x
(kheadReadPendingVblank_v03_00 and kheadResetPendingLastData_v03_00
remain for DISPv0502+).

On GB20x the old code enables head timing onto the legacy vector, leaves
its handler there, and never re-arms the message-based vectors. Page
flips still complete (nv50 sends those events from the commit path), so
the desktop looks fine while DRM vblank waits and vblank sequence queries
are affected.

Supply GB20x vblank enables and an interrupt handler that re-arms the
vector after servicing through gb202_gsp_disp, translate the low-latency
interrupt table entry as a second NVKM_ENGINE_DISP instance, and add a
gsp.intr_low_latency flag so r535_disp_oneinit() attaches the handler to
that instance. GB20x was the last cross-file user of the TU1xx vblank
enables, so make those static and drop their head.h prototypes.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 42 +++++++++++++++++--
 .../gpu/drm/nouveau/nvkm/engine/disp/head.h   |  2 -
 .../gpu/drm/nouveau/nvkm/engine/disp/priv.h   |  2 +
 .../gpu/drm/nouveau/nvkm/engine/disp/tu102.c  |  4 +-
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 10 ++++-
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c |  9 ++++
 6 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
index 765c42039a47..d0360610f9fa 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
@@ -124,12 +124,46 @@ gb202_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
 	}
 }
 
+/* NVD5.0 (GB20x and later) moved the RM head-timing interrupt enable to
+ * the low-latency vector's EN1 block. The event latch is unchanged.
+ */
+static void
+gb202_head_vblank_put(struct nvkm_head *head)
+{
+	struct nvkm_device *device = head->disp->engine.subdev.device;
+
+	nvkm_mask(device, 0x611ef0 + (head->id * 4), 0x00000002, 0x00000000);
+}
+
+static void
+gb202_head_vblank_get(struct nvkm_head *head)
+{
+	struct nvkm_device *device = head->disp->engine.subdev.device;
+
+	nvkm_wr32(device, 0x611800 + (head->id * 4), 0x00000002);
+	nvkm_mask(device, 0x611ef0 + (head->id * 4), 0x00000002, 0x00000002);
+}
+
+static irqreturn_t
+gb202_disp_intr(struct nvkm_inth *inth)
+{
+	struct nvkm_disp *disp = container_of(inth, typeof(*disp), engine.subdev.inth);
+	irqreturn_t ret = tu102_disp_intr(inth);
+
+	/* The FE interrupt vectors are message-based on NVD5.0. Re-arm the
+	 * low-latency vector so it fires again for any event that latched
+	 * while we were servicing.
+	 */
+	nvkm_wr32(disp->engine.subdev.device, 0x611f34, 0x00000001);
+	return ret;
+}
+
 static const struct nvkm_head_func
 gb202_gsp_head = {
 	.state = gb202_head_state,
 	.rgpos = gv100_head_rgpos,
-	.vblank_get = tu102_head_vblank_get,
-	.vblank_put = tu102_head_vblank_put,
+	.vblank_get = gb202_head_vblank_get,
+	.vblank_put = gb202_head_vblank_put,
 };
 
 /* GB20x is GSP-only. This table supplies the register programming the
@@ -139,7 +173,9 @@ static const struct nvkm_disp_func
 gb202_gsp_disp = {
 	.uevent = &gv100_disp_chan_uevent,
 	.ramht_size = 0x2000,
-	.gsp.intr = tu102_disp_intr,
+	/* Head timing arrives on the dedicated low-latency vector. */
+	.gsp.intr = gb202_disp_intr,
+	.gsp.intr_low_latency = true,
 	.gsp.head = &gb202_gsp_head,
 	.gsp.hdmi_gcp = gb202_sor_hdmi_gcp,
 	/* The legacy AVI unit is unchanged on GB20x. */
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
index 784521c2aca1..5976498da909 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
@@ -56,8 +56,6 @@ int gv100_head_new(struct nvkm_disp *, int id);
 void gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state);
 void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline);
 
-void tu102_head_vblank_get(struct nvkm_head *);
-void tu102_head_vblank_put(struct nvkm_head *);
 extern const struct nvkm_head_func tu102_gsp_head;
 
 #define HEAD_MSG(h,l,f,a...) do {                                              \
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
index a9dbda67a7d4..fde321dbd7c8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
@@ -42,6 +42,8 @@ struct nvkm_disp_func {
 	 */
 	struct {
 		irqreturn_t (*intr)(struct nvkm_inth *);
+		/* Head-timing interrupts arrive on a second DISP vector. */
+		bool intr_low_latency;
 		const struct nvkm_head_func *head;
 		void (*hdmi_gcp)(struct nvkm_ior *, int head, bool enable);
 		void (*hdmi_infoframe_avi)(struct nvkm_ior *, int head, void *data, u32 size);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
index 948b1d2f954c..f6c163072ff6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
@@ -123,7 +123,7 @@ tu102_sor_new(struct nvkm_disp *disp, int id)
  * enables to us. These program the RM head-timing line (bit 1 of the
  * per-head enable, not the bit nvkm's own gv100 path uses).
  */
-void
+static void
 tu102_head_vblank_put(struct nvkm_head *head)
 {
 	struct nvkm_device *device = head->disp->engine.subdev.device;
@@ -131,7 +131,7 @@ tu102_head_vblank_put(struct nvkm_head *head)
 	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000000);
 }
 
-void
+static void
 tu102_head_vblank_get(struct nvkm_head *head)
 {
 	struct nvkm_device *device = head->disp->engine.subdev.device;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 7d1d4ee2af79..f5f22173fc2c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -1671,7 +1671,15 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 	if (ret)
 		return ret;
 
-	ret = nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type, disp->engine.subdev.inst);
+	/* Chips that raise head-timing interrupts on a separate low-latency
+	 * vector report it as a second DISP interrupt table entry, exposed
+	 * as instance 1 by the RM engine-index translation (see
+	 * r570_gsp_xlat_mc_engine_idx()). Their high-latency vector
+	 * (instance 0) is left unhandled as no event nouveau enables is
+	 * routed to it, and without a handler it stays masked.
+	 */
+	ret = nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type,
+				  disp->func->gsp.intr_low_latency ? 1 : disp->engine.subdev.inst);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
index 3e391646d8f7..b45781cd0dfd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
@@ -44,6 +44,15 @@ r570_gsp_xlat_mc_engine_idx(u32 mc_engine_idx, enum nvkm_subdev_type *ptype, int
 		*ptype = NVKM_ENGINE_DISP;
 		*pinst = 0;
 		return true;
+	case MC_ENGINE_IDX_DISP_LOW:
+		/* GB20x+ report a separate low-latency display vector, used
+		 * for head-timing interrupts. Expose it as a second DISP
+		 * interrupt instance. r535_disp_oneinit() attaches the
+		 * handler to it when the chip's gsp.intr_low_latency is set.
+		 */
+		*ptype = NVKM_ENGINE_DISP;
+		*pinst = 1;
+		return true;
 	case MC_ENGINE_IDX_CE0 ... MC_ENGINE_IDX_CE19:
 		*ptype = NVKM_ENGINE_CE;
 		*pinst = mc_engine_idx - MC_ENGINE_IDX_CE0;
-- 
2.55.0

