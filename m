Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661950;
	b=BvvvCiFUnlmam0ulmDiN95TVVcty5soel5lB06/QuqkufkopfBIEl+LVn0Vsa2SQlA1H
	 3OAudbovkZyhTZuKG+QBJp840jmIaQd99r3bTaVRb0GeW5uBqYWjtaAdwh3yN+FJWHb4i
	 pYJ0GpGbzCeV6rZFZq57oV6M7KmRXCPISpntFyIU4ySDmXGO3P892n8BQJvtyLPCp/0jf
	 c+2D+eFay0vwC1QZPNFyZfLT4N5cddT45ctvVl9rRwzBcPqYvI+gXGfxVEcBpfRDE9/MN
	 8LalGz1sxLkQwp4ym83u9n0hfOAB41E9CuO67G2mlt9qRuPutGBjmYDwTI6Gbqc79ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661950;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=1MtmMD+EKzX18jpzkrhIroFejbF4xZVJTPvGgibSgEk=;
	b=kksabPnMiq9C5Dq0mvaLkhiTWT5X34ItjTGnnfrhwmnwecGVTDT824vhlKvU74/8HrHA
	 IrOBmXaGf6rYpq95PPR71bbz9YE3msc1WaCFpuzC47aQbTe2zygH4f1HZdP0RM/Byg5lN
	 13kLbhYTdF8AjBpbFHAWCMV7Q951xvbHxN9OP/ilB2fR6N6vX07p3VNN27F2mgP7MrBjU
	 DCpcB5Dr3lm8uiW41yD6PdVLvGPo5QS0v56VBIaQAhEzea2JU+fCDKVRU1aca6sozRISX
	 KTxYXFYHa1PVu1OTg8PO5+d/HCbSaczdwZ64of7ltEYvBB20Y8W09QGZH9JI+rriILg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=wadhKoq8;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D901606A33D;
	Thu, 22 Oct 2026 09:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D901606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=wadhKoq8
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j9Lh36HJXzMlSC;
	Thu, 22 Oct 2026 11:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1792661939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1MtmMD+EKzX18jpzkrhIroFejbF4xZVJTPvGgibSgEk=;
	b=wadhKoq8PfoPvOwjGjxaL7gafBly+0/63cAGTgqgQvXETcyS0Mlpvn8Hqlxh6uItsZry2U
	Xz5AV2zVPU4yzagQD6eepUxMY4hQE9mE7fP0lviOeZsiecHOTx6h9kMsUL8ChCFXfFiJG6
	FAELNXqjAaAYO7Z+UdNscuZflKe69MBONd9u6FSROoE8MfjsRwtLheCqeT4zu+DyPHTXUH
	iVHjG7qGcfIZ1xqc8ATWWrjY6qdzWlTAlGD4VHc0YBHZnTDZaQi038RpLFRSvTd/kntJv7
	Ytmfa+G3/AAVNa59NJh2uUhCjOowHXMyKTer2tTuyCoot5wQPFI7GK0Z4ugshQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Subject: [PATCH RFC net 0/6] net: macb: fix TX stalls, IRQ storms and a
 lost NCR update on link-up
Date: Thu, 22 Oct 2026 11:38:45 +0200
Message-Id: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1Jm7UAT20LdCh7Arbhokl8dwSiZW
 ITSu5vW5fuf92ZSJIHSoZopYRKVVyxgdhX5+xBvYAmFyda2M7W1rDnwc/COJ9OwIgbufDuGft+
 7BoaK904Y5bs1L3Q+HdctItP1/+nHPeDzGqVl+QEHISGSgQAAAA==
X-Change-ID: 20261022-std-macb-v14-send-6c5fd939b4e1
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kevin Hao <haokexin@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Andrea della Porta <andrea.porta@suse.com>, stable@vger.kernel.org, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792661936; l=6425;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=VVYNF3CyJIPb6nRtInpDj5vqmMPYtt3i85wDH8ipWgk=;
 b=7tFuKdiAy2s2+rQAW+z77qagxj5/P3AlmLVygBcRvOwH2pcGFdTdMh50NOHq9MqGVylgwyk2k
 pMGllQJgnbxBWDyV7zNGCGiplNRyyABgBddyzsM/9/to4iQd1q6NLyw
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4j9Lh36HJXzMlSC

Hello Théo, Christian, all,

I've been looking at RCU and TX stalls on macb devices (Xilinx ZynqMP on
Beckhoff CX9240) for a while and have been carrying downstream patches
similar to Christian's. A while ago I let Claude try to reproduce this on my
devices, it was able to reproduce and found some fixes but I wasn't
happy with the quality of the patches and my understanding of them. I
briefly talked to Théo in Prague and he suggested I send what I have as
either the patches or the reproducers may be useful for ideas.
I've finally gotten around to it and also ran some more testing and improved
the patches in the meantime. The series includes Christian's patches in the
original form (should also at least be reworded) and I also have Patch 1 in here
since the bench seems to have reproduced the issue on hardware (see below).

If anyone has other ideas / patches for these issues I'm also happy to
run tests on devices.

Claude output from here:

This series fixes the TX stalls, TXUBR interrupt storms and RCU stalls we
reproduce on ZynqMP (GEM rev 0x50070106, two TX queues, PREEMPT_RT).
Patch 1 is Théo's NCR locking patch [1], unchanged; patches 2 and 3 are
Christian's v1 [2], unchanged; patches 4 to 6 are ours. Patch 6 is most
likely what Théo reported in [3].

