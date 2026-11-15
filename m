Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794758280;
	b=1t2mPOrE98vehDKWl+f1sKP3hIuMH5OQ2u5BZ4kXsHY1FyD45vRhGUwt1rKUu1BAKyxt
	 s7/sBBHrLFX0FOcoZzrzZZGppR04rHOlHjP6s30qEP2mdc1KJS1xC1wD+cSm9Hj5vpV2r
	 I5qJvUlI62ioVgenV/4P4beTdX0O6QaH0Ho9l9q0o0Zfp7nWC+xYQDpyduLVB4qLEEL9P
	 p25j16Se0HLSmGSqbYcHOtexHQk7vbg6Ev/8SzQiMchjIExym8kE6FjITlEABdlJwJj+2
	 Ds4494W5TmLsjuYxhNFmCr0rL0dcEEsMI712RQtyviQKrLShI+cDE7KxZPna9GWyoFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794758280;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yTztLTqw12rdN7/Uw5DEdcju+OrXmRfrHG3yaxKlPWM=;
	b=UmE9HNbLwE5gujQXVKayrocouo23h0q5/vQXpB4HMJnFTA/mx+uXBPTiEzWpRv5vtq7G
	 54CevrVVvwwtiED5tX7/FRzu/eYqNh00SrhbDdIudWcCCQfTzeDgVseMcXESgmevs4tf3
	 h6OEhC6BvV2dhVLQ5XoFJu9prQ3Sk6QR4DFbLtrkHV3xxTzER0qbqPZ3N0jrEmyJ6zDR8
	 CmdXqjG3GU4MHborePfqdTicrnMRFeKLrknQqy6DIOEdGWXDMhTQpT+8vprbaXSUFujJH
	 ZoQXCrHcJiErjHT3DjK0ggux9acS8ms0eLj9L/a4Bmi76h5+DcUOIrDL1YtDGt0zlgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GZG6Ttt5;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E4606A884;
	Sun, 15 Nov 2026 15:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F4E4606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=GZG6Ttt5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794758275; bh=yTztLTqw12rdN7/Uw5DEdcju+OrXmRfrHG3yaxKlPWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZG6Ttt5+Pk+Oew0hLOD4tI2nkCzrVmsZiPQbSVGskYtY4tE9fsJpbgttOQ6vKyQw
	 cReC9jXugKTiL/j2ATVt+TLkJ4TGN99RR1V4U7E/I3S56uEZnJHsgKqMmFcPbiuXAL
	 mIG54w6NTomD5sq1yBY6Q16WNw2qRDbJtWWQ1H6k=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:103b:e9c7:571:634c])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id E701F634; Sun, 15 Nov 2026 23:57:48 +0800
