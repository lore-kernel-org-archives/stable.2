Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597953;
	b=XSV2NuEzWFRiBaxNEHejL7c84kZ742w7vdxWpkDCc34BXZFPZjep/NCi4vXOIzbp9a3J
	 W+sdBmlU/qrlpxIuuTog1bVLCuzkgvSivZz4NzXGnhQ9Yvv45s8/X97U32jcf774IEyhn
	 Hs8KB8+mBqCr0FqV4dqrTVlQSJxFfHdmbeq4HHK+Obygw8XwsCjU8gWi1SsjSOk37EaTo
	 4T/7CGJ4jmtdtOsVhDf77oMOaMA4v5HrS4fYIuVjF12zPDv2J5OH9pXVNpZ/+cIVdN/Nx
	 MJx7aNrV7ogYwwkjUijXNl5SbkAIu7kHEJjWbL43KS6AngTAYVi+4xsXzC0dMdG4h+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597953;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mP5DDoHUKRRKu9tE6RuP6hLe52SWbxGTCEVBYDsHc3I=;
	b=5aOOT7GuYHrDnZCuiIJWphJtrYp9iDCEWyuWN/IqadAlUxu76Ba8Sy1+8HWYPZ2T1kGN
	 hB7p5AkioV9kfvl6WgJmhGFrvA21wn0GD0capVF85MEj0tfHczjFVjvANZl40n/N1vO/e
	 a8VgDjUTPihJZtswYPsxPpcUL1kMucMexpjJxttYoTFatfCDl6GUjEh8MXDozy28VPwIM
	 /uKQx6pmOo9YwE9KUjV/B/7ePISm2INrifFM3KpQ2XTl4e7ldJmWvmF6dwvoTDp5wLrR8
	 p868zOTCM9Z3c0Ef1uMPv2eVEoBoTQzPBDZTboEnddrDGelpLQ0TuywfA2k6nF2VKDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NDw8DYaU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE555606A33B
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NDw8DYaU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348391F000EE;
	Wed, 25 Nov 2026 09:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597952;
	bh=mP5DDoHUKRRKu9tE6RuP6hLe52SWbxGTCEVBYDsHc3I=;
	h=Subject:To:Cc:From:Date;
	b=NDw8DYaUvaI0vjrW/JpEbbs+ofQTV0wQYIUa13Og+zj7F4LTlAXerOCBe3FX/h4D5
	 r2YLSl5AH3xtyWTuVLVUiMFwwIRzcLqbBigbj/HYIBkQoAwqe6OW0ycWbaUCoG1EQ3
	 t/LBPBF/rZlA1Y/zuv7Rubj0+eg7O5kxhApCSM7c=
Subject: FAILED: patch "[PATCH] net: gro: invalidate frag0 after a pull" failed to apply to 6.12-stable tree
To: edumazet@kernel.org,cenzhang@linux.microsoft.com,kuba@kernel.org,tsgatesv@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:01:23 +0100
Message-ID: <2026112523-decompose-earache-12ea@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 98d949a15ff9d3fffaa6983223178374aab92db6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112523-decompose-earache-12ea@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98d949a15ff9d3fffaa6983223178374aab92db6 Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 16:10:42 +0100
Subject: [PATCH] net: gro: invalidate frag0 after a pull

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
Link: https://patch.msgid.link/20261104151042.1157782-3-edumazet@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

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
 

