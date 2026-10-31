Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417130;
	b=qDiTYpw2T4hAv3ZVf8pTMYPG4OkMWi3+kEcOzzlhy4wHfu6EBAlFXEjKwqK3YXoPNbq/
	 iQhQ4EzzLaHtW/DC5WKBqW9guVNrSX7OE961rUmDlaZY57u65SQF51hPjjOEkFGcRV1/Y
	 JKeg40AcNHKn2t0iyiE2+pOUYIIdyKdGm7TgunJIuOP/yEuYK3oF4emI9ZFQ2p57j98XA
	 6Lbe4Frgc1kLOc7iBvpIJushWlUa8OqW9EGDEQONpm6Jee9K8VSfKefzzWiVH0MslYjg4
	 ytq3egbodhhWTZ/PLbP0Rt70ISkF2UKC8FuUFDtRifeiKSxx28QM4YXk6VXv7CaKIzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417130;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=JWFtuB8p/nC8iRQ5tDviTJ407yr+c+xO46BSQyzl+w8=;
	b=IkAViMyYYf9mRSjvR6mfZZRWFeNjwFubJb32x8f/jG4jsob45OJ6arRNE1IFdhMg5eaT
	 OhcKlyornXH2bJEDAvttCdZ6+VGPNTj5vCubnOAf3INDgP7EyDT/rCtIUT4G3xyuw4d8+
	 yL3bBKTdH6LfsBAeZnEtY1M4G0Q4oWC4Jq/8iYxKR8B/a22Gv3c6khbQ2KhyNZyxX1Hbc
	 hACjuKne1x81FVSl+uYSANhIYK6CqarfA2GqZBeeIjiY9qIl284MzBjgh5ovWdrOHfvTT
	 qEPENrxF81C9eHgpdQTVtSbtAeeO4ex20t/1aNrQaXA5qJP7hkAKuH8/QX8Wwbah/dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ugreen.com;
	spf=pass smtp.mailfrom=ugreen.com;
	dkim=pass header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b="LQEFaYf/";
	arc=none smtp.remote-ip=54.206.16.166
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70C606A31A;
	Sat, 31 Oct 2026 03:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E70C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=LQEFaYf/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1793417002;
	bh=JWFtuB8p/nC8iRQ5tDviTJ407yr+c+xO46BSQyzl+w8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LQEFaYf/BfzVIyMHUAsqnRFUFbscctXRWVQi+Ej1cPv4cGy68XAJj2bhggKISHbRx
	 Li9HI94e/dzUcsL1aTigt2ZSLMZALEKhXwK6RxUkVNrlAAGnJZchjU5UfdpH8J00RV
	 h2cc+p6BaxY4ptFlFwA0C3/XIrharEFJOwbvlgNg=
