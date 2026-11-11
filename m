Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425925;
	b=zNUOuYYLNbt2VDKvQdSH6LVPlKW4KhjPSsWsXu9/dx09rfXaUpn3AKnOZxAb3N8YAyOK
	 4o+NH99mF6mEE/7UoDwW4gUB9hOP/WBOGgIFqaIdWuDL+fr7zBxcADRjxqYP+quQPP99y
	 I2KMT1eKufr2BYN56hPpBSMxpz7bQwZsJEusXPA0Jp9wIRg6QtFSUdNvpU9Q/aQFGlO1K
	 B7fBUUdKT0Yr4/+cJbt8aMfCzsI/uyPbfnTIimBpe4KAHdIRpKCvaGRYTKHtFK11wrWn3
	 vr8BXvWp8p17eHJDRKNghfzqlzju8FhahIb2Nvl6SYFnEfY4bA8UluEMtpYxcg+0sYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425925;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=JGfMTpWWc/SxskG3/aF6loCPlkuSqCzMhJw6KsZDKsA=;
	b=CdZIKzqn2jH5GWn72J4mP5f+wJO1Z0x9dwmVy73LZQGPwg3EiA6Z+lT4HePcyZtZVz3T
	 lWaPJIxRFWNMNH+A2jzyGWEmdutZ3+TjtAhyQBCqmPTU3p6kfoNprd/L+2P9rNtGvmJBQ
	 l9hjpQ6yE+VDOq6u8ljbwaqwVaSHzNbOupaZZKN6EscUsMF2MFmu31P+j1cpOVsDWHnFC
	 wCCzFmp+BA+Bf4TqN4shCy+w+NL1nE6/FkDHnLqsV1AbAZgv1hIZx4ZR8dar3N+84Tmc1
	 fYx/3/LtP6eowSubJyt+h50alT4PujiuCod+d1vGvWlKwS7REl+ZzUMGyf631YcISWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bwdqgzEa;
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86A606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E86A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bwdqgzEa
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2ed1f1a7695so13910985ad.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425924; x=1795030724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JGfMTpWWc/SxskG3/aF6loCPlkuSqCzMhJw6KsZDKsA=;
        b=1uVMv6OHooQGSU4RN3ibcaPUZu2zCNfw+opkjquZp4GpU2D/n2dGL4mOPkYFkEvzhb
         C2DxtefYtzsQjWfyptNSrhuyMC4MOVUbk5Rn3FxDKxEo3kENPuZJcinPJkcuJdKJAa0e
         KfjckOLzrQhfFIdDALFifS4+mFZxAgbCECIQubhPjCP7x9lmo+zBKSD3kGDLIPBm6sNx
         MGGZiuUe320WMe7QZtmrpriIRfgok1/+HkaQEq6+9Vrth6WeLwNSZKFQ9T6skj1BVxxt
         xDkcceT7ojGDQ8DYvk2jOToGJHzgjKWrUJ4d3LIBcwgrvh/CICRl8GABiazxLLKAQcy8
         NQdA==
X-Forwarded-Encrypted: i=1; AL+hErEWxM/DKZYSCqtR0ofBee0m1rnUu3RIkJTcoZq/GCMGa6lOjb5PeBLsWPgjjdE3XmTTbMJboY0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9X9EoGW3CCoQpPyZ6XVlygob9EgmZZS4GWkiJ7kXN+mGP7+J4L
	uA6bSgHd64K892XacOuiZIBhMqDqRzmAkrhTiI2UwSrHzXEq982gcq9ceZ4yGlq0pg7nBYnJmLA
	DRhvYFWFzSB+6PPYr6FTUXeru/7fNP2sNlrXmR8Rlp5p0KbE8AxwQJYWLA9ewEalvdeCMht68tG
	3DaMpDnOuUbUYzxjNlPzA6yUaxu528s4tgoWJ3C7VqQOvUxmqRhwrBfRsQuFSg6lHfedO8J3BwD
	uKuoGv3
