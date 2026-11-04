Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805057;
	b=RLoQPyyPMRMP79t88ui76NsGOE+5z0EnVV2N4ngaZE5UX0tMYOApdWvFqKUaJhknNFR9
	 rxx27JTlKoLWU2gtlpHRAUHfJHpdNRFJUh76e2foNXaSIiFZeLoUtpPQw4pq6Oaqr6gJa
	 VjrofTDblQCAwFLZGkwnvYvBpseL58WeYkRJHTb5Qsm0AauzVoHKGPn3YbTDIvc8vymT0
	 ewvfGpljnLo8s1kjJ2VjGum2r+QZxiIhqqYmaYCUJ+XXYZTZ1FkUvLYJHH4jv2DT4z2Pd
	 iUEAkCFcXa2v2xzRfMUXI8koCXXqZ+5UgCWPnND5AViReWKtqdMcb1zGBw6zZMLuNXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805057;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c0Yx8fCK0WNB0T/fR6sEUWKNxkcIAIvJtE+ku38GnRo=;
	b=R595X1CIotFRH8eT16UvXsBIpm9n7gOQKmfXnAd+VqBTvK6VVpCpUrK/9HN3REC5wLe5
	 EyAhGcGn29GFLNep5MrFaiO+OrySQUm3ehA6nir1qH9vtGUCgTQt0xryFAhMbleRj+c/X
	 KvVkfOP6zu/nauDbipxDgK3taW78qP4ZPhzPQcFpqK2miLGcPKekZoD38+OizqocR0842
	 55CGk07akKmoqtBUAYXP53XEBwNoha2T3JFolbAnXjEXYIOHo7kkf72Ez1jIAmf0vCiIN
	 PUwmYlKhb8Cd/6IOE/r3wkhJNuu2sCi3lNmHdjPpcX/FcIbvCEhgLMh8rXiC7jL3wMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxCUen4N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169D606A339;
	Wed,  4 Nov 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxCUen4N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B771F0093A;
	Wed,  4 Nov 2026 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793805056;
	bh=c0Yx8fCK0WNB0T/fR6sEUWKNxkcIAIvJtE+ku38GnRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VxCUen4NZ3vMY6FPjJBWsDBEG3Cr4cxOXUzHPRxo7vu1KJ8bVaJ2iolxlHa4/Y69O
	 k7aD2ffxNSvIdYaB35guq4qpr63DJfMzjs7q97G4hdG4g4VQQeDvbQsJneRwE8gUP8
	 2/jhKyKEZx2slly2Ipi2rodTX947xCSNbtCEK3Sh5R+0qywpFADx5gtr4FVnirAHpR
	 ieZTTOgYOou9GT7LOmERzu8UgdHJGRdnjFEMc1ng2Uq1ucMkRv/14qw8lOGbu/9Dsj
	 6XATEQawrajFHcTotkLrA7VGKUFOtqIRpbLTHgIoAkvhJTDkkFdDo2hKyPYWFU9F+k
	 p3S+kdR1PoK5Q==
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
Subject: [PATCH net v4 2/2] net: gro: invalidate frag0 after a pull
Date: Wed,  4 Nov 2026 16:10:42 +0100
Message-ID: <20261104151042.1157782-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104151042.1157782-1-edumazet@kernel.org>
References: <20261104151042.1157782-1-edumazet@kernel.org>
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
If this pull fails, for instance after a failed pskb_pull() in
esp4_gro_receive(), do not hold the packet: later GRO lookups and
gro_complete() handlers expect its headers in the linear part.

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
 net/core/gro.c          | 20 ++++++++++++++++----
 net/ipv4/esp4_offload.c |  1 +
 net/ipv4/udp_offload.c  |  1 +
 net/ipv6/esp6_offload.c |  1 +
 5 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index c49ea8e1298f..7a19d4486456 100644
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
index a749755c83f3..75f6a5f39a4b 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -245,6 +245,7 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	if (unlikely(skb->remcsum_offload))
 		return -EINVAL;
 
+	skb_gro_frag0_invalidate(skb);
 	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
 		NAPI_GRO_CB(skb)->flush = 1;
 		return -ENOMEM;
@@ -457,12 +458,19 @@ static void gro_pull_from_frag0(struct sk_buff *skb, int grow)
 	}
 }
 
-static void gro_try_pull_from_frag0(struct sk_buff *skb)
+static bool gro_try_pull_from_frag0(struct sk_buff *skb)
 {
 	int grow = skb_gro_offset(skb) - skb_headlen(skb);
 
-	if (grow > 0)
+	if (grow <= 0)
+		return true;
+
+	/* frag0 can only be used if no pull happened. */
+	if (likely(NAPI_GRO_CB(skb)->frag0_len)) {
 		gro_pull_from_frag0(skb, grow);
+		return true;
+	}
+	return pskb_may_pull(skb, skb_gro_offset(skb));
 }
 
 static void gro_flush_oldest(struct gro_node *gro, struct list_head *head)
@@ -564,13 +572,17 @@ static enum gro_result dev_gro_receive(struct gro_node *gro,
 	if (NAPI_GRO_CB(skb)->flush)
 		goto normal;
 
+	/* Must be called before setting NAPI_GRO_CB(skb)->{age|last}.
+	 * A held packet must have its headers in the linear part.
+	 */
+	if (unlikely(!gro_try_pull_from_frag0(skb)))
+		goto normal;
+
 	if (unlikely(gro_list->count >= MAX_GRO_SKBS))
 		gro_flush_oldest(gro, &gro_list->list);
 	else
 		gro_list->count++;
 
-	/* Must be called before setting NAPI_GRO_CB(skb)->{age|last} */
-	gro_try_pull_from_frag0(skb);
 	NAPI_GRO_CB(skb)->age = jiffies;
 	NAPI_GRO_CB(skb)->last = skb;
 	if (!skb_is_gso(skb))
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

