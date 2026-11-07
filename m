Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794055576;
	b=KADI8vpYoGLv+Qr2bzUfTG/z92jTkXQadBIZNHbVTUCz2DEM/rHc1XKg7TvHhKHZqvSv
	 9SdiJ3O36mbGAzhDu4BBzfoZSPuNOFke4l3JqQIwYG+dI0TJc+X6rfkhF4AY9wZdj3CIa
	 iEU/suglnlvR9U1H7cbl/kUspy1L8TYCp6r0xaP5eKtefAQ1jYBL+6Y4c/taHMCfhvsxJ
	 AYM55dCMB6J1no8xToBskVMYmnM18zK2XQ7npwBsPle/bYy/JGArIQTGuOwHSm88lx0g/
	 zbKvs5z7TPbbTdzNHJVaybb3Pp70rEkPzdl9f2KVap3p2R5IoG7QgObQOT5ZUk7f/og==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055576;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ar7PExbW3wdbV0P0s2TSsG5MJBH7Qz+m72FE/mrj/DA=;
	b=vT1TXd+mlsxHbZDwJnVX04c2oxyVfP4E3ldIgBkvmzZPd5baGJ2w4GPKHQql2POJX3rg
	 nHOwLHT7/D2x43TixXZ0LuoisCTa5ubOYiXWOoitKFDGz7FmRBFSYNcvJoc4RNUCCOrqx
	 IbLuHlhLcmr9IIVk5IZ62rC8GO5JHqJEITw1fmKPUSTswRFxs1sf0362WVCbsbxLqJlWI
	 SrPewmwPycsSdOo/1dcy9ft/mfkApGj8r5Ic1TENxIrL9TW5DlPvphau1/t7U9/3Flsdf
	 /phwvuafVpyeuvOxTJ/5vHSg7XoRVywhvyaSfGuYFEXUOU3hIDJx2s751WX5LZdY6ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pv59yIzy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B807606A332;
	Sat,  7 Nov 2026 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pv59yIzy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794055576;
	b=dEqzj2xSckzRKH8mWGt9Oir0vorNFDz4kCvZlhyAV8uiXaE59px0TlkC6pzEEn/HeZh+
	 1xLrbkVEOKIdPzFIrDr08fYAP/ltpwtXeBeUs7gAFGftzNtaEFW7zQaN6VDfQeXdGz3lo
	 oYUFrR2EuY0G1fioRdaABUV9CCvN/jxRatpWpKwRqpqkP5PwtUljPJQbmM3JJro4eFv+E
	 W+0ASfLmDFdBrnTIKtFqvWpa/VQBHis63ywRCWyVtrQ7elJDVJSMIUtb4J529abDkA+5s
	 qJzVFGJWRMDWTxPqstPED5LjsqC23dL62W6S7mBq3uIzFF/BYRKKW+Mzoy030WEUKJw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055576;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ar7PExbW3wdbV0P0s2TSsG5MJBH7Qz+m72FE/mrj/DA=;
	b=SxoIizaQOmP95x8osGFIxz/BtaNDrIo+LG3PgqPoZdwfPj3RTbK9MffDokpsLmOv4j4f
	 AgRrAiSKUeNhZzIMO1sjIvUECuflnSJwtZLPnLL2+bvvqglqGOEUruDkZeeSDO8SYFs4K
	 tf+b9eaYsAU6Enwz3F5oM+wwDsIccInP/P0m86a8Qc3MkMdtC3duPiFRZVXShTvhfGZa3
	 ORhGzM8FtvfIITcwxJIlVVK5EsS7hCegVSInjLvC4ofGFJ6TnXlgtr/HATUqfHIzH2juF
	 mIE+LbN2dniWk7cxc6Ob9Mzk8mOsDjQF+3e8Z4vQ/PckATd2dEVAXPpwQCFvmL8gBMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3B5EE1F0089F;
	Sat,  7 Nov 2026 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794055576;
	bh=ar7PExbW3wdbV0P0s2TSsG5MJBH7Qz+m72FE/mrj/DA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Pv59yIzyFfSyHjHZJN0CjdoaZ94kwmdRMych70xbd1OxgO89ws1ep9KAz8MFxR0pU
	 V+wCMZa9vW6N1jPKUwj9O58/rskYJg+ww5u5B8ztOlcn3Zr5k7RVsBEjCMsBbWrqjm
	 Yl1kwSVeNJCIaLVgNci79tQz4t6Eoj8NqXLka0xp7lnwV1EkwvUHSIFKamNyMe1ZuF
	 xBc0d4O4p0sLj4xDla8WECPBXvn8IcSb+qjM+9sP8rNWcZnmKxpfKYP0QnnQODw4D4
	 L6mS8ZQ9F/xT59oU10b4PrDM1lo/zLc28siTHderg3CY1rD0x7VFLmtxYeCrKg4Y7C
	 V0EcB7VMpNnXA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 90BCA47BF9;
	Sat,  7 Nov 2026 12:46:14 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Subject: [PATCH v4 0/2] usb: gadget: gadgetfs: fix ep0 request lifetime and
 event counter
