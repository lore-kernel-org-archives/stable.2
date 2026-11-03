Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746745;
	b=QIaK24as/NJ9xJqBgXEzSKSQMajJpTH1LYZIWe5HpBUCTl/ZbmEgB7jH3pkrpwoEpZzX
	 Ey1prwDZfrYaLhPCgqzk9YGJbtPdYk4pAFBQwMcEyvnJTB6KDB+TEPp7iXqd1aQBJZ/D/
	 dNmtGcy3+H72QgRFG7i6I/ZvBFx6vbkRlyeQnvQ7MXVYPTMd6kblpKZvwhf8e/9Re367e
	 iIqIwvcpJTOYOthk1Fe6Fbnvy1jRak9B2EpybMfwqektqTNE3WxBR0YoaFBEZD5NYFc5U
	 YuISBt1zjdDGEUIpgzjQE+yuFHdN6UFy9iWrNm5ibMdT6NyoB5EzvNyMKuR7NHpBSeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746745;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=B0eqxT4KZIYBLooYPOsnwzdSBVuWqaCgyyU2d1XUpxY=;
	b=WI7RhULXidFOqjihLC7g1u0B41ky03Jb5mhLPb/S6wy6xj3GQJQhJTI4I8CVRmqo+qq3
	 9vDnlXLqlLdn4CSWYU6KvQskd0Pz9jCKQC8PwqUsGxyfm1eCWG7v+UXxQJPyaW4Thu8Lm
	 gi8K+NKUIM8Bau8kH/nbv/sP9fMUJhp2icmTKGb5JNjQOrDOEukS4hDHmTbHYXMsiZUGW
	 ZsN1d0H9x5B0vZ1ydJ6pcCITtyQ5fGegPluJbxZXV6xV/ZiUip/8RcXkimWzTgfUprVXa
	 3PNPdsrpQTejj30+dUWIT0LRSv6xPBG4Jfx0/KBoe2fYIlix++cZLKl/mNJNKxcgo8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=FaZr4542;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B76606A330;
	Tue,  3 Nov 2026 22:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B76606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=FaZr4542
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=B0eqxT4KZIYBLooYPOsnwzdSBVuWqaCgyyU2d1XUpxY=; b=FaZr4542aWXs0WCE5Ue/yuPFZY
	uSJx53o7232qP8Rsxd8W/ipIYmXUPtzYCKwGoC5TpROiY4DQ4j1/Najzu0NAmJntmI6ZGxD8FYl8L
	oLf0e1fN8EKzT8eikSAnX8DBehD05WwvMz+SXHuqmF0lziQpFCexPhU8QXtsd1najPLYmc8Ma/ePD
	FbNrLRcy+lgsnSHwbV5W3zjqAyfki1ro/5/TL8u1+yS1hsfxs8wI4dW7siLzuw+VSW3BKaqaU0b6x
	o/yXC26pOQDPoiLFG4xqjAzzHsAyFY8l8tajlKmEwQ7zfPW6yA9Z+OtbGOKFD3zXFcZr99zcp2srG
	5VsOZobA==;
Received: from [151.115.150.205] (port=38596 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xONT6-0000000Fyyx-30Ff;
	Tue, 03 Nov 2026 23:59:03 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] xfrm: fix selector matching for IPv6 atomic fragments
Date: Tue,  3 Nov 2026 22:58:42 +0000
Message-ID: <20261103225842.3204446-4-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103225842.3204446-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261103225842.3204446-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
atomic fragment is different because it contains the complete datagram,
which allows XFRM to read its ports, ICMPv6 type and code, and GRE key.
Leaving those fields zero lets a plaintext atomic fragment miss a policy
that matches on one of them.

Leave ports, ICMPv6 type and code, and GRE key unset for real
fragments. For atomic fragments, treat the packet as a complete datagram
during IPv6 session decoding and recover the ports at the transport
offset found by the flow dissector.

Fixes: 7e3a42a12c4b ("xfrm6: handling fragment")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/xfrm/xfrm_policy.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index bda5100c9fdbf..24470dbd82639 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3526,9 +3526,25 @@ int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl
 		decode_session4(&flkeys, fl, reverse);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
-	case AF_INET6:
+	case AF_INET6: {
+		struct frag_hdr _fh, *fh;
+		unsigned int offset = 0;
+
+		if ((flkeys.control.flags & FLOW_DIS_IS_FRAGMENT) &&
+		    ipv6_find_hdr(skb, &offset, NEXTHDR_FRAGMENT,
+				  NULL, NULL) == NEXTHDR_FRAGMENT) {
+			fh = skb_header_pointer(skb, offset, sizeof(_fh), &_fh);
+			if (fh && !(fh->frag_off & htons(IP6_OFFSET | IP6_MF))) {
+				flkeys.control.flags &= ~FLOW_DIS_IS_FRAGMENT;
+				flkeys.ports.ports = skb_flow_get_ports(skb,
+									flkeys.control.thoff,
+									flkeys.basic.ip_proto,
+									NULL, 0);
+			}
+		}
 		decode_session6(&flkeys, fl, reverse);
 		break;
+	}
 #endif
 	default:
 		return -EAFNOSUPPORT;
-- 
2.47.3

