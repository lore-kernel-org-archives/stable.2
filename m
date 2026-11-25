Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603518;
	b=QArk2jiVaEYxDIN6BWWDPGu8yHh9rs+bGiR1+2YffX51p+ar/+C2w10bsxYW4P0Rno3c
	 yUuk9KuFBKhVO3rKA+Gr/Zky3ZrxSJBpgT1b8xJeiRpOly0bBvXQiLmeEGCChbGIUjrn7
	 DTHbi7Z1EJ6ZoC/hRTBPDvLGSsI2x9PWr8l49ANWMMi+Mc/ekFVs8UPG05WXko0xAdBo/
	 Xep3rfQX0lFA1KBffRcwbpvIUNWr63lloh4u5h8bPAfi2Fk8FW0wlx1E65Oy3q+a31lLc
	 2auQ0ivAHo1uCKzXeOiIWKW0X02P6G7p9N9I56PWWDebl6csMwYGdf5th48biOc4N0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603518;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Hdmn2v1UWMGye85BKAQml731rR2LVysV0ncxnPt3VJA=;
	b=xjM73/hsoSDmJ90Zy3S+2PPMyD8F1M09G776Jr1lWOy28oShnN2o0sNhAFmos93WCtYe
	 Cp0+hT6y+1n9dOfocf1PhYAbUaFeTjxyip76B7kbLtrEo/ohCK0xnP6bsNn/uiUGfh8vx
	 MogvgtrsVQh8f4LJ31jxlkhfT+DiFHo2ZrWtLKF9+OJJTxWb2Gy1P1bCv0DgJTiFfuu/7
	 g6I6YSzpX+zM9TOzLrSFzOoxWIPlH6C9XUQlZQq2YWWDwxUZhdv5yjO+eN+1dOIJkJbrv
	 uU8BjaZjAhA+ZugZqjct0B+rlOt4FWfquglRSzxMqZun3K1UDofi4KvlNAxNBsENw1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YcntHQvx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E1606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YcntHQvx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F781F000C6;
	Wed, 25 Nov 2026 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603517;
	bh=Hdmn2v1UWMGye85BKAQml731rR2LVysV0ncxnPt3VJA=;
	h=Subject:To:Cc:From:Date;
	b=YcntHQvxKZhl2G1TnLDodNzT3iYfgFkQR3DyEFrATg37KLk+6PxMbGQ4+oYecY/XM
	 dTKbsqqkgYbiZbn/jgBZ1iXcAEuh9AnZkO2tv76rbUxndAfGbP/jNNzgiYu1dfXOeV
	 j6FCyQ5nVKUJTR/FWPsLgzF0VIwlnXfgiKQHn5Og=
Subject: FAILED: patch "[PATCH] ksmbd: keep group denials when a POSIX ACL entry decides" failed to apply to 6.18-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:36:11 +0100
Message-ID: <2026112511-cufflink-wool-8a84@gregkh>
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
git cherry-pick -x b0af9a3e6b1534d353ca6ac23caaf46127f62e4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112511-cufflink-wool-8a84@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b0af9a3e6b1534d353ca6ac23caaf46127f62e4a Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Mon, 9 Nov 2026 20:33:44 -0600
Subject: [PATCH] ksmbd: keep group denials when a POSIX ACL entry decides
 access

When no ACE names the caller, Everyone or Authenticated Users,
smb_check_perm_dacl() lets a POSIX ACL entry for the caller decide
access. The entry's rights replace the result of the DACL walk. Deny
ACEs for the caller's groups, and OWNER RIGHTS for the owner, are then
lost.

For example, a deny of FILE_WRITE_DATA for one of the caller's groups
should refuse writes. A POSIX ACL entry that gives the caller write
access still lets the caller write.

Remove the requested rights that those ACEs deny from the entry's
rights. The DACL walk already records them in grp_denied.

Fixes: 42ac1f1917ae ("ksmbd: grant a caller what its groups and OWNER RIGHTS ACEs allow")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20261102200353.884509-1-icb%40fastmail.org
Link: https://sashiko.dev/#/patchset/20261103150458.11591-1-icb%40fastmail.org
Link: https://sashiko.dev/#/patchset/20261107062233.1579198-1-icb%40fastmail.org?part=1
Link: https://sashiko.dev/#/patchset/20261107231941.1824289-1-icb%40fastmail.org?part=1
Link: https://sashiko.dev/#/patchset/20261108182011.1888520-1-icb%40fastmail.org?part=1
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index a81f17fa725a..6b5f22d6280c 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1771,6 +1771,15 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 					if (!access_bits)
 						access_bits =
 							SET_MINIMUM_RIGHTS;
+					/*
+					 * Only ACEs for the caller's groups,
+					 * or OWNER RIGHTS for the owner, apply
+					 * here. The POSIX ACL entry does not
+					 * grant an explicitly requested right
+					 * that they deny first in DACL order.
+					 */
+					access_bits &= ~(grp_denied &
+							 requested);
 					posix_acl_release(posix_acls);
 					goto check_access_bits;
 				}

