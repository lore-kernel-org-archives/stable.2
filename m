Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B54BD102
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447479; cv=none; b=etRumrHQQbFb8qC1O5Xtjf1qXC29JzQKJgh5f186NvccawYsrwgJVnD2nyH42O86JwEkPMxrRAZAph4ZHFtFT4U62+31G1XfV3ItWSYP/r8Y3EA8i9Q7HNOxt+TcA0rsPbtXa0NakKp/5YzxiGWCs6LNpdESZTyMFrgKxG5uoA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447479; c=relaxed/simple;
	bh=qaETQDtnad1TUlbHOP9J7ajTReas+JTL6/GqwIiWxmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LuWoey2TQu5EqkC9I4C4f0Xi829a/2tp2sDf8Hbf5Fze4sqKBi2j9xF4Ns+iZpkMQf4yPhmrvQT+HQiRul8HVjd2Qh+vug8ojjclJ9/eZZiuU52qztniGK+6DW4jDzRLex+Sx+6jaDySUnLNxdpY8T0kAqWfQF0RWB2x7WkpSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuLfyu4h; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuLfyu4h"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccae46de39so3718445ad.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788447477; x=1789052277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CHrg3cDedBMRGb61wI6lrgfnxx6d3yqY2V/Q1s1/JCc=;
        b=RuLfyu4h+zF5r+ZjsjSPB/AJvlDYUlsDEqmgoaRfbf+bGG8djtJ9oP93KEmUn7fYao
         2bR3J8sq7uBL/W3vBq5fQeNZP78jW7UE29BEh86+vk8GUIQfCZeaUtRwO6661ZNmtXNO
         ELa3u0edK1T7LAtPXh6+auDUGLeY+0oh/ItqaSyg7r8lsLNGLxJeil6oA/lql5atyQ8J
         HqPkEJdpSb2vq7vkkxvZnGCppp78Gtk0jyE3SLFGp7K0qjrnwys6phi7y5XybHx+eghL
         jw+/XDjH/85l+faKOQGeFx2927ZkHu5IJhaxi4XT3AUBdXgCBwh1BjFRjgggdGJM/3Rw
         081Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788447477; x=1789052277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHrg3cDedBMRGb61wI6lrgfnxx6d3yqY2V/Q1s1/JCc=;
        b=XhWWsZm7UyGcDXeYTQrECuJyz42phPLzW23jCr4nrLNkor9BaHeYLMtYxpOX94v01T
         B9Q5sxGSEJ9yo3epFvb0fuguRk1OIzgK+GxqnU9iyaUg4Ef0/v01KOSXJnut7rOhl+ME
         7pnoDvdnI/dR/XXPH5FZyxnDhWHcDzykI72ys3JgbMnxrv1TOf6MWsTJ6RJQjDLgq6y0
         pEroHDKz5Qe4ldFhTygoSx+tG0InHsBkVjcyXttxvmDCXKgcK2PiYh+iG02KFvpH83Nj
         AE4JW8f1SGgvuC//tqdV62qVRWQYMe2LmQ9ALCdmnWdeEzTE39hWkEtGirUdRhJxMs7o
         +LQw==
X-Forwarded-Encrypted: i=1; AKwUvBy8pjUHYoq5jIsI3qZWi79PPKI4m6h4I+P3jd/PHAGAfm2XkeDeiUx/vQWjFT4UwOFaSV9EENM=@vger.kernel.org
X-Gm-Message-State: AFuF++mCniu90Y2IH9vI/hLQKR3ezmOC/EeQiv7AuZefGB9bWqBYUvDQ
	edLinn/pN7HQxJ1vvnWG21g4zfU6fm8e7wDiU9/jOECycfaYIgBx+eD/
X-Gm-Gg: AYBFou393GK0EWS6D7xgWijjiFXcqq7UaPxT+6zeJ6DzpHzlf8g5VVVknYv+it7zK4w
	qYhBeZ9V1KAEU06pCc2QzSXRDOXrK7TI4FSpb6mbCWRq6Le3BakYQzNjMVv4xRzaaH5fqPs/oDF
	Bl5W5h8erDSmS+cSdswKBgrkUrHFbRG0EbjFXauy9GyarHudJMQBWrGd6JL1DeKh+LPR8D75WOI
	KOtQEJ/FAcatYZ6PCWuBGkrPpfWpkBqrduyIPJzscIPiRuENs3SzlQk4WYsMBZSQWqTsZmO1WQ8
	GFPsGJKODXREMMtZIl32dWyouBXGq/xSUB9GLh7mMHx9FGYcJTH4itImtkeN6A8mHR8rKrRQ7xw
	uVQy2nA517BSVCXilWfGWCnH3/7anh6+2I5NJmnEGWSAOTCaKhp6fnEYW2tLtSWoZjIGxV8AqB8
	qw2jGjd0mZKymnjBiPMEVKDTOm041w5npvBwDgZDrBsTIZPuGKcY1OEyZdwcnYk3J9u4uvklr7f
	KuLNA4eW0IiXYmQKEru1b80+Lm7VxnJrO2CAZgoh7f3
X-Received: by 2002:a17:903:2ca:b0:2da:e5a1:4b8f with SMTP id d9443c01a7336-2daec6d3c49mr123986925ad.2.1788447476665;
        Thu, 03 Sep 2026 07:57:56 -0700 (PDT)
Received: from localhost.localdomain ([14.218.78.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafec29a02sm11529805ad.54.2026.09.03.07.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:57:56 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] xfrm: retry inexact policy lookup after node reinsertion
Date: Thu,  3 Sep 2026 22:57:34 +0800
Message-ID: <20260903145735.468999-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Changes in v2:
- (changelog) Drop the unrelated xfrm_policy_count[] KCSAN report.

v1: https://lore.kernel.org/netdev/20260824152057.216329-1-nicoyip.dev@gmail.com/

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

