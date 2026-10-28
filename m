Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208940;
	b=xeKu7EEVkIWoIvybDRmr4KpWrIEba4NpXKwJnY7RG5cZiV2nj8BOEeUW9ZIuzwDd54SD
	 zV9BvCvpeIRkKchmP2fPcbtQnO/8EM/KDhdy7/W+DrfUb6qJtn8dWKJH1Bd9wqW/k0S4Q
	 F9Qc8tc9g5NLooRevmOZVMvi+/EUD9rp+PIKuw7tvidgm/JUq2ukDeY6cpfHhe8Xy0imy
	 C7wtOH2Bgy2G9EBMkqqzGEve1Hn+ONU8tV5qLhEPrSTt6+MUwo+9EhfHXGxBVdReH/eqf
	 l3nkwfeXeUn8IJ0w7lOUNlqhYwhgpRmas4SJl3Ckj0azlsohm/qXfFLZ+1uOTLt4ftA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ekh/kniw3a4ZTMvpZ6rOkuuSrm0lPBuYyh4BmIagRLw=;
	b=1CMlwuqE8YV5UKzYqThqTLW0FUyGQzUVchM8TtsFOSaFP5WRwC6CmwqtOjMqS9JY1HjF
	 AhVfRuYXKkN6cfJw+1BQUxquJPgCY9J6KSdscT9JzInpOskuXq0Si+EZSBWQNJwDgty7K
	 KVaYbe3D18oDKAYL2P26dmqPvMT3a5taOpcToCyahVBcu16rR0ts9Qk08kPm5tfFU5GHj
	 sv0cedsPiTUdOxZoTTwnBAi7+GgfVYd+ofZkDPBx3O74/KkQ+zfMfBKqYM09ZbYt31gFs
	 cdWaU83FQmWswzralMxfxx8687kx+IogkKdcrC6HuGbHveIrTOagmf+5fNZrCZ/VtFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b="fh/FU31B";
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1EB606A327
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA1EB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=fh/FU31B
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso549367a12.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793208939; x=1793813739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ekh/kniw3a4ZTMvpZ6rOkuuSrm0lPBuYyh4BmIagRLw=;
        b=fh/FU31Bo1jmYXTbZV7iyJWQZ59p8E+cdqPGKj8H29xLT+FfSq2MnCfIdLMjBJx7L2
         XRHESWAtoxKaHjONwm9SpIo4uusM2TZhWP9ytN4ACGoUNvG3Ir9RTEqvh8k+FgYl5Ga0
         syTfm29ghvXV7AgJglUPBpweiE+jo7wdvWb6K4Tw5xWRHjBiiWDuFATizD+B5I13lubs
         zNpC5gvfO9cYXQmNsHNLoRlcVA1JQoDJ8yQ4nwPao/FVqs7g7aOcM7hx0qzLPIUAseff
         h3lkeP8HVrNc9mz+hBgbjtHLvo9/QQmm+oKaMqhizw5JhJ5vMFWHbBmMDDSloqAiJRFM
         zHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208939; x=1793813739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ekh/kniw3a4ZTMvpZ6rOkuuSrm0lPBuYyh4BmIagRLw=;
        b=WJ8fjkQOX1+tMFOw/nwckrRN8Hfc2mM+j9gywFcC7HytPDrJ/LdEUQmRIBGXB17Gig
         75tYisTPdnaDlfAhVVPM45xH3T33f74+c9ukLHXaK+ReTgHdWlm2woY0zCh9vqXuQKnz
         S3mQgJ1u7/QQz0Ip7jgp3UziWkNdspdAR07waRj18gDh3helC+/p3+kE5V8S2rrADPKk
         aG8QcgND3rYJjPVsX6koaH/xD06GdWHJgRAxGCnygVZKsr/UVMq7XS/VqB13RL0+e/9f
         qF2BhzM2akWfX+jAkgjEMRRDPh4XCs2CFyhwUmJDSSy+kol6vCF/2RwTSh/+lFLqhQyz
         CfpA==
