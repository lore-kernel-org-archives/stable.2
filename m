Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439262;
	b=XhLyC74orji4dISeN+ITuptgrluR/dV4QF/6//qYuNkL0FN5hXo2EgeAyy8SuZvikScp
	 nmUIloEGFoutB+tzLfdVS5n0lepqt5prgFQRYnRLq526BEJbWPAS5r8fCwyGmW4H41VsI
	 sMrABw//D/W9jQZdbINI101sRmzV6Ly69NgcCenl7mYUEQbZYaeZvIlTYm0UwvJsk0o/v
	 4/VRHEMBlg4iw5vldrL0tABJZdhMlPyzFfYzNTWG4TAiNkQINNNw88PBy6jNJei/cH8xn
	 /1axsbdrXlsJjWFwI+7RZc1fBbf0C9Zs7GXm24VqZV8Kt0DgbxHj3bCp6aZPEFNryfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439262;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=CEsjwLaNHkM5WLJ0P0t7rAQQhvHBPzyPeBDAleNn9vk=;
	b=5GImqkmx+O+98/N2W3kZcTbyxHbCs19BmN6pBvbahSPoH7L+PFXWeAbT7xfKK+JZbR8d
	 MtFjwm3bkaDk5eqUMvM70wWuDGgIjFCWKccAsCALV44mAIjLTAeRxENl7eotRALcpn6J4
	 oLIKVz98k4aQWaAHE+yMlkZFRoPqtzhqk+nw9dohq/ZPZYaMiTOH+7CQ5d90+2JMj7UFH
	 MYNqpgLVLh3Ypxt359YIObkFyJAmDhRMi7FGoTG6vZURJ0hPO2ktNd4VJjOKvfMgVM33f
	 YS3tvsLhFrCvhWABgJqzDTjpd5z4DbPVEALI+9Syx6wOWWITp/VEGFC9WjYNJ4iEL5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=DyGdmWmF;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101F2606A32A;
	Wed, 11 Nov 2026 23:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 101F2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=DyGdmWmF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CEsjwLaNHkM5WLJ0P0t7rAQQhvHBPzyPeBDAleNn9vk=; b=DyGdmWmFOdrLP3dX7GJLySlDks
	5+T63oMQa96rtEWTJWzG3c5PWTPd026p3ryhOvB0S/TDDalySdQ5HhQeHxSs1Ac0G6N3D5sb/My3m
	kRpFXjVROYjAoKimO3N+K6RsNE6Z3UQjKsEjftlKShnMHnQcf+FkEs39ukQ3DCv6LbTiqgLJFdZjO
	Tg/q/b2lGTJfMiNzNMOmNRbl+EGZ0aJIwabl42au4eQJu6UPikLklS2ebCYhNvRyFWV00eSx9vyAX
	DKGZP5TFIZjnfkj41UrK7I20ZheCUKbP7uZVQsXzixu+ipxo0sod9A/iWwXRuVQsuyNwSvWYBqTy7
	XJ02Ss6g==;
Received: from [151.115.150.205] (port=46196 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRHcj-0000000EP1N-0yEM;
	Thu, 12 Nov 2026 00:20:59 +0100
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
Subject: [PATCH net v5 2/2] xfrm: fix selector matching for IPv6 atomic fragments
Date: Wed, 11 Nov 2026 23:18:53 +0000
Message-ID: <20261111231853.2504833-4-Jeremy.Jean@oss.cyber.gouv.fr>
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

IPv6 atomic fragments contain a complete packet, but XFRM leaves the
port, ICMPv6 and GRE selector fields unset. Plaintext can then miss a
matching policy.

Have ipv6_find_hdr() mark non-atomic Fragment headers. Restore the fields
only when every Fragment header is atomic. Use its offset when the
transport header is before skb->data. Read with skb_header_pointer() so
decoding does not pull or reallocate the skb.

Fixes: 7e3a42a12c4b ("xfrm6: handling fragment")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 include/net/ipv6.h      |  1 +
 net/ipv6/exthdrs_core.c | 25 +++++++++++++------------
 net/xfrm/xfrm_policy.c  | 19 ++++++++++++++++++-
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 3de07e738538..10785721b013 100644
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
index 4a9748338cf4..f00c28ce2f1e 100644
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
@@ -191,23 +192,20 @@ EXPORT_SYMBOL_GPL(ipv6_find_tlv);
 int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 		  int target, unsigned short *fragoff, int *flags)
 {
-	unsigned int start = skb_network_offset(skb) + sizeof(struct ipv6hdr);
-	u8 nexthdr = ipv6_hdr(skb)->nexthdr;
+	unsigned int start = *offset ?: skb_network_offset(skb);
+	struct ipv6hdr _ip6, *ip6;
 	int exthdr_cnt = 0;
+	u8 nexthdr;
 	bool found;
 
 	if (fragoff)
 		*fragoff = 0;
 
-	if (*offset) {
-		struct ipv6hdr _ip6, *ip6;
-
-		ip6 = skb_header_pointer(skb, *offset, sizeof(_ip6), &_ip6);
-		if (!ip6 || (ip6->version != 6))
-			return -EBADMSG;
-		start = *offset + sizeof(struct ipv6hdr);
-		nexthdr = ip6->nexthdr;
-	}
+	ip6 = skb_header_pointer(skb, start, sizeof(_ip6), &_ip6);
+	if (!ip6 || (*offset && ip6->version != 6))
+		return -EBADMSG;
+	nexthdr = ip6->nexthdr;
+	start += sizeof(struct ipv6hdr);
 
 	do {
 		struct ipv6_opt_hdr _hdr, *hp;
@@ -254,6 +252,9 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 			if (!fp)
 				return -EBADMSG;
 
+			if (flags && (*fp & htons(IP6_OFFSET | IP6_MF)))
+				*flags |= IP6_FH_F_NON_ATOMIC;
+
 			_frag_off = ntohs(*fp) & ~0x7;
 			if (_frag_off) {
 				if (target < 0 &&
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index bda5100c9fdb..e551af50da5f 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3526,9 +3526,26 @@ int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl
 		decode_session4(&flkeys, fl, reverse);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
-	case AF_INET6:
+	case AF_INET6: {
+		unsigned int offset = 0;
+		int thoff = flkeys.control.thoff;
+		int fh_flags = 0;
+
+		if ((flkeys.control.flags & FLOW_DIS_IS_FRAGMENT) &&
+		    ipv6_find_hdr(skb, &offset, -1, NULL, &fh_flags) >= 0 &&
+		    (fh_flags & IP6_FH_F_FRAG) &&
+		    !(fh_flags & IP6_FH_F_NON_ATOMIC)) {
+			if (offset > U16_MAX)
+				thoff = (int)offset;
+			flkeys.control.flags &= ~FLOW_DIS_IS_FRAGMENT;
+			flkeys.ports.ports = skb_flow_get_ports(skb,
+								thoff,
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

