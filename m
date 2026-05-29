Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C393275870
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098587; cv=none; b=akeACaLXm5iovYdSzemCGfDKQI1N0OYa5nsLq4J9MG9PWlDuRZoV4ksXgKuWx72pvcHZpazQb7HsVIzIxFD0hmYoP7bslHFIJ//XBBP4bIpl/BIBEpytoOJEFrcieVSBNefr2mPMTj/DTxcymDxor/bF+HwPfV2E95chDA8Lg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098587; c=relaxed/simple;
	bh=qNAbnz0tRZJLYwM3Hb6a9YM57H6Z123zUewiNKSqVgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kag+Eyan49BpptfvCUo7Hn5aaUFGGB7CeiJwFNNBlZRE1c3d+S8z9njFGUHj3p6bXWL7VR91KbXMWL0IPPacJXoBjdJ1lRrzQN2SIcdFquhGqhBU1fj48be0U81b+1MxlDABnLSNY6MOen/ZJtd6jjwQ5CSRRDxqk8jIxR87a3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxIwKWMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxIwKWMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DFB1F00899;
	Fri, 29 May 2026 23:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098586;
	bh=ZI/i1faoccKQZX9sWqbVXQZjjBOK9Oyc6IYXWjIYeso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxIwKWMzndWTjkuLW9YXiZFa7uOZilH5w9i09wHXczaT7hkfYbxXXcoMVE2TlOwra
	 ewvOvIZFJOaL1LRSulCLe7R504YsPsY1ljZHg5EYZuelmWdFJ18Q0c9xtQE5AOV9oD
	 wL9RuvTMJUCzha1NtZwhAt2ZmjuJqyFthbggmLc512KR3xFYevS3RyRlLfL28zEGXr
	 Cc2LYR9thIKj5nHPWpXA5TTmGdVDwTC6LNpQZ69BaaFvbiAPygrotX8gYptsa6Vk+T
	 SkV0EcPRn3RAbpb6BjWwFB05EPUBNcnBp74zNmKzZG37a0FXAQ21pHiFZ/9XpcUVDk
	 HY2XQAu1NdS+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoze Xie <royenheart@gmail.com>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] netfilter: nf_queue: hold bridge skb->dev while queued
Date: Fri, 29 May 2026 19:49:42 -0400
Message-ID: <20260529234942.1939638-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529234942.1939638-1-sashal@kernel.org>
References: <2026052832-chamomile-jazz-bc30@gregkh>
 <20260529234942.1939638-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoze Xie <royenheart@gmail.com>

[ Upstream commit e196115ec330a18de415bdb9f5071aa9f08e53ce ]

br_pass_frame_up() rewrites skb->dev from the ingress port to the bridge
master before queueing bridge LOCAL_IN packets. NFQUEUE only holds
references on state.in/out and bridge physdevs, so a queued bridge
packet can retain a freed bridge master in skb->dev until reinjection.

When the verdict is reinjected later, br_netif_receive_skb() re-enters
the receive path with skb->dev still pointing at the freed bridge master,
triggering a use-after-free.

Store skb->dev in the queue entry, hold a reference on it for the queue
lifetime, and use the saved device when dropping queued packets during
NETDEV_DOWN handling.

Fixes: ac2863445686 ("netfilter: bridge: add nf_afinfo to enable queuing to userspace")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_queue.h | 1 +
 net/netfilter/nf_queue.c         | 4 +++-
 net/netfilter/nfnetlink_queue.c  | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index b1d43894296a6..6b4de68a762e3 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -12,6 +12,7 @@
 struct nf_queue_entry {
 	struct list_head	list;
 	struct sk_buff		*skb;
+	struct net_device	*skb_dev;
 	unsigned int		id;
 	unsigned int		hook_index;	/* index in hook_entries->hook[] */
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index d7542c5c4ae61..d9d35658a357c 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -60,6 +60,7 @@ static void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 	struct nf_hook_state *state = &entry->state;
 
 	/* Release those devices we held, or Alexey will kill me. */
+	dev_put(entry->skb_dev);
 	dev_put(state->in);
 	dev_put(state->out);
 	if (state->sk)
@@ -103,6 +104,7 @@ bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
 	if (state->sk && !refcount_inc_not_zero(&state->sk->sk_refcnt))
 		return false;
 
+	dev_hold(entry->skb_dev);
 	dev_hold(state->in);
 	dev_hold(state->out);
 
@@ -204,11 +206,11 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 
 	*entry = (struct nf_queue_entry) {
 		.skb	= skb,
+		.skb_dev = skb->dev,
 		.state	= *state,
 		.hook_index = index,
 		.size	= sizeof(*entry) + route_key_size,
 	};
-
 	__nf_queue_entry_init_physdevs(entry);
 
 	if (!nf_queue_entry_get_refs(entry)) {
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index bfe909267c9d9..1541d6801001c 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -911,6 +911,8 @@ dev_cmp(struct nf_queue_entry *entry, unsigned long ifindex)
 	if (physinif == ifindex || physoutif == ifindex)
 		return 1;
 #endif
+	if (entry->skb_dev && entry->skb_dev->ifindex == ifindex)
+		return 1;
 	if (entry->state.in)
 		if (entry->state.in->ifindex == ifindex)
 			return 1;
-- 
2.53.0

