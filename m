Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B3429346F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035200; cv=none; b=mtiP8Dd1dJtyEFz2q6ZEiduYeuaaktOCPbbgrBC0IJiBBdGHLpY5WlNl2izxLO2zAb2OjqNbqBffBiK+zI/9+RpZw5nd9n0RH7UjKliDk/w+D3iW6+aeIjucNbGF5z2oWS0unN04wa1TX4+qCI8JLk+DHsqvyNYbgtHVkpt/Y8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035200; c=relaxed/simple;
	bh=yFU6tVT/yFzLBuEg0rvre2hfLwrV7PyfOCpFeGeK4ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tauGttyg5hrUXMVaFb3uS96CQ7oA8jSb+om1mgTV93ZgK0+9ZNjeFJyUhr4AFxhdi7uT55y25ozPPVIpPEeEQoNxdgQ9pwC7BgEmuw3g18c+Zg/cJS4OsP7Oa5U8yKgfEVEp/csO1HVa26bHxXGVQJ0VCdqd8IrCEIpd5r1ZPpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRDamuvg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRDamuvg"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38759bcd877so3693021a91.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035195; x=1784639995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WNvlJknX3V6hG5xwMburTptRLxJL73QN/VwaqdH3Aoo=;
        b=FRDamuvgiXr0ybC/Qi97rKxMAbtkMA2gWhwQcfqpnP1cpc3QVoNMBLteRNG9JF+ioe
         6PeXvkmGzH5VZWYhKWf398R3o2yeXfa/lUSjnhEkv8o/0fWIOtvLvJEmBI2caK0g2JFl
         pI7D63PzKfCuYWpA9B+pFmZj+/ZT29Dlad22NTo/Xq152CFSULEk2SPS/YY1lnDF6EgW
         GGpTumRmZL+plJOe8dEbIAGhawVV0tQFHdZQxuDr4jWJMMfkvM/K5FbRfGq1g+XaOrti
         xeDR4MNxlQK1hcsXROixDXevOJ8zauxY/DwH43aLqfG/VjLRBqJGxx6cBdKQID8FhnFl
         F3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035195; x=1784639995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WNvlJknX3V6hG5xwMburTptRLxJL73QN/VwaqdH3Aoo=;
        b=hdBrW0Sv8DZI7k5f3igJiM9SZvqokRPLs1mTQwn7kGnSwnninn9BSA686R7AMhdDds
         ru5Z8kfajQO7nqKQ8gaOTCy5N6MSWUNJmegBrw3h7QI0kt4F4GvntmR5DhS5gZW08jar
         CIMWbcMCIRuh1Zq7ESgXHkmr22JHYF3y/TuAeN2146vFBdu+UTyh/sMtX/QtNjzwE2ao
         NdOsJ3lHO+PDrDEthal/H7EjCs66X7D2VrRMz8bdJgNN8H/rDD3UT4gVQa3YbxI+hiHd
         jrdGCY9CYgxLOfDqUZtxaCPABDKZgZNEXoCsBv4qF3AEBPj2xy1jKAFme0ht8D0YqKOK
         /GAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmG6McjHCSIbLU8ZvBoXRUrAYBkXVfnR7UpWWRoExNk8VpcFwaWP9FeiGKdzTSac5gtWyZ4p8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ikCRZj8J4FyArOg/mtdKGfVQ1ofTJUeBdLA5MNtrcOtBpa4a
	dhZgm4AeFagbGwNOoBuO4HXqsRwE+ePF20voH6DXNAypGNI87LdhUVUg
X-Gm-Gg: AfdE7clcb2ExGBvh+5xj6tSSQM174MsQFQefh0ZDpGgq4vqBD7XD4SOuo7OiewI48sW
	0UWhis9CANG6KsPIdGEguO1qT9JCUYFdG9seozy/rpsLBJmFatrWHTRbspFYv/GmsweNvHgapjG
	J9d2oyosuYcZ9c37vkhMCAuP2u0zKGqwuc/syU7UJJzPpBYzHP6GE1uhCHmil5kAEaYDtGG22XW
	07J4gUxjtSQAywl3G7SsNeQj3VNswq8bJXtyD7mXACz/KZX3M8FTEC1xtKyB6NcxGmr2ouAz5qR
	CjGGpB/1HfOVZD86FCUGOS40ai5ttVgiGAgNRro/HJN5edspx1Bn1mJ5A0bbZ1bpzLB1XD4W2mI
	t1uN7XrpRC7btIvoncaT77ZuYRGn67rY/sidOKtuHnT4Gkd2jGZ+d2Xqfw4OT2HA8jOAHDww8WZ
	ybDNR0YKpD17i200AolEF0Onpd
