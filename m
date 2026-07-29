Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E44949E8
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333365; cv=none; b=FnIQ5xlywyNDEFCcwd7O4atd6tBCdwVPuAtvy9wODH51bAPxq/ebxdP9Oob2qau+K986WQrWb2DDAydHzpKoR+rEdNq0dk2qSlp4kbTPy2NfbqGmDOZF3fgVAl3WL0O3EnHxm7DnlAC3rj0RQcQDOKnx8Ko5z500BiX/+dAkryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333365; c=relaxed/simple;
	bh=0IsItg0quynVQ6cghlNVG8chkvEunG2riL4auqv20s8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ssl1IOzoCpcRkUYU+yms8ARear+jAakHLJp5g1EYsR34HuwPUtg8bvNaoH8SMx2MV4+bxfJAMaG9XmRRKpNiUGsZrFTml58AgYWBkVe+bmEXhNIOI+Bkl+p/ez/pgE0g42xtKhH9jW+6zInYg0WG1P0hpe9eukfDtCg8AQ18Cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xKFWdrUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xKFWdrUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112E71F00A3A;
	Wed, 29 Jul 2026 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333360;
	bh=4igK4E5kHI+4IoZAhtOpM5h/7BQX/pZyg6ES0QHPGcE=;
	h=Subject:To:Cc:From:Date;
	b=xKFWdrUVpWUeMPKPICJJM6xYI2sR6BGnkgF09JQjODfhdxLvQQG8fFTlDWgWEweYG
	 2qNvDVdfnY+kdPsnl9ixICOes7rGBprnbnEiWrDS+5xQhxtkJkrT/rjvLs7Uikw+Zx
	 r52jIdDUF7IJHcJL9Picvkf7JT3X6K/kvGqzmBDU=
Subject: FAILED: patch "[PATCH] ksmbd: restore DACL size on check_add_overflow() to avoid" failed to apply to 6.12-stable tree
To: guanwentao@uniontech.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:55:36 +0200
Message-ID: <2026072936-idealist-delicate-86ff@gregkh>
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
git cherry-pick -x bbf0a8e931204ecdab494a88d43b0a24a04285c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072936-idealist-delicate-86ff@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bbf0a8e931204ecdab494a88d43b0a24a04285c5 Mon Sep 17 00:00:00 2001
From: Wentao Guan <guanwentao@uniontech.com>
Date: Fri, 3 Jul 2026 11:22:09 +0900
Subject: [PATCH] ksmbd: restore DACL size on check_add_overflow() to avoid
 malformed ACL

check_add_overflow() unconditionally writes the truncated sum into *d
even on overflow, per its contract in include/linux/overflow.h.
The four check_add_overflow() guards in set_posix_acl_entries_dacl()
and set_ntacl_dacl() break out of the ACE-building loops on overflow,
but the truncated *size is then consumed downstream at the end of
set_ntacl_dacl():

    pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);

This produces an on-wire NT ACL whose pndacl->size under-reports the
bytes actually written by the preceding fill_ace_for_sid()/memcpy()
calls, yielding a malformed ACL that can trigger out-of-bounds reads
when re-parsed by clients or ksmbd itself.

Restore *size to its pre-addition value on each overflow branch (via
`*size -= ace_sz` / `size -= nt_ace_size`) so that after the break,
*size once again holds the cumulative size of the successfully-written
ACEs. The committed ACL is then truncated-but-self-consistent rather
than malformed.

The ksmbd DACL builders are the only check_add_overflow() sites found
where an overflow path breaks out of a loop and the destination value
is consumed afterward. The other nearby break-style cases either
return -EINVAL on overflow (transport_ipc.c) or break without
consuming the overflowed destination value afterward (buildid.c).

Fixes: 299f962c0b02 ("ksmbd: use check_add_overflow() to prevent u16 DACL size overflow")
Assisted-by: atomcode:glm-5.2
Assisted-by: Codex:gpt-5.5
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index d28289188e44..f285b4f24a5b 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -663,6 +663,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
 				pace->e_perm, 0777);
 		if (check_add_overflow(*size, ace_sz, size)) {
+			*size -= ace_sz;
 			kfree(sid);
 			break;
 		}
@@ -677,6 +678,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 			ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
 					0x03, pace->e_perm, 0777);
 			if (check_add_overflow(*size, ace_sz, size)) {
+				*size -= ace_sz;
 				kfree(sid);
 				break;
 			}
@@ -722,6 +724,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
 				pace->e_perm, 0777);
 		if (check_add_overflow(*size, ace_sz, size)) {
+			*size -= ace_sz;
 			kfree(sid);
 			break;
 		}
@@ -765,8 +768,10 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 				goto next_ace;
 
 			memcpy((char *)pndace + size, ntace, nt_ace_size);
-			if (check_add_overflow(size, nt_ace_size, &size))
+			if (check_add_overflow(size, nt_ace_size, &size)) {
+				size -= nt_ace_size;
 				break;
+			}
 			num_aces++;
 
 next_ace:

