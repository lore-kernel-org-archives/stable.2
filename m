Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396911;
	b=ReqNFgSiLig37w1QIoETwVetuUmHoWbnOyRTwQ1MiuUPHMdtBRQixwnZSsDDn+U3W0PX
	 LLGiVGa9n4Jp9NmLl9mBcSnhkP8jno9OhqCZCFDjUxxJOByyIQnx4Vb3OgfkyquXuNdDs
	 NeaboCPSJEB8DoKnAWcJ/dctw0+uPf137DGjCv9+gJl5OkzaK0NWKZ6SwKV7DNk7G84JI
	 GHdNV0n2u6Y1BRMJTm3sGZc990bywb4kKUHgw8lnykvzMW3mRyscHhFXFT/ec7WNOLBSi
	 98zSexjhV48i6ABtQ5qOaAtFlW7GPzflmXZ0q/VNMpwLaHx6pBrcSVYYxh9IPai4vLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396911;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zn/evyTY2YXOIPUCl2VF89xJV5FEZinteqD1qP6+XjA=;
	b=Yqo71W9QfrZJgddTdbBqBtPpY+/D8Ko5jxEsSGvQSkeEO+5rANPQweYlyWefz2QnK4TU
	 0IYAnxNY6248BvNa5npctG8x4qQNGMn/byiof00wTdlNbGwUm2GkHKXnNDznJNYW2dozW
	 YKuUEq+nsURBXLzu5qVVdOVIH5V8UKHnUoSZgBAffoPbWyHSNwW+hU65zeBdCQa/VbqQI
	 4qlXddXp/TJAUvmrXFEeJbNihc1aUa4VLCA4zufvXOdoYNpyiF0cBfiOdqc5mqEEgd1Jj
	 q3i6NpTyTglWeBDiJzXJHgquxkbfMOtJV7P+Mj6DkqMIb6Ppy5w2e9deBKKk2PTsyCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ctmbQthb;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CB2606A321;
	Wed, 11 Nov 2026 11:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28CB2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ctmbQthb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ctmbQthbX/z3rmhYp6sHMiRaosFNrjMsuCgbCRRbEJ5FdfQzAz84h4zvsHEJAtrhjtrhDNqusug2G
	 pLEOZO5UDvuMHViXXUPJJFuUXiWDsx39si7v0AXIOLDPBvx3IcjQQPyxs+WksuNkc+b2eYMF7ABALT
	 eH5R07ZZsbX3wf+4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af452ec7e9-a5480;
	Wed, 11 Nov 2026 19:35:08 +0800 (CST)
X-RM-TRANSID:2ee66af452ec7e9-a5480
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af452ea9e0-dabad;
	Wed, 11 Nov 2026 19:35:08 +0800 (CST)
X-RM-TRANSID:2ee76af452ea9e0-dabad
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
Subject: [PATCH net v3] tcp: fix device binding after failed IPv6 connect
Date: Wed, 11 Nov 2026 19:34:55 +0800
Message-ID: <20261111113455.284747-1-yanxia@cmss.chinamobile.com>
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
Content-Transfer-Encoding: 8bit

tcp_v6_connect() sets sk_bound_dev_if from sin6_scope_id when connecting
to a link-local address. If the route lookup fails, the error path
leaves that binding in place. Retrying against ::1 on the same socket
can then fail with ENETUNREACH, although a fresh socket can connect.

Save the original binding and restore it unconditionally on native
IPv6 errors returned by tcp_v6_connect(). Restore it before
tcp_set_state(TCP_CLOSE) and inet_bhash2_reset_saddr(), which uses the
binding to select the l3mdev for the bind2 bucket. Do not restore it
again after the TCP_CLOSE callback. Keep IPv4-mapped errors on their
existing cleanup path.

Found during LLM-assisted review of the tcp_v6_connect() error paths.
Reproduced in UML by connecting to fe80::1 through a down dummy
interface, then retrying against a listener on ::1 on the same socket.
With the patch, the retry succeeds. The VRF cleanup tests also pass
without the inet_csk_get_port() warning seen on the baseline. Tests
also covered existing bindings and BPF sock_ops callbacks. These are
custom userspace tests; the networking selftest suite was not run.

Deferred Fast Open failures after connect() returns success are
unchanged.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/062d02ca-e9e1-4f4e-ac57-0de27272a205@linux.dev/
Link: https://lore.kernel.org/netdev/20261110100224.57cbf548@kernel.org/
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
Changes in v3:
- Restore old_bound_dev_if without the scope_id_set and current-value
  checks, as Jakub requested.
- Keep the early restore before TCP_CLOSE and bind2 cleanup, and
  avoid restoring again after the close callback.
- Leave IPv4-mapped failures on the existing cleanup path.
- Use WRITE_ONCE() when installing the scope binding.

v2: https://lore.kernel.org/netdev/20261102143352.135769-1-yanxia@cmss.chinamobile.com/
v1: https://lore.kernel.org/netdev/20261031074654.73952-1-yanxia@cmss.chinamobile.com/

Testing on net d2809ccf3cfc:
- UML: reconnect and existing-binding checks, two VRF cleanup cases,
  and five BPF sock_ops cases. The baseline reproduces the stale
  binding and VRF warning; v3 completes without kernel warnings.
  Native CONNECT callback bindings are rolled back on failure;
  CLOSE callback bindings and IPv4-mapped behavior are preserved.
- x86_64, GCC 12.3.1, W=1: completed kernel and module builds with
  configurations derived from allmodconfig and allyesconfig.
  WERROR, KASAN and KCSAN were disabled; allyes also had
  KUNIT_ALL_TESTS disabled, with the resulting dependency changes.
  tcp_ipv6.o compiled without diagnostics in both configurations.

 net/ipv6/tcp_ipv6.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b1dec5d86d633db67a754c70ee1c63290a9acb5a..641b74aaf1963e71bb59e5542899e30e33b82a1e 100644
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
@@ -197,7 +198,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			if (!sk_dev_equal_l3scope(sk, usin->sin6_scope_id))
 				return -EINVAL;
 
-			sk->sk_bound_dev_if = usin->sin6_scope_id;
+			WRITE_ONCE(sk->sk_bound_dev_if, usin->sin6_scope_id);
 		}
 
 		/* Connect to link-local address requires an interface */
@@ -251,7 +252,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 			tp->af_specific = &tcp_sock_ipv6_specific;
 #endif
-			goto failure;
+			goto out;
 		}
 		np->saddr = sk->sk_v6_rcv_saddr;
 
@@ -353,9 +354,14 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return 0;
 
 late_failure:
+	WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);
 	tcp_set_state(sk, TCP_CLOSE);
 	inet_bhash2_reset_saddr(sk);
+	goto out;
+
 failure:
+	WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);
+out:
 	inet->inet_dport = 0;
 	sk->sk_route_caps = 0;
 	return err;

base-commit: d2809ccf3cfc3c30581dc64ebec5f49f7ee1e228


