Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817106;
	b=ctwIbQM5lMRXsVu9yHt7G/8gIk+rNqNT0Y62OChPHcoq+ZK+srXXqipt6FaIrRwf54Vg
	 BmnXfHHm7YsBJ1gzrDNxmYvpQVwJFebYkxHag8t956lVVGUE8q594/05JhxXeQDwvc9JY
	 t733uVk+MoWHOwyW5ag3nVvN8gI6mu/iq3pR48v1NELN+5z+agC8/YqYJVlNQ1en1VPIv
	 w6PHlCD5beLmprNlXD8s215Hx6/zD1gQgoWGB3lP537eKSOydPXMtTXTyPBJ/6b23ix3E
	 RZz5h9jhlGQ2ZpZgR9dUORBdND5njTc+gLz2OS+VtS1HerJYhu6T2Z+GUcr0oa39BNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817106;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kuOQPJNaCZ+bc4l7qS7ZYHU/7VAqXHEK0xhmM6+JD/Q=;
	b=EkbZIh7hoHOkq/bNQXtBvoEMR9nj86oc6HB7AzPFq1COk0uR8sN/RGpO7dysVZcQJUaK
	 9VMITfKXjJOmeYK6Y83qvy2vz+HRaJqR4oCU/8qPM8rNhCLs96Cg74GLqaGGl0vXSevuc
	 LT5LTF7emBaHBXiMqOpaDTjBKNj9zMbjjpPg8tEP0IaDEAGxSpPnu9H38uD4hX2wPZzS3
	 eGiuBFaOaRJlFHjHd//Eis6xLsFCCLlKuKNtqsAZJaTWlibImv8LJi4uHbjamQ8f7EqH6
	 n3wSnqiMe0rt5UOmZlsdhiHWz4x1rX8oxOcGt4ct+5jNtubnWNL57/15playCoFP1og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tannaRRT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800F606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tannaRRT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D998A1F000C1;
	Wed,  4 Nov 2026 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817106;
	bh=kuOQPJNaCZ+bc4l7qS7ZYHU/7VAqXHEK0xhmM6+JD/Q=;
	h=Subject:To:Cc:From:Date;
	b=tannaRRT70h4lOrsLBpafj85xNXeSye6Y7qSYOewWEeztNB6Ogbk6EgFmvA+wBdP4
	 ADN6FWjnVpKCtiEymp79QD7URs0bNl8OcY/XACQ6TGGT4eQV2g6Q2dpDT6sy/KNqWQ
	 gDpFBXPrcjdagntEeGbmgbnGQ1UHNpi90L+jc390=
Subject: FAILED: patch "[PATCH] smb: client: fix slab-out-of-bounds write in" failed to apply to 5.10-stable tree
To: dmnk@google.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:31:43 -0500
Message-ID: <2026110443-name-around-1b66@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a377a3645c7d0246af0bc4ef24db94bb2670bdde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-name-around-1b66@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a377a3645c7d0246af0bc4ef24db94bb2670bdde Mon Sep 17 00:00:00 2001
From: Dominik Maier <dmnk@google.com>
Date: Fri, 23 Oct 2026 01:21:16 +0200
Subject: [PATCH] smb: client: fix slab-out-of-bounds write in
 id_mode_to_cifs_acl()

In id_mode_to_cifs_acl(), while the chown branch reserves
sizeof(struct smb_ntsd) + 2 * sizeof(struct smb_sid) (plus
sizeof(struct smb_acl) and the worst-case ACE space after
commit 0ee150794c75 ("smb: client: fix heap overflow in DACL owner/group
rewrite")), the chmod branch only adds 2 * sizeof(struct smb_ace) or
5 * sizeof(struct smb_ace) to secdesclen (or 1 * sizeof(struct smb_ace)
on posix).

However, the chmod branch also invokes build_sec_desc() ->
copy_sec_desc(), which unconditionally writes the Owner SID at
pnntsd + sidsoffset and the Group SID at
pnntsd + sidsoffset + sizeof(struct smb_sid) (2 * 68 = 136 bytes total),
and set_chmod_dacl() always writes a struct smb_acl header (8 bytes)
even when the source descriptor has dacloffset == 0. When a security
descriptor has compact or overlapping Owner/Group SIDs (or
dacloffset == 0), calling chmod() under-allocates pnntsd and writes past
the end of the slab buffer.

Reserve sizeof(struct smb_acl) + 2 * sizeof(struct smb_sid) (plus
sizeof(struct smb_ntsd) on the posix path) in the chmod branch of
id_mode_to_cifs_acl().

Fixes: 7ee0b4c635c0 ("cifs: fix hardcoded default security descriptor length")
Fixes: f5065508897a ("cifs: Retain old ACEs when converting between mode bits and ACL.")
Assisted-by: ARTIST LLM
Signed-off-by: Dominik Maier <dmnk@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index d1a92bb4d9a5..f9f61c758a75 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1826,12 +1826,15 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 
 	/* Potentially, five new ACEs can be added to the ACL for U,G,O mapping */
 	if (pnmode && *pnmode != NO_CHANGE_64) { /* chmod */
+		nsecdesclen = sizeof(struct smb_acl) +
+			2 * sizeof(struct smb_sid);
 		if (posix)
-			nsecdesclen = 1 * sizeof(struct smb_ace);
+			nsecdesclen += sizeof(struct smb_ntsd) +
+				       sizeof(struct smb_ace);
 		else if (mode_from_sid)
-			nsecdesclen = secdesclen + (2 * sizeof(struct smb_ace));
+			nsecdesclen += secdesclen + 2 * sizeof(struct smb_ace);
 		else /* cifsacl */
-			nsecdesclen = secdesclen + (5 * sizeof(struct smb_ace));
+			nsecdesclen += secdesclen + 5 * sizeof(struct smb_ace);
 	} else { /* chown */
 		/* When ownership changes, changes new owner sid length could be different */
 		nsecdesclen = sizeof(struct smb_ntsd) + (sizeof(struct smb_sid) * 2);

