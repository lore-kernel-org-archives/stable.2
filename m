Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F73F7886
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922580; cv=none; b=SfAwmzyrq5doe//gPSXAcKBZrAmumJ0x8rik3B5jZU2Ut/RU2E6UG9XnLffaQEZJiebz+ImpnSY6PYcZdVOOybad+1eiIt2OzTUXUpC1M0PlDWxHDUwxmfxtmgb0RE16nMdq3RP9P1nAz1l6tlyYHb/NMn1BHqMnb+a7Ek5EFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922580; c=relaxed/simple;
	bh=h/j3pr5SDhzi/DoUzK/UiaJ1uS3OXiS1pQOD3rnQH0U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qBtaL3TzLZ9e8AnQ++KDFfaJTvAL7VIddG49gDlHnq3jd+ySNHRLyVxWaKGqkcPhlGPyKUUxl+SdXzUN5bqJs7d5Tv3CixPbQchYUSRfCDGMaP3sCMfQrf/VIjLoM8bwlmaEqDxlV2u/Dtz7aKHy568drkKGmqMXho8+kq0H7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BbjlVgTd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BbjlVgTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FCD1F00A3A;
	Wed,  5 Aug 2026 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922579;
	bh=kPV4RG5h+H6b/VAJUcNXNSYThNu03CZhd5ldwx73wDo=;
	h=Subject:To:Cc:From:Date;
	b=BbjlVgTdt6BnwEToKon2tJclew7JrtqllkNLEhFoGc6Q1oyY56YdV4vXrcYrARKQS
	 2IEn8U692eEXz+WN+rN1NYrNlbY/3DHnX5yd2urRis7KzCitMBWaRGFJPVW04wH2wK
	 nfAyTkhwZlASpmUeSlGLcq6GFY/eLjNkI3aobjIQ=
Subject: FAILED: patch "[PATCH] dibs: fix use-after-free of dmb_node in loopback" failed to apply to 6.12-stable tree
To: hidayath@linux.ibm.com,kuba@kernel.org,rc@rexion.ai,wintera@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:36:02 +0200
Message-ID: <2026080502-penny-cubbyhole-47d2@gregkh>
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
git cherry-pick -x a10ea943356b9d70c5616a0a06f6fa97cfdaccb1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080502-penny-cubbyhole-47d2@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a10ea943356b9d70c5616a0a06f6fa97cfdaccb1 Mon Sep 17 00:00:00 2001
From: Hidayath Khan <hidayath@linux.ibm.com>
Date: Mon, 27 Jul 2026 11:35:30 +0200
Subject: [PATCH] dibs: fix use-after-free of dmb_node in loopback
 attach/detach/unregister

dibs_lo_attach_dmb(), dibs_lo_detach_dmb() and dibs_lo_unregister_dmb()
look up the dmb_node under dmb_ht_lock, drop the lock and only then
operate on the node's refcount. Nothing keeps the node alive across
that window: __dibs_lo_unregister_dmb() removes the node from the hash
table under the write lock and immediately frees it.

A concurrent final put can therefore free the node between the lookup
and the refcount operation:

CPU0 (attach)                     CPU1 (owner unregisters)

read_lock_bh(&dmb_ht_lock)
find dmb_node (refcnt == 1)
read_unlock_bh(&dmb_ht_lock)
                                  refcount_dec_and_test() 1 -> 0
                                  write_lock_bh(&dmb_ht_lock)
                                  hash_del(&dmb_node->list)
                                  write_unlock_bh(&dmb_ht_lock)
                                  kfree(dmb_node)
refcount_inc_not_zero(&dmb_node->refcnt)  <-- use-after-free

The same window exists for the refcount_dec_and_test() calls in the
detach and unregister paths.

Close the race structurally by making hash table membership and the
refcount transitions atomic with respect to each other:

- Perform the final refcount_dec_and_test() and hash_del() in a single
  dmb_ht_lock write-side critical section, in both the unregister and
  the detach path. Freeing the node still happens after the lock is
  dropped, which is safe because a node whose refcount reached zero has
  left the hash table and can no longer be found.

- This establishes the invariant that any node found in the hash table
  holds at least one reference, and that the final reference can only
  be dropped under the write lock. dibs_lo_attach_dmb() can thus take
  its reference with a plain refcount_inc() while still holding the
  read lock; refcount_inc_not_zero() is no longer needed.

__dibs_lo_unregister_dmb() no longer touches the hash table and is
renamed to dibs_lo_free_dmb() accordingly.

