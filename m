Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D239A808
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309384; cv=none; b=a0QUS8JWo8hPGwWH8IaWPK1Htwhm5HUb2cURKFqDpcLL29GMAJ+yeWJgD7ZQHHpcKpqmDS5Oro05CjSssgRt/o+pXgPyhAXLtyMGKeLSe0PyNfTERnwCxDOtSPWeclND6VmCsBDO4yMqZIY0hG4GVdeZZfHxIeP5GyQ7gsHmBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309384; c=relaxed/simple;
	bh=6aQcWQSD5U51/gieI061vR7ucQYXBNEF4CylM7xlErs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tf4T+Sy3nE/XqUn22EOhH3oIHkAr8XTZps1dNaVjJa8qBOUspFeY3aEsvgI+2R7QqD+TFt9Ts2ZXQF8Oc8vLNer00cjvVEFcXaWr3vykY3F6yg1xUxC7+7RmnPXzefnpSmTTUWUIIrYZLw7/uz7ecbP97wromI456kopp0+s35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=f9Z/+TmA; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="f9Z/+TmA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=HL9WPv5ThIJKrIQZG8RqXMS9KKDk4aKZQQsAXwMSQrk=; b=f9Z/+TmAltV9SfMf6uZn+fqP8V
	RZPamUbf6W3nJv2szzOyXlEPJM06uUhuVV0DWdZIAm5e4mcELq/R2k7H9VPmWPIay60zAH5ZYaoBm
	hMLtTzXZBOe2R1Cigme907Gzz6bMe3IztcNzwBEkWxMoA/LNXm2YRoVaptSvsHkWxF86SR/SMYgs2
	Kk8P3YF5iIoy1KLlRS2OHdMxntQJUZEiJWgtQEFoXSTef/QdgB3l0EJbeQRiOtYyfCi1T5sz1ewHm
	C7mDsf4UWw50O+WPXNm7rzanSigSVEos8qjgkuo3IwHB9ilLvDqAmEo/EgyJu0mJbQhthWoqTLS//
	SAzWMNPg==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	kuniyu@amazon.com,
	kuniyu@google.com,
	Jakub Kicinski <kuba@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 8/9] af_unix: Don't use skb_recv_datagram() in unix_stream_read_skb().
Date: Fri, 17 Jul 2026 19:29:21 +0200
Message-ID: <20260717172922.3398851-9-heiko@sntech.de>
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

[ Upstream commit d0aac85449dec992bb8dc2503f2cb9e94ef436db ]

unix_stream_read_skb() calls skb_recv_datagram() with MSG_DONTWAIT,
which is mostly equivalent to sock_error(sk) + skb_dequeue().

In the following patch, we will add a new field to cache the number
of bytes in the receive queue.  Then, we want to avoid introducing
atomic ops in the fast path, so we will reuse the receive queue lock.

As a preparation for the change, let's not use skb_recv_datagram()
in unix_stream_read_skb().

Note that sock_error() is now moved out of the u->iolock mutex as
the mutex does not synchronise the peer's close() at all.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250702223606.1054680-4-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 net/unix/af_unix.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a18a4b022970..f1e81843c1b0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2720,6 +2720,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
 static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
+	struct sk_buff_head *queue = &sk->sk_receive_queue;
 	struct unix_sock *u = unix_sk(sk);
 	struct sk_buff *skb;
 	int err;
@@ -2727,30 +2728,34 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED))
 		return -ENOTCONN;
 
-	mutex_lock(&u->iolock);
-	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
-	mutex_unlock(&u->iolock);
-	if (!skb)
+	err = sock_error(sk);
+	if (err)
 		return err;
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	if (unlikely(skb == READ_ONCE(u->oob_skb))) {
-		bool drop = false;
+	mutex_lock(&u->iolock);
+	spin_lock(&queue->lock);
 
-		spin_lock(&sk->sk_receive_queue.lock);
-		if (likely(skb == u->oob_skb)) {
-			WRITE_ONCE(u->oob_skb, NULL);
-			drop = true;
-		}
-		spin_unlock(&sk->sk_receive_queue.lock);
+	skb = __skb_dequeue(queue);
+	if (!skb) {
+		spin_unlock(&queue->lock);
+		mutex_unlock(&u->iolock);
+		return -EAGAIN;
+	}
 
-		if (drop) {
-			kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
-			return -EAGAIN;
-		}
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	if (skb == u->oob_skb) {
+		WRITE_ONCE(u->oob_skb, NULL);
+		spin_unlock(&queue->lock);
+		mutex_unlock(&u->iolock);
+
+		kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
+		return -EAGAIN;
 	}
 #endif
 
+	spin_unlock(&queue->lock);
+	mutex_unlock(&u->iolock);
+
 	return recv_actor(sk, skb);
 }
 
-- 
2.53.0

