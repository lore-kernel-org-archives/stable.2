Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433632;
	b=ISTQkLPSFoQzFugQc/jDr4b6B0OTqX584hWevGKaYsKCVJrwEFFwhF3Nyem+VI3zysq3
	 At9KsJNOIfhMyOyCsBkaJGMqziloLz68oLLzr1AHZWPLVxrw2wJDfDBg0Ni+KZJDKoXPK
	 IeGFQhq7hQSAqutJbMD4T5x3iVPfPVF2hmRjlDGb7GZ8m03v0WN5kvlJcnFARlnqLYCqd
	 2oVrcATd4gQ3XnJ4fyBIhXEy5SBqNpi76OohssB4uJduBR+VIX3M9zGn2fiT8mg3FWfYx
	 +o2bVHkgdL5/ir3khp/oKALAotOAGQsCep8ZLx4bQ/MlEwETi8DCe3BA1xMpM/V4VBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433632;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=YvOEyv3VqLxiUMZ8Y2pmrOuocmXhB80LSHRQNIO8VwU=;
	b=FdzibaTN9nv/vriA9pwGH1zMl9Ty9E42hTR4I8aGbZvsUzQmn0zyCZywEqfpX1imMDFz
	 1y+YeFJiIrC/e8/57mp00HVFXxoh3Zh6ahYbEYhEizrz29a4bynSUOQJWX+S7Irc93KYl
	 FCZQymq3uRDNLKFxQwXBejqa3CGLKckHfIBJHteAYhp/QwgnHJ+UrTm7M4QhL3pw1Ob72
	 nmcJxDB20gIxNwi9luebuJZsa5VEDOvRysbY6up52K0oHP+B026mCWcvryCilZzGNUfJu
	 m7CFcvYKPxasXI9cgNfeIao91qiVPb3YowqLCWfyIz0Y9UNlYrEtiHWIvCAALnVqOOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=RBX1HAsP;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE83606A324;
	Wed, 11 Nov 2026 21:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FE83606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=RBX1HAsP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=YvOEyv3VqLxiUMZ8Y2pmrOuocmXhB80LSHRQNIO8VwU=; b=RBX1HAsP8zVG0K1o1j2FF/lKrv
	qjMMLrFO7eMQ9e7LJlVh2PMGL5APM3C9b10Nv+6mzHIcza+e+9IzBpwnmw6DUyOcWfgk6UyglQnqT
	KPA3dHQY3K3wsZB/KuscWiN1mYgei7OJTC8GrXzO9HS6WZKjazhfefV1ZepWYvtBzmbJ9FfI8a9Rt
	XzWnxzccZclEvOn0ZGBdmevN/scPHrLhOx5eHVO9AZR5TD8b53OpUyiztWYT2s5i3oF49tjKKGlwQ
	fgczPiCnq+y7Rzd3+eZrlJk7lsjNjZKLnaxUaml9nqPAyDEFdRG+FFeOZ7M9xTq+Ae/8EL185bXQv
	sLHuJNqQ==;
Received: from [151.115.150.205] (port=42092 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRG9t-0000000BsZK-3ZCS;
	Wed, 11 Nov 2026 22:47:09 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net v2] udp_tunnel: fix GRO callback mismatch during setup
Date: Wed, 11 Nov 2026 21:46:23 +0000
Message-ID: <20261111214622.2482547-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
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
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

setup_udp_tunnel_sock() updates an already bound socket. GRO can find it
while the socket callbacks and global static call disagree. Receive and
completion may then parse one packet differently and write out of bounds,
KASAN reports as:

  BUG: KASAN: slab-out-of-bounds in udp6_gro_complete+0x48a/0x4b0
  Write of size 2 at addr ffff8880044d8e78 by task repro/44

Publish gro_receive last and read it once. Count tunnel GRO receive
callbacks and consume one at each UDP completion. Only use the static
call if its target matches, and wait before changing it.

Fixes: 5d7f5b2f6b93 ("udp_tunnel: use static call for GRO hooks when possible")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---