X-Forwarded-Encrypted: i=1; AKwUvBxoG3UWtlONKD49i93J91X0hlk5L3AXwluycADZ4KXAYbOzT1kLBNOl2XICDjSno3AEkWgPwDs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgrQphAIgoqDvwE9eUJKmttHf1VqS6HgpwwPI/BBbl+LUpKba1
	Sl9oFrY2qlQjAtgOeme5N7KQELklES25yLpvhi0V2v+FvdzjRo0nT0eM+4IIshnkrDdVTSEZ+R3
	wxS/GnqpI3Vav4BOmrsNn6PrHiP9NPITm//r+2+AOIAHvGoMN9UEq
X-Gm-Gg: AYBFou3oElwO3G8V24CtOPLFIaqPBZ4u+nt5A/3A7lOnM3bW4ZOsZUhUKY3gxB4msfD
	gCqXV/HhVsXCUhKVPfuscckr92tV6smcYsXH6ZaGdaqAABKBYtmN0nsFjJ+ycov1Vr0upI54GuF
	f6N9qrSS3N9l6rrb/9zIIkqWZUSHcAntlXWocf1JYf9gJmdKr+EVwfr2eUP53geG/+oN/PvK3dr
	vjaBXq/0U0eVsciDx1+lNCgIUktCZdLEtawhCHl1Zlcx8cKfRJpHcSLcDUYjJUzzulnSrU7mPeD
	yFWWGhJehOrbGh44N9wS0KUqruJ0wXgu2lo7EBEVwBq1vDXEo0PjrQM40doNsOyTNSGI0M0beFC
	hOwhvH0qK1g//VqgFUAA=
X-Received: by 2002:a17:90b:51cf:b0:3aa:f2c4:12ea with SMTP id 98e67ed59e1d1-3ae57f627aamr2071360a91.20.1793208938996;
        Wed, 28 Oct 2026 10:35:38 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae55a6cfdfsm992002a91.0.2026.10.28.10.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:35:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 63738401D3;
	Wed, 28 Oct 2026 11:35:38 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 603B6DCDF71; Wed, 28 Oct 2026 11:35:38 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] kcm: reject attaching sockets with a ULP, and TLS on KCM sockets
Date: Wed, 28 Oct 2026 11:35:32 -0600
Message-ID: <20261028173533.2658096-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028173533.2658096-1-rjethwani@purestorage.com>
References: <20261028173533.2658096-1-rjethwani@purestorage.com>
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

KCM and kTLS RX do not work together, in either order.

KCM's psock_data_ready() is the lower socket's data_ready callback. It
can run in softirq context under read_lock_bh(&sk->sk_callback_lock),
and calls strp_data_ready(), which invokes sock->ops->read_sock()
inline. With kTLS RX, that is tls_sw_read_sock(), which can sleep: it
allocates with sk->sk_allocation, waits for async crypto, flushes the
socket backlog, and may wait in tls_rx_reader_acquire().

Found by code review. On an unmodified kernel with
CONFIG_DEBUG_ATOMIC_SLEEP, sending TLS records over loopback to a socket
with software kTLS RX attached to a KCM mux reports:

  BUG: sleeping function called from invalid context at include/linux/sched/mm.h:321
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 189, name: ksoftirqd/34
  Call Trace:
   __might_resched
   kmem_cache_alloc_node_noprof
   __alloc_skb
   alloc_skb_with_frags
   tls_rx_one_record
   tls_sw_read_sock
   strp_read_sock
   strp_data_ready
   psock_data_ready [kcm]

Before commit 662fbcec32f4 ("net/tls: implement ->read_sock()"), TLS
inherited tcp_read_sock(), so KCM parsed the ciphertext in the TCP
receive queue as messages. HW TLS RX uses the same proto_ops as SW
RX, so it is affected the same way.

The two also stack socket callbacks and neither restores the other's:
with TLS RX configured after the attach, kcm_unattach() overwrites
tls_data_ready(), and releasing TLS RX later reinstalls
psock_data_ready() on a socket no longer attached to KCM. On TX,
kcm_unattach() restores its saved sk_write_space, dropping
tls_write_space().

