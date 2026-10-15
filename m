Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A63509F18;
	Thu, 15 Oct 2026 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057564; cv=none; b=mgqN50jfgI0k3HFJPVBr+wHssIm6Y/5mYklfJULipXZryez/dzCbni+gRAbMVTj1SpaaUJiHgiCGSFNkhZ/xfmwpHP5H1MJxFPxV5fdftKjz9HtmqZZ7gXpbj+YaL0S153OEfc7vaKTJdlw3lMt+j/5yFCzLzTyxr8dq1U9cOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057564; c=relaxed/simple;
	bh=SaE49nUJpdyW2sxts16Btp7urzlfh/U7nHcUO3p/JXk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UYjxPhFTbRTMpcXOayv9iF28jQciCu1P10rNgAmDaE1k07lUmlvPr8Ypb6O6CKdSY5P8+dOZ/8EkTMouScCAPBWMhVbxDyyT1S167CwfijHLa4Q0uaDTkFyLKqyTMFgdHc3PqJ+F3iP/bRrz9amlkfpwo5REti/bOVIpZAqNGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Or8i7eFO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Or8i7eFO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8C1FC2BCF5;
	Thu, 15 Oct 2026 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792057563;
	bh=SaE49nUJpdyW2sxts16Btp7urzlfh/U7nHcUO3p/JXk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Or8i7eFODOTzKvnqux0DqDEvivmTzZxF7hvY7hnZ10vSidsrseZ+ectXSuoz8rh/C
	 MP6OEYJz82tPQGrTPAs8hKYYDFuxuYwxlR9YIJkageXfB5DjyS1gmvCGmsCnP03g24
	 brhai1H8OVgcC8j6HACHExs+xcIouZqSc/Obk3IKKEsdPntMIEmMntCx3j4tqtZtYw
	 P2TNb39FHGn57S0VYhoW8CI6wN6uW6SW1G89e1YRPBC5r7t0Pd6DsRZZsNKAf/98St
	 jD8YRh+voqTmIFqGF/3++3zGPxl+DTdFEJ4w+jbd2qV9F9HQbEU3t40AIT2a8Tzq+V
	 ur17FXsu8Hrfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958CDCC6B34;
	Thu, 15 Oct 2026 09:46:03 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Subject: [PATCH net v5 0/6] can: fix bus-off restart and device close races
Date: Thu, 15 Oct 2026 17:45:01 +0800
Message-Id: <20261015-rockchip-canfd-restart-close-v5-0-ae77327037c9@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2g0GoC/5XOS04DMRAE0KtEXtPIXxKz4h6IxbjdzZjPOLHNC
 BTN3XEGCSWrwLJapVd9FJVKoiruN0dRaE415akHd7MROA7TM0GKPQst9Z2SykDJ+Ipj2gMOE0c
 oVNtQGuBbrgQUIjnvLKvAohP7Qpw+V/5RTNTE08+xfoQXwnaCT7Ux1ZbL1/rErNby3/ZmBQq2G
 ge07I1GfjgcbjG/rzuzPpfsFUmDBNxxiDxEtZPmQjL/kUyXWFKwSnqprb6Q7Lnkrki2S/0b65m
 33jr5Ky3L8g1uJDbVugEAAA==
X-Change-ID: 20261013-rockchip-canfd-restart-close-ebde5954f1bf
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792057562; l=7232;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=SaE49nUJpdyW2sxts16Btp7urzlfh/U7nHcUO3p/JXk=;
 b=QETCn/MIXGzbMnlWURSFolwVCVhnD284ffEPu2Uaes5BNNT1XuOsddwiBtXd1+UItE9iGHu/X
 T9xQC9GKcu8BcfdN/7uhLIvQNui/dwms/I9qdDGdbvJyTWo2s8FjKk7
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

This work started from a real failure on a production robot using a
LubanCat-5IO with an RK3588. RX continued, but the TX queue remained
stopped and subsequent sends returned ENOBUFS. The interface still
reported ERROR-ACTIVE, and the hardware indicated neither a bus-off
condition nor a pending TX request.

While testing the echo-loss fix with fault injection, I discovered a
separate race between bus-off restart and device close. This series fixes
that race; the fix for the original TX stall will follow separately.

Rockchip currently cancels restart_work in close_candev(), after freeing
the IRQ, disabling RX offload and stopping the controller. A concurrent
restart can re-enable the controller and interrupts after IRQ teardown,
and requeue timestamp work that accesses registers after runtime suspend
has disabled the controller clocks.

The CAN core checks netif_running() before scheduling or starting
recovery. A new close_candev_cancel_restart_sync() helper lets Rockchip
wait for any restart already in progress before tearing down resources.
The final close_candev() call retains cancellation and echo cleanup.

Rockchip restart masks the device's interrupts and drains active IRQ
handlers without disabling the shared interrupt line. It also drains
timestamp work before reinitializing the controller and timecounter.
Shared IRQ handling stays suspended until initialization is complete.
Timestamp locking prevents workers from rearming after deactivation and
keeps timestamp conversions consistent with timecounter updates.

The bus-off path drains TX submission and RX-side echo users before
publishing BUS_OFF, protecting the CAN core's echo flush during manual
recovery. Consumed RX FIFO entries are dropped while TX is disabled to
prevent self-transmitted frames from reaching ordinary RX. Startup
serializes carrier restoration, IRQ resumption and queue wake with a new
bus-off. The series also fixes RX offload cleanup when request_irq() fails
during open.

The following issues were also identified during this work:

- Races in the Rockchip bus error counter cache.
- Incomplete runtime PM clock cleanup in Rockchip during removal or
  failed registration.

These two issues are outside this series. When I have time,
I will send separate patches to fix them one by one.

Hardware testing used a LubanCat-5IO running a Linux 6.18 PREEMPT_RT
kernel with this series backported. Tests covered 2,700 ranging
request/response exchanges and 630 seconds of continuous traffic,
including three naturally scheduled timestamp worker runs. RX, TX echo
and TX completion hardware timestamps were present throughout, with no
backward or abnormal jumps.

Test-only instrumentation captured 20 close/IRQ interleavings, including
15 with multiple FIFO entries. In every case, consumed self-transmitted
frames were dropped after TX was disabled, the FIFO was drained, and
traffic resumed after reopening.

All 100 classic CAN loopback tests, 20 automatic and 20 manual restarts
using synthetic bus-off injection, and 20 down/up cycles passed. No
timestamp worker ran during about 300 seconds after close, and no
deadlocks or WARN/Oops were observed.

---
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

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
To: "David S. Miller" <davem@davemloft.net>
To: Wolfgang Grandegger <wg@grandegger.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
To: kernel@pengutronix.de
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org

---
Cunhao Lu (6):
      can: dev: prevent bus-off recovery when the interface is not running
      can: dev: add close_candev_cancel_restart_sync()
      can: rockchip_canfd: cancel bus-off restart before closing the device
      can: rockchip_canfd: prevent timestamp work from rearming after bus-off
      can: rockchip_canfd: serialize TX with bus-off and restart
      can: rockchip_canfd: serialize timecounter timestamp conversion

 drivers/net/can/dev/dev.c                          | 12 ++--
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 67 ++++++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-rx.c       | 26 ++++++---
 .../net/can/rockchip/rockchip_canfd-timestamp.c    | 43 ++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-tx.c       | 16 +++++-
 drivers/net/can/rockchip/rockchip_canfd.h          | 11 +++-
 include/linux/can/dev.h                            | 12 ++++
 7 files changed, 162 insertions(+), 25 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261013-rockchip-canfd-restart-close-ebde5954f1bf

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


