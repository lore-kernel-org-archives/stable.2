Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794525889;
	b=A4QZHEewLt+n+fvDhdqJ9zyKD7ubaWC3vhyNP1SIvix7kMykc8MvAEdKP72Mtf+oBaff
	 48SIX+Muq8LbbdD3X6nU+r/4l/n9h8pOB2W8gbAlVAyd3O8/wMW9iRRO/Wohfepp4dLxK
	 /OAA6pBOOSDlTL4izhnWpXyomC6NE5IXeUtZOB8Ny2BYfH7HbmPZxZHzQYG6X5gv+fnHM
	 EXs5+2UmoE+1mKFOLjDSNPUkY6OE0zaoJrKiq1G7AqPPbW3qQKGjuzPJpPRQ8vXq4rSox
	 cnSXBaSGsIsptRZkmixbSEzZ8R7REfWMdvy0MTCjbtFVGcPSpp+xOyqXrlE0UER3F1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dQtnRpjgcfoePJ8DrV9q5s9+ULYVaqezzT//ZbLef6o=;
	b=hbBeSlTeXi7xqS4NESv3opKDbEgIqO2F71P3N0tezus1cC7asAptEJMBZnKpD9a+Oxsn
	 VV17OPBWSaB/+wedoF2DVueAbkDedSjLpLbmm6EQNqd2fc4gjIQ3zTO5uwA4gQfTpWK6K
	 M/aq6B1bY/XkVczAngH4TpTmaClNaeuzO0llwwfwmu2CQVp2Ufx1NeY0IDWJBO6/AHPDZ
	 GcJDNAWOtpbg/c7m7s7Wdrhh4dO4Qygt0HnDbRzkx5jPcCkrqyHG28uG83NOrJ4XtPsOb
	 Vz6FyUzM+T1EG+Wbal79c+GXTeZT0rMu9+EkLo8gH64ahbXhuosGY4FWm6Z7OC/oUnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=GdUiTINs;
	arc=none smtp.remote-ip=209.85.214.225
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1C606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DC1C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=GdUiTINs
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2ed11653a91so3058045ad.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794525887; x=1795130687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dQtnRpjgcfoePJ8DrV9q5s9+ULYVaqezzT//ZbLef6o=;
        b=GdUiTINsJdQS0parcUxxBF7RvgOv2P0+/QaTDMwIi7QVLGOgRuuqugRuY3m49IdULg
         +03xc+b7vO4YaZva9++zPRDM83/01emXIOaCUOs25aV+MB2+/qplMFy++LHOK5OyCddp
         uJdWGdwDryzEUZDM1BBLVzy0bKbWV4EnuBh9XVgchiBjIMzjGMkCMoFnX2PC0cS1LnFC
         W/MhPIM2c46QUoQrGJAdqFW+74eakxPHy6eqwiS10ulYQk+fSRqgXnWZnGn3onCEAR3E
         iJ5LCqbH1GaH7/e3+EUv2JX55sH5uOszxzezTIpjYhpgkwJbAUz2iUljXrODkByeTSNj
         7x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794525887; x=1795130687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dQtnRpjgcfoePJ8DrV9q5s9+ULYVaqezzT//ZbLef6o=;
        b=qRTh9LiIOcfRhqDrSYRytyjeS7LVhPhvVCxJ3ggHF+DI+xS167sdp/s9/zqARtPZRv
         BkFZhS8FxTvzGZvuMBu9rixm1M3hcvzZDsmKewGSzInSkUdxXcVKpqeI1pPppZ50wrRW
         D55JrQmvIBI7nQyuNIo/w2SVmrKHpahpKqyjwf7nU5VELagNC17cOE9NWUGjb+pi5sm1
         lLFALh1hBdvqAwutiEPdnxA27KdrgUrbd8Yvd6EMt9Y8D+nuLnHxDwxiG6N0Uuek+3n7
         hWJoxJ1clHxtVfYjpgS6+IN1N8lbbOOdkUiKhzBAQlaqkRNBrh/1q/gD6f9P0V9Osriv
         MTDQ==
