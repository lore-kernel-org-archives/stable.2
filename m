Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506078;
	b=CfpIdlUqqh+zlstgVe7c0ZBzcFmtulwr2tIPy7ME98f5SL0X+EnTFQ0AMzL6vPKfmTTD
	 PXWwBbsIUg3LveNWkPjJMqlwc7u6pftyTfluVbvD+95KcT/vKMqZphybvf163VatlurlB
	 QD7VkQjEhhjHa++Kd7s4HiRhHzi+0y0/6uqqMbb2wY3AItdnbTCtT22WtJBSHkxWUspd6
	 JuLPmlnusqFewCrzw841u7lme12NiGBKASDT0QC6n88jCj46ICy4GNaw0cO0LYPU5ppvt
	 BuyL6BB8rDLCsxHuNodRVCk4p1NRWel55VMSZQSnvWOO5oXHM6ArvxZRfpz/MfvTvjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=74TXVSiLNJEh4EdaGe7nzkm4UiqpR2QLi5goWWiHysE=;
	b=MU9l+V6Es92paHQSHKQhS0HUmR9OVTFeOUC7NwNKXykiBP3YkJv+R/2lV+W+Z3lQHWK7
	 OakbI1VJ09FLjLg++ggFxnTcEMVxZGTk7RBjfUJ6qSL0BD6fT8274ra2a08hakA3rP/lY
	 Si5+5A//HLLkShNtNwvoqzPtzlkoFtKhGwUPmAIcsq/193gKsmlFWG/x20sE1nnygSdBM
	 kExvAfzsAF+seKc9cJF0Qe7txfPp2GSphOOWTPhmE2IAcoRBNZaHZHDcMm0ysN1VdEvAs
	 Kql/POjirZbcE8P4XMh1M7w7pfyVo2ZUdbw/HBArSXyoEE3lrve684arKsAJsBLG39Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CN9Vv02r;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2AA606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B2AA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CN9Vv02r
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1628454a12.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 23:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795506077; x=1796110877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=74TXVSiLNJEh4EdaGe7nzkm4UiqpR2QLi5goWWiHysE=;
        b=CN9Vv02r05Mz/TSWqNI7Oyvwf0XCyVFM5ONbC4kPbLVaFolWLbn3Jft+H+eaVG2Pau
         H/dn7qS23EnetP+fSAD8D+TS7oR+cwN4mRDyxuKJVnLbY9tiZMprtJc03PGuAa1oJgzQ
         rwSTReb4JRcF9sDjwcnB/iSjmppfa2Bgogbgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795506077; x=1796110877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=74TXVSiLNJEh4EdaGe7nzkm4UiqpR2QLi5goWWiHysE=;
        b=aAk6yD8YqQAQ0J2hVIyjP2yYbzoWOvHe9DvzRCyDeOeY7r+zEK6c8dCOOFYa8Nm3eK
         xIBPhQM7y/yYim1aONrwIfDpQb0QEs64d5Kk/qBhDBmAnuntV8PLRWfxSR5VUYxyJ6Eb
         u36M9EQU/uRP6IqSqXGa77PvDTFet3B4fmEcNT2BBzN18skkPJ6sJaIOweKr51Eq5KAL
         QgiU/+jozfe/05mBhKQx2wup0fd4sNOj6ood1bFvKIKN9LOml7O3e9MnkN4MdvdJphD2
         ZPQMwo5I9kiszvhqh4yAf5Z3gpTMFvb0B2ZHof+MJ8Gi6eYrARcahkQirAm+u1rKVCnh
         DGdg==
X-Forwarded-Encrypted: i=1; AL+hErGpsPhBSFNdNYMBV5J99WmHY9cS6KRShwdIAtL6S9AhBwtL7izpAyJfErFwpvmOGp2juBXt5nQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oQVURFrYnFASlqpUlpee5V06B2O9q+T+4wlgm4f2ZouEDjEFA
	DXG+fNR8VhPXzB/ParD3ycaFbIeMDQTx+aUU7bjyL6z8r5jLXVLelHxAvThDeXrolQ==
