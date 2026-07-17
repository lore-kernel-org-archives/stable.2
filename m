Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD139A7FA
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309384; cv=none; b=h122E8RNVjvjrAE39u7xSNcudh0k1qPm6+zQreZECLK/t7E3ZyEdpgnYkXmf1zR7xZx/oElK1FPHXQ8ezU9yYzz374ga9Atvq0M0hh211xGlOtIedgpXsc+DWiPJD27v2G8hVtZKIBVwibRvJ52tBQe2cRoZjYCE0vHb3Piwmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309384; c=relaxed/simple;
	bh=liGC0x7GhTe3iGdCbfrN6gzqbAokopxe896dfAnSMu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgKvPMFaWAwIeJuHMhqJlg+He16wiBISa3Vy1v/M8i4T5LAqHGVP8n1T2zSq0OdixEiwnokqIacNddfjTaatiM/a+4Ya57u9j5MKCkiZn6BS/G/EJX84E4wgV2MC9KZCDhTW176WXeWF3FsFG/E1e0BFVIDylUPdl9ntT9sznpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=aMj2WnJ+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="aMj2WnJ+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=wnp4LPaLbBR31qGo8ikXCzW2q0JZQ0S8OzZY1vvpWhw=; b=aMj2WnJ+k53ZXfhGokUe/Mfq3t
	QUyW6d2sZCjlnoEqOb0ZnrkcVh3oZ/3/3CmzGtwYRbvCbpNEwp1gsQI6TXA/80BstplzuzAspC6fY
	r8dr3KTazI/yXLgCLZuJ/BWGLUQqeFSSVM4vsOt3PJNs0Ws0kPMtcqunJteuUaMY0oMKDTWfbitdy
	MbxZRt7onJ00E4L+nfEo5ir3iLrmP3m86YTA0eQT9IVt/npR+Lw3O9FgjsYVBzXaW/eNLcMuNQ77a
	l2R20NPGz0AikYbVG5dGIIxTLXNQ7oxJ7CIcrdlTw5ZOt7yxuu8aHMtT7QntODrIj0An7BSAYDTPL
	MobCiOcg==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	kuniyu@amazon.com,
	kuniyu@google.com,
	Jakub Kicinski <kuba@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 7/9] af_unix: Don't check SOCK_DEAD in unix_stream_read_skb().
Date: Fri, 17 Jul 2026 19:29:20 +0200
Message-ID: <20260717172922.3398851-8-heiko@sntech.de>
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

[ Upstream commit 772f01049c4b722b28b3f7025b4996379f127ebf ]

unix_stream_read_skb() checks SOCK_DEAD only when the dequeued skb is
OOB skb.

unix_stream_read_skb() is called for a SOCK_STREAM socket in SOCKMAP
when data is sent to it.

The function is invoked via sk_psock_verdict_data_ready(), which is
set to sk->sk_data_ready().

During sendmsg(), we check if the receiver has SOCK_DEAD, so there
is no point in checking it again later in ->read_skb().

Also, unix_read_skb() for SOCK_DGRAM does not have the test either.

Let's remove the SOCK_DEAD test in unix_stream_read_skb().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250702223606.1054680-3-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 net/unix/af_unix.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f50049ea54a5..a18a4b022970 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2737,14 +2737,6 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	if (unlikely(skb == READ_ONCE(u->oob_skb))) {
 		bool drop = false;
 
-		unix_state_lock(sk);
-
-		if (sock_flag(sk, SOCK_DEAD)) {
-			unix_state_unlock(sk);
-			kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
-			return -ECONNRESET;
-		}
-
 		spin_lock(&sk->sk_receive_queue.lock);
 		if (likely(skb == u->oob_skb)) {
 			WRITE_ONCE(u->oob_skb, NULL);
@@ -2752,8 +2744,6 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		}
 		spin_unlock(&sk->sk_receive_queue.lock);
 
-		unix_state_unlock(sk);
-
 		if (drop) {
 			kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
 			return -EAGAIN;
-- 
2.53.0

