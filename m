Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A94E50B4;
	Wed, 14 Oct 2026 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984257; cv=none; b=NW3/mMJvBaB2OQ9he2C8qD+WX3OWhj5UbiKudXYNf9+ePHp+cvoWmFW+IcwRhGU4xelp/MasfsEbTDGcAv6NAwDO9SonKf0aBCDkBa/JdQng+lhzxkhtvcK7Qsz/kpANwmrBoq+EF35DApuBfP/Lzlt6EBJmBags6EDuliFTRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984257; c=relaxed/simple;
	bh=IfFy4q9JJ1/mn/rqxMosvFbxLwm0Xf9tXSOMeY0lmB8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tQGI72Ck9fIJ8G7CTT0NFtUVloHYj/9EF+cGjrEKOpptpHBT/B7AwZe2A4KjNW8MmOibLvs0DLYo9ngq0b1vuqAy342TORKHcKTwKleyNfS/ZVITeicccwDr+JfTEiYGQSDRoAmTbtISM/kUSOU7dW1lfD7k/9ZnQtbv+eExx/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZmrHySS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZmrHySS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C206C2BCC7;
	Wed, 14 Oct 2026 13:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791984257;
	bh=IfFy4q9JJ1/mn/rqxMosvFbxLwm0Xf9tXSOMeY0lmB8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mZmrHySSWdflbLTlfwOeeqe05YpGiYtVaM3djx+0I9lyQCDSDEydh0jj8t0rVek0a
	 Tfx8Unc+XqN0tbaoYw6KW1XNLg2UoStfcLMeWG14Uy/trqhWGgNwKg1Feo/nJ2YLkd
	 ovE5wutZ51qUvm8zvjgqf9IPYhhBMS0VMU4aC63wwT45lBO5X17Vd5mKeLvC7DXlRT
	 id37NWRMdROew3QYSU4xE02eF7IuTaQ3sITQ4j5iIDmeeWjm5qJ0hBDLKQy7hNLjBv
	 G0eE6eFwZtpyvxTq9PHL7xjVZF2Ie2buapygAj+00XsUzMCG5+GwKkn0IlrmSCPOde
	 QBGW1jVCg4h+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214AECC6B24;
	Wed, 14 Oct 2026 13:24:17 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Subject: [PATCH net v3 0/5] can: fix bus-off restart and device close races
Date: Wed, 14 Oct 2026 21:24:02 +0800
Message-Id: <20261014-rockchip-canfd-restart-close-v3-0-f0eb41090242@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHKCz2oC/43OTQ6CMBAF4KuQrh1DCyi48h7GRZlOpf600FaiI
 dxdwMS40+WbvHxvBhbIGwpslwzMU2+CcXYK2Sph2Eh7IjBqykykYsNTnoF3eMHGtIDSagWeQpQ
 +Al5dIKBaUVEVuea1ZhPRetLmsfAHZimy4/sY7vWZMM7wXGtMiM4/lyd6vpT/2+s5cNgKlJjrK
 hOo9123RndbdnrxLeU/JAEpYKlrpaXiZZp9pHEcX2XQ5xMmAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791984254; l=7084;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=IfFy4q9JJ1/mn/rqxMosvFbxLwm0Xf9tXSOMeY0lmB8=;
 b=OAQERfZ60OSzf1T+63YlCkeNq8zfarSwtyc9ZEcMkJJjnEnsGrE2osBSl62M+oVM+yjz3A0XU
 aK+xB9U1fKXAobvkBJdVWgKcI7wgWpO1XPH9AJXrHtCJCOH2jnzj9kx
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

When automatic bus-off recovery is enabled, bringing the interface down
can race with a pending or running restart. The Rockchip driver currently
relies on close_candev() to cancel restart_work, but calls it only after
freeing the IRQ, disabling RX offload, and stopping the controller. A
restart in that interval can re-enable the controller and its interrupts
after IRQ teardown, and requeue timestamp work after it has been stopped.
That work can subsequently access registers after runtime suspend
disables the controller clocks.

The networking core clears the running flag before calling ndo_stop().
This series uses that flag to avoid scheduling or starting bus-off
recovery once the interface is observed to be no longer running. It also
adds close_candev_cancel_restart_sync() so drivers can wait for recovery
separately from the echo cleanup in close_candev(). Rockchip calls this
helper at the start of its close path.

The running-state checks do not replace synchronization with a restart
that has already passed the check. Rockchip waits for that work before
tearing down its resources, and keeps close_candev() at the end for the
final cancellation and echo cleanup.

During restart, Rockchip masks only its own interrupt sources and reads
back the mask. A software flag prevents a shared IRQ invocation from
accessing the controller while synchronize_irq() drains handlers that
have already entered. The shared interrupt line remains enabled. The
restart path also synchronously drains timestamp work before rebuilding
the timecounter, and publishes the initialized state before allowing IRQ
handling again.

Timestamp delayed work is initialized once at probe. The open error path
also disables RX offload if request_irq() fails.

Stopping timestamp work now prevents a running worker from rearming
itself after bus-off. A lock serializes deactivation with the worker's
active check, counter read and self-requeue. Both asynchronous and
synchronous cancellation remain outside the lock.

The bus-off path now drains TX submission and RX-side echo users before
publishing BUS_OFF. This also protects manual recovery: the CAN core
flushes echo SKBs before calling the driver's restart callback. A private
TX lock and enabled flag cover submission, completion, retry and queue
wake, keeping these paths out of the echo ring while recovery owns it.

After draining the old IRQ and reinitializing the controller, startup
restores carrier, resumes IRQ handling and wakes the queue under the TX
lock. This covers manual recovery racing with the old bus-off IRQ's
carrier update and prevents startup from overriding a new bus-off. Open
also suspends shared IRQ handling until initialization is complete.

I tested v3 on hardware with 180 real ranging request/response exchanges
and 20 CAN interface down/up cycles. These checks passed, with transmit
and receive working after every reopen.

The recovery and race test campaign also passed all 400 synthetic bus-off
iterations and 10 cleanup tests after actual request_irq() failures.
Tracing captured 5 overlap windows involving old IRQ handlers/timestamp
work and 2 windows where recovery overlapped with device close.

---
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
Cunhao Lu (5):
      can: dev: prevent bus-off recovery when the interface is not running
      can: dev: add close_candev_cancel_restart_sync()
      can: rockchip_canfd: cancel bus-off restart before closing the device
      can: rockchip_canfd: prevent timestamp work from rearming after bus-off
      can: rockchip_canfd: serialize TX with bus-off and restart

 drivers/net/can/dev/dev.c                          | 12 ++--
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 67 ++++++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-rx.c       | 22 ++++---
 .../net/can/rockchip/rockchip_canfd-timestamp.c    | 38 ++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-tx.c       | 16 +++++-
 drivers/net/can/rockchip/rockchip_canfd.h          |  9 +++
 include/linux/can/dev.h                            | 12 ++++
 7 files changed, 152 insertions(+), 24 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261013-rockchip-canfd-restart-close-ebde5954f1bf

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


