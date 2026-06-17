Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFD22E6CC7
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666383; cv=none; b=uVze+U5Syp0HFRkZi6021K81Ta97Nn8KQh0Mi32T2DfbJYjJdIoa+b1eUyOukXU1ie22ZX3l5DiB3Rh4dFsg/Ev+pttDD7nK39b2FAHl1fVYAQcPgCVAV0eVN2h35SzOv1icsrs2e/XoxfaGno2NWvJEjMXotGybQk/up/g0jzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666383; c=relaxed/simple;
	bh=EC9QGbi5jGyHEi2lDnc/LMK1Wv+EQrIZuMxlcnR7Lyg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rUKoccyqDNov0RVzl3W9Wj+Z27r8P1BhPa5W96qTB9FUtMzbn9cmw3etxCq5I1BxaqkH9/5Vqmqwg3EtNcVEgecHNzMidHX63KLnSYDZYHvGSGCdZU4tzgGxzSEpdrDKg+2VqMqtmpgpQBvANoJpFBC+T9Sb7SFG+XjSsc09zqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ACGNTne6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ACGNTne6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E211F000E9;
	Wed, 17 Jun 2026 03:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781666382;
	bh=6NQ/cbrZU0o0Kv9GK7gtQ4bLLaboR9ZqFRpC+xOLqAs=;
	h=Subject:To:Cc:From:Date;
	b=ACGNTne6UbxXjsBvg5nA9Ds6Jnxl0tDA/XVr5HIpDQOE5Hg5paAnqmJ16GbXxdggo
	 aJ3I8hxGR86OuVyA8jAwfaXnazK6l6QgFN66HXf9AO2lSuBugyASWvKDtBCZLMqHUk
	 1yxVv345Qc81DTBeQ180bgpX0vp2LecxP4ZXzGnU=
Subject: FAILED: patch "[PATCH] ksmbd: OOB read regression in smb_check_perm_dacl() ACE-walk" failed to apply to 5.15-stable tree
To: ali.qaniyev@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 Jun 2026 08:48:28 +0530
Message-ID: <2026061728-devotee-stencil-e4e7@gregkh>
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
git cherry-pick -x 0e60dafe97eca61721f3db456f97d97a80c6c8ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061728-devotee-stencil-e4e7@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e60dafe97eca61721f3db456f97d97a80c6c8ae Mon Sep 17 00:00:00 2001
From: Ali Ganiyev <ali.qaniyev@gmail.com>
Date: Mon, 25 May 2026 10:23:47 +0900
Subject: [PATCH] ksmbd: OOB read regression in smb_check_perm_dacl() ACE-walk
 loops

Commit d07b26f39246 ("ksmbd: require minimum ACE size in
smb_check_perm_dacl()") introduced a transposed bounds check:

    if (offsetof(struct smb_ace, sid) + aces_size < CIFS_SID_BASE_SIZE)

Since offsetof(..sid) is 8 and CIFS_SID_BASE_SIZE is 8, this evaluates
to `aces_size < 0`. Because `aces_size` is always non-negative, this
check becomes dead code and never breaks the loop.

Worse, that commit removed the old 4-byte guard, meaning the loop now
reads `ace->size` (offset 2) even when `aces_size` is 0-3 bytes. This
re-opens a 2-byte heap out-of-bounds (OOB) read past the pntsd allocation
during subsequent SMB2_CREATE operations.

Fix this by properly transposing the comparison to require at least
16 bytes (8-byte offset + 8-byte SID base), matching the correct form
used in smb_inherit_dacl().

Fixes: d07b26f39246 ("ksmbd: require minimum ACE size in smb_check_perm_dacl()")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ganiyev <ali.qaniyev@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index c2d9be52a311..664b1b4a3233 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1446,8 +1446,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = acl_size - sizeof(struct smb_acl);
 		for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
-			if (offsetof(struct smb_ace, sid) +
-			    aces_size < CIFS_SID_BASE_SIZE)
+			if (aces_size < offsetof(struct smb_ace, sid) +
+			    CIFS_SID_BASE_SIZE)
 				break;
 			ace_size = le16_to_cpu(ace->size);
 			if (ace_size > aces_size ||
@@ -1467,8 +1467,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = acl_size - sizeof(struct smb_acl);
 	for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
-		if (offsetof(struct smb_ace, sid) +
-		    aces_size < CIFS_SID_BASE_SIZE)
+		if (aces_size < offsetof(struct smb_ace, sid) +
+		    CIFS_SID_BASE_SIZE)
 			break;
 		ace_size = le16_to_cpu(ace->size);
 		if (ace_size > aces_size ||

