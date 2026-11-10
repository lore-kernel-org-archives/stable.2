Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273605;
	b=jRaQHF6xWljawfGcQE6GcbIhIXF7pBu0DYpa3yUeryjXjs8M7bHzjTYJLlWQxw392znR
	 YruwKxcNqMcLnYHLkmjuX8DEeFsq7fJwmQNHNeEO9d9UdYDvdKU3Q13BF86UVgYIptgw/
	 mY6E77c/een+7+wxJheWkTz/xA5/He1YNjJMLdomiMSQp4zRWBI9Oso1c93GbjwdWgKnJ
	 r7eCIKvTNiWBeOmIeNSQs84dtmt1doTWXe5ZwzW1cYT55n/dbckL9SMP92ptJrBGAk+ub
	 DhdMQLu2Vq7lgcE2+IkQgrY7jgEGlZfK6NGrrYtYPkYoJEn6KDj46ZWl3bwmh+5+W4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273605;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o7dl4RCvql0zK4vfWYKEVi9Aj0+hU9LdWoWApzABsg0=;
	b=l8CxFljgeaxb5KWmfOKu0LG8l+OTeg5leu/C4+oSMTkiK6vhWsoC2Lqe6nnlmcgTF7lS
	 0ROpyN5nNmECppLXzUMTmS4ThC412PMol6SxiXcqyg9AeHxC/HpenC8nYUIH9phbk6KOA
	 rheWubj5gOAnl9APOyMygG8XSZbUYE/AROVcDgSswOif5DXreVPGrKkiwGpIOu0nyQoJb
	 GeGFCxiUOZbI6/91DKanF8OHL3i/poD93mXDPiFnvjgva/NuVrTLRIHFgAGjOzX5oodtH
	 UPBSRhpigsEUpKMyBJn3R1tAm2nRIu/d8CltugB/f8GsoFyueMiLLTemIbjZeWhsE3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ju8Nc3Fm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC3606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ju8Nc3Fm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2351F008A1;
	Tue, 10 Nov 2026 01:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273605;
	bh=o7dl4RCvql0zK4vfWYKEVi9Aj0+hU9LdWoWApzABsg0=;
	h=From:To:Cc:Subject:Date;
	b=ju8Nc3Fmt89qCk+yqV12zk6t0g951rc/k6GM/PBW3iVuz+SAoTjspqIyt9dWPNzOI
	 QG0z+fWjLLdvhggVwhwRaV1s6ofkrx45QLcDBbpQYqXaHHx9kAlVjK/8z7lfAx10UK
	 8+wQnIk3j8z+oF6RuB90DUVmdK1LS+lpVxOUUc5nZrNoi9tQgy4luCb93gY6mZxUiY
	 yfRJfkLdhPP7EhTCXFti9NnBL3y95OC2ipWb3RkA7d3nzZEaz8Xw7qkuqV6yb5Q/zF
	 BdtrUBN6Y8BMSf8JEgyVS7RtqkTbXxE135fXSiRfqSLmHVG8taRlycyd48+xgGUp2K
	 j2KBtqJF8ympw==
From: Sasha Levin <sashal@kernel.org>
To: nicoyip.dev@gmail.com,
	steffen.klassert@secunet.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xfrm: retry inexact policy lookup after node reinsertion" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:03 -0500
Message-ID: <20261109202003-failed-5.15-868f63c8bfaf@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 868f63c8bfafa9b827168c9126f85264c39c02ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202003-failed-5.15-868f63c8bfaf@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




