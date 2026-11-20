Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201890;
	b=Tv/nPH1LkrPqPtrOARcG7dBMbVk3h4gHa9t07+c+AHqclLqEYS70GlE0SyxnWyULFcGv
	 s0CeP2LKwNDIXgVZt8hhYUEFmD4jNU0fHzDk6TBd19heVZ2RDHBLtS1NOFoUHwCxKPeEP
	 ett3GxNYpphYhpsvfP7rNlR9DCX8JuVrl8VMcRDlzUtl9x1HG4NsILdk8LqoPVZs8uzzJ
	 R5KMIE+qiD34iujXkNMZPsTMeQ2BF3c8lr3+m2pV0BVdouUSbkogiIyYKDddrSXHZMZTb
	 N/LDwJ6ca2O3sNh7AApwxROqWkHVqASd+BbTj2T3kru/90y/O4ZYAloaqky/d27Kq3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TPzfbb3YaLrMvD09KlfQinHnJnyyczP5XVaqic2qKsQ=;
	b=kAp4n7Ghp9r6CwL2HKJvYFEVX0+3N1/iIV8gfUMdAPOD9gWGO9KajeZFA/22MThDgiLR
	 9+x3dmnQnDLqpcjPmw4+vcTiu2q8t1I/XI6G34yLE2qDw6iKqbJrnoLPuEfi0L4XoiIxS
	 gz3HiJ/AlU9uTncmHgMheujT/m+r+XoUp8CnSXY6VnMfKwnjSVAi01FdYEDMMiaccRaoz
	 1iNLW9YcIUVyO6wkhtjEqfrxdd/dncc7DXOle3U01JlrOxpBjJ7dQe05bmJNrg3Ww4x+k
	 2IQ07y7Eoq6THEbqa6jfqhw3BYVZBMSnGK68urPalRU3UPUQ5sBYi82e1ExFm5MApOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=EyAeqo+A;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD3D60A260F
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCD3D60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=EyAeqo+A
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-499f20c7054so716077fac.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1795201886; x=1795806686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TPzfbb3YaLrMvD09KlfQinHnJnyyczP5XVaqic2qKsQ=;
        b=EyAeqo+ApYsatSBApkkMjlHlP50A1jf1ordwq8G7XRSahNrIQlT44sMaDpYhR+Ok0t
         R+aY5JM6SLJY/b/xcYnYtrCz4KwIFQyyxdQPCgfcZR96rtn7ZDSaKGoklvHQh8xNRxi4
         1kOrqLVYX8IbYexCaysu4ONfbaFi7rUHFlVZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201886; x=1795806686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TPzfbb3YaLrMvD09KlfQinHnJnyyczP5XVaqic2qKsQ=;
        b=dH4hiQg0X/iHTsECP7j2z63hJXSW0D2ju0B7S75nu87HZcYB7DmodmQA+CwOlI5xuI
         vALmXxE9NGahbVmJnonHXlH/Z7YkGEw+OPhHPo/69iEhX9LSZW+vlXCG3hgIuuQFgXSE
         P8rTtTIDpdAciHShGgw5+dUEK4fBlBtRh1I+/ZStJwjg6yHlYs8JDbU0vYnHPv0oUm6q
         cULpGI+ur+XSKDid/9zliEjp5wAIr+LGjR34UG174XX02Q0keZLsFH9ny08M30CwACFo
         uzJXlgqETIZ3fK/CsEWwTH7mA781ce5HSHKZnfcqvesUQLxEiRLIqRwml+GdUf/eAMEm
         v9IA==
X-Forwarded-Encrypted: i=1; AL+hErHXBVmofF/+aRQYb6YQyIfM2yeIeU5QFU4nJZXWoQaIRWnEmdB7rFhUTcK2DLC8BlQaPzLEpZI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/elGwLMLmajaxwnWNpLbq7U31EIJct7fXAxNgFVhX7lP7Ezdwf
	MNjxOZDOgctkLVynBVaIb0S7K8PFbJJUgIHT0MdOtFWYRiklPTsp6vGD7UEV894QSu4=