X-Gm-Gg: AZFdTZc/jZH4cgbjxnTglYL0EBj7TWBia1wwOsoitE3S04gbUV6Xh0PRBj7ox7ZEAPy
	EoqcpcooSV3N6CwISTGuX0Hyqc9m47gjBdfOaCcN6yqoWVB003IPIdRgS3R6M3WyOwqXhjIvd4V
	F5wcxCBsoQP+UQw142KC3+Q7Yx75o58vZ9Z9j97cu9/ZvP+jqfZKmxycCb2OambASZ2Y1f9wF6x
	WOrNpyx4w2y6h8CR7pJWO1FUEpclSU6cRsPA7coJ0o92Z7AByZ3EB/FK47d/AQHCkK+1r0WmDmm
	3sUuFSNOYAel3My9Knt6dm6IstK+7c+9QI7uSpXLqMGPy6QuG1C27qpSu5RrCA++n2DyzR8Glax
	DbAE30US31zCkeqkD2KpahrKQ63NI/wRUEm3uX+1eJ1OEsmo0mtget+UvX70De3/URwDWd2axf0
	JQxytCrMDoQm/Gv+tA+q005Jn8a3rWK78/Zts3wzkNf7mN5IYMYq/OuYHko33ZYgLHpBoQZZmOL
	3ip5gpCf2IHSjQQJ7/XHMAqY04UkayAnwZUAVMy+aXQhdCicg1ee2Vu0l6KKvL2dalsXCwElpRN
	At5bamvNL2o/rm9RWchOwpMELywVsUtUEbKHb3trGS2sDt8AlaY1SbXGuFOz
X-Received: by 2002:a17:90b:3d90:b0:3b3:ff70:4d0d with SMTP id 98e67ed59e1d1-3b41c8d49b7mr11902997a91.14.1795506076825;
        Mon, 23 Nov 2026 23:41:16 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:8f32:8910:4727:ea03])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b44b7a8c64sm9100767a91.3.2026.11.23.23.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 23:41:16 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liu Ying <victor.liu@nxp.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-sunxi@lists.linux.dev,
	imx@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RFT v3 4/5] drm/imx/dc: plane: Switch to drm_fb_dma_get_gem_clipped_addr()
Date: Tue, 24 Nov 2026 15:39:32 +0800
Message-ID: <20261124074041.115251-5-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124074041.115251-1-wenst@chromium.org>
References: <20261124074041.115251-1-wenst@chromium.org>
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

The hardware is programmed with clipped source and destination dimensions,
but the framebuffer address is calculated using drm_fb_dma_get_gem_addr(),
which uses the full source dimensions. This will not match the source
offset if the top and/or left sides are clipped.

Switch to the new drm_fb_dma_get_gem_clipped_addr(), which provides the
buffer address starting at the clipped boundary.

Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
Cc: <stable@vger.kernel.org> # Needs drm_fb_dma_get_gem_clipped_addr()
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/imx/dc/dc-plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/dc-plane.c
index 62dd0576fadc..35eb5039f5ac 100644
--- a/drivers/gpu/drm/imx/dc/dc-plane.c
+++ b/drivers/gpu/drm/imx/dc/dc-plane.c
@@ -65,7 +65,7 @@ static int dc_plane_check_max_source_resolution(struct drm_plane_state *state)
 static int dc_plane_check_fb(struct drm_plane_state *state)
 {
 	struct drm_framebuffer *fb = state->fb;
-	dma_addr_t baseaddr = drm_fb_dma_get_gem_addr(fb, state, 0);
+	dma_addr_t baseaddr = drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
 
 	/* base address alignment */
 	if (baseaddr & 0x3) {
@@ -146,7 +146,7 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 	src_w = drm_rect_width(&new_state->src) >> 16;
 	src_h = drm_rect_height(&new_state->src) >> 16;
 
-	baseaddr = drm_fb_dma_get_gem_addr(fb, new_state, 0);
+	baseaddr = drm_fb_dma_get_gem_clipped_addr(fb, new_state, 0);
 
 	fu_ops = dc_fu_get_ops(dplane->fu);
 
-- 
2.56.1.809.ga0b61035b5-goog

