Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D84189DD
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550976; cv=none; b=sOMwA0SdJWN8bXVm176QLYV+EDhQvD4wxP+tCkRnLIqp/jL5Ayu0WLfscl4Ps86w8Ik/4XdFTE8oAXvKetn/RR+/2QiWmRXMFcS99PbUu1mpN6jwfr+EwZCaRJLQIyG5XppNAA1t4d8pVdxenXu+s4zHK6woBlSmKKbg0YGw82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550976; c=relaxed/simple;
	bh=c4ZjmR6ULgjC4/cumunxI7mwiedpZZ1gc5kMaU7UkxE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HViK47e5B9K1iKAvnOwBzpflrFK33oQL+OlvP9LKf5zYbJVEQh5h2HCU3Y5XQk5BBxtDf8ox8znAuXqMzU8A6D/+gjE2cgBF5wdyQVzxQhc7f+cULqxaG9mRS3mHdoj8aKEy9UEK/boZqZtV1HAn3zpIHbNjrv2lXr5Q0gFHNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2dcJulgp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2dcJulgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823E71F000E9;
	Mon, 20 Jul 2026 12:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550975;
	bh=amncWYdU77VairFfY9s9Vi1We9li21Kgeepy3oYTrZk=;
	h=Subject:To:Cc:From:Date;
	b=2dcJulgpYXxoFJiVQumePO05qkF8RjlJ6TZQbd3s/XIxGNmbMPaaK6b0Z5xVyRXzq
	 CLsRpckvhUaEdX3m4GprE4xaTmmskCFvv8WGOUIXJatNR0YfcPGq7+3Mvj4yeJd9H/
	 zLs5WQk4zqnAXFip0cJIHJxuj5hqXJo3QIDXA4dI=
Subject: FAILED: patch "[PATCH] netfilter: nft_set_pipapo: don't leak bad clone into future" failed to apply to 6.6-stable tree
To: fw@strlen.de,cjc000013@gmail.com,sbrivio@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:34:15 +0200
Message-ID: <2026072015-level-taste-bb42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 47e65eff50691f0a5b79d325e28d83ec1da43bcf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072015-level-taste-bb42@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47e65eff50691f0a5b79d325e28d83ec1da43bcf Mon Sep 17 00:00:00 2001
From: Florian Westphal <fw@strlen.de>
Date: Tue, 16 Jun 2026 13:26:26 +0200
Subject: [PATCH] netfilter: nft_set_pipapo: don't leak bad clone into future
 transaction

On memory allocation failure the cloned nft_pipapo_match can enter a bad
state:
 - some fields can have their lookup tables resized while others did
   not
 - bits might have been toggled
 - scratch map can be undersized which also means m->bsize_max can be
   lower than what is required

This means that the next insertion in the same batch can trigger
out-of-bounds writes.

Furthermore, a failure in the first can result in the bad clone to
leak into the next transaction because the abort callback is never
executed in this case (the upper layer saw an error and no attempt to
allocate a transactional request was made).

Record a state for the nft_pipapo_match structure:
- NEW (pristine clone)
- MOD (modified clone with good state)
- ERR (potentially bogus content)

Then make it so that deletes and insertions fail when the clone
entered ERR state.

In case the very first insert attempt results in an error, free the
clone right away.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Cc: stable@vger.kernel.org
Reported-and-tested-by: Seesee <cjc000013@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 706c78853f24..978bb0c01106 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -342,6 +342,8 @@
 #include "nft_set_pipapo_avx2.h"
 #include "nft_set_pipapo.h"
 
+static void nft_pipapo_abort(const struct nft_set *set);
+
 /**
  * pipapo_refill() - For each set bit, set bits from selected mapping table item
  * @map:	Bitmap to be scanned for set bits
@@ -1296,7 +1298,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	const u8 *start_p, *end_p;
 	int i, bsize_max, err = 0;
 
-	if (!m)
+	if (!m || m->state == NFT_PIPAPO_CLONE_ERR)
 		return -ENOMEM;
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_KEY_END))
@@ -1367,8 +1369,10 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 		else
 			ret = pipapo_expand(f, start, end, f->groups * f->bb);
 
-		if (ret < 0)
-			return ret;
+		if (ret < 0) {
+			err = ret;
+			goto abort;
+		}
 
 		if (f->bsize > bsize_max)
 			bsize_max = f->bsize;
@@ -1384,7 +1388,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 		err = pipapo_realloc_scratch(m, bsize_max);
 		if (err)
-			return err;
+			goto abort;
 
 		m->bsize_max = bsize_max;
 	} else {
@@ -1396,7 +1400,26 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	pipapo_map(m, rulemap, e);
 
+	m->state = NFT_PIPAPO_CLONE_MOD;
 	return 0;
+abort:
+	DEBUG_NET_WARN_ON_ONCE(m->state == NFT_PIPAPO_CLONE_ERR);
+
+	/* Two rollback cases:
+	 * 1) no previous changes.  nft_pipapo_abort is not
+	 * guaranteed to be invoked (there might be no further
+	 * add/delete requests coming after this).
+	 *
+	 * 2) we had previous changes: there are transaction
+	 * records pointing to this set.  Leave the rollback to
+	 * the transaction handling.
+	 */
+	if (m->state == NFT_PIPAPO_CLONE_NEW)
+		nft_pipapo_abort(set); /* releases m */
+	else
+		m->state = NFT_PIPAPO_CLONE_ERR;
+
+	return err;
 }
 
 /**
@@ -1473,6 +1496,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		dst++;
 	}
 
+	new->state = NFT_PIPAPO_CLONE_NEW;
 	return new;
 
 out_mt:
@@ -1896,7 +1920,7 @@ nft_pipapo_deactivate(const struct net *net, const struct nft_set *set,
 	/* removal must occur on priv->clone, if we are low on memory
 	 * we have no choice and must fail the removal request.
 	 */
-	if (!m)
+	if (!m || m->state == NFT_PIPAPO_CLONE_ERR)
 		return NULL;
 
 	e = pipapo_get(m, (const u8 *)elem->key.val.data,
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index b82abb03576e..a19e980d06ef 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -131,9 +131,16 @@ struct nft_pipapo_scratch {
 	unsigned long __map[];
 };
 
+enum nft_pipapo_clone_state {
+	NFT_PIPAPO_CLONE_NEW,
+	NFT_PIPAPO_CLONE_MOD,
+	NFT_PIPAPO_CLONE_ERR,
+};
+
 /**
  * struct nft_pipapo_match - Data used for lookup and matching
  * @field_count:	Amount of fields in set
+ * @state:		add/delete state; used from control plane
  * @bsize_max:		Maximum lookup table bucket size of all fields, in longs
  * @scratch:		Preallocated per-CPU maps for partial matching results
  * @rcu:		Matching data is swapped on commits
@@ -141,6 +148,7 @@ struct nft_pipapo_scratch {
  */
 struct nft_pipapo_match {
 	u8 field_count;
+	enum nft_pipapo_clone_state state:8;
 	unsigned int bsize_max;
 	struct nft_pipapo_scratch * __percpu *scratch;
 	struct rcu_head rcu;

