Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795077592;
	b=EjN/kHm2pcm9V2db/Ch7yYQHTt5QF/8wavK/c5XZunw6t773Qp4F1o30OZFrjCm+9AAr
	 hw0IYKgK2Zm+jXUBZFZYbM5MHYE86X9yF1ySb804wY7Tvg9HY530eJA89eOykCfpwaAhF
	 y8MiTJ0rT1XJuC6/4pInoB2Hi7IZ990DsGn+fqGNmyPp/2nnIPX6ezvR0u92KQ50fMztH
	 eJ7BCm/3e6t5DOZYDS3hca5DT5EjdLUw/I6TYWPIjo5+Qiol53xBpQ4/plLPJGrCdx8gD
	 rTwvuEn32KVKt/Kj0g2Iip/47QNViw+pnSYGrYJRzktr/CwfqDvPPNP8/0TXCz4+NWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077592;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=3CETJMxEtQaqmQOMyC400VftcPjbQndNZKLyN1vrBv0=;
	b=SBpU8kTJVlAlobhQLFDVlmn7KDgHvY1g6fvYeznT6eUvaOf0agLhGphQCihqStjNlUgX
	 OMt6VM0cLc1d2/sry/shlaP3y96GjJAXZhnW5TCfwt8Bv7GzeJ2cYiRKKflMXnwJm9QAG
	 XU987phOyN8Z4VoxkBUEteH4jYAVdU1mKTBYs4QclsnzRS2WIOJ1rCn6XHpapj4cpJtgN
	 tnNNbSELileGYPSIb/hKNQLBOYKcMY4UoxPWPX9ZnZGYtrIdYoklJEahCEJ4J5kRGpTFZ
	 7tMrZcY3/JrXyWJPYtcCEzOw/kQRDaD3o2qj9DgF/iSNGA2ufwMx3qFV+Y9rABvGmHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kIFee/Dv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BBA60A263F;
	Thu, 19 Nov 2026 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIFee/Dv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795077591;
	b=KFfmeWcKDUdg+RY2ADX3mY/kolDMfe0HsejnQLRh3bL8IeuldrKSPyVr/R7fbPv8ICJT
	 VrfNickQGcRY/EgokETLm50hQ+w0NOnOWuhx4Ps754fZ+jvgCTM9pq0AoShHAeffqBNWH
	 XiaGhx0dAKKvBvo1FOsUF95LG8ZvdYKYGm1bfWLYFV57XdsFn5eL5Ql0bjg4dLCzlT0FI
	 ZzVMJjezwmTMMI7InzUVDqAoP7eMGLeDYqORXnbajykuaJJzPUzkBVZJBkDrpmcTlEGvK
	 UmrK2VVoKKI+Tp39ZPFGTtlfgRvGbuxlOQ8B4qsP1nLTaeWz9ZJvCldgPPVdD4rTveA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795077591;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=3CETJMxEtQaqmQOMyC400VftcPjbQndNZKLyN1vrBv0=;
	b=tbN8vpry0P+zXzscO+4c53VOTnX/s2Al15EOfYWHFubrEZd1YjVEM+lNbzmEoJARG2z4
	 cCZUrHb3IBJ+DbJ/NOM30+wR3bOnVT4qgStMpcxuhsDk4QDAEAnIYuaFrIzkjktNT3IwM
	 SkYvuYRq+IV4J5xr9thPY1KFrLXO6iWBicrTqZcCVqltBzxHh6KldCA4I8MvQu/yNlwmD
	 TwWBJg/7TyFTMuqDp2GRY2zwypDng+bf1AzG3w1dGufhze0f54DaEQZmDx+ASfEeHDGuI
	 ce4Qw+2c6yfsM7v5v2AAf/UeK0PE26HRp3zpGgfsNp4EsEEKt+FtvPEL4HHUIjoUwaQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E1F161F000C6;
	Thu, 19 Nov 2026 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795077591;
	bh=3CETJMxEtQaqmQOMyC400VftcPjbQndNZKLyN1vrBv0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=kIFee/Dvq9nYnzBzj1EuIxDpeJS1Gj5AXg2D1HnVLxxW5LXWJAYtSDL1bSUli9vp5
	 vbey2gk+238aIgWWcAY9YW49sMUGgpZ6m1+VCEYaq11J7/O1ICBxoh90h0Mxfp5oq3
	 /v5mCFRcx7i68IP89lnHwBk/M8uSim8bfZfkVAaWXDiE9nGIvVXBWaTqU3sK2MYk90
	 QwobwUn9lhZG/EXDUgp6LsbUGaEoy0ww/phmgynmom2pqL5Imghm8f1zc4TB2pzLmd
	 hKTa9ILzPMOTMqlOmlzHR3soKBYuph8Ps4TSnTfmfOvHBf0juvpcb8ZWMTDIC+tUfx
	 v1XSaGRNc9XJA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3FE9A4B1A2;
	Thu, 19 Nov 2026 08:39:49 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Subject: [PATCH net v10 00/10] can: fix Rockchip TX stalls and bus-off
 restart/close races
