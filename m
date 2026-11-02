Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793584671;
	b=YQDCDO0JZDbuSDXYvQzea0pzPTR1kiId0bWLWsSwu8pkieGM5Wh0YZNuWyUN84kVIJuB
	 Pyx8H9HlgrjALC2nofl6FvAAsQ3wH+/O6fhge/FFX8LpA3PLwB/Jr1r5qa/DmfcgdCJTy
	 QiOWG3NcmSaYadIaO6iNq5zU6XVHMuQaHfNs8rRrVttw8V09d7BUe2stEz40qHmbf8Qm+
	 U7WXWUiwDliCwy4U5nToRVr4qGHv5nJHExl86+6qpd3EwzJS5KSVJGmw7wau9cha6FbJC
	 mgDrfLBhge/4ZigwX2lyiDRCOWoBs/yOyq5qCATVkwpRj3tMoLq3oEd6H+I04F7jVjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584671;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TvpTzi8L0ZRWR0mVAbSBCUuTyz3j9j00g6UtTPOySZE=;
	b=0lOpBhM624rFG5oBa3F12Y9OphOoc8xn5ADCYs9P+kqsr99JqCkloB0ivh0Zhh+qRWpu
	 HgJ1H3SZ717uGGCc5sP6wvoDZILvKCsrEUHCxkgPVzURhxiZPYOG8i5xAmj5mlT8cVUX/
	 mcLXKOudAxGVvNeO2s47Ba7PAuS+BH9gRauhNg986vOo05T+XKAdAHMVxaou1/VsI29SJ
	 g5tYngM1dwha4VXzQO+QMeKoSsC6gIKyd8IRgJEMYRio8068FcDg1S+YY8zlX+CZKS5mc
	 99yFnr7K2GIKnrqNp4R5NBqqA25e+4a/UbVs1o3S1kAcAJPVPaVGbOSxdE29FLR8qZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=XiufxJuD;
	arc=none smtp.remote-ip=203.205.221.231
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51755606A324;
	Mon,  2 Nov 2026 01:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51755606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=XiufxJuD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793584660;
	bh=TvpTzi8L0ZRWR0mVAbSBCUuTyz3j9j00g6UtTPOySZE=;
	h=From:To:Cc:Subject:Date;
	b=XiufxJuD9RBVMxXzCuURboolbfjU2kmL84RSMEVL/ZZKV8smy+0M0FCTrt9GgbGEG
	 phUMPES+WYSQNLSOszyB8lGYxbTByoLlJFpCTAiqGRXm2Bz4InDDO5cC4XC1ILumip
	 ALABIKprKcJyqYg4wxT6xLbMp7lwIUxQMAaI5HVE=
