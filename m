Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417186;
	b=LzoLN3wqpUyHCaCUi2vZczXLcqSAozzDIJsVNO/jUxUvtZnIHGrGleHZ5tz7BcqvzR+z
	 xanjxG0qOPrA7c338WepOjmf2ur+0v8AIyV1khPkmwspVez4M8lupqc+ev8NFiumZbPpZ
	 SZhBOriXhkmQZFI7046oaobodfRkQiQGRFRiQDAibO4NaCXLxT38jh8aF0nBdgxX6Fn0T
	 5OEYSUqh68Tp4vJ759s9QRY/SQUMvS+4/6MwVup1HgBZMiQfiHYHbCNQ0Nqi9JsAnNOY3
	 agc37vT4+Uu1v4HeiRTskwHb907mjgBcH8ACxXP3t+RwnghEOomtjtIs2rwB0HrS61w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-Id:From:Date:Subject:To:Cc;
	bh=k/7X2LCq5GJYBOy/M+xu6XNBMe0qdeGs2S6qILBKKsY=;
	b=LE6S3j0bqrGuv69UnPBCL7l6f4iz3BkEicwNgM4/zUmOhKaQh0P3QOO664D3qo/yR8If
	 JcZXEkk1RodFGRDB03sGFRVuqKcFQhu5yipPGz8wk6Ua9GvDsmMXGGlcyLqPKukkRPBh5
	 6jCbN8KvMM4rFemIcRqGt3X8PdjjAD2nlLpigQu+p67Z/Av0A0GRhSL7tNZLBEzzLnQTq
	 JHfo4CXBjLbz3aND7GgtYNd15AqztIPjgF9vMGcbrW7jLIU4mjYtMDVg10adziuBbYn1z
	 DIVFhcdn+4KV1yJvaEI7bd/2kdCCeOcVZnykg6xg4XePwe6XdY/9KMXQzqFaWH/I5Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uqAAH8zZ;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBE4606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBBE4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uqAAH8zZ
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-3b196fefa1fso1568478a91.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417185; x=1796021985; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k/7X2LCq5GJYBOy/M+xu6XNBMe0qdeGs2S6qILBKKsY=;
        b=uqAAH8zZvQjt2N8tHeB9Mkz9ejeGUZyJd2ILHh9aOvhXQTBb/Bu2wqOA9pDXEenGbF
         wGaa7BIWmvtLvwQS5OhubLrVP9miHaOVkkxgoYyEJ0rsS43FhNeNxRiT4jqrbLmNjPec
         T2i+hWzDAvQeVE/6cx/EBFTvIhCYnCCt0dfRhvVD1mfXFyk6rv92Oi4OlCuhl2T7X3JG
         mj3R7P4Rci/tEjG+Ehqi0k4pTIUjjsigvHt20LmG09YFpYkeDcc8JhF3LqcDEGaEsVuu
         Gi7HkjAzCkuIB010u9Dnjo+/KTuiYzFSmjcBo/sP1yxjn7kJLwqu/fKLgxcNfeIlO07E
         lp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417185; x=1796021985;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k/7X2LCq5GJYBOy/M+xu6XNBMe0qdeGs2S6qILBKKsY=;
        b=I4/rMCaEQriQy6xQKpJGXBCLiyZRS2/AI3u0mEqrUjhQdO+u2xYlofUJ9VinENltxU
         xh9Di9s3JhuXl3av5bBth6vWPv8D6ZDt1xtbAMJOPNJ4XyoLA7WyeXZePRQ53+Ghb6vX
         B1Fcu85nXC8gHmPmDTm7BSCuSTU5nyy/Awmdf0qfEMsZHsucxVIX987AklscvsRL6HLE
         KUe5hTtwZXZBFaCF3/GRa/EndhrgiCUa7bvfyFVs+apBCkHIWoj54Medj8ngq4QNTBIf
         7jL0RwbLRvWnQUzv/KNvjHhvN4TrCQ2ni0YCAjtwUz5bAReQWT30zHi7ZubT8/6ZKUns
         C3ow==
X-Forwarded-Encrypted: i=1; AL+hErFDoE8ww8TmTFSVJKfTuv5WIb60FcUyTaWSkjz5oNat6vG4mYYwVB9/cykt/ULJt6ODn6S/+3o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QJNy16ITzuNwWkUx3GxWkB8YV5hVH4upwFE+k9YQKREq09HsB
	gpX8a7Q77ogj+ygF/1LmgnRdAqchAiwWTf+gstHGw+D+FZp8itbceRTc
