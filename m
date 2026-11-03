Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703490;
	b=4m1GZMTh4Q9lOl06fd+CU/QzvKKldkv7hQ8Rel/0HVXnHGvclQtgf/LlAdaHP2xPx4DF
	 XKsjqxqyUXeSczsyFy2rL8uhqa20Uvl0dW2a1YGVQlp3jvYEVuPk/DmKavpwnz8+fbYyC
	 0oKo8fKeIk2aqMg9XS5OQQwVlOmY206ujTQiQqywN/vnHyZZEqTpQUkQV94CrEs7HizT7
	 kL8riDjLkUtAgnIABUsxazyZBPjaWvxd8R2KGc170F4yqbNEtZDOJEWcCZWeKvVI1lHO+
	 PQNRbxC+GLe7Kd3VjhAXQq/MjsSyLEOjPCACc0gX4NNsSmTjSiooM/FPgmbFrAtnpIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7hxWKltofCjfT65CF+kY9nlzcT/EQbXxGO0a7C/06kg=;
	b=nBFqyfHMWP95WIvxv5I5ax5oMfIfltyemBVebKTsmsY2pIN/EctkAkFVJzCXUb3mquYL
	 pR8U6M5IudId97e83oVbSWjpeKtSkfuJIMO9Lt6pWSf+/lX4HAMQ181pzVM0piX8gbFAx
	 nUk8nsTe3xhKp55McIEyE/DS0nJx/LRKZpbz7CaItfXJF4i7I2Ux5HKZMJnMfcVkqrHxf
	 ckcBf8ptgtsc047d7Pe+LE/YUjchEC4HVuJzh6MpqGzXrbZ1q9F6hVb3OAofwqzpUT+Cu
	 BWZizJZBHfGLRn31GhGPVRN8sGGee3yDkY/V6PU4CNyO9AkazBnq+3TEWrOnzGFMZrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOMw71hk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9B606FAF1;
	Tue,  3 Nov 2026 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOMw71hk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DEF1F000C1;
	Tue,  3 Nov 2026 10:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703489;
	bh=7hxWKltofCjfT65CF+kY9nlzcT/EQbXxGO0a7C/06kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lOMw71hkmjasRuS0tFkDITzDF1h1B9eWmdqVTYAilSe+Tc67DHr32wb0Jmb13NMmm
	 5VvNwZAiCkK5fdBSzaVH8xQblg+6fImnYQk66gBh3lSXpmTNtxwMuBhCZ+q0jSyAs5
	 TT+gsKmxE00O7v5BIZmCg9DSxwfxXDBN2IL50nx38KZvFy7rPne8SoB4nMxiu8V/OG
	 mjb7/Yug5Kg1A9ZyIKETBc1xnesRp+KRfvEpNMVMp14BamTA8Nrx/HfK8Zbn7FDosS
	 GEUtJRfqHpMryLPaq9wZOg5x/NPFyXrykuEHxBCg7PbALcxL2M5ZqWOP7MuZ+/MV4j
	 O7G+FcSLuE2cA==
From: Eric Dumazet <edumazet@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	willemb@google.com,
	steffen.klassert@secunet.com,
	tom@herbertland.com,
	cenzhang@linux.microsoft.com,
	AutonomousCodeSecurity@microsoft.com,
	Eric Dumazet <edumazet@kernel.org>,
	stable@vger.kernel.org,
	Taesoo Kim <tsgatesv@gmail.com>
Subject: [PATCH net v3 2/2] net: gro: invalidate frag0 after a pull
Date: Tue,  3 Nov 2026 11:57:52 +0100
Message-ID: <20261103105752.49542-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103105752.49542-1-edumazet@kernel.org>
References: <20261103105752.49542-1-edumazet@kernel.org>
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

Since commit bd56a29c7a4e ("net: gro: change skb_gro_network_header()"),
skb_gro_header_slow() no longer invalidates NAPI_GRO_CB(skb)->frag0
after pskb_may_pull(). skb_gro_may_pull() keeps comparing against the
frag0_len value set in skb_gro_reset_offset(), assuming that after a
slow pull, all later accesses are beyond frag0_len.

This is not true:

- udp4_gro_receive() and udp6_gro_receive() read the network header
  with skb_gro_network_header() after udp_gro_udphdr() pulled the
  UDP header.

- vxlan_gro_receive() calls skb_gro_remcsum_cleanup() at a lower
  offset after the inner handlers pulled their headers.

- skb_gro_remcsum_process() can pull beyond the inner Ethernet header
  before eth_gro_receive() reads it.

- napi_frags_skb() calls __skb_pull(skb, ETH_HLEN) after a slow pull,
  so frag0 still points to the Ethernet header.

