Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047655;
	b=UzWhDK4jz5YxsewwK0trb0rD0Bm3ASXUnigAE1y/DSR1B7D9QnoPav9eKa79pEh1Ji2G
	 UGbpcdBkAVEAcBBK3lkYp4jSBjJ2lazwTZYbyohr/TJjx1UW9V95f9LhfeAz5lLnzGCSD
	 9vRdjWHngqywc+Dk/NAopaCLhPovh1qs48BD2g0E3LMEzGS7aDHf759ZlYREt7zDAfXVf
	 rxo0/zHdTmIMPVmHiVq8uzA4Etnx9Q/1r/Z8O5tjJOj723sy8Z+GgddXbdzxpptZgBDyP
	 aRkPczeCg0wSOf8e6N8i94zS8w0+j6ByOXbjNAOobRdpkxTr4GwGe3fBi8I4tH5sCUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047655;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hUL3a3fT0+bYa3sNpNOfFl3uEfII8q1DGj+hlED7su0=;
	b=i7ajTVkvjRHU2+I6mCr/fEk2m4toSFsGCdChAO7iqmfsnV5efw6NfcmGfpFxvBr5aJKV
	 OxdV5tFPodB59BozvSlqgEfnt5kQ9+WDYDUIYj0yKGOdvrhH3zgpqncrVCiJNO3mX+g3t
	 vVNks1cNCL/YdzvAPakZ1eOzZqnQYQa+BppYoV3eBDxj9AFqNv+FCVLjANUqu5i5/CtGr
	 qui/1V2BxSRN/sSlci8xQ4UkmxHcteOsBa+nhLN+bAxufh1uMxFUbUyfNdKEddqaA1kSQ
	 t4LKqZpHqvPKe227/ZFmD1TRQKV2XA6Uijrp+uU3bMVRUFcwim0Op9qHqdtqin0EHXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1+Xm1M5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67658606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1+Xm1M5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56071F0089F;
	Sat,  7 Nov 2026 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047655;
	bh=hUL3a3fT0+bYa3sNpNOfFl3uEfII8q1DGj+hlED7su0=;
	h=From:To:Cc:Subject:Date;
	b=S1+Xm1M5Bpl97lWs8XK6hIRom5ayxKzafZ/ocKQp+fQDzM9Lxj1GOeZnoWP0ZgcXP
	 c4KnGFWcywQtlPncU0UyWvyJ09rqsK5Hg+IeC35SnJZy95AMOHDicRc8GNm+ycW5Vv
	 NTWvoU3ee7wWL0Jkko9fYCFzoT4Uny6NxcH/WP4evTgzc++JWLXHTmNoE2izzn9UKR
	 r/uLdm2Yhngr4fbPEhHcT/skL3YAho2RGrhFHFcGQsZ+jVeSqDURsxaAH9iBKIAVt4
	 8y8AhVWlBmgtGH9cy10r/B7nyn6tJDSiM6I1ZpmSNZWIh+XHvFSEcOM0NLh8/Ij5gc
	 AYKsHZozxsACw==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: kyro: Release WC setup on registration failure" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:13 -0500
Message-ID: <20261107053413-failed-6.6-d3bc005a6294@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d3bc005a62945aec57059201092b12b7c955e5a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053413-failed-6.6-d3bc005a6294@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




