Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A935B137
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309384; cv=none; b=Bn4l5Q96bhpFq9qEeipJIR36kOGVopx9tXk7c7QoI5PPnOtIXK+UiEmk6M3ntBqEofGj8Eqh+4DRcZkFJ7bdJ1EKT2Kd4Ql8hNhlKfwhH9Uu0n6Ap1ac7YxR8a8kACTQsu5eRVyG23UeFhu/b/mXXSD0NFta5T06rB8q80OwYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309384; c=relaxed/simple;
	bh=tnsYQCAHKXWaq9F840ikzkpQE1wkYiF10OrPqNhcUkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gryam3JdVgBNqP6JMT1N7aAyhXLa+rl+u6T2mrjCjGJgCK3eVEBweCbytmulussJuSm+0D9ONRN5PNNeH/2wJ+DC+nsh7Xg4wBOAVz+n62/VR/OIa7eRVzmz/4Wr5jA5pAnFsWeibXsLHqz3StHJSvD5H2sG7YT5hP9VdPC2yKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=fVbvpxC4; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="fVbvpxC4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=CpY6v5+knFLQsLC5nlGBVW2mF/Qg3X6aZVi2ffwKkbQ=; b=fVbvpxC4zzB79kw40DXdJ3pqSh
	Ejcq/HMh9FueLP6+Z+Yxsg5dYgLH7u688gapOxFkxdOfTuIZIEfvD9dFUc/Nt8cJFHhNThww52YiA
	yHDut7yttCQBWQRXO4uzrG0p16Sw1S19ZYOspqvbnD2OYzrsa61xg8VXC7XmuuqaCDmZxIlIrL1uH
	6fLPvmWRl16UtXxCRZBPhJvuh9S38LPqpBop79vb3ERsQFA+xEuOc8r83xNk16fH0MY9iln/R1jKt
	TQm3Eqn36Cp1tiLbqD5C8kAkJdtp+XoDfYqFADTcNOtsbkqAuIc4BEH1XzPdeX+rPPgq+RSEM6iTL
	JXBOeiyw==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	kuniyu@amazon.com,
	kuniyu@google.com,
	Jakub Kicinski <kuba@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 3/9] af_unix: Set drop reason in manage_oob().
Date: Fri, 17 Jul 2026 19:29:16 +0200
Message-ID: <20260717172922.3398851-4-heiko@sntech.de>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 533643b091dd6e246d57caf81e6892fa9cbb1cc9 ]

AF_UNIX SOCK_STREAM socket supports MSG_OOB.

When OOB data is sent to a socket, recv() will break at that point.

If the next recv() does not have MSG_OOB, the normal data following
the OOB data is returned.

Then, the OOB skb is dropped.

Let's define a new drop reason for that case in manage_oob().

  # echo 1 > /sys/kernel/tracing/events/skb/kfree_skb/enable

  # python3
  >>> from socket import *
  >>> s1, s2 = socketpair(AF_UNIX)
  >>> s1.send(b'a', MSG_OOB)
  >>> s1.send(b'b')
  >>> s2.recv(2)
  b'b'

  # cat /sys/kernel/tracing/trace_pipe
  ...
     python3-223 ... kfree_skb: ... location=unix_stream_read_generic+0x59e/0xc20 reason: UNIX_SKIP_OOB

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250116053441.5758-6-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 include/net/dropreason-core.h | 6 ++++++
 net/unix/af_unix.c            | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 06912797712a..07826c85d31c 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -9,6 +9,7 @@
 	FN(SOCKET_CLOSE)		\
 	FN(SOCKET_FILTER)		\
 	FN(SOCKET_RCVBUFF)		\
+	FN(UNIX_SKIP_OOB)		\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
 	FN(UDP_CSUM)			\
@@ -131,6 +132,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_FILTER,
 	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
 	SKB_DROP_REASON_SOCKET_RCVBUFF,
+	/**
+	 * @SKB_DROP_REASON_UNIX_SKIP_OOB: Out-Of-Band data is skipped by
+	 * recv() without MSG_OOB so dropped.
+	 */
+	SKB_DROP_REASON_UNIX_SKIP_OOB,
 	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
 	SKB_DROP_REASON_PKT_TOO_SMALL,
 	/** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4caff11068c3..e0f5a9382149 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2714,7 +2714,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 	spin_unlock(&sk->sk_receive_queue.lock);
 
 	consume_skb(read_skb);
-	kfree_skb(unread_skb);
+	kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
 
 	return skb;
 }
-- 
2.53.0

