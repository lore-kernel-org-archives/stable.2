Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612127;
	b=ZVh71qsvij6f5Wz5rtPcL6eUUTDemO45bMGgV+QOjsD550hZtvS4IQ2wpgSkC8eRP8aV
	 10lUfhAr/vMTjZF9Cwzvt7LeQGHnSMF/irDfBG5WX4tAsecm08ZDY9PwuPlp9yl+1BLMP
	 77WFKKOx09e8i/AUczyS9csqnJuFdHAx9+3ap4pAMZW0qeKc7cl0/uz1Y58Eu9o/tXb3I
	 dOSz5xiqqx74Pu7tgr0ptFPQpiEEKchZutt2AkWfvPR+6wXMuR6J7mqrRjKP7Q+UlfM+L
	 9yAqB+I5fhzrMJT8PjhI7nnmHIUiNpOKDGXpdcrcJQuYewbtbb8C8yAIkDhUosrdH+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eG8sIetC7zpwDTaN+oZEyMcNNgTpFmawbIcCT4kAbrI=;
	b=Y31TuOhK+ZkQ9Lc2fLv3LPbMkOqX21Kf1tClgsaS5TTaz+frWRRA0fx2uzlWUeaQfvDW
	 //7mZAEP/hsCAm9nMiHSDcqsFWXQktGzTWccbX7DeYGI6Q/7pNQzhyLIS9WKUpC5xOenM
	 TJ8kkiMBANZD7qdMTTOl894vq+rVvQwewgRQzQ/H097yp6zIImDJVCTIhiB65A/y7k/P9
	 M+/Vkw4vqa5viXZv9Mi7MHP7SRNo8bluN6vvavBjwvf4HcmUZwWBObbUJ5FlxtXtBcpJ6
	 8qA0LCqqzswcZeGN2dt0zuF0t2IstSeScePN/RW7xScUuMYMY48wY7rs1edDmNmzy8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=NDNfvu1w;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F7606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 23:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 258F7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=NDNfvu1w
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91ea2e29d90so36051826d6.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794612125; x=1795216925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eG8sIetC7zpwDTaN+oZEyMcNNgTpFmawbIcCT4kAbrI=;
        b=NDNfvu1wf2iRj16DT3eUT5BRV92q1asM15vPRmZxAqSpfgP3gBLrjzeJaET6RmRZM6
         0qfP2ZejcU0vRUhpJwVNKqJheYuxmBuOIZWRPaqnj0Pc8gc1g3wmsdeyqxVqeD1r1uaw
         mStX/kqos1G2GzJnUkZEWO/pQAF7tie370CcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794612125; x=1795216925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eG8sIetC7zpwDTaN+oZEyMcNNgTpFmawbIcCT4kAbrI=;
        b=TLz5RKq+pBjq3z/us2t2Q6mOiJkIy7NGRavr/ajwM0VI+gOjOt2vQ78qutTWSW9nns
         /ATzQT657ZUQQnBJFfWXBTRxaYzP4S7nWYd4zddMKjaDmpw41Xp1YU8h4aI7pEiscP/4
         febCfdeeo8mo2BtwDJE0WtapScFKASIRcDFKnEEEaGBCcQIKOaw62BsMAJS69zDqvMci
         QPq9reGX9U5L2pag5xVYg7AMOrZGl5oUALqer0OAt3DzCKW8FIj5ixqWdx7HUl+D8/3B
         E7T8RjFkPPCQ8g/ojLoBzEHYmfgcZ6iUHjiztwzoH/+WS9M9HrvP/L7WZm18P+TPWOqL
         Hy0A==
X-Forwarded-Encrypted: i=1; AL+hErHoyUh4f2afGhO1q+SfxUEEybX0OZcBQS6VM+RS5aV7afDhmulbjLiXMkvwo7p8THfCGeHwtWY=@vger.kernel.org
X-Gm-Message-State: APuU4Z81QwJmw7QZdN4XhPr1oGmIcixoFsSl6S4GLwjeUhCSFnCBgtH6
	znOMIPKqD6XQ0lXtwWbDW2ol0TfK9Eblpmsmb+DkwzzAnrlovrOMs8IQh8Jwb7JzkmU=
