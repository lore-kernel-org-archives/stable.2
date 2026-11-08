Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794137682;
	b=HKuhZfiKlfOZtB/ymv+OdxXOAoLetUpwxDO+Z6KHw71YTBl/8vL6FOl1YM7lyOF/BsrS
	 ygKgUX8RNuYQfBZWbCs9NX8NF4owL4ooHUfQPk5/oeb2uOcxNLtteluAGSlaf3OSenMl8
	 iSl4PeYBArG3Mw6IZZ7Ic8+ENVOrnqxcrjvEaFFU8xisNvE/QY2Qrrl7SdZjuc8aF/way
	 /fbgn28x6ohZYxmzKSrZSbRtM7Reerm7n2iV9BETtYytgFk0ke73EN8bs0btpx+fK/1ri
	 U+bxZtsi4KiyOScnxbjZeWYsgFNSyltaw8lZWhQ3ZboLlYyuLDzce0JnFviuUECdxlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137682;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=n6ZvVlBF2yducGiUQxcQ21aStZz5H4n8TL/BwMSnxbs=;
	b=sUlP/hWqkSV07P1y5yBDUicCx92hm2UU6WCaS1OZgTnFv9HBkKdT0ivP71t193Fmgvrg
	 SN35lgtXHYfUgYVHTWAhNkvOXnVsyv17WriPtgYF5emKM8gO6hh1NQGRseTQBaZFu5Os/
	 ZWdC9T++3tIdrGNmwNsxwX8cb4dFTZ1TdNwqxI/pXBUQpjDH8DLKcsDabAshUbycYLUA8
	 faZmpTShivfPp72VQORpkYbGAZpLegRgA4SfWUKrdLTVwg5Bl7LyEZw2SSidzC8z8+w9m
	 CwyMAk6En9E5Gtev60rKPJHMDZe2Ar/ALF2YhUp0bvzcObnU8V+iqjONWSpvkbWkjDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ayki6tz/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCEB606A330;
	Sun,  8 Nov 2026 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ayki6tz/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794137682;
	b=oENjMEz0jBE8IIn3fVHK2Wmrrc/L7CAwEFn9uhkPTl764ePrlBWP/gWaty4iRD56BrUi
	 +mth/NbXv0EColM48bZAe1rjUV/GUtcWhXmF+LecD+NQO20rfHEx8yMlVxat7sxRf1oIg
	 42HQe2LcrBpwWRSCf2Io5dCkg8Vt4PExXfTKCi/jFQwqi3bWQlWtcErIES6e5N2WzdtAd
	 w1e3gnWojHG8GaAb+nqafRfolwKX5n0CUYyTD+XPcHNKopdswR/f9oHs8a+UjA1Qp3+a9
	 iMQeIITJyzzPQ9xFftlE2efE03K0ALn0nkJ2ulMKNlO4j+KwbnysbNv7UE67mLh42FQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794137682;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=n6ZvVlBF2yducGiUQxcQ21aStZz5H4n8TL/BwMSnxbs=;
	b=mq7csrPYEWErpZdxJbgGD521fO3y9O7oj/nmKfNSdhK0qG3l7CrsnX0qHXF4FIkmO+Sn
	 s9YGphKb0AHLR+QNRFmyc6dhTh5zQGDlze6a/FheMDEIHn9ncVCGMKfxL7lnGB8qE0QGb
	 zAY2Sccy0SRUKcGhc5t5JNNRnIMcT2dQ6hqzYbe3QYcuAZBk+N5OQw50rn9FvD8vwAf1r
	 W/Ec5wQEC/RFt23gc56t33hWxivlHX1YWd/py1pqveE9jH4Apu2Ahx7upW2mDQFbjQtNN
	 LqhF9CUoxj5AvEj9bnB4NZIGwg1K+SZdYd9ilEC59doRyqWn3CVtEemci7FsMaKa6pg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B65C61F008A2;
	Sun,  8 Nov 2026 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794137682;
	bh=n6ZvVlBF2yducGiUQxcQ21aStZz5H4n8TL/BwMSnxbs=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Ayki6tz/V1C/4mZyUj6PO8QMiICr3KbJiErTVdsp/VKD/phKYhI8EJp41MMjGpYBt
	 m7eXe3c50GVoF18CEQ9SBBjvvM1lD0KgwLQO4sjjy0PhIXzEYmN140TRJ49O/4kfYN
	 ZuWdkOpNQUuGzE+FgMhSTta3metrQmnD4beHFeZAtLBLqFJ5/DTu4PyUDzv5f6Xw7d
	 arDxip9U3rGPsfZcITeFJ+ecmD+BgcrQM04suxw9aN0sd4c38JqOJgFbBx/qI5wqu7
	 8DPSlDLjp1AtRKBB0aVrgDCqj5wZ7fOzNzPR4nl+5uWjiwyyOxa3ixueVeBllrDohw
	 STW9nrj4OvIiA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1376A47F0D;
	Sun,  8 Nov 2026 11:34:40 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Subject: [PATCH net v8 00/10] can: fix Rockchip TX stalls and bus-off
 restart/close races
