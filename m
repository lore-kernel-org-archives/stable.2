Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617539;
	b=MaYSGM09yd9iX8dgwZTfIewkVj1ovE7rFP0UCK8dU7J+Tj70doL+V3tmGRe2MMddoplP
	 +TgQeg3WoqHC/7uzn5xQrW+I95CNLLsi1BMl4rwlp3Hak3GpvpvQE0jR/X29gNLD9sXH2
	 mzhlPrjfHkfd2n9Wjeo4NSQewKkAg4JSl+uUB38/U0gjARCKZ1jizj5BMKrR6I8Fr5gvd
	 bayuZaaIAJv3YXTu7nm4xp1wLPvQ7FYmP7teZ22xsMSLuWWUSqEMzHfKTY36Ymn8zh6rF
	 4fx+SFGRzLLKvRrgNxH4r0HReSvDxwFWJDUqz0hSa93KIyGV6jJq2qw5B4Vw3j/Mrdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617539;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R8iHpmRF+gmBvFYBoEnaZkxwv/TMu2NVCXszbwsDrQk=;
	b=HK7TLyrIZ7pGtPDQKTpEJIm0kY6tD7kRKG4cCZSwtfwkrhZhUDbrgYVh6eDtO2oG7ZT1
	 ERiNRox3bHuycRwtk48B6nRmgILohad3qUMcPpusGWAxLyIu8+V7ZGDq8vg+6UvdBCg+3
	 vQtJH0XwOS9YrFz8b+2bazNk97+V16ZsVlwUCCWlYKSXYh0D+ijxDdBsrdcZ0BtbsJN3B
	 1Xp8Br3FjDzMi1YLAeHbVwJDfL2kUwEOjd1gN6U6LyuzKPM8NPedsPfDBqB/VA5Qp16Jt
	 B/WwONZRWPpGjdsJ3HDi+AY4N/3HynhT31H9yry/0IMqOe/L60omnaDQn/MRYAkgAPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLmqo3yC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D36606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLmqo3yC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3241F000E1;
	Wed, 25 Nov 2026 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617538;
	bh=R8iHpmRF+gmBvFYBoEnaZkxwv/TMu2NVCXszbwsDrQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TLmqo3yCexGuuXoPEvxrjH2npPhVARkGYP9UvHaqOh19WatScSZi27KgR/FlXsoso
	 oDBYRjecce8MbBVz6/+VxsMcMm33tM8owZy4Lw3hnjAjMbbNCiuiOSeSVy9uOT3XuD
	 YjPNapA0rOg8usQ7fhvv3sJAar32Xmj0JEx9FnnxexMuTFMtWldxQOcK5shT4xgUDW
	 /9rCIYwIWv1dER3CYGXiIBFrtNQ6zAOYAsphe4WXy7/UWD034iD1KzjRRpLPGxv3Yd
	 HRr3MwQLQWNSCEWfu6HO474s9+Fv1UQdF5LQqz3VdtvI3N/0aTk4r6eIrZnvt81EI9
	 sYIzni2Rri1eQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] tcp: extend TCP flags to allow AE bit/ACE field
Date: Wed, 25 Nov 2026 09:38:53 -0500
Message-ID: <20261125143848.4131839-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125143848.4131839-1-sashal@kernel.org>
References: <2026112553-cresting-chimp-b365@gregkh>
 <20261125143848.4131839-1-sashal@kernel.org>
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

From: Ilpo Järvinen <ij@kernel.org>

[ Upstream commit 2c2f08d31d2f6cd5621b121d596986bd54da679a ]

With AccECN, there's one additional TCP flag to be used (AE)
and ACE field that overloads the definition of AE, CWR, and
ECE flags. As tcp_flags was previously only 1 byte, the
byte-order stuff needs to be added to it's handling.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1c46780dec48 ("tcp: do not coalesce segments after FIN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h             | 11 +++++++++--
 include/uapi/linux/tcp.h      |  9 ++++++---
 net/ipv4/tcp_ipv4.c           |  2 +-
 net/ipv4/tcp_output.c         |  8 ++++----
 net/ipv6/tcp_ipv6.c           |  2 +-
 net/netfilter/nf_log_syslog.c |  8 +++++---
 6 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ba8748976259a..f15ed41473016 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -920,7 +920,14 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 #define TCPHDR_URG	BIT(5)
 #define TCPHDR_ECE	BIT(6)
 #define TCPHDR_CWR	BIT(7)
-
+#define TCPHDR_AE	BIT(8)
+#define TCPHDR_FLAGS_MASK (TCPHDR_FIN | TCPHDR_SYN | TCPHDR_RST | \
+			   TCPHDR_PSH | TCPHDR_ACK | TCPHDR_URG | \
+			   TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
+#define tcp_flags_ntohs(th) (ntohs(*(__be16 *)&tcp_flag_word(th)) & \
+			    TCPHDR_FLAGS_MASK)
+
+#define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
 /* State flags for sacked in struct tcp_skb_cb */
@@ -958,7 +965,7 @@ struct tcp_skb_cb {
 			u16	tcp_gso_size;
 		};
 	};
