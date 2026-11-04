Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836018;
	b=gJaxKHbZtGB4P2SGvACjjdyFT/sKRedxneXPo/nh2YbWCk3bBu12mYSld9eZJHWy0GlV
	 OLcpPfGHdto1qgpZMqU0f+9ZhLLN7NkymcTFuU6AHyZC/Ez4+i4/UFKYigppXa1/uYK4B
	 MLd9Hh1SOnfKOOUv9QIcIHEndZVRDAQgFu9+7JGJbZdAJBXE4wlCZUjzfW5F5BThcbctb
	 LcBsYuV38cBqIV+xMVzjckLIIcqRY46zUk8RI6M16jIA2FCjJo73OqLh6S3LfokIGsANP
	 w64xQ4Ij9H9oIeltXRKBL8aH2MAavTPQx06q7qXU2ckHZsFDlt6+gJaRhTuRUjD7WyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836018;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TEnzAffImc57zq8JSRKUgE0i0XHfJv+0p9Oa119x/dY=;
	b=qeWDjQXtIQx+cAwPOKbBC5Ou2cY32W4fgOEg42cYnpi3bN+O3QRNRoC07GLOa4kdkEqr
	 i+drVTqDRzP2G7DsxKTZ85wIBpM+wQxVp9hIy521jv32uveQH1RGCCXd3oYR2hVgZTYs4
	 q3PiGeNdEvzylxH0jPIxCVeKCieHputaRSErZn0+yfQHDmEcESa9Lvi7j3e67SnPnXBpf
	 jNG0DQbvi1uwJRFQj6H6UFvMzRzxzSpxZvf+OpK0QqhfbaauGB1W+P/LVPTf2H45VMbgN
	 7Y84HPYKmm9DUuUxnt109nI3tJuLo4kLYIP1NTGpTZ6dnIoZ8J9j9UujZbPoHixbivg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpUyPK6a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F4606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpUyPK6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D211F000C1;
	Wed,  4 Nov 2026 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836017;
	bh=TEnzAffImc57zq8JSRKUgE0i0XHfJv+0p9Oa119x/dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OpUyPK6ai76YF4jOOJ2/rJXmsyOFHQMKD5kjQCUTCYpMpTiEAQwzl8juZPyGd+j8r
	 Tqlr3Niae8M5jc2MkXU3l8CxNxZ3nkmo6wKon3BEeWw/s4eNards4Eaj2ZfhtXj/YJ
	 T3ZTyA1Ny8VAQdhtPvu8rDXMF/hBp56Royz11L6gAdGvG5SvABonH2uu0AiQQTr82J
	 TWwp+QVLYuG7dR1AgbUjx7sWei+KTWfIXULZoHIDzh05XhiygzLdK3mkqDBkP6hdNp
	 hcNm0ZWICMtKmBdoXa7odadsZ94p8qKQSUatMtKKyGBlP9taZFVcgyd5NIdmc7BWts
	 4AnMB8qsU45Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] tcp: Remove timeout arg from reqsk_timeout().
Date: Wed,  4 Nov 2026 18:46:54 -0500
Message-ID: <20261104234539.930903-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110448-scrambler-renovate-a361@gregkh>
References: <2026110448-scrambler-renovate-a361@gregkh>
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

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 207ce0f6bc131812c96cf4f6db328af5396cebac ]

reqsk_timeout() is always called with @timeout being TCP_RTO_MAX.

Let's remove the arg.

As a prep for the next patch, reqsk_timeout() is moved to tcp.h
and renamed to tcp_reqsk_timeout().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20251106003357.273403-5-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c9c90cf437a9 ("mptcp: hold MP_JOIN msk ref when cloning reqsk")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_connection_sock.h | 8 --------
 include/net/tcp.h                  | 7 +++++++
 net/ipv4/inet_connection_sock.c    | 2 +-
 net/ipv4/tcp_minisocks.c           | 5 +++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index d50e0afc3193f..39ccb785dd4c1 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -297,14 +297,6 @@ static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req);
 
-static inline unsigned long
-reqsk_timeout(struct request_sock *req, unsigned long max_timeout)
-{
-	u64 timeout = (u64)req->timeout << req->num_timeout;
-
-	return (unsigned long)min_t(u64, timeout, max_timeout);
-}
-
 void inet_csk_destroy_sock(struct sock *sk);
 void inet_csk_prepare_for_destroy_sock(struct sock *sk);
 void inet_csk_prepare_forced_close(struct sock *sk);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index e40bad5606486..f9bcfa8773a3a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -838,6 +838,13 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
+static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
+{
+	u64 timeout = (u64)req->timeout << req->num_timeout;
+
+	return (unsigned long)min_t(u64, timeout, TCP_RTO_MAX);
+}
+
 u32 tcp_delack_max(const struct sock *sk);
 
 /* Compute the actual rto_min value */
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6b36652d6bb9d..772964048cda0 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1128,7 +1128,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 	     inet_rsk(req)->acked)) {
 		if (req->num_timeout++ == 0)
 			atomic_dec(&queue->young);
-		mod_timer(&req->rsk_timer, jiffies + reqsk_timeout(req, TCP_RTO_MAX));
+		mod_timer(&req->rsk_timer, jiffies + tcp_reqsk_timeout(req));
 
 		if (!nreq)
 			return;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index d05009f985afc..2d78801866396 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -717,7 +717,8 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			 * it can be estimated (approximately)
 			 * from another data.
 			 */
-			tmp_opt.ts_recent_stamp = ktime_get_seconds() - reqsk_timeout(req, TCP_RTO_MAX) / HZ;
+			tmp_opt.ts_recent_stamp = ktime_get_seconds() -
+				tcp_reqsk_timeout(req) / HZ;
 			paws_reject = tcp_paws_reject(&tmp_opt, th->rst);
 		}
 	}
@@ -756,7 +757,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		    !tcp_rtx_synack(sk, req)) {
 			unsigned long expires = jiffies;
 
-			expires += reqsk_timeout(req, TCP_RTO_MAX);
+			expires += tcp_reqsk_timeout(req);
 			if (!fastopen)
 				mod_timer_pending(&req->rsk_timer, expires);
 			else
-- 
2.53.0

