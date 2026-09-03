Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7634A8A31
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443146; cv=none; b=LTBucGYNOaeV7EfP3Q0XaMqpFdiE88ZQPFvV4t3+2CPOPB8tE31b4E5/IfvfKOagTNEWXuqh6UC8/W1H1TLx/ltPqAYaHZC0VTHr6FT737ezNz2x0LgTXKgPSeBca6YxRUZyVuheDO0x3H+v1cKzs42uqgbapwgQfSsLG2n4sJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443146; c=relaxed/simple;
	bh=IEgmVY4gt+gn7ZATBAmyYQiml9LCZzak828XrAaOnUA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aymBMFpQoyCbkCaKFBlyM0UY/w6WiKqbAcqP/DK2hAFM3YYShfocdxN2v2OpOerc2gXvWphiGuRrNdenZe5/HVHT0/YI7LmINQ9fqsSizHM5Ta9g3X9BJpwJxoZhslPR2dxXiyKkDqreEOj0/x/xLFWOJYYSdDDKihrTPGhl82g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aiYqvRBZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aiYqvRBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141AF1F00A3E;
	Thu,  3 Sep 2026 13:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443140;
	bh=kpI/pii8rTP7ezYn85h7vm3/s/A5fqtPU2t2YD23GQM=;
	h=Subject:To:Cc:From:Date;
	b=aiYqvRBZYhjXp+E+k3LaHMrN5LK1/rSDz8/ZgIOeWKGD2bGMDd7xe3idv+JpciOXn
	 IQU9u1EAAGdTuV2Qj9X53Ggz6QjsGvrZirTXrD5BPls9qZmzYwXqD+jdoCyFdOKIit
	 gcOaU2+cHpEgkH0E/QyTnqZxNwTZ9luex2oorKeU=
Subject: FAILED: patch "[PATCH] NFSD: Prevent client use-after-free during admin state" failed to apply to 6.18-stable tree
To: cel@kernel.org,jlayton@kernel.org,neil@brown.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:20:09 +0200
Message-ID: <2026090309-food-custody-c3c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e270e5a0778e5bff852c8862ce9576ce70359393
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090309-food-custody-c3c1@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e270e5a0778e5bff852c8862ce9576ce70359393 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Thu, 9 Jul 2026 13:40:26 -0400
Subject: [PATCH] NFSD: Prevent client use-after-free during admin state
 revocation

A stateid holds only a bare pointer to its nfs4_client; a stateid
reference does not pin it.  The client survives only because
__destroy_client() drains its stateids before free_client() runs.

nfsd4_revoke_states() drops nn->client_lock across revoke_one_stid(),
which dereferences the client to revoke a stateid and read
clp->cl_minorversion.  A teardown racing the dropped lock can free
the client first.

Pinning cl_rpc_users under client_lock blocks the DESTROY_CLIENTID and
EXCHANGE_ID teardown, which refuses while cl_rpc_users is non-zero.
force_expire_client() ignores it: once its wait for cl_rpc_users to
reach zero has passed, a later pin goes unnoticed.

Under client_lock, skip a client whose cl_time is already zero --
force_expire_client() clears it there before waiting -- otherwise pin
cl_rpc_users before dropping the lock.  The walk then either sees the
expiry and skips, or pins in time for that wait to cover the revoke.

Fixes: 1c13bf9f2e3c ("nfsd: allow lock state ids to be revoked and then freed")
Cc: stable@vger.kernel.org
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260709-cel-v4-3-1d519d9be0cb@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index efeb2a2e9c8f..565fa2ff5ba5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1965,9 +1965,19 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 		struct nfs4_client *clp;
 	retry:
 		list_for_each_entry(clp, head, cl_idhash) {
-			struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
-								  sc_types);
+			struct nfs4_stid *stid;
+
+			/*
+			 * force_expire_client() ignores cl_rpc_users once
+			 * its wait_event() has passed, so pinning cannot
+			 * keep an already-expiring client alive; the
+			 * expiry path revokes its states instead.
+			 */
+			if (is_client_expired(clp))
+				continue;
+			stid = find_one_sb_stid(clp, sb, sc_types);
 			if (stid) {
+				atomic_inc(&clp->cl_rpc_users);
 				spin_unlock(&nn->client_lock);
 				revoke_one_stid(nn, clp, stid);
 				nfs4_put_stid(stid);
@@ -1980,6 +1990,9 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 					 */
 					nn->nfs40_last_revoke =
 						ktime_get_boottime_seconds();
+				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
+				    is_client_expired(clp))
+					wake_up_all(&expiry_wq);
 				goto retry;
 			}
 		}
@@ -3394,6 +3407,11 @@ static void force_expire_client(struct nfs4_client *clp)
 
 	trace_nfsd_clid_admin_expired(&clp->cl_clientid);
 
+	/*
+	 * cl_time is cleared under client_lock before the wait so a
+	 * revocation walk pinning cl_rpc_users under it either skips
+	 * this client or is seen by this wait_event().
+	 */
 	spin_lock(&nn->client_lock);
 	clp->cl_time = 0;
 	spin_unlock(&nn->client_lock);

