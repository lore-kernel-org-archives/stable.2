Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794542225;
	b=1Bvpapqv9UJlH8R8kMfL2MJe1nVPg67AKQppHP+eYe9WKz65xNxTLGsvQtVYSKJgKNin
	 ABVLiKArPppiF3SgHDL61osDKyYym6ZRMOAsMhmy59ODRDUN0Q5xA7Fq9/3s4BPS9hkpT
	 vhcbOaGW0i0qvPnjhA//jqkrboJxpAqt6S8KooIHkSxrrZCNfawHL9G9iW2Sh4Ymj/Asx
	 AkRgUnts3/3AS2sxC6lPIRCnZvzxQ/ICNU+hi1nZ6Fdb6B9EuLzQqI7CmGpp4LlyCSenr
	 RK6pPs+fHe5AXOngkD1IsomHEnq+iy4lTKQ3b9AsEhmxqhduBE+stoGfC53ysz5RJ7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794542225;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/pwo8ev4ydyn1kAXtq/Jnonk0sk8F7g6AjdNElBpRcU=;
	b=ZAEqlFuipA0XlLD8Yyvkp2i8ttWHBRgT9cFigaToDlrGkGtMD1qabbin7adAYs5LS1T3
	 oET7Hf5SEiRLFXyrcUw455MdHVng+b4l8mB8OApJpvjAR/3cmwOfZ9Gjxg5YhvyCj64jy
	 NU0CiAy/9bSxJiHCpz+hgQUSUFMS5IIuDOa9YhMhds1lxqE4H3QUwgJNH1PaNiZQZuXCm
	 dXkW7GxulnV0svgXYrujeHPTyOegTG1f3UUG8Y07nV/+QHuKO1DqMq1d5XnsPc8OkgU52
	 EHpwRkeIN97bKPx7GC7PcH6NZCWcrJGzirTu4jk4OzLWjaFEYRsdhKp7KhZsJoLqMNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2s5UQ+1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF014606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2s5UQ+1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53011F000C4;
	Fri, 13 Nov 2026 03:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794542225;
	bh=/pwo8ev4ydyn1kAXtq/Jnonk0sk8F7g6AjdNElBpRcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l2s5UQ+1XgR+rKxk0BJMNX1pD8D4LWKD3+ZRPWS0f9cX91VJ+CEGAFn00Dmer/fZH
	 sdMymR/AXp6k6zRPNIK4Nr2q7yvMMVt+Wfe9BGxAV/fIV2ysRsHzCyi1Q3Q5hKAw6T
	 K7B7gXlUnHtJf6YFLL2JN8Zfn7WELOZT2w2EJS39zWDXQeQYiX4Y4XqHXqUfMP7ubr
	 bfpuk67l4obz2A63WHnjR/khoKr8tqRMAmoUJisQGmMF2Py0WMmj/wJ9TsUrkbZBBg
	 jSbGQ/9zVjmZ4jQES5UOq9u7/sM/xFV8wJU7I44sOuLdNF7Wfo1hMpEenk+LOWT1si
	 EA8m6OwO+IUBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] drm/amdgpu: enable Navi 48-bit IH timestamp counter
Date: Thu, 12 Nov 2026 22:57:02 -0500
Message-ID: <20261113035638.1074375-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202406-failed-5.15-146b96974b33@kernel.org>
References: <20261109202406-failed-5.15-146b96974b33@kernel.org>
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

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 8888e2fe9c77983a9644cd9bf0d23ca9023b16d4 ]

By default this timestamp is 32 bit counter. It gets overflowed in
around 10 minutes.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 146b96974b33 ("drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for navi10_ih")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 6aa1884147c4c..2c42b9a7ba74b 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -160,6 +160,7 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 
 	tmp = RREG32(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-- 
2.53.0

