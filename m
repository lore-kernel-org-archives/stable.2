Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6545221EA
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577314; cv=none; b=O04QqlLf8EHbe4zQO4Gp2KmjR2a8d5tHYshYHytckwddjmi2lQpoh+jGN4/qGslXh+74667zxVKfI9oQ6Zhb7KONnKDXuNt/2cykne46wy+JZh5kwfOi15ha3DhmuETLhaRxhDtbSao7hHKjLnZSgsjNGz8Mvw5tLeP8M6dzVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577314; c=relaxed/simple;
	bh=3i92DuYaL/6G71JjAeIN2b7O5naAJWEy6NXq6RVlEyI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J/fHvye+zXgBzhXpHren+YIGw9HZxsyda7G+A89x5tWDeaCHhozKW1uLtCLzC0+gqJaYbeMtBCzxp6PXbfwNToW7omqS3wnuWCCp5TDtT6Ld3H33vy7T33KH0lM6PkIiIJxJcw57OqjF5ODCjKRkJVCsKBkCg1t0nVGuceO0Krc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PtTMk01B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PtTMk01B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C921F00898;
	Wed, 16 Sep 2026 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577303;
	bh=uqz1YxiBNsjW4Dc/x6xqqmnYhywXYhha1zvMHIJ1Zsc=;
	h=Subject:To:Cc:From:Date;
	b=PtTMk01BOXSmTXybwZJMTuYqMircDA+YWgFADCZfKnVMAalDaYOd+lo2xgyMGi9qp
	 FGfhoZb0amU8POrZdd2ZAHCEIWgzoFMX37PiKP8iGwYPoxqV246W/+eGyMD4nydEze
	 ktRXcGeyYq0pSP/D1IGF90t6ihNSxzActYBJcAtA=
Subject: FAILED: patch "[PATCH] smb: client: fix uid/gid override in getattr with posix" failed to apply to 5.15-stable tree
To: pc@manguebit.org,arthur.lesuisse@ulb.be,bharathsm@microsoft.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:42:36 +0100
Message-ID: <2026091635-untwist-absently-462b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x cf4d35896621b7298eef51b7a465e5c0cb22f670
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091635-untwist-absently-462b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cf4d35896621b7298eef51b7a465e5c0cb22f670 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 6 Sep 2026 14:39:44 -0300
Subject: [PATCH] smb: client: fix uid/gid override in getattr with posix
 extensions

When mounting with 'multiuser,posix' options, cifs_getattr() overrides
the server-provided uid/gid with the current process's fsuid/fsgid.
This is because the condition only checks for unix extensions
(tcon->unix_ext) but not posix extensions (tcon->posix_extensions).

With SMB3 POSIX extensions, the server provides real uid/gid values
just like with unix extensions, so they should be preserved rather
than replaced with the caller's credentials.

Add a tcon->posix_extensions check to the condition so that uid/gid
from the server are properly reported in stat results.

Reported-by: Arthur Lesuisse <arthur.lesuisse@ulb.be>
Closes: https://lore.kernel.org/r/DB9P190MB2012266F6B8DECBE5D26A1798DB52@DB9P190MB2012.EURP190.PROD.OUTLOOK.COM
Suggested-by: Arthur Lesuisse <arthur.lesuisse@ulb.be>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 12ed8db10e00..49f9993ad567 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2992,14 +2992,14 @@ int cifs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->attributes |= STATX_ATTR_ENCRYPTED;
 
 	/*
-	 * If on a multiuser mount without unix extensions or cifsacl being
-	 * enabled, and the admin hasn't overridden them, set the ownership
-	 * to the fsuid/fsgid of the current process.
+	 * If on a multiuser mount without unix extensions, posix extensions
+	 * or cifsacl being enabled, and the admin hasn't overridden them,
+	 * set the ownership to the fsuid/fsgid of the current process.
 	 */
 	sbflags = cifs_sb_flags(cifs_sb);
 	if ((sbflags & CIFS_MOUNT_MULTIUSER) &&
 	    !(sbflags & CIFS_MOUNT_CIFS_ACL) &&
-	    !tcon->unix_ext) {
+	    !tcon->unix_ext && !tcon->posix_extensions) {
 		if (!(sbflags & CIFS_MOUNT_OVERR_UID))
 			stat->uid = current_fsuid();
 		if (!(sbflags & CIFS_MOUNT_OVERR_GID))