X-Gm-Gg: AYBFou1yNfviK3/5Xlg1gnVIEazaHnV624b81tkqJ+0U/1WNElymcbtI1wDifKRA0gf
	8GRJ96lOLgRx9bKsIAhoy+jD0gseJNtnt1q4IWW0SaJmMCx8md4G8UZWRt+SILl/zW/ywKdiFui
	RUepYKzTyHeQm4l40a4icjUkZMZvE/Da2jmE4TDYr3AllSk7a9GIdzP47C3xNOPXH2sj+S11Z/R
	kRUTP3ndW2EmMz5G1KYxLioNonHnysRVXgi3xt4h2ZbnudbiaoSg3xkl4PA5TcBmIzicPzQT0ly
	4I3g837pM4N/+WPkrvA3fEG855ryUowasLT4M4pU3B+fsrXxu1FJTl6ssUg3RkIH388Xn8atRaB
	BVReYU1BVpM9NzjKZbq8eqVIMbzo3t005ZYHHXQfHZMP8tBoghB/ZkxgQSweh0GWj2mLPAQ70LO
	jtpUzSoH/nO+T6zDgJvdQm1lns+ipmcHuR
X-Received: by 2002:a17:903:3b88:b0:2e3:1e96:7f1a with SMTP id d9443c01a7336-2edd718fe82mr36871595ad.0.1794425924327;
        Wed, 11 Nov 2026 11:38:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2edb62e8610sm1237025ad.5.2026.11.11.11.38.43
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:38:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1aa0fb7f157so5549201c88.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794425922; x=1795030722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JGfMTpWWc/SxskG3/aF6loCPlkuSqCzMhJw6KsZDKsA=;
        b=bwdqgzEadkGx5ugExB5yz9+6CWtzpihZ8nSQ7CKGvb+++DIA0F2b/2KpaEC04vcUg4
         eqay07nYU+Pj1x6OdSS3q9AS5BBgoS5d6HFuLsm8Sf82Xh5ksCBOdf5IDEBw93fTr5vF
         Aysbuf6hm813rSnGheZvuvuo8rxWj8+GUPJm0=
X-Forwarded-Encrypted: i=1; AL+hErE3qFM9FwkhgKLXyfTpAFOVgtENwdZb6wnHQRtoEs8Mwo7Nl5ypI+8ELiXsi3SwgbDc4gsSVJ4=@vger.kernel.org
X-Received: by 2002:a05:701b:4516:20b0:19a:e0eb:6916 with SMTP id a92af1059eb24-1b3c036a7fcmr2971249c88.42.1794425922005;
        Wed, 11 Nov 2026 11:38:42 -0800 (PST)
X-Received: by 2002:a05:701b:4516:20b0:19a:e0eb:6916 with SMTP id a92af1059eb24-1b3c036a7fcmr2971211c88.42.1794425920952;
        Wed, 11 Nov 2026 11:38:40 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4b90csm16428621c88.14.2026.11.11.11.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:38:40 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: validate command body sizes before parsing
Date: Wed, 11 Nov 2026 14:38:36 -0500
Message-ID: <20261111193836.3161904-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

vmw_cmd_check verifies that a command's declared size fits in the
submitted buffer, but handlers can access fields beyond the declared
body. A truncated body can therefore cause relocations to target the
next command. Applying those relocations after validation can change
an already validated command ID and bypass command restrictions.

Legacy query conversion can also overwrite the next command, while
texture-state parsing can access fields beyond a truncated final record.

Check each handler's minimum body size before accessing command fields.
Use the common prefix for shared handlers to preserve shorter command
variants, and reject texture-state arrays containing incomplete records.

Fixes: fb1d9738ca05 ("drm/vmwgfx: Add DRM driver for VMware Virtual GPU")
Cc: stable@vger.kernel.org
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 200 ++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index a9136a6523cb..7b943e99061e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -564,6 +564,29 @@ static int vmw_cmd_ok(struct vmw_private *dev_priv,
 	return 0;
 }
 