There is no known user of this combination, so reject it, as was done
for sockmap in commit 460e6486617c ("tls: reject the combination of TLS
and sockmap"):

 - kcm_attach() refuses sockets that already have any ULP, not only
   TLS, as sk_psock_init() does for sockmap, with -EOPNOTSUPP like its
   other refusals;
 - tls_init() refuses sockets attached to KCM with -EINVAL, like
   __tcp_set_ulp() and the sockmap check, tracked by a new SOCK_KCM
   flag set on attach and cleared on unattach.

sk_user_data cannot serve as the marker: sunrpc and nvme-tcp set it on
sockets that tlshd later upgrades to TLS, so it is already set when
tls_init() runs. Unlike sockmap, both sides run under the lower
socket's lock (tcp_set_ulp() asserts this), so the check is made at ULP
install rather than at key configuration.

This is a user-visible change that will also reach stable kernels:
attaching a socket with a ULP now fails with -EOPNOTSUPP, and installing
TLS on an attached socket fails with -EINVAL. Every refused setup was
already broken as described above, except one where only kTLS TX is
configured. Such a socket still passes data, because read_sock() stays
tcp_read_sock() until kTLS RX is configured, and KCM transmits with
sock_sendmsg(), so records reach tls_sw_sendmsg(). It is still wrong: if
TLS was armed before the attach, psock_write_space() shadows
tls_write_space() and does not chain to it, so a record deferred on a
full send buffer waits for the next send; if TLS was armed after the
attach, the chain works until kcm_unattach() drops tls_write_space(), as
above. The direction is not known at ULP install, so refusing it keeps
one rule for both orders and matches sk_psock_init().

Tested with CONFIG_DEBUG_ATOMIC_SLEEP: both orders are now rejected,
plain KCM still delivers messages, and the TLS ULP can be installed
after SIOCKCMUNATTACH.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Cc: stable@vger.kernel.org
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55@linux.dev/
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/sock.h |  1 +
 net/kcm/kcmsock.c  | 12 ++++++++++++
 net/tls/tls_main.c |  6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 173b37b2b8bb..e579a4a96c8e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1024,6 +1024,7 @@ enum sock_flags {
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
 	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
 	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
+	SOCK_KCM, /* Attached to a KCM mux as a lower socket */
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index a7f94d42036f..546d5b563382 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -27,6 +27,7 @@
 #include <linux/sched/signal.h>
 #include <linux/uio.h>
 
+#include <net/inet_connection_sock.h>
 #include <net/kcm.h>
 #include <net/netns/generic.h>
 #include <net/sock.h>
@@ -1272,6 +1273,15 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 		goto out;
 	}
 
+	/* KCM and ULPs are mutually exclusive. A ULP such as kTLS replaces
+	 * read_sock() and stacks its own socket callbacks with ours. tls_init()
+	 * rejects sockets already attached to KCM, see SOCK_KCM.
+	 */
+	if (inet_csk_has_ulp(csk)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	psock = kmem_cache_zalloc(kcm_psockp, GFP_KERNEL);
 	if (!psock) {
 		err = -ENOMEM;
@@ -1305,6 +1315,7 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 	psock->save_write_space = csk->sk_write_space;
 	psock->save_state_change = csk->sk_state_change;
 	csk->sk_user_data = psock;
+	sock_set_flag(csk, SOCK_KCM);
 	WRITE_ONCE(csk->sk_data_ready, psock_data_ready);
 	WRITE_ONCE(csk->sk_write_space, psock_write_space);
 	csk->sk_state_change = psock_state_change;
@@ -1382,6 +1393,7 @@ static void kcm_unattach(struct kcm_psock *psock)
 	 */
 	write_lock_bh(&csk->sk_callback_lock);
 	csk->sk_user_data = NULL;
+	sock_reset_flag(csk, SOCK_KCM);
 	WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
 	WRITE_ONCE(csk->sk_write_space, psock->save_write_space);
 	csk->sk_state_change = psock->save_state_change;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b8d5a843f761..e45062841950 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1067,6 +1067,12 @@ static int tls_init(struct sock *sk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
+	/* TLS and KCM are mutually exclusive. kcm_attach() rejects sockets
+	 * with a ULP; both run under the socket lock, so this cannot race.
+	 */
+	if (sock_flag(sk, SOCK_KCM))
+		return -EINVAL;
+
 	/* allocate tls context */
 	write_lock_bh(&sk->sk_callback_lock);
 	ctx = tls_ctx_create(sk);
-- 
2.50.1

