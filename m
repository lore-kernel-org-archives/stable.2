Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B5035C6BE
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889282; cv=none; b=LXeRF3MISSn8ofbZPRoA+g0IHu7NxO71GMqyGt2MZZ5LhkzFANRQpfPb9Mp6JfbtjJDridBVKPt8o/jdbxD1WmEcap6skEY8YagtqolXurGXhFC6H6zCCwTfWMJDfy1qOukNCYFaYcT9/M5b5sSbawYW7NOCu2G8WNIA4oYhmBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889282; c=relaxed/simple;
	bh=F+6WQzKtvl7lwMfV2Eel0bV0rq5jcPHUpaN0GemaUIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+tn4MEcJu3N7fjKGAPu3uHt1B5lOw/eGMXBTD5Bi6gitql/S0qO1ZuGWSlKa89eg41HGJ5clD/c+7f7XKWpnGO9sRPXVFlg/7Fmf0pLdt/Rlo6uGnI8c+q2wcDdr8CVQWidfxhcN70c0a1gZJtHkT83fbbicReU0+FIagtdUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqLRsMlP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqLRsMlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A701F00A3F;
	Tue,  8 Sep 2026 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788889280;
	bh=QKbk5o7pFXARCatRZ3YWFg20rypvq5gGSCS/SFr7UNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eqLRsMlP6q1XTOuRllVR7vzsuw6FUjIqBdr2SPPvduOAVHwCWAVq6B5iyH6Kyc/Um
	 48j/ozBRh/8EXRlpHKOwd2yfr2IASuiWKAAOxpztI61RrzOiYyDuYcWkB2fclqITRP
	 b2acWVyupBMiJQwFRN9ul+ukWFsIYKvQbTq3XfdbRAyF+iL9BslLLot7hu/ynqqBre
	 rN4HDch7Yl6ZOyX3NHVcDHa2wQp1C1+1GnWaQ+/8L0biJHly7IcHiWrH0UJlFF1Zls
	 f8+9G27QjrqBaoouSiGhKalDeXO9eosHHz2aGMJ3PRhpOHlK9z0dKccjMirYWnvWF6
	 smF+mn77QHAOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Danilov <littlesmilingcloud@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] ipip: fix skb leak in collect_md mode when metadata_dst allocation fails
Date: Tue,  8 Sep 2026 13:41:16 -0400
Message-ID: <20260908174116.123019-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908174116.123019-1-sashal@kernel.org>
References: <2026090359-reflux-womanly-dd73@gregkh>
 <20260908174116.123019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anton Danilov <littlesmilingcloud@gmail.com>

[ Upstream commit 6776efe4a52f289a3fc18f8adf19b035a7d8e1bb ]

In collect_md mode ipip_tunnel_rcv() returns 0 without freeing the skb
when ip_tun_rx_dst() fails to allocate the metadata_dst. ipip_rcv() and
mplsip_rcv() are registered as xfrm_tunnel handlers, so tunnel4_rcv()
and tunnelmpls4_rcv() read the zero return as "the packet has been
consumed" and do not free it either. The skb is leaked.

The other tunnel drivers all dispose of the packet at this point:
ip6_tunnel.c jumps to its drop label, ip_gre.c and ip6_gre.c return
PACKET_REJECT, which makes gre_rcv() free the skb. Only ipip returns 0.

Jump to the existing drop label instead. It frees the skb and still
returns 0, so the packet keeps being reported as consumed, which is what
we want here: the outer header has already been pulled, and neither the
remaining handlers nor an ICMP unreachable have any use for it.

Triggering this needs an ipip or mplsip tunnel in collect_md mode and an
atomic allocation failure, which is why it has gone unnoticed.

Fixes: cfc7381b3002 ("ip_tunnel: add collect_md mode to IPIP tunnel")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Link: https://patch.msgid.link/20260819104338.432631-2-littlesmilingcloud@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted the failure path around the older ip_tun_rx_dst() call to use the existing drop label. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 714de14f0d889..b1d5d14816887 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -240,7 +240,7 @@ static int ipip_tunnel_rcv(struct sk_buff *skb, u8 ipproto)
 		if (tunnel->collect_md) {
 			tun_dst = ip_tun_rx_dst(skb, 0, 0, 0);
 			if (!tun_dst)
-				return 0;
+				goto drop;
 		}
 		return ip_tunnel_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
 	}
-- 
2.53.0

