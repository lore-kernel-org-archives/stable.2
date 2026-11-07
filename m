Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049511;
	b=oIILvk+y69FNQ3RDLNQFKVtjV4AG+x7RLBFJo+gSkePrbotB6FKy5mOYDW9J4l2uxksS
	 WI7T+NGLnVvh0GtzgwCOfyCtIKNkqr/+TjyZ1g5RT5PqztwlFQ9C6QaKbbUt70UpGHvng
	 LRTgljQgH6Ge3ymMfUiEzjNaKjHUGdg7UXeXVr9umRRcjbGuxvoSzJJH8igxqq+cmpHNg
	 0QUo6fRPkKWetv27UJay3f7Y/Vem5sIyvC6mUEcLhS69lhCpdBdqzFcaBpizZzBUL8nx0
	 vVpOOj9N4V5N14MHF/TbrrdbN+7KpPxxJdX2+uJYLJkTrHaYhk7iQrZliQi/WaDqDhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049511;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7T6RjE+8y6yR7RWpJaEBVuxFdoy3uCgnfdtnogo5veA=;
	b=0oodAdEShMypmwcyu/yJiFQ4MdJnbMLwjhXS22wojks+AkJX4dyeY51PJmebPQuX6f0n
	 SVihnGACbfXtfK1gMjnVTFNWXcEWtJjJJKviWz+b4icAh987k0hvl+C7vk02sodRvHnfn
	 7c0syVkfYme1lE83Au9udlaEG5qC8vdel6GNPOAJI7hIScNZhPg160rKeTopW3ZUFyDzv
	 2KVOwAkmd+XF4m5VC+sJNGN0aSUReyiyRQ0IpDilou5RYULApqv/rY84AcFTscva3PVc4
	 cwdDghIHNv+PtnVZwz5OCC8XA8qWCHUmFCxoHa3Utm1CzZMRQZhC5Pu/G2w8OHlmEBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGkG5OUy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9F606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGkG5OUy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3D61F0089F;
	Sat,  7 Nov 2026 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049511;
	bh=7T6RjE+8y6yR7RWpJaEBVuxFdoy3uCgnfdtnogo5veA=;
	h=From:To:Cc:Subject:Date;
	b=RGkG5OUyuxjc9AKxJbU/4TcJxpJQDRGGFQM0ny4pIbV8A0tFRLHkC1yLkuIw2cj+2
	 4gWbKWX6rLAMiNPVNmbJpnYYWYMFBtTTBAMsffKuUmLMlpkQtJKXQdjQLEX6ba/oHt
	 6kSHyVbcRNQU1T+ykcy3yUDKOQB9l/OupI+o4P6K8qtcF6DoIsrhIUhj9EPUF+ChSZ
	 LXWV+JuIkZIxEMfuCln2AP9LkAiR2O7kN5Li7B7hTY+cca28aMlWTdNHblPaMvQQsg
	 CX/pdcSu0aVBW+slB5VS8v7/4qJ/gY4zXOvivcudWKpu3hP5vHL75TvbQDShzfBHcn
	 3Xcbxch8IZaDA==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: kyro: Release WC setup on registration failure" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:05:09 -0500
Message-ID: <20261107060509-failed-5.15-d3bc005a6294@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d3bc005a62945aec57059201092b12b7c955e5a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060509-failed-5.15-d3bc005a6294@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




