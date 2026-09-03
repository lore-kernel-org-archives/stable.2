Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE214B1282
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443451; cv=none; b=t8JM2rd/ba198OX8qziH/SLtMif5QbcowqFgN9rkDVzRCXmLWlmq/M5TZv4n5WG66axLH8iP10vBB9xuwuMyw4Jv/DZDO7f+GymsVHRDDscnY8pOBMlmHpAm564hs87ONCopI5lXOkkXbU3BgKwvLW0UmniQGKZjTn0FXSCE3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443451; c=relaxed/simple;
	bh=VS61iyWpEXjRGTSlPC2PWkPeObuSUevZJ9xIMmHlj1E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ds53at8xRWq92vgQ/mXKBgZ5VImlQHj4Z+BEn6liXs5yJVrGIniJCCP2EBYoT1O9LBplItGtoApkXSYjBlypfGNRojAL5wJ6mIj5lWMsRE/2zicGu/5uIOPomifFKNN8tjTIwJNjdBIFRwLXrR5PGFD7/SKZUKEy77jaedxWHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eUG5WxRM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eUG5WxRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D7C1F00AC4;
	Thu,  3 Sep 2026 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443442;
	bh=Z/ZVamaNj+EzJZcmoC1GY+y40f+g2FiyryaXo+toJcc=;
	h=Subject:To:Cc:From:Date;
	b=eUG5WxRMSBiynfkiKTKga/aY8V6j/cjH2spfKaMeqTfIfZ0XA0HjP2Jgc2IIQn/Kt
	 cQDKRrtKTs4D9texb/Lfyi34gqUEQ5l+tYztznJKbvDHU6buVVGuJQWsQcWLaW3dOo
	 46XSF/ohnjLeZxDxDXH1qrfO3dhHnHIQ4Yq5hXKU=
Subject: FAILED: patch "[PATCH] NFSD: Prevent client use-after-free during close_lru reaping" failed to apply to 6.12-stable tree
To: cel@kernel.org,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:34:05 +0200
Message-ID: <2026090305-unmasking-excuse-7fa0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 2330b788d732f43668b965b3105b37ceb276dfea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090305-unmasking-excuse-7fa0@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 

