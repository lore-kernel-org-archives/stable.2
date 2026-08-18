Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA247CA99;
	Tue, 18 Aug 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070101; cv=none; b=uim/yCPRaacnn9/9WRqS2BcwSp5FH+T8vG4KUSB9MeQdhghmaqPny3OdzqeUMC3P3j2c63DHqpMBLL1WhVCNK79EEAhER27iQISPl+ph/IxTQRCbKaCE3wz2GKm/ywx95arIeJfvOQI3d7+CtQNQ7e6Ri3SDBAFdDyAO+gkTRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070101; c=relaxed/simple;
	bh=+bdjKlJ20YmD1d23zXtV4qvvYiYRZDYQfhFFijPPmJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5uYjnbCk+fn5LZxZoON9oKoDW9UVf8OTsAUuD5LCOQc/ZMScHWctnWxMixBvLfscAlzI0U1KeQuZge16I6PxMMuGqdNwohC9DCuU0+9+vyNUzru4SpRUEDQAO/ggNxSYfpM9CN4da7kB9GfxX4rDNMrRJbvew378GL0qi/KdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=s2kzsF+4; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jj60/ihW; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s2kzsF+4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jj60/ihW"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hPZhT4DKczMlKX;
	Tue, 18 Aug 2026 18:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787070089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VrITOwwiLa7v+dQLyFD6kE9M7/ckSEBFVhkdoe0ZhVE=;
	b=s2kzsF+4gtZ9ITfmBc4ieT+NBpbDejvpiRcQ7QOFLNF8kNHR9USyWRSw6dc3PikDUsHBIP
	lzYuEissyI1IW7jr7jmK6mGpkPslFAolEzc+98wmKcPgFMVHeUxQ+JXo9XDzHqmp9pCvfS
	yQuViBmtF1IiFYhyQMgLhuPVc79V53ZuN3RQuEzb7nR10wkO+SALgov3+HM4i8YxDHoviW
	0LDqR6vsEbKou8cqzq4+V1gxXUU7NjXDQhiLzyfdywaKJy0fSbiXgUORiH13DkF10wwJ3D
	kR8tmhtmCSJsbGekyrHQ9F33hTiLk/D3PFJjP35LZdO+D2bRafveZQqiyGgjfQ==
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787070088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VrITOwwiLa7v+dQLyFD6kE9M7/ckSEBFVhkdoe0ZhVE=;
	b=jj60/ihWoOa7hdglq48P5JhBx5kJF0rt/2VC02bJQ0GPElncPtEoQqqRllLPnxHvb8TEGq
	qqihbz5V+MqHj9jt1WaFqtUWtAzb1Njnrb15LM9wyXipuByh2+D79HIPL+gvPu45x0a3XR
	njjvHwsYKiAnUXiI6sJBp1dgwMvDV085T0Z3S4JtSCZ9YyBZN3LjzV0RJxz/jvTRCPY2Eq
	O59v65lE7w60wTu13lj547S2wnMo8lZaVK9gSfLKV64Nec6Q7sxYwTV3RBTLpfXQisG1VC
	dHbVTSUhDIQUd83FXioMwKTtgT0Z8/hn6DRbzyzTOP5ZU6gOtYEogXICZiMYjg==
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
Subject: [PATCH net] tcp: fix AO info use-after-free in tcp_ao_connect_init()
Date: Wed, 19 Aug 2026 00:21:08 +0800
Message-ID: <20260818162108.11456-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: acd1c96c9237518072b
X-MBO-RS-META: hotxfyexccp7scb5gi39bdfrq1s5di71

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

Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Qing Ming <a0yami@mailbox.org>
---
 net/ipv4/tcp_ao.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index e4ec60a33496..4dc5910da076 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1191,8 +1191,7 @@ void tcp_ao_connect_init(struct sock *sk)
 		 * at least one tcp-ao key that matches the remote peer.
 		 */
 		WARN_ON_ONCE(1);
-		rcu_assign_pointer(tp->ao_info, NULL);
-		kfree(ao_info);
+		tcp_ao_destroy_sock(sk, false);
 	}
 }
 

base-commit: a3dee9bb902ee4357fa02e49b415d7724ee0140a
-- 
2.53.0

