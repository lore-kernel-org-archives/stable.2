Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675031;
	b=M7heswNctb21cv9GjEktyl9vR9G/4kYIfCooIrq6mLlG31JZIEfxnQtZ+5XsCagqjVXx
	 yj6XiWZncTOzmcvQhXtW9MI7MXgJgaEGC12TUxgjWcN6vxqq1rUFqCy/TWLQhCMGhX6j/
	 GBYfH/h9g5QoAcQwSZlo9Dq/hrMYabUJidH80uFX2RJNFlXLvifNrY0d02FfIXA+uQXv8
	 v3IbbDVNJXP5avJvl+F8jK0jCgyrmKOFHMZuFrUxJxT0ygI+pwjnLRFBaytAn3uwcIh63
	 JvlMiwY9eyxs1OvwxmlxCMM//M5KxYrDvSTWJHsq+XhjlDdtnNdlHFIp25Rq93u9RZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675031;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=IGDhuoZYCkO0y7/Dp5n43qYEMJGCg442coo5FW74yLg=;
	b=j5svCpk3EUE3eD/UrNaFQ3cPm0zlMjofUa9LWhfTm2s6wuEyBiDOGLbNeH2yhzDSsSx1
	 6i+PkFHLN6SbrOMzF3wgbMP12H01YxnnQNTMEOkL+BaNNoroOAy9GhgJs+JNVNpKqKYkB
	 +KlqerB9kBMY8ntLom0eOPYXVMUiZQNN56nFryZzrCiI0kyuaLArajWktQTZpK3WRg8dj
	 2cz59uwvTHbQcieP2hCxRXn9kqUOdK3Ahhixtp1VBvSb5txMrUjEhyBe9CJCW/LI3HWuP
	 yhh9qIYCeEBOUbzwYQxwxh200oVL461V52w3L+siQTKlnjASpMUvcddQLaJ5VEZc2Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOi0Xk7T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82531606A31C;
	Thu, 26 Nov 2026 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOi0Xk7T
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795675031;
	b=SLX1Ihet0kkRpFJgYtVaI8hKr1V7yCtZgJILUMFpqQoaf1uPMnsCMomwjnVZvZs9QobO
	 TqpOyMviPRu6uQTx66eNOWFvKd3a7krA4Op8fD8byyAOvTynFs9fxGtJc0UHyVt7OwdAx
	 dZxdyNiO2aP9UZY+jZFUhrLNLRA2UdQWnqxmQUfUrRylHBTuf0JepeqqE1n/GuILsE3zJ
	 FpBBRI7vCkREl8y0XAGKQjvliN5N+cPmaMuM2pBf9L7PU682yjs+2LZukQbL0Ik3UNeFs
	 jwCsJ/BZoUDWqaAoesfKDpgsWBpi847z10/yP7/fRQUAW7IzEjs0wYFlIP5LYx40lig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675031;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=IGDhuoZYCkO0y7/Dp5n43qYEMJGCg442coo5FW74yLg=;
	b=oXFaT27SI8Q5IU1uCF9984vFyOffGZsZhoeZcayVBzQyxHUTNethseeHJw5k52MFpd1w
	 wGbMpwTJAMUUMC8n9oupOQ2YkemR5uivDtUpfchl74vEwoPUfTyQXcUVaG3QK9sj+mr1r
	 uDnPGpFvyQC6G3+D10bBjUmvJ/Tuubj2/MKQQsSlAQ0Pc80T5X4672mXp4e60mjARwWar
	 GpFoNAiJKDPJpaHGbtBSM1qqNQwZg3iJniSITq7Y1OyqCkxVz1ENSnBqMd1fTW/6juIaD
	 g1QK9H4kLhKm95KiLYvBZY8Gk5bzYeFxttKEGd02M0YoN1eeJvCEzIzpNvt5AZIAY+Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2E0621F000C6;
	Thu, 26 Nov 2026 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675031;
	bh=IGDhuoZYCkO0y7/Dp5n43qYEMJGCg442coo5FW74yLg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=hOi0Xk7TdAORfivXxt6CRoNGv0Rgy4Zjn5PtgMHcRYO0Sjah3a82pH+9czC6aVlbI
	 Urng045hltr4dEeSjJYFVFCkIM1NDc9+qpWDGGnXu8ItysIhHhih9Iihs8lFMjn9zs
	 ve3x0pEAtXvEcLphXqCVqAtuSqyDq0TVMfGRYB4av5H0Yu/WXXB5IIGWZObOgIk8Cv
	 2BZSsoPU7cO+hxOg+m3SO2vkgpkoCsyVWZGOO9gLY5oJv61wlFGbcmPvFmh/z1nVxG
	 yMCRWJ2WL89jhSfEudb2CtQMS62qE0n5uEaMPa12xGczi6CVbF9nHbrSDhOGM7fcOT
	 fofdDkVp4vNSg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B315E4D267;
	Thu, 26 Nov 2026 06:37:06 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Subject: [PATCH v9 0/6] usb: gadget: gadgetfs: fix ep0 request lifetime and
 control races
