Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472388;
	b=NKTc7t4YgG4D3eccbv+FvrpQqr7nCWogfNKs7Iqm3yJKqD0dgBcbS4wzT+cjl1M794tz
	 X2r4Ol+cHsx9eBvTFlGSrCfEqjShwKGyNqjjmU4ulxPMgKxFuHww9Mc/e5piVMAEMg6wj
	 +qY1FXDD4/TK1i0QD8pyIHWCBtsnRUUc9aV293IgXab0+B5YGyquP5pgRRBzP15RL1cyc
	 bxpmzKUJKEjO1PRRDsDDi9uLk7bk1Jm2dHlxOZ9h7/lirBX7gUPoRhr9KZ/9MjNtlgdE5
	 3hEmbhq7CmpSpuOP+/GTWa7EjVgobjkPD7HSy0zNd7WKJyUlEr2/gewESCMyOWzCymQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472388;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RhdgniR7Xv7Tq5+THcnfG7FzL9goeLQzbhmqdAGPw54=;
	b=l91cn5RMecbEHeQfCn8mvBolnsh6msfh5ckd3va+x9jJCQm4xyqom1hqge8E3mlfgfsl
	 aUdFoeM7XD70l/6sOJbUmj4JsO/HWDe+Spx7lS7KzwKI4Agw2lBt3YcklZ+Z7uPxxv4Zd
	 OAuf3jZhXkQqhzKubITRphyYgceilFIDt+m1JwYLtZydsZQM05KBLjuXys3oey/9ruI4U
	 DyPIlzZ3fXY1yeypN3r2629i9FdUimYVof+3TmHIwmLuCs2PA+nH0pSKZxjFHaVU2CbLm
	 qRXaCAhUeh0c7jHkDrJXJ3ULQQawt8yoy2gOrLNN2mTHsTxSo3Dt6lSyG+VWkdMTL7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VvpYQmxc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3DB606C818;
	Thu, 12 Nov 2026 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VvpYQmxc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794472387;
	b=midOdj1lEXBligdJ8Q5mhxR8xgtQUBpLR5XeWnezNplrsewJsrMkWu9Uz9IsNFzEBiTX
	 dghw3N1REs3JXL9OCiQ+U1a1vuJGjRl5rdDZtDJNEbIzcsaBvqSMDiVFGFa4v+xJU88Vb
	 LuVyRIKaJ74kYHPPV9eI7l3QzknLlVTvRZ8xBYRGnhIOAYJ1zsdsQMSirTrofloGt2drG
	 m0nfpvZ4+HY6jehXPKlkLrdVtrLdbJcrilJqvNNGssKgIPUWUNV/YsFV3r5zZp2c3fKDF
	 V4EnIbOP9p0+T239G2MpnhAU/oghJxfKdfE5L12u9AOcZ/8EqGb2R1Q8Eh1C3ky6ToQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472387;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RhdgniR7Xv7Tq5+THcnfG7FzL9goeLQzbhmqdAGPw54=;
	b=Wc/ocfOBGFXP2Vth0rkJ3HEIyZ7obUuWXlkH0hD4pLokDdE4m2ZGwx8sG4k5BedtSHrm
	 1HT1y1Bdi+S0mAhlsD4EkVmWtDy3f5dElU9GyEv/y5rfdXxqrGF8PPCEwNn7bRaaG7ZLu
	 2iletN1dKbGDLjrHXbjNdMZaXA9dYoUuoHe/lqSH2JlISofUfVT8n0u9cVqed1oZFEWiE
	 ZS22sjzLnwXJnhO/nVkqicGaExJK1ZKXBkziBX7oDApsjLJg3TMR4+8/hS7AG45VX8rUi
	 r8i6OD/6BP7SAl1T3+d1tdOGDocNtj4i9TROCmJyNIw2kzEbMEKo0f8TrtR3lzQc3aA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CB6CC1F00A0C;
	Thu, 12 Nov 2026 08:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472387;
	bh=RhdgniR7Xv7Tq5+THcnfG7FzL9goeLQzbhmqdAGPw54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VvpYQmxc83SJbPJeKVGeQ3hXL7ZpBI5Zq2825/p9PKTn4YzzkHZdbWYdO6h8n4qUd
	 8itrjuwEFHQRS7N9qW89WyBh86imBWjHkGkm4NH+LX7enJMkH21tFE46G0PtP5f6oH
	 eQg3fHFVCvxxhnORn4gFhvYy6P3ZH7dHFNUzx2isTILER2JFxNyMy+zLw1OmaKOVIw
	 cLoLUV8T50Jklv/k5dR3/04Q2+x4jFyWue2YfVwkFsTVc0kIyrBGw8LJehd5Crn5gx
	 ZMlOmeqJHsJ2vK4+B8tn9PqzeShi+wFBUWK91wVcRSXXAY3tBS2MpK8enSuGXiRYbO
	 Ufpu3qu7jAm/A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4FB9B4939E;
	Thu, 12 Nov 2026 08:33:06 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:33:05 +0000
Subject: [PATCH v2 1/9] drm/rockchip: vop2: Take the UV plane address from
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
Message-Id: <20261112-vop2-fixes-v2-1-8218c1cf8ac8@gmail.com>
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
In-Reply-To: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472385; l=1838;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=c6L45VmSkCBmk0ERX5lNSIXdj9a2eckfk+73qA8sDb8=;
 b=bNeTudL523j6Oh7G+s25KWoAvRH5h9NVLNWYV+GSaMqLiTaDWtX4j2lI+02qf8Y5TtY6yHfN3
 3AEArtFHBkpAOJZNZx6SmuxwHhXYzW9/VSt7E2jNe1ayGQUaGNQSjax
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

vop2_plane_atomic_update() computes the address of the chroma plane of a
multi-planar YUV framebuffer from fb->obj[0], the object of the luma
plane, plus the offset of the chroma plane. A framebuffer may have its
planes in different GEM objects though (DRM_IOCTL_MODE_ADDFB2 with two
handles, as with an NV12M buffer from a V4L2 decoder imported as two
DMA-BUFs). The window then fetches the chroma plane from the luma buffer,
at an offset meant for another buffer, which shows a wrong picture or
reads past the end of the luma buffer.

Use fb->obj[1] for the chroma plane. Single plane YUV formats like
DRM_FORMAT_YUV420_8BIT have no second object and keep using fb->obj[0].
This is also what the vendor kernel does.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206550@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 76d151b8bc52..ea8d837d661f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1369,7 +1369,9 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		if ((pstate->rotation & DRM_MODE_REFLECT_Y) && !afbc_en)
 			offset += fb->pitches[1] * ((pstate->src_h >> 16) - 2) / vsub;
 
-		rk_obj = to_rockchip_obj(fb->obj[0]);
+		/* Single plane formats like YUV420_8BIT have no second object */
+		if (fb->format->num_planes > 1)
+			rk_obj = to_rockchip_obj(fb->obj[1]);
 		uv_mst = rk_obj->dma_addr + offset + fb->offsets[1];
 	}
 

-- 
2.55.0


