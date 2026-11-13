Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587959;
	b=RdetZuwSd0y0WAWsg7ql7jDKkbIX3cAMPgQLDDBYtgjHxO1NTXi+eyPK4eEq2YpeNXoc
	 eU/X8AjPgweWkSLsP83UvMBed1icjT96i0fiQEuycfKgA0CIduX2nj7bxI8TzA8cxSMXs
	 yZxkri92yo0AKTWTAJi7odhW6qAihMgoStnFhIFJ7nWO4sqUEKa7amy4WkN7HL0v1BPMc
	 6opBHBMugpsG1J4J5UlCT42NkFb9ZgWVy+cINyHz1PJeqLZkpc0nGYpRBKzXApy8ZFISb
	 7ir4xAqXHia27pV40STmBwRDH4ZmdKBmeFyxQstOJQzRjAifHPudq0aa16LCSNnA3kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587959;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7zpkorwus004YyxUUcOl7JyvlAtNECWRC9I0Q9NEaTU=;
	b=yNjETxjY81v6jYIEyaJHQX2xcCs8EA+/VWAZ/S7m68imCF/dne4z7t3VOR20wpqE/QwL
	 L1cDHmMbnfKTTk5vqRx+YjHDhKmLvMJwTnmqIzR1EbhQEtvj3t7a3mdiWKbydCBvakDm0
	 byEyhBR+59gQfVuCKzPyqLGZdieZCc7xPuQrJOIvxAtfPwGgJ1GwApjqeyn5oPetk999Z
	 5Ke+ld7MyEqHR+b2O4WjqvJGWKHAhke7pw+2rSzP1HSYAqCa4dOwu9Rw69e7fCYXkve1+
	 nt5G796JsrEf+ArXCrvb3RU6NIT7sZGGBzF1O4BmeJZUfSu8hylesm4wM1NMr23zIlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liHHypdb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275C606A8B0;
	Fri, 13 Nov 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liHHypdb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794587959;
	b=pxtisLY8NTsy762MMvDnwTI14w3Pa53mGQZFD7Ekk3H27zeE3BCWVAVn404Q9by1+zL1
	 pP7XLxOCxZB2nUIeAUoe1uaYhSwAP7BYXKwo3LN3vYEUAeU6qABvjbKnXwVFPcz8e5sDs
	 wtTn/KLe3wJ31zsZJ4WK7EmxSDJ7hbdX2gL+ZLwr7RS8TBXVrQ4jRw/bBrjD2A2XithbG
	 NqZ41K3V4hOeEd11sYjXwOkrO/fKNriHcKgMNo8wmGbrNHKqzCfrYrTTSDFGYT0Kr3UkK
	 +uabgI0zRZXiXUzpxZTRMIQodeGsf828ToecN3Ovd6WW9IKExuBmYawVuAqIxrD5wBQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587959;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7zpkorwus004YyxUUcOl7JyvlAtNECWRC9I0Q9NEaTU=;
	b=L5DDuBqwUf1gjAJhzQ9JjcpTiarLCAljJBh2vjfVvkIdQawNZoDMchJKBZwX9TB0GtF/
	 jMWchb2ViMHlQuUbrNnVUxND8yeqD7SuLNixQaU0L8s9I1YTa+IdbCaUJtZjnFgXV7n0R
	 NrV+7trpbUp0NSAQ/1t9bsN7SbLgw1DU1u1sPiqgIp88x4hXOKsSM1Hacm3RsWOH1xnGQ
	 PulSYHp78VSK9R8yLL4OtYukOvyZuv+f3G8K7wW08O0bgc8UlT3+yE/PvbpvamMI/7ETn
	 SFJUW2127vB3TzkZZzuzKCUCTbfD2QRLHe5W8DutmrmAmjOeReBq4jo5vNweTMJVdjQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E4D5B1F000C7;
	Fri, 13 Nov 2026 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587959;
	bh=7zpkorwus004YyxUUcOl7JyvlAtNECWRC9I0Q9NEaTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=liHHypdbqq+1mNlpkUHAmBMwR4jXHGgNoLdOCknNBNSjX82KbNJa0z8IAGsMe1PPO
	 pq6F5z0XnrNsTQeq4zIA3GftwSNx5IfzDRi/XSRLLUojmzEvZI25cQYKO58yzEw4e+
	 zw7WUtPGMHxWbcza+ib+hVop3MWwdTEMzoWdaMNb72a597mj9kyIJ1q1DgzWoZxORX
	 XEI6vaF0DeAm4MmQWw6Xrj6oHFA00MQOse5VKLbdgh29ze/jCxxB574honn7IHmNZI
	 9Aw+awQ2X4B2nECwO/tgG7Fz4Vt4JWLp9RqhynUnR+gbaFOemltFXc+y2ozqxXowFD
	 hhfnEnTuZDRFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 77359499AA;
	Fri, 13 Nov 2026 16:39:18 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:39:18 +0000
Subject: [PATCH v3 1/8] drm/rockchip: vop2: Take the UV plane address from
 the second GEM object
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-vop2-fixes-v3-1-08ae37e83b5c@gmail.com>
References: <20261113-vop2-fixes-v3-0-08ae37e83b5c@gmail.com>
In-Reply-To: <20261113-vop2-fixes-v3-0-08ae37e83b5c@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Damon Ding <damon.ding@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587957; l=1358;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=NyEom6Ygar2g2E7rLCqTeR+IWUlMO87YHp3qaA5pe+8=;
 b=CJPvsRb+FeVzYc8gP6W0cF136DeokOuAD1BCNIGfE8dNt1REZCVnpFJ49KJgBJlBuQBo0FjL6
 Jatlf+XM37dA1SJ3GZlKWla6xcQrmz2pBEgjBC4I6zKcqAZy83iSe60
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

vop2_plane_atomic_update() takes the chroma plane address from
fb->obj[0]. The planes of a framebuffer can be in different GEM objects
(ADDFB2 with two handles, e.g. NV12M from a V4L2 decoder), and the
window then fetches the chroma plane from the luma buffer.

Use fb->obj[1] for formats with more than one plane.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206550@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 76d151b8bc52..e8ef83d6924b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1369,7 +1369,8 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		if ((pstate->rotation & DRM_MODE_REFLECT_Y) && !afbc_en)
 			offset += fb->pitches[1] * ((pstate->src_h >> 16) - 2) / vsub;
 
-		rk_obj = to_rockchip_obj(fb->obj[0]);
+		if (fb->format->num_planes > 1)
+			rk_obj = to_rockchip_obj(fb->obj[1]);
 		uv_mst = rk_obj->dma_addr + offset + fb->offsets[1];
 	}
 

-- 
2.55.0


