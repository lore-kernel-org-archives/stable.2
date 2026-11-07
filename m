Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046911;
	b=T1Tva0b2dPrU5lskJXq/AsZ9XFSmI4RscCrDz/Vq76ZwTDXZ8qZ0XUj5Grz86efeWAUz
	 skz39tecP0fi2SgZ9cSWIIdEeM0A47C4Ks45msQGBXTp4prbHkTsL6CSfdOm4fxJHzJn8
	 8sGBR7fsad6tL6ioslxhojLyEv23bL+CK7AHF2qXAY1mqk13P6k5YH39MpQIWsMFeXx4e
	 PRT/Fn8eEEWfTSYW0uf7V9bmP0+nnVT/gihStd9jIIBrV+Ia66bjuAUGINH0H0OVRoLxN
	 /GLEak3G07yTuKBIaHNCwKMbGYg0vYBS4rAEzDX8r8RQ4N4WhB3Dmuslyq5WEu6mp3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046911;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oW5uGiSNflskb7sl3QLavenxkeK6GGLBYfcR28T7i5M=;
	b=H/YV08mW7Ez2JQ2baa+4P1pw4hHLlJvDpiQtmQvfD+eSvMBX4WPGYU4fQQzCh9IVuCz7
	 l4LR7wZr7EJxBxEAFwjpzxjVTeoy6Dc9v2NSaJhWn+NJDWMZp1CwDLoC62fMoAqX/sBvN
	 wwhq4+EYihY41aUR3ZQxkbuIZxXgaLm3zDfPlivbYHqeIu42Lnew2QQIQBOp6F/IOM0aY
	 Sy+rpsgM2CZ/ZJQFTuPuPWiDpf7SsvgKyPwF+xzcct6m01koqpEPnIq+BwbQlMfZZfKPT
	 ytH6Amq9VQUvKWOTsssF93yfkyeI442QlKcz3CY2p6WvlvviO6SGnTZt8Ew/Rs50S6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UhJ/WPwb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86206606D81B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhJ/WPwb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB9F1F008A2;
	Sat,  7 Nov 2026 10:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046911;
	bh=oW5uGiSNflskb7sl3QLavenxkeK6GGLBYfcR28T7i5M=;
	h=From:To:Cc:Subject:Date;
	b=UhJ/WPwbMHJS7V6BjCsr2eO5g1e3HuV2DrLTUwTSCZE3iIvffBydIbHzC7MOCZ7BJ
	 rFWogiRTT+2JlHKh/hLwrnPPk9pAUlb1gDua0RRDPtnmEpuuDp5/RFDP08JwYrzsH+
	 3LISTVvAWNdycbQyXlkf0BYX5zWI641ojHgc2MBXV34r6cdVM7EPbwBLHupGciIBT2
	 zgXAXxztiryi6UI1rXIjZ5glAnP25/HD3aV2JM8mVP0SFCezzaEoHjpzBpLjAr4hec
	 fCwghJaBjvSpXh5rdDdCDVhyyjSti6PwfmIifDda1dNnvCRGdi2WFiJKH0OkGE+jyx
	 gYiTmupQeiMtg==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: nvidia: Release write-combining handle on probe failure" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:49 -0500
Message-ID: <20261107052149-failed-6.12-8710af6a3520@kernel.org>
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
git cherry-pick -x 8710af6a35201a6d01b5af8f7e4bad29cc40467f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052149-failed-6.12-8710af6a3520@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8710af6a35201a6d01b5af8f7e4bad29cc40467f Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 20:54:47 -0400
Subject: [PATCH] fbdev: nvidia: Release write-combining handle on probe
 failure

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
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 4ef7a5ba43cc4..395f5d0455fa4 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1423,6 +1423,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
+	arch_phys_wc_del(par->wc_cookie);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
-- 
2.53.0




