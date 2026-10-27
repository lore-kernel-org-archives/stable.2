Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135873;
	b=i2e+bV1CjgdRPjuCl8TlK5oGAVKBzteGAncu1fjoHDw1RL0t9SN1bYVtlVGp5PYHLKpL
	 D8Z5v7qGfH0EBM8IwJalVMSquKeh3rWJtft+hgMdZdJBkKaz3oNRyFyX+4A+tO4fXkErC
	 cY9SetFWe6g5fqZgBT6iPFgFs2jvK7+0Hipzvh2mD1yWCk2Ytafj0xxNTGLKr1sSWtsI2
	 uhZcHizvCvc2aWVTR06SKonJ37nM7tL0UPERl6qUoSvfyRE+inmmGpnCU17k4ay+xOENO
	 xqEe6Ky6BjT8O84TYVzi2cdGK+W/DWSLQ+4At80SAExNxP+JRJTlohGhcbjrhZSsW5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135873;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=01NOpgHWVqQgjTNsBgGAKMr4sobRWIoGGoSOs/pmDn8=;
	b=fn0OGccUUuOGGujrV2NOhrKQWaz/DLnBxtBT7Z2punLWX8Wc/kg0U4HgY+UACVSi9hfA
	 wrZcaLDMEbHnkmIYfJR4xML94HSSn9qaUmWpy+9Gy6Vq8vZw3IsRg8dhHM5jQp2qv2TBy
	 nsG+oPLX2/padk4T5qfDs6YPYoXXTJFyfysL7zaU0LLgTdeWz5x+vPfvhjgQheCjDyLTt
	 k0JQCtNrNR6VVpDxgDMi0W/N4GgOlEska2Ix+boJ9mjMKXanNaDjSQ7ZoWH2zkksCj7sM
	 PTe1gonoQYRE5bAT8/E5K4ou3r/wy8ILtqlGeNm7DS2H41uE029ifdbtgT1uB60hSxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MAkCgpWT;
	arc=none smtp.remote-ip=209.85.219.99
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B422606A320
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B422606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MAkCgpWT
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-91bb5795792so3754866d6.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135872; x=1793740672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=01NOpgHWVqQgjTNsBgGAKMr4sobRWIoGGoSOs/pmDn8=;
        b=AIxlObTjA+vzmrAs7KTrSQFe8snpAJV7VvRrYSXL8qZ5DiPtUf2svMVmuZ9ekKrsvv
         I26rcjC3pxb51uzcoX+hwbkfVtqRwc3NwYYgdn0zsBqCqIwfPegTmf7qGfYHJbPMbQqP
         LlDyyhkvrguasJxs1Apag6cgKG6zkUlSZVHTCwKNhQfRqwDuSNEjgqzJ+/+HjKyk4tKk
         n78wT6lOslhoSvA5+W/OvhnXfeE23rVxVGfxH6f2D0s4I4cNjNlxwn8QEKKs/5tE4QoT
         XPDnvrwVOKsr2/C3Qjw68wCenD4JjgPdC2eFGWulxg1pku+tNceieVA6bJ/We12cC6b5
         J+WQ==
X-Forwarded-Encrypted: i=1; AKwUvBwx2dk6HdaHqEEBj1jngPZpRBgEe1BLGDhkMCHqugEvCB081hIUMfdvhPLJN3aEqXPoz4gZ/LA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVD4r+ilzhTlcnE/Q0Gym/eSQHON2J9abAAJ4OPoLvXt0KaT/Z
	Sg+4dFA5LyQ/Tn6JQOiIO+BYrPMjumPv/q9EKpSY09nnXU+xcTAr2s9GU0xMT3I+LvxA6szRTg2
	L7073XERhzqNCc8lhy4FQHjzjFAlYCd3DyMACI8lsSnK9KWS5bAeSIu2pUcZD9p7LumpE7qPocP
	rpaqPZCKkaDWCsncIRMTjz7/tuqw3lMnj8Rp5losHloI1PY0rkhn2jNzCFD5f3t7Zebj8HtY4HS
	n3RFD7v
