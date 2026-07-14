Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DB285CA2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047831; cv=none; b=LNUP7H3A53FH2nYCuTs7sbV/9qGFcXc4TBf06NlV1qA4p7vraE2ogNY8/YFpnDzJigp86KvcqH8e0HneK5sGV4n+RBZa0Hcv890yolx2jOqRBJLEwqwiUOdAQH6t1Bo/OZUh8BVU+FTK01GoFm0i8Pz7g2xYLbmQSNEx4vbkpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047831; c=relaxed/simple;
	bh=v1S1CjSx/UQoeNIzgU5PVSLidycyEMRTcpjmZaVLMrc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n5VtMdhCYPkav3urUedrnFeTM0TAUm34EnRiPPgaBVy4jD33BV4oieod8xYAlTI6pPgyqzj/TkNcwKAdaFHa74xZCeBOSCo6k9dWSbbL+K7cb6c9jQF76Hp1x8Qb5YRRCjL3/+miJWDm4aPmGQu2xg9ZSNJLmJTzW2J6C37quoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nVlvq9aN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nVlvq9aN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9E71F000E9;
	Tue, 14 Jul 2026 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784047829;
	bh=4C5hetSUOtBOV0OcNLJUg/TcfijzgZgHCuSNzeNHgH8=;
	h=Subject:To:Cc:From:Date;
	b=nVlvq9aNyliUlMDjAGcmkTXtc+xNxbSXQgNowGWbrVUZ/OUW2eX+7tbS+g0UGZeak
	 g81iDuQCO+3IUyj2iK/0Gk3zQ8MszNEIdCiuHa2noVT66UGdJ3zGTEc9GATaAz0pTu
	 W9eftXUiJCTXYoofFMMpAAI8pbGJ0CF0TDR6NIqY=
Subject: FAILED: patch "[PATCH] usb: gadget: f_fs: Initialize epfile->in early to fix" failed to apply to 6.12-stable tree
To: nkapron@google.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:50:15 +0200
Message-ID: <2026071415-blouse-plunging-e6aa@gregkh>
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
git cherry-pick -x 82cfd4739011bdc7e87b5d585703427e89ddfaa5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071415-blouse-plunging-e6aa@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 82cfd4739011bdc7e87b5d585703427e89ddfaa5 Mon Sep 17 00:00:00 2001
From: Neill Kapron <nkapron@google.com>
Date: Fri, 19 Jun 2026 04:06:03 +0000
Subject: [PATCH] usb: gadget: f_fs: Initialize epfile->in early to fix
 endpoint direction checks

When parsing endpoint descriptors, ffs_data_got_descs() generates the
eps_addrmap which contains the endpoint direction. However, epfile->in
was previously only populated in ffs_func_eps_enable() which executes
upon USB host connection. As a result, early userspace ioctls like
FUNCTIONFS_DMABUF_ATTACH that run before the host connects would see
epfile->in as 0, leading to incorrect DMA directions.

By moving the initialization to ffs_epfiles_create(), epfile->in is
accurate before userspace opens the endpoint files.

Fixes: 7b07a2a7ca02 ("usb: gadget: functionfs: Add DMABUF import interface")
Cc: stable <stable@kernel.org>
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Neill Kapron <nkapron@google.com>
Link: https://patch.msgid.link/20260619040609.4010746-2-nkapron@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 745c44d251f7..d9b95fb830df 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2367,6 +2367,7 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 			sprintf(epfile->name, "ep%02x", ffs->eps_addrmap[i]);
 		else
 			sprintf(epfile->name, "ep%u", i);
+		epfile->in = (ffs->eps_addrmap[i] & USB_ENDPOINT_DIR_MASK) ? 1 : 0;
 		err = ffs_sb_create_file(ffs->sb, epfile->name,
 					 epfile, &ffs_epfile_operations);
 		if (err) {
@@ -2456,7 +2457,6 @@ static int ffs_func_eps_enable(struct ffs_function *func)
 		ret = usb_ep_enable(ep->ep);
 		if (!ret) {
 			epfile->ep = ep;
-			epfile->in = usb_endpoint_dir_in(ep->ep->desc);
 			epfile->isoc = usb_endpoint_xfer_isoc(ep->ep->desc);
 		} else {
 			break;

