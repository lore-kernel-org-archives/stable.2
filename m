Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603055;
	b=S4aT5XaulLuDfeWpzf+/TJdEaXWis8VMQpt+M5tXYdJWU5sCRblK3LisYpKuVKHadlQ6
	 St4CTCiPtpU7TQ4x2hg5ihNhGVvJRl4RssQ1CHyzc8rcmlKJgBmG4rYvbZY5c/mnhswwG
	 XAA/Xul8vv84w9fiMa8oVdKkEmVPwHON7eMEPRE/kQjAbYcd4P3HzVEAXdluKpsjkHNqI
	 Q8Uq2rJkB/lfIkuqipD1Vb6I+ESPVW+zeZLrZXN9sR8I1/p6OjJ1fkSPVXCkm6LqoIN+S
	 QUW6gxK/LXZQ7oOQTmL/siKbottoR6NRt0lAl97BhEG3Vio/jkeZWS+NnmANBZRQZKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603055;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mb9uaGLF5eXuc5no13Xl26sTr0lFaf3vvsWgP0MZLls=;
	b=uask3ZK3ILN3jkJkHb0fDi0VDCAsu8h2svwfvNoWRbo5Rv7rL0FD2XpL2JQ+KS95TKe1
	 jhpk4nfwMzVPxI4vAOgbP/8b6Fg21iYFZXu3QtIaWNAhS6mlgFSpi40dtKfnDQMhiA4Xf
	 FawQqe4W1aBxuvZwYLejV80SM13vImPwx8J6beEYhY/oTiWMvn8i9JCYAcW5tCAeuWPrT
	 lPlJlqEXygzsOQt3yJjhXAk6ikPZKY49m8uSYNgplhsPAgyW/prOvoq8jHeCzebQaMe5d
	 8CZBQ9Cjc0n7jqb/x/bS87TVUnuo2pkuvykbeenO63Gqakr4sS3eUGFJm//xoNeJOBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aD8+U5vm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FBF606A335
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aD8+U5vm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972D51F000C6;
	Wed, 25 Nov 2026 10:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603055;
	bh=mb9uaGLF5eXuc5no13Xl26sTr0lFaf3vvsWgP0MZLls=;
	h=Subject:To:Cc:From:Date;
	b=aD8+U5vmDtK0W6b27jBVbXloTddOMiik6nU5Wm/DiOMSm+JU6qvPUJQ2QfKavC85N
	 okNBDPV0vnNkyUEHC+s9TXVPSTi1skIsX58feVAvnsGvRrvYFGCaGoouD6V1pB4KrN
	 LRsL2UyG6rSwrSP14WZHPLI+PVtjfVifTHxze/ws=
Subject: FAILED: patch "[PATCH] ksmbd: keep group denials when a POSIX ACL entry decides" failed to apply to 5.15-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:24:38 +0100
Message-ID: <2026112538-spoiling-hardener-c7b0@gregkh>
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
git cherry-pick -x b0af9a3e6b1534d353ca6ac23caaf46127f62e4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112538-spoiling-hardener-c7b0@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

