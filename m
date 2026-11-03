Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701120;
	b=19JlFV/1aJkMZ5DeSnzvJsax53Va9bk5I3oevC6xzCTdy5wS7WkPP3oBneFzQzNeSbaD
	 a0kZtehfb0mZLBJUMHrVSNsxpo1+hOOjT8nTrFpUr7B88D44eBnci6PMilVb/rXbeG15W
	 JuQSElyf5AqxQ1pcSvDhkM40rkvR4LiflcMDxU4gVQ2JuezhNKi0tcK89e7pS2gdJ0bBe
	 e9zRNVSs050/6Qg3qO7KUxP9IJEgOJS1Tn/uuRrspTg89ipCNOM+YR5Xzt67Q+1G12Udt
	 vjYoei2uy5DfZNaM6r/vQ2AYdt2nNxv3VKlKtkrCoBd2sRHv8962ADE//8Xw2CwLvCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701120;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e308Hkry4M4hRMNrtDYyA1syDL61zo4wyS+Tpfntrvw=;
	b=oUyxj3SplteKXV1lzTxLHvnGx2jbLAKoplB26zz/IK3AytJzcvIyWeuLYgcTKenJLJES
	 S23U2gNzqu9dDLXM5zZg6WRKTp3AbtXVtBcfXPP0BpzCzG2UgbrwrKLqjqjwHOz3W678p
	 WocFEoktGGJNpMYeMDOtk1vYmLvJ/esHYhQYb02jJdEi2oYriSMx1OOmRsAZ3L+hWjEtl
	 Cd6e3cMulpgUxFlptVPgJWitfZ7dYzbJaEIQ2cpLXeKoHYw1JojwQCgsE2YpP95aC66VU
	 i+awdymcFfYYQWrFLiZkhOarVxOJ6JESiy8N/60DqPpV0swMEu5P+C5HaI/T//R9hog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fc0GDIWe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D166083618
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fc0GDIWe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7640A1F000C1;
	Tue,  3 Nov 2026 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701119;
	bh=e308Hkry4M4hRMNrtDYyA1syDL61zo4wyS+Tpfntrvw=;
	h=Subject:To:Cc:From:Date;
	b=fc0GDIWeATGaiKGqLZA9D1tixchdBI+unzCgN3QSNhZZYy5Y8U5N6jxCd17jwfqDJ
	 eRjXHqyRj+JHvr0J+lQOXsUW/VrtDM5wybBOUOl1hZxg0VIjR7GgWzRI+wE3fHyDLZ
	 f2hzouRP/dZ+e/u5h9vx4vh8k9W53/0GJu/tHuOg=
Subject: FAILED: patch "[PATCH] ksmbd: prevent share root removal through empty paths" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,zachariah@aplosai.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:18:38 +0100
Message-ID: <2026110338-sandfish-raking-bd5b@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9fd1fcbbf84986a7bcf601a2b90540899069d263
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110338-sandfish-raking-bd5b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

