Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792675900;
	b=BlRRTcyGAKro+LEM08PXE2NWvOWfwj412sB2Oe+kE7kqmlGXZOZ9nT+f6mIZIKXz61OK
	 iYhaVDIQiohOomHrHIEcMWW+LN5kNVob0KWLg9TARFDWqPrUEYr3kpcuQ3Mcpck8eCCXT
	 8+G/sG9txqgQd/tiHtBQt0Ds/24T5ehedp6d9iR881W+LQzxSs7gaF1L+RSNEwySbCtUH
	 mydsVSpeWXEOXqCm6v4bcO1oGPsuxTk9TB/cCCOvw162eKTXFCottZQiAy2VfXqCoDkYj
	 gHK8sN2fZUB/QGx4EZc0clgE7h1I5+9+924ll3rdBmwiG5fl6XP3/dSnYREzXCNEpjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675900;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=BIdLDKvZ8Gb9KO82Yn9OgQ6TjBbb88LPc8iOmBN900k=;
	b=Os3fuDOBr83wtKIbe6N8KVdBixVpSNcJf/M8NmfQ99qya9LJTMBroW5VRAQpNKvMpZ81
	 65aDnd8Rx/dSlYmZ/4BPW0FZL25swAm8SpZFwAuW/HzBUxi9g1BEYulm8XyLsv341gbHm
	 +p4FwyWyJdyMcQoyvzfRtkvKDNV4NN4ioaQ8eYVltVbZ1fLqUcB5qaA23Goc5e5gaII3D
	 tiyL8hAzRsMQKxA2/Ib+gMK4KU1A1hNuoAAY3S9sgkj/1jGLax5gh8vKICUzR05euXaJr
	 eCkZMcq9o/w2gxS9dbzx2aqbf5HWgWhPd4xGbs236NMZGhlDiTbWqKcNghKBOe7UzIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpMd3A4p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E2606A31B;
	Thu, 22 Oct 2026 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpMd3A4p
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792675899;
	b=uW/E/EK1GITkEqk0IjwSFb6g9K9gL7oi3mI/EEvfGmfOz2+WzkJtNaqwmOgRvXEpYvPO
	 WbCfStobbEUCbcH0yr0c53+8JYvVDd7EXEOOM2qoHZp4sixVjjVJlrv8IhiDU929fPnuc
	 xDu/kAIzjSW+qlFxHE/5dU1/56/Ze2BzJeTZTlBG7I/B3xzOw/wi5z4MjNXdT/zo4ChNA
	 3fgBlK/DOSlMGXt+1dwSsiDwavOwU8poKiQ13wmKyvcrpXJsQ6Ueu/r7AfMXCpZ/5e4tk
	 4ETKZA2UNjXvnoaUv1xnWG/1+vBbzrorcMokd5P4IZQ1FpOJZhDAtPVbi/C5UmqT51g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675899;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=BIdLDKvZ8Gb9KO82Yn9OgQ6TjBbb88LPc8iOmBN900k=;
	b=CPRC9TSa1/oZdgi+nrWCkwFNG0/nHMO44hwuSJkAZTKlxTQOL5Mo8eypz9URHml85jHd
	 f8nSQVnVeFk3Ga2phouj2v5Z4N2HKDqD0vHNGM22moWVElA5r5ZM4P7DQ5VnR++69BSWQ
	 DyKpPCLhmx+tkaXzlTQfV3qN6Jh+aFjVasYjDl5aRrwiju49mC2wvWvgwPYwhAB+FnwbI
	 zPWY5/plgDPAOkB+4P1o3ptzMNfDS0E/QhLcUGUmwzv0JRp+QSN7acNiH4z2nvY6FhDXX
	 sz22HFreTLqErUcSwhCV9tLQM5yrMcnWwKe/3gZHbq9eXhcSIr73/FayxNyI2XMY3gg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3FFBF1F000C1;
	Thu, 22 Oct 2026 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792675899;
	bh=BIdLDKvZ8Gb9KO82Yn9OgQ6TjBbb88LPc8iOmBN900k=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=GpMd3A4pyuxWGXlGZQfMaxq80VsrCRsK0c5BsUTxzVNb43mB5mXgXlP3ryDiOYalw
	 AiO/pEPdRtn3lGDLaILyBcNTnHBCBhflJWBHOrwK8EEVipPHSaFwUKudSZkTX0DxLe
	 7WYk7J6ViE7mVgO0R5gSupcaRTXeD8u8dqdN8bpZU2jzpv23z0B5Hzx9VXOxLrY+te
	 HJ6ccwh0wH7j/EgnISvBmqPPd2EWqecObhzJ4+mTtykwoQuYw1Nc7PtzXhsu5bgO2l
	 n2gKOPI1GVDAnPPmU33RuAjUQK5mrNNYPC4tHIjIhf/NdbbmxsZWP9zhYcqyExy54D
	 jB4d/4N3uIp7A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CA14743588;
	Thu, 22 Oct 2026 13:31:38 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Subject: [PATCH v3 0/2] loop, nbd: drop partitions left behind by the
 GD_NEED_PART_SCAN removal
