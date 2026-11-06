Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996977;
	b=Q0OLqRHxjr667kfb3KqANuX2tJVI6jrQ2Ac3bUYklnVO9CKgUccSEhU9LUsIw+jrJBMK
	 kdUc4xTJr8zJyY9KOVUKtsuGeUp/T5oEI6xzW09W3r5xdB8DaYW3K0qHpnDM8YmtQCOZH
	 ZxSw2xVNhK72IMeiTeGA34XGa11ZINNc3btXktQxB7Jt0hapCGNdd3Mc3Xk1dnRMoNJ3i
	 ZrU87MXMIrPFockRcAZ1xQgzfofr7x0iJ9X5nWpl0bWfz2nVxkg55l2+4H+s/gPk7ycBZ
	 nsOUXXzAu25dSFGgbYLR2DYNLP1/YbBq2TYCt4X7rXT6y9FPTislZYqiTOYkYxEgVmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996977;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=wo67bMf12uv9sxkRm+RvBafvUVvq2/g1Yt8DBSFwVh0=;
	b=BrjCxUR9nVC3n6fvenku1DznMRbVlqnfPwpZhGHuRi0j1Xa7Kz6onsUmjncGYIQauTnD
	 4E9P0KuPGbdW+2+nY7pedIcL4SLFDEntNde5dCTvRIbcqcBDgSGXq4S+7oFBmAlAzhc1R
	 //VoiMJOYPrW3NiN3FnxeEoZv/LyubTVVbfr9p0FlDxlphcBq7DEpy/PfWWL72n7nK5yz
	 k1Ul8cQpuIKAVIM2wv/9GrdlNJFZK/vR5QXXem3BSZKuJIxXCBODiqK9dI4TBNBSrsjan
	 QF5gz/5XPHzzKHU3hUPXRcq0omsOdocLqjqSXMPXlayrPswx+3X1kK5ddGgAI6bY6tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=AE4BKwBS;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CA606A329;
	Fri,  6 Nov 2026 20:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E8CA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=AE4BKwBS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wo67bMf12uv9sxkRm+RvBafvUVvq2/g1Yt8DBSFwVh0=; b=AE4BKwBSjh1xrC+Be45MrgzZdy
	K8VnGw6/Bz5moPLLZy6kO1frMi3IFouXoHJNBXLxX59ItXir+p8wcHADBduBEWl7Fmt5AIcppwgID
	aY4eT559AfjSIKB0Vg6EIhJCh5VgTaAs21j6vLrsq3JWW3lmvBgorZH3rPjlDcdhjmWoh7pxdx3jq
	aFYK+pPWoM1sAQMGqbK7L9iNeJiWAlbAkwKT2spEnxUqMQi+37KnLW8V8n0bxCDTqDWbBTJXFoU5/
	iAsjpZieySXSoiIi7c+pUy9FPy6K6atCDmMy20A9eGnBUTJT5UEMW9GpQpr0lfchTad8xR7spOypd
	q1U487nA==;
Received: from [151.115.150.205] (port=56674 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xPQZ9-00000001I6n-0Btm;
	Fri, 06 Nov 2026 21:29:35 +0100
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
Subject: [PATCH net v3 1/2] xfrm: fix IPv6 first-fragment protocol decode
Date: Fri,  6 Nov 2026 20:29:06 +0000
Message-ID: <20261106202910.723098-4-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106202910.723098-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261106202910.723098-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Make the dissector continue through first IPv6 fragments. Keep the
port, ICMPv6 and GRE selector fields zero for all fragments, as the
old decoder did. This also keeps the result the same when a BPF flow
dissector fills ports for a first fragment.

Fixes: 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/xfrm/xfrm_policy.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 9ea60c7717ff8..bda5100c9fdbf 100644
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

