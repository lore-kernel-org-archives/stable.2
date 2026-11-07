Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049998;
	b=Fk6F+VCeQb9nNSM2ABUWMLl/OQ6jv3kmx8op+/PGgplU2oY6KIFtVgzR9skClXvjxRMa
	 I0sYnQVJJEnQFo6m/kO5qJchEtMzqvpipClIXHoLe4avgA47JrkNsiNQ6Fhe0C4vA9HTM
	 XWx8LiE6drZKyXsRlF9OGT2WSNUHvV0hI+oRbu0z6Ats4BvFyJffmWUIE2EoBmwlqtMXh
	 Sr0blOFPWPh0bxmXL1VC3QIQXyYLAjJMdkp0sczNUCnwR84h+JsKHa48C7/29X9cDy6dq
	 491aki0PwrTi9S+q2TPmi0WuyKtskZtkf3WPh5fwfNFSgUBIqATw8Xcs2JC62bFLkyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049998;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oygJiutvtAXQXIigjRCSPIDN6ozx44oVxISVJziRoK0=;
	b=kMPn20UA0hSkMkB5tupssuBzQPWSzuRE3HKsLJqQMRyiIXGxEUSw+ev+Fy1yHq6WLn+K
	 VY7nu5PP8uficQavGjxPgXhLBArQrJh47MXF04nbn6Oz1rqrSXjqTVyJCOlxxlDnF4u2N
	 YVmuy/qK1EALECBjFYBuL9Ou5eoay7jgJseIhJBH7cMRUeMSnm7PUvDnMUQZp1slZUrZQ
	 F0AQg9oOCUIcxLcD/M4Z0zlPnh6eQ0YAzsjj4neoAmXeM60N0yKk/q8TWOGZM8xo7/fWm
	 TMzITLZDpFZAfchKFaGy9ccrBuJ/rI0mdXb06b/COgdO+mruldSYzb9VZPzgo028M6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbF5bHCf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EBB606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbF5bHCf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB401F008A3;
	Sat,  7 Nov 2026 11:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049998;
	bh=oygJiutvtAXQXIigjRCSPIDN6ozx44oVxISVJziRoK0=;
	h=From:To:Cc:Subject:Date;
	b=JbF5bHCffVb5LXeCEUl7RTLx/ki+h4Ze+FELyUGaHhXHQGMCodTYVuFsokTUmcPr+
	 ACL9XMivhMhhY7GYpVb+n9qK+QzBUFWkZ8BYEf05RsPJ0tIsYwdVM9oTJgWMFTIYBj
	 Op8Od83TX8CymXP36fwly+nxm7H8InUbASH/7ii5OkFAlBfv9vrX7x8WexZJPnLnGl
	 g5eqzedrzHS/dGgoxPbamfuz5V3OlT26WhYuathIHhp7enMyw+4gvq+bhWVLBRKrEj
	 ndYKiHUrnaiQ9XIUcWejVSSfMPgMfguudYun1tg0GWouc2+SVAbZE8MkyPD6dbyt7w
	 9VaMgHlxh2ilQ==
From: Sasha Levin <sashal@kernel.org>
To: jeremy.jean@oss.cyber.gouv.fr,
	edumazet@kernel.org,
	davem@davem-thinkpadp1gen8.ibmlond.csb
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] inet: frags: prevent acceptance of partially authenticated reassembly" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:16 -0500
Message-ID: <20261107061316-failed-5.15-6fb4e32f2ce3@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6fb4e32f2ce3234ae0c416872e911706a3484430
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061316-failed-5.15-6fb4e32f2ce3@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