+/**
+ * vmw_cmd_body_fits - Check that a command body covers what a handler reads
+ *
+ * @header: Pointer to the command header in the command stream.
+ * @size: Number of body bytes that the command handler interprets.
+ *
+ * vmw_cmd_check() only verifies that @header->size fits into the submitted
+ * command buffer. A handler that reads past the declared body reads the next
+ * command, which is verified separately. A relocation recorded there would
+ * rewrite the already verified command after verification has finished.
+ *
+ * Return: true if the body is at least @size bytes, false otherwise.
+ */
+static bool vmw_cmd_body_fits(const SVGA3dCmdHeader *header, size_t size)
+{
+	if (likely(header->size >= size))
+		return true;
+
+	VMW_DEBUG_USER("SVGA3D command %u: body size %u is smaller than %zu.\n",
+		       header->id, header->size, size);
+	return false;
+}
+
 /**
  * vmw_resources_reserve - Reserve all resources on the sw_context's resource
  * list.
@@ -810,6 +833,9 @@ static int vmw_cmd_cid_check(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, uint32_t) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_context,
 				 VMW_RES_DIRTY_SET, user_context_converter,
 				 &cmd->body, NULL);
@@ -853,6 +879,8 @@ static int vmw_cmd_set_render_target_check(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
 
 	if (cmd->body.type >= SVGA3D_RT_MAX) {
 		VMW_DEBUG_USER("Illegal render target type %u.\n",
@@ -898,6 +926,8 @@ static int vmw_cmd_surface_copy_check(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
 
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				VMW_RES_DIRTY_NONE, user_surface_converter,
@@ -918,6 +948,9 @@ static int vmw_cmd_buffer_copy_check(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				VMW_RES_DIRTY_NONE, user_surface_converter,
 				&cmd->body.src, NULL);
@@ -937,6 +970,9 @@ static int vmw_cmd_pred_copy_check(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				VMW_RES_DIRTY_NONE, user_surface_converter,
 				&cmd->body.srcSid, NULL);
@@ -956,6 +992,9 @@ static int vmw_cmd_stretch_blt_check(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				VMW_RES_DIRTY_NONE, user_surface_converter,
 				&cmd->body.src.sid, NULL);
@@ -974,6 +1013,9 @@ static int vmw_cmd_blt_surf_screen_check(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdBlitSurfaceToScreen) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				 VMW_RES_DIRTY_NONE, user_surface_converter,
 				 &cmd->body.srcImage.sid, NULL);
@@ -986,6 +1028,9 @@ static int vmw_cmd_present_check(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdPresent) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				 VMW_RES_DIRTY_NONE, user_surface_converter,
 				 &cmd->body.sid, NULL);
@@ -1243,6 +1288,8 @@ static int vmw_cmd_dx_define_query(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
 
 	if (cmd->body.type <  SVGA3D_QUERYTYPE_MIN ||
 	    cmd->body.type >= SVGA3D_QUERYTYPE_MAX)
@@ -1280,6 +1327,8 @@ static int vmw_cmd_dx_bind_query(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
 
 	/*
 	 * Look up the buffer pointed to by q.mobid, put it on the relocation
@@ -1310,6 +1359,9 @@ static int vmw_cmd_begin_gb_query(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdBeginGBQuery) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_context,
 				 VMW_RES_DIRTY_SET, user_context_converter,
 				 &cmd->body.cid, NULL);
@@ -1329,6 +1381,9 @@ static int vmw_cmd_begin_query(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdBeginQuery) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (unlikely(dev_priv->has_mob)) {
 		VMW_DECLARE_CMD_VAR(gb_cmd, SVGA3dCmdBeginGBQuery);
 
@@ -1364,6 +1419,9 @@ static int vmw_cmd_end_gb_query(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	ret = vmw_cmd_cid_check(dev_priv, sw_context, header);
 	if (unlikely(ret != 0))
 		return ret;
@@ -1394,6 +1452,9 @@ static int vmw_cmd_end_query(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (dev_priv->has_mob) {
 		VMW_DECLARE_CMD_VAR(gb_cmd, SVGA3dCmdEndGBQuery);
 
@@ -1440,6 +1501,9 @@ static int vmw_cmd_wait_gb_query(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	ret = vmw_cmd_cid_check(dev_priv, sw_context, header);
 	if (unlikely(ret != 0))
 		return ret;
@@ -1468,6 +1532,9 @@ static int vmw_cmd_wait_query(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (dev_priv->has_mob) {
 		VMW_DECLARE_CMD_VAR(gb_cmd, SVGA3dCmdWaitForGBQuery);
 
@@ -1637,6 +1704,15 @@ static int vmw_cmd_tex_state(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
+	/* The loop below must not read a truncated trailing state. */
+	if ((header->size - sizeof(cmd->body)) % sizeof(*cur_state)) {
+		VMW_DEBUG_USER("Invalid texture state size %u.\n",
+			       header->size);
+		return -EINVAL;
+	}
 
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_context,
 				VMW_RES_DIRTY_SET, user_context_converter,