Date: Sat, 07 Nov 2026 21:46:12 +0900
Message-Id: <20261107-b4-gadgetfs-ep0-v4-0-86bdfd684b54@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAJQd72oC/4WPy07EMAxFf2WUNS5xmknqWfEfiEWaetog+lASK
 tCo/05T2AwsWF7b5+j6JhLHwElcTjcReQ0pzNMe9MNJ+MFNPUPo9iyUVAZRGmg19K7rOV8T8CL
 h2qD2qC1aR2KnlsjX8HEYn1++c3pvX9nnoikXrUsMbXSTH8pojqEP0+PoUuZY9kNIeY6fR6UVi
 0egpZqsITSkK2WtwYrOutakSVpU1jSIJKu7YovLfoDMKT/1owtvlZ9HURqt6nD+fGT/fLQqQOi
 ahgyj685of/P1P3wNEoySDXVespd3/LZtXyvFB0N0AQAA
X-Change-ID: 20261106-b4-gadgetfs-ep0-f814c14717a9
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794055573; l=3518;
 i=kayano050408@gmail.com; s=20261106-gadgetfs-gmail;
 h=from:subject:message-id;
 bh=bTvVhVMcfu7sgkbgZWUCkfdoko52Ui4bE2y5k9oCIrY=;
 b=B21GKPrJNI7wrXIy8PZGYR0WU8eEgz9b72MBnJdaxqL0PTbYWb6FD7tTVMkhomnAc8MN35SL1
 soDvDVg6IJFD5Yn9iVZ2xDGp/FK8vHxAnWEPKdM1sK0gbgNwPyPcm1E
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=DtAI52kU3F0sVbAiS4n+5b4UKMnVF398eKHlj3H9KBY=
X-Endpoint-Received: by B4 Relay for
 kayano050408@gmail.com/20261106-gadgetfs-gmail with auth_id=1433
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com

gadgetfs_unbind() frees the preallocated ep0 request after disconnecting
the gadget, assuming that no I/O remains active. With dummy_hcd, a
delayed userspace response can leave the request queued when it is freed,
which triggers the warning in dummy_free_request() and a use-after-free
when dummy_udc_stop() drains the endpoint queue.

gadgetfs_setup() and ep0_write() also race on dev->req and req->buf
while a control transfer is in flight or while a completed delegated OUT
transfer is waiting for ep0_read() to copy the payload to userspace.
Overwriting req->buf with a descriptor pointer causes clean_req() to
free the descriptor buffer instead of the request buffer.

Copy completed OUT payloads into a separate setup_buf in ep0_complete(),
copy IN payloads from userspace into a stack buffer before preparing
dev->req in ep0_write(), reset req->buf when transfers finish, reject
dev->req reuse while it is queued, and dequeue it before freeing in
gadgetfs_unbind(). The second patch dequeues ep0 events into the local
buffer under dev->lock before copy_to_user() to prevent event races,
dropped GADGETFS_SETUP events, and counter underflow.

Changes in v4:
- Reject reusing dev->req in setup_req() and gadgetfs_setup() while
  dev->ep0_req_queued is set, so an -EINVAL queue failure cannot clear
  ep0_req_queued while dev->req remains on the endpoint queue.
- Copy control IN payloads into a stack buffer before preparing dev->req
  in ep0_write(), copy completed control OUT payloads into setup_buf in
  ep0_complete(), and reset req->buf when control transfers complete so
  clean_req() cannot free descriptor memory.
- Dequeue ep0 events into the local buffer and update dev->ev_next under
  dev->lock before copy_to_user() instead of using a generation counter,
  avoiding unlocked dev->event[] reads and lost GADGETFS_SETUP events.
- Link to v3: https://patch.msgid.link/20261107-b4-gadgetfs-ep0-v3-0-62089dc0ec07@gmail.com

Changes in v3:
- Replace the v2 -EBUSY rejection with a separate buffer for pending OUT
  data, so a new SETUP can reuse dev->req without overwriting unread data
  or leaving ep0 permanently busy after a zero-length status stage.
- Dequeue a pending ep0 request before freeing it in gadgetfs_unbind().
- Add a separate patch preventing the ep0 event counter underflow.
- Link to v2: https://patch.msgid.link/20261107-b4-gadgetfs-ep0-v2-1-d8896e1ad517@gmail.com

Changes in v2:
- Also check dev->setup_out_ready in gadgetfs_setup() so a new SETUP
  request cannot reuse dev->req or overwrite req->buf while ep0_read()
  still has unread or in-progress control OUT data.
- Reset req->buf to dev->rbuf in setup_req() when len <= sizeof(dev->rbuf)
  and clean up unread control OUT buffer in gadgetfs_unbind().
- Remove RFC syzbot test commands from the commit description and add the
  syzbot Tested-by tag.
- Link to v1: https://patch.msgid.link/179397691694.27761.9543494907127681190.gadgetfs-ep0-patch-test@gmail.com

Signed-off-by: Jing Lin <kayano050408@gmail.com>

---
Jing Lin (2):
      usb: gadget: gadgetfs: fix ep0 request lifetime on disconnect
      usb: gadget: gadgetfs: prevent ep0 event counter underflow

 drivers/usb/gadget/legacy/inode.c | 171 ++++++++++++++++++++++++++------------
 1 file changed, 117 insertions(+), 54 deletions(-)
---
base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
change-id: 20261106-b4-gadgetfs-ep0-f814c14717a9

Best regards,
--  
Jing Lin <kayano050408@gmail.com>


