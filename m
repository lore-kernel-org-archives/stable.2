Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE449B215
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442784; cv=none; b=rX65VqxGHAww5oBObYCbZ34242+myc4h8ihi5f75rnBblHcPz/cO2segkT/WRL9f4YK8NbcPHFMMnbwNJYq3i9vMymyliOEzgajYgbcSs3l87tzK4kOyWBdNJ2ZngG7WyJAwxBGDkVpXt3jKaA4kzF/R3KphqxqX27RphJcBPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442784; c=relaxed/simple;
	bh=0ewkpL5/xcGOxMrgUmWEg8HbIRiwYude+seuKg6u9+w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZKRKuBn5cUjdlpx7m32vsfMOyG9ZA8BwmnjNxHUL3UMKl0L0WeAROOL6HLnsFfmpBW1UO90xKJLyG1ly1Xo71UJdLwKE42UaMaMnoftL4TkB7Vf/59yNTc6qGFqs1P1Bsdb+x3B9iNXm4b2V42FiyNDhhs8i8yiYK8nEMBFjdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IiX9BXWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IiX9BXWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9971F000E9;
	Thu,  3 Sep 2026 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442771;
	bh=gyAM2g+jGJcysK1gw0wqAY2c8LHwttyoq2A2UYCMpu0=;
	h=Subject:To:Cc:From:Date;
	b=IiX9BXWevLqBqBSsfVzl9XeDvliaOb0TVOjngTOYiOQ373JZzq8/kFVaoWeLA8VqY
	 ss7k96gEXDqrF+4gw07Uq5ap+Wc5p37xzcfcXykydZUDiU1UI6cQhV4pBTHKYPhgGN
	 AjH3PPWFZj8b0OVLbfsMrzUNl7F1VXGKLCYVLM+I=
Subject: FAILED: patch "[PATCH] nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing" failed to apply to 6.1-stable tree
To: jlayton@kernel.org,chuck.lever@oracle.com,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:13:05 +0200
Message-ID: <2026090305-settle-sarcasm-3f00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ca94ba36172046be6a694a7986f6931e47ed4d51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090305-settle-sarcasm-3f00@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca94ba36172046be6a694a7986f6931e47ed4d51 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 May 2026 09:19:17 -0400
Subject: [PATCH] nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing
 delegation revoke

nfsd4_alloc_layout_stateid reads fp->fi_deleg_file without holding
fi_lock when the parent stateid is a delegation. A concurrent delegation
revoke via the laundromat can clear fi_deleg_file under fi_lock, causing
nfsd_file_get() to return NULL and triggering the BUG_ON.

This race is client-reachable: two NFS clients can trigger it by having
one hold a delegation while another opens the same file to force a
recall. When the first client doesn't respond to the recall, the
laundromat revokes it. A concurrent LAYOUTGET from any client using the
delegation stateid hits the race window.

Fix this by taking fi_lock around the fi_deleg_file read in the
SC_TYPE_DELEG path, matching the locking discipline of the
find_any_file() arm, and replacing the BUG_ON with a graceful error
return that cleans up the partially-initialized layout stateid.

Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260530-nfsd-fixes-v2-1-f27e8eb4d974@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index f34320e4c2f4..1de2f6cd1f09 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -247,11 +247,17 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	nfsd4_init_cb(&ls->ls_recall, clp, &nfsd4_cb_layout_ops,
 			NFSPROC4_CLNT_CB_LAYOUT);
 
-	if (parent->sc_type == SC_TYPE_DELEG)
+	if (parent->sc_type == SC_TYPE_DELEG) {
+		spin_lock(&fp->fi_lock);
 		ls->ls_file = nfsd_file_get(fp->fi_deleg_file);
-	else
+		spin_unlock(&fp->fi_lock);
+	} else {
 		ls->ls_file = find_any_file(fp);
-	BUG_ON(!ls->ls_file);
+	}
+	if (!ls->ls_file) {
+		nfs4_put_stid(stp);
+		return NULL;
+	}
 
 	ls->ls_fenced = false;
 	ls->ls_fence_delay = 0;

