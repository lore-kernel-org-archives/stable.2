Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC6202C48
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616914; cv=none; b=Pn+MIy+IThMI6LlPQbiSszCrEdS9w02eWoE9tk/5QiOJUS43Wo00RlHHsUthsoPylPd6l32OLTHC4x4XvhC4Ig7Dy5X9gtHkKrhRFjp7UyawjYFFyfJcZ9Uc1Jevo4H5wY6rZpcrEh1r8MqC4Wu96OKMNFH9Kp1zvkzYoK+K7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616914; c=relaxed/simple;
	bh=VJand9sh9NHtem3pMUzMrNghJXYdaKFAaIcEQwTQ0Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvEQ6vr8gJ7gPwtT9KnC1tEG2g2gbPhXu0aL1Lvy0Wn07hd3qXSIQpjEJEIf3PJP8jro2zKQ/VP7juFKzQidgLmBGmaZSTvQYGJPtPOlL1g8KYZ/sS+fw81sfEvOcPZlg67m/JexnWsA622/4Rv37Q1Ap5V+kKLegFkJC9vTB2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noWgxaLl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noWgxaLl"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1798787f8f.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 17:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787616911; x=1788221711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mdmMJSJ8rbCJNULoO8M4OEKgVBhOfOqt451kTS7kBCU=;
        b=noWgxaLlh1hhnViQNC9Q0ssItIR+dsKEFPnhzZbmW/C7Zlq1QJ/uAOlT8zrAjHk0B8
         jkM8al+m99s1exdGbEvXxm4w3LNpRM4ywDiL0Zd0jCdxVqMgvJlHfsEeMBR9qXx/YEzp
         lhEAUKHzh5biviOCPGCSKbGuHxgziO0o3LcWSr3/WZiAxD41GY+lwaOB7LxLjLDE27ht
         rLjMzYTwE+ldMkZWLxJ77tqUr/fhT+Z1b+e6Yn1t/RDJQCG436hanNLrYvE819wPB2zv
         22AzUWEt7JJjwo3Ts9qz/WrJYjzgHQ9Z8SXYP5ECAWAWPQRtyGRs7G9rxZ5pD2uFSaE0
         ohCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616911; x=1788221711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mdmMJSJ8rbCJNULoO8M4OEKgVBhOfOqt451kTS7kBCU=;
        b=KRo1ccZnoGz2TnKYQ7doevSIVp8x4nt2lTrny70MGdo1CAvXnCyHVWOdxekSuCoNdJ
         6yubPO16FQdiANkhVhzPA/wwnSz7TQQL1/Al7oIR3oVs/rVnLVXJv/SoDhhCyTgmC5s8
         /V090Khs6XfSpvPp+ZT2P035ne7hZInaCtb2EYqyCLkJjECn/HHw7DQK+219ZKjYpeZ0
         cKqQWEdve/ViNzGm/CZzYSBzlXlkL4qF1kayx4jV8znB5jDyPDvBSQZG3KEHsymJWl+t
         UliEEk2Uoa9ZdXow0Cjo6qm5Zb40BziUkyYeD6Avkl4kmpV23mY4S0fRJcUaoxkzJnaG
         u39w==
X-Forwarded-Encrypted: i=1; AHgh+RpI6l3FHAdklwVkoIgTwPe8/RE6KV+zrzXDfzoCuKu5Njb22CSjFW7emepDVhWD2XYXNOKAsIg=@vger.kernel.org
X-Gm-Message-State: AFuF++mTUDZDk7oQlRsfqoOKAJF/QP5s2it/2iArtLO88/fSNLOK5seP
	7tmCn1axP46RZ0Kmdp8W/RZRUFCBalRNqWPC4nVgW/K4YYtveC7a0hus
X-Gm-Gg: AR+sD13TLpayRaCA5wWhHYhXu7ooMS20H3wq0CwUWS+JkRct2+WAwGBkeKtnX37oHaD
	8+Bu1Eevoij7FqeXhDYyx5B7XxmHWeXkvLpbcqXuaiyz65TdWzfrSTip0w4g1gj8tESrkQU8YRM
	EcOiBrh6lY0jJrJn6WGLuwFBpRXP/UFIcWigeQOY6Vh4fs/ooKzXmECbmSTk+TgcGEkOSA6k/Zz
	HVKN39tYSqWDz5GyzKDdhgw07DQc0X/vRccsoMUVKgDvogXctolrFD3jFzvWIRaY34Y9z6aSpzS
	/TJqc+J1UewHLsobu2i1yFVHNoEZX3KA1f6zLzufmsVV8OhsMVT06gq18/X/P+OP9/Z1zNdJ+an
	8HLzqeuzNQ2UKDDJfseJmIvkFJVjYnbxKrGRBfIwG2izlqExNIdZFgX9IsOTVH4IRA4rYyjoOct
	FGyue0m59g0v7b7wbjwMJhSYwSDos1v4D/8fRVSQIZWtttc9Yi3gSPSXxRyzGNv5pgB+E=
