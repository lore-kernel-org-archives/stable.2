Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273908;
	b=kBu5EP3SnObVPoU1J/wXlmCj2kHOwf0naF/xTkMZMqq84UVwB14TiPBrgTAs2fALwkmF
	 M9IEkvBY2T3ypIDzfrn82VMMYwTzW2DZiADFVwVabJkJHqiVw0qaqKrCbxsBp53a92Xoh
	 039xHxOk87GxcCHtQmDiwhs7rUqeJjeOvDCdr76IX8tS/kdt6QpMAP6ehdzPmkeQZdBGF
	 V2I2JOmmizTh6oEr+MzGRMq0V+sDvik3MBzWFiKHxJ5Vev2muqX8BKbVDBza4ymqEjTyz
	 ijbV23oLVwmO5ukacDF4EliHz3Mk0FMKobZ8dpMyJn1SzIE6FyM4K0zaalBJjg9X7Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273908;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ps+1QQOoRKuqnGX3M7Xi/qVusuXMf48jY3Jir3Hfuzc=;
	b=swM0RR5GpWVjSgIsEMVm92EZ24MrEjRI+s2kXtQLw0CrdxuEA2Q5qyKS41eKgI30iW2e
	 i6ayyyo2O/WUXdpv+dUcGLuvLQ3zKKo43whDsROKJMY14orjLP0FNPcTWpnUBhRYqYGe2
	 JH+3VuiGIztjbm1qd/o20Id8lgvBnViUhG6mP4OieHKVOKEamoXSEW4XgPozIvxKYXXzl
	 1OIga0mY5dIV/ETnA9/dQonI9Klt1nNYvlpy5KGMu+g/1K+pABwX/XeS+5jNHw3PgH0bo
	 Mdap4BnSHvdf0dn5ud45DdlCNpeHzP1YFUQ0kTqkCC4cJnpfRwIZbwrciwP6n660lvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTwVlo0h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF6606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTwVlo0h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF141F0089F;
	Tue, 10 Nov 2026 01:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273908;
	bh=ps+1QQOoRKuqnGX3M7Xi/qVusuXMf48jY3Jir3Hfuzc=;
	h=From:To:Cc:Subject:Date;
	b=UTwVlo0h/sw//OPWBmKvFIPASaW+JR7lNZj7y4Rbpv4gMv4fyC7jhWpWYQms2irCs
	 UvOQu2+omefQ/OV5x90xmciVMUyxg9FayxAXqlpMnWRLf8gexh54gb1JGSm3q7N0Ae
	 nGKTdD6n1WW3G7XIZu6lkZcJ2E+hUdeOR5QHEHPj2RjHIVBDpiHqwD7YOYF7eU06au
	 CcC28jOTqMGsP+OppI/yhtrRb9VbK17a4xktqwq7E1BrlLe7X5dFxftDiGrXhhh3aK
	 aARRJNMKfTxrBDmA/NPn/w8TwbfDpZXkd18hOQz8oKrx6Qsk6GznjC5E+EHrWVvIJv
	 Xa/KyuVap4CCg==
From: Sasha Levin <sashal@kernel.org>
To: nicoyip.dev@gmail.com,
	steffen.klassert@secunet.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xfrm: retry inexact policy lookup after node reinsertion" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:06 -0500
Message-ID: <20261109202506-failed-5.10-868f63c8bfaf@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 868f63c8bfafa9b827168c9126f85264c39c02ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202506-failed-5.10-868f63c8bfaf@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 868f63c8bfafa9b827168c9126f85264c39c02ec Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 3 Sep 2026 22:57:34 +0800
Subject: [PATCH] xfrm: retry inexact policy lookup after node reinsertion

An inexact policy lookup first records pointers to candidate hlist heads
and then traverses the lists.  A concurrent policy insertion can merge
inexact tree nodes between those operations:

  lookup                         policy insertion
  ------                         ----------------
  find inexact candidates
    save obsolete hlist head
                                 write_seqcount_begin(&bin->count)
                                 merge inexact tree nodes
                                   hlist_del_rcu(&policy->bydst)
                                   reinsert policy->bydst in survivor
                                 write_seqcount_end(&bin->count)
  evaluate saved candidate list
    miss the moved policy

The merge immediately reinserts the same hlist node into the surviving
tree node.  RCU keeps the policy alive, but it does not provide a
consistent view while its list node is moved.  A lookup that selected the
obsolete list can observe it empty.  A lookup already traversing a moved
policy can instead follow the next pointer rewritten by the reinsertion.
Either case can return an incorrect IPsec policy result.

The per-bin sequence counter already brackets calls to
xfrm_policy_inexact_insert_node(), including node merges.  The read side,
however, currently validates the counter only while searching an
individual rb-tree.  A successful search returns without validation, and
the later candidate-list traversal is outside that read-side section.

Snapshot the per-bin sequence before discovering candidate heads and
validate it after evaluating all candidate lists.   Retry the lookup if
the inexact policy tree changes while it is being searched.

Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 513c9f2283347..f6f40ba713d5a 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2157,6 +2157,7 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 	struct xfrm_pol_inexact_bin *bin;
 	struct xfrm_policy *pol, *ret;
 	struct hlist_head *chain;
+	unsigned int inexact_sequence;
 	unsigned int sequence;
 	int err;
 
@@ -2191,12 +2192,18 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 		goto skip_inexact;
 
 	bin = xfrm_policy_inexact_lookup_rcu(net, type, family, dir, if_id);
-	if (!bin || !xfrm_policy_find_inexact_candidates(&cand, bin, saddr,
-							 daddr))
+	if (!bin)
+		goto skip_inexact;
+
+	inexact_sequence = read_seqcount_begin(&bin->count);
+	if (!xfrm_policy_find_inexact_candidates(&cand, bin, saddr, daddr))
 		goto skip_inexact;
 
 	pol = xfrm_policy_eval_candidates(&cand, ret, fl, type,
 					  family, if_id);
+	if (read_seqcount_retry(&bin->count, inexact_sequence))
+		goto retry;
+
 	if (pol) {
 		ret = pol;
 		if (IS_ERR(pol))
-- 
2.53.0