@@ -1782,6 +1858,9 @@ static int vmw_cmd_bind_gb_surface(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdBindGBSurface) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_switch_backup(dev_priv, sw_context, vmw_res_surface,
 				     user_surface_converter, &cmd->body.sid,
 				     &cmd->body.mobid, 0);
@@ -1801,6 +1880,9 @@ static int vmw_cmd_update_gb_image(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdUpdateGBImage) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				 VMW_RES_DIRTY_NONE, user_surface_converter,
 				 &cmd->body.image.sid, NULL);
@@ -1820,6 +1902,9 @@ static int vmw_cmd_update_gb_surface(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdUpdateGBSurface) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				 VMW_RES_DIRTY_CLEAR, user_surface_converter,
 				 &cmd->body.sid, NULL);
@@ -1839,6 +1924,9 @@ static int vmw_cmd_readback_gb_image(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdReadbackGBImage) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				 VMW_RES_DIRTY_NONE, user_surface_converter,
 				 &cmd->body.image.sid, NULL);
@@ -1859,6 +1947,9 @@ static int vmw_cmd_readback_gb_surface(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdReadbackGBSurface) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				 VMW_RES_DIRTY_CLEAR, user_surface_converter,
 				 &cmd->body.sid, NULL);
@@ -1879,6 +1970,9 @@ static int vmw_cmd_invalidate_gb_image(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdInvalidateGBImage) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				 VMW_RES_DIRTY_NONE, user_surface_converter,
 				 &cmd->body.image.sid, NULL);
@@ -1899,6 +1993,9 @@ static int vmw_cmd_invalidate_gb_surface(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdInvalidateGBSurface) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				 VMW_RES_DIRTY_CLEAR, user_surface_converter,
 				 &cmd->body.sid, NULL);