X-QQ-mid: zesmtpsz3t1793416996t4be89f10
X-QQ-Originating-IP: OjaJ8OvjxXAVJODd93Fr5lnT3csinDR4LetREcZD+do=
Received: from exmail.qq.com ( [113.89.160.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 31 Oct 2026 11:23:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16540221932053630440
From: Hanson Wang <hanson.wang@ugreen.com>
To: netdev@vger.kernel.org
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: atlantic: stop TX again before freeing rings
Date: Sat, 31 Oct 2026 11:23:08 +0800
Message-Id: <20261031032308.2991494-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MYcyYH/A/+tCGs5QprDqVHvqisRP025A6kGk6KEOSzijvZ27VCw5fMbV
	crVx1hdH8k9rr9Q8YCST/HKX5UNLJt6knoa4egXzOR/pc/v7jlhLzk2K3S4pOw0oxwK0UpQ
	ezyNToO6509x4ao3RHJJai4cPTaqsyHU+vc2HUxaq3Tb1sfRlGaeNRX4yWiXv9iRgw2Y+KB
	5eT9hIb+kJXGp7HUA+iewHSM5ZdfyM6wr7m6NziAckObjQS2Bj/1tNT2hqioIdC1f4O3IE4
	loonUvQeR+4zpipU24mYoaFg24H1yd7/Rh6+KL/npmy/AODb7ZMsc+jCvqLPa4z1CFAsdIE
	Yd6Yv/0U5idU64vLORyhjzYMvT8/czcLC4FYzgm98D+ew6hUG7XtEpiRHnfD6mCq3bzZFki
	VI6wM79U3Js4cMSVjeSad1zifuvLr1SwkEZ+IPdDDEz7/zwHQqtchNE93DINnk/abPhSMPs
	8Vicb98E9ujLWYFL968aqwklJpq7Sd20xGoWvy2aWP1B0RtZMXTfHRlNZrgSdyiDVj+sdnh
	3YtXYW4Uj3PbhicNJYnXIqDjn17TebbxGTXaCY7vfmEJDIHgt5b+6qJAf4b4YzyM/gYod6W
	5o2MNoGkZ8ptVhnPOQRQCb3HkjyJxaK7CtvttZkBwfyYrn7zXzKhTZyGafX+bd+KPo9VBtC
	C8EiA0CWZoCt/YUzBq3TBwyQ5f1OKVCNVwfBWpjtPY5ZeuAtzStxvdExtnnn+120cJ+Rv3+
	YHVU8JgG1mwsvP9SAmXfEAC6ddUcqNxS/yTjtoLusS/MJZdAQ+H5icrPiUJQew0Jyu3OWcM
	+2SZlL+rJR4drwhl0dlwChIBUrv/1dFTMrB8+RZNYB2+SNL00wODcoBChZKAjZEF1h+zFoU
	cck25j+nNoEZAkUG1EJv8YEV9I5ly33alOFRdrks6IZnGalCrgvwvMdGZtwukhbvKTH8jF8
	bmNUskkEpVwGbTZYmDPM0TTxoREFERJLpylGqoGJB6cn2lkR3qLyyLmG+Zae89qIc4bsUEg
	nThkWLsh3giq4bbA3WCwj3DId7Z8n8wMFcf5cmtn3yl6vfFVA8
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

aq_nic_stop() disables TX and drops the carrier, then cancels the
service work, frees the link IRQ and disables NAPI. A link update or
TX completion can turn the carrier back on and wake queues after that
first netif_tx_disable(). ndo_set_features, ethtool ring changes and
XDP setup call aq_ndev_close() directly, without dev_deactivate(), so
a re-woken queue is still reached from ndo_start_xmit. aq_nic_deinit()
then frees buff_ring and leaves sw_tail unchanged.

On a UGREEN DXP2800 GT running 6.18.15 this oopses in aq_nic_map_skb()
from the IGMP timer softirq. The faulting store is dx_buff->flags = 0
at R10+0x28 with R10 == 0xc00: buff_ring is NULL and sw_tail is still
non-zero. Every module is unsigned, so the kernel is tainted E; the
atlantic driver itself is the in-tree one.

 BUG: kernel NULL pointer dereference, address: 0000000000000c28
 #PF: supervisor write access in kernel mode
 Oops: Oops: 0002 [#1] SMP NOPTI
 CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G E 6.18.15
 Hardware name: UGREEN DXP2800 GT/DXP2800 GT, BIOS APS15021 04/14/2026
 RIP: 0010:aq_nic_map_skb+0x302/0x570 [atlantic]
 Code: 44 0f b6 78 06 <49> c7 42 28 00 00 00 00
 R10: 0000000000000c00
 CR2: 0000000000000c28
 Call Trace:
  <IRQ>
  aq_nic_xmit+0xc6/0x150 [atlantic]
  dev_hard_start_xmit+0x63/0x1c0
  sch_direct_xmit+0x154/0x3a0
  __dev_queue_xmit+0xb8c/0xe80
  ip_finish_output2+0x25f/0x580
  ip_output+0x65/0x100
  igmp_ifc_timer_expire+0x1d5/0x420
  ...

Stop and drain SKB transmit again after those wake sources are gone,
and drop the carrier in the same place, before hw_stop(). The rings
are freed by the caller only after aq_nic_stop() returns.
netif_tx_disable() holds each queue lock, so it waits until
sch_direct_xmit() has left ndo_start_xmit; the stopped bit then keeps
later SKB transmits out. hw_stop() only masks interrupts and does not
wake queues.

ndo_xdp_xmit is a separate path and is not covered.

The barrier below has not been booted on the failing NAS. The oops is
from the unpatched kernel. The diagnosis and this changelog were
prepared with an AI coding assistant from that oops and the driver
sources.

Fixes: 3aec6412e007 ("aquantia: Fix Tx queue hangups")
Cc: stable@vger.kernel.org
Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 42e0fe9248f2..a6ceec0a22da 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -1448,6 +1448,12 @@ int aq_nic_stop(struct aq_nic_s *self)
 
 	aq_ptp_ring_stop(self);
 
+	/* Link updates and TX completion may have woken queues after the
+	 * first disable. Drain SKB transmit again before the rings are freed.
+	 */
+	netif_tx_disable(self->ndev);
+	netif_carrier_off(self->ndev);
+
 	return self->aq_hw_ops->hw_stop(self->aq_hw);
 }
 

base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
