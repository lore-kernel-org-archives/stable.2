Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817105;
	b=0BEyxFY9ECCKgEyJxlF9e/nXauXHOoruIJUM3q+Mff0SXbK6fRrGdrT/5DA2sFCAeQnh
	 tZv93yw2guUHoZNsYdOFkLGP/3DTzLNfl24I0vUjrotcSG9S4nlGYbDMmDlG13SM+ROa1
	 Z0GmCH/AL957SHVU2RNlmXrZ9Y18Fm/4fDTC3dv3l/gvyDhTA3EuJGmYOunV2dAKChN0C
	 TyE6Esl2AwzgYl71S9kSRPteGDcRBjLxikrgbgIcfsuOx8W0s/Lp+bnQLsQkYfbMiA+Nj
	 yfpJfmwBLngSHYNFiUpGAXrIAIqwen+wI1VpP/15xZrL4HzCgT6mZ7b8FwF6WBFr9qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817105;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sWf3cYtTPY5eG3fGpO84ehBGNjdfonIHa6TUM/ypILE=;
	b=3L/u+XOKt21zZ9TALNjlHpLHDShFaMJKqhtKaaWy11MC9o2HhxT476qBY6/rOAYTteWg
	 AHkJzLSHUmsJ2yTtlH4/q5W8F9wV3fYK5UPFa3DdHe/tWpGpPTiu1ZqmIe7LKKt09EgOW
	 Mu6l88NzSW52uGQLYOAsJxrsaTIB+uF+3fvuvQrj6PYz4yn2Mw9oWnzr10nASgYOUFv23
	 DsA4z9On/+c1qk6a5jyDjKnBSXC/MnEZVKax3nZsTRgcfad28wuTL8Q1JoNMabSQNwGoz
	 cQKsJu+08kpZhTZxjozqhT2Kp3/v/4vv/RjN/Ei/8o1CQ5+Ql9GsLbtMPWdndy1Uh2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oFz78RJy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC238606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oFz78RJy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573021F000C1;
	Wed,  4 Nov 2026 18:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817104;
	bh=sWf3cYtTPY5eG3fGpO84ehBGNjdfonIHa6TUM/ypILE=;
	h=Subject:To:Cc:From:Date;
	b=oFz78RJykzkrrqJ4neZxLJQWYu3xs2ubAXW9KtgvFTTG8t74kld003zQMg5bmA/wN
	 0jKikXAZ7LjxnB5EZoxyaBywR9QCwFYnwITXk9Hjk5aiS1bqIsLolcjNwYdukY2XHk
	 Q3xFF8Y2UrR4e1p0umo6yfVgmsrqI57tKamVcmkQ=
Subject: FAILED: patch "[PATCH] smb: client: fix slab-out-of-bounds write in" failed to apply to 5.15-stable tree
To: dmnk@google.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:31:41 -0500
Message-ID: <2026110441-marital-prelaunch-5744@gregkh>
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
git cherry-pick -x a377a3645c7d0246af0bc4ef24db94bb2670bdde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110441-marital-prelaunch-5744@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

