Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28CA4A8FF1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442794; cv=none; b=EYLaYDvOnUQmbsZXhmUC6NSFYl+/BKKPjVBjadq+ht84toJ2fp7r4ydduiWGFdIxcSdovKwykA1GX7oEcuq/vH/vBiDJ3K9tm4Hs6Z80v5Vzf7oRbQZu3A1k+7AfGYkXByIqOkaNt/MgDTjiehkrrL52VSvVrlSbPhEOyhwLH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442794; c=relaxed/simple;
	bh=xjlGk6oaMu9msVkyoO9xB0jWxQ+zfNSRqeX9wcJtWEw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DZSAQWmx210ziR5c8LZSrOm9Yq9Wb1yOqZxWPJP7jXzGuYZnaCff/BISyy1LFhUX4e9zsE6uYCs6WvDDBoEeBPcSQTpxHSxnwio1hzZ3U75cfsH96J9+oWO0mV6NgItTSRq4toRreNUQpIccgJiHZGDoITZ4oZn74BALUGC/n74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L7+YGMg7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L7+YGMg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB5A1F00A3A;
	Thu,  3 Sep 2026 13:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442779;
	bh=VUa6+/KEt9hrDpF6W7s8VwG3mw+sEtNUNt6xCjMNPyk=;
	h=Subject:To:Cc:From:Date;
	b=L7+YGMg7wlw6LLwcfWvSsyVs/01fokZ9rjE23KZC5ZiF6s59/T+G2GUODCxMOjq7/
	 OHa+7Zbz1wiED4GslVL/WHYYmQFUWXuYQo0HbZdlQzF/kGoe7hLVLFE8qvGdmo+VGO
	 gdrIua6TEkXIkNSLQ6EsKg8dtJj1ZBueT0f9eFnw=
Subject: FAILED: patch "[PATCH] nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing" failed to apply to 5.15-stable tree
To: jlayton@kernel.org,chuck.lever@oracle.com,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:13:06 +0200
Message-ID: <2026090305-musky-peculiar-c632@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x ca94ba36172046be6a694a7986f6931e47ed4d51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090305-musky-peculiar-c632@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

