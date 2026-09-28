Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E94A6CD1;
	Mon, 28 Sep 2026 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595109; cv=none; b=jPhjjjCCjl4rHr5PCwh8Qt9SG6pE2yFrogS5l6iHvIDwD1yZYiA7oMpfaxTHf5Owu0VqO9ZgXAf6ipCJE9ydgJNJHJwIRFvLnwg/ygPP2Bq03EzCEfVMkLOVfVisKgmIuQK5zAaf201C+1EYBmTctdNr5JxHLAhy7+wZUgBgyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595109; c=relaxed/simple;
	bh=UOqKbSPZHSOVoEXxJ2kp5L5KOcGYlTbx97YLZ0qwcP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiT2PrEOuoQhi4soLDntOG+hluLN/e4J32OiszIqOETlybQ42KEXZXKn/V2neRAtPeoEem8f3s3ceys9KWfXrSGlanekEpfIx0MkymB7xHGXu+K2jm45Bbin8wSwsA8pDCas5NxlWCeZdmY0QZDRqkbqlHhfZLrgMFSD0rTwSZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DqcD67r3; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DqcD67r3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cS
	skOMhCQIMEKA2IYreR7P1RbOAEsdgbgHk3mzfeXJA=; b=DqcD67r3U0x1CIhYlE
	tznUFoUVDu9ytZWHo1E23ysWiosSBGZM06YHMekzdRJkmqVjhpvptInXYQOh5tFN
	oyCgVL9fJ8+e+xZFPB1w7RmPVRYBkNAglxz2j1z9MWQQnPgXcPSt3ha9jQGDMATc
	9grP9yqETFL2mu3Iw0JWlOIKs=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3lz_8T7pqlkwmBQ--.64509S2;
	Mon, 28 Sep 2026 19:31:09 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org
Subject: [PATCH v3 net] net/packet: guard the ll header push in packet_rcv_spkt()
Date: Mon, 28 Sep 2026 19:31:08 +0800
Message-ID: <20260928113108.2127215-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lz_8T7pqlkwmBQ--.64509S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1xArykKw4xAr4rJFyDtrb_yoWrWF4rpa
	s8KFyDtr4kGr4aqw18uF4DZFyFvF4kJa4fua48G34Yvwn8WryrKFy0krW5uFyUKa18Ga13
	XF1DW34UAa4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piMa0PUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-x1c0Wq6T-2owwAA3m

packet_rcv_spkt() restores the link layer header with

	skb_push(skb, skb->data - skb_mac_header(skb));

That subtraction is only meaningful when the device actually has a link
layer header.  packet_rcv() and tpacket_rcv() both wrap it in
dev_has_header(), which is also the predicate the block comment at the
top of the file states the restore in terms of; packet_rcv_spkt() does
not.  commit d549699048b4 ("net/packet: fix packet receive on L3
devices without visible hard header") introduced the helper and changed
the two call sites, and this one stayed behind.

A device without a visible ll header can leave skb->mac_header at the
0xFFFF sentinel that __alloc_skb() initialises it to.  A CAN skb does:
init_can_skb() sets pkt_type and ip_summed but does not reset the
headers, and commit 9f10374bb024 ("can: remove private CAN skb
headroom infrastructure") dropped the skb_reset_*_header() calls that
used to be there.  skb_mac_header() is then 0xFFFF, the length becomes
a large negative number and skb_push() reports it through
skb_under_panic() -- from softirq context, so it is a full system panic
even with panic_on_oops=0:

  skbuff: skb_under_panic: text:ffffffff8bd21bc1 len:-65455 put:-65471 head:... data:... tail:0x50 end:0x180 dev:can0
  kernel BUG at net/core/skbuff.c:214!
  RIP: 0010:skb_panic+0x50/0x60
  Call Trace:
   <IRQ>
   skb_push+0x38/0x40
   packet_rcv_spkt+0xe1/0x170
   __netif_receive_skb_core.constprop.0+0x7e8/0xd30
   ...
  Kernel panic - not syncing: Fatal exception in interrupt

The socket type is reachable: packet_create() accepts SOCK_PACKET
alongside SOCK_RAW and SOCK_DGRAM behind the same CAP_NET_RAW check,
and neither the socket length nor a capability check keeps it away
from a CAN interface.

The missing skb_reset_*_header() calls in init_can_skb() are a
regression in their own right and are being fixed separately, but a
packet socket should not turn a link layer that did not initialise its
mac header into a kernel panic.  Guard the push the way the other two
receive paths do.

Tested on v7.3-rc5 under QEMU with a slcan device on a pty, which is
the driver RX path: vcan does not reproduce it, because can_send()
resets the headers on the way out.  One SOCK_PACKET socket bound to
can0 and one frame written into the line discipline panics an
unpatched kernel with the trace above; the same image with this patch
prints no panic and powers off normally.  Both kernels are this tree,
defconfig plus CONFIG_CAN_SLCAN=y, differing only in this hunk.

Fixes: d549699048b4 ("net/packet: fix packet receive on L3 devices without visible hard header")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---

Hello Oliver,

Removed the comment block, as you suggested.  You are right that the other
two dev_has_header() call sites do not carry one, and that the block
comment at the top of the file already states the invariant -- so the
comment was only restating the commit message.  The hunk is the guard
alone now, two lines.

No behaviour change from v2: same predicate, same push.  I re-ran the
QEMU/slcan pair on this exact revision to be sure nothing else moved with
it -- unpatched still panics with skb_under_panic len:-65455 out of
packet_rcv_spkt+0xe1 in interrupt, patched prints no panic and powers off
normally.  checkpatch is clean on the resulting diff.

Thanks for the review,
Quchaosheng
 net/packet/af_packet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7c83e01526ed..a951a1e3c088 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1911,7 +1911,8 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
 
 	spkt = &PACKET_SKB_CB(skb)->sa.pkt;
 
-	skb_push(skb, skb->data - skb_mac_header(skb));
+	if (dev_has_header(dev))
+		skb_push(skb, skb->data - skb_mac_header(skb));
 
 	/*
 	 *	The SOCK_PACKET socket receives _all_ frames.
-- 
2.43.0

