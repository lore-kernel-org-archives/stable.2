Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620332;
	b=ibQ9h2QpzvB/gRVCcSY+V3+e2fdN1IzyKkFynS85UMLiJUbPqAmpWBw+xeDDIjj+5cba
	 E0uVYHfIswNnGL2EQx/KwUyf/hSoaJW1yiNueW5JDXyyHlQoNsjciOtwVb8I1n/h36Kwj
	 b2OOB4G54U5JOQzzJHPw7VHcmQeYeV3EzO1dr2V6GLVut9gGeM7JLwgeQKHCr8QSBHKZR
	 +FfKQGGQinzIfaOnIdGlGp3Mp5WPz/BZ9gmpNOwt0+cSISFb5m5N4M3IiJLvEor5gLl31
	 WUHTvKHOS+VwdaUw256MF2NM93GiohCGsV98lcBtdtIxzwukLMLH36hq7192JUe6Wfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620332;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WCVtjxItPEH0zXpqDbKQx/5snQrmn4JStnUV+RGkvSY=;
	b=IOHJGxvYJOYsLYNSi47slrKGSbZEgDy46GsXOK5z5lrjZFOKbJ7oYhVBvvFW5B62LNR2
	 57l8dydZgMpVs4Kot0UJNm9Rd5KvOklL8KcEu2AOiwO2Han0NEl1dEMu6MqVSQ5WymQ9p
	 fgp9CNiSXdqKU1SakKocqSRuvLOVtuTwqS645SdO7bKEUF1Z97ROskwePLhtfqkdlgQ8Z
	 pacrVDTWbrl2/5IcZWHTA3WLxc09sa3x9Kb+wCi1bK2bkJ0JYurjDH4c3J0d++0u4arfX
	 bSZfY3zHMgTGx7hJcam3dobmgQSVfOWrTQC4Jjbc/MbeXPm3qRCbU1YUD1NTCTDdNgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+MX3p9u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FFD606A33B
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+MX3p9u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224D21F000E0;
	Wed, 25 Nov 2026 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620331;
	bh=WCVtjxItPEH0zXpqDbKQx/5snQrmn4JStnUV+RGkvSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d+MX3p9uQNAY7747cS/xyqQvAIygIjXAweFCCN7ikNsX33f6Gxd4UuIRqCRjG+oFR
	 gHzttrcuPYRSl8x4FwZcPJ3mY9BP4Bzn+x0l1YvsiMHrWhIISDUczlJv/u3xBfCUhw
	 ZPEoRdiLp+fqeCNg2YqgYmCnM7i/FQkFEWh9zR9xidU5xlnB5kcf55+hfZw/dpBLv/
	 +kQyngt2qm93Ycvu8X8YV5pyjZ3OUIUKC0qHpPnbwpPt4CNObMdBunqqTjNtCU/Urb
	 A3AmCpQRw6W4vXaGrJo4yeY/u5mOFC9uQ0KDI+Xb0CIK8p9FZQ0YJ93V7IESQXokiU
	 vGljAmkrEWXRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: gro: do not undo remote checksum offload on merged packets
Date: Wed, 25 Nov 2026 10:25:29 -0500
Message-ID: <20261125152414.183875-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112508-straddle-cosponsor-ad6e@gregkh>
References: <2026112508-straddle-cosponsor-ad6e@gregkh>
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

[ Upstream commit c817ec1b06875b98460fbd19591be541bc3fa924 ]

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
Link: https://patch.msgid.link/20261104151042.1157782-2-edumazet@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: adjusted the placement of the remcsum_offload check in skb_gro_receive_list() because this tree lacks the pskb_may_pull() call that upstream has there (the pull is in the UDP caller). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/gro.h | 8 +++++++-
 net/core/gro.c    | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 439aa18578f69..886e267528d26 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -352,7 +352,13 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
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
index 755496f53415e..4a5822591a7de 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -244,6 +244,13 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
+	/* Fraglist members keep their own headers. Their checksum can not
+	 * be right both for a forwarded packet and for a decapsulated one,
+	 * if remote checksum offload adjusted it.
+	 */
+	if (unlikely(skb->remcsum_offload))
+		return -EINVAL;
+
 	if (NAPI_GRO_CB(p)->last == p)
 		skb_shinfo(p)->frag_list = skb;
 	else
-- 
2.53.0