Date: Thu, 19 Nov 2026 16:39:41 +0800
Message-Id: <20261119-rockchip-canfd-restart-close-v10-0-df23913aa33a@qq.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM21/moC/5XSyU7EMAwG4FdBOROUfeHEeyAOieMwYWln0lKBR
 vPupOUw7anM0Zb1+bfkMxmwFhzI492ZVJzKUPquFZzd3xE4hO4VaUmtQQQThjMuae3hHQ7lSCF
 0OdGKwxjqSOGjH5BiTKi9VpnHTBpxrJjL9+I/kw5H8vLXHL7iG8I4w/PYoQxjX3+WFBNfhv+3b
 +KUUysggMpeCshPp9MD9J/LnkmsJbUjCcoouBxTDok7JjeSvEWSTcoMo+LMM6HERlJrSe9Iqkk
 tjfI5W68020j6FknPElorhWXSgt9IZi3ZHck0CZNhOrcLo8GNZK8SZ2ZHsnMmgBQ5j+CU3khuL
 bkdyTVJog1C5uQxbDP5lcT5juSbZIySWTqhY7h+weVy+QW+x8xmLQMAAA==
X-Change-ID: 20261013-rockchip-canfd-restart-close-ebde5954f1bf
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795077587; l=10566;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=lTsdnwCHqwAoxAmeYNGgy9yRcSKjH5pM5w7N5WL7PJo=;
 b=FuX8UwsdDtydpORReZh0QXGB9ddEG1/a9JvLNw/bdZ3NsKpgR5tZWRJBa+9/RIn4BvGs64NAJ
 OkcXOh01kFZBrTyw4ZPRoebf0ITttp1F2TEFesMSIujQGkDj/KwJzgG
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

On a production robot using a LubanCat-5IO with an RK3588, the CAN TX
queue remained stopped while RX continued, and subsequent sends returned
ENOBUFS. The interface still reported ERROR-ACTIVE, with neither a
hardware bus-off condition nor a pending TX request.

During CAN traffic, the driver also repeatedly reported an inconsistent
TX echo state:

  rockchip_canfd fea60000.can can0: rkcanfd_tx_tail_is_eff:
  echo_skb[0]=NULL tx_head=0x00060f7d tx_tail=0x00060f7c

The Rockchip CAN-FD driver completes transmissions by matching
self-received frames with entries in the echo skb ring. A race between its
transmit and completion paths can expose a partially updated echo entry,
dereference an skb queued for NAPI, or stop the TX queue without a later
completion to wake it. If the driver cannot install an echo skb, it now
drops the frame before issuing a TX request. Retries use the outstanding
frame's slot and block new TX until both request bits clear, even if the
original echo arrives first.

While testing the echo-loss fix with fault injection, I discovered a
separate race between bus-off restart and device close.

Rockchip currently cancels restart_work in close_candev(), after freeing
the IRQ, disabling RX offload and stopping the controller. A concurrent
restart can re-enable the controller and interrupts after IRQ teardown,
and requeue timestamp work that accesses registers after runtime suspend
has disabled the controller clocks.

The CAN core skips scheduling or starting recovery when its
netif_running() check observes the interface down. These checks apply to
CAN core software recovery and do not serialize it with device close.
Rockchip waits for active core restart work before freeing the IRQ and
stopping the controller. The final close_candev() call still cancels
restart work and flushes the echo ring.

