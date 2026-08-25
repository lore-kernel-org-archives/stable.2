Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE72184524;
	Tue, 25 Aug 2026 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642479; cv=none; b=Rt/Z5LleUHqaipVM/+44ktJbU6zb6ji3jXD/RtrHAZSq0EwnM/LpvpNkO3A8a700CrK9DaB33jxpBYkEKYI0+7on+6exhvEtZ37eMdqYjnwaPnhWwY4Fw0eJ/U7RJlmDFooVx+ayxDPHSlDrAbOhfsL8mbUK4I7dyWn/X5RDucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642479; c=relaxed/simple;
	bh=5Kl2jQjO9cECsTxKcLbbCtTyLed0eNcKwzR7VgPB6rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUrN5V1t1MRgkZxGjeVuM87atFv895MAvyL5o9zmBZVzVWzmU62VtVG+Yrr3BDwEa4DxESe6mt9/UppKpEGLWldbfCdSxsPDQOIXcp3XNv/3bYWcZxGe8zIvHuGzpzzj+1TlDKd1EjxRHZFleJ+7jzMJEFjAphVcBtRvZ85BsuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XrFuUPIb; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SFWvNA3j; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XrFuUPIb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SFWvNA3j"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hTfMt6MC1zMlGP;
	Tue, 25 Aug 2026 09:21:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787642474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wMnwRlqtnUgyBUhAfXE3j+Zlk5aWVxnyqISZrf06fZk=;
	b=XrFuUPIbGQYlsW2mqjnSjSQ+ID7cnb5QSOqdkRhv/7zX9Po37Yqmnhg8xoS94LRBJwTVo/
	+CWURboN10BMt8iQ4iIwYbwN9jkPBaOR4kx+TIssPlaZaNeeZnF17W3VmJ1NH0Ksh2l9i5
	TeetnxSdqmXwJg2sj+MZ+KfmQ4FR+E0XWR8tb6Ir2wxLroAkq3HrW81+/dnKoQCSMIDh7H
	bZoK9OwF0w/eFTDUvdllcx9to7SFW4Dgxw7+1HFZG7ruQ1fOrWirqmEM7F8IBwq9WTh/r3
	0EW0SfmUPpo/u3M80Z7Y85a1iPmHyVT4w/0mu7h8iykbgU5tJcwLtA8jio/S9A==
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787642472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wMnwRlqtnUgyBUhAfXE3j+Zlk5aWVxnyqISZrf06fZk=;
	b=SFWvNA3j3nSLSXoqDjES+eJR9qLjgbssO3KM2V2xWHym5+fX+ekJZYasHFGgSi6u1zJnFT
	i6AtDMowGvwqOe4OLmjIp7fXTl5hkoMT8K+pznUnyWd931dNI0dZ0MwMVFIG+uxjPOjlLo
	C3zXdB9JYLSI0on5T1NbVQ7N5oj+rkOllvvJHb3wHFtU5N/OhSVSk9/drZNZnEAmbUou3K
	xyP56XkW6+N7vJB/s06WAonjVkMVbCu67etoDM/GahKYm2q/wKvku7WP3QeFCA/m7iKAlT
	w9fnNiqvpaEwjXlNc9mafZ+Zp7Fcddwzk2jdZmIZkG7tDD3zX8M1XXm8C5nenw==
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Ming <a0yami@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2] tcp: fix AO info use-after-free in tcp_ao_connect_init()
Date: Tue, 25 Aug 2026 15:20:33 +0800
Message-ID: <20260825072033.6921-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 713e056c3bd2c8fd8c1
X-MBO-RS-META: frbpemzubkhbkf7qz8nybgci1d84p3kq

tcp_v4_connect() adds a SYN-SENT socket to the ehash before calling
tcp_connect().  If TCP-AO is configured, tcp_connect() first verifies that
a key matches the peer and the bound device's current L3 master.
tcp_ao_connect_init() later resolves the L3 master again and removes keys
which do not match it.

The socket lock does not stabilize the bound device's VRF membership.
Detaching the device from its VRF between the initial validation and the
L3-master calculation in tcp_ao_connect_init() can therefore make the
validation succeed while initialization observes the default L3 domain and
removes the only key.  The subsequent AO lookup then fails, so the no-key
path clears tp->ao_info and frees it directly.

The receive path can find the socket in the ehash and load tp->ao_info
under RCU before acquiring the socket lock.  A reader which loaded the old
pointer can thus continue into tcp_inbound_ao_hash() after the direct free.

The issue was found during a static audit of TCP-AO object lifetime.  An
unprivileged reproducer in self-created user and network namespaces raced
connect() with detaching a veth from its VRF while sending TCP-AO segments.
It triggered the same KASAN report on two fresh boots:

  BUG: KASAN: slab-use-after-free in tcp_inbound_ao_hash+0x585/0x19f0
  Write of size 8 at addr ffff88800bf88128 by task tcp_ao_vrf_race/232

  Call Trace:
   tcp_inbound_ao_hash+0x585/0x19f0
   tcp_inbound_hash+0x677/0xa80
   tcp_v4_rcv+0x1c3e/0x3ab0

  Allocated by task 235:
   tcp_ao_alloc_info+0x43/0xf0
   tcp_ao_add_cmd+0xdf7/0x13b0
   do_tcp_setsockopt+0x168c/0x2640

  Freed by task 235:
   kfree+0x1b8/0x550
   tcp_connect+0x252/0x4f00
   tcp_v4_connect+0x1114/0x1720

The bad address is 40 bytes inside the freed 128-byte object, matching the
tcp_ao_info counters.key_not_found field.  The two runs used 1000 attempts
each, reached the no-key path 366 and 411 times, and produced one and two
KASAN reports respectively.  With this change, the same reproducer reached
the no-key path 366 times in 1000 attempts without a KASAN report or oops.

Use tcp_ao_destroy_sock() for the no-key path.  It unpublishes the AO info,
updates the socket memory and static-key accounting, and defers the free
until after an RCU grace period.

Also drop the WARN_ON_ONCE() and its stale comment.  The VRF detach race
makes the no-key state reachable during normal operation, so it is a
handled condition rather than an impossible assertion.  On panic_on_warn
kernels the WARN would turn this handled race into a kernel panic.

Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Qing Ming <a0yami@mailbox.org>
---
v2:
- Drop the no-key WARN_ON_ONCE(1) and its stale comment.

v1:
https://lore.kernel.org/netdev/20260818162108.11456-1-a0yami@mailbox.org/
 net/ipv4/tcp_ao.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 5094267447ae..cc2fb643119e 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1196,12 +1196,7 @@ void tcp_ao_connect_init(struct sock *sk)
 		ao_info->lisn = htonl(tp->write_seq);
 		ao_info->snd_sne = 0;
 	} else {
-		/* Can't happen: tcp_connect() verifies that there's
-		 * at least one tcp-ao key that matches the remote peer.
-		 */
-		WARN_ON_ONCE(1);
-		rcu_assign_pointer(tp->ao_info, NULL);
-		kfree(ao_info);
+		tcp_ao_destroy_sock(sk, false);
 	}
 }
 

base-commit: b70b7b71561f2be1183b6046964d950c2b203bfc
-- 
2.53.0