@@ -1921,6 +2018,8 @@ static int vmw_cmd_shader_define(struct vmw_private *dev_priv,
 	struct vmw_resource *ctx;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
 
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_context,
 				VMW_RES_DIRTY_SET, user_context_converter,
@@ -1960,6 +2059,8 @@ static int vmw_cmd_shader_destroy(struct vmw_private *dev_priv,
 	struct vmw_resource *ctx;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
 
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_context,
 				VMW_RES_DIRTY_SET, user_context_converter,
@@ -1999,6 +2100,8 @@ static int vmw_cmd_set_shader(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
 
 	if (!vmw_shadertype_is_valid(VMW_SM_LEGACY, cmd->body.type)) {
 		VMW_DEBUG_USER("Illegal shader type %u.\n",
@@ -2077,6 +2180,8 @@ static int vmw_cmd_set_shader_const(struct vmw_private *dev_priv,
 	int ret;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
 
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_context,
 				VMW_RES_DIRTY_SET, user_context_converter,
@@ -2104,6 +2209,9 @@ static int vmw_cmd_bind_gb_shader(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdBindGBShader) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	return vmw_cmd_switch_backup(dev_priv, sw_context, vmw_res_shader,
 				     user_shader_converter, &cmd->body.shid,
 				     &cmd->body.mobid, cmd->body.offsetInBytes);
@@ -2133,6 +2241,9 @@ vmw_cmd_dx_set_single_constant_buffer(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				VMW_RES_DIRTY_NONE, user_surface_converter,
 				&cmd->body.sid, &res);
@@ -2186,6 +2297,9 @@ vmw_cmd_dx_set_constant_buffer_offset(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (cmd->body.slot >= SVGA3D_DX_MAX_CONSTBUFFERS) {
 		VMW_DEBUG_USER("Illegal const buffer slot %u.\n",
 			       (unsigned int) cmd->body.slot);
@@ -2217,6 +2331,9 @@ static int vmw_cmd_dx_set_shader_res(struct vmw_private *dev_priv,
 	u32 num_sr_view = (cmd->header.size - sizeof(cmd->body)) /
 		sizeof(SVGA3dShaderResourceViewId);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if ((u64) cmd->body.startView + (u64) num_sr_view >
 	    (u64) SVGA3D_DX_MAX_SRVIEWS ||
 	    !vmw_shadertype_is_valid(dev_priv->sm_type, cmd->body.type)) {
@@ -2252,6 +2369,8 @@ static int vmw_cmd_dx_set_shader(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
 
 	if (!vmw_shadertype_is_valid(dev_priv->sm_type, cmd->body.type)) {
 		VMW_DEBUG_USER("Illegal shader type %u.\n",
@@ -2309,6 +2428,9 @@ static int vmw_cmd_dx_set_vertex_buffers(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	num = (cmd->header.size - sizeof(cmd->body)) /
 		sizeof(SVGA3dVertexBuffer);
 	if ((u64)num + (u64)cmd->body.startBuffer >
@@ -2360,6 +2482,9 @@ static int vmw_cmd_dx_set_index_buffer(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				VMW_RES_DIRTY_NONE, user_surface_converter,
 				&cmd->body.sid, &res);
@@ -2395,6 +2520,9 @@ static int vmw_cmd_dx_set_rendertargets(struct vmw_private *dev_priv,
 		sizeof(SVGA3dRenderTargetViewId);
 	int ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (num_rt_view > SVGA3D_DX_MAX_RENDER_TARGETS) {
 		VMW_DEBUG_USER("Invalid DX Rendertarget binding.\n");
 		return -EINVAL;
@@ -2426,6 +2554,9 @@ static int vmw_cmd_dx_clear_rendertarget_view(struct vmw_private *dev_priv,
 		container_of(header, typeof(*cmd), header);
 	struct vmw_resource *ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	ret = vmw_view_id_val_add(sw_context, vmw_view_rt,
 				  cmd->body.renderTargetViewId);
 
@@ -2448,6 +2579,9 @@ static int vmw_cmd_dx_clear_depthstencil_view(struct vmw_private *dev_priv,
 		container_of(header, typeof(*cmd), header);
 	struct vmw_resource *ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	ret = vmw_view_id_val_add(sw_context, vmw_view_ds,
 				  cmd->body.depthStencilViewId);
 
@@ -2481,6 +2615,9 @@ static int vmw_cmd_dx_view_define(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(*cmd) - sizeof(*header)))
+		return -EINVAL;
+
 	if (unlikely(cmd->sid == SVGA3D_INVALID_ID)) {
 		VMW_DEBUG_USER("Invalid surface id.\n");
 		return -EINVAL;
@@ -2529,6 +2666,9 @@ static int vmw_cmd_dx_set_so_targets(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	num = (cmd->header.size - sizeof(cmd->body)) / sizeof(SVGA3dSoTarget);
 
 	if (num > SVGA3D_DX_MAX_SOTARGETS) {
@@ -2582,6 +2722,9 @@ static int vmw_cmd_dx_so_define(struct vmw_private *dev_priv,
 	if (IS_ERR_OR_NULL(res))
 		return res ? PTR_ERR(res) : -EINVAL;
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(*cmd) - sizeof(*header)))
+		return -EINVAL;
+
 	ret = vmw_cotable_notify(res, cmd->defined_id);
 
 	return ret;
@@ -2617,6 +2760,9 @@ static int vmw_cmd_dx_check_subresource(struct vmw_private *dev_priv,
 		     offsetof(typeof(*cmd), sid));
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->sid)))
+		return -EINVAL;
+
 	return vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				 VMW_RES_DIRTY_NONE, user_surface_converter,
 				 &cmd->sid, NULL);
@@ -2658,6 +2804,9 @@ static int vmw_cmd_dx_view_remove(struct vmw_private *dev_priv,
 	struct vmw_resource *view;
 	int ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!ctx_node)
 		return -EINVAL;
 
@@ -2695,6 +2844,9 @@ static int vmw_cmd_dx_define_shader(struct vmw_private *dev_priv,
 		container_of(header, typeof(*cmd), header);
 	int ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!ctx_node)
 		return -EINVAL;
 
@@ -2726,6 +2878,9 @@ static int vmw_cmd_dx_destroy_shader(struct vmw_private *dev_priv,
 		container_of(header, typeof(*cmd), header);
 	int ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!ctx_node)
 		return -EINVAL;
 
@@ -2752,6 +2907,9 @@ static int vmw_cmd_dx_bind_shader(struct vmw_private *dev_priv,
 		container_of(header, typeof(*cmd), header);
 	int ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (cmd->body.cid != SVGA3D_INVALID_ID) {
 		ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_context,
 					VMW_RES_DIRTY_SET,
@@ -2803,6 +2961,9 @@ static int vmw_cmd_dx_genmips(struct vmw_private *dev_priv,
 	struct vmw_resource *view;
 	struct vmw_res_cache_entry *rcache;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	view = vmw_view_id_val_add(sw_context, vmw_view_sr,
 				   cmd->body.shaderResourceViewId);
 	if (IS_ERR(view))
@@ -2836,6 +2997,9 @@ static int vmw_cmd_dx_transfer_from_buffer(struct vmw_private *dev_priv,
 		container_of(header, typeof(*cmd), header);
 	int ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				VMW_RES_DIRTY_NONE, user_surface_converter,
 				&cmd->body.srcSid, NULL);
@@ -2861,6 +3025,9 @@ static int vmw_cmd_intra_surface_copy(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdIntraSurfaceCopy) =
 		container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!(dev_priv->capabilities2 & SVGA_CAP2_INTRA_SURFACE_COPY))
 		return -EINVAL;
 
@@ -2909,6 +3076,9 @@ static int vmw_cmd_clear_uav_uint(struct vmw_private *dev_priv,
 	} *cmd = container_of(header, typeof(*cmd), header);
 	struct vmw_resource *ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!has_sm5_context(dev_priv))
 		return -EINVAL;
 
@@ -2928,6 +3098,9 @@ static int vmw_cmd_clear_uav_float(struct vmw_private *dev_priv,
 	} *cmd = container_of(header, typeof(*cmd), header);
 	struct vmw_resource *ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!has_sm5_context(dev_priv))
 		return -EINVAL;
 
@@ -2949,6 +3122,9 @@ static int vmw_cmd_set_uav(struct vmw_private *dev_priv,
 		sizeof(SVGA3dUAViewId);
 	int ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!has_sm5_context(dev_priv))
 		return -EINVAL;
 
@@ -2981,6 +3157,9 @@ static int vmw_cmd_set_cs_uav(struct vmw_private *dev_priv,
 		sizeof(SVGA3dUAViewId);
 	int ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!has_sm5_context(dev_priv))
 		return -EINVAL;
 
@@ -3013,6 +3192,9 @@ static int vmw_cmd_dx_define_streamoutput(struct vmw_private *dev_priv,
 	} *cmd = container_of(header, typeof(*cmd), header);
 	int ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!has_sm5_context(dev_priv))
 		return -EINVAL;
 
@@ -3044,6 +3226,9 @@ static int vmw_cmd_dx_destroy_streamoutput(struct vmw_private *dev_priv,
 		SVGA3dCmdDXDestroyStreamOutput body;
 	} *cmd = container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!ctx_node) {
 		DRM_ERROR("DX Context not set.\n");
 		return -EINVAL;
@@ -3081,6 +3266,9 @@ static int vmw_cmd_dx_bind_streamoutput(struct vmw_private *dev_priv,
 	} *cmd = container_of(header, typeof(*cmd), header);
 	int ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!has_sm5_context(dev_priv))
 		return -EINVAL;
 
@@ -3123,6 +3311,9 @@ static int vmw_cmd_dx_set_streamoutput(struct vmw_private *dev_priv,
 	} *cmd = container_of(header, typeof(*cmd), header);
 	int ret;
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!ctx_node) {
 		DRM_ERROR("DX Context not set.\n");
 		return -EINVAL;
@@ -3175,6 +3366,9 @@ static int vmw_cmd_indexed_instanced_indirect(struct vmw_private *dev_priv,
 		SVGA3dCmdDXDrawIndexedInstancedIndirect body;
 	} *cmd = container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!has_sm5_context(dev_priv))
 		return -EINVAL;
 
@@ -3192,6 +3386,9 @@ static int vmw_cmd_instanced_indirect(struct vmw_private *dev_priv,
 		SVGA3dCmdDXDrawInstancedIndirect body;
 	} *cmd = container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!has_sm5_context(dev_priv))
 		return -EINVAL;
 
@@ -3209,6 +3406,9 @@ static int vmw_cmd_dispatch_indirect(struct vmw_private *dev_priv,
 		SVGA3dCmdDXDispatchIndirect body;
 	} *cmd = container_of(header, typeof(*cmd), header);
 
+	if (!vmw_cmd_body_fits(header, sizeof(cmd->body)))
+		return -EINVAL;
+
 	if (!has_sm5_context(dev_priv))
 		return -EINVAL;
 
-- 
2.53.0

