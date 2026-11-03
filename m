Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702865;
	b=uQ9ULTvQEpEFmgWcIosC9Wz3L/nTukJ/TdA9/5gaTddJRcYfnJWNX+9hZRzPemioWthe
	 Ys2KUTam50Idw7C0cExJWocgCWVXmbGj4E1St2uBK/4e3/aUgITWZgEaOKPoGCEjbIaLd
	 xXlS+M4gqicBmyXwWJkrf4FO7tc8TGczqwKwI+k46ADHBNY9nw/M6aFnhXjVIM9YNddcr
	 BYzQwH6zdEiYUcAGZDUa2QGBn8OK02cNaWz2DrBJ6hCuJVurDKDGqVPvnv3CfGD2CR9J6
	 oJ3W3FYPLC/soZr2etzWaa5krqzkmIjxqeONuEmkrAkCVYY8aj/LREsFl5W1dXZmcCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702865;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AoWNUg8WACkzfJPDutbhuYm9Uvq7xkBtAqRFFFO8xp4=;
	b=ipaUT8zoKaxyavGvol2QvLLOKBEyy5kgWHW1srCCQ0ZKZ30qCHSWuli2eZ7CpaI7b59m
	 vi8sFnpfItR5Yx7Be0jY6PIrz2MMluTWZ9ruRkLrF1wOyURSDlAj/wkmywC9IMT4Er42l
	 QLkGBKgtkpWfoU2Zw4FCzyg9HVBqr+LPG56daSrEcki/X+x6kmDzqzvFOCkRydAnc3JL/
	 JB80bR4HNAZdgdy8keAV0HkGhDOleprVtD52AyjvGgZovbcLMU58sk1Zxg0o5iHwfIXAb
	 o2UfakX9ByynleZRM2OoMF52x1UhZnxEkf5FF/UW75ZGPkY6bUcKxxvOkQhcHnoJWIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eT+gMmKk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3D60736C0
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eT+gMmKk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BB01F000C1;
	Tue,  3 Nov 2026 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793702864;
	bh=AoWNUg8WACkzfJPDutbhuYm9Uvq7xkBtAqRFFFO8xp4=;
	h=Subject:To:Cc:From:Date;
	b=eT+gMmKkXaf6DKtpsOAeHkmKhiiZIDf7UeGkvdJxMnDQD5cVG3+k3puAZvtW7/7iE
	 BBkIkFpIF4uHdaLqdv0L0zpmQwtEwhVx1wnGXrffhZITMEukOEiYBxLbn2ZjpnivJo
	 DQhRZ9vVfwdYmJ/afASzhOWFs96elNEENH1zqIRk=
Subject: FAILED: patch "[PATCH] ksmbd: prevent share root removal through empty paths" failed to apply to 6.18-stable tree
To: linkinjeon@kernel.org,zachariah@aplosai.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:45:36 +0100
Message-ID: <2026110336-chatting-upstage-25a1@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9fd1fcbbf84986a7bcf601a2b90540899069d263
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110336-chatting-upstage-25a1@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9fd1fcbbf84986a7bcf601a2b90540899069d263 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 23 Oct 2026 08:53:57 +0900
Subject: [PATCH] ksmbd: prevent share root removal through empty paths

A FileLinkInformation request can supply "/" as the new link name.
smb2_get_name() strips the trailing slash and passes an empty string to
ksmbd_vfs_kern_path_start_removing().

ksmbd_vfs_path_lookup() resolves an empty pathname as the configured share
path, without LOOKUP_BENEATH. With ReplaceIfExists set, smb2_create_link()
can therefore remove the share root from its parent before link creation
fails. An authenticated client with a writable share and DELETE access to
a file can trigger this if the share root is empty and the mapped user
has write and search permission on its parent directory.

Return -EINVAL for empty pathnames when for_remove is set, before
resolving the share path or acquiring removal resources. Ordinary lookups
continue to accept empty pathnames for opening the share root.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Cc: stable@vger.kernel.org
Reported-by: Zachariah Mithani (AploSec) <zachariah@aplosai.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 5360c6999bb3..4ee72eda9bc0 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -62,6 +62,10 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
 	struct dentry *d;
 
 	if (pathname[0] == '\0') {
+		/* The share root must never be removed. */
+		if (for_remove)
+			return -EINVAL;
+
 		pathname = share_conf->path;
 		root_share_path = NULL;
 	} else {