X-Gm-Gg: AYBFou3shkCySDuraNqf2L3hWjQP/7rIDbuzc3LjhQRCuJR9ptNuR48jRwemCAQeD5S
	X94+7y1ssUQMJB0YN5nGvmUnWjMK+NTVUduddb7D8bkRUdD2N6KugJpAGHHHmFu+mrVI3qX1lyk
	sYz7Ep0N/aUPKSR6SkMwALCzfd95CyW75LUDpH1kTDuMWr9/gZ+u/uvq/Nx5ECqZzvWJTt4UcLW
	yuSjCVAcUWiNW8hJ+xzEwo1NxZt70l+PVmZSX+0Wvqr7Ctup9tq1iYEVeJq+9jec0/iHdBDZmPr
	0syNrEmaT1kYsrXuGrXk/SoLU0tqCgRX5xM/pFVwg0LnKxTZzN2bX47WHy01bZRG1nGTLMqvthW
	McsaRmy4Al/S0JxmVWWCO/VuwOpVjviN9LGJw+dGkCWHTF5oNDZHADvG9bw6z8qrAi+xGbv2Ry/
	llmo5gCoXeh1N8kQzwkIeX7OUPkmOq7muFxUQf4OuIqeZgcoY6ua0N/SX5AOqj+qvzfJBikslTA
	ddVO34O/TQtFsbAZiZxClFTpaIH+PcwSykQuuEGLGxymaN1LLIPYj+IVsetrFjkMtLfvUKBLLRm
	24HbOwguQSpp0HHuPLSAQBFZzD90/EY4kOEu2a8XLnySlw9nLMofApSd3Q4ORMG/L7eEQBo7aXb
	C2aU29t/Bu8dpdpV8PblrqiLflQmD9dWu2ClYlM81TsjIXa0krOc=
X-Received: by 2002:a05:6214:d8d:b0:91f:ffc:69cf with SMTP id 6a1803df08f44-91f13a9513emr121471506d6.35.1794612124812;
        Fri, 13 Nov 2026 15:22:04 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7b607sm31147806d6.26.2026.11.13.15.22.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 15:22:04 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: dev@openvswitch.org
Cc: netdev@vger.kernel.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: openvswitch: make transport checksums writable
Date: Fri, 13 Nov 2026 15:21:58 -0800
Message-ID: <20261113232158.61174-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

OVS can still rewrite an IP address after transport-header extraction
fails. The checksum helpers check skb->len, which includes non-linear
data, before directly accessing the L4 checksum. If the transport header
was not pulled into the linear head, the checksum update can read or
write beyond it.

Call skb_ensure_writable() before IPv4 TCP/UDP and IPv6 TCP/UDP/ICMPv6
checksum updates. Save the original addresses and reload header pointers,
since even a failed pull can move the skb head.

Keep failures nonfatal to preserve the existing policy of rewriting IP
addresses when the transport header is unavailable. A failed pull or
unshare may leave a stale checksum or CHECKSUM_PARTIAL seed; the receiver
may discard the packet.

The issue was found by an LLM.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v3:
- Select source and destination addresses with booleans instead of
  calculating offsets. Keep the saved IPv6 address across head movement.
- Remove the redundant IPv6 fragment check and correct tab alignment.
- Move testing details below the separator and clean up attribution.

v2: https://lore.kernel.org/r/20261107040238.27606-1-kylebot@openai.com
v1: https://lore.kernel.org/r/20261030042304.74291-1-kylebot@openai.com

I have a reproducer for this issue and can share through DM.

 net/openvswitch/actions.c | 77 +++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 12e339cbf791..3b10b3fbadc3 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -319,20 +319,22 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
 	return 0;
 }
 
-static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
-				  __be32 addr, __be32 new_addr)
+static void update_ip_l4_checksum(struct sk_buff *skb, __be32 addr,
+				  __be32 new_addr)
 {
-	int transport_len = skb->len - skb_transport_offset(skb);
+	struct iphdr *nh = ip_hdr(skb);
 
 	if (nh->frag_off & htons(IP_OFFSET))
 		return;
 
 	if (nh->protocol == IPPROTO_TCP) {
-		if (likely(transport_len >= sizeof(struct tcphdr)))
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+						sizeof(struct tcphdr))))
 			inet_proto_csum_replace4(&tcp_hdr(skb)->check, skb,
 						 addr, new_addr, true);
 	} else if (nh->protocol == IPPROTO_UDP) {
-		if (likely(transport_len >= sizeof(struct udphdr))) {
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+						sizeof(struct udphdr)))) {
 			struct udphdr *uh = udp_hdr(skb);
 
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -345,32 +347,34 @@ static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
 	}
 }
 
