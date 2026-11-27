Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795751009;
	b=Lc7bAeraDfo+xsOVvcnQLIdqAoRynM/FE2hRZIh8f65f+UXI/76v81l3KLFKWWhKXXjO
	 Mgm2OECiCY44tL89BdwrIYWuArae3x9Xragx45QSoFgr4ULgA4BMcLQ3du74KHm4RuS0n
	 heqf1eQx/YMwVUKEakOAD23AZzAVzmRA7YiGSi76Pyg7nF22MsKgPwwxg2OqAwyzvtnzV
	 68Btz9+QQJFg0ael5mVsb5qryF7sIGCrx8+/FBdnMq6HRQD/dMjl9QaxBFXvBj+rx4mBx
	 nH2IxBo78XL1u4TymNxa4dyzyUH3ZOawzLclyK6jk1gQKnyCgdhf7U0PwoQ1HHATDmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795751009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Xv9HoU11wg50uyramdQYfq7Umn1TYxplpQtca+BOSaU=;
	b=zEiTRlienTxwGfs19rSjf13e+Z/Cvc1v9RXgWey1ZqocE1GSmu3tLsYP+7CUn/rk0jGg
	 r88zvj+WYzyHGaEAH8CfUvWKAjJPFujZisc6resFq5CBhu6T9x4Qj+IsvlevJPkSXUXaq
	 uNKqMmGHztlg/y/5NsFxwYgV/UGrA58sV8G2chbRihh+Unoh3V0gjt5hljG0Nd7yN1+rU
	 wN/UrzhwEv10Qk9s7wXNk+/oEM8ugscF1BybLHYRxVAhQIgT48KLljS3EdBhhqqsmnFqP
	 9qgqTy8UNaKwXxWDGF63LGwm24ISJWXPNUTHn6trLnKtjzyfPnxVFGOIFBQqPDgy1/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=andrii.net;
	spf=pass smtp.mailfrom=andrii.net;
	dkim=pass header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=Ybc9KqKC;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC52606A338
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC52606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrii.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrii.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=Ybc9KqKC
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdab938dc83so2993728a12.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 19:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrii.net; s=gmail-2025; t=1795751008; x=1796355808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xv9HoU11wg50uyramdQYfq7Umn1TYxplpQtca+BOSaU=;
        b=Ybc9KqKCk7jo1UVGtMcMSXNl5D6Iv5/l8sju3YXqeQTNRm/5YodH9ulL687tR8jX9J
         RNcbHN7JcHIc3/B27m1Vq0ZcMXTQHkvlJ/qXBwVqMtd3ALUhgu3PFg9z4UJezju4fJU6
         do6AJWIbPOExmoybQVwMGQEQuxgwRdTdC9JT64QmtTw9kN5XrqcV3/9JyaUV2beswWZO
         9C/AscZ/PTtG3dhO+Hv5wLG5QW536vKo9KWytOH6SDoH0TbTA2nhK2z4Nsrt1qHYD9iy
         F28n4k94kejdNesvFVX0O88DQyhFpJXp9pv5YrhLbh0e89lFhQSKA/WzMlo2XkuzmYWR
         WEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795751008; x=1796355808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xv9HoU11wg50uyramdQYfq7Umn1TYxplpQtca+BOSaU=;
        b=Y91SR9besel8tqpvFYp3MHxQytMmSGfVuWWApKTns0gDPjb/VPUBX0nONa8pBHxaDT
         5Rz0MfkNwJdP19YW5qw4NTs06ZOnB/ffJdYvYMUpjWwHJsqxeowNI/63O6Ck0lcs0sTA
         cfUB8NezAG4Ywo6/xmhw+BaPDdJPRyfUo0WJKJZ/Pw++IX2lTJIGG5DgeFcnyyiN0wSt
         lYSSEZ0nPledTrgaRL2FbKFQ+DB3PmORP/fWl3jRC6/K0X+p7GLPRIR+QYguwL4MMCO8
         SzsRsDNKtjFYTgk+Tuiv6kLphEaTjXvajCiZkqYNI9LuhQ0AMdjWVD5qCpPHedmUYiQU
         cbfw==
X-Forwarded-Encrypted: i=1; AL+hErFboE+14/YpQjF9Tv4j+MfRSb/ZfhNOTJ3DdMQz8/A2Yho6qIMD1IRAFK8N0tYv7yGjcHWBmkU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+M1XqUioJaSqpWuvDZOVJ+16aGwAWnIpqqkHADFLRFKprIxfEx
	HMb/hIbOX+/CvtYxpbVKQp0qT6FXqG6/pWdyg2SIVuAB6WObWwJUBzGTk7ZlhOSNQOd3YTnXZG4
	d2eGwdQ2SyOakBF3/9b7TRsdyD5Hvuap6WHl85hSCARbKb7QiT6y9