X-Received: by 2002:a05:6000:2582:b0:47f:80ee:744f with SMTP id ffacd0b85a97d-482c0b99a89mr36897656f8f.16.1787616911031;
        Mon, 24 Aug 2026 17:15:11 -0700 (PDT)
Received: from fedora ([5.31.134.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:15:09 -0700 (PDT)
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
Subject: [PATCH v3 05/10] drm/nouveau/disp: fix HDMI GCP AVMute register offsets on GB20x
Date: Tue, 25 Aug 2026 04:14:03 +0400
Message-ID: <20260825001408.14219-6-mohamedahmedegypt2001@gmail.com>
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

The GSP path brackets audio enablement with a General Control Packet
AVMute toggle. r535_sor_hdmi_audio() calls the gsp.hdmi_gcp hook, which
every chip so far serves with tu102_sor_hdmi_gcp() and the legacy GCP
unit at 0x6f00c0/0x6f00cc. On GB20x the SF packet units were compacted
and the old generic and VSI units are gone (ACR keeps slot 2) and the
GCP unit moved from slot 3 to slot 1 (control 0x6f0040 and subpack
0x6f004c from NVIDIA's published clc971.h. The same offsets are also
used by OpenRM's hdmiWriteGeneralCtrlPacketC871() on these chips). The
old addresses are reserved on GB20x, so the AVMute writes were silent
no-ops and mitigated only by the equivalent GCP r535_sor_hdmi_audio()
already sends through the SET_OD_PACKET RM control.

Add a GB20x GCP writer using the new offsets and hook it into
gb202_gsp_disp, keeping the direct MMIO path in sync with the hardware
as on earlier chips.

Only SB0 (the AVMute bit) is written. On NVD5.0 the subpack register also
carries SB1_CTRL (bit 24), which selects where the deep-color CD/PP
fields are generated (hardware or from the driver, with the default being
HW). hdmiWriteGeneralCtrlPacketC871() likewise writes only SB0-SB2.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
index 1e40de83e2bb..face801af080 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
@@ -65,6 +65,24 @@ gb202_sor_hdmi_infoframe_vsi(struct nvkm_ior *ior, int head, void *data, u32 siz
 	nvkm_wr32(device, 0x6f03f8 + hoff, 0x00000002);
 }
 
+/* General Control Packet AVMute bracket. The GCP unit moved to slot 1 on
+ * NVD5.0. Only SB0 (the AVMute bit) is ours to write so we must not do a
+ * full write here: SB1 carries the deep-color CD/PP fields, and SB1_CTRL
+ * (bit 24, new with clc871.h) controls where their generation happens (HW
+ * or driver) on these chips, with the default being HW.
+ */
+static void
+gb202_sor_hdmi_gcp(struct nvkm_ior *sor, int head, bool enable)
+{
+	struct nvkm_device *device = sor->disp->engine.subdev.device;
+	const u32 hdmi = head * 0x400;
+
+	nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000000);
+	nvkm_mask(device, 0x6f004c + hdmi, 0x000000ff, !enable ? 0x00000001 :
+								 0x00000010);
+	nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000001);
+}
+
 /* GB20x is GSP-only. This table supplies the register programming the
  * GSP-RM display path needs from the chip.
  */
@@ -74,7 +92,7 @@ gb202_gsp_disp = {
 	.ramht_size = 0x2000,
 	.gsp.intr = tu102_disp_intr,
 	.gsp.head = &tu102_gsp_head,
-	.gsp.hdmi_gcp = tu102_sor_hdmi_gcp,
+	.gsp.hdmi_gcp = gb202_sor_hdmi_gcp,
 	/* The legacy AVI unit is unchanged on GB20x. */
 	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
 	.gsp.hdmi_infoframe_vsi = gb202_sor_hdmi_infoframe_vsi,
-- 
2.55.0

