Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597949;
	b=DdPdx9jjRNPCSUSac0aIt1tF8Z+qr84a4k07Gtjrq2ojTMcoam71oyz/UNVxl4DCnpTQ
	 BbDMMJz5zVCQsR1K3jygnVlqHUGl9M4Eo+P00K4Iy+sCl6O3QzVGoJ6dfs5zs4RJWbf7I
	 iVxo3OEW9I7xtUUHZ1e2d+zGM0D0JUcXXe+xruBBd7vsLdVhpyE9eb7vecIWk0Z9fqZG/
	 FqLJL6VLHRiJpUvV678Y7Xl3PE0qsroqzje6yJsFbB3hVUezH6zN9HBqw9unkJwOGCKS3
	 uS1W+MiJ8+jnR1+LylB+uAnD71gWGX3dpxHwjmC7UVdD2rys2+SsHCPtTepAsFz+HTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597949;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xae5DZUmxLr6oI7oTh7Z+SLt8ewRs4psqQ4256WA5lU=;
	b=Qv/iMEVTNT5hkw+fuCOOJs/m3jTPYP9hnGwdOnzRcRc15NC2M8hUOhp3qDWLwIzhfmXC
	 gq6BbFn6GKzJQOKnruoSyK0g5q/+YkZ58dyzgxw8jjj9JAMoZUTb4RrhyQQIdKvYPC3jY
	 1+L4E4PH/hVRUDHT03dyWuT97bdpOJZSqDK10dhx6WJGdnVkmz4MpGp9U0MBjgrK58pdG
	 BlG9YMkjpQK8Ia2UaV44UdT+aP1F55S49hHbqxJ3yiUkgswYalJ0zyMJErrnqcLE+wkGx
	 qAJ2dQLN+Q9kf2PmPv9J++wPkFg03wGqn3OTZljff8/E0b5ID7Am7p6pVvn97pviYHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fJFf5hwS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B34F606A333
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fJFf5hwS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD0E1F01569;
	Wed, 25 Nov 2026 09:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597949;
	bh=xae5DZUmxLr6oI7oTh7Z+SLt8ewRs4psqQ4256WA5lU=;
	h=Subject:To:Cc:From:Date;
	b=fJFf5hwSG637JH5yBX6exMG4QKls6MtjQczZswLMXHFLACLnS8KIym9fAiQe6QYA2
	 pEnnYyXydhZJ77TfrxIWOm/9UELk8C+Y4j7YtMtQqGk1alym50FoLl9+HjhKo24wPq
	 81cU+iqbLvrP3yoBvcwYvdMB/QgEq/Pi3ENI6vCQ=
Subject: FAILED: patch "[PATCH] net: gro: do not undo remote checksum offload on merged" failed to apply to 5.10-stable tree
To: edumazet@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:01:10 +0100
Message-ID: <2026112510-gently-tweezers-f0da@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c817ec1b06875b98460fbd19591be541bc3fa924
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112510-gently-tweezers-f0da@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c817ec1b06875b98460fbd19591be541bc3fa924 Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 16:10:41 +0100
Subject: [PATCH] net: gro: do not undo remote checksum offload on merged
 packets

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

