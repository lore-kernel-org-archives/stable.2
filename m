Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333801;
	b=ZeBRw50ftkqjACs90w9Ms7Cj6XWRBYLwrtiI2BszmAfKJawGlDup+ZXwbmnt5oDJxMG9
	 8wl1G44It1qKQVUKg2TMyBE1N58+CcIt072xx0K6LGihBXfV2lBt899pjKkBz0cxz9nrP
	 EphWDbAdw9QKPeUBb8pQMpjuZCDVmXjv/4aqAJeyIi1kIgCrEeMIHWTvqJF9ec16O+5aV
	 Gtnbwi3mdhXqxNw0vGB08IOOgTNgT1GXYcmMGNEGZyAB4YLHrxn9Jd1e+iYu+yYg7eAiQ
	 LWdA+ltotOYDxO25w2/tF8G4mjMpdl+qiU7W726MfsG/72RlqPTLN6IdsUCKd5zbC4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333801;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XtubrmXqgaRtZN4m4H23jgyu0GIV9QrYqcdtzsgdqWw=;
	b=YKIC+yROd5H2vXc/ExbBVmXYiS5uCCXbTRFHyrr1zVdIVDULqhg6YwCkQfO6GQu8eQSk
	 PNinpeJ3eujwU6AugjR0iBL6BkqDkLjxKsbJpJpv50ShO3BoCJ1zccuezkkRRe4P7HcTm
	 UWWYRoOBFQWDKaynzVt4jrAFV3a/0Q9HGcjSN8P8qP3A3kokVJJdOaZ+Fcm//6QahYdQY
	 XCx7atMWeBK/BWZLJ+SwZb2BbUmsiBNzA+/dKBwv0AZQPh8uw3zhkrzpQi2gVSw5QYMQl
	 zN2Vf40G89yi6UzygPOiZiH1caSPKmhlh2+te38uEtf8xegutWJTINRHMThsqkKHM3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwXGTJXW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54B2606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwXGTJXW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56461F008A1;
	Tue, 10 Nov 2026 18:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333800;
	bh=XtubrmXqgaRtZN4m4H23jgyu0GIV9QrYqcdtzsgdqWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kwXGTJXWWmVxshwdPNEljxOgK9aFokTxHv8UgGxI1e2xzx+LHyd5O5NZFhRzqjD8T
	 jGZEihxgiq3SaIx7cmkKY80Byt4DiBSXChplkPWcDhWMPxt5XXxbcwlqdO9Zt5GO5n
	 9n2DhtAIW2UzuKS/4gdGBnVNwIJm1QO0XBEuiWTeK/qiSvI0dSEpQ7G/V89kGbwKw5
	 5OLjnlIozVsVHvY8FPua4gSU7aeMI/2aLKjAvJdtlEgOBTBhimYyBB+MdmamaJ34Bg
	 kxyk7CHBkUS1jl4ehwkrokeB8dOMcq8dQhj3sB9cYRQlK+2EXQ7HtvDRByXHFic7cl
	 fsx1c8/zh8f2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fbdev: nvidia: Release write-combining handle on probe failure
Date: Tue, 10 Nov 2026 13:03:17 -0500
Message-ID: <20261110180122.3100365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062156-failed-5.10-8710af6a3520@kernel.org>
References: <20261107062156-failed-5.10-8710af6a3520@kernel.org>
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

[ Upstream commit 8710af6a35201a6d01b5af8f7e4bad29cc40467f ]

Failures in nvidia_set_fbinfo() or register_framebuffer() leave the handle
from arch_phys_wc_add() allocated. Release it in the shared error path,
as nvidiafb_remove() already does on normal removal.

The missing cleanup was already present in the initial Git import,
when the driver used mtrr_add() directly.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
[ sashal: adjusted error-path context to retain the existing iounmap(info->screen_base) call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index ecf07b598453e..05d3d1fcd81d7 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1408,6 +1408,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
+	arch_phys_wc_del(par->wc_cookie);
 	iounmap(info->screen_base);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
-- 
2.53.0

