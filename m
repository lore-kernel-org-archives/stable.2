Received: from va-2-27.ptr.blmpb.com (va-2-27.ptr.blmpb.com [209.127.231.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363154B270F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444783; cv=none; b=k710+nhF8WOQryhBnDVLEq7vPz9rzVFblnGPtlyCNWpuAzytSFoFfONKS+u4PPsdCfpLsWeW2UVVMrDVg0GyU03oncrdfTUzc6ec+tWblZvRAr3+jjcuZv0jzbsRjCzvRPNlmJtjMQHn5KzY7MDnglA8KX5WHiwkScm1mPPFgWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444783; c=relaxed/simple;
	bh=puSA5liMU6OpiwuG3Ma1tWEIw4biXvPc5legy2szouk=;
	h=From:Mime-Version:Date:Content-Type:To:Cc:Subject:Message-Id; b=kTcXOMkwqwtHFT+HpMXB6FstCIAuN3i15T1qMNWPP6epSJGktFIyz5l2rFTEBcKBIXT9NASmRy5OBJ/9jbBXCW9zp2Smila5h1vsqia4f2xiXn0YX5iZMBwIF/a1eW1hvSQXSdp5ytWaaBblawWGzyrvWblFUd+D+xJGQfjiWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=FPFXknmN; arc=none smtp.client-ip=209.127.231.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="FPFXknmN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788444764; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=g3dTl09kOzRbhIjm5SK5uaKZxMYR1BcThZlmWS3SkPY=;
 b=FPFXknmNh0MZNPekFcRZaXKDsmcAWmPh1ZKPDl7o9saV5FUdG4khV9CjvBpztEgPuWK9ZE
 5xKtOgSX76BDGBp6pYyTlGiuhpsFGWEYT5VWdAKomf1HRGU6qwrei4fj/yHidYyaYLGZmp
 oo/JqdZejFgEi3SV9pyMW7fD3b74AN9dIuYHLjqvbLYSx8HmDUz/4oRMSJuJ2nbYJS6l3g
 VWftcKvWE4DBobIVVgggt0j/HRBFJA1sNN9skFLZ8rJto81PVEVnTX7QjEMTv/r/J7tq0d
 2KbApi5x9q4UhApXdvaAJOA+I7LQm1Hj1lf30DxcH8Cwb5G7eAo2jM+rhiEamw==
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a99805a+f725be+vger.kernel.org+yilinzhang@moonshot.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Thu, 03 Sep 2026 22:12:42 +0800
Date: Thu,  3 Sep 2026 22:12:03 +0800
Content-Type: text/plain; charset=UTF-8
To: "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Kimi Security Team" <bug-report@moonshot.ai>, 
	"Weiming Shi" <shiweiming@moonshot.ai>
Subject: [PATCH] inet: frags: invalidate queues before flushing them
Message-Id: <20260903141204.40934-1-yilinzhang@moonshot.ai>
X-Mailer: git-send-email 2.34.1
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>

fqdir_pre_exit() flushes the skbs from incomplete queues without
changing their completion state. A fragment which found a queue before
high_thresh was cleared can then acquire the queue lock and reuse stale
reassembly metadata.

For IPv6, this can make ip6_frag_reasm() use the old nhoffset with a
new skb and access memory out of bounds. The resulting heap corruption
can be leveraged for local privilege escalation when unprivileged
network namespaces are available.

Kill each queue before flushing it in fqdir_pre_exit(). This marks the
queue complete and releases any timer reference removed by
inet_frag_kill(), while leaving the hash reference for the asynchronous
fqdir teardown. In-flight fragments consequently take the existing
complete-queue drop path without changing the reusable-queue semantics
of inet_frag_queue_flush().

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
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
 net/ipv4/inet_fragment.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -235,15 +235,22 @@ void fqdir_pre_exit(struct fqdir *fqdir)
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
+		if (!(fq->flags & INET_FRAG_COMPLETE)) {
+			inet_frag_kill(fq, &refs);
+		}
+
+		if (fq->flags & INET_FRAG_HASH_DEAD)
 			inet_frag_queue_flush(fq, 0);
 		spin_unlock_bh(&fq->lock);
+		inet_frag_putn(fq, refs);
 	}
 
 	rhashtable_walk_stop(&hti);
-- 
2.43.0