X-Gm-Gg: AZFdTZdLTzAW/YTy1SrRN7Tku8u+4/1/EDoF8cdcSl//5qRypbgGwn+QQgNbdKPpW+g
	KCsygXDsBFb48sIBLG1O6DVvfpP1Ta6JuIZKIBfGb7VgwIcUhAewmf9ky7Cza0sz0RwplPkj1iY
	XRTc6wk/IJb4K316FcsSyXIzSGZK9YeK6NBrxw/DpnyuTfbfcOliD0xANz/oTgTIx4+WbMowG8S
	sQ+I+3vx8r7HzNqR4FsxaC9KgNwJzxee4uu0N0iUA14EAMnEX+NPvlamEZaN9pDAJgvZFIDfQkK
	Z5PM4rsSypW7E+dF6MZUHebd3Ynal9FNZRoM0P4z+dalxeNgRq7BppXWJe01GS63BJ990OCLSZ+
	Ax08pM87Pddg2NEFjrKq+XwskIIU=
X-Received: by 2002:a17:90a:e705:b0:3b4:fa3:36de with SMTP id 98e67ed59e1d1-3b41c9750e2mr20734881a91.51.1795751007623;
        Thu, 26 Nov 2026 19:43:27 -0800 (PST)
Received: from andrii.ai (mac.hestia.andrii.net. [2602:f337:ed:4865:7374:6961:204d:6163])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b405960cd1sm16387485a91.2.2026.11.26.19.43.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 19:43:27 -0800 (PST)
X-Relaying-Domain: andrii.net
From: Andrii Tereshchenko <opensource@andrii.net>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Christian Hopps <chopps@labn.net>,
	netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH ipsec v2] xfrm: iptfs: don't modify skbs it doesn't own when aggregating
Date: Thu, 26 Nov 2026 19:43:24 -0800
Message-ID: <d6f4d771-7235-460b-9a6d-dc2348a24f83@mid.andrii.net>
X-Mailer: git-send-email 2.56.0
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

iptfs_output_queued() aggregates inner packets into the first skb,
writing to its shared info and relinking frag_lists. But a first skb
can share those with someone else: a clone (the original TCP keeps
for retransmission), a frag_list shared without cloning (skb_cow(),
pskb_copy()), or a nested frag_list (conntrack). The result is memory
corruption, a CPU-hanging list cycle, or leaked skbs:

  skbuff: skb_over_panic: ... len:-340 put:-340 ...
   skb_copy+0xfc/0x180
   esp_output_head+0x38a/0xb40

Aggregate only into what IP-TFS owns: unclone the first skb, send a
first skb that has a frag_list on its own, and stop at a following
skb that has one. Nothing is un-nested any more, so
iptfs_rehome_fraglist() goes.

The two frag_list cases were found by an AI code review agent after
v1 was posted. The patch was written with an AI coding assistant and
reviewed by the submitter.

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
Link: https://lore.kernel.org/all/179171627713.434549.11629734394381610294@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Andrii Tereshchenko <opensource@andrii.net>
---
v2:
- Apply the frag_list rule to every skb that has one, not only to
  clones. v1 missed lists shared through skb_cow() or pskb_copy() and
  nested ones from conntrack. iptfs_rehome_fraglist() and the
  un-nesting loop are removed.
- The netdev AI review of v1 [1] reported the same gap and one more way
  into it: skb_checksum_help() in iptfs_first_skb() unclones the first
  skb before v1's check. Testing skb_has_frag_list() covers that too.
- v1 said that uncloning the first skb adds no copy. As that review
  showed, this was wrong when packets are aggregated: ESP's
  skb_cow_data() can then reallocate the head again. v2 does not change
  that cost.
