Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803C37268D
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309383; cv=none; b=VrnhGnVxisyee1CIsI5v5vJXn7glyQsA232yI7DP4M8aZb/AFv7AMK6MJIUVOStAI43dztEEiyGOHfWe34qK74fj4st6g2cLaDE4WNiFWajTNvEbTeuJ4v2WL8gz7Nw3hnm3E9kChoI6bWue88I5DhjFHApMIVAT6hTJnGapYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309383; c=relaxed/simple;
	bh=SgZDZf8Cw95h4aPITeQBIQZgZ5ZNicJvNVrxVJBGFEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS7ss15pWiAKyFWfwN+OQn6z0dvX82098+Hk6y7zKBk95vzUYBv9J6WjqOFNZFCRbQoxKP5O77spQIyzBnVNNApfme0lf/L1dFESMVzzsG9yepeKRjLZHknRnjHxPQ+kN/P6BKI2+EIr+2Xd6m1xNQDQw0eDe6B85K7qVBsAQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=fcZVNlYu; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="fcZVNlYu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=//vF63V8JpIEyZoVX8U9pZe/0bY+7glKcAzVktLY+cI=; b=fcZVNlYuHEiAaYLGjZCwCSEO95
	yzvv11YfOnB7yPjGHIvCDxG6BXK9KTCKmasu4EtFVZM6u+fFt24Sh+2y4D/TDQRbYTELP12ou9QYe
	3zOdg/DBrH6AhJKaO1zfOVrT/OLL9SZTr5pWnULoV4Fac0bzoJOC2408P4Ik4iatViavuxSQ9BOBj
	BmvHpMUmgO2mKSe90QYM0KRgCLSLiNigb2J8fCf26BJYXQBOPX9xcmuxf/jx2cDfprra6TJTyaoXA
	to1xl7x4YWUchsstxRZNdKwYu8QztRbYYLoV7h9lYk/S7CbGgpvM+8mR1ZkarvzdOHQuxCuuBf8U+
	2MqF/wmA==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	kuniyu@amazon.com,
	kuniyu@google.com,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 6/9] af_unix: Don't hold unix_state_lock() in __unix_dgram_recvmsg().
Date: Fri, 17 Jul 2026 19:29:19 +0200
Message-ID: <20260717172922.3398851-7-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717172922.3398851-1-heiko@sntech.de>
References: <20260717172922.3398851-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit b429a5ad19cb4efe63d18388a2a4deebcba742c6 ]

When __skb_try_recv_datagram() returns NULL in __unix_dgram_recvmsg(),
we hold unix_state_lock() unconditionally.

This is because SOCK_SEQPACKET sk needs to return EOF in case its peer
has been close()d concurrently.

This behaviour totally depends on the timing of the peer's close() and
reading sk->sk_shutdown, and taking the lock does not play a role.

Let's drop the lock from __unix_dgram_recvmsg() and use READ_ONCE().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20250702223606.1054680-2-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 net/unix/af_unix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index c64d8ee0ede4..f50049ea54a5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2463,12 +2463,10 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 					      &err, &timeo, last));
 
 	if (!skb) { /* implies iolock unlocked */
-		unix_state_lock(sk);
 		/* Signal EOF on disconnected non-blocking SEQPACKET socket. */
 		if (sk->sk_type == SOCK_SEQPACKET && err == -EAGAIN &&
-		    (sk->sk_shutdown & RCV_SHUTDOWN))
+		    (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN))
 			err = 0;
-		unix_state_unlock(sk);
 		goto out;
 	}
 
-- 
2.53.0

