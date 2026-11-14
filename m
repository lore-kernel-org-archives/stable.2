Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672452;
	b=z58tGJmUwBRj/5oDkFlEKkZP85lOtiXDYJuvSd3zvdJrQDzyA2GuyH6/roMp7kXz/ry1
	 tMphNW3RjnSk6p9DF5ATE1OweW3Bm4b9eGrA+e2/TpQR58MyexvvMB6pN+AGY+PpcZTWx
	 8Tgf2O2oz5HNF0qXxsekKHUZnv7L1g/cTZIRABf6Rq4vYwqm5z5svzAFaz3gF2BrB9WAn
	 LK2i8I8xRlBp2CzgbA6Ad3Sp6gH/8oSKQk2RrIlWV/f7UxzLmgjS2nxIM3qWFXO3K8OXM
	 R0RsRlMnu9+tzFQ2zNtympBLqS2eYWduzhHYhjAq6qBbO2Ye4i4ETvasZYjzo4Jl2hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672452;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J5eOfzQmafq77zZV0B+BOpxLyvPTWUCJaTlDrefVNro=;
	b=vpmB5YCTOmF+HnhZLLUrxSiJLYQoTmwg0ggKKJNcxjwjIOsB+aKIiZ5j9MyeHCEmB+Bg
	 PAVrWTb3VhWMCaE+O9xr2E8ObdcwNx6Pudp1/tTIrlwNrRCFw7sbwSNksveCzvrBPPTbV
	 WxIjz1Uk7wPCr3DzEQ4I5pzHMTLZFHt6f+Fk+Tz0vjC+n5zMdveVZYqmzK8KkvLtTuo3Q
	 g5aGX7omP15Jfoi/cdoypGp1CPOjY1MSUcFsxuKqHog7zP0ociZKeIJQ1P73vKzvUNvYN
	 Fsy7tt09OM9vnktsjJmjQ+mJtFHmb1cHJfKOKNOXICTcRioe7i32rtAeJ9xf/DgB2Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E+D/ohyn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6D606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+D/ohyn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFFC1F000C5;
	Sat, 14 Nov 2026 16:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672452;
	bh=J5eOfzQmafq77zZV0B+BOpxLyvPTWUCJaTlDrefVNro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+D/ohynis+/yrW4hsAWphi4ZDjPVKja3JoF0L+RbEaqfFh5qG/n8LC/B6L1k52Hk
	 JX77DD4cxpPKcPMKCWZ6XN2YWWmDG/HCexDwFMNFr30BsIxj8nOnuvE6SXxifomQSr
	 TomCwVMv4N+2mfo2ylPU2KcE/AZHx39ubhFnNyrbX6X/dpknRBxsttEDy3UpZDd0Zn
	 ctw94ru9yfDhkRjlZD9Dlc2/6QZz3UN96vTJOiB2uWeeJgsIlzw+KgejhXdZSPmN1h
	 c9XUiDKx2LNN7DRFy36en5hk/KQTgWNkAFyoht5UYmjDY0eof22X9ibXR/slmiz1L2
	 WIggdx/8dUj4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] xfrm: retry inexact policy lookup after node reinsertion
Date: Sat, 14 Nov 2026 11:07:29 -0500
Message-ID: <20261114160719.3922066-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114160719.3922066-1-sashal@kernel.org>
References: <20261109202003-failed-5.15-868f63c8bfaf@kernel.org>
 <20261114160719.3922066-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit 868f63c8bfafa9b827168c9126f85264c39c02ec ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 9e18e8d2c1c5c..c48315afead13 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2102,6 +2102,7 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 	struct xfrm_pol_inexact_bin *bin;
 	struct xfrm_policy *pol, *ret;
 	struct hlist_head *chain;
+	unsigned int inexact_sequence;
 	unsigned int sequence;
 	int err;
 
@@ -2133,12 +2134,18 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 		}
 	}
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

