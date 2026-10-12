Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55E35295C
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845467; cv=none; b=jIYDIReH367sc41ered7XdbbK/4ET55sunCIWoufN5NZn/j6a4LNhxKKrFMDIeDv+63m4GicfQ7P+w5zKNSzsC6+LLIKpgZHvo+aQyv5AKGAJPXZ2dT0sD7AkML8Bx8Ehtps8+enzgJ/Q1q8CYE9f7NYWlSp5K1KY2GlAMwQ0/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845467; c=relaxed/simple;
	bh=oNgTNlaCb29RA1kHJDvBokelvghhQEzGl9qbu/4yehE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osvhWCAwAecsURjJYQZqXzwrIgRhynX/ilCpRzwLORwoeVBIcYH+jinomDfCSdtmjbXzUkCK2wq0o9ahmbdAFamjq2GQqhnqdnrT/fY4E7ysKES0iaI2LGgiypjDt6jFbjjglVIkoOOAnG9hDs6rnm0JZjLEakPHUyCw9A2zGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4+Fsx8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4+Fsx8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1165A1F0089B;
	Mon, 12 Oct 2026 22:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791845465;
	bh=sk+Wqkx8rxsjvPCJKXvVPjYvRQS6T33eclU49VyKgVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y4+Fsx8KdV3o2YffGMie31zsGgZNVtt/r0Hy+VRZAlW8WpoJlOsigkxCVGDNxIkYp
	 HWc+RFiArmx2T4PUqcyPTJhQAehmAavU47fgs0/c/nxhbyID99XW99Brj/IFcqtoOo
	 FC1ShYdj+TV7VosiZLK+fhE6jRrX/XNAwFly33pqXb24gSHKysYyuLkvYIHihk9O2F
	 cIvTz7ynkKvom+7bBrJiXFQtfHzhw66wIKlWNePNhBHWrCsYfHW8k7bMPlOBV+FQ8Q
	 bXSvRRruVvxeRLXD5Cwj8LntQleWBKb08aBt0OIS8/jm9BWd4pZYFkfWaEx7Yoq0ir
	 C7iNwXokWgZZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ramses de Norre <ramses@well-founded.dev>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wireguard: queueing: preserve tstamp_type when encapsulating packet
Date: Mon, 12 Oct 2026 18:51:03 -0400
Message-ID: <20261012225048.1885547-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101238-ooze-falcon-33a5@gregkh>
References: <2026101238-ooze-falcon-33a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ramses de Norre <ramses@well-founded.dev>

[ Upstream commit 65ab9de4bdd4c05d8277cfc20ae0b9f5aff60897 ]

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
[ sashal: Replaced `skb->tstamp_type` with the older `skb->mono_delivery_time` field. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireguard/queueing.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 3ce70db9dd3fe..50ceff8d107ec 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -78,12 +78,14 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
 	u8 l4_hash = skb->l4_hash;
 	u8 sw_hash = skb->sw_hash;
 	u32 hash = skb->hash;
+	u8 mono_delivery_time = skb->mono_delivery_time;
 	skb_scrub_packet(skb, true);
 	memset(&skb->headers, 0, sizeof(skb->headers));
 	if (encapsulating) {
 		skb->l4_hash = l4_hash;
 		skb->sw_hash = sw_hash;
 		skb->hash = hash;
+		skb->mono_delivery_time = mono_delivery_time;
 	}
 	skb->queue_mapping = 0;
 	skb->nohdr = 0;
-- 
2.53.0

