Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3EB36AB46
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608797; cv=none; b=iWLLqV7IJI7NFNGm3fbR84WMBYFH09MsnMkRGedTmqZJo+ngG62fh8paCl89soqUGoetXxNy3vSRwrtyd8B/Rn9/fjaUpbbNZGJ1ynckGu4NRBoKUZpQNRLPttwj09KUJ38uzh+883pLog/4zPd+jMb4wzCByni0REbp/TbDZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608797; c=relaxed/simple;
	bh=pxN6FoGXlcsLvYyDlXjpUeGGpz+IZBNt2IY6O2YCr5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDdSO6iScZcZRrROKvJA//e5AHdce3pO1sE5UhM2kYgxP6X5DBQkkwsVzZRpAiNmTNR3HfAov1n/Kpj13keTnv9pqOCVSCG4xmD12335ghdN+bJaFeWyk6ak5LhzON6veWFwSsgyD98ZChJCmmjkQjvSoNPc3I8EpRrp+WXruMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjXH6L8Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjXH6L8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B295A1F00898;
	Thu, 17 Sep 2026 01:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608796;
	bh=r/uD3Co8FYHpIqwgQSRDWhNx9HVUbMQGhS5FzoLW7dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JjXH6L8YtnK/3rnTLC/d17NpKNISGzkJP6d0etlXlJS3/y6gZhjOzXcHPJATlOvSr
	 S1Sq7MAUOzfJ0G4MI/gIWww5w12jWykaSv4Qk4qBtiBmbaXHksRIt2X6pNHi+4XtOU
	 nr8o1yO35grlD0VOHd0TjgvtIyLacekRJc382l7vvmxMe3YipqTQP01tLAz+WZ3NF7
	 xUsFLppxn4ZkVqOwL5mGEk3FyMv5bU+uTzjpsTQOBnRD1i11xAwd4vBJFLR9qFHMwX
	 iQdAmTSffNQImgoYwBKLPn9X24dFbpY0Y/9rYMx6H8Bd0aSOLp2BMhmPL+9I/f7wbU
	 fJ7u5nmImGeRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] netfilter: remove nf_ct_unconfirmed_destroy helper
Date: Wed, 16 Sep 2026 21:33:10 -0400
Message-ID: <20260917013313.3594807-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917013313.3594807-1-sashal@kernel.org>
References: <2026091646-antonym-acid-ca2a@gregkh>
 <20260917013313.3594807-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 17438b42ce14cb60ceda9ae62ad5dd022d55a216 ]

This helper tags connections not yet in the conntrack table as
dying.  These nf_conn entries will be dropped instead when the
core attempts to insert them from the input or postrouting
'confirm' hook.

After the previous change, the entries get unlinked from the
list earlier, so that by the time the actual exit hook runs,
new connections no longer have a timeout policy assigned.

Its enough to walk the hashtable instead.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: fec9b1de0d02 ("netfilter: cttimeout: prevent UAF during module unload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack.h |  3 ---
 net/netfilter/nf_conntrack_core.c    | 14 --------------
 net/netfilter/nfnetlink_cttimeout.c  |  4 +++-
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 39541ab912a16..571f44a2a6fed 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -240,9 +240,6 @@ static inline bool nf_ct_kill(struct nf_conn *ct)
 	return nf_ct_delete(ct, 0, 0);
 }
 
-/* Set all unconfirmed conntrack as dying */
-void nf_ct_unconfirmed_destroy(struct net *);
-
 /* Iterate over all conntracks: if iter returns true, it's deleted. */
 void nf_ct_iterate_cleanup_net(struct net *net,
 			       int (*iter)(struct nf_conn *i, void *data),
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index ea9aba75b38af..65fea9f685260 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2446,20 +2446,6 @@ __nf_ct_unconfirmed_destroy(struct net *net)
 	}
 }
 
-void nf_ct_unconfirmed_destroy(struct net *net)
-{
-	struct nf_conntrack_net *cnet = nf_ct_pernet(net);
-
-	might_sleep();
-
-	if (atomic_read(&cnet->count) > 0) {
-		__nf_ct_unconfirmed_destroy(net);
-		nf_queue_nf_hook_drop(net);
-		synchronize_net();
-	}
-}
-EXPORT_SYMBOL_GPL(nf_ct_unconfirmed_destroy);
-
 void nf_ct_iterate_cleanup_net(struct net *net,
 			       int (*iter)(struct nf_conn *i, void *data),
 			       void *data, u32 portid, int report)
diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index 2a241ed20edd2..e2baa56fde531 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -612,7 +612,9 @@ static void __net_exit cttimeout_net_exit(struct net *net)
 	struct nfct_timeout_pernet *pernet = nfct_timeout_pernet(net);
 	struct ctnl_timeout *cur, *tmp;
 
-	nf_ct_unconfirmed_destroy(net);
+	if (list_empty(&pernet->nfct_timeout_freelist))
+		return;
+
 	nf_ct_untimeout(net, NULL);
 
 	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_freelist, head) {
-- 
2.53.0