Date: Thu, 22 Oct 2026 15:31:10 +0200
Message-Id: <20261022-b4-loop-nbd-stale-partitions-v3-0-7c58ecab69c8@amutable.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTU7DMBAF4KtUXjPIdps4dMU9UBcz9kCMkjjyu
 BGoyt2xywaxgeWbn0/vpoRzZFHnw01l3qLEtNRwfDgoP+LyxhBDzcpq2+tB90AnmFJaYaEAUnB
 iWDGXWOqfgA1Gc2Bn0KKqxJr5NX7c+ZfLd5YrvbMvzWwXhMJAGRc/ttGMUji3xRilpPx5L7aZB
 vyzw2ZAQ++IXIdDcMTPOF8L0sSPPs2q1djsD8+e/vBs9Z4G02HnnGcKv7x9378AAM8qSEYBAAA
 =
X-Change-ID: 20260806-b4-loop-nbd-stale-partitions-2d10ede71a2a
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nbd@other.debian.org, Christoph Hellwig <hch@infradead.org>, 
 Bart Van Assche <bvanassche@acm.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Daan De Meyer <daan@amutable.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792675886; l=2769;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=3+PDMxnsl8G9ZlQLR/RlC4f2OkrLNO1Xhb37Ahs8XaM=;
 b=cg2u2hn5E935C0FY3USY7C/0Oz9LXFC33XtW608UD/MlDeMedXfFIx20Y3vtT1osg+P6STlXH
 UM1gcJ+K8XTDmxOFLQuO2dYE1oeOy0zMyGxbOdvl3kEfJ0mhamdKyXv
X-Developer-Key: i=daan@amutable.com; a=ed25519;
 pk=I1l+WwrtmzRgofA5SQ1wTuJi18fjh91w+f5uRkFeZEA=
X-Endpoint-Received: by B4 Relay for daan@amutable.com/20260712 with
 auth_id=868
X-Original-From: Daan De Meyer <daan@amutable.com>
Reply-To: daan@amutable.com

Commit 267ec4d7223a ("loop: fix partition scan race between udev and
loop_reread_partitions()") stopped disk_force_media_change() from setting
GD_NEED_PART_SCAN. The caller audit in that commit only considered the bit
as a request to rescan partitions, but it did more than that:
bdev_disk_changed() drops every entry in disk->part_tbl before it consults
disk_has_partscan(), and only the re-adding half is gated on partition
scanning being enabled. The lazy scan on the next open was therefore also
the only thing removing partitions from a device that has partitions but
no partition scanning.

Loop devices without LO_FLAGS_PARTSCAN are exactly such devices, and they
are not unusual. bdev_add_partition() only rejects GENHD_FL_NO_PART disks,
so BLKPG_ADD_PARTITION works while GD_SUPPRESS_PART_SCAN is set, and
parted, libfdisk and systemd all fall back to BLKPG when BLKRRPART fails
with -EINVAL, which is what a loop device without LO_FLAGS_PARTSCAN
returns.

Commit c4f4c0fc551c ("loop: remove manually added partitions on detach")
fixed the detach path after this was reported as loop devices picking up
partition devices from a previously built image:

  https://bugs.debian.org/1141434

These two patches fix the two remaining places that relied on the same
lazy cleanup, LOOP_CHANGE_FD and NBD_CLEAR_SOCK.

Regression tests for both paths have been submitted to blktests:

  https://github.com/linux-blktests/blktests/pull/259
  https://github.com/linux-blktests/blktests/pull/260

Signed-off-by: Daan De Meyer <daan@amutable.com>
---
Changes in v3:
- Rebase onto current mainline.
- No functional changes.
- Link to v2: https://patch.msgid.link/20260824-b4-loop-nbd-stale-partitions-v2-0-9815a577cebd@amutable.com

Changes in v2:
- Rewrap the comments added by both patches so they fit in 80 columns
  (Christoph Hellwig).
- No functional change, so the review and test tags from v1 were carried
  over.
- Link to v1: https://patch.msgid.link/20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com

To: Jens Axboe <axboe@kernel.dk>
To: Daan De Meyer <daan.j.demeyer@gmail.com>
To: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: nbd@other.debian.org

---
Daan De Meyer (2):
      loop: drop stale partitions on LOOP_CHANGE_FD
      nbd: drop stale partitions on NBD_CLEAR_SOCK

 drivers/block/loop.c | 10 ++++++----
 drivers/block/nbd.c  |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)
---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20260806-b4-loop-nbd-stale-partitions-2d10ede71a2a

Best regards,
--  
Daan De Meyer <daan@amutable.com>


