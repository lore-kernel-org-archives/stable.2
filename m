Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477EC44B663;
	Fri, 21 Aug 2026 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306309; cv=none; b=lzGRMPDIJDMkB/1QMiYAY1gZ8w/r20FNnGOduqlxtvQC+kXQXk9fItagD+SeDyQynT6ejeb8ucYwTK/odXtLdh4I5FRt7HKY8P6lAYuAoGLG0eSojVsV/n8XCZiTbLXzlr046ewvZOmm7KBED0j6NMzp8Xo2C7NLKjBmdJUlzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306309; c=relaxed/simple;
	bh=4GHkMNhoIcuA6kuWYZ5jUDWk39e+tdOTeLa5C6CSZJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGyOabsC4piaU6mkD3lRY7K3OTZgwTVBAgvMZT1IPSksuYcz3DEmEGqsqg5UFnvoXZNjNMU3a7tB9/KAbN/pnnrKMei7jxv1jOeNRrMTeOL1h2+xOKiJyQjgKfnZvXSCcviLla+ftKdIt5JvnsRbfq4jRwBwr4wkDhWSTmyrBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=RP1zouhO; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="RP1zouhO"
Received: from kero.packetmixer.de (p200300C59714FCd8eC8c87C354003feD.dip0.t-ipconnect.de [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 6355DFA116;
	Fri, 21 Aug 2026 11:48:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdutJj0NeCuOQVhmoP4O60XEo/9t+zQrQe/6al6JIHw=;
	b=RP1zouhO4/HDyEzyjo7l0TSLrfTujCuL1i+GZjLh5IlShbRU7xbcwacnOQMKbvkXZks1Kg
	nd+R2a20sh91UmkWQG6eMLLzPP7U27dydiOSarzvZHosLBN4lQRLccHK/6Hbejfcdxl1BW
	jXy+0ldA2y+Vn8hUDI8j4JfqNNfqLRa2x1RWt0DrNMmHNgPS+0m9Cc2Pf46t4zHDiUeDMD
	dn7ZHUzL0q1qBdAE8f6aTChiXp7Thio9xfdMB7XyZU02oizMyMdWNEVlZVmIw07svpaPpu
	PJMeJJDIXqB3ScAH+jrZdTkbh3uvDqcMoN7/mN7F+P7yJphw1Ms/WmlIgBUMyg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 4/9] batman-adv: dat: avoid unaligned fault in IP extraction
Date: Fri, 21 Aug 2026 11:48:08 +0200
Message-ID: <20260821094813.201800-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821094813.201800-1-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

Independent of the alignment of the ARP packet in the SKB, either the
batadv_arp_ip_src or the batadv_arp_ip_dst will have an unaligned access
(on HW without native unaligned read support).

Use get_unaligned() to handle this properly on all architectures.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 5c3a0e553593 ("batman-adv: Distributed ARP Table - add ARP parsing functions")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0d5a9cb0affeb..76fd23db926c7 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -316,7 +316,10 @@ static u8 *batadv_arp_hw_src(struct sk_buff *skb, int hdr_size)
  */
 static __be32 batadv_arp_ip_src(struct sk_buff *skb, int hdr_size)
 {
-	return *(__force __be32 *)(batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN);
+	u8 *src = batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN;
+	__be32 *ip = (__force __be32 *)src;
+
+	return get_unaligned(ip);
 }
 
 /**
@@ -341,8 +344,9 @@ static u8 *batadv_arp_hw_dst(struct sk_buff *skb, int hdr_size)
 static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 {
 	u8 *dst = batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN * 2 + 4;
+	__be32 *ip = (__force __be32 *)dst;
 
-	return *(__force __be32 *)dst;
+	return get_unaligned(ip);
 }
 
 /**
-- 
2.47.3

