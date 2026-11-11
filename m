Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439261;
	b=OmwBku76kbG0cgamIZZ/qNiATqc5V1uplGxXNMdzHvaP9gQR2O2DzPAd9rIUQmtwPFEZ
	 ylROHdjPpoKWZfnoDzn/fH1iH5HFaTbPK23jz51vK5YfVFDuiXOEaNXe6+1agNh0Bpj9w
	 LFcmQC45tIrnIuoqfZUnWQjCD9B3Yiw/yF/5rEx1MWs70+IU98Qbr74cPWNyZmbI43dnv
	 MSRtv0J/3AimI3r/cyBcIyWI0DDPOxyQNTDyZtzVhpcLKKBtWZJlaDabkrDvZvNOwiVIN
	 A7GvHmHRsckSqRH3kS8k3i2jPlFARNGX7PfV+7mRfunZ7DB9w3M1kkwsD84AadCjg0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439261;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=yTLJ0crVEOQMB1gNrbZDcPgQwt8pvOXiWDD8GCkG320=;
	b=5WwamKbBczQRj+2Gn9KCb+4e7e9j5wxLLCqohFRLnjEH+qrMHd1fa2tScZ0QzM1kGi+r
	 zapRudXi9nAy1/eexriZRGiBbqaGZrziYlTRpFhcjQsLGkaEngv937b6Rs9LfVSkYu7o2
	 Mw851k5FfC5o7M63KU5LSyc+NpGEg6qM+3teUWTo2qxrpBDjykQ2HsDua3jLUWCrmDooY
	 mea0BWOlSJkKiac+yb6sNdDhjWy0W8g05YWnsH/oTN1ag8Ut6nSzpClGIsHGDvWaAxbP9
	 +Nmu6tu8l40bRjdLnVFRr5upg7oPooLMb7CRxx7RA9NSH/Js3x8zFsJcl1Habmrrlcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Q+Y2vAr8;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4661C606A324;
	Wed, 11 Nov 2026 23:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4661C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Q+Y2vAr8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yTLJ0crVEOQMB1gNrbZDcPgQwt8pvOXiWDD8GCkG320=; b=Q+Y2vAr87daXFj1T6Y+d9IlW9b
	grhikcWC0L3BMVTkimn7XqD/Hu4CypsYkFpQ+EhyDJZdgqzlEZVYmiZGAzntm4AQLuDZwFAT7ZoKm
	BnXM/8I/MJ/Mam+XDKauNYXT9OX28ordhxtLzqzrIAOt3IOMdynJQjx4NMHNIdBlbfsBZVTdurpQj
	2WL20FaWgNecXVqMfCSEmNdKfqYntW02hJWJ4cbNk+vC5UUosbv6+xFg069dIcHbenibXQu9cDQ+v
	TOeCn9HaagXXyRYXXuOItAHDX6MyCRTiW1GWOwoy/m15t4/E6KiPDdjJJVLcRvEDwDwzvo0zoMdsx
	A2kUeu8g==;
Received: from [151.115.150.205] (port=46196 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRHci-0000000EP1N-1OEZ;
	Thu, 12 Nov 2026 00:20:58 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net v5 1/2] xfrm: fix IPv6 first-fragment protocol decode
Date: Wed, 11 Nov 2026 23:18:52 +0000
Message-ID: <20261111231853.2504833-3-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111231853.2504833-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261111231853.2504833-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Make the dissector continue through first IPv6 fragments. Keep the port,
ICMPv6 and GRE selector fields zero for all fragments, as the old decoder
did. This also keeps the result the same when a BPF flow dissector fills
ports for a first fragment.

Fixes: 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/xfrm/xfrm_policy.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 9ea60c7717ff..bda5100c9fdb 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3480,23 +3480,29 @@ decode_session6(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
 	if (reverse) {
 		fl6->saddr = flkeys->addrs.ipv6.dst;
 		fl6->daddr = flkeys->addrs.ipv6.src;
-		fl6->fl6_sport = flkeys->ports.dst;
-		fl6->fl6_dport = flkeys->ports.src;
 	} else {
 		fl6->saddr = flkeys->addrs.ipv6.src;
 		fl6->daddr = flkeys->addrs.ipv6.dst;
-		fl6->fl6_sport = flkeys->ports.src;
-		fl6->fl6_dport = flkeys->ports.dst;
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
+		if (reverse) {
+			fl6->fl6_sport = flkeys->ports.dst;
+			fl6->fl6_dport = flkeys->ports.src;
+		} else {
+			fl6->fl6_sport = flkeys->ports.src;
+			fl6->fl6_dport = flkeys->ports.dst;
+		}
+
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
@@ -3507,10 +3513,13 @@ int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl
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

