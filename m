Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630111;
	b=qgZE1TDxooPbAllpI2v0rC+GAQIsgigAYXPoVS8wBRjIyPxUDG3yS0xk2FHx2Yi55N/b
	 TTKSv7I7agYyJB7wb/rOeyPThoY3B8kgqvobYlHaty3nPGi09cq3ZiAqftD3wsNoDnp/A
	 0x2GJcpb77Atf5BwaArjQR3Gq/Cvhmt4WCyL1corwJ8Wa+OkpLuOOJcVJln9L69ZbOTh/
	 qZV8pRfI8lOESU1FWZr8azHzhzSJkbzpFRQkaSnUPQpH0GOi4kF2Nm8XwcKG5fQnW5m6p
	 Asd/WRsJkQSphNgma1m1vDHTunKsFuROYj/YCfW01Jpjjkorow/6I/2gHBBPImPCYJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630111;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B20QF8u4Q48oGb36zaWtEXmrrj1aPPGtEEOCiHS8DN8=;
	b=v8lrYXE3n1OIIwQBm0qjqfO9HjXaeP9b3xYmNJqUks5a95DmL7ZdgCEloeckUqYmVJIe
	 0hCMYO3t92mKMtRyq3l7wDNVUN79bII8xFKd8FAKVSOrNeqkNythJ1CTDva7hLaYBwhsx
	 XkwlcS7qPvbOx3FlTv6QaF0kIgS5Kv4tqLlzWg64B8loxOVAK44RuzdEIJtvX5MwQvu1q
	 HmZqe+/7glohDa7dH446QoE2/H7Jy+qKUBtFm2sFIOfV5gx76tnTSJBXViNZSj/4rT5aN
	 wUSDPvfHgv5+BydT9VcTANxO5ibcGvuW5c9MFhn7hJJmku2z6+fd6f5D7MvJfur/bog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=TPgG1vg3;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF9C6072C77;
	Mon,  2 Nov 2026 14:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AF9C6072C77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=TPgG1vg3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=TPgG1vg3+OpB6Wjw24FEEZXxH/LnVnhnhgG3NygekBskyR2dlUh6ST3OFq/pPpSiYGVl6bUKQKf3G
	 JFtozWIp7lcn3SDSwDI2pUS3QuZzu/2xFI82YkphLSll4rLPwkbYZMTcifmifhnNauYrLZfSCryNaX
	 BY2qbSZZt5cKlRpw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86ae89f9988f-2a43b;
	Mon, 02 Nov 2026 22:35:06 +0800 (CST)
X-RM-TRANSID:2ee86ae89f9988f-2a43b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46ae89f99db2-0cb7c;
	Mon, 02 Nov 2026 22:35:06 +0800 (CST)
X-RM-TRANSID:2ee46ae89f99db2-0cb7c
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com,
	netdev-bot+sashiko@kernel.org,
	jiayuan.chen@linux.dev
Subject: [PATCH net v2] tcp: fix device binding after failed IPv6 connect
Date: Mon,  2 Nov 2026 22:34:52 +0800
Message-ID: <20261102143352.135769-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

tcp_v6_connect() sets sk_bound_dev_if from sin6_scope_id when connecting
to a link-local address. If the route lookup fails, the failure path
leaves that device binding in place. A retry to ::1 on the same socket
can then fail with ENETUNREACH, although a fresh socket can connect.

Save the original binding and restore it on synchronous errors returned
by tcp_v6_connect(). Restore it before tcp_set_state(TCP_CLOSE) and
inet_bhash2_reset_saddr(), since the latter uses sk_bound_dev_if to
select the l3mdev for the bind2 bucket.

Only undo a binding installed from sin6_scope_id by this call, and leave
a different binding installed by a later callback intact. Once the
late_failure path has handled the binding, do not restore it again
after the state callback and source-address cleanup.

This patch does not change disconnect handling after an asynchronous
connection failure.

Found during LLM-assisted review of the tcp_v6_connect() error paths;
the same assistance was used for the fix, tests and commit message.
Reproduced in UML by connecting to fe80::1 through a down dummy
interface, then retrying the same socket against a listener on ::1.

Tested in UML with 39 targeted userspace checks covering reconnects,
existing bindings, VRF bind-bucket cleanup and BPF sock_ops binding
changes. All 39 checks pass with v2, including the retry reproducer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/netdev/062d02ca-e9e1-4f4e-ac57-0de27272a205@linux.dev/
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
Changes in v2:
- Restore the scope binding before the TCP_CLOSE state change and
  inet_bhash2_reset_saddr(), as Jiayuan pointed out.
- Only restore a scope binding installed by this call, and preserve a
  different binding installed by a callback.
- Avoid a second restore after the late_failure cleanup.
- Follow reverse xmas tree declaration order.
- Clarify that this change handles synchronous connect failures.

v1: https://lore.kernel.org/netdev/20261031074654.73952-1-yanxia@cmss.chinamobile.com/

Testing on net cb284914e749:
- UML: baseline 32/39, v1 35/39, v2 39/39. The tests reproduce the stale
  binding on baseline, the bind2 warning on v1, and the BPF binding
  regression on v1. v2 passes all checks without kernel warnings.
  These are custom userspace tests; the kernel networking selftest
  suite was not run.
- x86_64, GCC 12.3.1, W=1: baseline and v2 completed vmlinux, bzImage
  and module builds using configurations derived from allmodconfig and
  allyesconfig. WERROR, KASAN and KCSAN were disabled; allyes also had
  KUNIT_ALL_TESTS disabled, with the resulting dependency changes.
  The changed object compiled without diagnostics in both configs.
- Unmodified allmodconfig and allyesconfig failed on both baseline and
  v2 with the same existing WERROR diagnostics in lockdep_proc.c,
  callthunks.c, coda/upcall.c and stackinit_kunit.c. The derived allyes
  builds have identical diagnostics. The v2 allmod build was incremental,
  so its log does not establish full-tree warning equality.

 net/ipv6/tcp_ipv6.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e006a30360eae..5bd4bd49d2824 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -134,6 +134,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			  int addr_len)
 {
 	struct sockaddr_in6 *usin = (struct sockaddr_in6 *) uaddr;
+	int old_bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct inet_timewait_death_row *tcp_death_row;
 	struct ipv6_pinfo *np = tcp_inet6_sk(sk);
@@ -142,6 +143,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct ipv6_txoptions *opt;
+	bool scope_id_set = false;
 	struct dst_entry *dst;
 	struct flowi6 *fl6;
 	int addr_type;
@@ -198,6 +200,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 				return -EINVAL;
 
 			sk->sk_bound_dev_if = usin->sin6_scope_id;
+			scope_id_set = true;
 		}
 
 		/* Connect to link-local address requires an interface */
@@ -353,9 +356,16 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return 0;
 
 late_failure:
+	if (scope_id_set &&
+	    READ_ONCE(sk->sk_bound_dev_if) == usin->sin6_scope_id)
+		WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);
+	scope_id_set = false;
 	tcp_set_state(sk, TCP_CLOSE);
 	inet_bhash2_reset_saddr(sk);
 failure:
+	if (scope_id_set &&
+	    READ_ONCE(sk->sk_bound_dev_if) == usin->sin6_scope_id)
+		WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);
 	inet->inet_dport = 0;
 	sk->sk_route_caps = 0;
 	return err;

base-commit: cb284914e749388eef402938bdb3115fe1f6d337


