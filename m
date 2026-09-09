Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85627489889
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944217; cv=none; b=oih1oJX9NCqpV8bTWssNOrsgqvSs0judk1jwSBF1fJeGijZrKpVgvtr/ftHU/0P9HBX7jVW3rH7e6jQtmoPu073U8qu+uMRwHioLwQEJem6Mf9gxyoES5N6v2JOCg6nm0fuWkX3GF8kETwc6gZ4xGlg8ZKtLnnFOQK+EXHEwN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944217; c=relaxed/simple;
	bh=JF3O1B0ruS2aFRTkmaSYRWic/aeA8sb9k9jvcclJdP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P0eZwx4zXKqgXMHLgfIbhn+ZWPU/JPngbRUW0AAKEj6bClRV2UzH4BabGVoTmJSgqU8kiMM23HnfmCUoSH0fpw2JkurR0mG+hmX1tWKEfv7fExMZPLN9R+PtB+6PpnVoOqdVHrNqMeWgSgRc76ySR5NscUy+5ILqmnHTDkWgsD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CDwauWnB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CDwauWnB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 051431A1A78;
	Wed,  9 Sep 2026 08:56:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CC74860448;
	Wed,  9 Sep 2026 08:56:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15E4811C7AF3D;
	Wed,  9 Sep 2026 10:56:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788944212; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=jhoGSO/XD6PN/mlAWTDEsoUz7/QkmzABQbv+weCnPbQ=;
	b=CDwauWnBz/mg4WpauvZGTQIf9scebzssIXSfVY7H7aezZ8D4uWVbghayq85ua+HO12bjoV
	ILLXuawZB+4SqB5jPgw8oKhUXgz9hVoXq1qle3uPVw1RKAdyPvJkZy8gpS3s+lEpuMya/F
	1THW21vDMtY6iKQpn1DJUi4Q2B9NJINF18IzvxzSw/uf/jFwGxp8j4GNAup1asq1V+FUJ7
	uZv+d33uOCVDFe+ReKNHBJR9sSeP+0EdTz3fJiRlFlGxDwhHs2xS+WN/z5wWg8iy8xxz3G
	sXU5Arq2nT+68v6vamDU83SWddQDW96Vf8ULLMnFuDMgwwXOKh85cO/f2TDT8A==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Wed, 09 Sep 2026 10:56:45 +0200
Subject: [PATCH 5.10.y] tcp: clear sock_ops cb flags before force-closing a
 child socket
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-cve-2026-74268-5-10-v1-1-374ebc121b6d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBCF4auQWTtk2tg69SrGBZYBxgWaFomGc
 HcLLL+XvH+BLEklw7VaIMmsWV9jgTlVEIdm7AW1LQZL1lMgxjgLbsDL2XpGh4bQ+YZDYGcCWyj
 Pd5JOv3v1Bq42VP/gfuz583hKnLYkrOsfX3KpH38AAAA=
X-Change-ID: 20260908-cve-2026-74268-5-10-56a899851982
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Lawrence Brakmo <brakmo@fb.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Sechang Lim <rhkrqnwk98@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788944205; l=4820;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=gfGs0ll/D/LmEzDWS0zeRunUGoOktjRYi4+zsANwh50=;
 b=RBJcJEeBsIokH9FWwAkHCPsE3jyGoCSdaKFJ6Z3FrnEfYoWKanpbyghHUJduIpbEGea5Ad3tN
 xIWjh1o9dj1Bu+CaL1CfwKDn/c7ETxpUcqAmRrsWrnUuS3eyE+5OTnv
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
 include/net/inet_connection_sock.h | 7 +------
 include/net/tcp.h                  | 9 +++++++++
 net/ipv4/inet_connection_sock.c    | 9 +++++++++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index cfb66f5a5076..5cc2b9658142 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -288,14 +288,9 @@ static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req);
 
-static inline void inet_csk_prepare_for_destroy_sock(struct sock *sk)
-{
-	/* The below has to be done to allow calling inet_csk_destroy_sock */
-	sock_set_flag(sk, SOCK_DEAD);
-	this_cpu_inc(*sk->sk_prot->orphan_count);
-}
 
 void inet_csk_destroy_sock(struct sock *sk);
+void inet_csk_prepare_for_destroy_sock(struct sock *sk);
 void inet_csk_prepare_forced_close(struct sock *sk);
 
 /*
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4c87936a33d6..f7a61e6f5ebd 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2356,6 +2356,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
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
@@ -2373,6 +2378,10 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return -EPERM;
 }
 
+static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
+{
+}
+
 #endif
 
 static inline u32 tcp_timeout_init(struct sock *sk)
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 723aab818b52..3d5816a8894f 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -933,6 +933,15 @@ void inet_csk_destroy_sock(struct sock *sk)
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
base-commit: be0af8204173441616d0775a54a95ca612a84ba8
change-id: 20260908-cve-2026-74268-5-10-56a899851982

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

