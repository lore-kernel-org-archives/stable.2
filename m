Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802986;
	b=c7XoJtjD+rFuWjD9j2PAQ4qbnKi+9hWoNZZ/cuh4/Cx6CM1KuKHUaoT2NrE/rv6bVJSY
	 eDwliNUcAROnsqGSRJbmVwEjDNOAYOWkQWmqsojldkeexhbqh0r9BDtiimLuoTqs0N78v
	 HfDDOY5pFVk/ktwNQufc5K/NXP4IrGJz1S2rO+hgXiacS4YFyPiibAnKnmBkhcHu/P208
	 heEEcZj9WFN0RtP17Us+8V0qIns+TLVVgd7xCoOP7plRAn72ehhFrGDeNJzEp+QLmcZFD
	 oVm8AOEg0qSvavmFvKVAMycG9Lg/njypuKA+nAJaoIa2Ls0ENHBQYnMdh+euZL+h6ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802986;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+bt2IG1E+nqDjwjcYWzWFB4yAsVmCREWF1BmUwG6lwA=;
	b=W73MTpZhPjKK7mqms2XBuLFOgVchL4goDbMh9hBjSxZGHoGNdGXI0ACq3b8Ln+9GF8Ig
	 OYa2Gucfvn73+guV60nOX8nVRreSLjFucCnQ6UNvxKUD17+Jz7v+Y70dKmVvtT7ePTu+f
	 F28xM13x/U2oJLZlB6hD6ZcvHtBPho5125dgahjRLNQ22b1Yv8l5If5sh2XLcL8mZZUT4
	 fa0KxHiAFZDNUyclokYdYfm47xLyfJRF9PNCaqQE8CLrXcCSpKRtCA3YM+dQLrbdHzCAL
	 XOFxgtTyWHJZ1jRCTgyWerXW0YeaF39pCrGN0QEIkovHrwVpsIPOvZCKLfwJa6pcx5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cibV8QXD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD1606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cibV8QXD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0281F00919;
	Wed,  4 Nov 2026 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802986;
	bh=+bt2IG1E+nqDjwjcYWzWFB4yAsVmCREWF1BmUwG6lwA=;
	h=Subject:To:Cc:From:Date;
	b=cibV8QXDAWJ9BDfnwzZ67LOKnMG9BkNF0KC8wMunsFeWLpurTkYXspfwW7FL0IbDE
	 Z0gxt1vYSRZfED4P7E2p8L6BtgUYTkhmvIoxp1c2fR2jMDsv469Vgk/02ovNgpH4V4
	 6LFyJvBcO1X4ez4UNNN+tMjiocxrc9I/WdwfbB64=
Subject: FAILED: patch "[PATCH] ovl: do not copy up an xattr value that was never read" failed to apply to 5.10-stable tree
To: mason@kernel.org,amir73il@gmail.com,fahad@codepure.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:36:20 +0100
Message-ID: <2026110420-outage-visor-9527@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 755b5c5c9277be251a51623d6065abab948c61bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110420-outage-visor-9527@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 755b5c5c9277be251a51623d6065abab948c61bc Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 09:45:28 +0000
Subject: [PATCH] ovl: do not copy up an xattr value that was never read

Copy-up stores uninitialized kernel memory in an xattr of the upper
file, where the user can read it.

ovl_copy_xattr() may only pass bytes to ovl_do_setxattr() that
ovl_do_getxattr() has read. When the read fails with -ERANGE the
function asks for the size again, and if the new size fits the buffer
it stores the buffer although nothing was read into it. The buffer
comes from kvmalloc(), or it still holds the value of the previous
xattr.

A FUSE lower layer that answers every sized GETXATTR with -ERANGE made
copy-up store 4096 bytes that the server never sent, with a kernel
pointer in them, as an xattr of the upper file.

Fix this by failing the copy-up with -EIO when the size that follows
-ERANGE fits the buffer.

Reported-by: Fahad Alharbi <fahad@codepure.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAOQ4uxjhfpNVvoVrTayj46H2CViTOc3oxzM6xdb8+E7ikE2CSA@mail.gmail.com/
Fixes: e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index e963701b4c87..c220cb5d0b70 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -131,8 +131,12 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 
 retry:
 		size = ovl_do_getxattr(oldpath, name, value, value_size);
-		if (size == -ERANGE)
+		if (size == -ERANGE) {
 			size = ovl_do_getxattr(oldpath, name, NULL, 0);
+			/* Nothing was read into value, so it must not be used */
+			if (size >= 0 && size <= value_size)
+				size = -EIO;
+		}
 
 		if (size < 0) {
 			error = size;

