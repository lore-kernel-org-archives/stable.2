Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582253;
	b=3BBYclMFgqNx/ZnDJ4ytGXned4XbNF/tyLGX5TRI3bKn5cTRWD+RMIuX/hucG1PfHcEn
	 22jQ95J2ys+AkTzelHKo+QxlNchgtv2xezaYPNPKMO3aL3Kf1WRwm7X4+777lLO+Pn1x4
	 lCBcXGelmvqqkQxeqAx70NNY2xeRDR0Sl+nctFryCs/n5DuvJTXEYJx19NbcSIRZmKYge
	 kW+q9eoVRt2j0EPztY7ybSJiS4RdYFomba9LSwTwEAIUlOGxkIHRwEFxKPc2Z5mWVeNTY
	 oQvB/OVuMQhSdoIsrZmsEBHfE8BM3abMMXDLPyHHWEQVWhhJlriuTMuKyH2jV5CaLPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582253;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DJYkSOpylqJuJ1GSeAn3aslYflmqSNxp87lpb3lSXmE=;
	b=jPlUknVeW16pPCVMS1hLVpRaqpx4I3KS4Fi/MxJcQ05j2M0y4sSO0YEGnSBR9KaSFlIa
	 opzUpgY0jwqQ7UrK/mrojBVSNxu6Woxrpwix7ugpyjQDYJXs5/j43Mgc0nrcD9CQxXqYu
	 T6ZzvzEQXzgG2HQwOuiNvBpsSRvrAdtr7w0tNjZx/71zaw0JdRMnuYaWd7A6mtS/MoqNh
	 KBt3v6C8oiljipb/BSqQLQyiFuh24iNvU/jBOEpJJosX83SOU5B2KqWw/6baz/dQQAbCH
	 +M3WSG+08Y1Y6pcSy5iAVrIV4A3xgLCdP4mAogOMItFGbn0tEXv/FDtalYaSeX6Rv9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+cVZF0N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0250606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+cVZF0N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195021F000C4;
	Fri, 13 Nov 2026 15:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582253;
	bh=DJYkSOpylqJuJ1GSeAn3aslYflmqSNxp87lpb3lSXmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+cVZF0NG884wL3KqrVRtxHeHTeD8QpJ+jxYVBMloM8EJAt+8HH+bsgZX4nX9Y9yy
	 iiuSLAjlUeqTmaZ4jQiDdwYcCnefLf2GuQkOalcJ4bwtXL7zT4yzH+0M0SOSFxiNT7
	 u4gudFfPpbSe3kCA6iEhOXlQQ6uFReh5R1HQrxOaWNr2mr1O0FXKjTWpFGvTEYMwk+
	 oaw8ULZQTwWoM87tTCfkhEgP6PwiGTZFPxbI9tJtSicwqM3EXXlanG1B+umqtgPz/Y
	 B1bpyMsMmxr1DsHHyD6rN9DYjAXzpJyVjKhYKQRpWc+wscNWL9ZUVVZJV8bCSQZjrO
	 U2IkxbeXpQ6XA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] fbdev: kyro: Release WC setup on registration failure
Date: Fri, 13 Nov 2026 10:04:10 -0500
Message-ID: <20261113150328.1846150-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113150328.1846150-1-sashal@kernel.org>
References: <20261107053413-failed-6.6-d3bc005a6294@kernel.org>
 <20261113150328.1846150-1-sashal@kernel.org>
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
index 06bdacf0211a1..986127294e937 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -761,7 +761,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset_io(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_free_fb;
+		goto out_free_wc;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -772,6 +772,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+out_free_wc:
+	arch_phys_wc_del(currentpar->wc_cookie);
 out_free_fb:
 	framebuffer_release(info);
 
-- 
2.53.0