X-Gm-Gg: AZFdTZeihdeWajzdMeojFSaNp2kVJJ9zDU8VOonc57pVgmPnH+WYl8alBoJjA1qaEjb
	MJmBU5dymFwkO86Yb+u6WfDCo+SF4HP14CGlQ5IXjnBfHQYpKD+Beuh4nKwVUmdRBQaRIypuc2l
	7dLsNk/HKBzbw1E812+pHjHS3ge+t5wKHBmEQfGk5JWKy7/yt9i5cWeQMHPT8DUhl16/PuU0Ofn
	ZL9qVnQ20IL9TTB1ee6MuOYMYKSsmE7hdgPIDIBL3z/CBoHaCmmUlU7+z6l/nLMYrlnMwbNT3Pk
	7MYCtnl0McolRVnPAfq9IbIfdW1BPNmWGB35OnVPmJdsjzkuf71qF9cdaW/RSdRGCbha2FUaQvr
	Hm1nxWSwdC4TSy+n88nh/NFFV+X9DGaJl8gSNaMzXsTeYcqfk9lZbzzdNQNzYaPj9FfxnkvLpe4
	unw0p3yoaIpwZ35fkHVnb7HjtyRJ9Z7MXV8Gv5ywyy1rOU2UL21Aon4dmI5iZ3LdR3Chyz+8WzT
	/cigPOZUs5PgS2ksMS/sY+ZBF27eVCp1LMQ4RsKzjncLwungnkW9pVbXprLay4pK+GYcd5fNUWj
	k9u0xTnEHMCRlz4kyMJjDahOb7C0W9HkqVC/6zPfJwcwV+aPSnnpXhSpiWLbMudOM1cOfhdk1Yg
	dHCBAFzIR0bvDri6X+38ximrGnPqT4Hj/EdPaqhnc5jC4NdiIwqMK
X-Received: by 2002:a05:6870:3193:b0:475:a1ec:9617 with SMTP id 586e51a60fabf-4bc80ec71b9mr3905456fac.25.1795201886207;
        Fri, 20 Nov 2026 11:11:26 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60497300sm3706193fac.11.2026.11.20.11.11.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 11:11:25 -0800 (PST)
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
Subject: [PATCH net v4] net: openvswitch: make transport checksums writable
Date: Fri, 20 Nov 2026 11:11:15 -0800
Message-ID: <20261120191115.39932-1-kylebot@openai.com>
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
v4:
- Document that both IPv6 checksum addresses must be outside the skb.
- Use the IPv6 address fields' sizes in the final copies.

v3: https://lore.kernel.org/r/20261113232158.61174-1-kylebot@openai.com
- Select source and destination addresses with booleans instead of
  calculating offsets. Keep the saved IPv6 address across head movement.
- Remove the redundant IPv6 fragment check and correct tab alignment.
- Move testing details below the separator and clean up attribution.

v2: https://lore.kernel.org/r/20261107040238.27606-1-kylebot@openai.com
v1: https://lore.kernel.org/r/20261030042304.74291-1-kylebot@openai.com

I have a reproducer for this issue and can share through DM.

 net/openvswitch/actions.c | 80 +++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 12e339cbf791..7691f262294d 100644
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
@@ -345,32 +347,37 @@ static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
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
 
+/* Neither addr nor new_addr may point into the skb, since
+ * skb_ensure_writable() can move the skb head even on failure.
+ */
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
@@ -381,7 +388,8 @@ static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
 			}
 		}
 	} else if (l4_proto == NEXTHDR_ICMP) {
-		if (likely(transport_len >= sizeof(struct icmp6hdr)))
+		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
+						sizeof(struct icmp6hdr))))
 			inet_proto_csum_replace16(&icmp6_hdr(skb)->icmp6_cksum,
 						  skb, addr, new_addr, true);
 	}
@@ -396,16 +404,28 @@ static void mask_ipv6_addr(const __be32 old[4], const __be32 addr[4],
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
+		memcpy(&nh->saddr, new_addr, sizeof(nh->saddr));
+	else
+		memcpy(&nh->daddr, new_addr, sizeof(nh->daddr));
 }
 
 static void set_ipv6_dsfield(struct sk_buff *skb, struct ipv6hdr *nh, u8 ipv6_tclass, u8 mask)
@@ -479,16 +499,18 @@ static int set_ipv4(struct sk_buff *skb, struct sw_flow_key *flow_key,
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
@@ -533,10 +555,11 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
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
@@ -555,10 +578,11 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
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

