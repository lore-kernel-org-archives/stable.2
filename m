Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746901;
	b=b2gBpjlRK1Z1Jd9LcWmLxujbw5vcKCg+zitt5B6q85XIHq5cLEjIoY039sZmvn499stz
	 WP4bSYSH9JS8oz4512IDa665OWHCTWiQ9MWqxdwZKHhwYHPLGn9Dm6gVqJ6ZzlCV97idU
	 XvsG5ztzZaAmkX+k18TLZWDY/dTM0iv32/CEZVo4We0Va5DCFaM2SvgM6a9ti30kd28fr
	 oGrrtZXr1+uh9G8N4MTrD4BMzgpmT/DV/C00nN08tJxY4137nopdpSB5Duic5mS5kXw5x
	 T7Q6CegvGcm5sLAQVWqTVM4y1xfJkCKlgBOz76lq8++oVAqZDHHpLs5ygoCVjEFbTIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746901;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UdJHrg0RN3klYyxIxzwKv6xLCwx4WKiEgFNLswgc0cs=;
	b=kNUyNQfvU3fGODteuV9MEejPkPzDbXpjfvQIxf8sSUdcGI5fEIBqcI0jXWE3htBnRpFp
	 QWm53HF6gP9MJJ56su07mNjajAn/m5uGgSnouAwiC88WOvqPpFsYL2cgPMvkDbZPCGEJH
	 DTPRyxhCT572DK6DjhY7IISIj5fEBHBTGIyG2+HM0cH+vBY1fSoNDdTgzFLis+6N0CHEz
	 KMxNIGi3PqByvepGWGObDZ0aMaVNHa83wJ3d/IwK3HomA6zPe5UumneWEUjEO34P8P9pb
	 4Rh5vQqqL7Tl+R53LYkQcd0BBhFFxl5QB5+B3KILhNSbmlcGhvePqBQzacSOPXUwMfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MEsFaDuS;
	arc=none smtp.remote-ip=91.218.175.235
Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61B606A323
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB61B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MEsFaDuS
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jgTz/hYZcxRGvrksAA4I+lCwJ2sml6J3MvWNfQZi+XQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792746897; v=1; x=1793351697;
 b=MEsFaDuSpC4H7Qdtlfbs0slTQtdaZYRPY1PzEnHUtawqav7goazqa/dsD0biXJrK8uv1cJBD
 NmYuEBrE7t98NKW6PFBrTbvMWc4e890owWEn/LYL1VXXK6zye8sRWG+tIsTj7iftxT2u0HbWiOo
 FKwF+sIr4xTBLPv0SgT2wRB8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e6b6812eb02a8c77;
	Fri, 23 Oct 2026 09:14:57 +0000
X-Mizu-Trace-ID: e6b6812eb02a8c77
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Joel Granados <joel.granados@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Flavio Leitner <fbl@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/5] ipv6: restrict gc_elasticity to 31
Date: Fri, 23 Oct 2026 17:13:27 +0800
Message-ID: <20261023091419.167088-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023091419.167088-1-jiayuan.chen@linux.dev>
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
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

Every counted IPv6 dst allocation runs ip6_dst_gc() once the number of
live dst goes over gc_thresh (1024 by default). ip6_dst_gc() decays
ip6_rt_gc_expire by gc_elasticity: the smaller gc_elasticity is, the
smaller ip6_rt_gc_expire gets, i.e. the more aggressive the gc.

ip6_rt_gc_expire is a u32, but gc_elasticity has no upper bound, so
writing >= 32 shifts a 32-bit value by >= 32 bits, which is UB:

	val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));

  UBSAN: shift-out-of-bounds in net/ipv6/route.c:3369:53
  shift exponent 32 is too large for 32-bit type 'unsigned int'
  CPU: 2 UID: 0 PID: 615 Comm: ping6 Not tainted 7.3.0-rc7+ #364 PREEMPT
  Call Trace:
   <IRQ>
   dump_stack_lvl+0xc1/0xf0
   dump_stack+0x10/0x20
   __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
   ip6_dst_gc.cold+0x15/0x1a
   dst_alloc+0x4e0/0x620
   ip6_rt_cache_alloc+0x189/0x7e0
   __ip6_rt_update_pmtu+0x68e/0x1160
   ip6_update_pmtu+0x30c/0x3a0
   icmpv6_err+0x1fa/0x330
   icmpv6_notify+0x303/0x770
   icmpv6_rcv+0xc12/0x1670
   ip6_protocol_deliver_rcu+0xb4a/0x1520
   ip6_input_finish+0x19c/0x400
   ip6_input+0xd4/0x240
   ipv6_rcv+0x1fd/0x330
   __netif_receive_skb_one_core+0x118/0x1c0
   __netif_receive_skb+0x21/0x150
   process_backlog+0x37e/0x1200
   __napi_poll.constprop.0+0xa5/0x5e0
   net_rx_action+0x4c0/0xf70
   handle_softirqs+0x204/0x9b0
   __do_softirq+0x10/0x18

Cap it at 31. 31 and 32 are equivalent anyway: ip6_rt_gc_expire starts
at 30*HZ (~30000 with HZ=1000), and such a value shifted right by 15 or
more is already 0, so val - (val >> rt_elasticity) stops decaying well
before 31. Values above 31 add no new behaviour, they only hit the UB.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/route.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 94e5ef1c4f83..6f2efc219f39 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6579,6 +6579,8 @@ static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
 	return 0;
 }
 
+static int ip6_rt_gc_elasticity_max = 31;
+
 static const struct ctl_table ipv6_route_table_template[] = {
 	{
 		.procname	=	"max_size",
@@ -6627,7 +6629,9 @@ static const struct ctl_table ipv6_route_table_template[] = {
 		.data		=	&init_net.ipv6.sysctl.ip6_rt_gc_elasticity,
 		.maxlen		=	sizeof(int),
 		.mode		=	0644,
-		.proc_handler	=	proc_dointvec,
+		.proc_handler	=	proc_dointvec_minmax,
+		.extra1		=	SYSCTL_ZERO,
+		.extra2		=	&ip6_rt_gc_elasticity_max,
 	},
 	{
 		.procname	=	"mtu_expires",
-- 
2.43.0