Date: Thu, 26 Nov 2026 14:37:03 +0800
Message-Id: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAI/TB2sC/1WNyw6CMBREf4XctTWlUF4r/8OwqOW2XCOUtEg0h
 H+XohuT2Zxk5swKAT1hgCZZweNCgdy4Q31KQPdqtMio2xkEF0WaioJZ1VmcTWA4cWa0EFJmXKp
 Swj6ZPBp6Hbpr++XwvN1Rz9ERGz2F2fn38bdUsfdTp/xfvVQxnFWm5nmWyzI3eLGDosdZuwHab
 ds+1xKosL0AAAA=
X-Change-ID: 20261126-gadgetfs-ep0-fc2255305a75
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795675024; l=3893;
 i=kayano050408@gmail.com; s=20261126; h=from:subject:message-id;
 bh=fvfwlA9wimqwVKnxLxvsfDJkX3M7MoycSS4Qn4OBS1Q=;
 b=bOdNzpvTZmi8LCOaQlCH7+dUQtZxXvvh+W5jRQ9aPcskDohwk8u7hmklZFJyCd5b3DMxArj+F
 O67PO+YlGOwDubELwbd44C4W50HkfAi2dEKj/R1/gnWwvbeovTFJmzj
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=40M3hugIx++9w3nkAoFXGcN/vLWsPMGDYdbduV+lUlI=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/20261126 with
 auth_id=1648
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com

This series fixes the ep0 request lifetime on unbind, control buffer and
setup_abort state races, lost completed control-OUT transfers, event
counter underflow, and the const cast in gadgetfs_setup().

1/6 tracks active ep0 requests and waits for completion after
    usb_ep_dequeue() in gadgetfs_unbind() before freeing dev->req, while
    keeping descriptor buffers out of kfree().
2/6 copies delegated control-IN payloads into a private memdup_user()
    buffer before touching dev->req and drops responses superseded
    during the unlocked copy.
3/6 fixes setup_abort tracking across ep0_poll(), gadgetfs_disconnect(),
    and early returns or in-kernel requests in gadgetfs_setup().
4/6 preserves completed control-OUT payloads until ep0_read() collects
    them, leaving ep0 unqueued so the controller NAKs newly arriving
    control transfers in the meantime and replaying the deferred setup
    afterwards.
5/6 dequeues ep0 events before dropping dev->lock for copy_to_user() to
    prevent dev->ev_next underflow.
6/6 removes the const cast on ctrl->wLength in gadgetfs_setup().

The setup() callback runs in atomic context and may not sleep, so a
mutex cannot serialize it against ep0_read() and ep0_write(); shared ep0
state remains protected by dev->lock.

---
Changes in v9:
- Split the first two patches into single-purpose patches (1/6 through
  4/6) so each problem is addressed separately.
- Drop the rejected usb_ep_dequeue() fallback (ep0_req_free) in 1/6.
- Allocate a private buffer with memdup_user() for control-IN writes in
  2/6 instead of copying through a stack buffer, and clarify that the
  generation check narrows rather than eliminates the unlocked window.
- Preserve properly completed control-OUT transfers in 4/6 by deferring
  any subsequent SETUP (leaving ep0 without a queued request so the UDC
  NAKs it) until userspace reads the completed OUT payload, then replay
  the deferred SETUP.
- Drop the STATE_DEV_UNBOUND event-read changes from this series.  For
  context on how unbind can happen before close(ep0): unloading the UDC
  driver (usb_del_gadget_udc()) or writing to
  /sys/bus/gadget/drivers/gadgetfs/unbind runs gadgetfs_unbind() while
  userspace still holds the open ep0 descriptor, where a queued
  GADGETFS_SETUP event could otherwise put dev->state back into
  STATE_DEV_SETUP on the next read().  If that case is worth guarding
  against, a small follow-up patch can clear dev->ev_next and wake
  dev->wait in gadgetfs_unbind() and check STATE_DEV_UNBOUND before
  delivering events in ep0_read().
- Use a local events[N_EVENT] array in 5/6 instead of sharing a buffer
  with control-OUT reads.
- Link to v8: https://patch.msgid.link/20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com

To: Neill Kapron <nkapron@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>

---
Jing Lin (6):
      usb: gadget: gadgetfs: fix ep0 request lifetime on unbind
      usb: gadget: gadgetfs: isolate ep0_write() buffer and reduce setup race
      usb: gadget: gadgetfs: fix ep0 setup_abort tracking and reporting
      usb: gadget: gadgetfs: NAK new setups until control-OUT data is read
      usb: gadget: gadgetfs: prevent ep0 event counter underflow
      usb: gadget: gadgetfs: avoid writing through the const setup pointer

 drivers/usb/gadget/legacy/inode.c | 514 +++++++++++++++++++++++++++-----------
 1 file changed, 366 insertions(+), 148 deletions(-)
---
base-commit: 90d6263e867be7089b3d3323bef8d2accd327c77
change-id: 20261126-gadgetfs-ep0-fc2255305a75

Best regards,
--  
Jing Lin <kayano050408@gmail.com>


