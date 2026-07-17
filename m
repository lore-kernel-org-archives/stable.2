Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0737BE86
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309383; cv=none; b=aksGD5REr6wr8IjuVKlzpAzDlmLq6sOokHGyNr9KMMMhJ5LcqUEFKtQDtyOkv7S6nOdUDUq13SLsP7xbveb9vggUHq/Y8eDLHPbCsJ6yITHOLUctQ6vdcf6rAUHmdcZga/oeRVm1oEi8gYUj1URlyHiiMkFQyGt+YH2oobJixc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309383; c=relaxed/simple;
	bh=Hp59I4ci1XIveCcpc+JjHglEfGZ4/KMyVFmh32DCp/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxsT+9biu6Nc7yExVookvDDNnqnETS2mStPYRXQMRPw4TvFzJKrYfteKeWu5iCvW0UJHyUL0O0Q6RSTn0x9cPbmczxq6GKfFzvl/IKexo5jLjiicR5tWMHFE43rQQ9+ervUqFEsgjGZiDjf49qYPCul4amqCjh8berEFAdgQy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BD/EF9vC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BD/EF9vC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=ZqtWkV/cWeDXjKLn4tB4B0G4I1O42BhYLe8DlWf5MnU=; b=BD/EF9vCIb7/22oLbXx7hjr/1D
	lHn29onodJZnKzBvz5k+mF+c5kZ4JxB2KaUHbV23CFMtMJjK50SyisTd8+E9fir0D/nY9v24fHkmF
	l04/B0MC9ocSHAU+r02dwWnWS56SZPz9kKVMps6qzDTrostzNYIdixRGrXC128nKYwu7XuK6t3JH4
	ACqkvQSz+WDWgWqU8jY/c+ehMnlZebjv2efsd5P7IVEqf9g/BmKB1fC+LIeRy/CkUsx0ZlUHAzDYH
	pZVkERYkUUKlpnnreNXwgkqUO7rfxCUZglDLBwcUgcs1RE/0FQSmF3AxxDblIOn3OphSVNSnLwROG
	nnkthwEg==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	kuniyu@amazon.com,
	kuniyu@google.com,
	Jakub Kicinski <kuba@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 1/9] net: dropreason: Gather SOCKET_ drop reasons.
Date: Fri, 17 Jul 2026 19:29:14 +0200
Message-ID: <20260717172922.3398851-2-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717172922.3398851-1-heiko@sntech.de>
References: <20260717172922.3398851-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 454d402481d45af79ee7eea7e64bce02bbbe9766 ]

The following patch adds a new drop reason starting with
the SOCKET_ prefix.

Let's gather the existing SOCKET_ reasons.

Note that the order is not part of uAPI.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250116053441.5758-2-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 include/net/dropreason-core.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 02e7be19b042..76311b3ebfc8 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -6,9 +6,10 @@
 #define DEFINE_DROP_REASON(FN, FNe)	\
 	FN(NOT_SPECIFIED)		\
 	FN(NO_SOCKET)			\
+	FN(SOCKET_FILTER)		\
+	FN(SOCKET_RCVBUFF)		\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
-	FN(SOCKET_FILTER)		\
 	FN(UDP_CSUM)			\
 	FN(NETFILTER_DROP)		\
 	FN(OTHERHOST)			\
@@ -18,7 +19,6 @@
 	FN(UNICAST_IN_L2_MULTICAST)	\
 	FN(XFRM_POLICY)			\
 	FN(IP_NOPROTO)			\
-	FN(SOCKET_RCVBUFF)		\
 	FN(PROTO_MEM)			\
 	FN(TCP_AUTH_HDR)		\
 	FN(TCP_MD5NOTFOUND)		\
@@ -124,12 +124,14 @@ enum skb_drop_reason {
 	 * 3) no valid child socket during 3WHS process
 	 */
 	SKB_DROP_REASON_NO_SOCKET,
+	/** @SKB_DROP_REASON_SOCKET_FILTER: dropped by socket filter */
+	SKB_DROP_REASON_SOCKET_FILTER,
+	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
+	SKB_DROP_REASON_SOCKET_RCVBUFF,
 	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
 	SKB_DROP_REASON_PKT_TOO_SMALL,
 	/** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
 	SKB_DROP_REASON_TCP_CSUM,
-	/** @SKB_DROP_REASON_SOCKET_FILTER: dropped by socket filter */
-	SKB_DROP_REASON_SOCKET_FILTER,
 	/** @SKB_DROP_REASON_UDP_CSUM: UDP checksum error */
 	SKB_DROP_REASON_UDP_CSUM,
 	/** @SKB_DROP_REASON_NETFILTER_DROP: dropped by netfilter */
@@ -160,8 +162,6 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_XFRM_POLICY,
 	/** @SKB_DROP_REASON_IP_NOPROTO: no support for IP protocol */
 	SKB_DROP_REASON_IP_NOPROTO,
-	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
-	SKB_DROP_REASON_SOCKET_RCVBUFF,
 	/**
 	 * @SKB_DROP_REASON_PROTO_MEM: proto memory limitation, such as
 	 * udp packet drop out of udp_memory_allocated.
-- 
2.53.0

