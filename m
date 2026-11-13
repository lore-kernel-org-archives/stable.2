Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584239;
	b=amVeBc0M+WLwe1T7cavcUyCIj89/7LReLLxYWas+vxRvZ+7y87QduWsJZgiIlLbxwQ8r
	 NLm+N/TAXFKAVSGebaX29zy1Sdl73vPeFKovPewW5WVN1OlrCiGLsUv/Ie5reWeqDP47S
	 GJKcwaiCOQlBwUS6GAeq+/V5vMZ0yYsez4KQqv+b8smOnhERcTTnXlZ0YPcu6kB6sKG9u
	 EqntYll1jcL/+Q+mqQaNebEzVKIU0xp4nF+U5kaVBqzJdp/+rkZN4NfgVG64r/7c60gGN
	 B8xI2He/jwX/fxWba0EofRrOcdEooqXY1ddCWgx55qmNWXti3GpDSP/wQ1oA3TETSSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584239;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V1sJRNRHX/C+FvEH6sRh41mOYGo+m3Hk6+rprXCAwX0=;
	b=zRqZbrAbBUeGcTwP5x9IKcomeyy1xBvXPsmPUgxqaharK6Q8FlnEuGspAyhB3joFEAa0
	 InlK1dQumA99F7t1YwIHqfrQeFyQ9opU+m7rKyy0zzpcFIcM1ROj1GclayEf6gMEM4x9j
	 OrT0dnFSYvBYmFZKMsZp5OLT8hzlH+ktqYVvowcsm63VMhDbR9pySNRhvEtiLlNO+0rya
	 jcr5Ip5hO0PZsCXRH2ePCGYK/hjAzssDJDOY8+qYT3vKTi4K1N/qTBShLCOw+ZrNH5ZIq
	 xauZ+ZwkCGRAc2W+sT2j2PePyIfsdKYP11ck3a+BoLDqjzDlW/YT5pdsXCSUKZR98gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ef6bcRG1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC40606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ef6bcRG1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DB41F000C4;
	Fri, 13 Nov 2026 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584239;
	bh=V1sJRNRHX/C+FvEH6sRh41mOYGo+m3Hk6+rprXCAwX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ef6bcRG1M8vyKINa1w+R7asS8d6IIY4pVV/pMywNqh+8DcaBAF8SCEL4LpDDtRqxf
	 QpJIrmX89dWjn4+j5DzwxA7pMYHDMVbu9OzMvo9kYNU2vdo7627hdOAczusYQ4b1N4
	 XkkmTX7l6wc7WXp9jtAJKTqMESlU3jd3dwnubBzS0kZTjC+TIGLErrlNFvXq0ryEy4
	 tq68NRQF39+wqy3GpaeqjUW7Pr1JqGRbMNgYY+V3gyagowKbeT6H8vm4VszDaB6jQ6
	 V8iN7bbTZz/7euVFsDVB/2XPmws8Iavd8SvUOJX7jBBaVxjiDmV3zhji0MhwU2EkJw
	 3yT+MhkZRdYgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] fbdev: kyro: Release WC setup on registration failure
Date: Fri, 13 Nov 2026 10:37:16 -0500
Message-ID: <20261113153600.1932437-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113153600.1932437-1-sashal@kernel.org>
References: <20261107054747-failed-6.1-d3bc005a6294@kernel.org>
 <20261113153600.1932437-1-sashal@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit d3bc005a62945aec57059201092b12b7c955e5a7 ]

If register_framebuffer() fails, kyrofb_probe() frees the framebuffer
without releasing its write-combining range. Release the range before
freeing the framebuffer. Earlier failures still skip this cleanup.

The missing cleanup already exists in the initial Git import, before
the conversion from mtrr_add() to arch_phys_wc_add().

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/kyro/fbdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 4a3928a525122..a08b25e567fd1 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -764,7 +764,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_free_fb;
+		goto out_free_wc;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -775,6 +775,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+out_free_wc:
+	arch_phys_wc_del(currentpar->wc_cookie);
 out_free_fb:
 	framebuffer_release(info);
 
-- 
2.53.0

