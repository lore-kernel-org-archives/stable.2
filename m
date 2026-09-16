Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C54A92C3
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577644; cv=none; b=F8w+ILdS1UzwkKgR9CU1pVzWuBLk/w0KfpQzxGDj3+5QUr5f3SHSpMrVzPWuK4s6+Bi++DMDDP+fMQPNbJywhZ7KFMdTQ942obDfJeI0W0di5vex55/S61D5bsCNmo6B8NzK7RxdIReJOEecujMycAwsJipkPH2NZeoKQH2K48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577644; c=relaxed/simple;
	bh=GfA5cQhOfIqgHu7loLp0cy30+u107q1OTsbXoVIvZdA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QL4G/QwIdR4BSNIYTdZfGg7nGRVbJuzdTMUU4LmQGtIY3q/PT9zDwXcz6E3GQTvBmPlJItuJZPA8GTSWdnMsJTEol5Nd9ZLHS/bgFp0MklZ7rr7yo3xNzHxv7UHZqxk3p5B69ivvxTMcQ+pIAJkP3+Hit3GOmxfeja+BGmpkLmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qk+k9++n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qk+k9++n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73661F000FF;
	Wed, 16 Sep 2026 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577630;
	bh=/3SQIRSeFiNqDpNkBL+AadW5MkCRXil9WQDHqMFSqEc=;
	h=Subject:To:Cc:From:Date;
	b=qk+k9++n2fTUItpQzcmXkV898y65DOag2Hzbv+BqnsLnfYWrWGHhUZ3DWrt83UlA8
	 ElLbO15QZub0obhrsKnHP/o3y3YyeSLS/2ArEIWE5mdNNkuHAmqcl89I4PwM2LVTSg
	 2DzM0l1QcMUlCo+JSFKFfzTWlsCReYFaIOM5UNvM=
Subject: FAILED: patch "[PATCH] smb: client: fix heap overflow in DACL owner/group rewrite" failed to apply to 5.10-stable tree
To: doebel@amazon.de,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:49:08 +0100
Message-ID: <2026091608-relish-shine-870e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 0ee150794c75bcd0be0e24ff3394f433cbae18cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091608-relish-shine-870e@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ee150794c75bcd0be0e24ff3394f433cbae18cc Mon Sep 17 00:00:00 2001
From: Bjoern Doebel <doebel@amazon.de>
Date: Tue, 8 Sep 2026 16:10:00 +0000
Subject: [PATCH] smb: client: fix heap overflow in DACL owner/group rewrite

When id_mode_to_cifs_acl rewrites an existing DACL, it allocates a
buffer sized according to the on-disk DACL length reported by
dacl_ptr->size. However, replace_sids_and_copy_aces may rewrite each
ACE with a new owner/group SID obtained from the cifs.idmap upcall.
Those SIDs can have up to SID_MAX_SUB_AUTHORITIES (15) sub-authorities,
making each ACE up to 76 bytes (sizeof(struct smb_ace)).

If the original DACL contains short SIDs (e.g., 1 sub-authority) while
the replacement SIDs are long, the rewritten ACEs overflow the
allocation.

Fix this by always budgeting for worst-case SID expansion: allocate
sizeof(struct smb_acl) plus num_aces * sizeof(struct smb_ace), which
covers the smb_acl header and room for every ACE at maximum SID size.
This replaces the previous split logic that used dacl_ptr->size for
cifsacl mounts but num_aces * sizeof(struct smb_ace) for mode_from_sid
mounts: both paths can trigger the same rewrite and need the same
headroom.

KASAN reports this as:
  BUG: KASAN: slab-out-of-bounds in build_sec_desc+0x1e8a/0x2680 [cifs]
  Write of size 4 at addr ffff8881a5e25374 by task chown/5298
  ...
  The buggy address is located 0 bytes to the right of
   allocated 884-byte region [ffff8881a5e25000, ffff8881a5e25374)

Cc: stable@vger.kernel.org
Fixes: bc3e9dd9d104 ("cifs: Change SIDs in ACEs while transferring file ownership.")
Assisted-by: Kiro:claude-opus-4.6
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Fixes: 5c3564852c58 ("cifs: Minimize the number of cifs_acl memory allocations")
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index def8908dd7e9..3e96e151df35 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1837,11 +1837,13 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 				cifs_put_tlink(tlink);
 				return rc;
 			}
-			if (mode_from_sid)
-				nsecdesclen +=
-					le16_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
-			else /* cifsacl */
-				nsecdesclen += le16_to_cpu(dacl_ptr->size);
+			/*
+			 * Worst case: every ACE is rewritten with a new SID of
+			 * SID_MAX_SUB_AUTHORITIES sub-auths -> sizeof(smb_ace) each,
+			 * plus the smb_acl header replace_sids_and_copy_aces() emits.
+			 */
+			nsecdesclen += sizeof(struct smb_acl) +
+				le16_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
 		}
 	}
 

