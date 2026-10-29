Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241554;
	b=o+nsPTHU0N/sIpUQmQf3uwnqknQllDLz1HFQ3wJnnYD2gdUGYjCVc2feNpUWJgiCjFQQ
	 OnSgGwozZ7u6MHPA3e7nBDxP5OecwQDhkjV6CQqhqEW5Z/6V3UeFgNxHK8S0iKiJP5Asz
	 hBJYqROZbgTKNd3EMMEnC2aKj5zv3IA7gEztAu1RGR8Ai9e5G+4DFL1CZuhAoqwFNHCWO
	 nMuKLT5f0KMsp/QsQfVYntI7mIEXlte9KbiCy5/oP5i+imlpv0GAS1kIK52+s6uJFbjYA
	 ZfcBh3/lTQHxszaZ7TYhsuiASOCzbDNRwkXZdC/trPjG4q/KSA6xn5f9ijC9snGGkJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241554;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:X-Mailer:Content-Transfer-Encoding;
	bh=e+lCID6p1r1B1w9U9iByFy2i5q0xuSntsqQpXnWCxQM=;
	b=bj0T1kTqOCCAAF6luw7MwTXtSdHCGGw/eQMAH02mO/mAarBtfzCZSFntuE+8IhpDhbhh
	 k3OxBREf0wX51BdhRz3IxyCaetfh45BeXcbmhElF6sD+tAl+KXzos/EBxeAVxChCfF2R4
	 b013OFxZEUnSfmB2dM69hk4qI1v5i8wb8awZOTQ60A6nMQ//Z2LBHy+2NxKhL4m5RN4N9
	 7qDanyIuxnZlY2ejSgzGpobZumhLvPL6RyBeBSnkvZK4wUHVFOq7lTE3VA8ekS17VryWU
	 KAmWxk4xyCN7J54wu5Nf2w80DcD2O8w0aFdtZ19z0KHWNvPDLGHzfypZODs8A3YPwfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=kq2IyNos;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C35606A31A;
	Thu, 29 Oct 2026 02:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18C35606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=kq2IyNos
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793241542;
	bh=e+lCID6p1r1B1w9U9iByFy2i5q0xuSntsqQpXnWCxQM=;
	h=From:To:Cc:Subject:Date;
	b=kq2IyNosViGWBiDgczhlyVGE+UiTneELthrD1fnh3WDd7Ry0J1D7zoDYEZRFyPxOH
	 ggDIaByK8+/idUukOSn5e5TFaohPDuLgtn4HPeJ5Z1P/Agj2kO9c6KRy7qXCXHdHyp
	 10Xd6SvMEmk2hj15OidezZh4XlZARr92FnyT11vs=
