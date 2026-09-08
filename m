Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785749E5DE
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888794; cv=none; b=UGDEi49UPvmM7E/FF9TVlLsvRI8dTP2INZtAOYVsVo4CupYm6/JFIYhIQU/Vtss8oJBNbaRLi108F+d7RyancUy6jjOW3e1lKhpsgTrsDfqumCzVucjc0tR+AEmWLzayYk6HE8t4fKEtOa5SpN5EswVnjiB3ANzhwNb3+P1TujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888794; c=relaxed/simple;
	bh=pgK1BuqFcbPqYRX+LC4apJeUcNoED+V7k1VNEi2CDCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiX0CH5J20LWhHShVSX6dH1/eFQbSav7HuxGnmLyrDZ49CQ7XPE618OiuK5bsuKQZYi9dYepizl6wH5AZoMm3R6dDRe5iLgx0RKzWZTC6UyeaRqrlh9NdWXPXKHHqxv9SpuXi+CzpnjbYh8zKj2nVqWJ5kiXjrHK0+QlYhCVv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYT0evrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYT0evrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EB81F00A3E;
	Tue,  8 Sep 2026 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888793;
	bh=g5wHepAmSsPfMM6Td/7NnbSsW117x/kgSmJ832TjQX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CYT0evrmekeKXCZbL8YEKo/FgurujwFEWA0g7yQ5CVwYQ7tC+A7lF7sZLcGYuYHUW
	 sbFRCStNFMBUynSM4galv6yGo1UCy9JB8bEBXs3PQaVO4lgqOeWtZLvp/zak0gYpW0
	 Lt6nIhOG6wwzvR3yzh8cfp0dnZb1C8J3rIQ5NiPkkO28j+up+VEcrjKIKbRK4XhApq
	 0S1TVEUf3y34BJfxP2ejP8L/4swlEp2GVGPdupjRz3jjj/PFi4kl7eJXj3Wq/uI/rZ
	 W+NiwXbzKznIqIwZ+mA+99Sr+fW3oQH/akiWt3qQKMxwuTW00BtwuqkEjJTcTYd7SS
	 zw3OKYENO/Huw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Danilov <littlesmilingcloud@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] ipip: fix skb leak in collect_md mode when metadata_dst allocation fails
Date: Tue,  8 Sep 2026 13:33:09 -0400
Message-ID: <20260908173309.106466-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908173309.106466-1-sashal@kernel.org>
References: <2026090359-hurry-disagree-2db4@gregkh>
 <20260908173309.106466-1-sashal@kernel.org>
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
index d22d8e5f4abc1..3ec9553436930 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -240,7 +240,7 @@ static int ipip_tunnel_rcv(struct sk_buff *skb, u8 ipproto)
 		if (tunnel->collect_md) {
 			tun_dst = ip_tun_rx_dst(skb, 0, 0, 0);
 			if (!tun_dst)
-				return 0;
+				goto drop;
 		}
 		skb_reset_mac_header(skb);
 
-- 
2.53.0