-static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
-			__be32 *addr, __be32 new_addr)
+/* May move the skb head; callers must reload packet pointers. */
+static void set_ip_addr(struct sk_buff *skb, __be32 new_addr, bool saddr)
 {
-	update_ip_l4_checksum(skb, nh, *addr, new_addr);
-	csum_replace4(&nh->check, *addr, new_addr);
+	__be32 old_addr = saddr ? ip_hdr(skb)->saddr : ip_hdr(skb)->daddr;
+
+	update_ip_l4_checksum(skb, old_addr, new_addr);
+	csum_replace4(&ip_hdr(skb)->check, old_addr, new_addr);
+
 	skb_clear_hash(skb);
 	ovs_ct_clear(skb, NULL);
-	*addr = new_addr;
+
+	if (saddr)
+		ip_hdr(skb)->saddr = new_addr;
+	else
+		ip_hdr(skb)->daddr = new_addr;
 }
 
 static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
 				 __be32 addr[4], const __be32 new_addr[4])
 {
-	int transport_len;
-
-	if (l4_proto == NEXTHDR_FRAGMENT)
-		return;
-
-	transport_len = skb->len - skb_transport_offset(skb);
-
 	if (l4_proto == NEXTHDR_TCP) {
-		if (likely(transport_len >= sizeof(struct tcphdr)))
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+						sizeof(struct tcphdr))))
 			inet_proto_csum_replace16(&tcp_hdr(skb)->check, skb,
 						  addr, new_addr, true);
 	} else if (l4_proto == NEXTHDR_UDP) {
-		if (likely(transport_len >= sizeof(struct udphdr))) {
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+						sizeof(struct udphdr)))) {
 			struct udphdr *uh = udp_hdr(skb);
 
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -381,7 +385,8 @@ static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
 			}
 		}
 	} else if (l4_proto == NEXTHDR_ICMP) {
-		if (likely(transport_len >= sizeof(struct icmp6hdr)))
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+						sizeof(struct icmp6hdr))))
 			inet_proto_csum_replace16(&icmp6_hdr(skb)->icmp6_cksum,
 						  skb, addr, new_addr, true);
 	}
@@ -396,16 +401,28 @@ static void mask_ipv6_addr(const __be32 old[4], const __be32 addr[4],
 	masked[3] = OVS_MASKED(old[3], addr[3], mask[3]);
 }
 
+/* May move the skb head; callers must reload packet pointers. */
 static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
-			  __be32 addr[4], const __be32 new_addr[4],
+			  const __be32 new_addr[4], bool saddr,
 			  bool recalculate_csum)
 {
-	if (recalculate_csum)
-		update_ipv6_checksum(skb, l4_proto, addr, new_addr);
+	struct ipv6hdr *nh = ipv6_hdr(skb);
+	__be32 old_addr[4];
+
+	if (recalculate_csum) {
+		memcpy(old_addr, saddr ? &nh->saddr : &nh->daddr,
+		       sizeof(old_addr));
+		update_ipv6_checksum(skb, l4_proto, old_addr, new_addr);
+		nh = ipv6_hdr(skb);
+	}
 
 	skb_clear_hash(skb);
 	ovs_ct_clear(skb, NULL);
-	memcpy(addr, new_addr, sizeof(__be32[4]));
+
+	if (saddr)
+		memcpy(&nh->saddr, new_addr, sizeof(__be32[4]));
+	else
+		memcpy(&nh->daddr, new_addr, sizeof(__be32[4]));
 }
 
 static void set_ipv6_dsfield(struct sk_buff *skb, struct ipv6hdr *nh, u8 ipv6_tclass, u8 mask)
@@ -479,16 +496,18 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
 		new_addr = OVS_MASKED(nh->saddr, key->ipv4_src, mask->ipv4_src);
 
 		if (unlikely(new_addr != nh->saddr)) {
-			set_ip_addr(skb, nh, &nh->saddr, new_addr);
+			set_ip_addr(skb, new_addr, true);
 			flow_key->ipv4.addr.src = new_addr;
+			nh = ip_hdr(skb);
 		}
 	}
 	if (mask->ipv4_dst) {
 		new_addr = OVS_MASKED(nh->daddr, key->ipv4_dst, mask->ipv4_dst);
 
 		if (unlikely(new_addr != nh->daddr)) {
-			set_ip_addr(skb, nh, &nh->daddr, new_addr);
+			set_ip_addr(skb, new_addr, false);
 			flow_key->ipv4.addr.dst = new_addr;
+			nh = ip_hdr(skb);
 		}
 	}
 	if (mask->ipv4_tos) {
@@ -533,10 +552,11 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
 		mask_ipv6_addr(saddr, key->ipv6_src, mask->ipv6_src, masked);
 
 		if (unlikely(memcmp(saddr, masked, sizeof(masked)))) {
-			set_ipv6_addr(skb, flow_key->ip.proto, saddr, masked,
+			set_ipv6_addr(skb, flow_key->ip.proto, masked, true,
 				      true);
 			memcpy(&flow_key->ipv6.addr.src, masked,
 			       sizeof(flow_key->ipv6.addr.src));
+			nh = ipv6_hdr(skb);
 		}
 	}
 	if (is_ipv6_mask_nonzero(mask->ipv6_dst)) {
@@ -555,10 +575,11 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
 							     NULL, &flags)
 					       != NEXTHDR_ROUTING);
 
-			set_ipv6_addr(skb, flow_key->ip.proto, daddr, masked,
+			set_ipv6_addr(skb, flow_key->ip.proto, masked, false,
 				      recalc_csum);
 			memcpy(&flow_key->ipv6.addr.dst, masked,
 			       sizeof(flow_key->ipv6.addr.dst));
+			nh = ipv6_hdr(skb);
 		}
 	}
 	if (mask->ipv6_tclass) {

base-commit: 2800868f63227c8237d70c41e70d441c919620d6
-- 
2.55.0.openai.911.g06873a30d2f3

