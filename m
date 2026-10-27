Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135869;
	b=3PCuBfaRzo5Gi2rMh2EDDsrm8wGF5BVOyn/OFnD6pq0LnHiKGGsmEm04vuRifT/MbuJM
	 g/gcDFgFyQDbSPeUkvD8T142idkGPyMHPbRWhAkFzCuecTWKLaHe8bbPtxSWWcWvJvLUG
	 2gI+/zjZSj4I/3OqksAnHNK7uOQM17hkZekOULW4ayiGEr7yOCc7MjE8fUJEKRWWXOjr7
	 F3I8Zy4uO6KRQiK915i5sHEP2gsRFX6MPg+rsADaZOyjVv5r2Gp07zbCXnq+BJ1tkJxbb
	 od+C3B0ESTLxwEgeczTwzysijoB9S4K5RrQWZv3BjIpNdD/tyXO4UzNbBeraWDJ1yww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135869;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Z15Mxl6D/RVXRz+kYS1G8evAgIyEZyDMFRgpwmQMOpU=;
	b=aV4LUBHdJ2JoqZspKjeikEDcyZBsWNEX6e8KAXwik3JsgAjGlmEPR2qS1S62VEDTMlQY
	 1zHQtA4dJOXpOM1idV78aeUqbXqoF71iTritCV0Y+fBsI2WEz0AA7rC4Of7txDSjhHU6L
	 GJ0l8sANzdiOCT9dVwiPwlvliWuC9Vf8T2zOWEaUUMhLBp+8p5YZat8sYYBwCl3hYisvX
	 F04c0hLMfSUoDJ5JhEYL3iFPer9emwBr/GYvaeasySr1HE7T1YgKdMqub9CwrYxIk+ST0
	 pgfvvgXOCjDqP96eFqcoBHwVatJCpkoqnTNQDVXvMCHE6nTQM6SS8o/mJ5kZvMuM1tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KHy6TFN7;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F51F606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F51F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KHy6TFN7
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso158584a12.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135868; x=1793740668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z15Mxl6D/RVXRz+kYS1G8evAgIyEZyDMFRgpwmQMOpU=;
        b=fgyBGC4QF4rVEyBTIiKl0adPoBZSab+FtAtuMVhbl2ZmC9izzBpF6NQY6EiTA6zDib
         DjITbyjQ+KItPBbFq+d9gmFBe3QVt0mA2UySPPWoM8pz227Gn45uhie/8ngrkJbam4Du
         Zi79V2/2zmGJl8Npk+zCs9MD1Z8wdWfWFDViDyUNKa7XoI7WCNWorqt4xnDVNPwl1vmk
         D9IDkMhXlL6Bj31xWZcNl/b0yEBa2n/TU9d7D73S12TeF9HqWgdcO2dGzLNG7gAM3KoH
         j/9J8h08FekU+NH6qVmRox39UBrSovgfMWjoItXrfPtjQeTpv/SUTFTp0aprq9GsAjfb
         bgdA==
X-Forwarded-Encrypted: i=1; AKwUvBymD3yQSz0mvqSGrgsopkmz0MI+5N3B8Sn+nEFLD3TPFzQTYljX8ZE72wRUZ9ey3BpBLQCUDfo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSvJ0vw6J1d5qIGslgRzWTLeHrLseH2Ca8clfLr2VFB4owb3BI
	zppjGIHm2dwEZBpDLh+9vPSqCoYWnA9foi/g/5pDlnFcH95FPbSsttkWpQFjn7zlgmSwZ2yBJiy
	pJpfW7ETnAY4L+FJIrEt70AI/YAT6tqroZI7dBIc0KBwAkqacRNZZZUgmN+yeN2ewUInEEsdMBU
	EXaIOe/GZERwiKeDXu2ld8SPv0di8Gx8NzeTKz09W16GzkZlIi4ZVMeWgHinXajzYDhDZ5cPoxc
	cZ8HBvf
X-Gm-Gg: AYBFou3YpRC7kiArKlFhUby9ug6lpFwdGwVCYUsJhwnMWMra5Z025szz7vYQyO5bCSb
	Ruct3pMvR3ACnrX/qI9yOKSzOrTgrAWyMjp4GRRNOUpiPdhqceqPkQRQ3RtTRyC2OWdVWv9+/js
	Vncf826xRqCSoIeiIgtPB86cbhSCRLy6VxsP8BkOUqVxm5XZyUqUHZqbwF+CFjZ4bZZ7jVQ06AB
	yXHr/7xDTKmTj0vBPAKiP3FOwl6LhFU/1P0raiOTAFQFcLxXhW1vnHzbQGERUMR+enxnYTdNxfL
	D+mQuCkyv8U1Qbqq3yYfJsdq1aACFIzsV15OcgMbqiFDtxJeS/ZJzOIqYS4fpL8DlUxXpNWzTeC
	gAEjsfwDIyj3SC7Y+lIn1/OY0hRzwmu+G5IlCmQSBiGJaxW+p9TGsHoQfggUIW3FwYg4UbXT1/u
	J8FFDFTWlAdfgxFHF1ugEHP7mCilxUcEN7
