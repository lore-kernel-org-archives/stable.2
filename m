Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050515;
	b=XtwUHE34TAs45XFGxeGXPdKN29K4V8UGGwBZ23gZlu/uLIDDyYXV8crTpbuuhi7M1rHv
	 4bDTsm7yIQa8y86hwY2J6bQr3QfOXuTt0NEns2DefGkYQWRbqfaih5GfTR7zUYPShlYjB
	 Wf3jFGXWjXKCiEMOodqVhtB9xji2z7hhgorV/KCqlmD96yFSHWB+rqMttNU0LegTyXd4s
	 nZd7j6BOSh5xNaxefUeEwEkkGhDfWjyDLhcrlEztPU5h//vdACOdyA5Okpa0VQtckKHrE
	 2D/WfP5eiR1Ve+pdhDnSQ1FQlSuWiCFFWLFkfkTTsDVVW3fIHqJsbM7iUaiukjJb/4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050515;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VBIerH6pMym/K1+RLU759OLqzVXWE+u6Zg87eKd4Bxg=;
	b=MWhnzupIZTv4mQyl9eDHkN/IiWrb7jzpvBG4zFzraFmNohkJkCTvVOKMnCodVnhO6lHR
	 mjaAKUh3Rd5G2C9lrn3KcFAjpnfiP35wdZviAuyc5lFaVfF1La3K/ja2aTIUAGj8nVmMd
	 K0o2ytVhamLZsrJcDyv45YSsGPc41HTIYQaIjrRP2Zd2IYHo5O+Mt59HLDbazBohn/hCv
	 P90xrpmSD2H/ollcZYPvKAZWOldTgXSt9vIPexyeAZf+pjrwVFf7JOJQnXpKXDwTSaYFK
	 fV6WgLimrhYxWcJ+xFC6+qwvD1nY4MjjLxRIxDuu9RW/iI1O0R6tutvAyjrC9EsOgtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsVEHuFW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsVEHuFW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFB71F0089F;
	Sat,  7 Nov 2026 11:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050515;
	bh=VBIerH6pMym/K1+RLU759OLqzVXWE+u6Zg87eKd4Bxg=;
	h=From:To:Cc:Subject:Date;
	b=EsVEHuFWJNatpSkA8zsIyZ8t7A8NubYU4rH/mY/So2e8Q2vOn8GV7Ok+y/0gN7szE
	 U8Hgp61qUX5kQrxhgxXgLIK/3VJ9rK5m9AWQ8hlendxo5upMtnd8k33yWNWeKrBj2/
	 PXFxq8+60sok8OyIp9+yK77BWWtbjbG/SIw/siMrtSH5IeuVehlkcmkle3F3dJZLox
	 fGa4/42jaQIJpfUjKGsDE8GTHnphbTTC9oRR0PC6bEUGZ0wqRZEWMNlKHx171T84VW
	 kf26y3m2UKlskJp2aIjAx6y2ClnIkdPUnqybFbkVaIULAQh7sTJrCzIhS6op+kbtNx
	 SmzraB/PDifgQ==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: kyro: Release WC setup on registration failure" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:53 -0500
Message-ID: <20261107062153-failed-5.10-d3bc005a6294@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d3bc005a62945aec57059201092b12b7c955e5a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062153-failed-5.10-d3bc005a6294@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




