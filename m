Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD9233941;
	Mon,  7 Sep 2026 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800564; cv=none; b=QhiIx0I2n3U4R0nEXkMiR6HXPLBk77HdMzbHfc4tdeEFIpQm8WOUoV3DZNnzdRy+A82xVyxeGHs2fOvpsy5CCNqqKu8RmnGQEKT3wMlUJxo/+5CRRwTSSgLyYLYuliFw3Yp2VPLCHlr4jxA8s2bMlL/k+sgWvyMBDemp8JNYID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800564; c=relaxed/simple;
	bh=X/s1XNaINmiUqzvzDx/P4+fqGZPIdSlPLAWBJ/UyuMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TsRABKXJxwwVSNCkxPbE8iMITGFxhaIgAgGjmVolbWQ4T8hewDfgrUZL7CpdcooookXUaWjExyp0Cl5p6sCPoGgxa4I9JEi/qenwzHeMvzzZ5bmCBXPqn6g154butBlCZoIH/MAk0LJQtT/ItIc66W+gLHfOpFt+aKJPyQnlkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KN1T63TQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KN1T63TQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3E81F1A1A40;
	Mon,  7 Sep 2026 17:02:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1059C60383;
	Mon,  7 Sep 2026 17:02:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B3DD11C7A34F;
	Mon,  7 Sep 2026 19:02:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788800559; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=TPBFaRQq2cT8jbiEmrzWCCDROYRAcXs2NN30XcIR25k=;
	b=KN1T63TQ3ZnSJ4mevdIUUZ4InvDmcu++2eCJ4+otbuUH2Ets5xoyZ+9kJhZ5a8xGv5PcGA
	ie0THgIg+PNDIiIFC+MWtWqHxEP93hEmg2z8WhWwgULEKaFLJdWJIkFYJBQ1q71OslYolt
	XGfIfhY/rdkh5o6hEnU1+xlwZxlhJlUkl8LVBRjdbDHL/SuqsUAHGrOwGMfdI/EhnBsvn3
	v0t5llm2Ijc4tC+YO0AjP70IQTvhfrtGuLltTx7jduCMZVSo5aQ9KLjy6tAp/lpOCmPati
	PrIMAjv9Mc1LXFZdQqfQ9dNuPReepM0H1TfedlhHr/Mo3q3+TZv613FsNO0SrQ==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 07 Sep 2026 19:02:30 +0200
Subject: [PATCH 6.12.y] tcp: clear sock_ops cb flags before force-closing a
 child socket
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-cve-2026-74268-v1-1-cacea38d7fb3@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CMBBD0atUXjNVEiCBXgWxgMHAsCgogQpU9
 e6ksHyW/EcUZmNB14zIHKzYva/wiwZ6PfQXip2qEVyIbuuS6ECZIWkV4kY8U/Jr1SWVqKdH5tn
 ev+AOsfWh/WD/38vreKM+5xqm6QtZUEhfegAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788800553; l=4566;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=eQtDX2FDK17S6DsoeWyEMqBzN907bygcNtweixVS7tM=;
 b=3rkpEAzzhblkFI6ongGK7I6+IHHAbACofPIdRX27pJXf5AMvX04hoEk7+5iin0lSw7SWL1+Aw
 tx/1VEXb78tDMiLQTFvpy9mE8M15LURzfTA6MsyxqYPpnmFTgQfO3U2
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
[ Moved inet_csk_prepare_for_destroy_sock() to inet_connection_sock.c due to header dependency ]
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 include/net/inet_connection_sock.h | 8 +-------
 include/net/tcp.h                  | 9 +++++++++
 net/ipv4/inet_connection_sock.c    | 8 ++++++++
 3 files changed, 18 insertions(+), 7 deletions(-)

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
index 91dcdb7567ac..e0bd8e76fa78 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1315,6 +1315,14 @@ void inet_csk_destroy_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(inet_csk_destroy_sock);
 
+void inet_csk_prepare_for_destroy_sock(struct sock *sk)
+{
+	/* The below has to be done to allow calling inet_csk_destroy_sock */
+	tcp_clear_sock_ops_cb_flags(sk);
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

