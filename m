Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135866;
	b=HHMBSBsHSVXSxQO3mvOj3hPFGx+mTVYV0yAyhdDUhwd94Tx9DM2UkOsea1zE/r18Hs31
	 xZniouWS1kBMZ9PG/9aw5jXRy16oUu3eChoywvOokpQjdEh4gxEqq4xHxyeN5XDnIbAEE
	 6qDSxCSD5g5yTxByEc0/WOGefhM5qYXQghBhKbHV2AEwhkW/GrDcihH2ip/EMcICbfF70
	 WZfGKRYS1KlCBQ34Ge2s0DoIKw43eq0lszGItzzHIcMWWLHIsVqy7HTBjT3zVityzaMat
	 lCOVPNDUx9vc4WDp5+f0xRy9YRS7OAnVr/IZ2fbxgAjdl7/2vduK2hFu2DcvQqcanAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135866;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=VhwStqBc0JsG88BacH2y24XzBET34vQRSMUTxkJ0j4g=;
	b=LrGqJoE5Gnel/rHKmiST0cB4xLtPO97YebtGFKTAFbokftCThYry6oGL6K7EPgcXCJlc
	 maw0r3yez87sBFojMFmZw9W3UNzVhpMYU3vjSa+7whJLNI3lHVOXIJCPyQEylznO7I1ez
	 z50nivQU9zz68zNT/i2V0egOKvB26+zJxJdhPDIorRwG9H3Qs77dDzMbES1P+I2ZY6F81
	 p2itkucO4pgutTVcm/CdQ9m6k3UVb6lmc6JiHuNC6p3oRf5P/eR5wLStvcxnNgUgzs8so
	 jOSExCpi1A6Ugv2zK8Qf3Y8xCvydR+FtqtQAKg8rCZQoXpxyJS6gvqDfX++ffzcNt4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=QD668nKQ;
	arc=none smtp.remote-ip=209.85.161.97
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA75606A322
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EA75606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=QD668nKQ
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-6d7e06dbcccso280933eaf.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135865; x=1793740665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VhwStqBc0JsG88BacH2y24XzBET34vQRSMUTxkJ0j4g=;
        b=sBqHUOe+lFjO75S2PKLYjQ6K4OUdWw1QN5qaAfWBh/7rhfE+Ge5PbSUZ5xtsuRaM7h
         NySF0KG1M1tf84pVo44JEqddPOLepGwA5qdg53nCf992JwrbVP7/N5hI6z72QzjyGT5O
         7fDSSAodcmKAj+EFRHnIgirGZcJxY+x0TP6oCHNbXwGlN5Ofwdy8HmsO5ZI+ekXhByqs
         AqNeT2pJl17LXabe5skffb70USPuL6TlrcvNUhMO5gqfKbg/3DBI3w+VQBEEnJYqCXrT
         +Y1lxga/rKCgYkbhQESw15v+YJdGhFEbLRnDZURfrXrTV5lrKMZMPHX1Wx5Nl0F/rwwl
         vd0A==
X-Forwarded-Encrypted: i=1; AKwUvBxeGXfgcs9ytYPebREO9MMdVpLM8BhlCcDJgbO4gFOmY2HZ8WBSnwo2jUtghePYa1ClPGg7kFE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLls2RHyP+ciFtckZNWFTs1BeobNdmX7BXHuaYC3rflR6CKtf3q
	dPbtgZ8LRIVjhtJTWhi/8pZjEOkcWKfv0qRb19yLtP9c2EGpq5QXvXTsSgLfkk2zOd80UIWbnyJ
	Tr7IdLBI2mhueQVrQF3XLh0WCxyCNqhHF0swgrLFE+4LFJRDNFMMEaaaRIRtIcSrHNTMwh3sZU0
	6G747qPbDzUHrAiFcHmxHVoNzs15f/YzcfFDjEslkfZmt5/hfNEJgwj6zlt+MDugRuy+DKfx6o4
	/e1DPPw
X-Gm-Gg: AYBFou06D7j3DWoTn94Rf5PS6gz6wYDwjFrCaAszby8dgOPF2ahLERUUyRCaY1M2osX
	QxWD6FIaot/Lf0SD5Zj5wqIzEJh0jSKD7GnM59xwnZC4Qg3bHLzAxoTwMnuR0UDHsYbxwZicK+2
	2jeqjJECrknYEjrqcFJhguN6CGv/8hdQMOxVMFdlahp331miPtOEYo1Xjq6a0bosZn3P5uPxb0f
	bHCGRxJf2cywgFagZD4Yw+LrjoFcx6+RbOLDMtmpIcL4Y9aNofLlSZAP/cZLCqYdRcPM7PLWPoB
	HHU3KxEKi7p8qebQxHVXUwwNfqS7j6CNDQrxqoqYGdrt41xj58P3eP8U6JRyGHU/a8QW7gCHoVI
	QhegodJgZR+pUSugWAAXdFXHV+L2mRNBcTjUpYPvhQoUoZk6aYL5WdVFtYYF3t8KZzqwWpaHtfw
	wQckS2/0PHP6jfpDnhFGQNxep0338UAKgZ
