Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212179;
	b=3uPOZpyd7Ktkqc21/ixhJdSd6C9OnB0Je5+B5gZ75N2a4aFhLvjcflpyqu3slT/KnODN
	 OWZ/M7IX4GR3OMyJi9Mlre4nIJM907koH/u5XciJX18goI9Ln41tzaADzOgmj1NStvthr
	 PAdzbzTlOWBs9h+9WOsNW+3VSL2v1u9wGCECFO4IBLiYPYSx6wuIHaMXrkOLOicy33JQr
	 gNlzJTa03CAei4hy3a4yL8Tw3ghGkqDgrmzaAuWPymngrroQVgjqziUV6+RLKo7UFYgYe
	 HzivbcnhF2LOfTSQN2DnkxtRxrbA/gdqfjNogccAuhQ7xIbapUj7dOLIgv5KQnfEcmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212179;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KkorX69HnL1Au5lIPRwPKiXUNIXeoolXng5N5Qkg+bQ=;
	b=i/zxilj0G5zCthLKfP93H0Sw4XxFbbn4PLJyXJL2DL9HtGmQGTDTWMePUAfHZqbpKnva
	 21NnMxRzkP1JCO68+bxHWGymH3ZAJZo+z77SE62BytLnL8ETEyAnB2vqBf78MNSj9uUPU
	 +561a9g1j0bfLshbzb3t/gTe+KTWA72Gc5dvRXDG9/qZfRv9Xw6j7R4G8DKpBrsTPracb
	 iZygeZlxZVQk1LOwYh2lLjqBs6XwMjHrukyrii61qJ5b1aNRf01q9QGnd0TFb6KIYhHTo
	 tO22qz/zXZGBcg/+kKZLPhUijP5oYDfCYR9xD1sZqlU+ExFanZGvzezQ+psyn/u2o3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eayf4V5x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E0606A31A;
	Wed, 28 Oct 2026 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eayf4V5x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9521F01825;
	Wed, 28 Oct 2026 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212179;
	bh=KkorX69HnL1Au5lIPRwPKiXUNIXeoolXng5N5Qkg+bQ=;
	h=From:To:Cc:Subject:Date;
	b=Eayf4V5xECtofIajQZIecVU4gxokSn1SQWO+UzHkI1yQrIPIOvX4ru7yqPKa5rfKj
	 eutqOtUPaXOMuh0Gx55vGfVFgQbplRTFW/J9e6VRYuis4yiyU7m7o8NjoT5s74wX8i
	 EV/9TwidugCYBXuPgAhKuGyl5J2Ojahibn0rMgOJTntQMg9if6spbWjesPGSBOEAPh
	 ou8rV87TRzxJ14Xt4Cm17090Ubg6L26+IGR73yLJ5A8V1ZpMo1V9WYjqnzuDgWx7O5
	 5J+7dU3s3Bvw/Mk8DiWuTrqCyg5fBpi7mAuH/NPjWEoh2ma0aXf6ngG83WiAsyWG1Q
	 qOzpxwzNcWgDA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	stable@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net] inet: frags: limit the truesize of a reassembly queue
Date: Wed, 28 Oct 2026 19:29:34 +0100
Message-ID: <20261028182934.2236310-1-edumazet@kernel.org>
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
Kyle Zeng provided a more complicated patch, I wrote something much simpler.
LLM was used to discover the bug, build a repro, and test the fix.

 include/net/inet_frag.h  | 8 ++++++++
 net/ipv4/inet_fragment.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index b02d2472b003ec6e7b8e391d56115e8f0578ca61..b7b9e96c073e8da30387f85c5ea27d5b05a2b228 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -100,6 +100,7 @@ struct inet_frag_queue {
 	u8			tstamp_type;
 	__u8			flags;
 	u16			max_size;
+	unsigned int		truesize;
 	struct fqdir		*fqdir;
 	struct rcu_head		rcu;
 };
@@ -172,6 +173,13 @@ extern const u8 ip_frag_ecn_table[16];
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
index c18da91c1f031ee0b97f9e072837d053380da2f2..0bd5b7baf9ad300a042e2e9d5c95c6b3ce8990a1 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -446,6 +446,9 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 	if (last && !secpath_equal(last, skb))
 		return IPFRAG_MIXED_SECPATH;
 
+	if (skb->truesize > INET_FRAG_MAX_TRUESIZE - q->truesize)
+		return IPFRAG_TOOBIG;
+
 	/* An IP fragment is never a GSO packet, but an untrusted source
 	 * (virtio_net_hdr) may have attached GSO metadata to it. Do not let
 	 * that reach the reassembled skb, whose head keeps the first
@@ -510,6 +513,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 	if (offset)
 		nf_reset_ct(skb);
 
+	q->truesize += skb->truesize;
 	return IPFRAG_OK;
 }
 EXPORT_SYMBOL(inet_frag_queue_insert);
-- 
2.53.0