Received: from HAPYCAO-MC1.tencent.com ([61.151.228.146])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 9BB8EABC; Thu, 29 Oct 2026 10:38:59 +0800
X-QQ-mid: xmsmtpt1793241539tef31wi7f
Message-ID: <tencent_D1F9D5069513D7D12F0FC2E55A32A9ED4C08@qq.com>
X-QQ-XMAILINFO: MtaEuttEGLYbbQHxVCZzeC0e/NC/B1bs8OaIHhEnZXNOsRxjLmj3K6bXSUCvQx
	 NwfK9gYxWhbx+D5WtY/MYFr2xI+Gylux/zXIrqKyxKufn4utMz2gZE3d+MaCv1fJlF7xy66VNqzi
	 i1Qh9JlB+tQMDC6a8MdJ8iaxDPmfDItJaJ55ums2zA/Vv17ZBDiuf5vQP+zg2GwBtqz56xMTcQ5h
	 yZ5GsGux31eysmwhDCgtZQEmmFQkz2bxn4l1ziwxJPBS2qhsIStEeX4Cucf08SEXW+E9LZ708JdH
	 Es9txn2UaKNEVgmHpzkUxYL1wQLrxssgj9IHAMnbqhXQYCaJnZUPi6rWeJ8y5Cp3lQAVkeZqBNKo
	 L9x0KBXPQ16VyCGW7sY/M6hnagNGbXkEunAUYTI0xc3zjiSjWGEd96VB1ZBMVY7A4mCZ91hbVNpM
	 LjyhWqbHi2Lvd+QmjrfXjQcBXEABXz4Qc77vAoyyOJDDb7hHjJ49Pg5tBvJymp9dmml3IasIESLE
	 V0KANAs6Ib5VsqQbtBpsis/OnV+omvsMab72lIpNCv6IdZnAOPyKhU1ifjlIQCHFS7bzcDCbSza7
	 Qz7o3TNaQFg6jbkMJI0E+QrQnPtIAnFLdDY44WJrFq3oa0NWsUUyKOpSXBzIu23ZGF/hQIBg9I2D
	 1BKXj4t+/xAXK8kQzzUq3/pzB6RI1Kl/j4jRXUj6wxC5YLVzQ6AESmPYRKQutT3IVHafkBpdm7Hh
	 LT2uXJVK3vhbcTIfrQFhD/To7P0653wACAVgVtJFyJeDyqcerSPLyb0Uj74CjKuWv9MrMDgM9eO2
	 V8bPnIcK3z1QbAD2I5KQDYpI+GN7A4SWNeCpM7c7NtYnZfvnruoABZi/vNfK+sYOkenJG5fzLf8p
	 GUImkLSW3Jg4FD8NMZzgJugkb+CJwW8jam72OMg33xCHAHpazNzKBY/vvIuPuXiT431S15HICGfQ
	 uaq1lakav2W9RVfiqA+qyw1AuERNd11V/ruyEqLkIm0T6zVZMJh2fjnxyEX5nYfFEt+WbtHHUxRK
	 LgpidPALUEN7JdAMumyjo7yok+JbSb3K24w/b4Z58aA3pFL8volnd61v0Mb/xbI14cuJrr8tZhGO
	 j7GrxwdmVLGS+UxchUhiH0sifvg7/IQy/co+ONdLvJhNpR5WCB4m7Pp/+QwvlOczApHdXLLLCUA/
	 JZc+Ww5vBPypXQqs7nhKaMSKCaODoUI8rHN0E=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: bo cao <treebacker@foxmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	bo cao <treebacker@foxmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] ipv6: fix dead half of the MTU guard in __ip6_append_data()
Date: Thu, 29 Oct 2026 10:38:57 +0800
X-OQ-MSGID: <20261029040000.1-1-bo.cao.respin@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit

ipv6: fix dead half of the MTU guard in __ip6_append_data()

__ip6_append_data() validates the path MTU against fragheaderlen
before the fragmentation loop, but the second half of the guard is
always false: it compares (mtu - fragheaderlen) + fragheaderlen
against sizeof(struct frag_hdr) (8), while fragheaderlen is at least
1280 for any packet carrying a Hop-by-Hop options header of 1240
bytes.  An IPV6_MTU socket option that makes mtu - fragheaderlen
underflow below fragheaderlen therefore passes the guard, defeats the
datalen clamp (which wraps), and leads to skb_over_panic() from
skb_put().

The bounds are also recomputed in ip6_append_data_mtu() for the first
fragment: with a transport-mode xfrm (DST_XFRM_TUNNEL clear) the
ESP/AH header is counted in dst.header_len but not in fragheaderlen,
so the recompute can lower mtu below fragheaderlen again after the
entry guard has passed.  Nothing checks a lower bound after the
recompute.

Rework the guard to require 8 bytes of payload after the fragment
header in every non-final fragment -- maxfraglen >= fragheaderlen +
sizeof(struct frag_hdr) + 8 -- both at cork setup and after every
recompute in ip6_append_data_mtu(), which now reports failure instead
of silently producing bogus values.  This matches ip6_fragment()'s
existing "mtu < hlen + sizeof(struct frag_hdr) + 8" check and covers
the plain IPV6_MTU case as well as the transport-mode xfrm case.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: bo cao <treebacker@foxmail.com>
---
Changes since v1:
- also check the recomputed bounds in ip6_append_data_mtu(): with a
  transport-mode xfrm, ip6_append_data_mtu() lowers mtu via
  dst.header_len (ESP/AH is in dst.header_len but not in
  fragheaderlen) after the entry guard has passed, re-opening the
  same skb_over_panic() (review, High)
