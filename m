Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F6444710
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722647; cv=none; b=PRogta/2jiM4/NwB747Xi/1MlTkqckka2lBvTQoRvdM/+nUN1l72nHiZS2lz64t4XXOffedJYKQsez6vj0k1p5162YNxudmGwu7/v6b2WExbk8MVq2sTuhCfU2StXkYL/Wh25x8j2P9h8p4xFLL1LZIbRwaXiA6T69ZD7PYpK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722647; c=relaxed/simple;
	bh=6403Da3Wz+fHxYg/ZS/tqyRqO3VaL2b0fwBQDcv0+8g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RALaVpsa7+6TvBss8UTWsCWD+BZ+Jfguw2wy5bAL/zkvWUeWQN+kSCCFTBY/X1eP7UorNcItz5W+vN626OSqU6SMToZXNW6tMR5NRQvu0x7ctPUNKV31ONvDBr5kOpfhLsZT4TpBSZgE3yARjGZ/2HMiO/nBVR++67QlFFwZUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OeHbZqwP; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="OeHbZqwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783722646; x=1815258646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AoNYL6KjIawmEpp1a4Bnz60AJM36lpx7QW9KgYJ7a3k=;
  b=OeHbZqwP9GZ4myijNzAm3tIrd3B+H0J/ddUldttQVzRp4qMo4MjTSJNz
   E9K3XHVPVJy8/Zn3w0WMxoAMrQylZnQWDtR6eyCpJge0tMtJwDe91aBaR
   42h1ep4/mgdTDp3dAIqZcZGAvJWXWK92ovUvc82vKfuSKf82niCxH6OVs
   HdKQo7xl4dnvRaR8wCREO87S+7iwLFzcKAa36r8DIr8qYtVq0yIoC8Ijz
   urzvH8aJVGyjD5ODwe7Cz6uJde2NMuvnGUjNrPDUimOIKON5+WybxCsqT
   fCLsSS/oiiBc/NoVzrp4hTPSGF8rvyTM2emPC4tRW3MFct/1I1zwddKhD
   g==;
X-CSE-ConnectionGUID: LKTh14BOTzS9k1BETuRrHw==
X-CSE-MsgGUID: J4Ri1NZzT1O7WHZ/LDTW6w==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23447977"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 22:30:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:19655]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525] with esmtp (Farcaster)
 id 1d85c986-4115-410f-9f3c-0830c047c820; Fri, 10 Jul 2026 22:30:45 +0000 (UTC)
X-Farcaster-Flow-ID: 1d85c986-4115-410f-9f3c-0830c047c820
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 10 Jul 2026 22:30:45 +0000
Received: from dev-dsk-mkbund-2b-ce767ba1.us-west-2.amazon.com (10.169.40.81)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 10 Jul 2026 22:30:45 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Michal Kosiorek <mkosiorek121@gmail.com>, Steffen Klassert
	<steffen.klassert@secunet.com>
Subject: [PATCH 5.10.y] xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete
Date: Fri, 10 Jul 2026 22:30:15 +0000
Message-ID: <20260710223015.3831465-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Michal Kosiorek <mkosiorek121@gmail.com>

[ Upstream commit 14acf9652e5690de3c7486c6db5fb8dafd0a32a3 ]

KASAN reproduces a slab-use-after-free in __xfrm_state_delete()'s
hlist_del_rcu calls under syzkaller load on linux-6.12.y stable
(reproduced on 6.12.47, also reachable via the same code path on
torvalds/master and on the ipsec tree). Nine unique signatures cluster
in the xfrm_state lifecycle, the load-bearing one being:

  BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:990 [inline]
  BUG: KASAN: slab-use-after-free in hlist_del_rcu include/linux/rculist.h:516 [inline]
  BUG: KASAN: slab-use-after-free in __xfrm_state_delete net/xfrm/xfrm_state.c
  Write of size 8 at addr ffff8881198bcb70 by task kworker/u8:9/435

  Workqueue: netns cleanup_net
  Call Trace:
   __hlist_del / hlist_del_rcu
   __xfrm_state_delete
   xfrm_state_delete
   xfrm_state_flush
   xfrm_state_fini
   ops_exit_list
   cleanup_net