Rockchip restart masks the device's interrupts and drains active IRQ
handlers without disabling the shared interrupt line. It also drains
timestamp work before reinitializing the controller and timecounter.
The reset path restores and flushes the interrupt mask immediately after
reset deassertion. The Rockchip IRQ handler stays suspended until
initialization is complete.

Disabling timestamp work prevents workers from rearming after bus-off.
Timestamp locking keeps timestamp conversions consistent with timecounter
updates.

The bus-off path drains TX submission and RX-side echo users before
publishing BUS_OFF. Consumed RX FIFO entries are dropped while TX is
disabled to prevent self-transmitted frames from reaching ordinary RX.
Startup serializes carrier restoration, IRQ resumption and queue wake
with a new bus-off. The series also fixes RX offload cleanup when
request_irq() fails during open.

Hardware testing used a LubanCat-5IO running Linux 6.18 PREEMPT and
PREEMPT_RT kernels with v7 and the applicable prerequisites backported.
Tests on each kernel covered 600 seconds of bidirectional classic CAN
traffic, plus CAN FD and CAN FD+BRS. Local echo and both software and
hardware TX timestamps were also verified.

All 1,000 socket-close iterations passed. Instrumentation captured
1,150 cases where the last TX skb of a closed socket was destroyed,
all after releasing tx_lock and with IRQs enabled.

All 200 injected echo clone failures dropped the frame without
submitting TX, advancing tx_head or adding BQL bytes; subsequent sends
succeeded after removing the injection. BUSY, occupied slots, missing
echo skbs and invalid indices were also tested, along with automatic and
manual recovery from hardware bus-off triggered by bitrate mismatches.
All passed.

Test-only instrumentation captured 20 restart/close and 20 close/FIFO
interleavings. No timestamp worker ran during about 300 seconds after
close, and no WARN/Oops, deadlocks or persistent TX stalls were observed
during CAN testing.

Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v10:
- Move the retry fix (v9 03) after TX/IRQ synchronization and block new
  submissions after a retry until both TX request bits clear.
- Limit the recovery documentation to CAN core software recovery and
  clarify that running checks do not serialize recovery with shutdown.
- Link to v9:
  https://patch.msgid.link/20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3@qq.com

Changes in v9:
- Use workqueue disable/enable operations to prevent timestamp work from
  rearming after bus-off, balancing repeated stop calls.
- Move worker requeueing and initial scheduling outside timestamp_lock.
- Restore and flush device interrupt masking immediately after hardware
  reset, before the remaining controller configuration.
- Count consumed RX FIFO entries discarded while TX is disabled.
- Link to v8:
  https://patch.msgid.link/20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com

Changes in v8:
- Merge the previously submitted Rockchip TX fixes, with TX serialization
  before the retry fix.
- Move retained-skb handling and the missing-echo guard into the echo
  failure fix, using the original skb as the frame-data source.
- Establish the TX/RX critical sections and caller-held helper locking in
  the TX serialization patch, covering queue updates, TX diagnostics and
  RX pending checks, with assertions for command writes.
- Reuse those critical sections in the bus-off/restart lifecycle patch.
- Rebase onto the latest testing branch in the mkl/linux-can-next repository.
- Link to the Rockchip TX fixes:
  https://lore.kernel.org/linux-can/tencent_E25C9BE6689264E4138A464803B810FDFD09@qq.com
- Link to v7:
  https://patch.msgid.link/20261106-rockchip-canfd-restart-close-v7-0-accdb11bc845@qq.com

Changes in v7:
- Clarify that running checks do not serialize recovery with close, and
  keep the restart-ms example tied to configuration while down.
- Introduce Rockchip restart/IRQ synchronization and TX protection
  together, keeping close cancellation and open failure cleanup in
  separate patches.
- Build on the CAN skb and Rockchip TX fixes, reusing the TX lock and
  adapting failure cleanup to the updated skb ownership contract.
- Link to v6:
  https://patch.msgid.link/20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e@qq.com

Changes in v6:
- Update the can_bus_off() comment and document the running-interface
  requirement for automatic recovery.
