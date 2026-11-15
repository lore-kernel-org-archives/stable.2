Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704195;
	b=r4+DroaDIUcAyagTDe3L15NYKNF1pEiVH/WQn9HM//ZoewlGOtYElL5Qvb9msp/WnECf
	 j12iIObgKbtivFcFM+ZfuhC2AiAle0g1UHbQhHkaK26O1zg+VbNdtw5/cVdlK4aKTd6EG
	 jmRjGqcwmTKkHwDESMoRHh8AnGy4Z7lk7WwnVsI70phftiEu3bWfC9qoHzGC1BEt8BtIp
	 +wqdC0yfmhlD2IujauoX17xa7A593nGKptVjPw7boO0OdvxTnJWMAAWTEpLBOonzpgjvt
	 v09iFFz/O1f/61po6xC4Vh+f6yr8ZTaE4kF2cHp3aSy+e9jFswP6dxSdcn/k2ErwQNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704195;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5dXjD2qR6qM2aViVTtuAOp4gGmEo825SdXXlHkWmJWQ=;
	b=D0gKfK5zvcYWAg09vxXT5Rrm7fbrGndZ4ib0lDM6tWiotxVrdeIJR606mJvj+/l0dIMV
	 OvpaXQTXmaurKEDhQ/JhrkhY/X9VC1ArY97SVmVxRKLpUSk4DQR1OIjl9qbscvdAhNwXb
	 t8MAZxykgTVQ8qWZ2YX0f9QzsIPoMqFlMyXX/9AsCqaliEWpFEFyuATVkl9GB5ovgEA+M
	 Y0ZLLnltFV+VDuy7giLFbIrx/PVB1kB0wmdJCg0EuZn/XwnrhH09/6MqYVpsX+M1mvsDV
	 iNZ7ZY/ePdhnpVH911ZlHNQuKL/h8CCIRNMd8NF1elXTXSb1Qk2NolPDnKGBflfBqbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iI+DyWLt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A28606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iI+DyWLt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EF81F000C4;
	Sun, 15 Nov 2026 00:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704195;
	bh=5dXjD2qR6qM2aViVTtuAOp4gGmEo825SdXXlHkWmJWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iI+DyWLtLD8J40LmxfNlQuit514tuyl740SGlbz6n3SAYM06Fh8aOc+x5wn5H0XYI
	 lFT81RbyeBdE2L7GJFmdki1h5e+vfx5SNAtFPlYq54R2tWrESPNbRU02Mbk0v+mNVv
	 OX/o+YKI0u/DU4IpeS7PktN1Tbfj8KJkSxrNbvwQhdpX7pH786rvt2R2FlsaYXm3H1
	 NWcmKex3slfiPCK1INepta7WumoIsLqnLfTdAxuXmFagK34R2zB2Nsrt06tdmoddQg
	 7LlQAko3dh20TTxgPJxetTih3vAJYlm8UpqMIDq7BzEq2Qino9In8XMHmQ8kEpFrcd
	 Oajk24oaYmKXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfrm: retry inexact policy lookup after node reinsertion
Date: Sat, 14 Nov 2026 19:56:33 -0500
Message-ID: <20261115005611.615768-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202506-failed-5.10-868f63c8bfaf@kernel.org>
References: <20261109202506-failed-5.10-868f63c8bfaf@kernel.org>
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
[ sashal: preserved the required dir argument in xfrm_policy_eval_candidates() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c14f495f62b80..0b753c0ba0055 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2104,6 +2104,7 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 	struct xfrm_pol_inexact_bin *bin;
 	struct xfrm_policy *pol, *ret;
 	struct hlist_head *chain;
+	unsigned int inexact_sequence;
 	unsigned int sequence;
 	int err;
 
@@ -2135,12 +2136,18 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
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
 					  family, dir, if_id);
+	if (read_seqcount_retry(&bin->count, inexact_sequence))
+		goto retry;
+
 	if (pol) {
 		ret = pol;
 		if (IS_ERR(pol))
-- 
2.53.0

