Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617537;
	b=wmjenSnoP0Vz8mWUByHfKHxpP9ZBa9BialLMc8djh7ahs9Wabwy6rXRvtrM6HfimM1Fi
	 beVc4X/S43ttNqK7+dzrvmOjoTWBkOe2TszNRX4YoZBRIN7lT5gkXipu+IVW5NgIWktq4
	 e0H3Q55MgqRYlOZxKsbiuSw79Gz4q3svmp5qNR8NvNqdpDRHZyD5usv4eF6OY2XCTTirT
	 I+KknslAX8+GThixJAxdgJYFCJ+bHtDnC9Du62lrTi4YnP03MdhN6FaeFKgTkGAM4YRtm
	 UBMt+TTuXIBJlxJ39JMUEDiBtVR+EWWcJrhjTLWLxO9sXXjIRibMnpS7txrlar4L00Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617537;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PFpdKkGx1COzx30VD31Htes3d68SOzYlmTVDc/xRoS0=;
	b=vVFGieiwPvwUle+kElNraGVA6LX3CrKTYhEW2rKW9bo8Dm1frhjy3QQc6NjY833Kj/a9
	 sorkNnIrBh989j+aWcIhkYjVB8A/SvqK/t7q8PmS7eGDE5QLggpxc+/m6icgyMtILzDqQ
	 BmzHyGuXCOwmREYt3a2womLroWP3pDZrXhJWsEy8kgun+df3CE4iKmGkoiymtHKLFLpHr
	 g4J5KV6N33LTOshOvXmPpUvhMhDs2N6WEIflJIgYonW9xQ4YOS5DBf953p9Wiozu/tSEH
	 /nkN+zmpBBJ65W0y8Oo0hFrQKpKezRznyZciqF1TwyWOXg5WX51sLmmS2TSLi9VgmNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSChKAq2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C949606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSChKAq2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1811F000C6;
	Wed, 25 Nov 2026 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617537;
	bh=PFpdKkGx1COzx30VD31Htes3d68SOzYlmTVDc/xRoS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SSChKAq27ZyK2Q+i6dJSOgHqdRH/AqkKLH1tUl/f8r4wdA2BxDbnYmqFJiDTZuVV1
	 E4SMOQSZvAbbe77bRxOKsNHsQinhbDbbggKeNT+oWWKoOtT46ImN5cNsx+f6The3uc
	 Ob1s6LlLyHfUd/ku0lzb0Q0Z0keU2ufUV79Ju//lL29KSGpPQTI4PcXj5+XD6fnn32
	 4t/nwWA5fRNXwhNzbYGTQ+X8R/Jd/wJJq+qa/f5cxb312tblPAUyEGNhmugTt5Xd+S
	 xw65FJyGrN2bBUds4Y6ny2TpLYRoQ9N6XcICjziJc4Ou3PnoaJEPcesBdCwiM1ypLq
	 Ph41ZAgsPuq9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] tcp: use BIT() macro in include/net/tcp.h
Date: Wed, 25 Nov 2026 09:38:52 -0500
Message-ID: <20261125143848.4131839-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112553-cresting-chimp-b365@gregkh>
References: <2026112553-cresting-chimp-b365@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

[ Upstream commit 0114a91da67263c56612ff19a6aa0992466e7756 ]

Use BIT() macro for TCP flags field and TCP congestion control
flags that will be used by the congestion control algorithm.

No functional changes.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Ilpo Järvinen <ij@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1c46780dec48 ("tcp: do not coalesce segments after FIN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 23f619a1b41a6..ba8748976259a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -26,6 +26,7 @@
 #include <linux/kref.h>
 #include <linux/ktime.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/bits.h>
 
 #include <net/inet_connection_sock.h>
 #include <net/inet_timewait_sock.h>
@@ -911,14 +912,14 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 
 #define tcp_flag_byte(th) (((u_int8_t *)th)[13])
 
-#define TCPHDR_FIN 0x01
-#define TCPHDR_SYN 0x02
-#define TCPHDR_RST 0x04
-#define TCPHDR_PSH 0x08
-#define TCPHDR_ACK 0x10
-#define TCPHDR_URG 0x20
-#define TCPHDR_ECE 0x40
-#define TCPHDR_CWR 0x80
+#define TCPHDR_FIN	BIT(0)
+#define TCPHDR_SYN	BIT(1)
+#define TCPHDR_RST	BIT(2)
+#define TCPHDR_PSH	BIT(3)
+#define TCPHDR_ACK	BIT(4)
+#define TCPHDR_URG	BIT(5)
+#define TCPHDR_ECE	BIT(6)
+#define TCPHDR_CWR	BIT(7)
 
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
@@ -1110,9 +1111,9 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CA_UNSPEC	0
 
 /* Algorithm can be set on socket without CAP_NET_ADMIN privileges */
-#define TCP_CONG_NON_RESTRICTED 0x1
+#define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
-#define TCP_CONG_NEEDS_ECN	0x2
+#define TCP_CONG_NEEDS_ECN		BIT(1)
 #define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
 
 union tcp_cc_info;
-- 
2.53.0

