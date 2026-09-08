Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04DF1A6811;
	Tue,  8 Sep 2026 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860658; cv=none; b=Usgv/xzlZA0doZMeOwIiOMvWmlPfGOkQYyodRb0BT9+fel1CFX480L9i7BEvkC8J4U/GxkTbQ8n2CmqghzaD0duT7xnBfg89GRFm7gbvDqEPSO5+AM+45Uvz2vvnR146Gc5SM4MTqgmW5YMI3wpdMg0w8VPOwpeYyR7aycMy8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860658; c=relaxed/simple;
	bh=tV1/2vbL1jxMtILARx3VLVVgP1XTxok2Hvoa3dXSuDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uZsTbCo3oNVpc78q6DlK3DNgmWHQmaaM7qhshn84CKiMc+OD4KVf2nd8uYxXv/UBqaDu/F53EU4SzBuYLDoQvdUC6xtWMkf7NaHcc/tvXFfVF+uDB/jwcFR9D2fEjV3p23XnKexyEPubEff8UHOYqtqwSrD1UdffbrMfQszgYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z5LV5O8Z; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z5LV5O8Z"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 163AE1A1A48;
	Tue,  8 Sep 2026 09:44:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D576D603C4;
	Tue,  8 Sep 2026 09:44:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3412911C7AF45;
	Tue,  8 Sep 2026 11:44:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788860647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=4UL0rI1qhKgbhnyOjA0R1BAuU9vhQ7hOWSOXb/t/2aA=;
	b=Z5LV5O8ZFgRnjS/RpwyUYjtTADG77FnFreY9PgyxcuABpZdY3pbarNlNG4/RqisoO0smmT
	Q8n/4e+2QUBr8o7fmJwuNz+TAwYO8DGJ2eMYPHZpUPtgMXgjmTJVW9XR5n5eNUZcubrwm9
	eJ8OHeRnlQqK5s1Q3mtmFuP3OCHLmsiZGTRevK4QW0vJ3dyZDzTBkPfema5Pg1+1cO+/Ga
	KNUfhKXE2F8wK9nr1z1IESPdxDO2BpaMAA11p6mlJ4ZewfYKGDzJBzUDr17IuuT2rNSTUi
	gtjYX6IKVNMyGWaMj+FMvuzCkBFWleaUfjRYfPQtuKlEWn60ClbrjUofbJSuWQ==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 08 Sep 2026 11:43:59 +0200
Subject: [PATCH 6.12.y v2] tcp: clear sock_ops cb flags before
 force-closing a child socket
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-cve-2026-74268-v2-1-3f81ea487415@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4Xs2SW0KEVO/ofhAMsia7Q1LTYSw
 r8LePb4JjPzZgjshQNUyQyeowRxdgV9SICGxt4YpVsZdKaL7JwZpMi4AZqjLkpUbIw6EeVMDOv
 o5bmXz354hSJVOp2g/uXh3d6Zxu1taw4SRuen3RzV3v8niQoVUkPc5GVn+ja/tM6ND7EpuSfUy
 7J8ASngnFvIAAAA
X-Change-ID: 20260907-cve-2026-74268-1e7715cc3ece
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Lawrence Brakmo <brakmo@fb.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Sechang Lim <rhkrqnwk98@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788860641; l=4928;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=EZy3Ctcpk/9jzcS9g2UJ49fwPzeSX4XCW9l/AbD7+Zo=;
 b=AIeKqALHtIzuSXRgSbu3RxEzHr9F3FRqCV7zQvUYv1rLlpZ+l7LHXy2/MGvezcm7tH4kAiOWE
 UxYEOkmsyXPAGBTqOaJCFqTFzycMYUaMiKV/7XjgG7sFzE+dri7x4RN
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Sechang Lim <rhkrqnwk98@gmail.com>

[ Upstream commit 990348e5bb457697c2f1f7f7b65154a3334d9d2b ]

A child socket inherits the listener's bpf_sock_ops_cb_flags via
sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
without it.

If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():

  WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
  RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
  Call Trace:
   <IRQ>
   tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
   tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
   tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
   tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
   </IRQ>

The child is freed before it is ever established, so it should run no
sock_ops callback. Clear its cb flags in inet_csk_prepare_for_destroy_sock(),
the common point for the IPv4, IPv6 and chtls forced-close paths and for the
MPTCP ->syn_recv_sock() failure path (dispose_child), which reaches tcp_done()
on a child that was never established too.

Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260611092923.1895982-1-rhkrqnwk98@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>

[ Moved inet_csk_prepare_for_destroy_sock() to inet_connection_sock.c due to header dependency,
  Added a guard arount the call to tcp_clear_sock_ops_cb_flags to avoid
  calling it for DDCP sockets.]

Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
Changes in v2:
- Added guard around the call to tcp_clear_sock_ops_cb_flags to only
  call it for TCP socket.
- Link to v1: https://patch.msgid.link/20260907-cve-2026-74268-v1-1-cacea38d7fb3@bootlin.com
---
 include/net/inet_connection_sock.h | 8 +-------
 include/net/tcp.h                  | 9 +++++++++
 net/ipv4/inet_connection_sock.c    | 9 +++++++++
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index bcc138ff087b..534f4fafad42 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -296,14 +296,8 @@ reqsk_timeout(struct request_sock *req, unsigned long max_timeout)
 	return (unsigned long)min_t(u64, timeout, max_timeout);
 }
 
-static inline void inet_csk_prepare_for_destroy_sock(struct sock *sk)
-{
-	/* The below has to be done to allow calling inet_csk_destroy_sock */
-	sock_set_flag(sk, SOCK_DEAD);
-	this_cpu_inc(*sk->sk_prot->orphan_count);
-}
-
 void inet_csk_destroy_sock(struct sock *sk);
+void inet_csk_prepare_for_destroy_sock(struct sock *sk);
 void inet_csk_prepare_forced_close(struct sock *sk);
 
 /*
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 1cc25e0b3bde..c472c1cdd3b8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2702,6 +2702,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return tcp_call_bpf(sk, op, 3, args);
 }
 
+static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
+{
+	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
+}
+
 #else
 static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 {
@@ -2719,6 +2724,10 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return -EPERM;
 }
 
+static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
+{
+}
+
 #endif
 
 static inline u32 tcp_timeout_init(struct sock *sk)
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 91dcdb7567ac..117a424d1fee 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1315,6 +1315,15 @@ void inet_csk_destroy_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(inet_csk_destroy_sock);
 
+void inet_csk_prepare_for_destroy_sock(struct sock *sk)
+{
+	/* The below has to be done to allow calling inet_csk_destroy_sock */
+	if (sk->sk_protocol == IPPROTO_TCP)
+		tcp_clear_sock_ops_cb_flags(sk);
+	sock_set_flag(sk, SOCK_DEAD);
+	this_cpu_inc(*sk->sk_prot->orphan_count);
+}
+
 /* This function allows to force a closure of a socket after the call to
  * tcp/dccp_create_openreq_child().
  */

---
base-commit: 064531c7e30cd67b79c0c694ac97f00c7796f4d6
change-id: 20260907-cve-2026-74268-1e7715cc3ece

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