Received: from HAPYCAO-MC1.tencent.com ([61.151.228.151])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id E6531245; Mon, 02 Nov 2026 09:57:37 +0800
X-QQ-mid: xmsmtpt1793584657ta2b66kj9
Message-ID: <tencent_0A4B784EEB3D358B09B43AA2B2F13AE44505@qq.com>
X-QQ-XMAILINFO: N8xf3Kn/xs1HBUfGmattMNB7+yKUBgyS6w9hE05dNpGZAJ7OXBN53xrj/d7j8m
	 kAtrXYjFbxUYmmy4ZfV3o5Bi5Pf4jXZ8tdxbeoSbqvqFgg5mqQrWD1wkQbkxfEUU0HnS947jrrFS
	 Oi1NCkyWyFQnMYW6/9wfAxeA7lJHCwcv0wdpOxTflzDyVzhGyxRYZCxzOGaiKJT69BbXaoL+UEzH
	 IBTU8f4AI795r7ec7eIKB2yh8eXc+jgSvd7ropAWfho2zo0EMYBNMgUo1Rhl/acsRj8VTqcMPnOI
	 T0DQPeb9ZU4BMBXigfVLvVAwaqNM0eqzwPWmVueAnQXV8KTRfXsB/w22xFKrYYlXhNqOKRdw/LLW
	 xSIlYMmKt+8vjUAFn6kdBdpKXvK/hVU5+r6OCnwrifggZOB+AayXO947KRTPjF4pUgeazjve15jd
	 7aB8fqp61dC39dAUx5xdBznQIXvFOadB1XNqRbxLNR6wVsLdR7fFy+D7OGD+0mEzHQykxVTOEzlK
	 dUUjmdAUhJ/03ireIY2K1fsSjhICoMFb97UWhaI/EFEmvHKXoKsLs+8xZ6bPNW+qIMAo4PBnMnRW
	 uwNS2Cu7HATj6Ce0MKW1JwRLxLauw/2SlRQp5bsOptoPWo0h/qyVIQDHlg3m1iCoOA4klNbNkp8/
	 BOLLyog9IWXyNZC4LsxHMHqtOTjd+Xw06Y6CY2tqogXoyF49rV+Ch/CXmeSvd50M9rnUtw3Nzfmz
	 hWgIk0e0C1iWJ+0nH5tBCQpyvUWbTcYEM3LuwQE8cuueVh9/KzSGhvlETtHyeZxOTcky03HC+B+J
	 0WdmGGCsn0u1Scc2g/jd5CtKm1Y/CneVb9RtmwTQZDuqNPFOpdk1XxqYN2poY69rogrZeorKNJ+y
	 vV+PKZjYRh7jo28m+ZDRFM3R6o5bEpJlbdAXrc6ho6fiH+Ti2eA8H1QgBKnTPZf3qlfHfQFin/g9
	 wEYe7zh7ISYxpdc9jxAs6W8GGgULEtVX3C7HfyjhBGSoDtkn0CohE205XEMe5ehkAAI346AjpadG
	 +Pu+KO/aYPGzz3n7z+UX18BVEKkQKFn1Inljf511zzzpksorgFIyYj4MN32XaWGgxvMYniZQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: bo cao <treebacker@foxmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	edumazet@kernel.org,
	idosch@nvidia.com,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] ipv6: fix dead half of the MTU guard in __ip6_append_data()
Date: Mon,  2 Nov 2026 09:57:36 +0800
X-OQ-MSGID: <20261102015736.64157-1-treebacker@foxmail.com>
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
Content-Transfer-Encoding: 8bit

