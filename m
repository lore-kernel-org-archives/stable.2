Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046914;
	b=secUTHyGMUHm4KhZ/6CIhyuxukeIpmiUPO+WjSDNElohITjXzGt5BpZNVXhdWiiaPm1W
	 lkJC/aCkZDmCg2a6d4MrqZTf/W9bSHHiC5PaQD082OShOE7FB5+UkKZCmvzWYE5i5chUg
	 YNV1JsFdngCwDsFmb/fjB4UCGRtzhr5imgViYIEZP4AI9ZKokN8++pgvE7Lj8GDgnB8u2
	 AFJOUPFU9I5pY5Orj05KFiElYPhZzBnjh7MX+SQyc3hvpcIyHgodZYiVNQ3sdtVFmzal1
	 6+AIltXEFrlB47gfa3BVv7hsmvOjW0H00lKiJIpR90LLlv+Um9Z9tSWcEKtZ2cPRkNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9wvJsnzuX7kRtcrx8/iN5rJasSpG+V84ZsiNEsuv7r4=;
	b=V4h+Or4S5IWSaTub5HJFmc/Rf0pH8Ba/mUAJyuJrhDlGl6m0D/yPE+W+Rz4XB5neYkWX
	 YTjLMeyumUeTxhZ7gmW0lDh8chqkvQmn3RfpZBTdFDVQflkFTCuKqhzkg8ie/IudB/JEa
	 LtiW8sgpmb4hQCyMggI5MHNwsRNtO3KFwL8DC+/s1UhbxbtIB3iVUqYYITjARnQPiXwSt
	 nJF4edjJaUN/SOCmCG6gieq/RkSn5Z5L1Qek9YTY/gsLAGkU5BRDczOJKX4THg/NGUbKA
	 PXfMBHCTaU2A18zap+OBo9rHGVugvQkvJgLWVuRcvSA8tckYJSPgdy5IRHvVpVbDUIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UipyvTEq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06004606D81B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UipyvTEq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CBB1F008A1;
	Sat,  7 Nov 2026 10:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046913;
	bh=9wvJsnzuX7kRtcrx8/iN5rJasSpG+V84ZsiNEsuv7r4=;
	h=From:To:Cc:Subject:Date;
	b=UipyvTEqhGWx87Rr9lRyRqiD50KZKDhyIdgQOhWB8yNCq60oh/JrjNwOTojtsMmGD
	 X3vz1vZVpgUqfKzx1ImjlawxW/OgPAAKF0AzEb4zdpmrDK/G+uUo5pmcvsbkTxAhp/
	 Mzr4lvY6bPB0RhSt8I+wftAD6ZlNORaCs1JNz8/c56RgBDUhvRsww0MDnGnULMesLx
	 Na01/GhZ+wgflIiM6uVF7pGWjhM8dWOPf8rtEroCqhrpjHhefnAwowIDhgOrvN0Mp+
	 BJX2Bqih7UrfGqmbhAE2SF0GTRJoxN9kfF8077AeM02h0Y6n5azWL5Xp0NOaaNavsd
	 Vs2AjZgQ5+cBg==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: kyro: Release WC setup on registration failure" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:52 -0500
Message-ID: <20261107052152-failed-6.12-d3bc005a6294@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d3bc005a62945aec57059201092b12b7c955e5a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052152-failed-6.12-d3bc005a6294@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d3bc005a62945aec57059201092b12b7c955e5a7 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 20:52:43 -0400
Subject: [PATCH] fbdev: kyro: Release WC setup on registration failure

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
---
 drivers/video/fbdev/kyro/fbdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index c237389888229..94d6af54e6c46 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -765,7 +765,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset_io(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_free_fb;
+		goto out_free_wc;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -776,6 +776,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+out_free_wc:
+	arch_phys_wc_del(currentpar->wc_cookie);
 out_free_fb:
 	framebuffer_release(info);
 
-- 
2.53.0




