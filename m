Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB878373BE8;
	Mon,  6 Jul 2026 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346551; cv=none; b=m4kto0PQEVCD5mH8SvPtyq4j8BpkRbfwNn4CFnrdUvcR9O8ntPkd7e9v/DWLK/6xnAd2oIJY6g/NaZ6D7h6pprFIvkNQrxH1p9pu4z+svRRM/t3VCTsNbbWOZavrf9ANZZXG/sOKHX/iay7abaNzFbq24F3TEpw21FsXnz7xrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346551; c=relaxed/simple;
	bh=LGjH+VaxkyRsmQ/os7WX5aNwBGmhH6HBNhqikwdceMM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CP+qiM3Z2qxb6Q9IXVRQ0gjIFI+fJI2i/PycxisCJ2XQgJ8A2N4USGofnFewVbfkNkBjx1+66Iosgz0xQqz7ONxcPDnI4h8hkvwi60csdG83CF/279xt/5jaQjT/OAgOipt2rhtr7u3LPv5L9QS/73edHtanEoUgc0iSoo1gEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPbVPNsR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPbVPNsR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 590A4C2BCB8;
	Mon,  6 Jul 2026 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783346551;
	bh=LGjH+VaxkyRsmQ/os7WX5aNwBGmhH6HBNhqikwdceMM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qPbVPNsRQvg023DCq9xlCKDPO+uDYvxvsIuToYQiLpM87/h21+ei2r8ZdQwVSu2rj
	 QUVCfQRbebCI8miHBj2SdJybXawrUGYVcOaXVIH7fSiBN++/oWZVEJHX/Mg9mtBY0o
	 5UbSj5CpU3LgMqeytDkFslTIb1h0fVT2Oq+maujPKP8KyGOEjs0LcswD0flOahnv3v
	 WBxGTzSmVWXMJ+5t/35x92GRPW+7nOwkaO53rB6BMDRvwKtVOfL7UV02iVfFX/LwtC
	 1+oafBaZON8FkD+df4eO0r6jDw1q6nE0JV8cst/E5zo+BFJCF04NcFFaX6uwmk+zC7
	 Pos+l0IA1O4PA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EDFC43458;
	Mon,  6 Jul 2026 14:02:31 +0000 (UTC)
From: Christian Taedcke via B4 Relay <devnull+christian.taedcke.weidmueller.com@kernel.org>
Subject: [PATCH net 0/2] net: macb: fix TXUBR interrupt storm on link
 flapping
Date: Mon, 06 Jul 2026 16:02:13 +0200
Message-Id: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGW1S2oC/yXMywrCMBBG4Vcps3YgTcHbq4iLpP2tIyStM6kIp
 e9u1OU5i28lgwqMzs1KipeYTLlGu2uov4c8gmWoTd75vTu4jpfZiiIkySOn0EcWfbKVSRMjDv7
 kYotj56kCs+Im7x9+oYxC1/+0JT7Qly9L2/YBE/amu4MAAAA=
X-Change-ID: 20260703-upstreaming-macb-irq-storm-ebd290b1e832
To: christian.taedcke-oss@weidmueller.com, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kevin Hao <haokexin@gmail.com>, Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Robert Hancock <robert.hancock@calian.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783346550; l=2123;
 i=christian.taedcke@weidmueller.com; s=20260702;
 h=from:subject:message-id;
 bh=LGjH+VaxkyRsmQ/os7WX5aNwBGmhH6HBNhqikwdceMM=;
 b=33b8wgskQBt3ZzGbeRbzLxtKAax+bkWySLpAMG4R44eStuzkCjtdwcSi2Xwcf8nNYvGetIncg
 4bsnHablbDDC8NMTCRGmWQO8UcGU8BkoraAFd4qw9AiKf8T3H1Q7YuZ
X-Developer-Key: i=christian.taedcke@weidmueller.com; a=ed25519;
 pk=fVCoBhFV3uMogA2nxIOU/rynNY+O2TDJgWvWjR06TrQ=
X-Endpoint-Received: by B4 Relay for
 christian.taedcke@weidmueller.com/20260702 with auth_id=847
X-Original-From: Christian Taedcke <christian.taedcke@weidmueller.com>
Reply-To: christian.taedcke@weidmueller.com

We observed a hard interrupt storm in the Cadence GEM (macb) driver on
a Xilinx ZynqMP based platform running a PREEMPT_RT kernel (6.6.142).

After several Ethernet link up/down transitions, the CPU that the MAC
IRQ is pinned to is pegged at 100% in the threaded MAC interrupt
handler and the kernel reports "sched: RT throttling activated",
killing the network interface. The MAC ISR keeps refiring with the
level-triggered TXUBR (TX used bit read) set, because the transmitter
is left pointing at a descriptor whose used bit is set. See the
individual commit messages for the full analysis.

Patch 1 fixes the root cause: gem_shuffle_tx_one_ring() resets tx_tail to
the ring base on link-up but never reprograms the hardware TBQP pointer.

Patch 2 fixes a second, independent bug: macb_interrupt() masks only
TCOMP (not TXUBR) when scheduling the TX NAPI, and macb_tx_poll()
re-enables only TCOMP. Because TXUBR is level-triggered, a persistent
used-descriptor condition keeps it asserted and re-fires immediately,
storming the MAC interrupt.

Both patches are required: on the affected platform the interrupt storm
still reproduces with patch 1 applied alone, so patch 2 is needed as
well to stop it.

The relevant code is essentially identical in mainline, so the bug is not
RT-specific. PREEMPT_RT merely turns the storm into a fatal failure via
RT throttling.

Tested on ZynqMP with PREEMPT_RT by repeatedly flapping the Ethernet
link. The interrupt storm and RT throttling no longer occur.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---
Christian Taedcke (2):
      net: macb: reprogram TBQP after shuffling the TX ring on link-up
      net: macb: mask TXUBR during TX NAPI poll to prevent IRQ storms

 drivers/net/ethernet/cadence/macb_main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260703-upstreaming-macb-irq-storm-ebd290b1e832

Best regards,
--  
Christian Taedcke <christian.taedcke@weidmueller.com>


