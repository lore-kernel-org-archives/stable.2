Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328852DFA3A;
	Mon, 28 Sep 2026 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578259; cv=none; b=gfaGsUBdEYp+rCXC6rcoeZxBk9QaFEre6HrkGSdUSMqVT4gIb99R23WOisRohG+kPNlN/n17RZnSu0EPBdP92zaHidwGjNFu/ztpaU01WyFsFX0tA57+RDVgUvYYvHCuB9TWpA7fE/uViZdc7oyjbI59e6gD0Vg+CWUWRqiVCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578259; c=relaxed/simple;
	bh=2E9G4VmDFD6/yu3yb1708hufoVcnZW/LN7zidVbYqPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HddLOTZoDBRRZwLQeeJvZjNtLUbl4JtzyBVjNDJ6p7mFyu00lxatUuuHRnF0BP0/08sJeKMxYhWqrqgiGHZ7qVk89SYP0qM6TuAfxDTgeVAj8FEXDM/pNja4NSlUKFdXG2M5A7V9q3E7njJbNS/10oPYA4srhsdIb6CDsaej918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F9UBXykz; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F9UBXykz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tI
	Mde4K42epJIrlb7se7/az4aigvinEYHEwl4Q4UHOs=; b=F9UBXykzlwXRfhnsjy
	u6t8cPrrZQ906qFWWSPpmt/NyE0ZBhJpKcYE7LF0HsuxEL0B6ad/ZRpJY/1KbFcW
	R9Rf9ve8/+NwDAjw8eyfgE+Vc+EVl0LVdUToHTP9Z0XowuMsSwcabWh+f6HGSsjb
	L3Y9QBxNSf4MgHQ/C+CUncNrg=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD350wnDrpqY_dYBQ--.60414S3;
	Mon, 28 Sep 2026 14:50:17 +0800 (CST)
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
Subject: [PATCH net] net/packet: guard the ll header push in packet_rcv_spkt()
Date: Mon, 28 Sep 2026 14:50:00 +0800
Message-ID: <20260928065000.1749383-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928065000.1749383-1-quchaosheng000406@163.com>
References: <20260928065000.1749383-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD350wnDrpqY_dYBQ--.60414S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1xArykKF4fXr45tFy8AFb_yoW5uF1rpa
	4DKa47Jr1kGr4ftr1xuF4xXF1YyF4rJayfGa48JryFkwn8WryFkFyFyFW5uFyUKFs5Ga1I
	vryqgw1jy3WkZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKjgxrUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AnWTGq6Din2bQAA3b


packet_rcv_spkt() restores the link layer header with

	skb_push(skb, skb->data - skb_mac_header(skb));

That subtraction is only meaningful when the device actually has a link
layer header and the producer initialised skb->mac_header.  A CAN skb
does not: init_can_skb() sets pkt_type and ip_summed but leaves
skb->mac_header at the 0xFFFF sentinel, because 9f10374bb024 ("can:
remove private CAN skb headroom infrastructure") dropped the
skb_reset_*_header() calls that used to be there.

skb_mac_header() is then 0xFFFF, the length becomes a large negative
number and skb_push() reports it through skb_under_panic() -- from
softirq context, so it is a full system panic even with panic_on_oops=0:

  skbuff: skb_under_panic: text:ffffffffadd28261 len:-65455 put:-65471 head:... data:... tail:0x50 end:0x180 dev:can0
  kernel BUG at net/core/skbuff.c:214!
  RIP: 0010:skb_panic+0x50/0x60
  Call Trace:
   <TASK>
   skb_push+0x4d/0x60
   packet_rcv_spkt+0xe1/0x170
   ...
  Kernel panic - not syncing: Fatal exception in interrupt

packet_rcv() and tpacket_rcv() already handle this: both wrap their
skb_push() in dev_has_header(dev).  packet_rcv_spkt() is the only
remaining receive path that does the subtraction unconditionally, and it
is reachable with SOCK_PACKET -- a socket type that still works and that
no length or capability check keeps away from a CAN interface.

The missing skb_reset_*_header() calls in init_can_skb() are a regression
in their own right and are being fixed separately, but a packet socket
should not turn a link layer that forgot to initialise its mac header into
a kernel panic.  Guard the push the same way the other two paths do.

Tested on v7.3.0-rc5 under QEMU with a slcan device on a pty (the driver
RX path is required; vcan resets the headers on the way out and does not
reproduce it).  A SOCK_PACKET socket on can0 panics an unpatched kernel
with the trace above and is silent with this patch applied.

Fixes: 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 net/packet/af_packet.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7c83e0152..ab8e0309e 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1911,7 +1911,17 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
 
 	spkt = &PACKET_SKB_CB(skb)->sa.pkt;
 
-	skb_push(skb, skb->data - skb_mac_header(skb));
+	/* The push restores the link layer header, which only exists for
+	 * devices that have one.  A device without a visible ll header
+	 * (ARPHRD_CAN and other L3 types) must not be pushed, and the
+	 * subtraction is meaningless when the producer never initialised
+	 * skb->mac_header -- it then holds the 0xFFFF sentinel and the
+	 * result is a huge negative length that trips skb_under_panic() in
+	 * softirq context.  packet_rcv() and tpacket_rcv() already guard
+	 * this with dev_has_header(); do the same here.
+	 */
+	if (dev_has_header(dev) && skb_mac_header_was_set(skb))
+		skb_push(skb, skb->data - skb_mac_header(skb));
 
 	/*
 	 *	The SOCK_PACKET socket receives _all_ frames.

