Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504451;
	b=RyxoxbGK4bUIwc/cfXEH7OayNJ4JdJvFE+Kr/UICrHZifbECFp3++b7s968aOWnpgP2s
	 2tZrYlgoHnPltuX5DoVFqX5nK00TSDJ036rS9050jlhhkm25KyjD3ADIwFYgRUHNzGXQR
	 L2GdRm903stE5tWNkESwS0KvJkpJzsuDJMESpOfzZp/YF4tm9NYyW7SgUBaPDYxEQ5eBj
	 tk9HnVB9eIikOMsC7DvdSar1kSm0in8fjKTLe6ij6yOfdBNs70RZHNG9rMb0ceb+x4VkX
	 0n+T/LMIyE4lOcpWanPFSNL30DIfXgX6GaKsvEjP2gDBBqPg3XfmwRO2I2VW2AEeq7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504451;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X6EwVi8BQQ9pNZV0SSPdWtD6i42Nc4T/U+RaqeoNwIw=;
	b=SJPrvhki6ErMqqZEA991X6e4Y6A8oPnBqSHKqPX1+7YH9CNMH+KNB7+TDd/LDNZwzQ0d
	 DrEjzdviITbqsm+DhekPpC+TqdZAzD66CU1xQEB41HbVGFoSKT/2+4km39/oV/NzlRQk2
	 W8ETi+Y7Ng9Fojj5LgszI1ixSAWj4EhLzPygYow7FUaDeUpmdO5M4+67ObigdX9AWLbpG
	 jqEIldjzvpAIrGX13f+0J+EYjCRspcGjW+8XQxTvAH0WtS/HtgcwqKskzuubrhhWR+8W/
	 DWHkC4p55W8It+K8jW6GHeiu6N5IEKhcm9SlWFLo8mK8Hyh8BbN/NDF57V1Nw4bgJDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqZUjAQO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F0606A33A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqZUjAQO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6602E1F000C4;
	Thu, 12 Nov 2026 17:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504451;
	bh=X6EwVi8BQQ9pNZV0SSPdWtD6i42Nc4T/U+RaqeoNwIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YqZUjAQOzhmllCSaPlBpak29M42FdnOliH+jjLYdfDFO0nUEaB9wpKafQoyQm6E+p
	 JCO8ancsBfNiZmFBtkB1dK8xfvB+pV7JEz1qutF6l1F5fNn3hNvEa7/ghXyAjPcARX
	 s3Iniy/q90BM8oAbls/1brmYv5xesABdFftOItIgce58NtLox1QqjRCr3BDza9PYiW
	 IkeKhMvZaiaFw11GvaLO9uQLZ+JqXT4L4Hsh+8BAPHmiEjCDqiDkN2nKauL8qlJZKn
	 vE7taEK4ly+/LSx1UPH0EHga5LchkCj08WaPY3b0ZXh5THPUg7rehevkryagPJsGYK
	 6qzsjIxnuCGbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] fbdev: kyro: Release WC setup on registration failure
Date: Thu, 12 Nov 2026 12:27:27 -0500
Message-ID: <20261112172618.3072183-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112172618.3072183-1-sashal@kernel.org>
References: <20261107052152-failed-6.12-d3bc005a6294@kernel.org>
 <20261112172618.3072183-1-sashal@kernel.org>
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
index c387bdb1e515f..f5439f34e1336 100644
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

