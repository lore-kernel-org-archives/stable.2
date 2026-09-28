Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFFC4FE2FD
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631128; cv=none; b=UidOS/hkf5KvxleZOecdTgGgPisJZBlvn8F6mEgWK/JiT7m+8PLF0xFoqq2b+JgPeKtVofuQGkOkmyo/8lR/L8AB/SzokdQJ5NVjwRAkE2lcMEC8SAHZpY2G6O3jSuQnu9WvPGaQRbsB2lFrZGzckQDXXwDtuZRE6udnkO1RkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631128; c=relaxed/simple;
	bh=/brgKhzdWcWlLdCx4WE05Qvg5rHn6oSwveO9sxETu0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3vDgAIu7l85FAw7EnRlaRyv89Dk7q6k69ctZNmo2i1sJ7BTjZ9W7U4gsu4PGCQhYT+MLwTE7v4rlUgZRjzRaklNxoJ4p71Va9aOjfT0S5ghETBPLZZZi8eWZ2JTc+BLNSOWQGIxlzHnPrq/wDXu28N//nHRGq9VJGcus4wAqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=CgOtzpTW; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="CgOtzpTW"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-81b8e8e9cb0so1302541a34.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790631121; x=1791235921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iygu2zvwRpC9Zkpi+d3GRtu2GZQ+sbLHR8UiqU5TYv8=;
        b=CgOtzpTWtmdDyz7saJ5N0hk3z9hiO/VatUTKUIo6vsX06uOWIHoeWByOYWVC8s72OS
         lvqX7e/yImfK3xAGjg4ng5fL8UXE2rwxsQrdXE1a70gjEjOvt/1UiUMAzvevON1lJX+a
         QlO0syXi8pBlpWY8v8s3gLSOB3pXcY7+L+4RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790631121; x=1791235921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iygu2zvwRpC9Zkpi+d3GRtu2GZQ+sbLHR8UiqU5TYv8=;
        b=n7bfC6SgnPoses7/wsYFeqxtmbaWGnKg3ko6RTfSyhaJ6zBUgzGFkK9mqoTaUz6pcr
         2VdKH7b4O9cg5j4C6oCRfWyZVBwqWEUq0vZvDbz52h3lMB2fu8ixkt08+prYqPAhUFFF
         ppqYwWM/eaIp7J075peDK7Y+RoS+YE8FDFtBuZAu5/3MSYHnoLbgscpspTJY3j/IrSq4
         OeCJ8detI2vDLirEmRAnRpc5/H3m7ACOe1m4XEjTR+zyApHZf81gE4XRcFQni28LOQY/
         xPUIic2wn9+/pFoj4bjtMFZhRHE1pEuiuv2okQZwc63DGBt7f0Ivh3iLqF27p7pDCva9
         n++A==
X-Forwarded-Encrypted: i=1; AKwUvBwTNgzaZHXumQp1lUXsiwah+gHHUvzIl2p0f2s7WmHREqYvrDm3D9N1zZnawc5AHuqma/SFIlw=@vger.kernel.org
X-Gm-Message-State: AFuF++kFkUdQMrtc88i/GUF5nNiXRc20s0+yFZGogZuClcEYd51GOEWg
	7HAPYOn2Y4tUaGc2QD5SeJ05bpJ1PSOotCfyuyjPK+PrjHmQQdQ/6jt9qzGCoZExoP8=
X-Gm-Gg: AYBFou08bL3DgMoPBiO4JN6BX49BY0YTH/lB41kyM4O/tGSoPJqRIwcdBTrciub4FPy
	m3iwc8DEl1hOW0LCHOPYTEwVXjJ0elSEo9qknv3noYYqnLHks5KT3NHPyW6JTfXV5RemVO2iWlB
	Vdb2oNTZuMK1BTfvf3p9j2GTav5WLTHomOaA/OXkzyT6QiJINTBKb5uXvRaX51+aSudanO2uOIX
	RhU0L43ACgW5Ab0x1ysdaxU3w2CDLmBeeEIHv/8UVmXTf8vY7l/DH6vOll0N9kDe1kVUl6RHM7c
	GCvutbMnQNMoki9ev05YeM5f0aP62MUd1LPQesMFU/iDa+26Mc/jlKN6N2oCNLLEnen6ni3WYRv
	kbjCoUdwoj0w+SZW4U7EAfxP+znFkuBGs8vjZmqxTipzsu9K0rkwZZfMxeArkN9+pfrFAUZTvUp
	mCtmz/S/gWi9l5A4F/20VS6wca7cnqRmdlE6BjbzrO2sw4Hq/pGxOc2w5+JFwCQxEOCFYJZCbSG
	iswQQI9S9rhy70JWf2H4H20oAqQJR3uhjZxFlgEzO3S77811WqdWsyuU3dwtZ+E8tvtH6DXWec=
X-Received: by 2002:a05:6830:270a:b0:81b:a5aa:e82b with SMTP id 46e09a7af769-81ba5aaea16mr4940048a34.24.1790631120670;
        Mon, 28 Sep 2026 14:32:00 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d57ef36b0sm2552238a34.6.2026.09.28.14.31.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 14:32:00 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Kyle Zeng <kylebot@openai.com>,
	Yue Sun <samsun1006219@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/smc: prevent TCP from retaining freed address-family ops
Date: Mon, 28 Sep 2026 14:31:53 -0700
Message-ID: <20260928213153.36141-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yue Sun reported a KASAN use-after-free in tcp_sync_mss() after an
AF_SMC socket entered TCP fallback and listen failed. smc_listen()
installs an address-family operations table embedded in smc_sock, but
its error path leaves the table installed. TCP can outlive the SMC
socket and dereference the freed table. Retrying listen also saves the
SMC wrapper as the original operations and can recurse indefinitely.

