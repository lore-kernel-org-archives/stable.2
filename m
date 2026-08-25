Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BBEEB3
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616885; cv=none; b=ag00PM1h5/lAw+Tu2mN4yA3wu1CkwoW8K8gQUgumD8BySYMudGIba+yxklOpoxA0fYXNzuRO8BA6kBq2tLdUGhAIDcaFLm4dCwinGGdjhixG8hL+Ziz56lk/MdHxURp+S9hilFKaa3yfPdHzkXreUPSX3YECRSfX3OBSLFkcaYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616885; c=relaxed/simple;
	bh=plz2a+CWfqDmsfsV8vUbs5gQ2DLeAQR+DAafoCpZbOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrXsgjFfbUAFG7wsOvWbcLTlWUbVKELdd0hJNJpP3S/OLW0AIwi+9kNoBsY0K7PnaQWgdOtlMa7J17B1GUzvdrib7Llvyp9VqgTzIsTtKtaGIXQ5B7EU4zxbLo+PKERX1cgdc9ltkhTVA9G0DfZQhyGZCw61dTCpLLYUJtOQvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFPgbFqN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFPgbFqN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so31347135e9.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 17:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787616882; x=1788221682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RuAEk+4LiQhkycCwL92SfZ2A4rYOkzcfHz0DHKAe0bE=;
        b=QFPgbFqNzLWeubX5OaYmvwktzLd8hl6ehe/Am+Vp+cmuuj/UZ0zyxpi+OJ0YaCJEv8
         vta9+PjGriO8br9ZUUFcSZ5C+cnvbVhd1i2oyFrZ+oCJKbiOzzXR8bJEEHcc4SIf+7Qy
         sqvKQLjOJv7+f01FkfjcMRWwlSWVcU5ZdUM/NS3jfLbFw9hkL+DX9skUL1HjpAO3x903
         ioh0PCYgmTIG1d33s55/BW5SJyh3q1RH93NmP85XBD6eIW07Ek66L5K3ssLHl92qLQbz
         w2iUHxpID+z4d8ndlEwKUjc8xtxm9h4QlL6f0FEMyKqH9m1uRN10d1VN/Af/qsJ4wOpx
         olcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616882; x=1788221682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RuAEk+4LiQhkycCwL92SfZ2A4rYOkzcfHz0DHKAe0bE=;
        b=hNB5wOpHTmXEI5T30LMVv7Us0AVc8VSITA44jx/wGQNKVwZYVRb9di6NEbOP+gTCJw
         l8yaQr7SwLZZJesnkpqUxPxVOWYrJFzHR1a1JPWRR+w6UdYbC9L55Ji4E75gyrh0KzQK
         xwdm7FdGAgyZ6gVFCX2/Z5XHJqf+Sn15uwLcFQs7K7p5wK6fPGHdORHuqFDYGBUDZHZD
         F9/wbPaniTzB37WDQU2wRkLeuBMgGsgkXIuQLyAPACVuZnhXoqwIwErAFs3nnMtAkr8f
         fsWdrRS70xC4AkVJG5uWnuuX0QsP8WnGoSv09m85mynkkcuAW1AhF73MDCwrfHlHmAfa
         oOMA==
X-Forwarded-Encrypted: i=1; AHgh+RoiSWw01Urd0mPJOzmbO44vivSctauSll7q8ijnkKs+Nm2MT+yjFyIX6gTjMhoStlnAf4OxoRM=@vger.kernel.org
X-Gm-Message-State: AFuF++mi3O26kq9IFf+pa02VPwPfPb6Jf+R7Y9I2j87yXtctEK5OZNgj
	p4XEcWGW/fWO/R8M0RsHVzQN1dZADVUhZc8gBNx/AzGdRlaJzBIrUevJ
