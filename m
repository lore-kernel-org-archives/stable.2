Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C23ACA5F
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242524; cv=none; b=o5jT+3Q81Poa5C5bzoSgVtPy0Q85R8WifegjPIDeBuMBiHutTdsUaGR2rDEFYQvHTFX8sN87trxkio0kA2TPIqgZCE4uIwsAjYt5GwPlHYBdc1p5xvCQ5NB+T/pIbUvZtalbhN9DPhb4gEbud3m3+NG2A7QE7b6bmaD99eo+x+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242524; c=relaxed/simple;
	bh=xu5FWdP/o1iAXmElZ1e7tiMer++E5lec8lXspFSiPaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J71ALUTqIy7Bf03OdpicMUs7YnRBfw/Rgc112uRhyrSxAlNG3kl3g3VS2UP5AswdrJ6ibMclnGzxt018wMtWLD4ZSjG12bb608GSTDo9REzgLS+ulaDfcjH3xf7xijVEoHzU2wjgEpMM7IHe2VlKEuXMipD52nFb1mobfCrNcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqo5caql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqo5caql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5331F000E9;
	Tue, 28 Jul 2026 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785242523;
	bh=PbwoROWwP2YxiyV9tT5peoB+JMwK7zVicyi+RfB8w80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gqo5caql8Vjs2ymZOyJQUMItwhFTxG8f5Jd9+HXGg66qe4sbKv83y3yGjsAstH9OC
	 zVSBweEun5h7nloV9N+yTfDU5oCLPm+azDaG9sjlxqqxVAoPT8PWYcw+Xpnk0HlkOu
	 96tPPSz0MXcE7O38JuIJyuTZV9CRhdkkYSe7xVt0b1lpv1SJD5BODJZe2tkVGsndbE
	 h/lanKFBYcrIkqV+1Oa08TNth/KJE8FC3LtnFI3a0R36G4ZfSaL66neLV5572SzXWT
	 3mBWTnnAiRFVyKP6wsAUKt0ddN5qwZ/XbWnb8kFW5JxdccvAH4Vtmr1bC1Dwxz0Yxp
	 AUs81DfpuaLFw==
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
Subject: [PATCH 5.15.y] net/sched: act_ct: preserve tc_skb_cb across defragmentation
Date: Tue, 28 Jul 2026 08:42:00 -0400
Message-ID: <20260728124200.3806616-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072019-provoking-acutely-210b@gregkh>
References: <2026072019-provoking-acutely-210b@gregkh>
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
index 1639cc2869ef18..f426783203c450 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -700,10 +700,10 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
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
@@ -717,7 +717,7 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 	if (err || !frag)
 		return err;
 
-	mru = tc_skb_cb(skb)->mru;
+	cb = *tc_skb_cb(skb);
 
 	if (family == NFPROTO_IPV4) {
 		enum ip_defrag_users user = IP_DEFRAG_CONNTRACK_IN + zone;
@@ -731,7 +731,7 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 
 		if (!err) {
 			*defrag = true;
-			mru = IPCB(skb)->frag_max_size;
+			cb.mru = IPCB(skb)->frag_max_size;
 		}
 	} else { /* NFPROTO_IPV6 */
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
@@ -744,7 +744,7 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 
 		if (!err) {
 			*defrag = true;
-			mru = IP6CB(skb)->frag_max_size;
+			cb.mru = IP6CB(skb)->frag_max_size;
 		}
 #else
 		err = -EOPNOTSUPP;
@@ -753,7 +753,7 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 	}
 
 	if (err != -EINPROGRESS)
-		tc_skb_cb(skb)->mru = mru;
+		*tc_skb_cb(skb) = cb;
 	skb_clear_hash(skb);
 	skb->ignore_df = 1;
 	return err;
-- 
2.53.0