X-Gm-Gg: AZFdTZe+wdD2lf058HLkGLEhKbgXlxIgcP11qgPxBWrNIfahAvMOPIPZSsXlX4VlxXl
	BfXNcAg73303IhuO6k8IqUclMMSPnlKbv3hbtCCxI9zp0b3w12QYrbWPHr60QGguSdZsMN9zrka
	MGCJH9KDDVRvkHSCsu4joSMnsjtuo3tTMa0WjMWLmBmLRaSd+D1UcJmYCgWDI4GSgqOm/Pv02cZ
	5OEr9NQ23ta7ALvbRQQBOxOiz+LzfFMw36RqmMQcB/LtUk1c+ox5NrKqykinTBlSTRA0wavJhFg
	HcRZaYIyivxKHlmD0Xld45DXnoXUzt34g/qWXiHNNR7iR29d3td9XQTl3kY48M7An7sy7mrqnLv
	RrgjOq1OmHwG145X+XpwKBbu46l6KJhduuavgxkoZdTV8/tdkICRkUhHnH6s2iD0o2VUS+BZBU5
	kUkXvyT+F/dsaklV3NSlU+D4WI/LAZOOlz4Xy9BfXkWo1dBKP3Yzr7OGnkkC+lnU8g/essde4sB
	56cXRc2AwyJyKe4M9YdnUjMI3v5rseaPQbS95l5o6AYA5nUBqYR0pv6C5XLUwKmcnl9CIn9ZTjK
	vAiPVuPIJ7AUPfDJ6VcoFra+3P/EHSVZqfX/GPsIQoaeChAXZX3E97Dx
X-Received: by 2002:a17:90b:5546:b0:3b3:c44b:b779 with SMTP id 98e67ed59e1d1-3b41c935639mr10465956a91.46.1795417184963;
        Sun, 22 Nov 2026 22:59:44 -0800 (PST)