X-Gm-Gg: AR+sD10KScQI5wwS5lz6Z+3LuXEp4jsu7P/YjwnrgqMntlr9yPKL78haq2ih0ReEr/N
	ZeoTPpEfaJJjcPUPWezxpytjsqgYkqw6+xqcir/LdShCvAi9dmGYEGp7iLSSFH/gXulPTBEMqEk
	paKkRNn0MBynXvXcAZtUvO1gSFSIW+C7wmQb4or4LS/r8PurvyfCy7bS0guI3rlcSiLBeQbskBa
	cQgytJih0/0I/4vIyYEiomnovgzhEfdc0TLVgpp94MH4JAyBXw4iIE2w5fgXEZ7Z11G2oPW6Dbf
	j85CIL8vqZaKqsDqyO+er5Hhyl6R7xBIkwV/rb4WB/NQ2zfhoT7FLVxssB/zSVi2QUadpy9kINM
	4jdp/dO0vDTGgzE5vKvn+rxtbIIo/ksX3ccJDSRDTwbFkyuJo7ybbDvCZInI92f9X27qtQhW6H/
	Ui2to9RZ51EqXcZy8e5oWAAwg50K3btvqizJRF2EATgtOk9VOcil1QBf46Dm3ER+MONDCc2lhl5
	Vw0Xw==
X-Received: by 2002:a05:600c:474a:b0:499:b65d:124f with SMTP id 5b1f17b1804b1-499b845709amr367619755e9.11.1787616881745;
        Mon, 24 Aug 2026 17:14:41 -0700 (PDT)
Received: from fedora ([5.31.134.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:14:40 -0700 (PDT)
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
Subject: [PATCH v3 01/10] drm/nouveau/disp: move GSP head-timing ISR and vblank helpers to tu102.c
Date: Tue, 25 Aug 2026 04:13:59 +0400
Message-ID: <20260825001408.14219-2-mohamedahmedegypt2001@gmail.com>
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

The GSP-RM display code in rm/r535/disp.c owns a handful of direct MMIO
routines: the head-timing (vblank) interrupt handler and the per-head
vblank enable/disable. They program display registers, not RM, so they
belong with the rest of the per-chip register code in engine/disp/.

Move them to tu102.c (Turing is the first GSP-capable generation) as
tu102_disp_intr() and tu102_head_vblank_get()/put(), exported for
rm/r535/disp.c, which keeps calling them by name for now. No functional
change.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/head.h   |  3 ++
 .../gpu/drm/nouveau/nvkm/engine/disp/priv.h   |  1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/tu102.c  | 50 ++++++++++++++++++
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 52 ++-----------------
 4 files changed, 57 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
index b642729c254f..986043e87554 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
@@ -56,6 +56,9 @@ int gv100_head_new(struct nvkm_disp *, int id);
 void gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state);
 void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline);
 
+void tu102_head_vblank_get(struct nvkm_head *);
+void tu102_head_vblank_put(struct nvkm_head *);
+
 #define HEAD_MSG(h,l,f,a...) do {                                              \
 	struct nvkm_head *_h = (h);                                            \
 	nvkm_##l(&_h->disp->engine.subdev, "head-%d: "f"\n", _h->id, ##a);     \
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
index a3fd7cb7c488..722ec340e12a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
@@ -72,6 +72,7 @@ int gv100_disp_wndw_cnt(struct nvkm_disp *, unsigned long *);
 int gv100_disp_caps_new(const struct nvkm_oclass *, void *, u32, struct nvkm_object **);
 
 int tu102_disp_init(struct nvkm_disp *);
+irqreturn_t tu102_disp_intr(struct nvkm_inth *);
 
 void nv50_disp_dptmds_war_2(struct nvkm_disp *, struct dcb_output *);
 void nv50_disp_dptmds_war_3(struct nvkm_disp *, struct dcb_output *);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
index dcb9f8ba374c..7b70b466fa36 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
@@ -104,6 +104,56 @@ tu102_sor_new(struct nvkm_disp *disp, int id)
 	return nvkm_ior_new_(&tu102_sor, disp, SOR, id, hda & BIT(id));
 }
 
