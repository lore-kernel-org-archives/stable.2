Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793574525;
	b=VHCxrDRm4WHK4Mo9PHllNzCmbRia23iSGTi29jTF/dzzMMuqZUnf3woAm4ryEJZiB7nd
	 gN3HU0JHX6iTqUqA7zLvx74iNI7jO7Kayy6J4pqyZE1huflIeUAZ5uUk1HiIPsCcosxow
	 I9BET1WNgFSgPnJIN2uPKXMLST+BmS4HTI+6aOiA7LIzk4AmHAcHLategWl/UOXC1DxWq
	 RjCwwOp9dCPqtZWF9ZAaqkVsooBOMWS4Ccx0nUlIwX9v0wzV/zX8RpHBhjr77t8IFPjXY
	 olwnmHTUuShkodI+J2fCQFmu31KgVUUa4jKxk06lPyGSh9CjdUCQni6c8mJC7+XUS0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574525;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=EDyFzLWJAx3/EEHiJ5QGNpTHFe63F8uemUyzw+u6ROs=;
	b=VoqjzvSP7KkcjV6QGyP5wvOxNBamV6NjVtQ4gNUzl7bxxdC6MDZQP8KPOGAhZ+TdQKcn
	 aVuiwDW2VoAxY6fBrTjXHiRd+nau4SDSpIvyKlWddkMI3qhrJqdYaLyk0fU+eYk+rwFPC
	 NoTrHZanu1guQHsdg4zMlxOOLHTTqrYy+7pytwJrIEsK4zFYPOGuNkgjP0+oJJI+Pi69s
	 sYllMJBtXy90qeKgyZ0bxGWjCYoUhrdFqP/asvUFgeJhZS6JLHMCfQOFnyTS3SHjieiHN
	 kqIh4a+G0GnTlgbjhbt7H6sOqqfSCeH8fYe++E4JTkz2q9hKw22pWzbkmfSikCsXDQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Unjni+PT;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E562606A324;
	Sun,  1 Nov 2026 23:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E562606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Unjni+PT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=EDyFzLWJAx3/EEHiJ5QGNpTHFe63F8uemUyzw+u6ROs=; b=Unjni+PT3jPu/98GYZyI+I8IPB
	E6HA8M+Y1cv70Yu5s0LAebIlVxlHfo3SWFE0B8SsF2Rw/+hkDu/fi/P+7yhRIXrxi4LqLHrIkOBe1
	+7oDuezC2gjeP96dfcQAP0ymV0vZqG04i0IZpm8PXjMs7nn0O6smbjRU253a47heIntpm0gE1ANiQ
	dOxHbneVFqlLMdLMtQBwcNevhU69VRD17p9OwCRlJIyjhbxmCM/QTammkFj5XUmm/AYqSUAIQpaW6
	3FTudW2DxJ0XAmhw77d9x0vllYOeBgq8ipDtt8kigDBNVCFzMiqs8eHY8cEb+qgLSeXtlIu54ThCV
	cbaq1bow==;
Received: from [151.115.150.205] (port=40718 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xNefL-00000004S7h-0IAK;
	Mon, 02 Nov 2026 00:08:43 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net] xfrm: fix IPv6 first-fragment protocol decode
Date: Sun,  1 Nov 2026 23:07:45 +0000
Message-ID: <20261101230745.2043474-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
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
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Commit 7a0207094f1b ("xfrm: policy: replace session decode with flow
dissector") replaced XFRM session decoding with the flow dissector.
While the old IPv6 decoder kept walking past an IPv6 Fragment
extension header, the flow dissector stops unless the caller sets
FLOW_DISSECTOR_F_PARSE_1ST_FRAG. For an atomic fragment followed by
extension headers, inbound policy lookup can therefore see the header
after Fragment instead of the actual upper-layer protocol and miss
protocol selectors.

Make the dissector continue through first IPv6 fragments. Keep GRE and
ICMPv6 selector fields unset for fragmented packets, matching the old
decoder's behavior.

Fixes: 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/xfrm/xfrm_policy.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 9ea60c7717ff..c9c2370b07cc 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3489,14 +3489,16 @@ decode_session6(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
 		fl6->fl6_dport = flkeys->ports.dst;
 	}
 
-	switch (flkeys->basic.ip_proto) {
-	case IPPROTO_GRE:
-		fl6->fl6_gre_key = flkeys->gre.keyid;
-		break;
-	case IPPROTO_ICMPV6:
-		fl6->fl6_icmp_type = flkeys->icmp.type;
-		fl6->fl6_icmp_code = flkeys->icmp.code;
-		break;
+	if (!(flkeys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
+		switch (flkeys->basic.ip_proto) {
+		case IPPROTO_GRE:
+			fl6->fl6_gre_key = flkeys->gre.keyid;
+			break;
+		case IPPROTO_ICMPV6:
+			fl6->fl6_icmp_type = flkeys->icmp.type;
+			fl6->fl6_icmp_code = flkeys->icmp.code;
+			break;
+		}
 	}
 
 	fl6->flowi6_proto = flkeys->basic.ip_proto;
@@ -3507,10 +3509,13 @@ int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl
 			  unsigned int family, int reverse)
 {
 	struct xfrm_flow_keys flkeys;
+	unsigned int flags = FLOW_DISSECTOR_F_STOP_AT_ENCAP;
 
 	memset(&flkeys, 0, sizeof(flkeys));
+	if (family == AF_INET6)
+		flags |= FLOW_DISSECTOR_F_PARSE_1ST_FRAG;
 	__skb_flow_dissect(net, skb, &xfrm_session_dissector, &flkeys,
-			   NULL, 0, 0, 0, FLOW_DISSECTOR_F_STOP_AT_ENCAP);
+			   NULL, 0, 0, 0, flags);
 
 	switch (family) {
 	case AF_INET:
-- 
2.47.3