Received: from smtp.n0ps1edzz.local ([120.253.139.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm19344239a91.7.2026.11.22.22.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:59:44 -0800 (PST)
Message-Id: <20261123133000.2.n0ps1edzz@gmail.com>
From: Zhou Qiuyue <n0ps1edzz@gmail.com>
Date: Mon, 23 Nov 2026 13:30:00 +0800
Subject: [PATCH net] ipv4: route: fix use-after-free in ipv4_confirm_neigh()
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
    Ido Schimmel <idosch@nvidia.com>,
    David S. Miller <davem@davemloft.net>,
    Eric Dumazet <edumazet@kernel.org>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Hangbin Liu <hangbin.liu@linux.dev>,
    linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list


ipv4_confirm_neigh() loads dst->dev with dst_dev() and hands the
resulting net_device to the neighbour lookup.  The load is outside any
RCU read-side section: __ipv4_confirm_neigh() does take rcu_read_lock(),
but only after the pointer has been read, which is too late to protect
it.  The load is only a READ_ONCE(); it does not pin the device.
udp_sendmsg(), raw_sendmsg() and ping_v4_sendmsg() reach
dst_confirm_neigh() when sendmsg() is issued with MSG_CONFIRM and
MSG_PROBE, without holding RCU or a net_device reference.

The first stale field read is dev_net(dev) in arp_table(), reached from
the neighbour lookup.  Route teardown drops the reference the dst held on
the device: dst_dev_put() does it for dsts removed from the fib tree, and
rt_flush_dev() does it for uncached routes.  Both replace dst->dev with
blackhole_netdev, so a reader that loaded the old pointer just before the
replacement can dereference a freed net_device.

Take rcu_read_lock(), load the device with dst_dev_rcu(), and keep the
section through the gateway dispatch and __ipv4_confirm_neigh().

KASAN reports (trimmed to the relevant frames):

 BUG: KASAN: slab-use-after-free in ipv4_confirm_neigh+0x89d/0x9c0
 Read of size 8 at addr ffff888104bea108 by task confirm_race4/125

 Call Trace:
  <TASK>
  dump_stack_lvl+0x55/0x70
  print_report+0xcb/0x5d0
  kasan_report+0xb8/0xf0
  ipv4_confirm_neigh+0x89d/0x9c0
  udp_sendmsg+0x11b9/0x1dd0
  ____sys_sendmsg+0x7af/0x9b0
  ___sys_sendmsg+0x145/0x220
  __sys_sendmsg+0xf8/0x190
  do_syscall_64+0xee/0x500
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

 Allocated by task 117:
  __kasan_kmalloc+0xaa/0xb0
  __kvmalloc_node_noprof+0x216/0x5d0
  alloc_netdev_mqs+0x7e/0x11c0
  rtnl_create_link+0xaa6/0xe30
  rtnl_newlink+0xd22/0x1de0
  rtnetlink_rcv_msg+0x697/0xa00

 Freed by task 117:
  __kasan_slab_free+0x61/0x80
  kfree+0x201/0x440
  device_release+0xc8/0x240
  kobject_put+0x101/0x1e0
  netdev_run_todo+0x611/0xe70
  rtnl_dellink+0x343/0xa50
  rtnetlink_rcv_msg+0x697/0xa00

 The buggy address is located 264 bytes inside of
  freed 4096-byte region [ffff888104bea000, ffff888104beb000)

The faulting address is object offset 264, the dev_net(dev) read of
dev->nd_net in arp_table().

The lifetime bug comes from the v4.13 series that removed the dst gc
list.  Commit 95c47f9cf5e0 ("ipv4: call dst_dev_put() properly") made
route teardown release the net_device reference held by the dst, so
dst->dev no longer pins the device for the lifetime of the dst.
Later commits changed the replacement target to blackhole_netdev and
added dev_rcu, but did not add RCU protection to this reader.

The lifetime change is present from v4.13 onward.  Kernels that reach
this callback are affected, including current mainline, net-next, and
the 5.4.y, 5.10.y, 5.15.y, 6.1.y, 6.6.y and 6.12.y stable branches.
dst_dev_rcu() is available in current 5.15.y and newer; 5.10.y and
older need the equivalent rcu_dereference(dst->dev) backport.

Fixes: 95c47f9cf5e0 ("ipv4: call dst_dev_put() properly")
Cc: stable@vger.kernel.org
Signed-off-by: Zhou Qiuyue <n0ps1edzz@gmail.com>
---
Window amplification for the KASAN run only:

 struct net_device *dev = dst_dev(dst);
+if (in_task())
+	msleep(2000);
 const __be32 *pkey = daddr;

The sleep runs in process context (udp_sendmsg), so RTM_DELLINK can
reach netdev_run_todo() and device_release() before dev_net(dev) is read.
It is a verification aid, not part of the fix.

Report context: 7.4.0-rc2 #27, CONFIG_KASAN=y, PREEMPT(full),
kasan.fault=panic.  Full log: evidence/dyn-confirm/qemu-kasan-confirm4.log.

Object detail from the report:

 The buggy address belongs to the object at ffff888104bea000
  which belongs to the cache kmalloc-4k of size 4096

Base tree: netdev/net.git main at af6737b90668.  The pre-image blob in
this patch matches that tip exactly.  The same hunk also applies to
netdev/net-next.git main at eb6d6c80d354; the target function is
unchanged there.

 net/ipv4/route.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index cd69242..5ceea01 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -441,19 +441,25 @@ static struct neighbour *ipv4_dst_neigh_lookup(const struct dst_entry *dst,
 static void ipv4_confirm_neigh(const struct dst_entry *dst, const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst_dev(dst);
+	struct net_device *dev;
 	const __be32 *pkey = daddr;
 
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+
 	if (rt->rt_gw_family == AF_INET) {
 		pkey = (const __be32 *)&rt->rt_gw4;
 	} else if (IS_ENABLED(CONFIG_IPV6) && rt->rt_gw_family == AF_INET6) {
-		return __ipv6_confirm_neigh(dev, &rt->rt_gw6);
+		__ipv6_confirm_neigh(dev, &rt->rt_gw6);
+		goto out;
 	} else if (!daddr ||
 		 (rt->rt_flags &
 		  (RTCF_MULTICAST | RTCF_BROADCAST | RTCF_LOCAL))) {
-		return;
+		goto out;
 	}
 	__ipv4_confirm_neigh(dev, *(__force u32 *)pkey);
+out:
+	rcu_read_unlock();
 }
 
 /* Hash tables of size 2048..262144 depending on RAM size.

base-commit: af6737b9066832a2017c281159950ba92385ce00
-- 
2.34.1


