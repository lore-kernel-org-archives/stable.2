Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795065704;
	b=pUvnp6V+s/3JbND+ZeewYk95XaNWPPaYbVgLbJ0ECkbfp7jXgPSoqyKmhWHIGkzB/sbY
	 IHiFX+r86/SflyW8Ok7nclU6Ky4Feqi8PpPlowXaizmBdR82IOUF2onRFQBYGclWKNWWv
	 0OPcpZfG3OvvOOC7s8/hOIh6moFBqFBSMosLGHwP6PGDAzFWU1pVXIhUdEYhjMfM+G3g2
	 IPr4oWC/io9WGVlD5jLmh69pW4H7mORKknjaqMymTlAOEPHx7+yqAo8OAejepG9wgYdlG
	 /OdhOuVzbUu5RVNPS75UY8Z1hs65IkmiiMEwuFlGQkF9RJQpRs3Jx8yBVbl6mdzs+xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065704;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Lnnp+w9z2htGn+mXW4XMMYZwdUZ4sJhwx11uqDYaPEc=;
	b=OPgbLGUoMzwxD1QtBA1fC4HVU5pC+sCtWZXSF1cPucyvYL7EzolMcaIm9i/9wDQIBaR+
	 82shIreR4V0zPxELRhE00XWwRgTiRYlh3F//JBMcQtGRSV8Qrv1G14tkseT0wisXkBZgq
	 q4dDpbGRaYf1HXzWADCTEtZhsgnyVsFg4Q0fWkKhM9iMM6JqSqTBjb1beqtoJjcpApCuO
	 uyZnGn3nmVEUQeLM25UzE5M+NFNqAH8MCgqmRh5flJsP1TJDPbavgSsXZf9OcfNltVPfp
	 cp+a30BQuBjroNNx9i/H1uoNiVR7zlj2ZB5Jar8gtiN/z5wSG/SeGjxecaGza2xu8ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRyp7KDS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFF606A326;
	Thu, 19 Nov 2026 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRyp7KDS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795065704;
	b=oilW1udFWAZ5bSa4N/auNXHlyS/UxvLfFlbOKbn4Hznlb2L8nWwDFxmKwr1GVo7l56qH
	 bZN0viDy64Kfb+wJIGmyFC9exLWsqjHGrSG+rHKD7I3xkLoKR1JKqpz2t0dzoM2N9ONG8
	 bSS46NyHWIp3yBad9Np5pCcK3ZMnfj1euSoryemHyzDqTamJOZl3jd9robNIsXfk31p3a
	 hcAc4pLna2BMA1a3YAKQrzO7XDrWxqObY8my1ZrZubWnhgW1QZs3W40aFImX46jaapBQv
	 sTyLjIADS4cgVgL6ccjdQ2DFLSDGN1su5fq4TEM8m+GhLRQbET9uRo4LYIuhJzb7VjQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795065704;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Lnnp+w9z2htGn+mXW4XMMYZwdUZ4sJhwx11uqDYaPEc=;
	b=V27yOTHJS2FOa2q5jfV/tcPXiMKEcLZGT4iDAQayVMCrERhXFzv3yfEwKiUMp6NtwY1z
	 Pb9B3fxNKU+U5XTv5+4Ry3YuKaRuOk84UH+LERJlRVlTBH2LYkpbNSCeGzOV5KLNSkOeb
	 3pYOH7Z/2n6PfJidutJP4FGeBcpwbKxFoStQW8S3+Q0Z+5vXwgsPZYAYkvNrZlp1q2mnT
	 TVhma+6Aj/EB8JjUcka8srwKwvQGjrWuAOzEWNxFjI18hF0Q0sD0lhK286kGXb7TqJprj
	 TU1LeTsU+fBnH3KS4FBLQQa3b1tR890NZ0EYW1clS3VwaS2GGVV2h2eUJSVzzRan12w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D0BF11F000C5;
	Thu, 19 Nov 2026 05:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065704;
	bh=Lnnp+w9z2htGn+mXW4XMMYZwdUZ4sJhwx11uqDYaPEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FRyp7KDSlFUaxVajhm0XCl2rl3roYPoDPPhJbZnpKJsStbT5i7rfb7T4m3lBaunho
	 WY6g5PTvVFZZFM8MBHVWImJRfCR6D7i7uncseBWk25V3hNL03pOkKI68dSq64TELMt
	 Rh4CP+5oyqbocgO2moTbdWfyd34p7dwb7qXVFjroC/9KxeeWPv8TjuG575PyFD5E6P
	 NzHWlsKJZfsJ0kQ2uvi5fYyjkSlILFM4gDQ0K0Yf9sIfdStDS3y9oV7d5SB0pqZ9pl
	 bsVUOLpKr9dzZFb2u6CwyZWV5XhnTTouiBj1bI+bvbEzUtMuW+i5NTiem5PM0pgMn5
	 juLMb8aFcfOnQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 49CD54B0F0;
	Thu, 19 Nov 2026 05:21:43 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 05:21:42 +0000
Subject: [PATCH v4 1/8] drm/rockchip: vop2: Take the UV plane address from
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
Message-Id: <20261119-vop2-fixes-v4-1-4b8f5e7148c9@gmail.com>
References: <20261119-vop2-fixes-v4-0-4b8f5e7148c9@gmail.com>
In-Reply-To: <20261119-vop2-fixes-v4-0-4b8f5e7148c9@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795065702; l=1411;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=TOp7ZbibLvqtdCodlqF9JsSFSXjfB2Ipxv2/ACxgEig=;
 b=Yt456vFi1CaR7FWdkfDdK29YEc+AoDzHB0LsnBww2fS3Vc4GyTQ8u8ql2ylHleuCPv7CUiPb/
 bujhI/l9oPhDKy4oWz8Kuu0WNjtwLnh9N7vKufFFnFkSoQaBeJNrlIG
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
Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
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