+/* The GSP-RM display path leaves head-timing (vblank) interrupts and their
+ * enables to us. These program the RM head-timing line (bit 1 of the
+ * per-head enable, not the bit nvkm's own gv100 path uses).
+ */
+void
+tu102_head_vblank_put(struct nvkm_head *head)
+{
+	struct nvkm_device *device = head->disp->engine.subdev.device;
+
+	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000000);
+}
+
+void
+tu102_head_vblank_get(struct nvkm_head *head)
+{
+	struct nvkm_device *device = head->disp->engine.subdev.device;
+
+	nvkm_wr32(device, 0x611800 + (head->id * 4), 0x00000002);
+	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
+}
+
+static void
+tu102_disp_intr_head_timing(struct nvkm_disp *disp, int head)
+{
+	struct nvkm_subdev *subdev = &disp->engine.subdev;
+	struct nvkm_device *device = subdev->device;
+	u32 stat = nvkm_rd32(device, 0x611c00 + (head * 0x04));
+
+	if (stat & 0x00000002) {
+		nvkm_disp_vblank(disp, head);
+
+		nvkm_wr32(device, 0x611800 + (head * 0x04), 0x00000002);
+	}
+}
+
+irqreturn_t
+tu102_disp_intr(struct nvkm_inth *inth)
+{
+	struct nvkm_disp *disp = container_of(inth, typeof(*disp), engine.subdev.inth);
+	struct nvkm_subdev *subdev = &disp->engine.subdev;
+	struct nvkm_device *device = subdev->device;
+	unsigned long mask = nvkm_rd32(device, 0x611ec0) & 0x000000ff;
+	int head;
+
+	for_each_set_bit(head, &mask, 8)
+		tu102_disp_intr_head_timing(disp, head);
+
+	return IRQ_HANDLED;
+}
+
 int
 tu102_disp_init(struct nvkm_disp *disp)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index e77733a5d9c3..8e57bb6519e5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -608,29 +608,12 @@ r535_sor_cnt(struct nvkm_disp *disp, unsigned long *pmask)
 	return 4;
 }
 
-static void
-r535_head_vblank_put(struct nvkm_head *head)
-{
-	struct nvkm_device *device = head->disp->engine.subdev.device;
-
-	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000000);
-}
-
-static void
-r535_head_vblank_get(struct nvkm_head *head)
-{
-	struct nvkm_device *device = head->disp->engine.subdev.device;
-
-	nvkm_wr32(device, 0x611800 + (head->id * 4), 0x00000002);
-	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
-}
-
 static const struct nvkm_head_func
 r535_head = {
 	.state = gv100_head_state,
 	.rgpos = gv100_head_rgpos,
-	.vblank_get = r535_head_vblank_get,
-	.vblank_put = r535_head_vblank_put,
+	.vblank_get = tu102_head_vblank_get,
+	.vblank_put = tu102_head_vblank_put,
 };
 
 static struct nvkm_conn *
@@ -1404,35 +1387,6 @@ static const struct nvkm_event_func
 r535_disp_event = {
 };
 
-static void
-r535_disp_intr_head_timing(struct nvkm_disp *disp, int head)
-{
-	struct nvkm_subdev *subdev = &disp->engine.subdev;
-	struct nvkm_device *device = subdev->device;
-	u32 stat = nvkm_rd32(device, 0x611c00 + (head * 0x04));
-
-	if (stat & 0x00000002) {
-		nvkm_disp_vblank(disp, head);
-
-		nvkm_wr32(device, 0x611800 + (head * 0x04), 0x00000002);
-	}
-}
-
-static irqreturn_t
-r535_disp_intr(struct nvkm_inth *inth)
-{
-	struct nvkm_disp *disp = container_of(inth, typeof(*disp), engine.subdev.inth);
-	struct nvkm_subdev *subdev = &disp->engine.subdev;
-	struct nvkm_device *device = subdev->device;
-	unsigned long mask = nvkm_rd32(device, 0x611ec0) & 0x000000ff;
-	int head;
-
-	for_each_set_bit(head, &mask, 8)
-		r535_disp_intr_head_timing(disp, head);
-
-	return IRQ_HANDLED;
-}
-
 static void
 r535_disp_fini(struct nvkm_disp *disp, bool suspend)
 {
@@ -1708,7 +1662,7 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 		return ret;
 
 	ret = nvkm_inth_add(&device->vfn->intr, ret, NVKM_INTR_PRIO_NORMAL, &disp->engine.subdev,
-			    r535_disp_intr, &disp->engine.subdev.inth);
+			    tu102_disp_intr, &disp->engine.subdev.inth);
 	if (ret)
 		return ret;
 
-- 
2.55.0