v1: https://lore.kernel.org/all/20260906211351.1272699-2-Jeremy.Jean@oss.cyber.gouv.fr/
Sashiko: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906211351.1272699-2-Jeremy.Jean%40oss.cyber.gouv.fr

 include/net/gro.h          |  3 ++-
 net/core/gro.c             |  1 +
 net/ipv4/udp_offload.c     | 51 +++++++++++++++++++++++++++-----------
 net/ipv4/udp_tunnel_core.c |  5 ++--
 4 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 7a19d4486456..81bd838f268f 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -45,7 +45,8 @@ struct napi_gro_cb {
 	/* Used in ipv6_gro_receive() and foo-over-udp and esp-in-udp */
 	u16	proto;
 
-	u16	pad;
+	/* UDP tunnel GRO callbacks left to complete */
+	u16	udp_tunnel_gro_count;
 
 /* Used in napi_gro_cb::free */
 #define NAPI_GRO_FREE             1
diff --git a/net/core/gro.c b/net/core/gro.c
index 75f6a5f39a4b..96c3bbd6c153 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -526,6 +526,7 @@ static enum gro_result dev_gro_receive(struct gro_node *gro,
 	*(u32 *)&NAPI_GRO_CB(skb)->zeroed = 0;
 	NAPI_GRO_CB(skb)->flush = skb_has_frag_list(skb);
 	NAPI_GRO_CB(skb)->count = 1;
+	NAPI_GRO_CB(skb)->udp_tunnel_gro_count = 0;
 	if (unlikely(skb_is_gso(skb))) {
 		NAPI_GRO_CB(skb)->count = skb_shinfo(skb)->gso_segs;
 		/* Only support TCP and non DODGY users, with a sane gso_segs. */
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cd9d7426b227..39f06fcd59ab 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -136,6 +136,7 @@ void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
 		static_branch_enable(&udp_tunnel_static_call);
 	} else if (old_gro_type_nr == 1) {
 		static_branch_disable(&udp_tunnel_static_call);
+		synchronize_net();
 		static_call_update(udp_tunnel_gro_rcv, dummy_gro_rcv);
 	}
 
@@ -144,27 +145,37 @@ void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_rcv);
 
-static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
+static struct sk_buff *udp_tunnel_gro_rcv(udp_tunnel_gro_receive_t gro_receive,
+					  struct sock *sk,
 					  struct list_head *head,
 					  struct sk_buff *skb)
 {
-	if (static_branch_likely(&udp_tunnel_static_call)) {
-		if (unlikely(gro_recursion_inc_test(skb))) {
-			NAPI_GRO_CB(skb)->flush |= 1;
-			return NULL;
-		}
-		return static_call(udp_tunnel_gro_rcv)(sk, head, skb);
+	if (unlikely(gro_recursion_inc_test(skb))) {
+		NAPI_GRO_CB(skb)->flush |= 1;
+		return NULL;
 	}
-	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
+	NAPI_GRO_CB(skb)->udp_tunnel_gro_count++;
+
+	if (static_branch_likely(&udp_tunnel_static_call) &&
+	    likely(gro_receive == static_call_query(udp_tunnel_gro_rcv)))
+		return static_call(udp_tunnel_gro_rcv)(sk, head, skb);
+	return gro_receive(sk, head, skb);
 }
 
 #else
 
-static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
+static struct sk_buff *udp_tunnel_gro_rcv(udp_tunnel_gro_receive_t gro_receive,
+					  struct sock *sk,
 					  struct list_head *head,
 					  struct sk_buff *skb)
 {
-	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
+	if (unlikely(gro_recursion_inc_test(skb))) {
+		NAPI_GRO_CB(skb)->flush |= 1;
+		return NULL;
+	}
+	NAPI_GRO_CB(skb)->udp_tunnel_gro_count++;
+
+	return gro_receive(sk, head, skb);
 }
 
 #endif
@@ -777,6 +788,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 				struct udphdr *uh, struct sock *sk)
 {
+	udp_tunnel_gro_receive_t gro_receive = NULL;
 	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
 	struct udphdr *uh2;
@@ -795,7 +807,11 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	 * cases. Such packets should be caught in udp_unexpected_gso later.
 	 */
 	NAPI_GRO_CB(skb)->is_flist = 0;
-	if (!sk || !udp_sk(sk)->gro_receive) {
+	if (sk) {
+		/* Pairs with smp_store_release() in setup_udp_tunnel_sock(). */
+		gro_receive = smp_load_acquire(&udp_sk(sk)->gro_receive);
+	}
+	if (!gro_receive) {
 		/* If the packet was locally encapsulated in a UDP tunnel that
 		 * wasn't detected above, do not GRO.
 		 */
@@ -842,7 +858,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	skb_gro_pull(skb, sizeof(struct udphdr)); /* pull encapsulating udp header */
 	skb_gro_postpull_rcsum(skb, uh, sizeof(struct udphdr));
-	pp = udp_tunnel_gro_rcv(sk, head, skb);
+	pp = udp_tunnel_gro_rcv(gro_receive, sk, head, skb);
 
 out:
 	skb_gro_flush_final(skb, pp, flush);
@@ -921,6 +937,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 {
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 	unsigned int newlen = skb->len - nhoff;
+	udp_tunnel_gro_complete_t gro_complete = NULL;
 	struct sock *sk;
 	int err;
 
@@ -928,7 +945,12 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
-	if (sk && udp_sk(sk)->gro_complete) {
+	if (NAPI_GRO_CB(skb)->udp_tunnel_gro_count) {
+		NAPI_GRO_CB(skb)->udp_tunnel_gro_count--;
+		if (sk)
+			gro_complete = READ_ONCE(udp_sk(sk)->gro_complete);
+	}
+	if (gro_complete) {
 		skb_shinfo(skb)->gso_type = uh->check ? SKB_GSO_UDP_TUNNEL_CSUM
 					: SKB_GSO_UDP_TUNNEL;
 
@@ -941,8 +963,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 		 * functions to make them set up the inner offsets.
 		 */
 		skb->encapsulation = 1;
-		err = udp_sk(sk)->gro_complete(sk, skb,
-				nhoff + sizeof(struct udphdr));
+		err = gro_complete(sk, skb, nhoff + sizeof(struct udphdr));
 	} else {
 		err = udp_gro_complete_segment(skb);
 	}
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index a128fe85620d..147c92374975 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -84,8 +84,9 @@ void setup_udp_tunnel_sock(struct net *net, struct sock *sk,
 	udp_sk(sk)->encap_err_rcv = cfg->encap_err_rcv;
 	udp_sk(sk)->encap_err_lookup = cfg->encap_err_lookup;
 	udp_sk(sk)->encap_destroy = cfg->encap_destroy;
-	udp_sk(sk)->gro_receive = cfg->gro_receive;
-	udp_sk(sk)->gro_complete = cfg->gro_complete;
+	WRITE_ONCE(udp_sk(sk)->gro_complete, cfg->gro_complete);
+	/* Pairs with smp_load_acquire() in udp_gro_receive(). */
+	smp_store_release(&udp_sk(sk)->gro_receive, cfg->gro_receive);
 
 	udp_tunnel_encap_enable(sk);
 
-- 
2.47.3

