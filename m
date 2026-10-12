Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1E4766A9
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807786; cv=none; b=qYc+bE4WcO9Ri5D8QOjizjeW/q0Et3EXJw1oBHWHAlZzXjsQOUZUPhx72tkO3+j/E3ZXmAbs7aMFv0hrXwphKpM68+EZ/K2+UNq5ezagLvoIL1AgHEMEbj3ldBiEEp16loMceaR07QSvk1tlHOFUFL4n1ydtNlPbboMQtAsHzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807786; c=relaxed/simple;
	bh=WyIMc5JSO30DllUbZ36PY1LD+B5nLX52l1tPPrXA2qY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NGVGK5iMDJuDbqsN9yXz2wxwR089nNENleIXRR+FPaQ5KYHBloRVqZCTm0mUsdz7liexJz8fdAI4+50YvDda3ioieqZNu2SelHTJT6C+CR79nKTX/fyS+q8KAu1RW9CXvWOVcoQg7JWgx7yiSlSQxjyQgk50Aej47dBOkKB2wEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uc+TwMBi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uc+TwMBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65971F0089B;
	Mon, 12 Oct 2026 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791807785;
	bh=8XDro3H3ImpmeXSVJqZRv0+Wf5TB5m1o1c6o1dNhhpw=;
	h=Subject:To:Cc:From:Date;
	b=uc+TwMBizwcIR51PeqXMna3a0iUVTVxEJxwFsP/OU1Ma0d0PGY0oyFAwqKprSyJCJ
	 pXw44fNjyATeX+N5u3Tf4MmjuXTNtT/+uTnzTU+oMhYU1cyrmUHfOpog84WG8ZREOf
	 fCz0PuatqN0feibPNaSsk/8lhm19+kPKquRHYqfA=
Subject: FAILED: patch "[PATCH] wireguard: queueing: preserve tstamp_type when encapsulating" failed to apply to 6.1-stable tree
To: ramses@well-founded.dev,Jason@zx2c4.com,edumazet@google.com,kuba@kernel.org,toke@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 14:20:38 +0200
Message-ID: <2026101238-ooze-falcon-33a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 65ab9de4bdd4c05d8277cfc20ae0b9f5aff60897
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101238-ooze-falcon-33a5@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65ab9de4bdd4c05d8277cfc20ae0b9f5aff60897 Mon Sep 17 00:00:00 2001
From: Ramses de Norre <ramses@well-founded.dev>
Date: Thu, 8 Oct 2026 14:59:15 +0200
Subject: [PATCH] wireguard: queueing: preserve tstamp_type when encapsulating
 packet
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sending traffic through a wireguard tunnel on a host using the fq
qdisc fills the log with:

  fq: likely mono tstamp with tstamp_type 0

An skb carries a timestamp in skb->tstamp and, separately, a
skb->tstamp_type field recording which clock that timestamp came from.
The two have to agree.

When wireguard encapsulates a packet it calls wg_reset_packet(), which
clears the fields that must not leak from the inner packet into the
tunnel packet. It does so in two steps:

  skb_scrub_packet(skb, true);
  memset(&skb->headers, 0, sizeof(skb->headers));

skb_scrub_packet() deliberately keeps skb->tstamp when it holds a
monotonic timestamp: that value is the time the packet is scheduled to
be sent, and the qdisc still needs it. The memset then zeroes
skb->tstamp_type, because that field sits inside the headers group
while skb->tstamp does not. The packet therefore leaves wireguard
carrying a monotonic timestamp labelled as a realtime one.

Nothing noticed until commit c4f796c4f16b ("net_sched: sch_fq: convert
skb->tstamp if not monotonic"): fq used to assume every timestamp was
monotonic. It now consults tstamp_type, spots the mismatch, warns, and
falls back to treating the value as monotonic. Pacing still ends up
correct, so the log spam is the actual problem.

Save tstamp_type before the memset and restore it when encapsulating,
next to the hash fields that are already carried over this way. When
decapsulating it stays zeroed, which is right: an incoming packet's
timestamp is a realtime receive timestamp.

Fixes: d98d58a00261 ("net: Set skb->mono_delivery_time and clear it after sch_handle_ingress()")
Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
Reviewed-by: Toke Høiland-Jørgensen <toke@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Link: https://patch.msgid.link/20261008130124.724119-3-Jason@zx2c4.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 79b6d70de236..663b19b78395 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -78,12 +78,14 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
 	u8 l4_hash = skb->l4_hash;
 	u8 sw_hash = skb->sw_hash;
 	u32 hash = skb->hash;
+	u8 tstamp_type = skb->tstamp_type;
 	skb_scrub_packet(skb, true);
 	memset(&skb->headers, 0, sizeof(skb->headers));
 	if (encapsulating) {
 		skb->l4_hash = l4_hash;
 		skb->sw_hash = sw_hash;
 		skb->hash = hash;
+		skb->tstamp_type = tstamp_type;
 	}
 	skb->queue_mapping = 0;
 	skb->nohdr = 0;