X-Forwarded-Encrypted: i=1; AL+hErHKTqpnWd8Q3ZLU/cojK1I3qzFAQYCGBkjhSWNMhz6J2pfyDcH225MnO3Rl5yoE9ORiOG76rA8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OizmYLdSvZYM39jwD+2fTxXRsRgaCbTaHuCuMmAdBUJuSRLkp
	lX7Ym1Pb4tKIeuDp9PvU0GCsIkqTw+5H9BvQRbyTRwmBUehOoQcSmXepywH9fkTAMu75Ex8YDPo
	IxjVZ5/LesVNorKvvrU9ZKODzx0lpXOcUCJiz
X-Gm-Gg: AYBFou2SzQ5W3wKwUSsOPzOFN+J4LFFdufkMrR/BOWOwcD7tEBMqyA9M6Xy33S+rpUf
	LdaK2mS3wSUyihMAi9Hku6HtCqyYQYHsBfDPYtCNrp7HZHqbkIMzF0ZnG0lOsXMw1XqtiUvvDXL
	fINqalNJyo4cdtr9o6QrbFDgbzC+k6+vWz6xz/iiXdp48EhFFWORnS1jd61sFFTOOkyZoOc3GNz
	fuXY/+269uGNQdkj/YAoNgwPcwuwIjmNecFiajTYC6dnlKK9nqRDKtYKfhPlWrthfqMRWQdU59P
	2pKz/GXyUBFhdRobY2emT62HyJa9/TI0sOqH7ZzG86HFF6Gxl2ThjQeMAmHo8GzEmuBerccJ/jF
	lnajExYn6fWgd08SNvD/xA7YLLFmstiEB4gg=
X-Received: by 2002:a17:903:8cd:b0:2ed:3d88:4c24 with SMTP id d9443c01a7336-2ee0dad04a4mr7831835ad.27.1794525887504;
        Thu, 12 Nov 2026 15:24:47 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ee0fa3f7d2sm295725ad.55.2026.11.12.15.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 15:24:47 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 3AF744017C;
	Thu, 12 Nov 2026 16:24:46 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 3468FDCE0C7; Thu, 12 Nov 2026 16:24:46 -0700 (MST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v7] kcm: reject TLS on attached TCP sockets
Date: Thu, 12 Nov 2026 16:24:43 -0700
Message-ID: <20261112232444.2865382-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

KCM calls read_sock() from its receive callback in atomic context. With
kTLS RX, this reaches tls_sw_read_sock(), which can sleep. KCM and TLS
also replace socket callbacks, so detaching KCM can discard TLS handlers.

Found by code review and reproduced on an unmodified kernel with
CONFIG_DEBUG_ATOMIC_SLEEP by sending TLS records to a KCM-attached
socket with software kTLS RX.

Reject sockets with an installed ULP in kcm_attach(), and reject TLS
installation while KCM is attached. Track attachment in a tcp_sock boolean
present when CONFIG_AF_KCM is enabled, and clear it on detach. Both checks
run under the transport socket lock.

Use sk_is_tcp() before accessing TCP state. Checking only the family and
IPPROTO_TCP also accepts raw sockets, whose allocations do not contain
inet_connection_sock or tcp_sock.

