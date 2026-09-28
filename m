Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A6469854;
	Mon, 28 Sep 2026 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583022; cv=none; b=IQKUBd0hln1xPPqTHp6W/IFZGyeITUiY6NsDVU4pVawKBweLYRSSjQvGA5nxn5RK/0jySXTWJUfIfHC1oWxh08fzHrngh3aRPzV3eK5/QTxrJikdJCD7QbRb7Vs0QR2u/XKQIhO+IcuiMJycoiI8+V9mbJZLzqknD+bzes0RHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583022; c=relaxed/simple;
	bh=gsnQfoMWvT4gOXgSz/pav3SwHY17eQYEKINJQZ/JbGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gthsDz7BqPZFY4dg0WDNaO1pcc1RdNvd8deoEAt2kw4ERPpeEb4Dg5PP5cDCTywPL82MDU90W6GcOPg7GIcKIRRtEcOJdv8rxeUPYQ86fkhePlWtbXs1YMqnVvjZsCLHXXvqk+NOHOvsxrRH/wpYeSfccCoV0uWsuQRS48TA8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YDCSEg9W; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YDCSEg9W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5s
	B4Kk8Agy90VKZ6ZjhDiR3CfDgWQ7ypVhRCNo2mUDE=; b=YDCSEg9WGlguNCwJGw
	R7pFFKdHvbt2XtjE9CyLY9GbHbfPP9Tdpc9HL120+ZiymFJx1rXw2rQeOURcgz7g
	IhQbprYR+EZakedFG5hUI6OrE98zJ5KlLO7xs+1Vdk1SdgM3jFwv3fVghj23H3d4
	Ri+hCm9+hSp8vgMw75WrFslz8=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3sUq+ILpqZvRDBw--.54881S2;
	Mon, 28 Sep 2026 16:09:35 +0800 (CST)
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
Subject: [PATCH v2 net] net/packet: guard the ll header push in packet_rcv_spkt()
Date: Mon, 28 Sep 2026 16:09:19 +0800
Message-ID: <20260928080919.1888649-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a56a3e49-ffdf-4285-bca6-992b12127289@hartkopp.net>
References: <20260928065000.1749383-1-quchaosheng000406@163.com> <20260928065000.1749383-2-quchaosheng000406@163.com> <a56a3e49-ffdf-4285-bca6-992b12127289@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgB3sUq+ILpqZvRDBw--.54881S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFy7Jw4rWFyUXr1rJF4kXrb_yoW7uFWrpa
	s8tFyUtr1kGF4Y9r4xZa1kXFyYvFs5Ja4fWa4kGryYywn8Ww1FyFyIkrW5uFyjkan5Ga1a
	vF1q934DCa4vvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piAwIDUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5B+A9Wq6IL+dfgAA3i

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

Yes -- af_packet.c is the right place, and your question made me cut the
patch back, so this is a v2.

You are right that the CAN side is already being fixed: I ran zjamg's v2
earlier today and verified it holds.  The two are not alternatives to each
other.  That patch restores the header initialisations the CAN stack lost,
which is the actual regression; this one is the packet socket that should
not panic when a link layer hands it an skb whose mac_header was never set.
Either one stops the crash on this path, but only the pair leaves the
producer correct and the receiver safe.

On your question about where it belongs: packet_rcv_spkt() is the third
call site of the same subtraction, and commit d549699048b4 changed the
other two to dev_has_header() and left this one alone.  It is still the
only one that does the subtraction unconditionally, and it is reachable
with SOCK_PACKET.  So this is that commit's missing hunk rather than a
second opinion on the CAN fix.

The v1 had an extra skb_mac_header_was_set(skb) conjunct and this version
drops it.  dev_has_header() alone is what the block comment at the top of
the file states the restore in terms of, and what packet_rcv() and
tpacket_rcv() test; for a device without a visible ll header the documented
invariant is that mac_header points at data, so the subtraction is a no-op
push and skipping it outright is the same thing.  CAN is the case where
that invariant does not hold, which is the panic; the extra conjunct only
would have masked it.  I have re-run both kernels with this version.

Details of the re-run, since the earlier numbers were from the v1: v7.3-rc5
under QEMU with slcan on a pty, defconfig plus CONFIG_CAN_SLCAN=y, two
images from one tree differing only in this hunk.  Unpatched: skb_under_panic
len:-65455, packet_rcv_spkt+0xe1, "Kernel panic - not syncing: Fatal
exception in interrupt".  With this patch: no panic, powers off normally.
checkpatch is clean apart from the unavoidable long line in the quoted trace.

Thanks,
Quchaosheng

 net/packet/af_packet.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7c83e01526edc..40c67b86a1735 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1911,7 +1911,14 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
 
 	spkt = &PACKET_SKB_CB(skb)->sa.pkt;
 
-	skb_push(skb, skb->data - skb_mac_header(skb));
+	/* Only a device with a visible ll header can have it restored, which is
+	 * the test packet_rcv() and tpacket_rcv() already make.  For the others
+	 * the header is invisible and the subtraction has no meaning: a producer
+	 * that left skb->mac_header at its 0xFFFF sentinel turns it into a huge
+	 * negative length that trips skb_under_panic() in softirq context.
+	 */
+	if (dev_has_header(dev))
+		skb_push(skb, skb->data - skb_mac_header(skb));
 
 	/*
 	 *	The SOCK_PACKET socket receives _all_ frames.
-- 
2.43.0

