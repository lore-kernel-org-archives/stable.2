Received: from mail-m60118.netease.com (mail-m60118.netease.com [210.79.60.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518924D8CE;
	Sun, 31 May 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780231728; cv=none; b=dyiT7eQzirMJxVbOn5HM0yQ8HRFk3BNdw22KQnLYTeQ/tSPunY40D1+g4J7uTMmSx/OAD3MjANTruYp2AxqKcO3/Pt7jS8YjZNUQZ9Bz/+w7SRuR/JMDqcb1HtK7ptc1+2GqlUlTCkqD1cYwP1qABMk7sDm9FNXxdX1aLxieUCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780231728; c=relaxed/simple;
	bh=ga6ao25d1JTHgfYvqJR12MirHM8k1OnptQ9KBUCPdoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ib7tUv1G/883h8UXntg0W++CP9MJx7KeXZDNdkSHgCF+Rvxg+DRqXE37m5IrGafiHEaf5rj3sCLP1ldWa/HAmYekXdM7v5lZ8q6whMwVWwYpdZmjDSsUuus0KOioMjqXlmXa3JxChJviN427qPhOKPJ3FCFZ5mEDE+8/BX2zBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=N5sOpDHY; arc=none smtp.client-ip=210.79.60.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="N5sOpDHY"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40786b883;
	Sun, 31 May 2026 20:48:34 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: davem@davemloft.net,
	dsahern@kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH net] ipv6: use READ_ONCE() for bindv6only default in inet6_create()
Date: Sun, 31 May 2026 20:48:28 +0800
Message-Id: <20260531124828.2323406-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e7e14362d03a1kunme0273942106092
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHhhPVh9LHxhNSE1MHUtPGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=N5sOpDHY2/KHq2Zc4utFmwCRKGGg+bl/VqTdWLPqCEX/sWxza8uUDOHNTC/5AWKG+Yz5Z9QqowqPcNgw9wHziJ2b+5gz9TnwdoZoHEtknAEPtrbM8w4bncfgM0zAf1KOilUGU37Kpfq6SFxB6zVkVkaJPGaHW1t50fMIM7JZIow=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=FMFH/MMyaYzGdrx/DaFPZW8M1UXSknLDtVo9O1ZlCYc=;
	h=date:mime-version:subject:message-id:from;

inet6_create() copies net->ipv6.sysctl.bindv6only into sk->sk_ipv6only
without any locking. bindv6only is writable through the IPv6 sysctl
table via proc_dou8vec_minmax(), and adjacent lockless sysctl reads in
the same function already use READ_ONCE().

This read is reachable whenever AF_INET6 sockets are created while
/proc/sys/net/ipv6/bindv6only is being updated. In our QEMU/KCSAN stress
test on Linux v6.18.21, one actor repeatedly toggled
/proc/sys/net/ipv6/bindv6only while four concurrent readers repeatedly
created AF_INET6 stream and datagram sockets and queried IPV6_V6ONLY.
The writer completed 75313 sysctl updates in 45 seconds, and the readers
created more than 360000 IPv6 sockets in the same window.

KCSAN reported the following race:

==================================================================
BUG: KCSAN: data-race in inet6_create / proc_dou8vec_minmax

write (marked) to 0xffffffffaa27bbcd of 1 bytes by task 95 on cpu 1:
 proc_dou8vec_minmax+0x206/0x220
 proc_sys_call_handler+0x21d/0x300
 proc_sys_write+0xe/0x20
 vfs_write+0x559/0x6d0
 ksys_write+0x88/0x110
 __x64_sys_write+0x3c/0x50
 x64_sys_call+0x1016/0x2020
 do_syscall_64+0xb0/0x2c0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffffffffaa27bbcd of 1 bytes by task 97 on cpu 0:
 inet6_create+0x351/0x700
 __sock_create+0x149/0x280
 __sys_socket+0x9f/0x130
 __x64_sys_socket+0x3b/0x50
 x64_sys_call+0x1c76/0x2020
 do_syscall_64+0xb0/0x2c0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x01 -> 0x00
==================================================================

Wrap the bindv6only read in READ_ONCE() to annotate the intentional
lockless access and match the surrounding per-net sysctl reader
contract.

This issue was first flagged by our static analysis tool while scanning
lockless sysctl readers, then manually audited and runtime-reproduced
with QEMU + KCSAN on Linux v6.18.21.

Build-tested by compiling net/ipv6/af_inet6.o on x86_64 netdev/main.
Runtime-tested with a QEMU/KCSAN stress test that concurrently toggled
/proc/sys/net/ipv6/bindv6only and created AF_INET6 sockets.

Fixes: 9fe516ba3fb2 ("inet: move ipv6only in sock_common")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/ipv6/af_inet6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0a88b376141d..79fc6ce6ff77 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -211,7 +211,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	np->pmtudisc	= IPV6_PMTUDISC_WANT;
 	inet6_assign_bit(REPFLOW, sk, READ_ONCE(net->ipv6.sysctl.flowlabel_reflect) &
 				      FLOWLABEL_REFLECT_ESTABLISHED);
-	sk->sk_ipv6only	= net->ipv6.sysctl.bindv6only;
+	sk->sk_ipv6only	= READ_ONCE(net->ipv6.sysctl.bindv6only);
 	sk->sk_txrehash = READ_ONCE(net->core.sysctl_txrehash);
 
 	/* Init the ipv4 part of the socket since we can have sockets
-- 
2.34.1
