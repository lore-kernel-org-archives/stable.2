Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805053;
	b=Ypu6x8daFpX9iS0WxqjxTdzz5GFKuvZ+tv6drqi6OPhfDg+9HwPthGRxVgxkydJ/dwx1
	 OttS+ihlGmthDlWkGx/sj5WOoewFjA0dSDmJ+PQ3/mzs1a5dtrTWre4VsgdsU1GWzkv7A
	 JV901zYRLkdsiYHe6HP5HtlXW0cacH6NZaC9qDAeb+hj+ULpkCSI1f1gKPoytArW5g0py
	 0YeYfmVmA5Kpw4AbMUTwWXtKkTNGqjQG6wqDmlIKq98xvdnjo9K4qUPke1UvgmC+H0bbP
	 vbncup+XiNMZ8Xbi/Ph103mCFsPdMF00Q15UP4A8WxSXRzHHBQmC4XkWBWNHlM0DmlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZVSEtoVsB39r42UQevvZMNr2ALaezg8WDEvEiyx0PhI=;
	b=CYlotYOVkLLQIR4fxo5s6s+zeAsgHoaO9o3f0BWC+2BtvV9VXgshWSwq3mpKcyczRl01
	 +qYwOoHWLbcvwAiXmuuBg9uUmCMWKBS19PhCLJ1AWy80RULtbJsVvgAamQtq25hGKJu0B
	 6VvAC/t0OtG5xcpYpF/lXkZF2XRu4wJ/Fy0cgYq7RjHO3z3jb0tWamhHsRF1+noS7Mm3P
	 tgw0pK2X3ZpRfwdilDxhQ9Q3P435641QNwDUi0bm4XBqNOGm9USwJoEeNF2OkGJ6h1/Wd
	 ht8rWPArcNEBj3K/hzprDJtcg88gwBRbwgg4IKeitpg9dsHOIISK4G0MQfMDRymHH8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QrmMFiJ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F521606A330;
	Wed,  4 Nov 2026 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrmMFiJ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483711F00A15;
	Wed,  4 Nov 2026 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793805052;
	bh=ZVSEtoVsB39r42UQevvZMNr2ALaezg8WDEvEiyx0PhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QrmMFiJ/pMw/DIpC5JsnQBbE4GI+FKECOrysVFn58gVUKUjfIqV4G8A8soJIigG/I
	 gilbAk9np6Mr23+STG7vPrNgCc+rbnyx28I3/uleJs2MLl/S/ng705rFMcKmi3JkCL
	 mEfX7ci93GICVnE9zsn2tjUAWQ9am8vao71UoxG0GZ6AOPaBxo3QX14TNcFSCIsugA
	 yDLCWwiwAZN14zGYnC7bZj4FluyZqpe91LVaD9VO/Ny/8Ofi61zsh9s8teJJEu7Vnh
	 L2E3vQBJwfdCCgBvsEExOj/YSwn4w8F58Qas9NBsovyatOO+B+DJJe4G7x559bRWtt
	 TX2J9CLn5tu2Q==
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
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] net: gro: do not undo remote checksum offload on merged packets
Date: Wed,  4 Nov 2026 16:10:41 +0100
Message-ID: <20261104151042.1157782-2-edumazet@kernel.org>
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

skb_gro_flush_final_remcsum() calls skb_gro_remcsum_cleanup() to undo
the checksum adjustment done by skb_gro_remcsum_process() when the
packet was not consumed by GRO.

When the inner handler merged the packet (NAPI_GRO_CB(skb)->same_flow
is set), grc->offset can no longer be trusted:

- skb_gro_receive() either gives the frags or the head of the skb
  to the held packet, or uses __skb_pull(skb, offset) before adding
  the skb to the frag_list of the held packet.

- skb_gro_receive_list() uses skb_pull(skb, skb_gro_offset(skb)).

grc->offset is relative to the original skb->data, so the 2-byte
read-modify-write done by skb_gro_remcsum_cleanup() can land in
the payload of a packet which now belongs to the GRO packet.
pskb_may_pull() can also be called on this frag_list member.

With fraglist GRO, this can also be a use-after-free:
pskb_may_pull(skb, skb_gro_offset(skb)) in skb_gro_receive_list()
or udp_gro_receive_segment() releases the first page fragment if it
only contains headers. NAPI_GRO_CB(skb)->frag0 and frag0_len are not
updated, so skb_gro_remcsum_cleanup() takes the fast path and writes
through frag0 into a page the skb no longer holds a reference on.
The non merged case, where frag0 is used after this pull, is handled
in the following patch.

For skbs merged by skb_gro_receive(), the cleanup can be skipped:
the skb is freed, or its headers are rebuilt from the head skb in
skb_segment().

Fraglist members keep their own inner headers, as skb_segment_list()
only copies the link-layer and tunnel headers from the head skb.
Their checksum can not be right in all cases: a packet forwarded with
its tunnel header needs the original value, while a VXLAN packet
decapsulated locally needs the adjusted one, as vxlan_remcsum() only
adjusts the head skb. Make skb_gro_receive_list() refuse packets with
skb->remcsum_offload set, so that fraglist members never carry an
adjusted checksum.

This affects VXLAN (VXLAN_F_REMCSUM_NOPARTIAL) and GUE
(FOU_F_REMCSUM_NOPARTIAL).

This was found while fixing a report from Taesoo Kim and Cen Zhang,
who used LLM assisted code analysis and provided reproducers.

Fixes: 26c4f7da3e41 ("net: Fix remcsum in GRO path to not change packet")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/gro.h | 8 +++++++-
 net/core/gro.c    | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 2300b6da05b2..c49ea8e1298f 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -351,7 +351,13 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
 	void *ptr;
 	size_t plen = grc->offset + sizeof(u16);
 
-	if (!grc->delta)
+	/* Once merged, grc->offset can not be trusted: the frags or head
+	 * of this skb now belong to the GRO packet, or skb->data was pulled
+	 * past the headers before adding it to a frag_list.
+	 * skb_gro_receive_list() does not merge packets with an adjusted
+	 * checksum, other merged packets do not use their headers anymore.
+	 */
+	if (!grc->delta || NAPI_GRO_CB(skb)->same_flow)
 		return;
 
 	ptr = skb_gro_header(skb, plen, grc->offset);
diff --git a/net/core/gro.c b/net/core/gro.c
index 1b033855a20d..a749755c83f3 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -238,6 +238,13 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
+	/* Fraglist members keep their own headers. Their checksum can not
+	 * be right both for a forwarded packet and for a decapsulated one,
+	 * if remote checksum offload adjusted it.
+	 */
+	if (unlikely(skb->remcsum_offload))
+		return -EINVAL;
+
 	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
 		NAPI_GRO_CB(skb)->flush = 1;
 		return -ENOMEM;
-- 
2.53.0