X-Received: by 2002:a17:90b:3e8d:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-38dc782279bmr11459375a91.2.1784035195311;
        Tue, 14 Jul 2026 06:19:55 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf92bfsm116881975ad.28.2026.07.14.06.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:19:54 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Breno Leitao <leitao@debian.org>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] tipc: clear sock->sk on the failed-insert path in tipc_sk_create()
Date: Tue, 14 Jul 2026 22:19:39 +0900
Message-ID: <20260714131939.1255974-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tipc_sk_create() fails to insert the new socket (tipc_sk_insert()
returns non-zero), its error path frees the sk with sk_free() but leaves
sock->sk pointing at the freed object:

	if (tipc_sk_insert(tsk)) {
		sk_free(sk);
		pr_warn("Socket create failed; port number exhausted\n");
		return -EINVAL;
	}

This is harmless for plain socket(): the syscall layer clears sock->ops
before releasing, so tipc_release() is never called. It is not harmless
on the accept() path. tipc_accept() creates the pre-allocated child
socket with tipc_sk_create(net, new_sock, 0, kern); on failure it leaves
new_sock->sk dangling and new_sock->ops non-NULL, and do_accept() then
fput()s the new file, so __sock_release() -> tipc_release() runs
lock_sock(new_sock->sk) on the freed sk -- a use-after-free write of the
sk_lock spinlock.

tipc_release() already guards this exact "failed accept() releases a
pre-allocated child" case with "if (sk == NULL) return 0;", but the
guard is bypassed because tipc_sk_create() left sock->sk non-NULL
(dangling) rather than NULL.

Clear sock->sk on the failed-insert path so the existing tipc_release()
NULL check fires and the use-after-free is avoided.

The tipc_sk_insert() failure is reached when the per-netns socket
rhashtable hits its max_size (tsk_rht_params.max_size = 1048576, ~2M
elements) -- i.e. once a netns holds ~2M TIPC sockets every insert
returns -E2BIG.

  BUG: KASAN: slab-use-after-free in lock_sock_nested (net/core/sock.c:3839)
  Write of size 8 at addr ffff8880047cdc38 by task init/1
   lock_sock_nested (net/core/sock.c:3839)
   tipc_release (net/tipc/socket.c:638)
   __sock_release (net/socket.c:710)
   sock_close (net/socket.c:1501)
   __fput (fs/file_table.c:512)
  Allocated by task 1:
   sk_alloc (net/core/sock.c:2308)
   tipc_sk_create (net/tipc/socket.c:487)
   tipc_accept (net/tipc/socket.c:2744)
   do_accept (net/socket.c:2034)
  Freed by task 1:
   __sk_destruct (net/core/sock.c:2391)
   tipc_sk_create (net/tipc/socket.c:504)
   tipc_accept (net/tipc/socket.c:2744)
   do_accept (net/socket.c:2034)

Fixes: 00aff3590fc0 ("net: tipc: fix possible refcount leak in tipc_sk_create()")
Cc: stable@vger.kernel.org
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
v3: correct the Fixes: tag to 00aff3590fc0 ("net: tipc: fix possible
    refcount leak in tipc_sk_create()") -- that commit added the sk_free()
    on the insert-failure path; before it the path leaked sk rather than
    freeing it, so the use-after-free only exists since then (v5.19+).
    Thanks Breno. Collect Reviewed-by from Tung and Breno. No code change.
v2: https://lore.kernel.org/netdev/20260713082342.3803379-1-4ncienth@gmail.com/
v1: https://lore.kernel.org/netdev/20260710014440.2055584-1-4ncienth@gmail.com/

 net/tipc/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216..55e695748332 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -502,6 +502,7 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
 	tipc_set_sk_state(sk, TIPC_OPEN);
 	if (tipc_sk_insert(tsk)) {
 		sk_free(sk);
+		sock->sk = NULL;
 		pr_warn("Socket create failed; port number exhausted\n");
 		return -EINVAL;
 	}
-- 
2.54.0

