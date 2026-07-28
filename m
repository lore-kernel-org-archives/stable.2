Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B23EB0F4
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242064; cv=none; b=V2zoGONG14vPK4tIMdh/0bB8uwFEEqr0w7nmtghQ9fIbKJa5hxkn0epq1XmYJsYMMbcZJKIZp4aNuPKG5Bl9kRsC3YXDoY5d7yNgwJxmK8Zi6WWfVW2PPOU3uhVyZ7nJ+NvDzkwVKSzobaKBo7VhhxjedDSxTUbReAt75GtQhWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242064; c=relaxed/simple;
	bh=X9WqK2SHSPOE9lYH32Zt7CX9cNLIRj4OPfF1I9+51q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlJv6QVbEld4TgJEFsK5x8OqFAhqJ/pc0Bw2wC+vQ+eOFj7+pNkC1KSF9deqJ5ms1TtZpuP50qU1IjrXxpfUyconbAUp/7ONhZjdKHjaQYgTyMNswCfHv1xBz1uLZEpOZAdgqOti6IcyrxumlhnD0sCCbRG4lFUULCOUU1liFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO1/SmjM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO1/SmjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D381F000E9;
	Tue, 28 Jul 2026 12:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785242062;
	bh=E6SJaY69FzBfsB/MONFftjKxne/yHyiufrWO0MTGjkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OO1/SmjMDBuD8B2ROsj5sAno1undzMgZO7rjJWKBkLHQsIqNl7FGsbwLiTi50s1u0
	 OzwScLTxKJ6lJPMm7wRyGB78/2smLh/8k38wNLjZZD9pjnrnoDyGOYss9wj300lkuK
	 jCw78pUDJVBrdpuiqgxcrbx9kX6kl+P3zZjGow9rGvRym6RViUVQ24GHTH7bBw8yY5
	 EwzyUP+e0ATPRoWy/dONkjLi2dhOStAQwoyvUD7JgrHZKsAYaLKPq2+IedJ7qquEiP
	 0At7FtG7K5ZSSOXs30E8lyuj5To0wHazo9LuCPm+pLfFA5QSNYWbZLkUjUC5GqKUAj
	 uPrkpxwz9wGJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <xizh2024@lzu.edu.cn>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net/sched: act_ct: preserve tc_skb_cb across defragmentation
Date: Tue, 28 Jul 2026 08:34:17 -0400
Message-ID: <20260728123417.3768679-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072018-sixtieth-darkness-30c6@gregkh>
References: <2026072018-sixtieth-darkness-30c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

[ Upstream commit 9092e15defbe6c7bc241c306093ca9d358a578e7 ]

tcf_ct_handle_fragments() calls nf_ct_handle_fragments() without saving
and restoring skb->cb. The defrag helper clears IPCB/IP6CB, which aliases
the tc_skb_cb/qdisc_skb_cb control buffer. Fragmented traffic through
act_ct therefore loses qdisc metadata such as pkt_segs and can trigger
WARN_ON_ONCE() in qdisc_pkt_segs() when panic_on_warn is enabled.

Save and restore the full tc_skb_cb around nf_ct_handle_fragments(),
matching the pattern used by ovs_ct_handle_fragments().

Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc control block")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/510c51217fd7aaf29c6dc298bab8d643fe229b1c.1781358692.git.xizh2024@lzu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 651701a186fec7..f1208fa7433c58 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -858,10 +858,10 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 				   u8 family, u16 zone, bool *defrag)
 {
 	enum ip_conntrack_info ctinfo;
+	struct tc_skb_cb cb;
 	struct nf_conn *ct;
 	int err = 0;
 	bool frag;
-	u16 mru;
 
 	/* Previously seen (loopback)? Ignore. */
 	ct = nf_ct_get(skb, &ctinfo);
@@ -875,7 +875,7 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 	if (err || !frag)
 		return err;
 
-	mru = tc_skb_cb(skb)->mru;
+	cb = *tc_skb_cb(skb);
 
 	if (family == NFPROTO_IPV4) {
 		enum ip_defrag_users user = IP_DEFRAG_CONNTRACK_IN + zone;
@@ -889,7 +889,7 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 
 		if (!err) {
 			*defrag = true;
-			mru = IPCB(skb)->frag_max_size;
+			cb.mru = IPCB(skb)->frag_max_size;
 		}
 	} else { /* NFPROTO_IPV6 */
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
@@ -902,7 +902,7 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 
 		if (!err) {
 			*defrag = true;
-			mru = IP6CB(skb)->frag_max_size;
+			cb.mru = IP6CB(skb)->frag_max_size;
 		}
 #else
 		err = -EOPNOTSUPP;
@@ -911,7 +911,7 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 	}
 
 	if (err != -EINPROGRESS)
-		tc_skb_cb(skb)->mru = mru;
+		*tc_skb_cb(skb) = cb;
 	skb_clear_hash(skb);
 	skb->ignore_df = 1;
 	return err;
-- 
2.53.0

