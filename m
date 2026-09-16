Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29949388E58
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890091; cv=none; b=jiuPZDpliHDoLmRKFDUwvBzE3ygidynxID4BxpO3qQ7Il6SVoxl2TElDYmn/A0hBe3Abx6TFphgI20Lu5hhSSk1iuUvz+OzIYq0pzBbV4EEfEi0a8IpnCfxFvGfHQRzMrdJtiWwjhI/zsWRrk+R9HzRlngYNsbS/e7a/Sn5LsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890091; c=relaxed/simple;
	bh=c4o9uPcSRAvzb80Ft2JVIWMtMqCxVLaSqy/MjuZ/4ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suEVqWwBEvtzsVFfvHUQ2P0yetxZxz2PKHnLw354oq6CmUlB9+EIM4xQcCs22zYjhQra2eSWo9cZyF8QllRuxLAA/A02fjoLWSz3+k8F+nGtAk8B2nGcmi80wn79c1udWGlLN7jNkMBgOpVyuYVYOX2hi5c62+24PzLr+YC0jOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=wQCDhzhJ; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="wQCDhzhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=wQCDhzhJNUelsH7e0vWSvVhE5ijxpvsnLFaC9wfH5YbGidxmbydlQLuUy6D+Lu4bpMr26oh3Gdzgd
	 4Fuphl4ZLschLFiPytDkpV4r+K2LEXmZDlnUrflvmG/51cbtZOaiD/6aeEU+/d2UR03GqmEZbJ2Cjm
	 Cbffe3zDNiEaaxp4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86aaf8d64ca2-d9cbe;
	Sun, 20 Sep 2026 15:38:14 +0800 (CST)
X-RM-TRANSID:2ee86aaf8d64ca2-d9cbe
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.102])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26aaf8d63e0a-80a49;
	Sun, 20 Sep 2026 15:38:14 +0800 (CST)
X-RM-TRANSID:2ee26aaf8d63e0a-80a49
From: lvjunyu <lvjunyu@cmss.chinamobile.com>
To: lvjunyu@cmss.chinamobile.com
Cc: stable@vger.kernel.org
Subject: [PATCH] netfilter: nf_nat: Fix stale outer UDP checksum on VXLAN encapsulated packets
Date: Wed, 16 Sep 2026 16:12:17 +0800
Message-ID: <20260916081217.522624-1-lvjunyu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When MASQUERADE --random-fully rewrites the outer UDP source port of a
VXLAN-encapsulated packet whose inner header has CHECKSUM_PARTIAL, the
outer UDP checksum is not updated.  inet_proto_csum_replace2() is a
no-op for CHECKSUM_PARTIAL skb's, so the stale checksum causes remote
VTEP to drop the first packet (UdpInCsumErrors) until a ~1s SYN
retransmission.

Add an explicit csum_replace2() call to update the outer UDP checksum
when the skb is encapsulated, has CHECKSUM_PARTIAL, and is not GSO
(hardware offload handles the non-encapsulated case).

Test results (10 connections, single netns vxlan + veth environment):
  Before fix: ~1080ms avg first-connection latency, 10 SYN retransmits,
              UdpInCsumErrors incremented per connection
  After fix:  ~29ms avg first-connection latency, 0 SYN retransmits,
              UdpInCsumErrors unchanged

Fixes: faec18dbb0405 ("netfilter: nat: remove l4proto->manip_pkt")
Cc: stable@vger.kernel.org
Signed-off-by: lvjunyu <lvjunyu@cmss.chinamobile.com>
---
 net/netfilter/nf_nat_proto.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/netfilter/nf_nat_proto.c b/net/netfilter/nf_nat_proto.c
index 64b9bac228e..35cc6e10b5b 100644
--- a/net/netfilter/nf_nat_proto.c
+++ b/net/netfilter/nf_nat_proto.c
@@ -57,6 +57,20 @@ __udp_manip_pkt(struct sk_buff *skb,
 		nf_csum_update(skb, iphdroff, &hdr->check, tuple, maniptype);
 		inet_proto_csum_replace2(&hdr->check, skb, *portptr, newport,
 					 false);
+		/* For CHECKSUM_PARTIAL encapsulated non-GSO packets,
+		 * inet_proto_csum_replace2() above is a no-op because the
+		 * port field is data, not pseudo-header. The outer uh->check
+		 * was computed by udp_set_csum() with a temporary sport, and
+		 * the subsequent NAT sport rewrite leaves it stale. On devices
+		 * without hw_enc_features, the software fallback
+		 * skb_checksum_help() honors csum_start which points at the
+		 * inner transport header and only recomputes the inner
+		 * checksum. The stale outer checksum goes out and the
+		 * receiver drops the packet with UdpInCsumErrors.
+		 */
+		if (skb->ip_summed == CHECKSUM_PARTIAL &&
+		    skb->encapsulation && !skb_is_gso(skb))
+			csum_replace2(&hdr->check, *portptr, newport);
 		if (!hdr->check)
 			hdr->check = CSUM_MANGLED_0;
 	}
-- 
2.43.0



