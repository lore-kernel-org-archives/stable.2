Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427247;
	b=vzy4St+BLmPwpKAlsnLSrnada8g/OpT0dxz3mLPXBNnkhp0PudH64zvDS0Ppyokt6E/A
	 EGTF9Eg7iksBIlJdUUv2S5NI5G5hDGLsaC31ztkzOvDoPf1d2lV0svGc/umSQ7LnX2KyD
	 JmMHSyt8kSA+e2fwk9VKR2SEVsm1cJZYu5NoZ8E2m0SypYAn4J+O4DAUFIEHdVOhtgp2o
	 K/ZdVs8yzBwVIkATQo4Rw/4R7aJmHMnqvQMo/5xP0l2K84fA5LRWN9WXb2raRVxsxMX1l
	 LLDNdFmb/nHRlDLCzKmY4T63I7hFFmyQe24nPl2aQ39ri4A+zvDG++VHt3+V3a0U3Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427247;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UaefB8A3yTLegoLwLnY17kIeCgiwMftxOiYmoejib2c=;
	b=Uhwm1SgJEBR2VuCiSw7+gAsMdLpYCeqKF/OALOIh2lFEgiORRatLUKIxz+ak9EmXak4e
	 EREgxrH5Icf075vuWJcg6xE0ntk7p+8sRto0K7nSKn6VjzjDlH4bnUgYkv1pOluv9fflW
	 0ZNYZNGMLc7No7ANBl21mB2Yf0cDw/8yxirZ2ZBtuCwMtFjQU1f+a2X0PE+NGXYI+pmTV
	 hlbaA+NUteE8XI1Royq3pzhCl7sPNLVacGiWmjQ3taIM1N2exAqd8zswyWeJ6BBWnbavg
	 xloWwZIzK3n6UXqHwP4nwVIbEFN7a1nlK3JkiLfVJjZWJST4z2n7iiYEqNh3nddbZXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtCdaC6h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD157606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtCdaC6h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9C61F00A05;
	Wed, 11 Nov 2026 20:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427247;
	bh=UaefB8A3yTLegoLwLnY17kIeCgiwMftxOiYmoejib2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtCdaC6h4OM8lxmJ/GN/aBb9Ank2XXIrsaGJc7Qvzlx1Ck4JrzriptyLu38xmBF5s
	 5d6FlJHGsdmgczpHFGLUU7HPifZZTOSwlysJBQFcS9wM/jBLtyT567JhA/8EGadWmx
	 5ch3VaDA4lJFdxl9UZEepBt/RIzFUeSOp0WA1Ch1UbS8YVJ2xdhuvr8brgGHcWGiRa
	 JmlZQiMWO6moaJbRLIptI427sPukCTBFNj8YEssLPLq1Sbora87TKwxW0Fwaolcn9Y
	 UC/aerD+Wtj/CtuF154T429UegRX36vO7qAetfGWfjDyGCXzddErkB5RX17SmDEaVR
	 GA8iAL20+28HA==
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
Subject: [PATCH 6.6.y] inet: frags: limit the truesize of a reassembly queue
Date: Wed, 11 Nov 2026 15:00:45 -0500
Message-ID: <20261111200025.4039824-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201201-failed-6.6-3ae20e4697eb@kernel.org>
References: <20261109201201-failed-6.6-3ae20e4697eb@kernel.org>
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
[ sashal: adjusted context for missing security-path checks and nf_reset_ct() in inet_frag_queue_insert() ]
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
index 90709f2fdab88..c7be3060698ba 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -337,6 +337,7 @@ void inet_frag_queue_flush(struct inet_frag_queue *q,
 	q->rb_fragments = RB_ROOT;
 	q->fragments_tail = NULL;
 	q->last_run_head = NULL;
+	q->truesize = 0;
 }
 EXPORT_SYMBOL(inet_frag_queue_flush);
 
@@ -441,6 +442,9 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 {
 	struct sk_buff *last = q->fragments_tail;
 
+	if (skb->truesize > INET_FRAG_MAX_TRUESIZE - q->truesize)
+		return IPFRAG_TOOBIG;
+
 	/* An IP fragment is never a GSO packet, but an untrusted source
 	 * (virtio_net_hdr) may have attached GSO metadata to it. Do not let
 	 * that reach the reassembled skb, whose head keeps the first
@@ -503,6 +507,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 
 	FRAG_CB(skb)->ip_defrag_offset = offset;
 
+	q->truesize += skb->truesize;
 	return IPFRAG_OK;
 }
 EXPORT_SYMBOL(inet_frag_queue_insert);
-- 
2.53.0

