Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048985;
	b=jE50fihORtqnRd2aJ66zEhvJ9EMoR7TD74G0+N2JkKxHGh1uI3cfwz6nmzRXukr/LLuq
	 xD8L+ZSGAStx3/CZnBasH0knbTGVWEbgGqUfCid2cgEhpqJ7hinX4sPEbYLhVDUv8AMb7
	 LNBkWefo0CjKfv9LsYJo/BWGtLciz8yqh2M8qJS6ryJSvPLP2MC8hhcGoxH+w3Qy7l/US
	 WgK56JE4+Lrz2GFwpMeFs6lj+IeFMNyeWuXWf/JIzUnmDQ5s1gjaBkaECyVwjR7Vj3Kns
	 Z3XB4LnK+jTEyas+24oO3bCylUtTnwW0bj1AGM5WqMTk6TMPXmcTLguAhv+VoPk6DUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048985;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3Zxid7EKHWYc2e66EPUKArOXwgWBgGHb2JlGHDqTlLA=;
	b=CFl6Gm1Mkb7gE/hQ6I7uF3nsWLZe6r5pQTakBqcigb3Gkg3LmfNqpb5bc/QBk5zDyBli
	 TE3c5N8u457rtxq3mgWv3A9BH59f9vEsq9H2rTbBP8gjsseHQqH0nBzY34TQ6IkO7eLNh
	 spn+bAS+LeX55dv0zTaeXoH1Vvx6orKY+la2TzRgebKr5ORyBR/iFCjcIV1q0AVLnnoFH
	 3BLAUOrZSkOVPrPRnFPgUZa+Ov7AKptTRAOgFFagFKqvQymvvq77I0j2VvYK9/GuDAaEx
	 xM6WClQWe9RSh+HBJNVRRghLt2BjzSri+gGH2iReby5meRU2twRL28tcA7//YCSi8og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6z89hie;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95069606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6z89hie
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC23F1F0089F;
	Sat,  7 Nov 2026 10:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048985;
	bh=3Zxid7EKHWYc2e66EPUKArOXwgWBgGHb2JlGHDqTlLA=;
	h=From:To:Cc:Subject:Date;
	b=S6z89hieDk4LZMFFkXQpSk3KErjcIxbRMcfonfuvgWWJGSOxFlAE+ZuRzERehKbFE
	 no05gy87GS4V0DxB5cV48agdOucuCmmmrsqrHPnsRV0Jy6Xj9FVngOa/dHJ6JeIn5u
	 TbtTbcuwSGQt4x5mCqWaXHGshDpW7DAdWFFocqoDwQzYRkTp61swa8ZkGoO3vpCBjH
	 q/2sDAO+XXZ4hBKrMFguky8V6Vs8qPUvnSQP7zQhZnaxtfPzg4sQ2/n+QCvpFE+7j7
	 rucOx/pnN/4DFYjVleUQ8Y/xEK2baddLuesa5gpvoZsdXUk+aaohWivUsbmgrmyE3P
	 xyew+agyNyMtw==
From: Sasha Levin <sashal@kernel.org>
To: jeremy.jean@oss.cyber.gouv.fr,
	edumazet@kernel.org,
	davem@davem-thinkpadp1gen8.ibmlond.csb
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] inet: frags: prevent acceptance of partially authenticated reassembly" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:56:23 -0500
Message-ID: <20261107055623-failed-6.1-6fb4e32f2ce3@kernel.org>
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
git cherry-pick -x 6fb4e32f2ce3234ae0c416872e911706a3484430
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055623-failed-6.1-6fb4e32f2ce3@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6fb4e32f2ce3234ae0c416872e911706a3484430 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Date: Fri, 23 Oct 2026 18:51:19 +0000
Subject: [PATCH] inet: frags: prevent acceptance of partially authenticated
 reassembly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A reassembled skb retains the secpath from its first fragment, which
makes it possible for the final policy check to accept bytes that were
not covered by the transform recorded on the skb. This can affect IPsec
tunnel traffic, including AH and ESP, and allow a packet to be accepted
even though only part of its payload was authenticated.

Reject a fragment when its secpath differs from the fragments already
in the queue, and keep overlap statistics limited to actual overlaps.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>
---
 include/net/inet_frag.h  |  1 +
 include/net/xfrm.h       | 17 +++++++++++++++++
 net/ipv4/inet_fragment.c |  5 +++++
 net/ipv4/ip_fragment.c   |  3 ++-
 net/ipv6/reassembly.c    |  3 ++-
 5 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 365925c9d2628..b02d2472b003e 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -171,6 +171,7 @@ extern const u8 ip_frag_ecn_table[16];
 #define IPFRAG_OK	0
 #define IPFRAG_DUP	1
 #define IPFRAG_OVERLAP	2
+#define IPFRAG_MIXED_SECPATH	3
 int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 			   int offset, int end);
 void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index a6d69aaa6cd2d..298ca9bb00835 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1201,6 +1201,23 @@ secpath_reset(struct sk_buff *skb)
 #endif
 }
 
+static inline bool
+secpath_equal(const struct sk_buff *skb1, const struct sk_buff *skb2)
+{
+	const struct sec_path *sp1 = skb_sec_path(skb1);
+	const struct sec_path *sp2 = skb_sec_path(skb2);
+	int i;
+
+	if (!sp1 || !sp2)
+		return sp1 == sp2;
+	if (sp1->len != sp2->len)
+		return false;
+	for (i = 0; i < sp1->len; i++)
+		if (sp1->xvec[i] != sp2->xvec[i])
+			return false;
+	return true;
+}
+
 static inline int
 xfrm_addr_any(const xfrm_address_t *addr, unsigned short family)
 {
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index b286ee429da8f..c18da91c1f031 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -23,6 +23,7 @@
 #include <net/inet_ecn.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <net/xfrm.h>
 
 /* Use skb->cb to track consecutive/adjacent fragments coming at
  * the end of the queue. Nodes in the rb-tree queue will
@@ -441,6 +442,10 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 {
 	struct sk_buff *last = q->fragments_tail;
 
+	/* The reassembled skb keeps the first fragment's secpath. */
+	if (last && !secpath_equal(last, skb))
+		return IPFRAG_MIXED_SECPATH;
+
 	/* An IP fragment is never a GSO packet, but an untrusted source
 	 * (virtio_net_hdr) may have attached GSO metadata to it. Do not let
 	 * that reach the reassembled skb, whose head keeps the first
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index c790d2f494870..36105dd192823 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -378,8 +378,9 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb, int *refs)
 		err = -EINVAL;
 		goto err;
 	}
+	if (err == IPFRAG_OVERLAP)
+		__IP_INC_STATS(net, IPSTATS_MIB_REASM_OVERLAPS);
 	err = -EINVAL;
-	__IP_INC_STATS(net, IPSTATS_MIB_REASM_OVERLAPS);
 discard_qp:
 	inet_frag_kill(&qp->q, refs);
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index a7964125c764c..8418ed9423f4b 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -241,8 +241,9 @@ static int ip6_frag_queue(struct net *net,
 		err = -EINVAL;
 		goto err;
 	}
+	if (err == IPFRAG_OVERLAP)
+		__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASM_OVERLAPS);
 	err = -EINVAL;
-	__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASM_OVERLAPS);
 discard_fq:
 	inet_frag_kill(&fq->q, refs);
 	__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASMFAILS);
-- 
2.53.0




