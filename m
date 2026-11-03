Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703486;
	b=JfO65eM4SKguvPTbiSKqJ/T1ej33DxvTuoouDtcRepC4MLCcH63OMPLuY+IHQVuCi3Wv
	 EUgsWKxyRzCOEMiffmlSBLi7J7e0MqmEw1ohbOvsk4a3Wj3N92jIKFqLG0Ajmju4uWydZ
	 mgUCFN+UUt7fv9L5B7Sqbvi8lD5U1Gi5eUWAXNb58Ur7TKTGmOyTrJVA4VzWwar0k1qGF
	 DS4e5QanTXPaDm+zblNC9uB/RkB31T1FQ5IZKMlhujC66etp07O3ZyTT81dTAYPfHQpsQ
	 l42aQ+8Y3jBZJSmMZJDTbr9tLh5qL8n05Jsl2ASDv0jksiy5dqkhzCVqsFy/FfZh0GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vKJTcM1+MB8kkg7Ee1JWD9nIoH3GOA+sJzoSRUJHO/Q=;
	b=ktfaxQccmE5hsMryPOgDBGWA+rdHgZmC4ixEAplM727JpiLe+y+6hNjK/M9G3XSIO10b
	 A2tNjTC71O3ifACR9T3WDeBGI8kEr04eE2nByTnCr7SZjnLK6sVp23XguiXosxcr9Ljhx
	 nxyzDGj0+PpEHoxSx/qVhl2jQcs/qh2xxeYvQ5cjHtPts2HRMeXOFC9sg15KMLSkckaxk
	 SUAloTTRNx9NS6nCPHC+rM9zySf7ioxiREOJ5DRyLf3H+IBriYIMsDJFjYT/uZ3J23iQZ
	 4+VqbUeTsA2h5U5zotHhkCjaZK95CNL9t8VVdw0VG+5m+g5Nayywmuems7NlkL5l5pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVNUGyUw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92332606BF96;
	Tue,  3 Nov 2026 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVNUGyUw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E2A1F00A1C;
	Tue,  3 Nov 2026 10:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703486;
	bh=vKJTcM1+MB8kkg7Ee1JWD9nIoH3GOA+sJzoSRUJHO/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OVNUGyUwE0PQUAYXt8pxwzenF724B1xK0VtimdXnPpViem4LYz3+0UxoH0v2NrN5O
	 BOr0rW/ilPSFWHkeEJfLrhtALDd1y+TnM/f0LcxwaQ6gRPpALbQkr376/6D173ZG1S
	 Wus+17umEmFIxcz647ea8GiHyZf65BnoWwnOFj7VhD5h2sdjhVUiIDDXMWH/lN8JiH
	 xiKiLNsnVAIeCSefSK3vSfp7vJwm+ma1czhTCaR10Epph65grEWXVSafgDJc/cKw3P
	 waDBx3eZBs9I8W5NS9p4/dVbiD5+ZAfbPnLXr96cbtShWFOf6nDS/cqCht6enCVkbS
	 aaDlR1qlKcybA==
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
Subject: [PATCH net v3 1/2] net: gro: do not undo remote checksum offload on merged packets
Date: Tue,  3 Nov 2026 11:57:51 +0100
Message-ID: <20261103105752.49542-2-edumazet@kernel.org>
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

Fraglist members need the cleanup: skb_segment_list() only copies the
link-layer and tunnel headers from the head skb, so members keep their
own inner headers, with the adjusted checksum. A forwarded VXLAN or GUE
packet would then leave with a modified inner checksum, and since
__copy_skb_header() copies the cleared remcsum_offload bit of the head
skb, gue_remcsum() or vxlan_remcsum() would adjust it a second time.
skb_gro_receive_list() pulled the headers in the linear part before
moving skb->data past them, so restore the checksum there.
The remote checksum start and offset come from the packet: only
restore the checksum if it is part of these headers, which is the
case for a valid packet, where it belongs to the inner transport
header. Otherwise the write could land past the linear part.

This affects VXLAN (VXLAN_F_REMCSUM_NOPARTIAL) and GUE
(FOU_F_REMCSUM_NOPARTIAL).

This was found while fixing a report from Taesoo Kim and Cen Zhang,
who used LLM assisted code analysis and provided reproducers.

Fixes: 26c4f7da3e41 ("net: Fix remcsum in GRO path to not change packet")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/gro.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/net/gro.h b/include/net/gro.h
index 2300b6da05b2..13a8ef217a1d 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -354,6 +354,23 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
 	if (!grc->delta)
 		return;
 
+	if (NAPI_GRO_CB(skb)->same_flow) {
+		/* skb_segment_list() keeps the inner headers of fraglist
+		 * members: restore their checksum. skb_gro_receive_list()
+		 * pulled these headers, then moved skb->data past them.
+		 * A valid remote checksum offset points to the inner
+		 * transport header, which is part of these headers.
+		 * Headers of other merged skbs are not used anymore.
+		 */
+		if (NAPI_GRO_CB(skb)->is_flist &&
+		    grc->offset + sizeof(u16) <= skb_gro_offset(skb))
+			remcsum_unadjust((__sum16 *)(skb->data -
+						     skb_gro_offset(skb) +
+						     grc->offset),
+					 grc->delta);
+		return;
+	}
+
 	ptr = skb_gro_header(skb, plen, grc->offset);
 	if (!ptr)
 		return;
-- 
2.53.0

