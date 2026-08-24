Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AD7324716;
	Mon, 24 Aug 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578376; cv=none; b=Z1rFXGzAQ3iDrZUPnr4eUw2061yAxGKi6V6VHGpj8+L+rDpGxkshe+ftVCn1D9yrcqqil++i3geL4yzA3yijAcmtdngEzRqhadwggxMgxSt4sKEM+sKF++KxXEcg//KG9TLfsqLQZxF31LldOLdO94ebs/GhUuURLjshaQnsOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578376; c=relaxed/simple;
	bh=m8oDTs2Omttsm2iVNRsyL1KTq7wF+IDuFw+OPYgP+Kg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oWR3iiqOCUAFqO4MuDo5uAe5QUzJO+rZ9kTAVMz9C4yFZ7kaXbVdi2oU9rSQw+bGgsFlfWC3bNufX0dbpzs0YWnblow8pa6B9V/4+c9JVL1Z8qkC1/Q+3JU+0CtT9rqdNcSH5IrCyldXeYH0uz9OeQ+wdEdCsFm32giKG6haFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY9vVvfj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY9vVvfj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 867A8C19425;
	Mon, 24 Aug 2026 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787578375;
	bh=m8oDTs2Omttsm2iVNRsyL1KTq7wF+IDuFw+OPYgP+Kg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LY9vVvfjVj0dTcYmQccXCfK9HWdq3+Ay3pEkWnRrKmIARH5jxrUIgRcABeKxPRAl3
	 IfQBfGOzMvAD/nQjIpMGXEdkjxVYYHXW9MdBu1YJzceL4Y06xqm9uVV8Q256v868r0
	 VKiatKE58emBZ3v6uuz6KR34AYpulQATZAUPiM4rZBICJ6tmxjHpLO/vE+3vgFvzMl
	 hQqa9h5BwZauz+NXtn8UhOzhE6YpC630brsgQUtYJcMn5jGoXc/s8PIVHaIUu73dr4
	 Inkj64EDkERbR8uHQwCFCiBs3HTyfKEclajAfdftozq0R11+gBy6ny42DUo4wTzKZO
	 0+syj18dc55jA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D8C5DF81;
	Mon, 24 Aug 2026 13:32:55 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Subject: [PATCH v2 0/2] loop, nbd: drop partitions left behind by the
 GD_NEED_PART_SCAN removal
Date: Mon, 24 Aug 2026 15:32:46 +0200
Message-Id: <20260824-b4-loop-nbd-stale-partitions-v2-0-9815a577cebd@amutable.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr2K6dkxpFIgr72FYzNBRaoCSTiEaw
 t1t8QIu3/8zL39VwsGxqOthVYEXJ86PCczxoNoOxyeDs4mV0abUtS6BztB7P8FIFiRizzBhiC6
 mPwFjC82WqwINqqSYAj/ce9ffmx/LTC9uY3bmC0JhoIBj2+VoQIkcctE5iT589mFLkQV/blgK0
 FBWRNUFa1sR33CYI1LPp9YPqtm27QvDn62h9gAAAA==
X-Change-ID: 20260806-b4-loop-nbd-stale-partitions-2d10ede71a2a
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nbd@other.debian.org, Christoph Hellwig <hch@infradead.org>, 
 Bart Van Assche <bvanassche@acm.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Daan De Meyer <daan@amutable.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787578374; l=2324;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=m8oDTs2Omttsm2iVNRsyL1KTq7wF+IDuFw+OPYgP+Kg=;
 b=fNrfiKkFno9FI1OkHU1IpiZwGO7JDAKB2aiPhaNwy4SDOLKjkI6phc4O81sz4kHnlF/d34lTv
 jqFqFl5ACeaCBaP+Szikiya/mlTUw0I82MIJ3feixk0zQoizlshzTB7
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
Changes in v2:
- Rewrap the comments added by both patches so they fit in 80 columns
  (Christoph Hellwig).
- No functional change, so the review and test tags from v1 were carried
  over.
- Link to v1: https://patch.msgid.link/20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com

---
Daan De Meyer (2):
      loop: drop stale partitions on LOOP_CHANGE_FD
      nbd: drop stale partitions on NBD_CLEAR_SOCK

 drivers/block/loop.c | 10 ++++++----
 drivers/block/nbd.c  |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)
---
base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
change-id: 20260806-b4-loop-nbd-stale-partitions-2d10ede71a2a

Best regards,
--  
Daan De Meyer <daan@amutable.com>


