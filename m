Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603526;
	b=cFha/ULioShzZilrRK9BEzis22njj1qKdgZy/Am2T+c1ArwwMJKeX0u/ztZoXBvAaHdn
	 GGJw3/iWkr+1bqAXhNoNYQ7PoxFO4h7WTs1m1Y/r0VYAzvKIDW/zOZ1fOaWtkc8EPDsIX
	 rZ/V7IRV0REiLQchbYGsGTuz+OZAcQ7Q1uk8ZSHP5CqOf5ZtKzldnkOfzr3aTyx/Cfy5O
	 N0zd73X3Tn+BKCE5iHOHq9KHHeAisY++33P6xHujPYbyMsItgaB967PzjzhI3Lv+0MJzs
	 BRU5/LF4y6nwFxT7cO8Zu8zRl5u1SNoXfDwYPT20xAf/V1OS7LYYa35PDE1yfV4UR+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603526;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kbj8DJvZsLgT8w/mVx8XRYxB8dLVy9kwyxCIbhAoFeg=;
	b=D+OMvVw7oloJCN14QHsS7RVdWkzJBkmb/J9YfZcIQs8orjNFXAR/LOcJZConV3GZlzH7
	 O4/OLN+8zonSFu5iFXZ52PzGGNcSuB09YFX3fYxIbjhXg7Xjroy2GFBa+5t1ccG8z+fWj
	 NeP7wOr7gTN3oqeqoMbJ8QFoEtg+VuK51qHoMQfGQHFbyGZkxh9SrDhX48omeNmRrX2HC
	 IGhJAtbL3duOFbXVO7zdZ9VUV6/8GwBNgwPneILKUTMn8FdRqYJzmoY7Zr0tTH209xwq3
	 zkTmyfY7QQHoXjZgnRjn2SzSE47+BcsZXRVpmnRu2ZJDPHcrVxBl4FJTzTW2QZepXyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JchYuPkP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB98606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JchYuPkP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD19F1F000C0;
	Wed, 25 Nov 2026 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603526;
	bh=kbj8DJvZsLgT8w/mVx8XRYxB8dLVy9kwyxCIbhAoFeg=;
	h=Subject:To:Cc:From:Date;
	b=JchYuPkP6j+tmRPwtgEI0VlrctMZ6lKIfduvHQxXdUllrjiE2tlfarhTjf68W1sFj
	 MqC+dU5+ymOGMUL4zuci/55cgIklCIdW+CG5iXIcsRGbfP8q44ekzDiK7P94jnYObn
	 obzvaXMCeszxlYxaYo+2kMa85gT0g8PH1QKAjmJU=
Subject: FAILED: patch "[PATCH] ksmbd: keep group denials when a POSIX ACL entry decides" failed to apply to 6.12-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:36:12 +0100
Message-ID: <2026112512-evict-breeches-3641@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b0af9a3e6b1534d353ca6ac23caaf46127f62e4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112512-evict-breeches-3641@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