If the pull consumed the first page fragment, __skb_pull_tail() released
it. If the head had to grow, pskb_expand_head() freed the old one.
These reads, and the 2-byte write in skb_gro_remcsum_cleanup(), then
access memory the skb no longer holds a reference on.

esp4_gro_receive(), esp6_gro_receive(), skb_gro_receive_list() and
udp_gro_receive_segment() also pull directly and never invalidated
frag0.

Add skb_gro_frag0_invalidate(), which only clears frag0_len, and call
it before each of these pulls. This is a single store in the slow path,
and frag0 stays non NULL, so skb_gro_network_header() does not need
a NULL test.

frag0 must be invalidated even if the pull fails: __pskb_pull_tail()
can return NULL after pskb_expand_head() freed the old head, for
instance if a frag_list member has to be cloned or pulled.

As frag0 is now invalidated before a pull that can fail,
gro_try_pull_from_frag0() can see an skb whose linear part does not
cover skb_gro_offset() while frag0 still points to the start of the
packet, for instance after skb_gro_remcsum_cleanup() pulled a shorter
length. Copying from frag0 would then corrupt the headers: only use
frag0 while frag0_len is not zero, and use pskb_may_pull() otherwise.

This was found by Taesoo Kim and Cen Zhang, using LLM assisted code
analysis, and confirmed with reproducers.

Fixes: bd56a29c7a4e ("net: gro: change skb_gro_network_header()")
Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Cc: stable@vger.kernel.org
Reported-by: Taesoo Kim <tsgatesv@gmail.com>
Reported-by: Cen Zhang <cenzhang@linux.microsoft.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/gro.h       | 10 ++++++++++
 net/core/gro.c          |  9 ++++++++-
 net/ipv4/esp4_offload.c |  1 +
 net/ipv4/udp_offload.c  |  1 +
 net/ipv6/esp6_offload.c |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 13a8ef217a1d..2e6e4d6da725 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -160,9 +160,19 @@ static inline bool skb_gro_may_pull(const struct sk_buff *skb,
 	return likely(hlen <= NAPI_GRO_CB(skb)->frag0_len);
 }
 
+/* A pull can release the page fragment frag0 points to, or reallocate
+ * skb->head, even if it fails. Call this before the pull, to make sure later
+ * skb_gro_header() and skb_gro_network_header() calls no longer use frag0.
+ */
+static inline void skb_gro_frag0_invalidate(struct sk_buff *skb)
+{
+	NAPI_GRO_CB(skb)->frag0_len = 0;
+}
+
 static inline void *skb_gro_header_slow(struct sk_buff *skb, unsigned int hlen,
 					unsigned int offset)
 {
+	skb_gro_frag0_invalidate(skb);
 	if (!pskb_may_pull(skb, hlen))
 		return NULL;
 
diff --git a/net/core/gro.c b/net/core/gro.c
index 1b033855a20d..49e7f64f2775 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -238,6 +238,7 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
+	skb_gro_frag0_invalidate(skb);
 	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
 		NAPI_GRO_CB(skb)->flush = 1;
 		return -ENOMEM;
@@ -454,8 +455,14 @@ static void gro_try_pull_from_frag0(struct sk_buff *skb)
 {
 	int grow = skb_gro_offset(skb) - skb_headlen(skb);
 
-	if (grow > 0)
+	if (grow <= 0)
+		return;
+
+	/* frag0 can only be used if no pull happened. */
+	if (likely(NAPI_GRO_CB(skb)->frag0_len))
 		gro_pull_from_frag0(skb, grow);
+	else
+		pskb_may_pull(skb, skb_gro_offset(skb));
 }
 
 static void gro_flush_oldest(struct gro_node *gro, struct list_head *head)
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f5e7..2309468cfc3d 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -37,6 +37,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 	__be32 seq;
 	__be32 spi;
 
+	skb_gro_frag0_invalidate(skb);
 	if (!pskb_pull(skb, offset))
 		return NULL;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c6611a..cd9d7426b227 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -743,6 +743,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 			pp = p;
 		} else {
 			if (NAPI_GRO_CB(skb)->is_flist) {
+				skb_gro_frag0_invalidate(skb);
 				if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
 					NAPI_GRO_CB(skb)->flush = 1;
 					return NULL;
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22895521a57d..ca947cb94fb7 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -64,6 +64,7 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 	if (NAPI_GRO_CB(skb)->proto == IPPROTO_UDP)
 		encap_type = UDP_ENCAP_ESPINUDP;
 
+	skb_gro_frag0_invalidate(skb);
 	if (!pskb_pull(skb, offset))
 		return NULL;
 
-- 
2.53.0

