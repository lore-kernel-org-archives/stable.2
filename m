Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427951;
	b=Qydo6U2g9gKgor/n0NgVmwceD5e/hLZQcvZjsJCA80y5ziYumKvfo7A3FUe+RtkQ8992
	 Kk2bA4Sz6xxNjuK1Bup7ku9oTFBPEZyODQJQrivi41AJsAmsaivt2V+M/T1UFIDM80z7D
	 a3RS5D+jMkX7eKnkhbCg6f+isY09hjBjVpZ7zzvF+oKEWejdlpJ2It2NFoRuPyhVaQO8h
	 MuZkjDGleYGeum4ah/3tV8guMjoM+aY3aRR+DMVwGyuybNsQoHEBvnjZJeMoByvgc6Eod
	 wWzowVjoRsRDPtX6N5RcG8dEk8o0zHQMLbexd35M1+ItWgGQqm5CImCvg10depDa9zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=79H8btPJKwYyRTPxXXyFtbZEGb1tE2bRM37OBxqjI2o=;
	b=WSud0IKb5E2va5kkcKavvpXYB3okyNsNl2zA1QUfVhOEh+8tpSlslzi3PtzpBepZskDG
	 Fu6Abf7RuH3zp6fmNOspVB1tq6fzC6IybCTNrgCuE0/4BIC0D3Uq9dvFlBDymLgaGSCnS
	 iVvNlBjA+S8dCJmI5uqPUppU9qWMfw7fYNN+5c+H2J66jHkm/FYTdr0TfKeZJJlNNvNnD
	 ZC4PhVDmk9YOP6dmzIMu2FKcU9y0xYUStTsD6ppiZ8nFx91iMmc7Kojc6GovEJSv8/qQN
	 pp6Y1w5SD2/dEKSUmdGQAlZ6NON9rzwnzU5PvNnO0P0CFOc4uMeonrzubTAypIQBcEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0CgGpHx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158D606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0CgGpHx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C111F00A05;
	Wed, 11 Nov 2026 20:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427951;
	bh=79H8btPJKwYyRTPxXXyFtbZEGb1tE2bRM37OBxqjI2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n0CgGpHxOIEoP0QinBMNXpvN3OPrK6rK9lVho9pySlNsUBAkfkqb+SsA6UavKb3qm
	 HsqA9wAYAXsLVcQArTf8981eDUmnUvYGAkrW9fKjCo/z8eb2LywKsjq3WnpgBf1rR5
	 qWUBktwDSnQLpVhoM0Sy5AJ19gW+2HeQnDbg261mNFFUXS8DvkQPcRmiNdC7BLqx35
	 OK0dGEnP+nrO3v7lyIn/ho6J6uAX7pScLs0zm+Gl75/iTy3wiKa2sAS9xvUsRyJ4N3
	 RlFvZMj1a0/HFC0QDFozCU1GXHVLZXDSBs2UbzjJWcwMXK2Xd50yD8I6NpokTiCOEG
	 y5No/xoEY6Pdw==
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
Subject: [PATCH 6.1.y] inet: frags: limit the truesize of a reassembly queue
Date: Wed, 11 Nov 2026 15:12:29 -0500
Message-ID: <20261111201210.4044623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201643-failed-6.1-3ae20e4697eb@kernel.org>
References: <20261109201643-failed-6.1-3ae20e4697eb@kernel.org>
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
[ sashal: moved the truesize reset to ip_frag_reinit() because inet_frag_queue_flush() is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_frag.h  | 9 +++++++++
 net/ipv4/inet_fragment.c | 4 ++++
 net/ipv4/ip_fragment.c   | 1 +
 3 files changed, 14 insertions(+)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 0b0876610553f..2ed882dd089a7 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -76,6 +76,7 @@ struct frag_v6_compare_key {
  * @mono_delivery_time: stamp has a mono delivery time (EDT)
  * @flags: fragment queue flags
  * @max_size: maximum received fragment size
+ * @truesize: sum of the truesize of queued fragments
  * @fqdir: pointer to struct fqdir
  * @rcu: rcu head for freeing deferall
  */
@@ -97,6 +98,7 @@ struct inet_frag_queue {
 	u8			mono_delivery_time;
 	__u8			flags;
 	u16			max_size;
+	unsigned int		truesize;
 	struct fqdir		*fqdir;
 	struct rcu_head		rcu;
 };
@@ -179,6 +181,13 @@ extern const u8 ip_frag_ecn_table[16];
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
index 9586bbbe92f9c..ba1e851257002 100644
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
index 43b1265f5ac19..be83c4b74036b 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -268,6 +268,7 @@ static int ip_frag_reinit(struct ipq *qp)
 	qp->q.rb_fragments = RB_ROOT;
 	qp->q.fragments_tail = NULL;
 	qp->q.last_run_head = NULL;
+	qp->q.truesize = 0;
 	qp->iif = 0;
 	qp->ecn = 0;
 
-- 
2.53.0

