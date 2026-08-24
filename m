Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD336A352
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584869; cv=none; b=fFLQEtGrYrJObwjTtimYwQpiwkSkRPVPboxpvs8fVjiWwUSdzyJyDZpGtrncbpzKLT2B4+otTGnEA5I3InGQfFPRrClkPeTB+qC0drPJi0499TgaZN8kbfC0z8kdGuyyhPspEOel7uQHmn4MXZKHA49OeIVqdHyAMTq7TSrRPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584869; c=relaxed/simple;
	bh=XY2OgZaePqMnmpH5RREj5/3sAFhLh/26g3/Ol4N3ewo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5UuxgKJlTc95Qa0MJUGoCne2bSC2VwUvSz9gyD6JutrmaLmVggE7vSnRSQShxvwuNGF0cy/1LtgLSvJtUDk5j0nx+FdkrUyJMdtU9D0pNY7eORB3jYILSUDljSl7u72MxIG+HP3QH+6oRFKS9rZV4QqK7tf7eKr1pHJoNFVfqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RALPA1WH; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RALPA1WH"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-847ffc4fb1fso1920247b3.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787584865; x=1788189665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5uQFclyHynCG/0FLEAf23P/Cd+g9q80jm8OGZqPvec=;
        b=RALPA1WHSXLP1JkVHUcJDsei1iEPqgWD0iiFuxtwm4WM7nrvQXlWkNENjFaObGAzSU
         r9McLzOd33bgGf5Uc2yr1VeqDSrKWLl/zluKCrSCZe9P5vddqgYi7nr9PvUnE94oI1et
         1XF8IGUEnIM8vhD3GOXE3/B/Bl/Q6XTMN2f1/cUvATabIkVV3Wjd7XVdiPfqukfUOB4w
         lTHL5V+mYlFz5a2Ci6vJmCIXsAq6TBdk6y4CEMhk80TMsMRSXJ4GmUGxtI6skml9jjG5
         1s7J7nHMoGC2hDnntkL0h3EpCQ9oytzOU9JL+TqUyxmTs9aRTb/fmsOZTf99Lh0j0tzb
         MzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584865; x=1788189665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5uQFclyHynCG/0FLEAf23P/Cd+g9q80jm8OGZqPvec=;
        b=KbhtX66hG8pWICDPhEbQ946Mpm7/yQ5DYxx/BdAOqDNoTGxXNw/HoJZNknhLRYakZ6
         Eem1nVF5K5p+RgwOwn/FNhBroKDK4GqYOHhbTDEW08I9S7QjGxDFbQWZFZ0TklZ41BaB
         q+fER8H03Pl6Kazxa4kiL+MzR4HDMRGEPhYpwJT2aG2BXCHciiNgSEnz9dtSL6mmeL+u
         xOVm6Mo35Oq9dsxFEe5lEpD3zaIgMlh23KJJyjkolqWL/j//bFNSvywLKjVM1Phmg7tC
         1pBCJqZc7Il/RwD0cNBRcCgeS70eHxMDStCCHXACO6UU1DkTZDr3UWM2loxkijRlhvUJ
         /Ztw==
X-Forwarded-Encrypted: i=1; AHgh+Roz55mZecpLDHFmxw8+TpdijD9XSEp0JIfIUrfnovNnD2jzmZW+EV8EGY4acL/qmfY6lsEw2g8=@vger.kernel.org
X-Gm-Message-State: AFuF++nEW9xoLf81bBtjNzFiAg1N/6rpzlSkOEnmg7JtdkWBULE3P06s
	rki9DKa1f0fpDjfdXXoMkzmWuLAi29XUu25JsEmCS8xrT41j9AI+Bo3t
X-Gm-Gg: AR+sD12wmmvrnGALSjAM8JVRw+p5jjmeD0JKdiejJZmUOwQ04yx4tylqey0pDRhlTaL
	Cda6PeE34peqNrI/mGX1ce7dekQjpBR/TjnZp1yjphM5KQrPPEijxN4xvEu529xBKHZiQRyUJ+0
	I5PXN2D1vg433M09a92/GzCFNvaxirKsAQ/E3vKP4g4HQwPRdjtXGt7BFh0ek3k5Q+R/CR1ou5Z
	DSCmMSogsLHsEESe7F4XPIhKW3I9UFPwJqtxP6mIrlOa3AAHBh4Mu/U+KqyOAIv9OlpRV30TLvG
	QK+Fp9dDEgTboyTOGInjMxIpxcHOBnSY+S8/nYThZitP6Jy5oQZePAX6A59dlJnnVWvMwHOx0nD
	jgwdA1gqyFwFziKkL9pd1VBjQYzCryJ6B/4reUseRFjvsaOmmkLQI03e29Obdwr9B3W4ismaZy1
	9oAJv70HvZ8HV2cE3fkV0+HOfHtl8yNJPYwiocs5HzrVIvm5WI0hYjx4Ops0gvQvZ5hSQIWHJ9b
	OhMN7JU0ZEqjJXFFtZbG3zojd17gFBlxyQsRWJa6y39i2WZAosp23NCYe2TjhgRGw==
X-Received: by 2002:a05:690c:4f82:10b0:853:bc96:d834 with SMTP id 00721157ae682-853bc96ea4emr10826257b3.2.1787584864959;
        Mon, 24 Aug 2026 08:21:04 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cacac4e25sm35572937b3.47.2026.08.24.08.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:21:04 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] xfrm: retry inexact policy lookup after node reinsertion
Date: Mon, 24 Aug 2026 23:20:57 +0800
Message-ID: <20260824152057.216329-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a newly inserted inexact policy covers multiple existing nodes,
xfrm_policy_inexact_node_merge() removes each policy from the old node with
hlist_del_rcu(). xfrm_policy_inexact_list_reinsert() then immediately adds
the same bydst node to another hlist. hlist_del_rcu() leaves ->next intact
for readers already at the removed entry, but the add overwrites it before
an RCU grace period.

This permits the following interleaving:

  CPU 0                                  CPU 1
  -----                                  -----
  reach policy P in the old hlist
                                         delete P from the old hlist
                                         add P to the new hlist
  follow P->next into the new hlist

The lookup can then skip a matching policy and make an incorrect IPsec
decision.

During concurrent policy insertion and route lookup, KCSAN reported:

  BUG: KCSAN: data-race in __xfrm_policy_link / xfrm_lookup_with_ifid
  write to ... by task 92 on cpu 0:
    __xfrm_policy_link
    xfrm_policy_insert
    xfrm_add_policy
  read to ... by task 91 on cpu 1:
    xfrm_lookup_with_ifid
    xfrm_lookup_route
    ip_route_output_flow

The per-bin sequence counter already brackets inexact tree changes,
including node merges. Snapshot it before candidate discovery and retry
after evaluating all candidate lists if it changed. This rejects results
from any traversal overlapping reinsertion while leaving stable lookup
order and locking unchanged.

Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/xfrm/xfrm_policy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 932a313b9460..5d4e863863df 100644
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
2.43.0

