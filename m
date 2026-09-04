Received: from va-2-37.ptr.blmpb.com (va-2-37.ptr.blmpb.com [209.127.231.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70F3EC83B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539408; cv=none; b=tlWsNUPhbG2EV0zeK9saoL+lbGUzT/7f4pHpCM010moDpMLI3HN/6ycaTWB0tX4hDB5Z8vAwAeqLDoVBbDY11rhUF7SBIXd404kttRuN8inae1ZLjxEA+5DDuyo1d4+mn5Q2DxQZATbrlwemhaNFFDaU0P50hRbdwQp2EYIiDuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539408; c=relaxed/simple;
	bh=2UzV47eyqEN6kda7jBhEffBfss4UK5TCeSkvg1YP4g4=;
	h=To:From:Date:Message-Id:Cc:Subject:Mime-Version:Content-Type; b=ElOQTv+WhuwRQaL9apRx3BXlBivpu4h7yxI35e/as2naivERKD2Ph2dIi2WiZQ6wzHLPvPbK2RMNXJnHCNwgtWwH3az0SpW6AgTAItgLNT5FcSHunMwfCpNe6sS8kiAauBI9QHMVlUcUdxlq4eMUiQVpqPiwoXjHq7SjtnLff/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=JpoPRaxj; arc=none smtp.client-ip=209.127.231.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="JpoPRaxj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788539286; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cCvtHfGGl259QrWzwudsWa5IwYjsJ7Z2jP7mYSd5vM0=;
 b=JpoPRaxjq6/ZK0bV2+R/U/FRzUNouKHR8Sw3wsH4jtY6C1sSPg1/CCn9Pyx6akp7j6gGBT
 zJ4Tqxb+IIkrgBeQvtkZkdRcXBAdIIdqrLGL/k9ylqcuH9/rjKq7jc1hRzMhE64zj3mcjb
 vytIAVaSlC3/YSUBCSv1Z9vYRuLt8aVLN3+arkEGLUfs1pkCmE/Mx8UTmz75eb7zD0MKtr
 65ZxVYUz0nNIE7879x5VHEIZjDDMm7Rw9xJmScO9FpCwDdVitVCyv7NbckDe9xDsnEyYHY
 3WCFTuVlaKbX6wxmrz6inpZyrN+2t/PgwjSvQkzGeg3Ycz1Z7xoPzqP5C4Dusw==
To: "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Date: Sat,  5 Sep 2026 00:28:00 +0800
Message-Id: <20260904162800.1095662-1-yilinzhang@moonshot.ai>
X-Lms-Return-Path: <lba+26a9af195+71c7a3+vger.kernel.org+yilinzhang@moonshot.ai>
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Kimi Security Team" <bug-report@moonshot.ai>, 
	"Weiming Shi" <shiweiming@moonshot.ai>
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Sat, 05 Sep 2026 00:28:04 +0800
Subject: [PATCH v2] inet: frags: invalidate queues before flushing them
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.34.1

fqdir_pre_exit() flushes the skbs from incomplete queues without
changing their completion state. A fragment which found a queue before
high_thresh was cleared can then acquire the queue lock and reuse stale
reassembly metadata. A queue concurrently killed after fqdir->dead is
set can instead become INET_FRAG_COMPLETE|INET_FRAG_HASH_DEAD while
still holding its old skbs; skipping it because it is complete leaves
those references behind until asynchronous fqdir teardown.

For IPv6, stale metadata can make ip6_frag_reasm() use the old
nhoffset with a new skb and access memory out of bounds. The resulting
heap corruption can be leveraged for local privilege escalation when
unprivileged network namespaces are available. Unflushed fragments can
also keep conntrack references alive after the conntrack per-net
cleanup point.

Kill each incomplete queue, then flush every queue still owned by the
dying rhashtable. HASH_DEAD identifies that ownership, while complete
queues without it are already owned by another destroy path and must be
left alone. Releasing a timer reference removed by inet_frag_kill() is
deferred to inet_frag_putn(), after the queue lock is dropped.

KASAN report:

  BUG: KASAN: slab-out-of-bounds in ipv6_frag_rcv (net/ipv6/reassembly.c:289 (discriminator 2) net/ipv6/reassembly.c:229 (discriminator 2) net/ipv6/reassembly.c:391 (discriminator 2))
  Write of size 1 at addr ff110001039c6e00 by task poc/771
  Call Trace:
  ? ipv6_frag_rcv (net/ipv6/reassembly.c:289 (discriminator 2) net/ipv6/reassembly.c:229 (discriminator 2) net/ipv6/reassembly.c:391 (discriminator 2))
  ipv6_frag_rcv (net/ipv6/reassembly.c:289 (discriminator 2) net/ipv6/reassembly.c:229 (discriminator 2) net/ipv6/reassembly.c:391 (discriminator 2))
  ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479 (discriminator 5))
  ip6_input_finish (net/ipv6/ip6_input.c:534)
  ipv6_rcv (include/net/dst.h:480 (discriminator 3) net/ipv6/ip6_input.c:119 (discriminator 3) net/ipv6/ip6_input.c:109 (discriminator 3) include/linux/netfilter.h:325 (discriminator 3) include/linux/netfilter.h:319 (discriminator 3) net/ipv6/ip6_input.c:351 (discriminator 3))
  packet_sendmsg (net/packet/af_packet.c:3110 net/packet/af_packet.c:3142)
  __x64_sys_sendmmsg (net/socket.c:2883 net/socket.c:2880 net/socket.c:2880)
  The buggy address belongs to the object at ff110001039c6b40
  which belongs to the cache skbuff_small_head of size 704
  The buggy address is located 0 bytes to the right of
  allocated 704-byte region [ff110001039c6b40, ff110001039c6e00)

  BUG: KASAN: slab-out-of-bounds in ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:423 (discriminator 1))
  Read of size 1 at addr ff110001039c6e08 by task poc/771
  Call Trace:
  ? ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:423 (discriminator 1))
  ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:423 (discriminator 1))
  ip6_input_finish (net/ipv6/ip6_input.c:534)
  ipv6_rcv (include/net/dst.h:480 (discriminator 3) net/ipv6/ip6_input.c:119 (discriminator 3) net/ipv6/ip6_input.c:109 (discriminator 3) include/linux/netfilter.h:325 (discriminator 3) include/linux/netfilter.h:319 (discriminator 3) net/ipv6/ip6_input.c:351 (discriminator 3))
  packet_sendmsg (net/packet/af_packet.c:3110 net/packet/af_packet.c:3142)
  __x64_sys_sendmmsg (net/socket.c:2883 net/socket.c:2880 net/socket.c:2880)
  packet_sendmsg (net/packet/af_packet.c:2959 net/packet/af_packet.c:3053 net/packet/af_packet.c:3142)
  __x64_sys_sendmmsg (net/socket.c:2883 net/socket.c:2880 net/socket.c:2880)
  The buggy address belongs to the object at ff110001039c6b40
  which belongs to the cache skbuff_small_head of size 704
  The buggy address is located 8 bytes to the right of
  allocated 704-byte region [ff110001039c6b40, ff110001039c6e00)

Fixes: 006a5035b495 ("inet: frags: flush pending skbs in fqdir_pre_exit()")
Cc: stable@vger.kernel.org
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Tested-by: Weiming Shi <shiweiming@moonshot.ai>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
 net/ipv4/inet_fragment.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -235,15 +235,21 @@ void fqdir_pre_exit(struct fqdir *fqdir)
 	rhashtable_walk_start(&hti);
 
 	while ((fq = rhashtable_walk_next(&hti))) {
+		int refs = 0;
+
 		if (IS_ERR(fq)) {
 			if (PTR_ERR(fq) != -EAGAIN)
 				break;
 			continue;
 		}
 		spin_lock_bh(&fq->lock);
-		if (!(fq->flags & INET_FRAG_COMPLETE))
+		if (!(fq->flags & INET_FRAG_COMPLETE))
+			inet_frag_kill(fq, &refs);
+
+		if (fq->flags & INET_FRAG_HASH_DEAD)
 			inet_frag_queue_flush(fq, 0);
 		spin_unlock_bh(&fq->lock);
+		inet_frag_putn(fq, refs);
 	}
 
 	rhashtable_walk_stop(&hti);
-- 
2.43.0