- Explain Rockchip's use of the cancellation helper.
- Release the original TX skb after unlocking.
- Abort TX submission if echo preparation fails.
- Link to v5:
  https://patch.msgid.link/20261015-rockchip-canfd-restart-close-v5-0-ae77327037c9@qq.com

Changes in v5:
- Drop consumed RX FIFO entries under tx_lock when TX is disabled
  instead of only skipping echo filtering.
- Link to v4:
  https://patch.msgid.link/20261015-rockchip-canfd-restart-close-v4-0-ad149ff79450@qq.com

Changes in v4:
- Serialize timecounter_cyc2time() with the worker's timecounter_read()
  and startup's timecounter_init() using timestamp_lock.
- Update rkcanfd_skb_set_timestamp() to take a non-const private pointer
  and document the expanded scope of timestamp_lock.
- Link to v3:
  https://patch.msgid.link/20261014-rockchip-canfd-restart-close-v3-0-f0eb41090242@qq.com

Changes in v3:
- Replace disable_irq()/enable_irq() in Rockchip restart with device
  interrupt masking, mask readback, irq_suspended and synchronize_irq().
- Use release/acquire ordering when resuming the IRQ handler.
- Initialize timestamp delayed work once at probe and synchronously
  cancel it before restart reinitializes the timecounter.
- Balance RX offload enablement when request_irq() fails during open.
- Prevent timestamp work from reading the counter or rearming after
  deactivation, with cancellation outside the lock.
- Drain TX submission and RX-side echo users before publishing BUS_OFF,
  protecting the core's pre-restart echo flush.
- Serialize carrier restoration, IRQ enablement and queue wake with a new
  bus-off; suspend shared IRQ handling during open until startup finishes.
- Link to v2:
  https://lore.kernel.org/linux-can/tencent_82C93561D200C84C24608C80049C23EEF80A@qq.com/

Changes in v2:
- Split the series into the common checks, the cancellation helper, and
  its use in Rockchip.
- Check netif_running() after the do_set_mode capability check and before
  the restart notification, echo cleanup, and carrier update.
- Only queue automatic recovery for a running interface; keep reporting
  bus-off and make the log message match the scheduling decision.
- Add close_candev_cancel_restart_sync() in linux/can/dev.h and use it in
  close_candev() without changing the existing cleanup order.
- Replace the Rockchip mutex and closing flag with an early call to the
  helper. Drop the extra close-path IRQ synchronization and mask readback.
- Retain IRQ exclusion around hardware reinitialization in the restart
  callback.
- Link to v1:
  https://lore.kernel.org/linux-can/tencent_5802EE88434010229EDF7A53084D994C6106@qq.com/

---
Cunhao Lu (10):
      can: rockchip_canfd: prevent TX stall on echo skb failure
      can: rockchip_canfd: serialize TX state and command writes
      can: dev: check netif_running() before bus-off recovery
      can: dev: add close_candev_cancel_restart_sync()
      can: rockchip_canfd: cancel bus-off restart before closing the device
      can: rockchip_canfd: disable RX offload on open failure
      can: rockchip_canfd: serialize TX with bus-off and restart
      can: rockchip_canfd: retry the outstanding TX buffer
      can: rockchip_canfd: prevent timestamp work from rearming after bus-off
      can: rockchip_canfd: serialize timecounter timestamp conversion

 Documentation/networking/can.rst                   |   9 +-
 drivers/net/can/dev/dev.c                          |  17 ++-
 drivers/net/can/rockchip/rockchip_canfd-core.c     |  79 ++++++++++++-
 drivers/net/can/rockchip/rockchip_canfd-rx.c       |  30 +++--
 .../net/can/rockchip/rockchip_canfd-timestamp.c    |  41 ++++++-
 drivers/net/can/rockchip/rockchip_canfd-tx.c       | 124 +++++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd.h          |  19 +++-
 include/linux/can/dev.h                            |  17 +++
 8 files changed, 303 insertions(+), 33 deletions(-)
---
base-commit: 48bcad36a131fa67a29a5ac430aceedf2d6f3d0f
change-id: 20261013-rockchip-canfd-restart-close-ebde5954f1bf

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


