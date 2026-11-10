Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273406;
	b=b8/TJacX5QrGnLU+jsHnOQJbMn4BYMbjoparEeCTsI0F+ivqEenxirXndPp+uHX0fXAz
	 KQnKXGQmx+AEfCQkF3EUGLgtu8pCbA/VPpe14OGAQPrx6WHRp2SD/KPQlsWlgaKd3btuM
	 nG/8ORmO14j4c47AilcoyTN7G2lHWv6hlcXmmrIMdDM8ewo/IuJ5pIWmqD7jOETHURUsv
	 rZO43LxcEZLupBJf23yupmIf48LrRTBYxd7kRq5Ah5v3d/7HHAc4u0+5C3zw3JLwae5Ub
	 rZJzEJMCTkGqf4R2svvUjmW3uGQbhNRp+iD48UaGsQhfC3HUSNHvFX1GoQ4SauQ/QSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273406;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yhtPaM9jbff3xZolbTSlMFgxhOykysboPA3ONeBeYng=;
	b=ZrPpfKRTh7lzNAzXL5AzfrU91jAw/HMi1/LKsjUoCUfRyGdmHAGosCRed6+j/y5cWTSz
	 ohG01luwMkzc/Xkuz2i17sr2O5yuXg+QAomRl/zECdafILMDwK8ph5wfyJQ6DnrsTFzuO
	 KVa2Yio9r0QBWEliYTqoEWSAKQPcAT/63dm8WQXeF23PJbIQLEcjW3vyQfQKPcUOrMbZx
	 CLQkngYF1RvEQsS+6JLRa3qQUhA4cGzVp9dHMHR0c7CJrmT2NdiXv09pVA3ImbFHYPDN4
	 tiCELfZ0WlGLHocaXilFXqo3ispAP62onSZAxeuce5mp688OYVheBmT/My8KrAwVkPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuzmKEpH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F3606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuzmKEpH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EBF1F0089F;
	Tue, 10 Nov 2026 01:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273406;
	bh=yhtPaM9jbff3xZolbTSlMFgxhOykysboPA3ONeBeYng=;
	h=From:To:Cc:Subject:Date;
	b=CuzmKEpHeZ6DbdDZcfWFfiBpDF/PYNZQRr5H+hiMatG5D+Yz5NzlZF2LbnmbddRFH
	 Q/sWlB6AzdFZ6NjbL6d/5u4dlcJbDz8b1wW7C2+RvIxBe8W5ZitvlyLtyncT8H/Qf9
	 JxRPQ9+JK6adMQVY5fncsLZkVJwiSw1Xh10ojJQDugJTqY8TAwzCIsmcRSO6Xc++yl
	 GZXFuqhU+ZvmfjYj1BWe0slq7ffY6XlSvo7ZYUtGLXnu9GGA/VkQEjspXN8pNCtrB5
	 QHy0bXS8jrnoJTBRfg5i3WYV/+DE0JjAEZzog4svhzZz3llAmOSQB4ejuAkYA72OSY
	 fJUEPbZScdxuw==
From: Sasha Levin <sashal@kernel.org>
To: edumazet@kernel.org,
	kylebot@openai.com,
	fw@strlen.de,
	idosch@nvidia.com,
	jiayuan.chen@linux.dev,
	wang.zhan@smartx.com,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] inet: frags: limit the truesize of a reassembly queue" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:16:44 -0500
Message-ID: <20261109201643-failed-6.1-3ae20e4697eb@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3ae20e4697eb969104fe4b1e98a675f0100382b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201643-failed-6.1-3ae20e4697eb@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3ae20e4697eb969104fe4b1e98a675f0100382b6 Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 30 Oct 2026 09:12:25 +0100
Subject: [PATCH] inet: frags: limit the truesize of a reassembly queue

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
---
 include/net/inet_frag.h  | 9 +++++++++
 net/ipv4/inet_fragment.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index b02d2472b003e..c1fb419a9cf03 100644
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
index c18da91c1f031..0b8d22ffafca6 100644
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