The second half of the MTU guard in __ip6_append_data() has been dead
code since the initial git import:

	if (mtu <= fragheaderlen ||
	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
		goto emsgsize;

(x & ~7) is unsigned and >= 0, and fragheaderlen is at least
sizeof(struct ipv6hdr) = 40 > sizeof(struct frag_hdr) = 8, so the
second condition can never be true.

For mtu - fragheaderlen in [1,7], (x & ~7) == 0, so

	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen - 8

underflows below fragheaderlen.  Every later bound computed as
maxfraglen - fragheaderlen then wraps to 0xfffffff8, in particular the
datalen clamp inside the fragment loop, which never fires and lets
fraglen = datalen + fragheaderlen escape the MTU constraint.

With MSG_MORE on an egress device without NETIF_F_SG, alloclen = mtu
while skb_put() is called with the unclamped fraglen, so a single
sendmsg() on a raw IPv6 socket with a 1240-byte HOPOPTS cmsg and
IPV6_MTU = fragheaderlen + 1 triggers:

  skbuff: skb_over_panic: len:61280 put:61280 ...
  kernel BUG at net/core/skbuff.c
  skb_put __ip6_append_data ip6_append_data rawv6_sendmsg

The same re-lowering exists with a transport-mode xfrm bundle: ESP/AH
bytes counted in rt->dst.header_len are not part of fragheaderlen
(ESP lacks XFRM_TYPE_NON_FRAGMENT), and ip6_append_data_mtu()
subtracts dst.header_len from mtu for the first fragment, so after
the entry guard passes, the recomputed maxfraglen can be pushed below
fragheaderlen the same way.

Remove the dead expression and, when the datagram actually has to be
fragmented, require room for at least one 8-octet payload block after
the fragment header, matching the minimum ip6_fragment() already
enforces once skb->len > mtu.  The check is placed after the dontfrag
and maxnonfragsize handling so that unfragmented datagrams that fit
within mtu, and the dontfrag PMTU notification path, keep their
current behaviour.

reserved_headerlen accounts for the first fragment's xfrm header
space regardless of whether this append is the first one on the cork:
a subsequent append that pushes an initially unfragmented datagram
past mtu still fragments, and ip6_append_data_mtu() subtracts
dst.header_len from mtu for the first fragment.  The check runs
before any zerocopy uarg is allocated, so the emsgsize path needs no
cleanup.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.22a3131380a8c@gmail.com/
Signed-off-by: bo cao <treebacker@foxmail.com>
---
Changes in v2: move the check into ip6_append_data_mtu() (review of v1).
Changes in v3: collapse the fix into a single entry check, leaving
ip6_append_data_mtu() unchanged (review of v2).
Changes in v4: gate the check on fragmentation actually being needed
and place it after the dontfrag / maxnonfragsize handling, so valid
unfragmented datagrams and the dontfrag PMTU notification path are not
affected; include dst.header_len in reserved_headerlen regardless of
!skb, so a subsequent corked append that fragments still accounts for
the first fragment's xfrm header space (review of v3).
---
 net/ipv6/ip6_output.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba98b1a..4353b154f216 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1477,7 +1477,7 @@ static int __ip6_append_data(struct sock *sk,
 	bool paged, hold_tskey = false, extra_uref = false;
 	struct ipv6_txoptions *opt = v6_cork->opt;
 	int csummode = CHECKSUM_NONE;
-	unsigned int maxnonfragsize, headersize;
+	unsigned int maxnonfragsize, headersize, reserved_headerlen;
 	unsigned int wmem_alloc_delta = 0;
 
 	skb = skb_peek_tail(queue);
@@ -1499,8 +1499,7 @@ static int __ip6_append_data(struct sock *sk,
 		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
 		     rt->rt6i_nfheader_len;
 
-	if (mtu <= fragheaderlen ||
-	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
+	if (mtu <= fragheaderlen)
 		goto emsgsize;
 
 	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -
@@ -1533,6 +1532,29 @@ static int __ip6_append_data(struct sock *sk,
 		return -EMSGSIZE;
 	}
 
+	/*
+	 * If the datagram has to be fragmented, each non-final fragment
+	 * must leave room for at least 8 bytes of payload after the
+	 * fragment header, matching the minimum ip6_fragment() enforces
+	 * once skb->len > mtu.  This rejects the MTUs that make maxfraglen
+	 * underflow below fragheaderlen and defeat the datalen clamp,
+	 * which leads to skb_over_panic() from skb_put().
+	 *
+	 * reserved_headerlen accounts for the first fragment's xfrm header
+	 * space (with a transport-mode xfrm bundle, ESP/AH bytes counted
+	 * in dst.header_len are not part of fragheaderlen), regardless of
+	 * whether this append is the first one on the cork: a subsequent
+	 * append that pushes an initially unfragmented datagram past mtu
+	 * still fragments, and ip6_append_data_mtu() subtracts
+	 * dst.header_len from mtu for the first fragment.
+	 */
+	reserved_headerlen = fragheaderlen;
+	if (!(rt->dst.flags & DST_XFRM_TUNNEL))
+		reserved_headerlen += rt->dst.header_len;
+	if (reserved_headerlen + cork->length + length > mtu &&
+	    mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8)
+		goto emsgsize;
+
 	/* CHECKSUM_PARTIAL only with no extension headers and when
 	 * we are not going to fragment
 	 */
-- 
2.39.5 (Apple Git-154)

