Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347951;
	b=btNvBLrGtnGufJpGzOG95Tta9NDBdAJS1ETEsH0cmkSZ+Oj5EBQXSDfTNcR7mti+exfI
	 xC6U0e5dM1aHLoI8iGc9dd9LS/ajHofiQvtiV6m3mzsjsgH/a8E9gtdL8XFnso087CBTJ
	 7NlKcSJ1TadfZLMQ/yiPOWSs/k0TpsEe0s/Pf/ko4A937c3bltf17mpFXgLWT9aIVGVXM
	 XotDJL44BY7qvNbQiOpI/r0J+wIZb8K3AyN5NFEj8Q7mN1wLBS9r4CoitrqRiaXiOpUgC
	 bq2HVbGT3L8jqgD0wjmcjFFnR6zhLAQ2X+OVTRC7jgf/X4n1Gby2E55t+mkjavheI+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cwt4Hg4qMuIaaCvAXceJlYQIKFNEo2HNhM36aeH05D4=;
	b=xuBoMPdx64+2VQJPLrspW0LsTl83BwTlG5VeAh9hE9S67nQmgSpBCviBp3ZuLOIVohS3
	 T1Lrh2Ek5OmXk9J2+vLLNs8vZOLZ+2UWaQZmegx3JgHbF70lk0bzUjkUAA74aP6Pg63Oa
	 U95R99uvYkYCUCSpL1795cqWdQ3/2Ge3909ZzpIPiKKO/i0N3Qq+eZfeM7IFxDPYa79FB
	 rlb0PKMJldlzGL25c9vnR2BgobHzqj6CrOCwVeuVthJ59kx6Wh4wJ6qYRqy8dZ5xyQY0D
	 YFSfYXoJ2FAWgiwO+/rfubzLRSLRvqE3OHp/koRYCupm1rMlSdr+0iQMtEBuEHAI/Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJnsaMfq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDB1606A31C;
	Fri, 30 Oct 2026 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJnsaMfq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF631F000C1;
	Fri, 30 Oct 2026 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347950;
	bh=cwt4Hg4qMuIaaCvAXceJlYQIKFNEo2HNhM36aeH05D4=;
	h=From:To:Cc:Subject:Date;
	b=QJnsaMfq3q22zM8v2AhRdonJAq1zicvekS3FWa1Wh3jaP7OM653ElGaDufODpuzLn
	 atlGfBVEhY9P5V4x7Qn8r+6cchg/KJ4KmNZAwpBlZV4oKhZ82gRdt8NttcsYYeDLBV
	 /YHj2XhHaSQnc89zxkHY7EROmScwcnleDu541wUoYKAd9VsNDPjwQmb+xio+KiaoP8
	 SZoLRvYQkMTGdyP0tIJRL9vYkW2L2D5XdPWpvqCQWB+hY6dcpbxa91wLSK82F2ewLl
	 wiSTzcqT4KrkYesxYrU2Z6h1LoKOsL+v+mC2WaGYCsgS1FEFAQ/SH8SjdLNdtNKBqm
	 SH6mfc10UZaNg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	stable@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 net] inet: frags: limit the truesize of a reassembly queue
Date: Fri, 30 Oct 2026 09:12:25 +0100
Message-ID: <20261030081225.2575462-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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
---
v2: reset q->truesize in inet_frag_queue_flush(), as ip_frag_reinit()
    can keep a queue alive after flushing its fragments (Wang Zhan, Sashiko).
    Document @truesize in struct inet_frag_queue kernel-doc (Sashiko).
v1: https://lore.kernel.org/netdev/20261028182934.2236310-1-edumazet@kernel.org/

Kyle Zeng provided a more complicated patch, I wrote something much simpler.
LLM was used to discover the bug, build a repro, and test the fix.
---
 include/net/inet_frag.h  | 9 +++++++++
 net/ipv4/inet_fragment.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index b02d2472b003ec6e7b8e391d56115e8f0578ca61..c1fb419a9cf03a346edd0424ca0ba5b06b6a20f0 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -79,6 +79,7 @@ struct frag_v6_compare_key {
  * @tstamp_type: stamp has a mono delivery time (EDT)
  * @flags: fragment queue flags
  * @max_size: maximum received fragment size
+ * @truesize: sum of the truesize of queued fragments
  * @fqdir: pointer to struct fqdir
  * @rcu: rcu head for freeing deferall
  */
@@ -100,6 +101,7 @@ struct inet_frag_queue {
 	u8			tstamp_type;
 	__u8			flags;
 	u16			max_size;
+	unsigned int		truesize;
 	struct fqdir		*fqdir;
 	struct rcu_head		rcu;
 };
@@ -172,6 +174,13 @@ extern const u8 ip_frag_ecn_table[16];
 #define IPFRAG_DUP	1
 #define IPFRAG_OVERLAP	2
 #define IPFRAG_MIXED_SECPATH	3
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
index c18da91c1f031ee0b97f9e072837d053380da2f2..0b8d22ffafca69b2bccd98eca3d4bda93ebb816a 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -336,6 +336,7 @@ void inet_frag_queue_flush(struct inet_frag_queue *q,
 	q->rb_fragments = RB_ROOT;
 	q->fragments_tail = NULL;
 	q->last_run_head = NULL;
+	q->truesize = 0;
 }
 EXPORT_SYMBOL(inet_frag_queue_flush);
 
@@ -446,6 +447,9 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 	if (last && !secpath_equal(last, skb))
 		return IPFRAG_MIXED_SECPATH;
 
+	if (skb->truesize > INET_FRAG_MAX_TRUESIZE - q->truesize)
+		return IPFRAG_TOOBIG;
+
 	/* An IP fragment is never a GSO packet, but an untrusted source
 	 * (virtio_net_hdr) may have attached GSO metadata to it. Do not let
 	 * that reach the reassembled skb, whose head keeps the first
@@ -510,6 +514,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 	if (offset)
 		nf_reset_ct(skb);
 
+	q->truesize += skb->truesize;
 	return IPFRAG_OK;
 }
 EXPORT_SYMBOL(inet_frag_queue_insert);
-- 
2.53.0