Reproducers (all on the same ZynqMP board, RT config, IRQs on CPU 0,
rcu_cpu_stall_timeout=8, iperf3 -P10 against a host on the same link):

 A. the link speed is toggled between 100 and 1000 Mbit/s every ~12 s
    with "ethtool -s end0 speed {100,1000} duplex full autoneg on" while
    the load runs; after every link-up the transmit counter, the netdev
    watchdog counters and the interrupt rate are checked. A storm is
    left running so the RCU stall detector can report it.
 B. a managed switch cycles the DUT's two ports (one port only, the other
    port only at 10 Mbit/s, back at autoneg), ~140 s per cycle; a hit is
    an RCU stall on the serial console.

Results, vanilla net/main 78731b46967e, PREEMPT_RT:

  driver                       A: failures/toggles          B: hits/cycles
  net/main                     watchdog at link-up 2,       1 TX stall episode
                               RCU stall at link-up 3       in 74 cycles
                               (idle mode: stall at 3)
  patches 2-6                  0/300 (idle mode 0/50)       0/74 (with load)

Same on a v7.2.7-rt tree with the net/main driver files (same bench):

  net/main                     8/9 toggles failed, RCU stall after 9 link-ups
  patches 2-6                  1/300 (one dead transmitter), 0 stalls in ~1300

Per patch, one patch removed at a time from the series (method A):

  patch 2 (TBQP) alone off        0/100; TBQP reads the stale pre-link-down
                                  index in 176/295 link-ups without the write,
                                  0/555 with it (trace)
  patch 3 (TXUBR mask) alone off  0/100
  patches 2+3 off                 RCU stall at toggle 85 (1/153)
  patches 2+3+4 off               RCU stall at toggle 42 (1/41, p = 0.03)
  patch 4 (rotate) alone off      1/97: TBQP stopped at index 0 on the used
                                  descriptor of an unreaped frame, watchdog
  patch 5 (kick) alone off        8/11 toggles: watchdogs, p = 7e-13
  patch 6 (queue 0) alone off     1/100 watchdog; per-stream share at
                                  100 Mbit/s 6.9 to 11.7 Mbit/s over both
                                  queues vs 9.3 Mbit/s x10 with it
  patches 5+6 off (2-4 only)      8/16 toggles: watchdogs on queue 0

So patches 2, 3 and 4 together prevent the storm and the RCU stall, patch
5 fixes the TX stall after link-up, patch 6 fixes the strict-priority
unfairness (no starvation-induced stall reproduced on this device).

Patch 1: once in ~300 toggles the transmitter stayed dead after a link-up
with patches 2-6. Tracing every NCR writer showed the cause:
macb_mac_link_down() clears RE|TE with an unlocked read-modify-write,
and macb_tx_restart() in the TX NAPI poll, which had read NCR with TE set
just before, writes its image back with TSTART 40 us to 900 us later. TE
is set again while the link is down, the next link-up starts with TE set,
the TBQP write of patch 2 is dropped and the ring is rotated under a
running transmitter. With the read-to-write gap of the TSTART path
widened to 1 ms to amplify the race: without patch 1, 3 dead transmitters
and an RCU stall in 792 toggles, 6 lost updates in 408 traced link-downs;
with patch 1, 0 in 1196 toggles (p = 0.025) and 0 lost updates in 1206
link-downs. The
traces (link_down clear, the stale write from irq/22-eth%d, TE set at
the next link-up) are available on request.

Answering the review of [2]: with the rest of the series in place,
removing patch 2 or patch 3 alone gives 0/100 each, removing both brings
the RCU stall back (1 in 153 toggles), removing 2, 3 and 4 gives 1 in 41;
TBQP of queue 0 keeps its
value while TE is low in about half of the link-ups on this GEM, as in
Christian's trace, while the fetch still starts at the base after TSTART.
Both reproducers were run on vanilla net/main; only PREEMPT_RT was tested.

Théo's steady-state case ("iperf3 -P10" for 30 min without transitions)
gave no watchdog on this device with or without the series.

[1] https://lore.kernel.org/netdev/20260918-macb-ncr-rmw-v1-1-30c3494f93cd@bootlin.com/
[2] https://lore.kernel.org/netdev/20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com/
[3] https://lore.kernel.org/netdev/DLIJN4CDS11K.RVJGK3UALMJE@bootlin.com/

---
Christian Taedcke (2):
      net: macb: reprogram TBQP after shuffling the TX ring on link-up
      net: macb: mask TXUBR during TX NAPI poll to prevent IRQ storms

Steffen Dirkwinkel (3):
      net: macb: rotate unreaped TX frames behind the ring base on link-up
      net: macb: kick the transmitter on link-up
      net: macb: keep best-effort traffic on TX queue 0

Théo Lebrun (1):
      net: macb: take bp->lock around NCR read-modify-writes

 drivers/net/ethernet/cadence/macb_main.c | 80 ++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 13 deletions(-)
---
base-commit: 78731b46967e3e7102b5cd5062bef185f3404b5c
change-id: 20261022-std-macb-v14-send-6c5fd939b4e1

Best regards,
--  
Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