Backports without commit 8cc3aef0cb198 ("tcp: Do not allow buggy
transitions between ehash and lhash2.") must also prevent attached
sockets from becoming listeners after disconnect.

Validated with KASAN and lockdep, including connected IPv4/IPv6 raw
sockets, both TLS/KCM orders, detach and concurrent installation.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Cc: <stable@vger.kernel.org> # see backport requirement above
Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55@linux.dev/
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 Documentation/networking/kcm.rst |  3 +++
 include/linux/tcp.h              |  3 +++
 include/net/tcp.h                |  9 +++++++++
 net/kcm/kcmsock.c                | 16 +++++++++++++---
 net/tls/tls_main.c               |  3 +++
 5 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/kcm.rst b/Documentation/networking/kcm.rst
index 71f44d0beaa3..07778f29211c 100644
--- a/Documentation/networking/kcm.rst
+++ b/Documentation/networking/kcm.rst
@@ -167,6 +167,9 @@ The kcm_attach structure contains:
   - fd: file descriptor for TCP socket being attached
   - bpf_prog_fd: file descriptor for compiled BPF program downloaded
 
+The transport socket must be a TCP stream socket with no TCP ULP installed.
+TLS cannot be enabled on a transport socket while it is attached to KCM.
+
 Unattach transport sockets
 --------------------------
 
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e6b79cf4798f..d4b07fbae2d5 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -516,6 +516,9 @@ struct tcp_sock {
 #if IS_ENABLED(CONFIG_MPTCP)
 	bool	is_mptcp;
 #endif
+#if IS_ENABLED(CONFIG_AF_KCM)
+	bool	kcm_attached;
+#endif
 #if IS_ENABLED(CONFIG_SMC)
 	bool	syn_smc;	/* SYN includes SMC */
 	bool	(*smc_hs_congested)(const struct sock *sk);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5c9203aae834..5e99d3142f5e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2882,6 +2882,15 @@ void tcp_cleanup_ulp(struct sock *sk);
 void tcp_update_ulp(struct sock *sk, struct proto *p,
 		    void (*write_space)(struct sock *sk));
 
+static inline bool tcp_kcm_attached(const struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_AF_KCM)
+	return tcp_sk(sk)->kcm_attached;
+#else
+	return false;
+#endif
+}
+
 #define MODULE_ALIAS_TCP_ULP(name)				\
 	MODULE_INFO(alias, name);		\
 	MODULE_INFO(alias, "tcp-ulp-" name)
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index a7f94d42036f..ca789812124e 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -30,6 +30,7 @@
 #include <net/kcm.h>
 #include <net/netns/generic.h>
 #include <net/sock.h>
+#include <net/tcp.h>
 #include <uapi/linux/kcm.h>
 #include <trace/events/sock.h>
 
@@ -1259,9 +1260,10 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 
 	lock_sock(csk);
 
-	/* Only allow TCP sockets to be attached for now */
-	if ((csk->sk_family != AF_INET && csk->sk_family != AF_INET6) ||
-	    csk->sk_protocol != IPPROTO_TCP) {
+	/* Only allow TCP sockets to be attached for now. A raw socket
+	 * created with IPPROTO_TCP has that sk_protocol but no icsk.
+	 */
+	if (!sk_is_tcp(csk)) {
 		err = -EOPNOTSUPP;
 		goto out;
 	}
@@ -1272,6 +1274,12 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 		goto out;
 	}
 
+	/* KCM and ULPs cannot share the receive path and socket callbacks. */
+	if (inet_csk_has_ulp(csk)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	psock = kmem_cache_zalloc(kcm_psockp, GFP_KERNEL);
 	if (!psock) {
 		err = -ENOMEM;
@@ -1305,6 +1313,7 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 	psock->save_write_space = csk->sk_write_space;
 	psock->save_state_change = csk->sk_state_change;
 	csk->sk_user_data = psock;
+	tcp_sk(csk)->kcm_attached = true;
 	WRITE_ONCE(csk->sk_data_ready, psock_data_ready);
 	WRITE_ONCE(csk->sk_write_space, psock_write_space);
 	csk->sk_state_change = psock_state_change;
@@ -1386,6 +1395,7 @@ static void kcm_unattach(struct kcm_psock *psock)
 	WRITE_ONCE(csk->sk_write_space, psock->save_write_space);
 	csk->sk_state_change = psock->save_state_change;
 	strp_stop(&psock->strp);
+	tcp_sk(csk)->kcm_attached = false;
 
 	if (WARN_ON(psock->rx_kcm)) {
 		write_unlock_bh(&csk->sk_callback_lock);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b8d5a843f761..fa71c75c2861 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1067,6 +1067,9 @@ static int tls_init(struct sock *sk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
+	if (tcp_kcm_attached(sk))
+		return -EBUSY;
+
 	/* allocate tls context */
 	write_lock_bh(&sk->sk_callback_lock);
 	ctx = tls_ctx_create(sk);
-- 
2.50.1

