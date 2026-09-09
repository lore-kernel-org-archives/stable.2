Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13D54DAE5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955694; cv=none; b=do2wXb+qJJaAWBTGvz37ejR4puT1yMSJAXfcapB/yeckC4wQWUZdMtIJilGT82lJxN1HYGB349BZaHZ2RbakdfkUm/mh2On2pAU1N8TgSCToljseXjNpWN+BWtuqRrs3JvxYwTwBmtAiUUp7zeb32crvwwxeEJeyrrZW3tAOSgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955694; c=relaxed/simple;
	bh=b1KYgUfo1qBmJLwQS/hFVCFdo662QvmV/uxhl0ftpk4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qnJLcNU1JqEffCKnoXDsGKKZTxaJzy96xUljqM/2+cAv70lMzbQ55/V4d8+tlxLt97n1l+RKxfVv6wYDGk8V5W11GgMWi+ouEXmE6O1gCiK9HA1BeZSFfQ+rkBqj9nLnQTzqbgWV3Q6r+fuz9v6yKG3jFvL/0hZFCR8tgSCsbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pjlzCpqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pjlzCpqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970851F00A3A;
	Wed,  9 Sep 2026 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955693;
	bh=WMDOluN3eGkBCdg+bLPNe4bq9+MJpdglhavePVwIZ0o=;
	h=Subject:To:Cc:From:Date;
	b=pjlzCpqFDehDn4LDG7JrY62dfaXhD/K/8xFNpb1tN0Se911D9nS5kuaMQQJpfYFNZ
	 2wtJ/U1DBp8WEhF2CjfFgATXdJ8wdpuHeQ5WS52yiVSP3QxF0zXXaleCY+OOCDT7R9
	 /Stx6ozP5soVz5KZgAOEmWOhPo/9FSF1QKo5OpNo=
Subject: FAILED: patch "[PATCH] drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug" failed to apply to 6.6-stable tree
To: oushixiong@kylinos.cn,stable@vger.kernel.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:01:59 +0200
Message-ID: <2026090959-thinness-nest-7c54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 958f35cbb8955ca3fa439cd9f2092cb42414aa8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090959-thinness-nest-7c54@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