Restore the original operations after a failed listen and before
releasing the internal TCP socket. The latter also covers a fallback
listener reused as an active TCP socket. Serialize installation and
restoration with the TCP socket lock, and restore only if the embedded
table is still installed, preserving a concurrent address-family
conversion.

Enable the existing RCU-delayed SMC socket destruction before publishing
the listener callbacks, including on failed listen. Compare a child's
operations with the embedded table itself so that concurrent restoration
of the parent's operations cannot leave the child holding that table.

SMC fallback exposes the kernel TCP socket through the socket file.
Reject attaching the MPTCP ULP to such a socket: otherwise userspace
can bypass smc_setsockopt() and MPTCP can retain the embedded table in
its subflow context. MPTCP's own creation path still attaches its ULP
before the new kernel socket is associated with a file.

A standalone userspace reproducer forces listen to fail with
EADDRINUSE, enters TCP fallback, and closes the SMC owner with data
queued behind a zero receive window. A TCP probe then reports a KASAN
use-after-free in __tcp_transmit_skb() when reading net_header_len.
The same binary completes without a KASAN report after this change.
The complete x86_64 SMC and MPTCP code was compiled.

Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
Fixes: 2303f994b3e1 ("mptcp: Associate MPTCP context with TCP socket")
Reported-by: Yue Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/netdev/20260713085238.16780-1-samsun1006219@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/mptcp/subflow.c |  7 ++++---
 net/smc/af_smc.c    | 14 +++++++++++---
 net/smc/smc_close.c |  6 ++++++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f0a6725d2c37..da7ac71344a9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1984,10 +1984,11 @@ static int subflow_ulp_init(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 	int err = 0;
 
-	/* disallow attaching ULP to a socket unless it has been
-	 * created with sock_create_kern()
+	/* Only attach to a kernel-created socket that has not been
+	 * exposed through a file.
 	 */
-	if (!sk->sk_kern_sock) {
+	if (!sk->sk_kern_sock ||
+	    (sk->sk_socket && READ_ONCE(sk->sk_socket->file))) {
 		err = -EOPNOTSUPP;
 		goto out;
 	}
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e9f93b3ab435..dbbe7d6574e4 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -157,7 +157,7 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 		rcu_assign_sk_user_data(child, NULL);
 
 		/* v4-mapped sockets don't inherit parent ops. Don't restore. */
-		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
+		if (inet_csk(child)->icsk_af_ops == &smc->af_ops)
 			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
 	}
 	sock_put(&smc->sk);
@@ -2671,6 +2671,8 @@ int smc_listen(struct socket *sock, int backlog)
 	if (!smc->use_fallback)
 		tcp_sk(smc->clcsock->sk)->syn_smc = 1;
 
+	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	/* save original sk_data_ready function and establish
 	 * smc-specific sk_data_ready function
 	 */
@@ -2682,18 +2684,25 @@ int smc_listen(struct socket *sock, int backlog)
 	write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
 
 	/* save original ops */
+	lock_sock(smc->clcsock->sk);
 	smc->ori_af_ops = inet_csk(smc->clcsock->sk)->icsk_af_ops;
 
 	smc->af_ops = *smc->ori_af_ops;
 	smc->af_ops.syn_recv_sock = smc_tcp_syn_recv_sock;
 
-	inet_csk(smc->clcsock->sk)->icsk_af_ops = &smc->af_ops;
+	WRITE_ONCE(inet_csk(smc->clcsock->sk)->icsk_af_ops, &smc->af_ops);
+	release_sock(smc->clcsock->sk);
 
 	if (smc->limit_smc_hs)
 		tcp_sk(smc->clcsock->sk)->smc_hs_congested = smc_hs_congested;
 
 	rc = kernel_listen(smc->clcsock, backlog);
 	if (rc) {
+		lock_sock(smc->clcsock->sk);
+		if (inet_csk(smc->clcsock->sk)->icsk_af_ops == &smc->af_ops)
+			WRITE_ONCE(inet_csk(smc->clcsock->sk)->icsk_af_ops,
+				   smc->ori_af_ops);
+		release_sock(smc->clcsock->sk);
 		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
 		smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
 				       &smc->clcsk_data_ready);
@@ -2701,7 +2710,6 @@ int smc_listen(struct socket *sock, int backlog)
 		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
 		goto out;
 	}
-	sock_set_flag(sk, SOCK_RCU_FREE);
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	sk->sk_state = SMC_LISTEN;
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index bb0313ef5f7c..c59e578f3e52 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -24,12 +24,18 @@
 void smc_clcsock_release(struct smc_sock *smc)
 {
 	struct socket *tcp;
+	struct sock *sk;
 
 	if (smc->listen_smc && current_work() != &smc->smc_listen_work)
 		cancel_work_sync(&smc->smc_listen_work);
 	mutex_lock(&smc->clcsock_release_lock);
 	if (smc->clcsock) {
 		tcp = smc->clcsock;
+		sk = tcp->sk;
+		lock_sock(sk);
+		if (inet_csk(sk)->icsk_af_ops == &smc->af_ops)
+			WRITE_ONCE(inet_csk(sk)->icsk_af_ops, smc->ori_af_ops);
+		release_sock(sk);
 		smc->clcsock = NULL;
 		sock_release(tcp);
 	}
-- 
2.55.0.openai.867.ga7d5542d7eda