Note: commit cc21191b584c ("dibs: Move data path to dibs layer") moved
the code to its current location; the race was introduced earlier by
commit c3a910f2380f ("net/smc: implement DMB-merged operations of
loopback-ism").

Tested SMC-D via ISM and dibs loopback.

Cc: stable@vger.kernel.org
Fixes: c3a910f2380f ("net/smc: implement DMB-merged operations of loopback-ism")
Reported-by: Rahul Chandelkar <rc@rexion.ai>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Link: https://patch.msgid.link/20260727093530.968834-1-hidayath@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
index 0f2e09311152..fd5caf1e19a8 100644
--- a/drivers/dibs/dibs_loopback.c
+++ b/drivers/dibs/dibs_loopback.c
@@ -118,14 +118,9 @@ static int dibs_lo_register_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb,
 	return rc;
 }
 
-static void __dibs_lo_unregister_dmb(struct dibs_lo_dev *ldev,
-				     struct dibs_lo_dmb_node *dmb_node)
+static void dibs_lo_free_dmb(struct dibs_lo_dev *ldev,
+			     struct dibs_lo_dmb_node *dmb_node)
 {
-	/* remove dmb from hash table */
-	write_lock_bh(&ldev->dmb_ht_lock);
-	hash_del(&dmb_node->list);
-	write_unlock_bh(&ldev->dmb_ht_lock);
-
 	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
 	folio_put(virt_to_folio(dmb_node->cpu_addr));
 	kfree(dmb_node);
@@ -139,27 +134,33 @@ static int dibs_lo_unregister_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb)
 	struct dibs_lo_dmb_node *dmb_node = NULL, *tmp_node;
 	struct dibs_lo_dev *ldev;
 	unsigned long flags;
+	bool last;
 
 	ldev = dibs->drv_priv;
 
 	/* find dmb from hash table */
-	read_lock_bh(&ldev->dmb_ht_lock);
+	write_lock_bh(&ldev->dmb_ht_lock);
 	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
 		if (tmp_node->token == dmb->dmb_tok) {
 			dmb_node = tmp_node;
 			break;
 		}
 	}
-	read_unlock_bh(&ldev->dmb_ht_lock);
-	if (!dmb_node)
+	if (!dmb_node) {
+		write_unlock_bh(&ldev->dmb_ht_lock);
 		return -EINVAL;
+	}
+	last = refcount_dec_and_test(&dmb_node->refcnt);
+	if (last)
+		hash_del(&dmb_node->list);
+	write_unlock_bh(&ldev->dmb_ht_lock);
 
-	if (refcount_dec_and_test(&dmb_node->refcnt)) {
+	if (last) {
 		spin_lock_irqsave(&dibs->lock, flags);
 		dibs->dmb_clientid_arr[dmb_node->sba_idx] = NO_DIBS_CLIENT;
 		spin_unlock_irqrestore(&dibs->lock, flags);
 
-		__dibs_lo_unregister_dmb(ldev, dmb_node);
+		dibs_lo_free_dmb(ldev, dmb_node);
 	}
 	return 0;
 }
@@ -188,14 +189,9 @@ static int dibs_lo_attach_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb)
 		read_unlock_bh(&ldev->dmb_ht_lock);
 		return -EINVAL;
 	}
+	refcount_inc(&dmb_node->refcnt);
 	read_unlock_bh(&ldev->dmb_ht_lock);
 
-	if (!refcount_inc_not_zero(&dmb_node->refcnt))
-		/* the dmb is being unregistered, but has
-		 * not been removed from the hash table.
-		 */
-		return -EINVAL;
-
 	/* provide dmb information */
 	dmb->idx = dmb_node->sba_idx;
 	dmb->dmb_tok = dmb_node->token;
@@ -209,11 +205,12 @@ static int dibs_lo_detach_dmb(struct dibs_dev *dibs, u64 token)
 {
 	struct dibs_lo_dmb_node *dmb_node = NULL, *tmp_node;
 	struct dibs_lo_dev *ldev;
+	bool last;
 
 	ldev = dibs->drv_priv;
 
 	/* find dmb_node according to dmb->dmb_tok */
-	read_lock_bh(&ldev->dmb_ht_lock);
+	write_lock_bh(&ldev->dmb_ht_lock);
 	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, token) {
 		if (tmp_node->token == token) {
 			dmb_node = tmp_node;
@@ -221,13 +218,17 @@ static int dibs_lo_detach_dmb(struct dibs_dev *dibs, u64 token)
 		}
 	}
 	if (!dmb_node) {
-		read_unlock_bh(&ldev->dmb_ht_lock);
+		write_unlock_bh(&ldev->dmb_ht_lock);
 		return -EINVAL;
 	}
-	read_unlock_bh(&ldev->dmb_ht_lock);
+	last = refcount_dec_and_test(&dmb_node->refcnt);
+	if (last)
+		hash_del(&dmb_node->list);
+	write_unlock_bh(&ldev->dmb_ht_lock);
+
+	if (last)
+		dibs_lo_free_dmb(ldev, dmb_node);
 
-	if (refcount_dec_and_test(&dmb_node->refcnt))
-		__dibs_lo_unregister_dmb(ldev, dmb_node);
 	return 0;
 }
 

