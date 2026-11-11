Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436814;
	b=3GQA5lxPus8cAZYiFBjHfzWLC55BkEzyrJG3cY7wxO2h+EswMcX2e9RvrpPkdtEtNNgG
	 1lY8KMMnBf4sExY9o6V0heKVKKZfKAm19zhGUxKBJrDfF0ppmRIKuUSUgeIOIym6jiTkc
	 jMhyCPDhvV0oxdxitOpIz+qWup56BahnzAvqjZrg922MFMAK1z0k87W88DoZ0lk0NoqjF
	 5+ycX08I/dZJZd6EiLFtpma+RUyLaCZLlhE6YrB4iRtLSYeOtzs7qqaZfBFk0nmrxYVZ2
	 QAZoNslpr7LcB7s2z3o/QoRCh4cZkMXd5iCAk33rQIvdfUOMvUOHDK8TFttzzVBl0aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436814;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cLGR3MGHcLuIDUbjeAwFgBeKiMu5cUKXgT9qjBgfgCs=;
	b=E8DJ+TwDQiGWM8rMfbaGTwjJGfWzRPW9rHh8wtCCjQCwV9oSyjsXFW61RmW06CpxuRxn
	 A0LAWre/WqOkWgxzawh2SDPzvhA1yaLAbfu+SjWJCEMwSLZLDRWBDQffxC3pgUZ3Tv/bH
	 WXthjulc5FQ2xvWsigvgHZG/d3UDXzaX1kzDyp8UA9sG2Gwd8qXV5bsEHrMSB3oPlSPQ4
	 j9oSork971+DnvgAQFavI3ucqG3C9AEYNgHVWuLjKldCW3l+9m0oc6a+1cm53QF4O12p4
	 W2MoG0ffrvNgNN3z6YYc2UuXwORB2NLOKJKta44sJKEl6DHQ7yWyDtE8j1iu3WPeh2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RG/m1p9U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E08606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RG/m1p9U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06EA1F00A06;
	Wed, 11 Nov 2026 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436813;
	bh=cLGR3MGHcLuIDUbjeAwFgBeKiMu5cUKXgT9qjBgfgCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RG/m1p9U4d8Kad7SN+z6/KUvLOd7FA1bwpn+AbcDaNz6BDvqvwdfixNDySxqubcjA
	 BG/xbtsWhVJaY+iBg2CyNHXSqmCjISXcPu+rweHyouWJZoOUkKC+brL8Nq5BEis2Pi
	 iOGwKuPHoro183DGorUntaoNazRs2YVmcXf+/Ev1vsBmrLJ13++JULULAwrBxnar9O
	 dZkwmfw29x86ioqxcuQX6ERFBRw/n4KwZ2TXKX4Cet6e5k1TCWP8NdXNbgjD8Iy/NZ
	 B1icPaX82BJz+JZc/7Uo8hZfMZHq5U1fTnHtdE+fZ3eu8R4DA4uHzhuKXgGev74faP
	 QpuLaErEPtbng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Florian Westphal <fw@strlen.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Wang Zhan <wang.zhan@smartx.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] inet: frags: limit the truesize of a reassembly queue
Date: Wed, 11 Nov 2026 17:40:11 -0500
Message-ID: <20261111223808.4136567-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202645-failed-5.10-3ae20e4697eb@kernel.org>
References: <20261109202645-failed-5.10-3ae20e4697eb@kernel.org>
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

From: Eric Dumazet <edumazet@kernel.org>

[ Upstream commit 3ae20e4697eb969104fe4b1e98a675f0100382b6 ]

The truesize of fragments in a reassembly queue is only bounded by
the per netns ipfrag_high_thresh sysctl, which has no upper limit.

inet_frag_reasm_finish() sums the truesize of all fragments in an int.
If this sum reaches 2^32, it wraps, and the final sk_wmem_alloc
adjustment of the socket owning the reassembled skb can cancel its own
reference, leading to a use-after-free of this socket.

This can be triggered from an unprivileged user/network namespace,
raising ipfrag_high_thresh and using padded TUN packets, which keep
a large truesize after being trimmed by ip_rcv_core().

Track the sum of the truesize of fragments in each queue, and refuse
a fragment that would make it bigger than INT_MAX / 2. Callers kill
the queue on this error. This bound is far above the needs of
legitimate traffic.

Fixes: 18685451fc4e ("inet: inet_defrag: prevent sk release while still in use")
Cc: stable@vger.kernel.org
Reported-by: Kyle Zeng <kylebot@openai.com>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Tested-by: Wang Zhan <wang.zhan@smartx.com>
Link: https://patch.msgid.link/20261030081225.2575462-1-edumazet@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ sashal: moved the truesize reset from inet_frag_queue_flush() to ip_frag_reinit() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_frag.h  | 9 +++++++++
 net/ipv4/inet_fragment.c | 4 ++++
 net/ipv4/ip_fragment.c   | 1 +
 3 files changed, 14 insertions(+)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 4cbd413e71a3f..400375468536c 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -71,6 +71,7 @@ struct frag_v6_compare_key {
  * @meat: length of received fragments so far
  * @flags: fragment queue flags
  * @max_size: maximum received fragment size
+ * @truesize: sum of the truesize of queued fragments
  * @fqdir: pointer to struct fqdir
  * @rcu: rcu head for freeing deferall
  */
@@ -91,6 +92,7 @@ struct inet_frag_queue {
 	int			meat;
 	__u8			flags;
 	u16			max_size;
+	unsigned int		truesize;
 	struct fqdir		*fqdir;
 	struct rcu_head		rcu;
 };
@@ -173,6 +175,13 @@ extern const u8 ip_frag_ecn_table[16];
 #define IPFRAG_OK	0
 #define IPFRAG_DUP	1
 #define IPFRAG_OVERLAP	2
+#define IPFRAG_TOOBIG	4
+
+/* Max sum of the truesize of fragments in a queue. This keeps the sums
+ * done in inet_frag_reasm_prepare() and inet_frag_reasm_finish() well
+ * below INT_MAX. Legitimate traffic stays far below this limit.
+ */
+#define INET_FRAG_MAX_TRUESIZE	(INT_MAX / 2)
 int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 			   int offset, int end);
 void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 18217537cb298..6d6d90123be02 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -353,6 +353,9 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 {
 	struct sk_buff *last = q->fragments_tail;
 
+	if (skb->truesize > INET_FRAG_MAX_TRUESIZE - q->truesize)
+		return IPFRAG_TOOBIG;
+
 	/* An IP fragment is never a GSO packet, but an untrusted source
 	 * (virtio_net_hdr) may have attached GSO metadata to it. Do not let
 	 * that reach the reassembled skb, whose head keeps the first
@@ -415,6 +418,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 
 	FRAG_CB(skb)->ip_defrag_offset = offset;
 
+	q->truesize += skb->truesize;
 	return IPFRAG_OK;
 }
 EXPORT_SYMBOL(inet_frag_queue_insert);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 5cdc65a5c010b..00dff2c866154 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -263,6 +263,7 @@ static int ip_frag_reinit(struct ipq *qp)
 	qp->q.rb_fragments = RB_ROOT;
 	qp->q.fragments_tail = NULL;
 	qp->q.last_run_head = NULL;
+	qp->q.truesize = 0;
 	qp->iif = 0;
 	qp->ecn = 0;
 
-- 
2.53.0

