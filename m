Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818398;
	b=EE7kh2sfq/Z2SKu5YF3ubjzO6zecGKd0HyMwVOMP/GnYA3niB5Cs4csBToces2KEPmje
	 2JgpIqH45viWjiFrfd6VSyU8KbR3l12U00rSb8fMWJ1HsPCt5z7b4dQELtoLNByTSZGc4
	 6GDzFw8FqzAWEmr2oBnULXaS2ZryRcNxOmNsD6ut3laXXtHQhpOr86rjbOjpnBYy4/LcU
	 G4uVNRTlf0GqtMaPFmOpD7N5r16S0lurvYScywwAdQfqXBC5LFC5zYBW//0nN2fjknMei
	 WpeisCNYe+pkzVO9grmpVGXVR1sOk5MfHxPYpnJARw0BPSink/u/wGUCjc8ESXYqdVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818398;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wVMEyaoGUT8ZSIf1hZ9SOUl8SiEKeR2dNoUDDJokQps=;
	b=nMbiLadOYj3PULu+FjpzDsMz35N7CY6mKyNsrEfok+3pJZWbHX/VQXxYFwTILZfAF8L1
	 t6KuhlKebdcdp7jOAjnfiDCUd8ZNzL506853n3PAy72zyFisrJD7nD5hEIsq7N3i3IPcb
	 LW98R3GTdzf/FKvQ0meiqWKgZVbMMA6SD4obNwerEUNEPZQUEQsZU5JFQWe1FdYl6XAyc
	 N5YeVPIAMNzunR8daAo3aBsKGEFZyDpNddvDMQSj/lpm1moV1vhJo1F1rSK+cLx/JZNyx
	 OBHftyDxijrnReS8BS5dQ30oZ8pzsHEn2tr5I5wL8WqJafHRmFJvUKDd7FLkVCtCUZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VOacyBlr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A836606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VOacyBlr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99B01F00919;
	Wed,  4 Nov 2026 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818398;
	bh=wVMEyaoGUT8ZSIf1hZ9SOUl8SiEKeR2dNoUDDJokQps=;
	h=Subject:To:Cc:From:Date;
	b=VOacyBlrAPZtJ0tEufn47L9tGGH6cxhFBs+nr5leR3qSxcZ8y9d0na04K5fRyxvvz
	 Iv/CraZElksJ7R/iOQ7MJZoAi1GLmKTY2RfjBfAw2PPqqoNvP5EKzCGxqT5cFebAZa
	 EKscA7B9w2I3KpXVHj9PlCL+FDBdL1NFH3FXTj1Q=
Subject: FAILED: patch "[PATCH] NFSD: Send a meaningful CB_RECALL_ANY keep count" failed to apply to 6.12-stable tree
To: cel@kernel.org,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:53:16 -0500
Message-ID: <2026110416-cleat-grapple-d472@gregkh>
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
git cherry-pick -x 9af39c0773ef956039e1ebe9c235532fe6ee1e50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110416-cleat-grapple-d472@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9af39c0773ef956039e1ebe9c235532fe6ee1e50 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Mon, 17 Aug 2026 21:08:39 -0400
Subject: [PATCH] NFSD: Send a meaningful CB_RECALL_ANY keep count

deleg_reaper() sets craa_objects_to_keep to zero on every
CB_RECALL_ANY. RFC 8881 Section 20.6.3 defines that field as the
number of objects the client may keep, leaving the client to choose
which of the excess to return, because the server cannot read lack
of recent use as lack of usefulness. Zero asks for every delegation
the client holds, including the ones backing files an application
still has open.

There is also no reason NFSD has to reclaim the entire delegation
working set on the first sign of memory pressure.

Derive the keep count from cl_deleg_count so that each callback
asks for one delegation. Both the shrinker and the laundromat re-arm
while their condition lasts, so a client with more to give is asked
again on the next pass.

The Linux client ignores craa_objects_to_keep and returns unused
delegations selected from the type mask alone, so the count changes
nothing for it.

Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260817-recall-any-keep-count-v5-4-3b2cffce701e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f6da74ce16a9..9d40b573a295 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7959,6 +7959,7 @@ deleg_reaper(struct nfsd_net *nn)
 {
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
+	unsigned int count;
 
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -7968,21 +7969,33 @@ deleg_reaper(struct nfsd_net *nn)
 			continue;
 		if (clp->cl_state != NFSD4_ACTIVE)
 			continue;
-		if (list_empty(&clp->cl_delegations))
-			continue;
 		if (atomic_read(&clp->cl_delegs_in_recall))
 			continue;
 		if (ktime_get_boottime_seconds() - clp->cl_ra_time < 5)
 			continue;
 		if (clp->cl_cb_state != NFSD4_CB_UP)
 			continue;
+		/*
+		 * This read races with hash_delegation_locked() and
+		 * unhash_delegation_locked() on other CPUs. A stale
+		 * count only skews the keep value; the next
+		 * laundromat pass sees a more current one.
+		 */
+		count = data_race(READ_ONCE(clp->cl_deleg_count));
+		if (!count)
+			continue;
 		if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &clp->cl_ra->ra_cb.cb_flags))
 			continue;
 
 		/* release in nfsd4_cb_recall_any_release */
 		kref_get(&clp->cl_nfsdfs.cl_ref);
 		clp->cl_ra_time = ktime_get_boottime_seconds();
-		clp->cl_ra->ra_keep = 0;
+		/*
+		 * Ask for a single delegation. Recalling one before it
+		 * is needed costs the client an OPEN when it next
+		 * touches the file.
+		 */
+		clp->cl_ra->ra_keep = count - 1;
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_WDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_DIR_DLG);