X-QQ-mid: xmsmtpt1794758271tpqvrom9e
Message-ID: <tencent_D0DCF4B132B20B70FB5AE2D9272AA4AEAF07@qq.com>
X-QQ-XMAILINFO: NbKmVx0xKz4YqwfzH4swwo7u3QuxPwORuvGLOhHfA78MNO8DDHvXZ5Ri4an+kU
	 6b39+tBmIIgI9Q9aSuKZIqhjkeYfj2Y3Eby9AVgsvUY2dpeLipcgBMJm8KEu5VWCa5xTq+8IYwJS
	 UxW7wN91vgRM6OvkEUxBwHNYrAuRfVUp+yOrVkK/JTXbCfTSxBCRIejJrEAVRcBcwJwkseGpd2F0
	 ZQGf3m5PbnTSpfFrrCkFY+QVrzKRfEWbs26LXenP+6TF+ktur0pGAN1W4JxoihC3nQcUJl/sfXVd
	 LWBkBgKhxMkOSHUY3OTU6cLpCFZNYL3O1OHBjMqIt5+0BcSD56vifQVUvkWnIKaw9S6rC7wiTyTh
	 brb6Wj3XZ2+tAUPR+y6z/G2y522sR2R31R5t3hXh4Avotd2YGnVg3LzWRWvTOhMRDKrnUjkHCv1p
	 Rtc9prhjtXGXV3pDtuCZZflvED6D9eqBluQ/K2njfXXTR/XFnnoaxj8ejuo2Ma1vI63MltUu0GFX
	 FWLtbHRGAypRQxwbDLDGNLF5ilr4QZuh4xQ8SXSqEY93jjIixnHYtF0Dnb3uQ4mOyEq/4r4YyXDz
	 rehrALxHhjNRbQm+S4oR2Cw3RYpDfnjU6D8jSau4uL8NqjsCHVfuypEFIgo5bSTYJPlGcFf8eZLg
	 ysQP2rAKj5n7E2OvQ0UwyLcXpleomSSdvZ3KnGvsjd6fHQxKt6fQdeYuJOrJkbT8DQ7iG+C1tFsb
	 82nPL6Dhzy9pe680oVl2zcxpNiDppsXZh/Xoy+4Lj+lS8s7KiVRdgNJokOcUB8BZu529dfdxHCYz
	 0eQG2yqD9uZJskCvXD8z53EZ8IUt3mBlDDxBa/59VF8INs37DQeMk1mlFZNWR1M3+H17ywvYixwy
	 fYmTDnVv0fOxl6Lvx70ruusSQdaofUeyzuENMXB0SyouowMp1GW4hSBq8HrWOhM0h349vXh7Rg9G
	 fLSTwUWsIG41xcqpku3tAELAKJJ/9uslSRycodPHuQKLQIwWctF4udE+fKiZqxW849ibtGruGpq6
	 fmcLKDXh+nJe+MzRTAcKJsK1H1W7U0r+eW8HIQg3zQl8AYAgr/gzZ5Pr7d47rQXnOi03BEOe6gKG
	 ClQH4cFsGSUsGyt4eDpRk6IDyifh40k/BhxKJVC2+FePxEKbIt4ZPzgF9z7c1jermMXoY1Y1JD2D
	 Q7SpNzDZ5d8u8ezFGZXUyPhwaGAy1LM7Q9Tqc=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
Subject: [PATCH net v4 1/3] net: mptcp: take token lookup references with acquire ordering
Date: Sun, 15 Nov 2026 23:57:45 +0800
X-OQ-MSGID: <20261115155747.178858-2-2122295973@qq.com>
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

mptcp_token_get_sock() and mptcp_token_iter_next() take a reference on a
socket found on an RCU-protected hash chain and then re-read state to
decide whether that socket is the one they were looking for.  The
re-validation is only meaningful if it is ordered after the reference
acquisition.

The sockets come from mptcp_prot.slab, which is SLAB_TYPESAFE_BY_RCU, so
the memory a reader still points at can be freed and reallocated as a new
mptcp socket while the reader is between the chain walk and the
increment.  The new owner publishes itself in sock_init_data_uid() with

	smp_wmb();
	refcount_set(&sk->sk_refcnt, 1);

and initialises the rest of the socket only afterwards.  A reader whose
increment does not carry acquire ordering can have the re-read of
msk->token and sock_net(sk) satisfied before the increment, that is
against the old object's contents, while the increment itself succeeds on
the new one.  The lookup would then hand back a socket that belongs to a
different connection, or one that is not initialised yet.

refcount_inc_not_zero() has not provided that ordering since
commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t"),
which removed the ordering the previous atomic_add_unless() based
implementation gave; refcount.h names this exact case as the reason the
acquire variants exist.

commit 5b5d8f351dd9 ("net: restore refcount ordering for lockless socket access")
restored the ordering for the IPv4/IPv6 established lookups,
inet_twsk_purge() and bpf_sk_assign().  These two mptcp sites have the
same shape and are converted as well.  There is no behaviour change on
strongly ordered CPUs.

Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
Fixes: 96d890daad05 ("mptcp: add msk interations helper")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/mptcp/token.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index e0f2823f92ef..3429b43a9f7c 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -309,7 +309,7 @@ struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token)
 		    !net_eq(sock_net(sk), net))
 			continue;
 
-		if (!refcount_inc_not_zero(&sk->sk_refcnt))
+		if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
 			goto not_found;
 
 		if (READ_ONCE(msk->token) != token ||
@@ -370,7 +370,7 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 			if (num <= *s_num)
 				continue;
 
-			if (!refcount_inc_not_zero(&sk->sk_refcnt))
+			if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
 				continue;
 
 			if (!net_eq(sock_net(sk), net)) {
-- 
2.47.3

