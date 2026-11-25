Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603521;
	b=I04iUFa1yEvXDj2duB1QMHC4qeQDlFn08hb4TzViKBfMVnd99lP079COPpZ+JEW/8qCM
	 iNpZWXrF2RYaxvzRe8y5jALuz0tv2a0N5fpGGAww1Ib+AWcRl8Z/63Xt6H4N45DuGtcTJ
	 s9QqhnfuRjDtjXUJ0rqMZx7ekWwwq5+51sJXJALaBozjcA12V6px8/9gLX6lldwS8VS2P
	 rO9jn8og6k4kNYgOUO8bT/P7WkYAe9GBmBqR8zhpPY/Q2BmFEAs+Xlq8LdSPJLix1eHoe
	 yxJranzgahUrslcvDVYbUgwUHDt4ka3ZXTcosRii2yCmzTzgjCeUTKI10h5/VwrmnXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603521;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=T7crWW398PplhWJFDcUegBMqprzeSu9sblXj/B/6m00=;
	b=B367z2BrP12L0Ummz04coTdiR4hTsYKPxKbszGc9ifT2bI3VbVnOOmlo+kdtLL3rCOAJ
	 GcO4fVjiMOHWRW7fRd0C74Dsd3eUORPMCkKQbffdGOjeQDAyIydGr1uvTR60d+i/t4eof
	 Q/aI4TAnS1oOoib5cTAiA6Tq7Iz6/98eyhZnJUdJAN+JjAOw+XpFOjiobosyDRYpxxzOq
	 VJ/3CnjHVcW1RWqbQIhZBXfaDIFWG/6j6yR3aZXh3SNvDqSP/8Yr8XM8ue/cs7FoFEPU9
	 Qo1ugzBu43uajt+YLkyaV1pkhpVBOek95pBkKK8lkufykbgKK2b78zJa+OA0aKor9Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WJQMPP8O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE13606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WJQMPP8O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216A01F000C6;
	Wed, 25 Nov 2026 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603520;
	bh=T7crWW398PplhWJFDcUegBMqprzeSu9sblXj/B/6m00=;
	h=Subject:To:Cc:From:Date;
	b=WJQMPP8OBhuxOm/Tgf26ZlAp0HDSdLs4oFAif1r0oP9JjXIuRRYw0f24uZKm33e2z
	 IiUv+8/OawB7uRAb5pfW5IqajGMeJRs4AE+6DDLeiKSArQdcxQHI3G3ZxCz6suhkfT
	 M5dnYlQej5MQ1VhtK4KFPfjGN6y+jrNnZ+A8ffLU=
Subject: FAILED: patch "[PATCH] ksmbd: keep group denials when a POSIX ACL entry decides" failed to apply to 6.6-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:36:12 +0100
Message-ID: <2026112512-uncloak-mammogram-c33f@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b0af9a3e6b1534d353ca6ac23caaf46127f62e4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112512-uncloak-mammogram-c33f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