- require 8 bytes of payload after the fragment header in every
  non-final fragment (maxfraglen >= fragheaderlen +
  sizeof(struct frag_hdr) + 8), matching ip6_fragment(); the v1
  comparison accepted mtu - fragheaderlen in [9, 15], which leaves
  zero payload per non-final fragment (review, Medium)
- match the From: and Signed-off-by: names (review, Low)

Link: https://lore.kernel.org/netdev/179321375161.3134.12690504630171635307@kernel.org/

 net/ipv6/ip6_output.c | 41 ++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba98b1a..ab4eee51f173 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1347,7 +1347,7 @@ static inline struct ipv6_rt_hdr *ip6_rthdr_dup(struct ipv6_rt_hdr *src,
 	return src ? kmemdup(src, (src->hdrlen + 1) * 8, gfp) : NULL;
 }
 
-static void ip6_append_data_mtu(unsigned int *mtu,
+static bool ip6_append_data_mtu(unsigned int *mtu,
 				int *maxfraglen,
 				unsigned int fragheaderlen,
 				struct sk_buff *skb,
@@ -1357,8 +1357,20 @@ static void ip6_append_data_mtu(unsigned int *mtu,
 	if (!(rt->dst.flags & DST_XFRM_TUNNEL)) {
 		if (!skb) {
 			/* first fragment, reserve header_len */
-			*mtu = orig_mtu - rt->dst.header_len;
+			int new_mtu = (int)orig_mtu - (int)rt->dst.header_len;
 
+			/*
+			 * With a transport-mode xfrm the ESP/AH header is
+			 * counted in dst.header_len but not in
+			 * fragheaderlen, so this recompute can push
+			 * maxfraglen below fragheaderlen (or wrap it),
+			 * defeating the datalen clamp and leading to
+			 * skb_over_panic() from skb_put().
+			 */
+			if (new_mtu < (int)(fragheaderlen +
+					    sizeof(struct frag_hdr) + 8))
+				return false;
+			*mtu = new_mtu;
 		} else {
 			/*
 			 * this fragment is not first, the headers
@@ -1369,6 +1381,8 @@ static void ip6_append_data_mtu(unsigned int *mtu,
 		*maxfraglen = ((*mtu - fragheaderlen) & ~7)
 			      + fragheaderlen - sizeof(struct frag_hdr);
 	}
+
+	return true;
 }
 
 static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
@@ -1499,13 +1513,23 @@ static int __ip6_append_data(struct sock *sk,
 		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
 		     rt->rt6i_nfheader_len;
 
-	if (mtu <= fragheaderlen ||
-	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
+	if (mtu <= fragheaderlen)
 		goto emsgsize;
 
 	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -
 		     sizeof(struct frag_hdr);
 
+	/*
+	 * Each non-final fragment must leave room for at least 8 bytes of
+	 * payload after the fragment header, matching ip6_fragment()'s
+	 * mtu < hlen + sizeof(struct frag_hdr) + 8 check.  This rejects
+	 * MTUs that make maxfraglen underflow below fragheaderlen and
+	 * defeat the datalen clamp, which leads to skb_over_panic() from
+	 * skb_put().
+	 */
+	if (maxfraglen < fragheaderlen + sizeof(struct frag_hdr) + 8)
+		goto emsgsize;
+
 	/* as per RFC 7112 section 5, the entire IPv6 Header Chain must fit
 	 * the first fragment
 	 */
@@ -1635,10 +1659,11 @@ static int __ip6_append_data(struct sock *sk,
 			else
 				fraggap = 0;
 			/* update mtu and maxfraglen if necessary */
-			if (!skb || !skb_prev)
-				ip6_append_data_mtu(&mtu, &maxfraglen,
-						    fragheaderlen, skb, rt,
-						    orig_mtu);
+			if ((!skb || !skb_prev) &&
+			    !ip6_append_data_mtu(&mtu, &maxfraglen,
+						 fragheaderlen, skb, rt,
+						 orig_mtu))
+				goto emsgsize;
 
 			skb_prev = skb;
 
-- 
2.39.5 (Apple Git-154)

