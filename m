Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9A2F8E98
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787480310; cv=none; b=iCDcbRLU1H7C8l/PFBDGRIrVAcRmOVCCl6Nt2TQbBpC5SUPIdElwDi559y7KOWM+QpPnysogN+PFdOD7haySojsRsfTe5oliyM2iC8HTOR/jQiGXWD5QNAMI9kO5YxmNPWpR8UDX7gf30JZ0IEJ8rg1MSwhlfxXEL5yzUZ9J2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787480310; c=relaxed/simple;
	bh=S8BPB7Qjsw6r96pi4uoQRaT+P0oPrJHiJIl1kunlkxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDgRjZUXY38VBKbd73nkBBsFha9/oOKvX93lyCuc4NxojItfgrZuL81A7jaAjvkBBrYDkUPrFojWFTbJaDNx31egRswZQ0FqyoDM1A/314nEfOvRyPJ1McuzF/iMPYZCq9u0yvJtFbNZwLpxKRnuqrd0QfKF6blcPZTpR0ONjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhRcqSLQ; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhRcqSLQ"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3931e624fd8so1367676a91.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787480308; x=1788085108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSNVncEMgEraytLD+WR3MzrZH+OTuZ38jo7hC58bHW0=;
        b=EhRcqSLQh+BNU1/FNj1zBNreLFib369AjA/8JanTOi+6bmRpIubYUad6T3r0kpFiW7
         OmAImxPrJfoZwUPNQmqQX+aoKTY85NGFnWeKvCpcdYrcn1OXwAgFzDjUqtg4wcwWcwh2
         twm/d38q7bcpRlke2WC3aYtqB7khy7Kyzjp0xDL8Q8QclKnFbB9bN5dlfci+4WteQCFy
         7U1xwKzaQISthLZPB1EP8dXzg8taQjqg3Ba4yyp5X013+UYDVU5RdNyq6Gqm+JlKBjkX
         kxM3dqVdXXZk7vrVoK1zFhfdZfpSNuxBEapigP8MSbCs4GxEMcHz9EtGfz/4lq9A4/Kf
         UREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787480308; x=1788085108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSNVncEMgEraytLD+WR3MzrZH+OTuZ38jo7hC58bHW0=;
        b=sn79t19rkQEgl0ddSTBatOHwB9szZZxDKGINT9odwTzndWxBfP1+XqZqFLloVDcha4
         o4ZAeu2t/cXO2xS4VV9lw63alOHLZkOslX0ijgJboSrxvI3WZCzb06QTw2rf7QQZAnKp
         dE0SlZIvMCXId5OzhnHmFQ6CmXHNKn+WnUf+0e1UQvp4NN0zkfmWYtPKuVRi6cAvq7HI
         7u329CVPRUvPdh9NRlFi6k8hDEzZJ4YsPoll1lomtcbFDkTiHsK89FBCfMEDa+uP2e4j
         07sYVqDQjNKJ3V9OkNDFAC2s1mexBnKp2qJUuZSFKLfDOw/AtjbdjKsIgp4kPcPlCiiq
         2y8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqg9Il/Aq++5R/K4dHkxEtAqsTwASl9Z6Q+3TdgE2cSz0YNn4EctwGrYIHyKsdRSqdIoi6c3iY=@vger.kernel.org
X-Gm-Message-State: AFuF++nNaVOPHRJIb8HlVZEV8ooHrJjZDqbqEyzP0s1GACKTakkjdDvr
	q0Po1wG/L9l7SOa36EG9ZuWWnNAS9ZL7GhDkrMeswYe9ys2ajOhu0n50
X-Gm-Gg: AR+sD10B4lREMTYoIbjEafNZYRbvT7xJK9KZqlV/iyMJlO28SAvZDaMZM4TKuex83C9
	RN96EGl8cmVk8JR5rqOs+t6fsQ13+jUy+p2CZ7SLt/szY4+ljFEaEAXv8v41p0fYg+RtTG/0MWM
	cgFx12+EF1RQBodZ1Nb61tXoAK8BFoxB6H7P8dYkWUbXiVfpEQs5Txjx1YLDLuVUhxvvR1PKlRs
	NRDn/6Bo2KwmYJW3N7CgkRS1VPH697P1FhHMF9AxFXlQZReWHDtA/5uxJL0ZcP73FJXKywoqjH0
	MaAwD5c0T07xcDzBoQbC1xL0VBXa2x4oE31C6EgKbfIY07r6Ke9oK7ZMM+E8fAkYKUsGh4e3XLn
	sa22v1nZX51dE3KNgvDnvfYPQPQ1DU5gK5nYpvvsvGCMq4St4a81ZyuS0uEk4RxWjyveKOQMOrI
	n0SwKl/TdEJJPXo/UdDsan650+cvSL1ehQ9vIAm1l9TKYDfNTzBRCADS9JVERpbQyiKyx17Ppyh
	Z8hQpaksA==
X-Received: by 2002:a17:90b:530c:b0:395:5404:95 with SMTP id 98e67ed59e1d1-395c35516a0mr34092527a91.12.1787480307838;
        Sun, 23 Aug 2026 03:18:27 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([2409:8a55:94ee:7131:6dfa:11e6:f115:ea42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e42cc144sm5471603a91.0.2026.08.23.03.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 03:18:27 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Joe Stringer <joe@wand.net.nz>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/1] net: Don't deliver IPv6 packets to IPv4 sockets
Date: Sun, 23 Aug 2026 18:17:19 +0800
Message-ID: <20260823101809.26802-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_sk_assign() allows a TC ingress program to attach an arbitrary
hashed socket to an skb, without checking that the socket family
matches the packet's network layer. As a result, an IPv6 UDP packet
can be assigned to an AF_INET UDP socket: udpv6_rcv() steals the
socket via inet6_steal_sock(), which also lacks a family check, and
queues the IPv6 skb on the AF_INET socket.

recvmsg() on that socket then runs the IPv4 udp_recvmsg(), which
interprets the IPv6 skb control block as IPv4 IP options. When
IP_RETOPTS is enabled on the target socket, __ip_options_echo()
copies up to 153 bytes of attacker-controlled data from the IPv6
Destination Options extension header into the 40-byte option-data
area of the stack-allocated optbuf in ip_cmsg_recv_retopts():

    BUG: KASAN: stack-out-of-bounds in __ip_options_echo
    Write of size 153
    ...
    __ip_options_echo
    ip_cmsg_recv_offset
    udp_recvmsg

Reject sockets whose family is not AF_INET6 in inet6_steal_sock().
An IPv6 packet can never be legitimately delivered to an AF_INET
socket, so drop the stolen socket and return NULL, letting the
callers continue with the regular IPv6 lookup. When the socket is
refcounted, release it with sock_gen_put(), the same type-safe
helper sock_pfree() and sock_edemux() use, so the release stays
correct no matter which kind of socket a future BPF helper allows
to be assigned. This covers both the UDPv6 and TCPv6 receive
paths. The opposite direction, an IPv4 packet assigned to a
dual-stack AF_INET6 socket, remains allowed since that is a
supported configuration.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Cc: stable@vger.kernel.org
Assisted-by: GLM:GLM-5.3
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 include/net/inet6_hashtables.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 2cc5d416bbb5..b39e59efac8d 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -115,6 +115,12 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!sk)
 		return NULL;
 
+	if (unlikely(sk->sk_family != AF_INET6)) {
+		if (*refcounted)
+			sock_gen_put(sk);
+		return NULL;
+	}
+
 	if (!prefetched || !sk_fullsock(sk))
 		return sk;
 
-- 
2.43.0