X-Received: by 2002:a17:90b:562e:b0:3ac:9ed8:f30d with SMTP id 98e67ed59e1d1-3ae580de136mr225042a91.39.1793135867571;
        Tue, 27 Oct 2026 14:17:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae55a7b970sm220921a91.0.2026.10.27.14.17.47
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:17:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36637676140so400707eec.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793135866; x=1793740666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z15Mxl6D/RVXRz+kYS1G8evAgIyEZyDMFRgpwmQMOpU=;
        b=KHy6TFN7QCpAekGxkJe/HRMXV6KAOg5EqouvOCgBiubXGMtNj1Wlk7qj9wYkoOC09B
         SvqD9ODCYsNyiSmeXaRKlAFpOi4E2eYRfplFiexdSgpRUVwj53t0S6qOYUdL+PNhSpLK
         btFrG3U7+M9CNol8EzdWzxbv8lG9mq2JqBkfc=
X-Forwarded-Encrypted: i=1; AKwUvBwOdtJquaLEJYPukXO+zjPiuJhxfQIpKe7PaHkClnOezzsIQxn8ISlYxXMKIj1WDubaAiO7Cl0=@vger.kernel.org
X-Received: by 2002:a05:7300:d088:b0:36a:238:1485 with SMTP id 5a478bee46e88-36a2016f3d3mr897562eec.37.1793135865592;
        Tue, 27 Oct 2026 14:17:45 -0700 (PDT)
X-Received: by 2002:a05:7300:d088:b0:36a:238:1485 with SMTP id 5a478bee46e88-36a2016f3d3mr897525eec.37.1793135864781;
        Tue, 27 Oct 2026 14:17:44 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:17:43 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	yunfeng.li.nb@gmail.com,
	tomas@slax.org,
	stable@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH 3/6] drm/vmwgfx: include legacy hotspots in GB-only cursor images
Date: Tue, 27 Oct 2026 17:17:26 -0400
Message-ID: <20261027211729.646988-4-zack.rusin@broadcom.com>
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

From: Tomas M <tomas@slax.org>

The guest-backed cursor path without cursor MOB support defines the image
using only the hotspot from the plane state. Its position calculation
also includes the legacy hotspot supplied through DRM_VMW_CURSOR_BYPASS.

Xorg's xf86-video-vmware driver supplies its hotspot through that ioctl
and loads the image with drmModeSetCursor(), which does not set a plane
hotspot. The mismatched image and position hotspots displace the visible
cursor by the legacy offset.

Use the combined hotspot for both the GB-only image command and cursor
position, matching the legacy and MOB image paths.

Fixes: eef295a85082 ("drm/vmwgfx: Restore Guest-Backed only cursor plane support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tomas M <tomas@slax.org>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index 14490ead99cd..f0661e5effeb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -852,6 +852,10 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
+	/* Include legacy Xorg cursor-bypass offsets in the image and position. */
+	hotspot_x = vps->cursor.legacy.hotspot_x + new_state->hotspot_x;
+	hotspot_y = vps->cursor.legacy.hotspot_y + new_state->hotspot_y;
+
 	switch (vps->cursor.update_type) {
 	case VMW_CURSOR_UPDATE_LEGACY:
 		vmw_cursor_plane_update_legacy(dev_priv, vps);
@@ -864,8 +868,7 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 			vmw_send_define_cursor_cmd(dev_priv, vps->cursor.map.virtual,
 						   vps->base.crtc_w,
 						   vps->base.crtc_h,
-						   vps->base.hotspot_x,
-						   vps->base.hotspot_y);
+						   hotspot_x, hotspot_y);
 		break;
 	case VMW_CURSOR_UPDATE_NONE:
 		/* do nothing */
@@ -878,9 +881,6 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 	cursor_x = new_state->crtc_x + du->set_gui_x;
 	cursor_y = new_state->crtc_y + du->set_gui_y;
 
-	hotspot_x = vps->cursor.legacy.hotspot_x + new_state->hotspot_x;
-	hotspot_y = vps->cursor.legacy.hotspot_y + new_state->hotspot_y;
-
 	vmw_cursor_update_position(dev_priv, true, cursor_x + hotspot_x,
 				   cursor_y + hotspot_y);
 }
-- 
2.53.0

