Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234550;
	b=YL/a2M8qQf5q0GJpto/j2sWHUFbMpfR3KNYJstNy7p/yrQOP/kvuJn6qIMIJQDn8+pI0
	 BG3j8Dc0ZiLkcbykO7TCZGagFJvaC6PLWmGDtT9OkvuoDtqzI0mg/lm1IpB6EOyFqu3fu
	 axYl2Zuu1HHg1IAojGGrirjPRoK3oHWBUupEraXPKEtJN0eRE7+FdcvFm0F6loAf39ELx
	 GeppXx4Dd+Hcq9a0GR6rKJKrR/mT3F90QPXQ/o0g/NYHvdNI6ArTVZg8KhRtLrXCVT6Qc
	 uga9cGSteXBddhmBoLa4zKMP14eJSGUvJPL9FQzYN3Bs14ahxZO0vDiSSxmK/NmV9NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234550;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0L4n5IgIGbEUNpv5W+tbbEAqIhBBWRObE4cu9d+NthI=;
	b=KKJSYj4rtYgVDPo05zJs+g9VnjvZwvUeF3/H/VKDdVolpX0lrE8M8Q0Yf9UoxdcOMVk/
	 bERBdQ4Tp1NbRKHIeQCfXeylPOZW9OIHVaa5+v2+fq1xpalgss968g//HHsRiyJK1CG8b
	 Lf8GWLVCVW4Mb3ht4yJVcIRItyYDL9a3VlD+PfX/hqt9jsiINOAtvVx6ajxHOTw0uLfcW
	 /mrp329k5xpmfaKwHvKQaZra1mhX/5l63uS8ZxsmRcf2idIbGvKC3ZDGO8jBzCqEbPAsm
	 gSANwMk1AsRe4W4B8LmJ4BI41YyBAE6tnaFIuro8GqPYKS5/nDf3Xw2Rw4M1ajUuRlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=dGMIGHOk;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7B606A31C;
	Mon,  9 Nov 2026 14:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C7B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=dGMIGHOk
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 8634220B7168; Mon,  9 Nov 2026 06:29:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8634220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794234547;
	bh=0L4n5IgIGbEUNpv5W+tbbEAqIhBBWRObE4cu9d+NthI=;
	h=From:To:Cc:Subject:Date:From;
	b=dGMIGHOkJB6lmgTJctAabThtxtWgeUQ4hCWF3mwG4tO4doi5J1UNCKTjnph7rf+G2
	 WKivuroPCey6kIivmqj9B4aBLrywkOihLNwMK05ME4Iyt4khgRgEv2UghKMZW+Z+lv
	 12jIfDfgJ3WdWG0VhtMtgop4l/h9pROYgH3lpi9A=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: netdev@vger.kernel.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: mana: report RX checksum offload for IPv6
Date: Mon,  9 Nov 2026 09:28:56 -0500
Message-ID: <20261109142856.779955-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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

The hardware validates TCP and UDP checksums for both IPv4 and IPv6 and
reports the result in rx_tcp_csum_succeed and rx_udp_csum_succeed.
However, mana_rx_skb() also requires rx_iphdr_csum_succeed before it
sets CHECKSUM_UNNECESSARY. That bit is only set for IPv4 (since IPv6
has no header checksum), so IPv6 TCP and UDP traffic is always
checksummed again in software.

So, only look at the L4 result. For IPv4 this makes no material
difference since CHECKSUM_UNNECESSARY only covers the L4 checksum, and
ip_rcv_core() always verifies the IPv4 header checksum in software.

Between two Azure Standard_E16s_v6 VMs (VF enabled), IPv6 TCP and UDP
packets (including VXLAN over IPv6), now arrive with
CHECKSUM_UNNECESSARY instead of CHECKSUM_NONE, so GRO no longer
checksums them in software. Calls to __skb_gro_checksum_complete() on
the receiver during an 8 second iperf3 run:

                               before    after
  TCP/IPv4, 12.2 Gbps              23       28
  TCP/IPv6, 12.1 Gbps         8728419       25
  UDP/IPv6, 1.5 Gbps          1071380       20
  TCP/VXLAN/IPv6, 10.9 Gbps   7934373       18

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index e6d494df22e4..05bd4b4b8349 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2179,10 +2179,9 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 	skb_checksum_none_assert(skb);
 	skb_record_rx_queue(skb, rxq_idx);
 
-	if ((ndev->features & NETIF_F_RXCSUM) && cqe->rx_iphdr_csum_succeed) {
-		if (cqe->rx_tcp_csum_succeed || cqe->rx_udp_csum_succeed)
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-	}
+	if ((ndev->features & NETIF_F_RXCSUM) &&
+	    (cqe->rx_tcp_csum_succeed || cqe->rx_udp_csum_succeed))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	if (cqe->rx_hashtype != 0 && (ndev->features & NETIF_F_RXHASH)) {
 		if (cqe->rx_hashtype & MANA_HASH_L4)
-- 
2.56.0