Date: Sun, 08 Nov 2026 19:33:27 +0800
Message-Id: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
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
X-B4-Tracking: v=1; b=H4sIAAhe8GoC/5XPTU7DMBAF4KtUXmPkf8esuAdiEY/H1ECT1g4Rq
 MrdcYIEySp0OaPR995cScGcsJCHw5VkHFNJfVeH5u5A4Nh2L0hTqDMRTBjOuKS5hzc4pjOFtou
 BZixDmwcK731Bij6gdlpF7iOpxDljTJ8L/0Q6HMjzz7J8+FeEYYbns2MqQ5+/lhIjX47/lzdyy
 qkV0IKKTgqIj5fLPfSnJWcUa0ntSIIyCk30IbaBN0xuJHmLJKsUGXrFmWNCiY2k1pLekVSVahv
 lYrROabaR9C2SniW0VgrLpAW3kcxasjuSqRIGw3SsH3qDG8n+SZyZHcnOnQCC59xDo/SvNE3TN
 /Q6fS2YAgAA
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
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794137678; l=10370;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=AUqolhpdPrP0LIZPkeDY80MGWPP5QcafeJRXVEuQ/XQ=;
 b=505SD/n6kbLWmXeAEwN0jC2PWh6H8v6wHd8RKSyENZXH5ikmA7MhoG5aUi8uqhm8LdVSrgtnv
 /VX1efOSIgvDrRRxYD7/d1cWGULEe4pibRMDatKx9HYPVjdTr/ppYq6
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
completion to wake it.

While testing the echo-loss fix with fault injection, I discovered a
separate race between bus-off restart and device close.

Rockchip currently cancels restart_work in close_candev(), after freeing
the IRQ, disabling RX offload and stopping the controller. A concurrent
restart can re-enable the controller and interrupts after IRQ teardown,
and requeue timestamp work that accesses registers after runtime suspend
has disabled the controller clocks.

The CAN core skips scheduling or starting recovery when its
netif_running() check observes the interface down. A new
close_candev_cancel_restart_sync() helper lets Rockchip wait for any
restart already in progress before tearing down resources.
The final close_candev() call retains cancellation and echo cleanup.

Rockchip restart masks the device's interrupts and drains active IRQ
handlers without disabling the shared interrupt line. It also drains
timestamp work before reinitializing the controller and timecounter.
The Rockchip IRQ handler stays suspended until initialization is complete.
Timestamp locking prevents workers from rearming after deactivation and
keeps timestamp conversions consistent with timecounter updates.

The bus-off path drains TX submission and RX-side echo users before
publishing BUS_OFF. Consumed RX FIFO entries are dropped while TX is
disabled to prevent self-transmitted frames from reaching ordinary RX.
Startup serializes carrier restoration, IRQ resumption and queue wake
with a new bus-off. The series also fixes RX offload cleanup when
request_irq() fails during open.

The following issues remain outside this series:

- Races in the Rockchip bus error counter cache.
- Incomplete runtime PM clock cleanup during removal or failed registration.
- Missing explicit interrupt-mask write completion before free_irq() in
  the Rockchip close path.

When I have time, I will send separate patches to fix them one by one.

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

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: kernel@pengutronix.de
To: Vincent Mailhol <mailhol@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org

---
Cunhao Lu (10):
      can: rockchip_canfd: prevent TX stall on echo skb failure
      can: rockchip_canfd: serialize TX state and command writes
      can: rockchip_canfd: retry the outstanding TX buffer
      can: dev: check netif_running() before bus-off recovery
      can: dev: add close_candev_cancel_restart_sync()
      can: rockchip_canfd: cancel bus-off restart before closing the device
      can: rockchip_canfd: disable RX offload on open failure
      can: rockchip_canfd: serialize TX with bus-off and restart
      can: rockchip_canfd: prevent timestamp work from rearming after bus-off
      can: rockchip_canfd: serialize timecounter timestamp conversion

 Documentation/networking/can.rst                   | 10 +++-
 drivers/net/can/dev/dev.c                          | 17 ++++--
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 66 ++++++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-rx.c       | 29 +++++++---
 .../net/can/rockchip/rockchip_canfd-timestamp.c    | 43 ++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-tx.c       | 51 ++++++++++++++---
 drivers/net/can/rockchip/rockchip_canfd.h          | 11 +++-
 include/linux/can/dev.h                            | 17 ++++++
 8 files changed, 209 insertions(+), 35 deletions(-)
---
base-commit: 26e74534310157d284fe9f2518c1503e055b6210
change-id: 20261013-rockchip-canfd-restart-close-ebde5954f1bf

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