- Drop v1's 2/2: Nguyen Ngoc Thang's same fix is upstream as
  b88c75488ecc ("xfrm: iptfs: force a dst reference before queueing
  an skb").
v1: https://lore.kernel.org/all/c1e999b5-15ee-468d-81c5-530a560e84df@mid.andrii.net/
[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/b56bbced-a8b0-4ae9-80b4-1958ea36684c%40mid.andrii.net
Affected: v6.14 and later (0e4fbf013fa5 first shipped in v6.14-rc1);
needs CONFIG_XFRM_IPTFS and an IP-TFS SA carrying aggregated traffic.
Mitigation until the fix lands: no IP-TFS SAs, or the xfrm_iptfs
module left unloaded (it is tristate).
Found: a production panic (the cloned head), then an AI coding
assistant review after v1 (the frag_list cases). Validated: a test
module driving the CHECKSUM_PARTIAL route, 50 of 50 rounds. Tested:
the private selftest (nested FAIL to PASS, shared hang to PASS) on
ipsec master 2803867cf3de, two boots each, panic_on_warn=1 on the
fixed kernel.

 net/xfrm/xfrm_iptfs.c | 61 ++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 0313a43aa8a97..c6bdfbd9a1a8b 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2139,27 +2139,6 @@ static int iptfs_first_skb(struct sk_buff **skbp, struct xfrm_iptfs_data *xtfs,
 	return iptfs_copy_create_frags(skbp, xtfs, mtu);
 }
 
-static struct sk_buff **iptfs_rehome_fraglist(struct sk_buff **nextp, struct sk_buff *child)
-{
-	u32 fllen = 0;
-
-	/* It might be possible to account for a frag list in addition to page
-	 * fragment if it's a valid state to be in. The page fragments size
-	 * should be kept as data_len so only the frag_list size is removed,
-	 * this must be done above as well.
-	 */
-	*nextp = skb_shinfo(child)->frag_list;
-	while (*nextp) {
-		fllen += (*nextp)->len;
-		nextp = &(*nextp)->next;
-	}
-	skb_frag_list_init(child);
-	child->len -= fllen;
-	child->data_len -= fllen;
-
-	return nextp;
-}
-
 static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
 {
 	struct skb_shared_info *fromi = skb_shinfo(from);
@@ -2234,6 +2213,21 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 		if (iptfs_first_skb(&skb, xtfs, mtu))
 			continue;
 
+		/* Aggregating writes to the first skb's shared info and, when
+		 * it has a frag_list, to the skbs on that list. A clone shares
+		 * its shared info with the original, e.g. the skb TCP keeps
+		 * for retransmission, so unclone it first. The skbs on a
+		 * frag_list can be shared with another skb whatever the first
+		 * skb is: pskb_copy() and uncloning share them, and the list
+		 * of a datagram that conntrack reassembled can nest. Send a
+		 * first skb that has a frag_list, or that we cannot unclone,
+		 * on its own.
+		 */
+		if (skb_has_frag_list(skb) || skb_unclone(skb, GFP_ATOMIC)) {
+			xfrm_output(NULL, skb);
+			continue;
+		}
+
 		/* If fragmentation was required the returned skb is the last
 		 * IPTFS fragment in the chain, and it's IPTFS header blkoff has
 		 * been set just past the end of the fragment data.
@@ -2246,18 +2240,8 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 		 */
 		remaining = mtu - (skb->len - sizeof(struct ip_iptfs_hdr));
 
-		/* Re-home (un-nest) nested fragment lists. We need to do this
-		 * b/c we will simply be appending any following aggregated
-		 * inner packets using the frag list.
-		 */
 		shi = skb_shinfo(skb);
 		nextp = &shi->frag_list;
-		while (*nextp) {
-			if (skb_has_frag_list(*nextp))
-				nextp = iptfs_rehome_fraglist(&(*nextp)->next, *nextp);
-			else
-				nextp = &(*nextp)->next;
-		}
 
 		if (shi->frag_list || skb_cloned(skb) || skb_shared(skb))
 			share_ok = false;
@@ -2273,6 +2257,13 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 			if (skb2->len > remaining)
 				break;
 
+			/* Appending would relink skb2's frag_list, which may
+			 * be shared. Leave skb2 to be sent on its own as the
+			 * next first skb.
+			 */
+			if (skb_has_frag_list(skb2))
+				break;
+
 			__skb_unlink(skb2, list);
 
 			/* Consider the buffer Tx'd and no longer owned */
@@ -2292,10 +2283,13 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 			/* skb->pp_recycle is passed to __skb_flag_unref for all
 			 * frag pages so we can only share pages with skb's who
 			 * match ourselves.
+			 *
+			 * iptfs_consume_frags() empties skb2's frags, which a
+			 * clone shares with its original.
 			 */
 			shi2 = skb_shinfo(skb2);
 			if (share_ok &&
-			    (shi2->frag_list ||
+			    (skb_cloned(skb2) ||
 			     (!skb2->head_frag && skb_headlen(skb)) ||
 			     skb->pp_recycle != skb2->pp_recycle ||
 			     skb_zcopy(skb2) ||
@@ -2315,9 +2309,6 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 				/* Append to the frag_list */
 				*nextp = skb2;
 				nextp = &skb2->next;
-				if (skb_has_frag_list(skb2))
-					nextp = iptfs_rehome_fraglist(nextp,
-								      skb2);
 				skb->truesize += skb2->truesize;
 			}
 		}

base-commit: 2803867cf3defa294710088a4663b434e12b5e93
-- 
2.53.0

