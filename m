Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C054CF41
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955697; cv=none; b=IimM09DMGKiVC7uOpr0PO278fliLwJMlZqoRNFwI7AxnZc+Qeh29H1UE+zzBVJIrtN73RqR2kwIBNkcUXN7wQ3f9kXqUOs2P63pukw4xf1hJ6g/4nLiKwJeBtN8fZ8roS9dMP850R3SAaUO6muYZmXQcTy1DmzFGC6KMXQ5/mGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955697; c=relaxed/simple;
	bh=dAR8LM85L7Y41MkH6jVRLC2RP31IL7Y+2hyPxpekbFE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s+y+IKa/B2yRyxKwbSWG6pUC97P+ihBP0MVZDmBL3FFDaQ7RevtGkxhuF4y5/b+DUmD9w1THS5Hg+yVd5TxuUy8z85zVsLRnvHHSQkwNc1jVnzJijYAhdGF8G6MlNAW1P/ZLsrpCqBPea8fOPLGpUl4SYR1Dr6CwV51L1WoNujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZQaMItus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQaMItus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608101F00A3A;
	Wed,  9 Sep 2026 12:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955695;
	bh=5HLjN4YL+6zOz6gFZni094JbTRK/feQ/mEtv+TI91fA=;
	h=Subject:To:Cc:From:Date;
	b=ZQaMItus0/mdbN1L1wtaqrXGdZIPHIO9egLV9zjT/wrVFBlDytps6QAxxXjb3meJM
	 YM/vK96TIkv7DP0HHuo0ljsbAODRiZv1w1ZWxUiemgTeRbHjFFO+EzD/z2ZZBXUbok
	 YeD4rEq2F3va0yntqvI3Ek0tT0IhZpl9u3MROgGs=
Subject: FAILED: patch "[PATCH] drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug" failed to apply to 6.12-stable tree
To: oushixiong@kylinos.cn,stable@vger.kernel.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:01:59 +0200
Message-ID: <2026090959-implicate-skintight-5af9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 958f35cbb8955ca3fa439cd9f2092cb42414aa8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090959-implicate-skintight-5af9@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 958f35cbb8955ca3fa439cd9f2092cb42414aa8c Mon Sep 17 00:00:00 2001
From: Shixiong Ou <oushixiong@kylinos.cn>
Date: Fri, 31 Jul 2026 19:17:29 +0800
Subject: [PATCH] drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug

The is_avivo() function has a logic error where it compares a constant
to another constant instead of checking the device parameter:

  (PCI_VENDOR_ID_ATI_R600 >= 0x9400)

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: f496834e1674 ("drm/ofdrm: Add per-model device function")
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v6.2+
Link: https://patch.msgid.link/20260731111729.703116-1-oushixiong1025@163.com

diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
index a6dc34b9ec0f..9d60db45139c 100644
--- a/drivers/gpu/drm/sysfb/ofdrm.c
+++ b/drivers/gpu/drm/sysfb/ofdrm.c
@@ -239,7 +239,7 @@ static bool is_avivo(u32 vendor, u32 device)
 	/* This will match most R5xx */
 	return (vendor == PCI_VENDOR_ID_ATI) &&
 	       ((device >= PCI_VENDOR_ID_ATI_R520 && device < 0x7800) ||
-		(PCI_VENDOR_ID_ATI_R600 >= 0x9400));
+		(device >= PCI_VENDOR_ID_ATI_R600));
 }
 
 static enum ofdrm_model display_get_model_of(struct drm_device *dev, struct device_node *of_node)

