Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4545000
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616893; cv=none; b=km39xszATbO3fvEcehSZR4I7sw4lbjAUkhXQaH7xK+tkjQi6KaZr0G9S/+I0F/Tjo3Qi6tXmxWG/5Ervo/hPpe5LgKtg0lIvWTMeqXZ6DWqDLC7RdTKTf/LgNIEq2lm6KZIkz1s2WmF22h9ffoIkWNmw+zJv4iygIDgzyIezHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616893; c=relaxed/simple;
	bh=ze/HLi/pQf5IGVEyhSdxRYFBhUH7CZ1PfAlGbkDO+WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMHYNAdFOzA+8s6pXfMjHES9PC1T8fh9mkc4n6nLbVjry9uIiyuCf0gdN7U5PfgvVioDZ42ZCu50sXeHP0LN/enAqE2v4l2qE/iEniE+vbSt2IokEvLuxYs6FKeYiwJyzGwWqVPidZ0y58DGxRFIqVX1B1Fd+hTJlXT7Hfmb0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCFntH9A; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCFntH9A"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso1328660f8f.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787616890; x=1788221690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x04IiTfhYJXNOaOqTfXwDySQqeqgSixvxmzpY3etBHo=;
        b=kCFntH9AwbZEbdHtsrB1ilGtZ4X0so5UXVVRwUn67Ept6Dt7QkC8lDTrFz/ralsf3O
         V9dDtCbAYghIMrTXoX7KijUECKYFWNpmr7iohdVI2xILa756v6iCgmpBXMYNuQ/APvv/
         t9mLUaH/GyVjnzR/PGPMF+ZUgLG19VVKXX/04u4gtdEYHFHGrQNAlIv939kEZMd3VrJG
         Ct9CHBl+mdiSO+SfoLtiiVCUx9DMOIshAc4YnJsFozVf4l2iCXtIvUCnsghpLsJW6ee2
         fVaak9nZlUFS8h+XZOh9ouaVshmIK2NlaAwE1mPjJwvyMC9gV8BJPvPAGrFqu2wGXcL6
         ZS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616890; x=1788221690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x04IiTfhYJXNOaOqTfXwDySQqeqgSixvxmzpY3etBHo=;
        b=MHOE11teL994p3w4HcnhF9yPkra9rRt2SnWf4CDY4eAWhcgtPMItvAetnZIszJrxYI
         W3ZzdeWpIHl9npeczRc52f/zC5w3u99jICw+NW1Gp72woOfBCpXtZEgSZd4x+cUHBhOz
         ieMwuN2FQDWg1UxTg6OZ0eBZBQ2+J4GDqs5/WWvyk2MBtDDcbGCELcj2dFdf+MgUKvqp
         uJFM7xOqIvtZawHCc1B2PRuFKHGzEMgjaFS5dYiti1LBNLR2vlJs3NaXRgE+cOh1YnCS
         0+WuW5PLXaHo+7biG0tKr3/jbGccclVGqJG9P4TPltFrIToInNa7G5eiXky2jOwxPgK+
         RTwA==
X-Forwarded-Encrypted: i=1; AHgh+Rrpgz+sINTYtk3rpGzcqt9ssWe2oBmYTq3sCe3iJ1B93cPcV8R6ogTdPkUHMvcqT0CF8sBNk2g=@vger.kernel.org
X-Gm-Message-State: AFuF++lGhEAtWitSh/NuaauQ6rz3PuwnSCTxxOWQkP2RaqzIsnQ0xGdQ
	rpNFX6aQedb/oK0/eBSMsagMCQfF2761++NI3kmekLLrqdR0tFbi4MjR
