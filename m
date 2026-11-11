Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426665;
	b=op6aq3Qo6VLwAzPa+DxHDNYsWTRa8F7C5WrCrNEv3S4MXNMD1ZfX4fs3bzMsuaZgeLc+
	 gXLesEP0YtdIyTZVbl8jvC+ZY0QNUjgnkw3sP/m5RZYLdJk2RxMTIVr4tBeB4vM95SpfV
	 mT4nknxvaWytfzdNnPkXC+GpqkuNqnUGVBNa2k6uRLs3oxKZtY9Pz/ZMlBJ9Kme+BrG9c
	 aKFb0RQuC6Drsi3n+RfKCWBVV1moOu6WJqBXCkLsn5lxK7GdQCqX1okyKZrCWkO+sdzl8
	 PGZ9TgeTpvmHR28N/+2iVMCgEykon0XhTJTajX2reBY7EdmQcMx6jiNZa+A7n4+2v/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426665;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z82R1+TXth2TRElVSq11Qh45IJQoJLtmPIsNg7ik0eA=;
	b=TDTubQjMigAp/CB9YQookmfWZZ5zLUPVSuyGjy0ZK4e7bOv9lbsg/Ir3fjLbiAALilkk
	 Iw5hBHfp1C9+86ZdJTJfcqW0ubg2SJPYWu1b5rPbvq/a1car7VmcZPukyVD1NkZM2UHaV
	 wUI2s5DdpjGSrEPbkTU0TNflFlf9ktY/MYjY6MyJH6PjcnkaB6kAFW6FHEQcegQ5zyaUT
	 GXIWluzSFOhKv5gQk98CJ/kTmR4rm0u1e50wHk5GcQm8hTY0wNXmeih0oHyZO0NR9YMly
	 vN6xVTrw6+Tj2JPOxtEexr9u4ACbYEIPwBfKvg3MQ5gwS/xgs7JE2i9KNAg3Y7FArDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVEG7Sg0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E1606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVEG7Sg0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F021F00A07;
	Wed, 11 Nov 2026 19:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426664;
	bh=Z82R1+TXth2TRElVSq11Qh45IJQoJLtmPIsNg7ik0eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CVEG7Sg0oZrJHNPidyAIxLnYa/7t/CV9UO62h7NT2M/d+3csUE/gOc1MGIwKfxH7D
	 R103zl6FXu/hel9uTq9hPkbCDQP6Jdj86ukz0K+CIC64OjufCPvYAlU8/dMRkyPqet
	 er4EIH138bqgflFd2fWdcOHAMpayXVDlpcdL4KJn+ueKrWNsAxylpLoRykrsMv28YW
	 vXUn+6FoFSHaAliSi3L9Z9ZT9AO9cPnqkkFnDQRgSWXov8VFyN3Fexp10cDx+5MvpZ
	 2aPbiFyahC4zlM9izUASt5kYppyfD2hLJVrHFz7i6T6HwcymYKO+NO+Q5m+UCCdVQE
	 miCDjeMlit5gw==
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
Subject: [PATCH 6.18.y] inet: frags: limit the truesize of a reassembly queue
Date: Wed, 11 Nov 2026 14:51:02 -0500
Message-ID: <20261111195039.4014950-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200348-failed-6.18-3ae20e4697eb@kernel.org>
References: <20261109200348-failed-6.18-3ae20e4697eb@kernel.org>
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
[ sashal: Adjusted context for the absence of IPFRAG_MIXED_SECPATH and secpath_equal(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_frag.h  | 9 +++++++++
 net/ipv4/inet_fragment.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 365925c9d2628..6aea2d1ac376f 100644
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
@@ -171,6 +173,13 @@ extern const u8 ip_frag_ecn_table[16];
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
index 21f7bf9ea5ba2..436b8737b2b66 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -337,6 +337,7 @@ void inet_frag_queue_flush(struct inet_frag_queue *q,
 	q->rb_fragments = RB_ROOT;
 	q->fragments_tail = NULL;
 	q->last_run_head = NULL;
+	q->truesize = 0;
 }
 EXPORT_SYMBOL(inet_frag_queue_flush);
 
@@ -443,6 +444,9 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 {
 	struct sk_buff *last = q->fragments_tail;
 
+	if (skb->truesize > INET_FRAG_MAX_TRUESIZE - q->truesize)
+		return IPFRAG_TOOBIG;
+
 	/* An IP fragment is never a GSO packet, but an untrusted source
 	 * (virtio_net_hdr) may have attached GSO metadata to it. Do not let
 	 * that reach the reassembled skb, whose head keeps the first
@@ -507,6 +511,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 	if (offset)
 		nf_reset_ct(skb);
 
+	q->truesize += skb->truesize;
 	return IPFRAG_OK;
 }
 EXPORT_SYMBOL(inet_frag_queue_insert);
-- 
2.53.0