X-Gm-Gg: AYBFou1cJ84iJtjSrOhMh5dRV1hQeC1/JFRIBxKNWufsDaOgOtXbd4auZCK50eoVQlP
	cJuU5fbVoRdDjiV6/IdomYbVRwwXqLgjiOuiE5nSZ8a6LhxS/mxHykhViNwbEVZvR1c4m3ZgQqr
	JiBotS/2r4OmWBNhp3HQgUC17C6QBNdxrM7dIA1nIb1XNHEL06zFrPtiwVoyb8M6Htpzt9lBhOl
	4jU1EDLIRDGRA/jIE++eotT9QLdVRUdGF4Zv5NZBhP6RdlTDFvc3g9Jycxy/oPoYRKRiU5ZVrU/
	99UBCVpHt2b8ui6O+M7QNrW2l+fBW5TJ84rC61ngxccWjo60/H7JuzRUROCQY1sWzn0cvVOyijg
	tiBL1Xkt2MbVTCZhZXdfrH3qc/2GYTcc0GeD10jLPP/2h6OmwcASzlby7VxeMBxalJQcXyv7fCg
	xuBGpqs+fBCV5iZmZsW+WfSKQ/+N6Yvn543ZY=
X-Received: by 2002:a05:620a:45a6:b0:944:6d8:9c52 with SMTP id af79cd13be357-94408a9763amr33492685a.57.1793135872203;
        Tue, 27 Oct 2026 14:17:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-940f05b2712sm156551885a.1.2026.10.27.14.17.51
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:17:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so498976eec.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793135870; x=1793740670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=01NOpgHWVqQgjTNsBgGAKMr4sobRWIoGGoSOs/pmDn8=;
        b=MAkCgpWTppVmiSey3zGWXqcbwrNpkGQxsJEbgzXDi1dwInHQE9k0pOYrOQXGQsKlF0
         ROLfIZ7tF/MKr3QlL9uPI9T/wzG7JwLxI+IgD8xjq2TGwS2VgWG0Th7QlOk+iVjHEvvY
         GFKu+9Kc4AYw4CdfBltoeKtyw5hO4oml34oG0=
X-Forwarded-Encrypted: i=1; AKwUvBw9j9cwMwJ1lmiDUCwB7zV4ERoW1+UpbHUA+LUIccjihkOFYjDTOAn26LimftdV+KTXhiDC19w=@vger.kernel.org
X-Received: by 2002:a05:693c:2a17:b0:36a:1bac:6bf4 with SMTP id 5a478bee46e88-36a2039cb09mr850549eec.18.1793135870329;
        Tue, 27 Oct 2026 14:17:50 -0700 (PDT)
X-Received: by 2002:a05:693c:2a17:b0:36a:1bac:6bf4 with SMTP id 5a478bee46e88-36a2039cb09mr850515eec.18.1793135869562;
        Tue, 27 Oct 2026 14:17:49 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:17:48 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	yunfeng.li.nb@gmail.com,
	tomas@slax.org,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/6] drm/vmwgfx: validate the framebuffer selected for cursor updates
Date: Tue, 27 Oct 2026 17:17:28 -0400
Message-ID: <20261027211729.646988-6-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027211729.646988-1-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
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

Cursor atomic checks select an update path and look up surfaces through
vps->uo. That object is copied from the previous plane state and is only
replaced with the new framebuffer's object in prepare_fb(). Switching
between snooped surfaces and buffer objects therefore applies the old
framebuffer's cursor limits to the new image.

KMS clients can also submit a guest-backed surface without a backing BO.
The check accepts it, but the MOB update later copies from a NULL source.
Zero-sized MOB images pass the check as well, then fail preparation when
mapping zero pages, so TEST_ONLY accepts a commit that cannot succeed.

Resolve the user object directly from the selected framebuffer in both
validation and preparation. Apply the matching cursor limits, reject
zero dimensions and require a backing BO for GB-only and MOB images.
Recheck the backing BO in preparation before mapping it, while keeping
snooped surfaces independent of a BO mapping.

Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 61 ++++++++++++++------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index f0661e5effeb..9e8ea9e07f40 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -89,10 +89,26 @@ vmw_cursor_plane_update_legacy(struct vmw_private *vmw,
 	}
 }
 
