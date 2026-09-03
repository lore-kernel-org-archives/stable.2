Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C74B1274
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443458; cv=none; b=TBw7smXsdmptda+Xqa4FrdUSHQLrkx3nTcdLXKRULC0IVy5FyHeRSxP+f5D42WOqZdrW7r59OmHTi270fNoWQKjy7l45THlpeMdm1Zib8Svja7jdupHlNnZHC2UvWD3zdfK10nDlUXPHNK5Wwe/aJPjVOT4GlbUG0dfWUp6yObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443458; c=relaxed/simple;
	bh=F4oMi3rA2HMf8dgNZ8k0aJsCNunD00B2IpDLQe1PQCg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E6//veTQQKn30jiF8sJCr2zcYFudnUvRj38/XxNzZbwn2J8dAYjvHfUygH7ihfUPX+q2zW0ShB7aYdcBsxtwcmEH21WB1x2cChNK2P3EhsWdKXpgj05QgvdduR+89X5kNwg8OF1yJnKzJPiZ+Hl9Ov8CN+/UZ9SYOTfWp4Fvkak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sXCwWuEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sXCwWuEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AC51F00A3E;
	Thu,  3 Sep 2026 13:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443447;
	bh=bVzgmjjSpLTQ+7T8wHAbl/W5SY86u44PhKiS64zqt60=;
	h=Subject:To:Cc:From:Date;
	b=sXCwWuEphT6gJnVO7tEr2+MaOiYu8Xm+v0/pz56b7LeBgw32e2/Zyq603b0xcm5LW
	 Dn9UuoquDZkET4ACXW6j3joLsWmriKDbRS1RTJDtfIu91NnvkgQ7pt88o2PW1Mm65D
	 ID7vQRWnUs1IpWfzkmRpJ9kMHcGjgraasxsc8LEk=
Subject: FAILED: patch "[PATCH] NFSD: Prevent client use-after-free during close_lru reaping" failed to apply to 5.10-stable tree
To: cel@kernel.org,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:34:06 +0200
Message-ID: <2026090306-unwieldy-turtle-e4a5@gregkh>
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
git cherry-pick -x 2330b788d732f43668b965b3105b37ceb276dfea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090306-unwieldy-turtle-e4a5@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2330b788d732f43668b965b3105b37ceb276dfea Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Thu, 9 Jul 2026 13:40:31 -0400
Subject: [PATCH] NFSD: Prevent client use-after-free during close_lru reaping

An nfs4_openowner left on nn->close_lru after its final CLOSE keeps
its last closed stateid in oo_last_closed_stid, holding only a raw
pointer to its nfs4_client. The laundromat reaps timed-out entries,
drops nn->client_lock, and calls nfs4_put_stid(), which dereferences
the client through cl_lock. Nothing pins the client across that
window, so a concurrent force_expire_client() can free it and
nfs4_put_stid() reads freed memory. __destroy_client() hits the same
race, walking clp->cl_openowners without cl_lock.

Pin the client with cl_rpc_users before dropping client_lock, and
skip clients already expiring. __destroy_client() then cleans up its
own close_lru entries through release_last_closed_stateid(), so
teardown no longer races the laundromat.

Fixes: 217526e7ecc9 ("nfsd: protect the close_lru list and oo_last_closed_stid with client_lock")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260709-cel-v4-8-1d519d9be0cb@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4acd02f1642c..20556b8f186a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7581,11 +7581,16 @@ nfs4_laundromat(struct nfsd_net *nn)
 		if (!state_expired(&lt, oo->oo_time))
 			break;
 		list_del_init(&oo->oo_close_lru);
+		clp = oo->oo_owner.so_client;
+		if (is_client_expired(clp))
+			continue;
 		stp = oo->oo_last_closed_stid;
 		oo->oo_last_closed_stid = NULL;
+		atomic_inc(&clp->cl_rpc_users);
 		spin_unlock(&nn->client_lock);
 		nfs4_put_stid(&stp->st_stid);
 		spin_lock(&nn->client_lock);
+		put_client_no_renew_locked(clp);
 	}
 	spin_unlock(&nn->client_lock);
 