The other observed signatures hit the same slab object from
__xfrm_state_lookup, xfrm_alloc_spi, __xfrm_state_insert and an OOB
write variant of __xfrm_state_delete, all on the byseq/byspi
hash chains.

__xfrm_state_delete() guards its byseq and byspi unhashes with
value-based predicates:

	if (x->km.seq)
		hlist_del_rcu(&x->byseq);
	if (x->id.spi)
		hlist_del_rcu(&x->byspi);

while everywhere else in the file (e.g. state_cache, state_cache_input)
the safer hlist_unhashed() check is used. xfrm_alloc_spi() sets
x->id.spi = newspi inside xfrm_state_lock and then immediately inserts
into byspi, but a path that observes x->id.spi != 0 outside of
xfrm_state_lock can still skip-or-hit the byspi unhash inconsistently
with whether x is actually on the list. The same holds for x->km.seq
versus byseq, and the bydst/bysrc unhashes have no predicate at all,
so a second __xfrm_state_delete() on the same object writes through
LIST_POISON pprev.

The defensive change here:

  - Use hlist_del_init_rcu() instead of hlist_del_rcu() on bydst,
    bysrc, byseq and byspi so a second deletion is a no-op rather
    than a write through LIST_POISON pprev. The byseq/byspi nodes
    are already initialised in xfrm_state_alloc().
  - Test hlist_unhashed() rather than the value predicate for
    byseq/byspi, so the unhash decision tracks list state rather than
    mutable scalar fields.

Empirical verification: applied this patch on top of v6.12.47, rebuilt,
and re-ran the same syzkaller harness for 1h16m on a previously-crashy
configuration that produced ~100 hits each of slab-use-after-free
Read in xfrm_alloc_spi / Read in __xfrm_state_lookup / Write in
__xfrm_state_delete. After the patch, 7.1M execs across 32 VMs at
~1550 exec/sec produced zero xfrm_state UAF/OOB hits. /proc/slabinfo
confirms the xfrm_state slab is actively allocated and freed during
the run (~143 KiB resident), so the fuzzer is still exercising those
code paths -- they just no longer crash.

Reproduction:

  - Linux 6.12.47 x86_64 + KASAN_GENERIC + KASAN_INLINE + KCOV
  - syzkaller @ 746545b8b1e4c3a128db8652b340d3df90ce61db
  - 32 QEMU/KVM VMs x 2 vCPU on AWS c5.metal bare metal
  - 9 unique signatures collected in ~9h, all within xfrm_state
    lifecycle

Fixes: fe9f1d8779cb ("xfrm: add state hashtable keyed by seq")
Fixes: 7b4dc3600e48 ("[XFRM]: Do not add a state whose SPI is zero to the SPI hash.")
Reported-by: Michal Kosiorek <mkosiorek121@gmail.com>
Tested-by: Michal Kosiorek <mkosiorek121@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Michal Kosiorek <mkosiorek121@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[ 5.10: drop state_cache{,_input} lines from context because 81a331a
("xfrm: Add an inbound percpu state cache.") does not exist yet, drop
xfrm_nat_keepalive_state_updated line from context because f531d13
("xfrm: support sending NAT keepalives in ESP in UDP states") does not
exist yet, and remove byseq since that optimization in fe9f1d8 ("xfrm:
add state hashtable keyed by seq") does not exist yet ]
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -659,10 +659,11 @@ int __xfrm_state_delete(struct xfrm_state *x)
 		x->km.state = XFRM_STATE_DEAD;
 		spin_lock(&net->xfrm.xfrm_state_lock);
 		list_del(&x->km.all);
-		hlist_del_rcu(&x->bydst);
-		hlist_del_rcu(&x->bysrc);
-		if (x->id.spi)
-			hlist_del_rcu(&x->byspi);
+		hlist_del_init_rcu(&x->bydst);
+		hlist_del_init_rcu(&x->bysrc);
+
+		if (!hlist_unhashed(&x->byspi))
+			hlist_del_init_rcu(&x->byspi);
 		net->xfrm.state_num--;
 		spin_unlock(&net->xfrm.xfrm_state_lock);
 