X-Gm-Gg: AR+sD12z24RxxoU3/WpkmRbxi2LVNBUPyyGgfu53nDPlZF2ReZS9vSCZTBTprX5kkpE
	2PcUTxHJol/9ab5j9K+MoQ0ltu8TCg7E6E+lhuwD5TBJlmWzM4sYKiH2W5OIvTSKCPTrs4LVYD9
	AVJ93vdYrAL1YcEMKlp3VJXAze/mGCMk7IB21s/D+YNCzAEAzzOgS0SuRi5IhYf7mVuucrzjrRQ
	xzTZf5LYqUSOwbX3pLSb3vF9C90AKdLcBE0ZLa4u9FFlOMqnqNfibO8PPiEUZvhAwSFuqi7VGRn
	2/HJRxdAIxEbfPko7mQEKu535VYL8zDe6Skd0PhXTyp8fyfA5AZmc3uZhnnjv89EsbAKUtncE5a
	qno7DQNh8PEhlcIng0OGJGxOUg0dNPc2873txPW39fF4dLoqXuLgoE9a49k7YOzYhOHbnfDwQMA
	T+1uPfzsMCMtDz6x/wVNmSeHA8rSTWmCRgeSx0I7XgYm1mhiLEuCG6E+Xb14Rj2vVXRlz6o3nvo
	VgCTA==
X-Received: by 2002:a05:6000:2309:b0:47f:9447:62bf with SMTP id ffacd0b85a97d-482c0b54855mr37921273f8f.2.1787616889861;
        Mon, 24 Aug 2026 17:14:49 -0700 (PDT)
Received: from fedora ([5.31.134.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:14:48 -0700 (PDT)
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
Subject: [PATCH v3 02/10] drm/nouveau/disp: move the GSP HDMI GCP AVMute write to engine/disp
Date: Tue, 25 Aug 2026 04:14:00 +0400
Message-ID: <20260825001408.14219-3-mohamedahmedegypt2001@gmail.com>
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

r535_sor_hdmi_audio() pairs two RM controls (a SET_OD_PACKET carrying
the same General Control Packet, and the audio mute-stream toggle)
with a direct write of the GCP AVMute bit through the SF GCP unit.
The controls are RM and stay, but the direct write is register
programming and moves next to the other per-chip display code as
tu102_sor_hdmi_gcp(). No functional change.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h    |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c  | 15 +++++++++++++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c    |  9 +--------
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
index 3ba04bead2f9..5d682a774f2d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
@@ -194,6 +194,7 @@ void gv100_sor_dp_audio_sym(struct nvkm_ior *, int, u16, u32);
 void gv100_sor_dp_watermark(struct nvkm_ior *, int, u8);
 extern const struct nvkm_ior_func_hda gv100_sor_hda;
 
+void tu102_sor_hdmi_gcp(struct nvkm_ior *, int, bool);
 void tu102_sor_dp_vcpi(struct nvkm_ior *, int, u8, u8, u16, u16);
 
 int nv50_pior_cnt(struct nvkm_disp *, unsigned long *);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
index 7b70b466fa36..6cfd52c9056f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
@@ -30,6 +30,21 @@
 
 #include <nvif/class.h>
 
+/* General Control Packet: bracket an audio enable/disable with AVMute
+ * through the legacy GCP SF unit. Used by the GSP-RM path, which sends the
+ * equivalent packet via RM as well but keeps the direct write in sync.
+ */
+void
+tu102_sor_hdmi_gcp(struct nvkm_ior *sor, int head, bool enable)
+{
+	struct nvkm_device *device = sor->disp->engine.subdev.device;
+	const u32 hdmi = head * 0x400;
+
+	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000000);
+	nvkm_wr32(device, 0x6f00cc + hdmi, !enable ? 0x00000001 : 0x00000010);
+	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000001);
+}
+
 void
 tu102_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u16 aligned)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 8e57bb6519e5..cd4451e62512 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -545,16 +545,9 @@ r535_sor_hdmi_ctrl_audio(struct nvkm_outp *outp, bool enable)
 static void
 r535_sor_hdmi_audio(struct nvkm_ior *sor, int head, bool enable)
 {
-	struct nvkm_device *device = sor->disp->engine.subdev.device;
-	const u32 hdmi = head * 0x400;
-
 	r535_sor_hdmi_ctrl_audio(sor->asy.outp, enable);
 	r535_sor_hdmi_ctrl_audio_mute(sor->asy.outp, !enable);
-
-	/* General Control (GCP). */
-	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000000);
-	nvkm_wr32(device, 0x6f00cc + hdmi, !enable ? 0x00000001 : 0x00000010);
-	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000001);
+	tu102_sor_hdmi_gcp(sor, head, enable);
 }
 
 static void
-- 
2.55.0

