Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702868;
	b=swgEeJ8ZOlLwwW9zaQ5lcakE1/7DVZYrEME32TQz5xy7PvLJwr2r5vxqHYi81rNdSIKa
	 7NzTmbhxsx7Ne8Fd/vjI0hR5lEMUgyTn/bDyN4tmoFr81iWQUODNLXzEM8DkAq+znRc/h
	 wsCoB1slBTXOltYjdBrIo7/FGYejyhAy2phr3YPzW4U6NicUX3z3eY797dmyG5BCVKYTt
	 tISvYAAMybMmuE909EA8Iz4kCgv8spLoTDMzcILubDoPjmPVBPqEmXv/KqlW7o+ymkpEO
	 xT3p60/5L9OKQDe2EZPKl5kXOBGGZxkz/Hn2jmGl4+yI4fGzsojVpQeBr5xpUmCNh6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702868;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pUDn/bDBHFFPg15IWdAi3JzTlZmCSHu0oWpw2norP4M=;
	b=Po6Yiu1tTgxVofevLRE8akhqdqw/oJnzTV+p+DETi/DKe0maahWH/014eNWu2Nwd7IdF
	 F5Z0NOOsxXFHeHqhv5LyQXrU3DrNLFr6IkIfU75dxc7v/tTdNt8g5EUxkDGmA2Oj2K21k
	 FwS0wv26JB9ihL3ebKUCVExLLwGSbhEBp8R+8UuKQE+XbWyjSDl/tSCwNmNhpJzh/3X2r
	 yCRA4n0nCTf4VVR87wmGP1SnODQOvYHB3w6lZO1gzP53vz3gF0Jx7ZtOMH69MaMPoN1Bu
	 HLboAgSoYvs2gd7dg19pO5/WyuMwXm4r3OmtXttlATDX/41m4xrn28ex7uszbCuIN/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gZl9E01d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD386073787
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gZl9E01d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A8E1F00919;
	Tue,  3 Nov 2026 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793702867;
	bh=pUDn/bDBHFFPg15IWdAi3JzTlZmCSHu0oWpw2norP4M=;
	h=Subject:To:Cc:From:Date;
	b=gZl9E01dz4O1BkSFt8VwZKDn+qoyqWCk73q4SfVoVx/OIXwaRFmuumAOOdwqUagvY
	 UBp5xSQ+rgqEi6koB1SCeLGSZxFmfiLz9x4/GB21cnUJliW+5epQsFo90r/aajOdPx
	 CSfPtO1t443qoN4zXIFmXNGvKzwVH/SXwUehOP5k=
Subject: FAILED: patch "[PATCH] ksmbd: prevent share root removal through empty paths" failed to apply to 6.1-stable tree
To: linkinjeon@kernel.org,zachariah@aplosai.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:45:37 +0100
Message-ID: <2026110337-undivided-femur-faa6@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9fd1fcbbf84986a7bcf601a2b90540899069d263
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110337-undivided-femur-faa6@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

