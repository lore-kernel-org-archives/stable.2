Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794758286;
	b=sXRuYKYF4n/QG7V6djkXTQiX18mdIXw+z5NpOXFOGDaMhxn5GNNfXZQsKWlrlYzVjyZM
	 QOOZ5+d/nLhv11n5Me5G2Sool8le+Jpdes3K7HcxT3uYzJSSjQJnw1FF7LCaiCXq8e44I
	 XG8xxCwroe/kPGSdBVQWyaXmA/L9htJRvXVaROKuFcGP2jLdoU5VJbNiBEhu8XJ6p+qwO
	 2fr/XMURvx0sl6BGSFvo3dgW7i/ZC6pxM+JEowJ/v+SBGsEhZ9/xZto9zVH+wHp2Vh0DX
	 70GPeaRh1W3IimEesu8bqqzo21BhBDDskavdHZL7v9/V4v/OcsOe3S7Pr2B6368v7Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794758286;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P6Yuh683q5aNH3HN18bjb0/+LSo0udXf08N/NrFxA9s=;
	b=Dgtjtnl75ohFK6+J2P3t/sul5NBBHENNceYykzmt1Mm5Hq5f8Q1JSEAqz8wMTJkMph/H
	 hrk4daX1+/YWP6CZXvXGmeClWPOkv55K9+QoNqTjkx9RD39ocIdOMUHNZF/kLCpcoD9N9
	 O1065YbCgmr0MgD1MGRjAswdttiUqmePIwUoU4RQ2bEGwNU6AJmuorgGkK9/XkxZ/BJo9
	 he+zlZYjUT11gup/VmcFvQMXFMeqB5USQbmvqGISy2sb72hJQ9P2B03YFn67Zy68WCJrp
	 9/hPi/Go5dqKl0KHdkUvvVqbGJGGkRF/0VVaGsE5oWsbflpKu0VsMxPVYu3p2JAeENQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jiuJ87M1;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A319606A8A3;
	Sun, 15 Nov 2026 15:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A319606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jiuJ87M1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794758281; bh=P6Yuh683q5aNH3HN18bjb0/+LSo0udXf08N/NrFxA9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jiuJ87M1miPF1rOjwNNhGHY8FDRjh/W4RNlnNKcDUKpqZMkK2tYGrJJytB2ZZUlbe
	 3vKJQhnDNwsOGLBFBQ9Zs7sdTdP8IU0hiM4ZASyaazHy7elUsC+eaXdWT3SYiBc6lD
	 ebhlu3ZAE2xz2d+JH8rhtfK+xzu22YsSnCPCF+DE=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:103b:e9c7:571:634c])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id E701F634; Sun, 15 Nov 2026 23:57:48 +0800
X-QQ-mid: xmsmtpt1794758276ts8204fuk
Message-ID: <tencent_647B95315D18DBA311A33E8120517E1DA60A@qq.com>
X-QQ-XMAILINFO: M1MPMfFwhktTc5Lq75+GxKYba1EwgBbknoSdzVahXq96JdfuepVwINZizr/3z6
	 EqsRscknwvhOoa01E5YvqKsXMOcAZTCpzLVys4mGZiASftATx+0sT/VHuttBGBZdXpsv2J3SxGdn
	 YZCYpTsC2g0K/PJZYWVQ3n1a62VowBPhn7C1rY9xyJWJQ4WPfnYY7xFrg+Vpyjxf/10tvsjyrRJe
	 pb1bVor63qPXVugYO8lggiTu21NGMVW3/3UIUdUG5mFg5/OAd18FSXvdyDFVsy2g7sq8AkqDA7uK
	 4n6zZcKg1QmTolumyHzlHj0r2nutjXa6/weoFSYjDgSjXamKek7PB8u1iqTMm20H3lvUoOyAhUKq
	 nBnjS1/sn1e6GC0fPiPsAWWu/l4oxWtuH7tpJKK4akuvuPRdjWbqMaZmYmhOCfNxoY/GIyvmPg1/
	 pGT/X1n5BP93mO4eyfFXUEC0LpYSPkjc3ApriIwI+l7iXnZlP8O1L915DlKAP+smEjieIN8YqUir
	 YDGWFsu3KUNtbpG53eTdSiEtbXhHxzCfTjVmTzE/7IHYVMNE449IL6Axs8eglUG48gozqzCidK6I
	 G943VgOAlunYY4GEMA/S8PxWWPyWRoIUmmrUJCxfvZTrEqa90iog5mvnB1EmIMFsStjFlsjCHq0J
	 Xw/uuv1Cpob2pXzlJvf3axP4HdhJLWGNJE8lq1hOiilSY+bamX8uB/t1rinpZguBjFd33UlTIX0Q
	 scJ+AwVrRVAHGCH8MiM0iGlIOCL78X4Y9vM52nGjTCj85sjZ3W0gcKDkfM8WQQbPkioG9MZ8qS4u
	 sOqhWpJ5GMK4N02jaQyKKiq5F3ex1bT8FD/eEwjU4vKUfqQgIqVW/7677b0GYPUNHWQ7y+wuedsg
	 Z7H2D90yIjohp5WPgGzDfpDMzs1OXO613lz5HT3PcTJMeHSyF4ZzcfRCsoE2u3am5tlN00cthBK4
	 BDjqAV/q1T32LCvSXTXT+nzb2SARh7i8jl/wFHFTseP1Xvbj5srJ4q8qelPEzNNQHSTZwBnSPjKL
	 pDGiIlynM1xbEszv75swU0hdZajyeOdFhc226HFd1sSqXGAsZfe115GKSSvKfYdimfhu4hxrrDq8
	 N8WZYTvNbqXkmqE9CbM1QZjukFp9USz2B5caH02wG7aNLOu9pcWNmbO1It0YOAh5ENK4fVrgWS0K
	 bfHkCTwNDcrL7nEdMzdSGUrlHLNt5J9IR0TJw=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	2122295973@qq.com
Subject: [PATCH net v4 3/3] net: mptcp: verify the token slot in mptcp_token_iter_next()
Date: Sun, 15 Nov 2026 23:57:47 +0800
X-OQ-MSGID: <20261115155747.178858-4-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115155747.178858-1-2122295973@qq.com>
References: <20261115155747.178858-1-2122295973@qq.com>
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

mptcp_token_iter_next() takes a reference on a socket found on the chain
of the slot it is walking and then re-checks only net_eq().  A socket
that was freed and whose memory has been reused by a new msk in the same
network namespace passes that check while it is still zeroed, and the
callers - mptcp_diag and the userspace path manager - then use mptcp_pm
state that has not been initialised yet.

The token of a socket on a chain always hashes to the slot being walked,
and token 0 is never assigned, so re-read the token after the acquisition
and drop the socket unless it is non-zero and still maps to this slot.

Fixes: 96d890daad05 ("mptcp: add msk interations helper")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/mptcp/token.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 8a603fc8dc05..48470d6e751d 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -355,6 +355,7 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 	struct mptcp_sock *ret = NULL;
 	struct hlist_nulls_node *pos;
 	int slot, num = 0;
+	u32 token;
 
 	for (slot = *s_slot; slot <= token_mask; *s_num = 0, slot++) {
 		struct token_bucket *bucket = &token_hash[slot];
@@ -377,7 +378,9 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 			if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
 				continue;
 
-			if (!net_eq(sock_net(sk), net)) {
+			token = READ_ONCE(mptcp_sk(sk)->token);
+			if (!token || (token & token_mask) != slot ||
+			    !net_eq(sock_net(sk), net)) {
 				sock_put(sk);
 				continue;
 			}
-- 
2.47.3

