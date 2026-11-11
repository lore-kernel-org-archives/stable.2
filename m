Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435094;
	b=VdNeq8yu04xwxQZg0zs2/LrIzKrrCbQXek8AquyhMgrpIAf6Jd4X0kM8jfIJB4eqVZVl
	 ZTxbtkz41HQhrPmioWUSyaeuEMNfBI7LCtHaKwonmVP198SXI1eKpZ6nFWxTfr4ZnLadt
	 ZqrsIZ17bNI3X0bxo+6gvEJom5kSIOB4RwORmOfdPKFdysi0mYpVTz1/lsENR9CeZPjoL
	 HkhNDiSvxoivAGL7csAc48fVxUvJR3SGmYZm4ef3kCs7jbjq2NtR604vAwQ28TzT3JygN
	 B8VzsUkJzJrIiIzaUXFe/O2sYRGClL9v0/F4SENn3ppn3bVMTFV8iPI9NeJ8qgZ/3WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435094;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YWpHvODDWPMNdsssQiZ4xPR8T3MUpIpCGmDH7Tjiqx4=;
	b=1OJzYdBQPNqnvJNu56K/vRP1+tsSgOPXPg+65CTA24hcFdSroC42knS+gTFkcDd7ARbL
	 q7ChyGsN6mww/wWF5aHNit5ck8OZgdwl40ifgyoAGNPAlcef3rJST8tvsaXEW4pAp6umZ
	 8uw2H6Zv7haL0AwgnzOxPldNmhmbya3umEiGu0NXyCWjBdmRm/DH1KtVu5Zy3Q71SDTzs
	 FE5S029lUtlNoNre7BEXpkKmvYcq+EdNeBJOnW5mV7+8VfowWkwsAG4eKpbqLYC4Rbuud
	 mz+itbxQ6hXMlTetA9tbC7rvbseMpE9M9vq/8WBmsU3u9jUV6kVrPneFmdspG7CWGvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1azAt2+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B974E606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1azAt2+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744811F00A0C;
	Wed, 11 Nov 2026 22:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435094;
	bh=YWpHvODDWPMNdsssQiZ4xPR8T3MUpIpCGmDH7Tjiqx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1azAt2+5G073xG+tvAx9LcPqZWX7oOjNyWLE5wgqXa2RIhU0hdrHyLiab02DXMU0
	 OUovDjd5v7YSU6z29tviTT2YNvIspJUDWGA1g2gpU8BOW5KjpFzaIdTlbi7jO0GYpx
	 pO1BfFPneKCX7RI2sDdI7EDF08r3XoWFH22fYimHcrYAKMycwrY80YRTBI5z9hZh3E
	 btEYVA2nrULjomXIT+FdPi/jh0F9FcUXb+Cgih5Id82yfZrNiAlbxrdowfWTEQ+3sA
	 Td6e5zd3s4qPf6/wP0IPqXVARlQEU54HU9JM3NxJVPVrNDf2ukAo1NsaBXaiOz7ktT
	 v5zfOiYlgg1Mg==
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
Subject: [PATCH 5.15.y] inet: frags: limit the truesize of a reassembly queue
Date: Wed, 11 Nov 2026 17:11:32 -0500
Message-ID: <20261111215329.4056116-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202156-failed-5.15-3ae20e4697eb@kernel.org>
References: <20261109202156-failed-5.15-3ae20e4697eb@kernel.org>
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
index 63540be0fc34a..0114941b4c873 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -72,6 +72,7 @@ struct frag_v6_compare_key {
  * @meat: length of received fragments so far
  * @flags: fragment queue flags
  * @max_size: maximum received fragment size
+ * @truesize: sum of the truesize of queued fragments
  * @fqdir: pointer to struct fqdir
  * @rcu: rcu head for freeing deferall
  */
@@ -92,6 +93,7 @@ struct inet_frag_queue {
 	int			meat;
 	__u8			flags;
 	u16			max_size;
+	unsigned int		truesize;
 	struct fqdir		*fqdir;
 	struct rcu_head		rcu;
 };
@@ -174,6 +176,13 @@ extern const u8 ip_frag_ecn_table[16];
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
index 6e6b46ebfc407..fb5973ffe4d67 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -384,6 +384,9 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 {
 	struct sk_buff *last = q->fragments_tail;
 
+	if (skb->truesize > INET_FRAG_MAX_TRUESIZE - q->truesize)
+		return IPFRAG_TOOBIG;
+
 	/* An IP fragment is never a GSO packet, but an untrusted source
 	 * (virtio_net_hdr) may have attached GSO metadata to it. Do not let
 	 * that reach the reassembled skb, whose head keeps the first
@@ -446,6 +449,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 
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

