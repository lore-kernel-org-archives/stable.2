Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350108;
	b=dQoIgqN4D9Qv94NP52fjPgIBEyy9PbKtsHhzUOEkInx0hWf2ST0jB3mlaaiMZ24b5EZ8
	 X31eHrxDLO1qFXe7P6FDI+BhxjARjMpbQ/U9O9rlk9JwNLdiozEcy4EmDNsLTalZZv/f9
	 dbkuYI9fInDRtQYDAuQCrU1ba4JnvOaX5ePefCyaYd815dPC+3jBHqd6TbdWMAycw68TA
	 IQCOVR9TOl5yantNAtwVxE8P5NaTe+XcoBeajlAVY3QlV3AxAp0/08FxA46Ugsl61hrjI
	 EkoUgQQU3e78zSXR3FKLqF3m7b0zx5BeFLdGknUXoivsAvkuZOES6w7ko0D6nuOedlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350108;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=d4BubhTuUiYmur5xGsCVH9ZoMUKul8IPkNkFyKd+yDQ=;
	b=EwtwOZnttrIRAlGIsI5pEFqimbwr5nnMSCIfbjtgezYJTqQH8ZybDzlta5NtDsFPBZCi
	 0L0Dw6eL4Y18ZSZ/yumJAq9NXAT+oaD4zWZPwR/3aq0LNq2JCihecFxkpdaaoACBTk+d+
	 2n2oKpOC2DdAnyjfPB4R1OC6HqxlhnsSGetZTIBn8Bu7RPIsvmm8AV2aCJntJUfDs+Y45
	 NPY2f4PV2tEOyaY9CcoT90nsmH1clesDb1E+pqZWLFiZT/M51Q1MxSwmDAPYW9kzkKoyC
	 cjYj/ytgWcsz41lY1BhvckNDGuR/N0Pr1y6b0cyi9SKp/oIKyYUK/4rTaSVUx1skzGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=cNNJODwY;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDE7606A320;
	Fri, 30 Oct 2026 08:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FDE7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=cNNJODwY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793350101;
	bh=d4BubhTuUiYmur5xGsCVH9ZoMUKul8IPkNkFyKd+yDQ=;
	h=From:To:Cc:Subject:Date;
	b=cNNJODwYXyb6ecggHQNrNsP2vtFksmq3L9twmoZKEAe7fVdiwfLQzptPBBEQdOQPo
	 G+27LNtjlqnegiHQjSpHmOGRBGzezhUS/3EHvN0ZAdF2Y5XQYjGY+fLo7Iyma9X/KZ
	 2V/ac82ghXMElnMHMtYDA0JtZwC0vXcVUKkpAI70=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.246])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id C122FCF4; Fri, 30 Oct 2026 16:48:18 +0800
X-QQ-mid: xmsmtpt1793350098troxkh9b8
Message-ID: <tencent_AE3DA7423209553B562E5C7FBCB808EB680A@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLkXvhBrTg/wKEg6yifF/+P7RjmXEfht0G4PUBsdnxYk4Kv8gOAB
	 +Weo2kaK6+jO7fAiD9pJvDnolsZr74dL3aa2nAvyGri9LIDl8dEB4KRN5E51nqj4xHIobicwRy/U
	 QyY4rSTbcNxLrozBKSjUbwUbykHpJDRAS63eCokUlHM31j3AlyRoZHFdeosBqMO2VOr0fAMtaOET
	 HLMTbXAuHQwuhPMhe+syyKaQxn7NhHJ/5sJNbUzMRYmM7PdWAWONjjxrP/wmba0WwLWd0tOkzbZb
	 CcWOOFUU8Cpc6baZB3epmvzCppPuJYd6v027N2a2Bm8VghwD7DGvigM48bpbbGND5lSqQDouEJfT
	 6qVU65I9+gzTj7l71mYQt+crp/O4N78eqrS8Mmw6eSz0EYj4xDmI5eU4vN2uvTxtWsmSphnjZTOr
	 ckY6Hp7nUwPM52ZBRUn/4S207Wgfbjk36a/U+ZbVC9oiuFGDF/hqHsaW3OS2TuVZjWPc2LvW4TPF
	 Vy4fYB7q1mmLeL3x6kih9//Rft6xMnfCkE3hW6h5gFetQ+Aun3Njb7wgj3R16VBu76/GWQGcVoxX
	 Mf1hWkyEroEPzsBRF+rMySq+qhtkrMMZZ7E5DofIEfOwM+Q/YyLj3ylLMpvTxwSSX/+MFzoUqzcx
	 tqtDYZYeRjwU1Gznh90i5KKrCXzmdEPXjq5HEtLCOyxEb37salHMY1PkUzyjNXaj7C9/XnxHamlV
	 FtT9YibUl3S5/3887JvXSvxHSNBsB9qs3m8Eh4O1/4lyOXFGxkqmINkhF4hfGqcVsb9RrsERLGS+
	 VafikYHGu3sOysCyj7QvsyFZIT/dFsuB/aM+L8GmNHuNWTLHKMBDc+SoDFfwcII4lBamOq2a5LmV
	 SNiTQ5MYittnIgdke6y3Q6/0KdrmwD19fAdIBN88O+26gL9/Jq4aevE/0/zl8yb6wz2hV9of5XaJ
	 0jVdArDJwA4JCjV/TfqQkL+zHD25SkD5tyqS26IfRMoUr7yEccUV1btBzbggIDEF0s68yywb9gAE
	 1x1IXE+Axg9Y7ZfSrWeNV8x6dxz0ktXcZllv8bM6Coygf0fjIeKs/+3+vE+bY=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: bo cao <treebacker@foxmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	edumazet@kernel.org,
	idosch@nvidia.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] ipv6: fix dead half of the MTU guard in __ip6_append_data()
Date: Fri, 30 Oct 2026 16:48:17 +0800
X-OQ-MSGID: <20261030084817.71015-1-treebacker@foxmail.com>
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

Replace the dead expression with a single check that requires room
for at least one 8-octet payload block after the fragment header,
matching the minimum ip6_fragment() already enforces:

	reserved_headerlen = fragheaderlen;
	if (!skb && !(rt->dst.flags & DST_XFRM_TUNNEL))
		reserved_headerlen += rt->dst.header_len;

	if (mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8)
		goto emsgsize;

For the transport-mode xfrm case, pre-reserving dst.header_len in the
entry check makes the later ip6_append_data_mtu() recompute safe: the
subtracted mtu still satisfies the same minimum, so the recomputed
maxfraglen cannot drop below fragheaderlen either.  The check runs
before any zerocopy uarg is allocated, so the emsgsize path needs no
cleanup.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: bo cao <treebacker@foxmail.com>
---
Changes in v3: collapse the fix into the entry check of
__ip6_append_data() and leave ip6_append_data_mtu() unchanged, as
suggested in review of v2; this also removes the emsgsize cleanup
hazard for the zerocopy uarg and the separate maxfraglen check.
---
 net/ipv6/ip6_output.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba98b1a..936dad85f1c9 100644
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
@@ -1499,8 +1499,11 @@ static int __ip6_append_data(struct sock *sk,
 		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
 		     rt->rt6i_nfheader_len;
 
-	if (mtu <= fragheaderlen ||
-	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
+	reserved_headerlen = fragheaderlen;
+	if (!skb && !(rt->dst.flags & DST_XFRM_TUNNEL))
+		reserved_headerlen += rt->dst.header_len;
+
+	if (mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8)
 		goto emsgsize;
 
 	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -
-- 
2.39.5 (Apple Git-154)