-	__u8		tcp_flags;	/* TCP header flags. (tcp[13])	*/
+	__u16		tcp_flags;	/* TCP header flags (tcp[12-13])*/
 
 	__u8		sacked;		/* State flags for SACK.	*/
 	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dbf896f3146c5..3fe08d7dddaf7 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -28,7 +28,8 @@ struct tcphdr {
 	__be32	seq;
 	__be32	ack_seq;
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-	__u16	res1:4,
+	__u16	ae:1,
+		res1:3,
 		doff:4,
 		fin:1,
 		syn:1,
@@ -40,7 +41,8 @@ struct tcphdr {
 		cwr:1;
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	__u16	doff:4,
-		res1:4,
+		res1:3,
+		ae:1,
 		cwr:1,
 		ece:1,
 		urg:1,
@@ -70,6 +72,7 @@ union tcp_word_hdr {
 #define tcp_flag_word(tp) (((union tcp_word_hdr *)(tp))->words[3])
 
 enum {
+	TCP_FLAG_AE  = __constant_cpu_to_be32(0x01000000),
 	TCP_FLAG_CWR = __constant_cpu_to_be32(0x00800000),
 	TCP_FLAG_ECE = __constant_cpu_to_be32(0x00400000),
 	TCP_FLAG_URG = __constant_cpu_to_be32(0x00200000),
@@ -78,7 +81,7 @@ enum {
 	TCP_FLAG_RST = __constant_cpu_to_be32(0x00040000),
 	TCP_FLAG_SYN = __constant_cpu_to_be32(0x00020000),
 	TCP_FLAG_FIN = __constant_cpu_to_be32(0x00010000),
-	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0F000000),
+	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0E000000),
 	TCP_DATA_OFFSET = __constant_cpu_to_be32(0xF0000000)
 };
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 293a3b2bdd9e3..f0dcfa5af7fc4 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2167,7 +2167,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
 				    skb->len - th->doff * 4);
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
-	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
+	TCP_SKB_CB(skb)->tcp_flags = tcp_flags_ntohs(th);
 	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
 	TCP_SKB_CB(skb)->sacked	 = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index eadf5956a79df..b19b2f4eda242 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -403,7 +403,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 /* Constructs common control bits of non-data skb. If SYN/FIN is present,
  * auto increment end seqno.
  */
-static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u8 flags)
+static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u16 flags)
 {
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
@@ -1387,7 +1387,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	th->seq			= htonl(tcb->seq);
 	th->ack_seq		= htonl(rcv_nxt);
 	*(((__be16 *)th) + 6)	= htons(((tcp_header_size >> 2) << 12) |
-					tcb->tcp_flags);
+					(tcb->tcp_flags & TCPHDR_FLAGS_MASK));
 
 	th->check		= 0;
 	th->urg_ptr		= 0;
@@ -1610,8 +1610,8 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 	struct sk_buff *buff;
 	int old_factor;
 	long limit;
+	u16 flags;
 	int nlen;
-	u8 flags;
 
 	if (WARN_ON(len > skb->len))
 		return -EINVAL;
@@ -2166,7 +2166,7 @@ static int tso_fragment(struct sock *sk, struct sk_buff *skb, unsigned int len,
 {
 	int nlen = skb->len - len;
 	struct sk_buff *buff;
-	u8 flags;
+	u16 flags;
 
 	/* All of a TSO frame must be composed of paged data.  */
 	DEBUG_NET_WARN_ON_ONCE(skb->len != skb->data_len);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d8d3a688c0104..7882f9f17ed64 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1717,7 +1717,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
 				    skb->len - th->doff*4);
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
-	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
+	TCP_SKB_CB(skb)->tcp_flags = tcp_flags_ntohs(th);
 	TCP_SKB_CB(skb)->ip_dsfield = ipv6_get_dsfield(hdr);
 	TCP_SKB_CB(skb)->sacked = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index e2c109d5f069c..f368e090e6450 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -219,7 +219,9 @@ nf_log_dump_tcp_header(struct nf_log_buf *m,
 	/* Max length: 9 "RES=0x3C " */
 	nf_log_buf_add(m, "RES=0x%02x ", (u_int8_t)(ntohl(tcp_flag_word(th) &
 					    TCP_RESERVED_BITS) >> 22));
-	/* Max length: 32 "CWR ECE URG ACK PSH RST SYN FIN " */
+	/* Max length: 35 "AE CWR ECE URG ACK PSH RST SYN FIN " */
+	if (th->ae)
+		nf_log_buf_add(m, "AE ");
 	if (th->cwr)
 		nf_log_buf_add(m, "CWR ");
 	if (th->ece)
@@ -519,7 +521,7 @@ dump_ipv4_packet(struct net *net, struct nf_log_buf *m,
 
 	/* Proto    Max log string length */
 	/* IP:	    40+46+6+11+127 = 230 */
-	/* TCP:     10+max(25,20+30+13+9+32+11+127) = 252 */
+	/* TCP:     10+max(25,20+30+13+9+35+11+127) = 255 */
 	/* UDP:     10+max(25,20) = 35 */
 	/* UDPLITE: 14+max(25,20) = 39 */
 	/* ICMP:    11+max(25, 18+25+max(19,14,24+3+n+10,3+n+10)) = 91+n */
@@ -529,7 +531,7 @@ dump_ipv4_packet(struct net *net, struct nf_log_buf *m,
 
 	/* (ICMP allows recursion one level deep) */
 	/* maxlen =  IP + ICMP +  IP + max(TCP,UDP,ICMP,unknown) */
-	/* maxlen = 230+   91  + 230 + 252 = 803 */
+	/* maxlen = 230+   91  + 230 + 255 = 806 */
 }
 
 static noinline_for_stack void
-- 
2.53.0

