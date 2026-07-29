Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7B326A08F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333368; cv=none; b=EnNZDZhzDdfRDdnZPqDtnjG+4GVq5R/KlOjoTMs6TabBQyVW3DGGwDSNIgn1Uzw4ymRCPbmOak51RPc71RU9glMEOtoB+AJmEP6Pw2/MpPh3c382k80gI+L2Ef+lZWlvrQeD0hgZ6XRu10J4DDndMIrTTCdDEAYuUrhc56SOl50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333368; c=relaxed/simple;
	bh=fgy8U3D9SKVVby/hWdJ7Q/yGJUwZpz3jqNoFmqo/uQg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=slUj3ATRl97d0tJhYxWqdD7ZTf5i9q2ENxNFHA94LbINt/wvLS3lWCB2xSQxXKNVa8xRehTg1hMsmL6kMwBSU9+UiyEd6rLph2ERLZMbbVnyfHd5WwpxELjRyXDzPlDNJxSIhD5qkOiN6NCkKxvhxHhcXiKWMeMqRgg9j567aY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WOK4BVrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WOK4BVrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8FE1F000E9;
	Wed, 29 Jul 2026 13:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333363;
	bh=WRMvSELZny9FtgemrA/oHdy+j3r29CMCv0H/9IS2G6U=;
	h=Subject:To:Cc:From:Date;
	b=WOK4BVrBhQL4Hbx/riRH55C8lTws94p+wKNj45NDxiV18Fwf9HoyeCPPepkw/xno7
	 OUAbsHH8EG9+tf3yiZQF8057QTq6AgZpGbYl/kfQ4El54l0UzewQ8T+HTaTiMiXKbc
	 oqlttptWa/vNJ9kRwR5Vqkk9X2u89sIBp4g69OY8=
Subject: FAILED: patch "[PATCH] ksmbd: restore DACL size on check_add_overflow() to avoid" failed to apply to 6.18-stable tree
To: guanwentao@uniontech.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:55:36 +0200
Message-ID: <2026072936-equipment-calculate-e753@gregkh>
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
git cherry-pick -x bbf0a8e931204ecdab494a88d43b0a24a04285c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072936-equipment-calculate-e753@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

