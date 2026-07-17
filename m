Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD702652AF
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309383; cv=none; b=L93vRECY/XGc+X7pshacj1NrtvDrwBQ5D2y9noiruZd3Z/u1KEb9MluO9o8pS0lvvbj8YauP6l6ug4X0ghoE+SVU45QMqETJhMEDpsuhDQkMW1cDaSmjYdy4+SE6SoGt3wZn7cXzeECO6hVhduREm0WFx+uK1POaTap/8uTEtd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309383; c=relaxed/simple;
	bh=LySAzJU5KwjnjOSpGUHBf/ihymwW9EWui+09fJN8qzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAs1LjsM279qzB5Od6SWQkyqGoid/Se71u5UoNirmE7oEZUQ5qkYRnx3tMjP4DE3EkgURWJUnq4yrewAdmBlKSfOiBpgY27laGx+M/YUxtEzLUKOwTvY812mhDhfur8Rux/Hgm1bjZsCjeovqnCfo7FYYDrIjTfA8suOL6qLtnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZEzrBW9I; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZEzrBW9I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=s4lIuAvNzIr4Si1M1BkJlftsW0p2e4QPX15Rd/G491E=; b=ZEzrBW9I9Tpmyud5ZthKoB2aV0
	/ifSGo78Dl3LZUdbVYOyrrsqCsLWuWObgt/GSGg89W1C4cK3KTBgDCLi1dm2EQCAYh5o5a8f74oZC
	j4v6JbeRzFug8Ic/Ay0NVZhp6qhjtVZD3ucE0/japhUMzKF8rrR4FJ+zBvLqUM5mrtikqOVkeusT8
	IGxERJydiy6PdOUeU5XSPlOq4b6saZOGOL/jcrcW9XAcYfcF5gJCbGoIS8fjLakOVwwN3ndg+595l
	yFGCRUhRVmoO6BB3q713VzJJihSyrmUbWn1r4xr51bMHw3+ERxn1i88SVRp+14eLl3bL6gyfdJcTu
	sftWO69g==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	kuniyu@amazon.com,
	kuniyu@google.com,
	Jakub Kicinski <kuba@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 2/9] af_unix: Set drop reason in unix_release_sock().
Date: Fri, 17 Jul 2026 19:29:15 +0200
Message-ID: <20260717172922.3398851-3-heiko@sntech.de>
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

[ Upstream commit c32f0bd7d4838982c6724fca0da92353f27c6f88 ]

unix_release_sock() is called when the last refcnt of struct file
is released.

Let's define a new drop reason SKB_DROP_REASON_SOCKET_CLOSE and
set it for kfree_skb() in unix_release_sock().

  # echo 1 > /sys/kernel/tracing/events/skb/kfree_skb/enable

  # python3
  >>> from socket import *
  >>> s1, s2 = socketpair(AF_UNIX)
  >>> s1.send(b'hello world')
  >>> s2.close()

  # cat /sys/kernel/tracing/trace_pipe
  ...
     python3-280 ... kfree_skb: ... protocol=0 location=unix_release_sock+0x260/0x420 reason: SOCKET_CLOSE

To be precise, unix_release_sock() is also called for a new child
socket in unix_stream_connect() when something fails, but the new
sk does not have skb in the recv queue then and no event is logged.

Note that only tcp_inbound_ao_hash() uses a similar drop reason,
SKB_DROP_REASON_TCP_CLOSE, and this can be generalised later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250116053441.5758-3-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 include/net/dropreason-core.h | 3 +++
 net/unix/af_unix.c            | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 76311b3ebfc8..06912797712a 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -6,6 +6,7 @@
 #define DEFINE_DROP_REASON(FN, FNe)	\
 	FN(NOT_SPECIFIED)		\
 	FN(NO_SOCKET)			\
+	FN(SOCKET_CLOSE)		\
 	FN(SOCKET_FILTER)		\
 	FN(SOCKET_RCVBUFF)		\
 	FN(PKT_TOO_SMALL)		\
@@ -124,6 +125,8 @@ enum skb_drop_reason {
 	 * 3) no valid child socket during 3WHS process
 	 */
 	SKB_DROP_REASON_NO_SOCKET,
+	/** @SKB_DROP_REASON_SOCKET_CLOSE: socket is close()d */
+	SKB_DROP_REASON_SOCKET_CLOSE,
 	/** @SKB_DROP_REASON_SOCKET_FILTER: dropped by socket filter */
 	SKB_DROP_REASON_SOCKET_FILTER,
 	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4682cc59b7a7..4caff11068c3 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -731,8 +731,8 @@ static void unix_release_sock(struct sock *sk, int embrion)
 		if (state == TCP_LISTEN)
 			unix_release_sock(skb->sk, 1);
 
-		/* passed fds are erased in the kfree_skb hook	      */
-		kfree_skb(skb);
+		/* passed fds are erased in the kfree_skb hook */
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
 	}
 
 	if (path.dentry)
-- 
2.53.0