X-Received: by 2002:a05:6820:4606:b0:70d:9d05:dac with SMTP id 006d021491bc7-713eeb52434mr194660eaf.58.1793135865303;
        Tue, 27 Oct 2026 14:17:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-70b9e01f523sm113568eaf.23.2026.10.27.14.17.43
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:17:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3552883bd19so1025784eec.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793135863; x=1793740663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VhwStqBc0JsG88BacH2y24XzBET34vQRSMUTxkJ0j4g=;
        b=QD668nKQEADxI5DBhpO4SCjw2HbCaqMeFX8h3ydhmTK27yqD8OUXs7vn3cFMLqExct
         FbiTtI3ppUiWdHW4q0YZG9dYpeIQKOkeeekdTH8kXGYZkKqNkicAHUDx9RmeJ3JmqxoA
         GosQYLH2h3Y1ewNXHi3KGOPCspXBWzIj6+Pww=
X-Forwarded-Encrypted: i=1; AKwUvByoCZHhnoEiOLI11Q7jEmxRf5OUuvMJbjzVGGfVA/kyvQ0vTbhNXmYN65N+QWRM68Nba2Ibzxo=@vger.kernel.org
X-Received: by 2002:a05:7301:78c8:b0:366:dbf9:32bd with SMTP id 5a478bee46e88-36a20406fcemr723442eec.9.1793135862591;
        Tue, 27 Oct 2026 14:17:42 -0700 (PDT)
X-Received: by 2002:a05:7301:78c8:b0:366:dbf9:32bd with SMTP id 5a478bee46e88-36a20406fcemr723426eec.9.1793135861976;
        Tue, 27 Oct 2026 14:17:41 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:17:41 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	yunfeng.li.nb@gmail.com,
	tomas@slax.org,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/6] drm/vmwgfx: validate GB-only cursor command limits
Date: Tue, 27 Oct 2026 17:17:25 -0400
Message-ID: <20261027211729.646988-3-zack.rusin@broadcom.com>
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

Guest-backed devices without cursor MOB support define cursor images with
SVGA_CMD_DEFINE_ALPHA_CURSOR. SVGA_REG_CURSOR_MAX_DIMENSION belongs to the
cursor MOB register class and reads as zero on devices that do not expose
that class. Applying this register to GB-only cursors rejects every
nonempty image submitted by KMS clients, leaving Xorg without a hardware
cursor.

The submission transport also limits the command size. A 96x96 image fits
the 40 KiB FIFO image limit, but exceeds the 32 KiB command-buffer limit
and causes a device command error when submitted through that transport.

Validate GB-only images against SVGA_MAX_CURSOR_CMD_DIMENSION and
SVGA_MAX_CURSOR_CMD_BYTES. For command-buffer submission, also bound the
whole command by SVGA_CB_MAX_COMMAND_SIZE, including its header. Calculate
the image byte count in 64 bits and keep the register-based dimension and
MOB size checks for MOB cursors.

Fixes: d5ed8749168a ("drm/vmwgfx: enforce cursor size limits for MOB cursors")
Cc: stable@vger.kernel.org
Reported-by: Yunfeng Li <yunfeng.li.nb@gmail.com>
Closes: https://patch.msgid.link/20260830151619.2452307-1-yunfeng.li.nb@gmail.com
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index 942d07079ef7..14490ead99cd 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -778,8 +778,27 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 				 "surface not suitable for cursor\n");
 			return -EINVAL;
 		}
-	} else if (update_type == VMW_CURSOR_UPDATE_GB_ONLY ||
-		   update_type == VMW_CURSOR_UPDATE_MOB) {
+	} else if (update_type == VMW_CURSOR_UPDATE_GB_ONLY) {
+		u64 image_size = (u64)new_state->crtc_w *
+				 new_state->crtc_h * sizeof(u32);
+		u32 max_size = SVGA_MAX_CURSOR_CMD_BYTES;
+
+		/* The command-buffer limit includes the define-cursor header. */
+		if (vmw->cman)
+			max_size = min_t(u32, max_size,
+					 SVGA_CB_MAX_COMMAND_SIZE -
+					 sizeof(struct vmw_svga_fifo_cmd_define_cursor));
+
+		if (!new_state->crtc_w || !new_state->crtc_h ||
+		    new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
+		    new_state->crtc_h > SVGA_MAX_CURSOR_CMD_DIMENSION ||
+		    image_size > max_size) {
+			drm_dbg_kms(&vmw->drm,
+				    "Cursor dimensions (%u, %u) violate command limits\n",
+				    new_state->crtc_w, new_state->crtc_h);
+			return -EINVAL;
+		}
+	} else if (update_type == VMW_CURSOR_UPDATE_MOB) {
 		u32 cursor_max_dim =
 			vmw_read(vmw, SVGA_REG_CURSOR_MAX_DIMENSION);
 
-- 
2.53.0

