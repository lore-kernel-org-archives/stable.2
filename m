Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32B285CA2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047822; cv=none; b=b3qfxP+A7DJpA/atBtnVzDU+VBtZjYeyrIxQZdWSNUHDJQXgEorBGqIB6i2BAAlln7KQiddky7Z3uIPAQcZa1cEh5GKh+bXxQduDkJzPL82+jWZf+GhCm/P/GbShzSJwFkl5gD84M39C6ibacZsyDoS3jLUfUt0VhjCaq47JKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047822; c=relaxed/simple;
	bh=kvuYJpjmiJcuDHApbDcKPfJTp80VKSPAsfQMdospI0s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ji1727NzBs65S6N3bxcRWN4JNm8ZXMq98+3LoEiRP25W6LsGAV8tldLHuY5wz8VZ2T+usijKoiHCnKB4JlEPU6LoxFlacwkRzI8PO2NjpAD3WG/JJrYOlcqBphRku96mPhdOs7tiRAU0jUB9zIJEYLji5H4JkARnr0RjUMfaQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kOGTuluP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kOGTuluP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79AA1F00A3A;
	Tue, 14 Jul 2026 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784047821;
	bh=bBcOH5Xp0nGyxNlxDj8VQvfB7elAsqkpBFJ7fm1x8Oc=;
	h=Subject:To:Cc:From:Date;
	b=kOGTuluPA6DMnQkop5wilnOM1aowZzW/UdQZ97YNIVZ/gUZ1o3EYTCyRU2dym2PhP
	 I70kQXH1vXSqfEMJ9F+n2Qg5RP14kI21dGDncTGscoDqk5c5d+y9XIIdsz54KdgJ8l
	 Ij1Fg4N3i9Tp4Sjyk6oDHKW89p8neYoHJ/bO4nTI=
Subject: FAILED: patch "[PATCH] usb: gadget: f_fs: Initialize epfile->in early to fix" failed to apply to 6.18-stable tree
To: nkapron@google.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:50:15 +0200
Message-ID: <2026071415-tragedy-purely-e8df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 82cfd4739011bdc7e87b5d585703427e89ddfaa5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071415-tragedy-purely-e8df@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