-static enum vmw_cursor_update_type
-vmw_cursor_update_type(struct vmw_private *vmw, struct vmw_plane_state *vps)
+static struct vmw_user_object
+vmw_cursor_plane_user_object(struct drm_framebuffer *fb)
 {
-	struct vmw_surface *surface = vmw_user_object_surface(&vps->uo);
+	struct vmw_user_object uo = { 0 };
+
+	if (!fb)
+		return uo;
+
+	if (vmw_framebuffer_to_vfb(fb)->bo)
+		uo.buffer = vmw_framebuffer_to_vfbd(fb)->buffer;
+	else
+		uo = vmw_framebuffer_to_vfbs(fb)->uo;
+
+	return uo;
+}
+
+static enum vmw_cursor_update_type
+vmw_cursor_update_type(struct vmw_private *vmw, struct vmw_user_object *uo)
+{
+	struct vmw_surface *surface = vmw_user_object_surface(uo);
 
 	if (surface && surface->snooper.image)
 		return VMW_CURSOR_UPDATE_LEGACY;
@@ -642,17 +658,10 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 	if (!vmw_user_object_is_null(&vps->uo))
 		vmw_user_object_unref(&vps->uo);
 
-	if (fb) {
-		if (vmw_framebuffer_to_vfb(fb)->bo) {
-			vps->uo.buffer = vmw_framebuffer_to_vfbd(fb)->buffer;
-			vps->uo.surface = NULL;
-		} else {
-			memcpy(&vps->uo, &vmw_framebuffer_to_vfbs(fb)->uo, sizeof(vps->uo));
-		}
-		vmw_user_object_ref(&vps->uo);
-	}
+	vps->uo = vmw_cursor_plane_user_object(fb);
+	vmw_user_object_ref(&vps->uo);
 
-	vps->cursor.update_type = vmw_cursor_update_type(vmw, vps);
+	vps->cursor.update_type = vmw_cursor_update_type(vmw, &vps->uo);
 	switch (vps->cursor.update_type) {
 	case VMW_CURSOR_UPDATE_LEGACY:
 		surface = vmw_user_object_surface(&vps->uo);
@@ -662,6 +671,9 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 	case VMW_CURSOR_UPDATE_GB_ONLY:
 	case VMW_CURSOR_UPDATE_MOB: {
 		bo = vmw_user_object_buffer(&vps->uo);
+		if (fb && !bo)
+			return -EINVAL;
+
 		if (bo) {
 			struct ttm_operation_ctx ctx = { false, false };
 			size_t size = (size_t)new_state->crtc_w *
@@ -744,7 +756,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 	int ret = 0;
 	struct drm_crtc_state *crtc_state = NULL;
 	struct vmw_surface *surface = NULL;
-	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
+	struct vmw_user_object uo;
 	enum vmw_cursor_update_type update_type;
 	struct drm_framebuffer *fb = new_state->fb;
 
@@ -763,7 +775,21 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 	if (!fb)
 		return 0;
 
-	update_type = vmw_cursor_update_type(vmw, vps);
+	if (!new_state->crtc_w || !new_state->crtc_h) {
+		drm_dbg_kms(&vmw->drm,
+			    "Cursor dimensions (%u, %u) must be nonzero\n",
+			    new_state->crtc_w, new_state->crtc_h);
+		return -EINVAL;
+	}
+
+	/* The duplicated plane state's user object still belongs to the old FB. */
+	uo = vmw_cursor_plane_user_object(fb);
+	update_type = vmw_cursor_update_type(vmw, &uo);
+	if ((update_type == VMW_CURSOR_UPDATE_GB_ONLY ||
+	     update_type == VMW_CURSOR_UPDATE_MOB) &&
+	    !vmw_user_object_buffer(&uo))
+		return -EINVAL;
+
 	if (update_type == VMW_CURSOR_UPDATE_LEGACY) {
 		if (new_state->crtc_w != VMW_CURSOR_SNOOP_WIDTH ||
 		    new_state->crtc_h != VMW_CURSOR_SNOOP_HEIGHT) {
@@ -772,7 +798,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 				 new_state->crtc_w, new_state->crtc_h);
 			return -EINVAL;
 		}
-		surface = vmw_user_object_surface(&vps->uo);
+		surface = vmw_user_object_surface(&uo);
 		if (!surface || !surface->snooper.image) {
 			drm_warn(&vmw->drm,
 				 "surface not suitable for cursor\n");
@@ -789,8 +815,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 					 SVGA_CB_MAX_COMMAND_SIZE -
 					 sizeof(struct vmw_svga_fifo_cmd_define_cursor));
 
-		if (!new_state->crtc_w || !new_state->crtc_h ||
-		    new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
+		if (new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
 		    new_state->crtc_h > SVGA_MAX_CURSOR_CMD_DIMENSION ||
 		    image_size > max_size) {
 			drm_dbg_kms(&vmw->drm,
-- 
2.53.0

