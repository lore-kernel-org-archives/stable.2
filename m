Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996982;
	b=MqWzmLqo1wjU0wAjQxofSOYgglrJCi5E2oAJ+o5m3EGyeie71+F8y7XkMCRQ1Ag6p2qK
	 larpAQZeYMUJ5IGTIZbFixTdatoND0t61IgGS4CmGEocr1LIFlQk29ZenF2ZpqH108Lbe
	 kLBme9Vn/qRvVbOQ22J92XC+mVHkR+M3EnZalQLpESc4Vx87XRk6IO3l6HSizN1o5ZKLr
	 dUrQcsHuCwHhwE4BDFWjkWgAEaSkmDwO9pGWnQIqrRM4DOS42qajKAi6/ElVexH+UoPfF
	 ETKvvCWoX14SBIH19dzMEmG3kOR28S7eSSEja8+B0rv3qA8pTqCsjcu2cecWD94wKwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996982;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=HrXkiiGdUBmwU/LbSqgOWqBj4+1gSdkVc3p2fHsXaTk=;
	b=VQhqiTL9Yyo7DNC7rGzTXnSvr5tcwbHK7i3SvYWLAFlczOkLXLro0a5pZ2uR/tN8wz8L
	 goy2oAYleF4BOM+YUeG6GrviOzmpgnYQTXKRhWtCppHNhwcVgenkBNR1mTXJhvGam/LlG
	 YWzfY83m6cXpPors1eyeYg2Ywin15bGNQIu8yKNoWzrLyFnjkjvWLazUgkWanaLEv/uCX
	 7L0aGLZvGvl7BOp/26Zjx0DOpgwiLfcH0RE1gNXZCqS1K/mHgSGQRDTjk0+tAfr2EwXuI
	 z/Na+4X0JM4Pa6cqQkfDvnDmNQJwAAokhqYQhCPfiwCUWCDbGAESGwpH+X1Y5saN5UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b="YITxRy/H";
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D0606A32F;
	Fri,  6 Nov 2026 20:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC2D0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=YITxRy/H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HrXkiiGdUBmwU/LbSqgOWqBj4+1gSdkVc3p2fHsXaTk=; b=YITxRy/HbXJm1Ad71+dJ1GnA7k
	FQwQtX8nd+8e8LMWhluvLtF/1NtD6J4SY1VHF5PzsyuWPiS+SGzEnjO6pbomf649Z49n/AjcsRsRF
	9Y6395JGcR94EskTCbhA+dsxZlLJyVRYmqFUTbTylILK4C96Ssej/8RWHdWFQR7HN7cDCe9gE/ofh
	QLVXJiNgSwFgtSJtIE0k0kPia2syppa//6J+2cJtwMsMpojKeLmPcSWNco6vGsonOmT7PaudJENgp
	SvIcrWNvyMuXk8owIrd9KIrOvUtWiPcLIkPK9J6/F2aBy/2pcPndZsWScKzaEA3OU4NSZjk4xS/NY
	+GCpgGhg==;
Received: from [151.115.150.205] (port=56674 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xPQZD-00000001I6n-2K02;
	Fri, 06 Nov 2026 21:29:40 +0100
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
Subject: [PATCH net v3 2/2] xfrm: fix selector matching for IPv6 atomic fragments
Date: Fri,  6 Nov 2026 20:29:08 +0000
Message-ID: <20261106202910.723098-6-Jeremy.Jean@oss.cyber.gouv.fr>
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

Commit 7e3a42a12c4b ("xfrm6: handling fragment") stopped decoding IPv6
selector fields after a Fragment header. That is correct for real
fragments because later fragments do not carry those fields, yet an
atomic fragment is different because it contains the complete
datagram, which allows XFRM to read its ports, ICMPv6 type and code,
and GRE key. Leaving those fields zero lets a plaintext atomic
fragment miss a policy that matches on one of them.

Leave ports, ICMPv6 type and code, and GRE key unset for real
fragments. For atomic fragments, treat the packet as a complete
datagram during IPv6 session decoding and recover the ports at the
transport offset found by the flow dissector.

Have ipv6_find_hdr() report non-atomic Fragment headers while it walks
the extension header chain. Pull the base IPv6 header before calling
it so nonlinear skbs are safe, and recover selectors only when every
Fragment header it sees is atomic.

Fixes: 7e3a42a12c4b ("xfrm6: handling fragment")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 include/net/ipv6.h      |  1 +
 net/ipv6/exthdrs_core.c |  6 +++++-
 net/xfrm/xfrm_policy.c  | 17 ++++++++++++++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 3de07e738538f..10785721b013d 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1110,6 +1110,7 @@ enum {
 	IP6_FH_F_FRAG		= (1 << 0),
 	IP6_FH_F_AUTH		= (1 << 1),
 	IP6_FH_F_SKIP_RH	= (1 << 2),
+	IP6_FH_F_NON_ATOMIC	= (1 << 3),
 };
 
 /* find specified header and get offset to it */
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 4a9748338cf40..9b9e2ce72e170 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -183,7 +183,8 @@ EXPORT_SYMBOL_GPL(ipv6_find_tlv);
  * isn't NULL.
  *
  * if flags is not NULL and it's a fragment, then the frag flag
- * IP6_FH_F_FRAG will be set. If it's an AH header, the
+ * IP6_FH_F_FRAG will be set. IP6_FH_F_NON_ATOMIC will be set for a
+ * non-atomic Fragment header. If it's an AH header, the
  * IP6_FH_F_AUTH flag is set and target < 0, then this function will
  * stop at the AH header. If IP6_FH_F_SKIP_RH flag was passed, then this
  * function will skip all those routing headers, where segements_left was 0.
@@ -254,6 +255,9 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 			if (!fp)
 				return -EBADMSG;
 
+			if (flags && (*fp & htons(IP6_OFFSET | IP6_MF)))
+				*flags |= IP6_FH_F_NON_ATOMIC;
+
 			_frag_off = ntohs(*fp) & ~0x7;
 			if (_frag_off) {
 				if (target < 0 &&
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index bda5100c9fdbf..679343b23df35 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3526,9 +3526,24 @@ int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl
 		decode_session4(&flkeys, fl, reverse);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
-	case AF_INET6:
+	case AF_INET6: {
+		unsigned int offset = 0;
+		int fh_flags = 0;
+
+		if ((flkeys.control.flags & FLOW_DIS_IS_FRAGMENT) &&
+		    pskb_network_may_pull(skb, sizeof(struct ipv6hdr)) &&
+		    ipv6_find_hdr(skb, &offset, -1, NULL, &fh_flags) >= 0 &&
+		    (fh_flags & IP6_FH_F_FRAG) &&
+		    !(fh_flags & IP6_FH_F_NON_ATOMIC)) {
+			flkeys.control.flags &= ~FLOW_DIS_IS_FRAGMENT;
+			flkeys.ports.ports = skb_flow_get_ports(skb,
+								flkeys.control.thoff,
+								flkeys.basic.ip_proto,
+								NULL, 0);
+		}
 		decode_session6(&flkeys, fl, reverse);
 		break;
+	}
 #endif
 	default:
 		return -EAFNOSUPPORT;
-- 
2.47.3

