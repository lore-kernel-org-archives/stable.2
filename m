Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792741655;
	b=pTVTQiigtwvncJ/f8dpS9fokdpGuQ48JHvVKzfCvK3mDTOc8mgXXNuWW90BVV1op0L6R
	 AU/qknYRAg07Vbk0GtaateA40kjeA9M4gYiABHMlGaeYdgMyYwfQ6c+QaUk7aTjSs8qIp
	 dzx3pdr4aY7qgRL8/J1VDvFkA/bQavWK6a3/xehp/M9tAlpViSAYzxk6oDdw3BaD3kxBn
	 0vRHXqUCYA3sMHkHhzRCjqhbiT3FQUoiw+m6YGVlXUEqaQeHQRgFAzLitVYGz5mqDnZrO
	 aUECMWCSaXCz9ezMv8EdaTC+oDeBqLbq5xkrQyo7ve3NBZMYdZag6yb2iRSLZuSibEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741655;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9yH6lCZJs4jQqhq5RKT/kA7z15frEt+8pQmmPZcgKoI=;
	b=oosfMljevutVkG90gfPQARwWl3zyEpFxPaDw/hcX+t58LsY+n76MUyajmY+B7gKYnF62
	 A519LgJ3cEPITicNvaUFOwYIePKPSNH/Jo4N/rciOYKz8xTfeVLOlKJCdxusOzThG0nou
	 u9mKS0aBbpV8xoPisivcshpUCuo6VRYZPZCG0fgcc0m713WPb0Dy/bx6/jkfMlxP0eHT/
	 8PDOMBw+VPa44fovU1lzmmUCW7aNbO3cQLPdymFTW5gjMWD0yD9kM1uuVqPQgyi63WrC9
	 844uSDVD6UGVz9xLxuo5AzdiGLlmJMIb0mja1ip5SvwLF2IX1SRZ7UCw/9xiRVKT4gQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MHb/qz0f";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EDB606A31A;
	Fri, 23 Oct 2026 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHb/qz0f
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792741655;
	b=POK1lHC9ktNwu9VX9PaWJH1xjXmT9N42u5XhE2DqUSGw5/t4C6bnunnleTCk3/v7qCMu
	 F0ebKjw7V5bJza1M/CbIB8VQryOKzXpRzNXkjPPguZ8gH88tmy6Vy+RcBnjRBlyo18CB/
	 1/HrEQj2aFLyF+/ekr47v+r+j+9pxP6fqSUai7kyPo4Dm1dKpdYmEzI1QD0AXapWUMr/b
	 n389jLVlH5HqjLxtr8uwtrxPYZ1z8+lR2/jIXABWlfoJ093oLbK9sZLQRRqDhDrrTAcAR
	 HmfxLmZBISfKj7W5KrgG3WR08XymCBRQnO/Vst9jjIme+A6WovV5jnjLho6t8IcXoxw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792741655;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9yH6lCZJs4jQqhq5RKT/kA7z15frEt+8pQmmPZcgKoI=;
	b=GMQfhp9I4vd5myvuK3oBdZ3b4+e+YNm7J8Vks+bmMS9PH099BLvTP3ZPGn/AasV1gCd2
	 xaOzwHeAVrFDz1kJdBIoOzqgeKdCOkGRFB7Ao3D3pqRAMcjvIABGS/hMTA+zygmLd10f3
	 2uOQW66ngmF31K9ZRBH6lRNGM2PfJftLOa1uUxb8j+iBFJ0T68kZLOVUkgjb8QRq5HhKb
	 2z53IN1mckbicV8qgneuTchjy9AaHVn+tWvvua7jcrlYdp8M7KstrF+kRRpcKDQEvy691
	 P718UWSF65cD6IaFht/v8x+/03dL48PkLaOybdSmYMCfziNNIn/h/583y1rJyEYdz3g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AF79D1F01829;
	Fri, 23 Oct 2026 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741655;
	bh=9yH6lCZJs4jQqhq5RKT/kA7z15frEt+8pQmmPZcgKoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MHb/qz0fhwHON31otPKHTAfRFUgNCQ2OS0hDPjaISsN+XrDatxPI4Q2MBDlR9V5g2
	 vw4zSiAkPqm2mukeKNMmq2JdJhwn0LGbMx6wlV3MwGVXorbUs0H+1sAEKO7VqJCIuV
	 xGd/DX+nMbYUTqD9H2U+fRG3HJKnBtDhOwX1KN7gtnfdZ4npHfzZm0/a6serbBo8mP
	 5XiL+Tg4Q1berTNx9OAXE1Wv0sAvv+UGn9m/p7TJnkRoysuWDKFT0zVVP/tb4tVdoR
	 O7SrQBBkuXjT/Zo0rkIwGWDSa5VbBL2oNvhaE49tW31fah4ulzUNmXXve7T6soige+
	 /dYgek7bahQ2g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 19DAA443FE;
	Fri, 23 Oct 2026 07:47:34 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Date: Fri, 23 Oct 2026 09:47:20 +0200
Subject: [PATCH v4 1/2] loop: drop stale partitions on LOOP_CHANGE_FD
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
Message-Id: <20261023-b4-loop-nbd-stale-partitions-v4-1-2baf05e4b2cb@amutable.com>
References: <20261023-b4-loop-nbd-stale-partitions-v4-0-2baf05e4b2cb@amutable.com>
In-Reply-To: <20261023-b4-loop-nbd-stale-partitions-v4-0-2baf05e4b2cb@amutable.com>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nbd@other.debian.org, Christoph Hellwig <hch@infradead.org>, 
 Bart Van Assche <bvanassche@acm.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Daan De Meyer <daan@amutable.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792741645; l=2855;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=puuj6cW8tTVT3rlBQ4+twjIwX6td3ITnz1udGWzqXoE=;
 b=Tnjirr+n77MEjWAVk8pBYLU9GIMayh2l3zrluh5TKVI0jg86QutdronlkxiSz0EGQUKpm2Lhj
 NxLBZEsVX1lB1FuuL7jMNu3uk0R5+t1d3dWhyWkPVrpzzYGXkDYWJxV
X-Developer-Key: i=daan@amutable.com; a=ed25519;
 pk=I1l+WwrtmzRgofA5SQ1wTuJi18fjh91w+f5uRkFeZEA=
X-Endpoint-Received: by B4 Relay for daan@amutable.com/20260712 with
 auth_id=868
X-Original-From: Daan De Meyer <daan@amutable.com>
Reply-To: daan@amutable.com
Content-Transfer-Encoding: 7bit

From: Daan De Meyer <daan@amutable.com>

Commit 267ec4d7223a ("loop: fix partition scan race between udev and
loop_reread_partitions()") stopped disk_force_media_change() from
setting GD_NEED_PART_SCAN. That bit did more than request a rescan:
bdev_disk_changed() drops every partition before it consults
disk_has_partscan(), so the lazy scan on the next open was also what
removed partitions from a loop device without LO_FLAGS_PARTSCAN.

Such devices are not unusual. bdev_add_partition() only rejects
GENHD_FL_NO_PART disks, so BLKPG_ADD_PARTITION works while
GD_SUPPRESS_PART_SCAN is set, and parted, libfdisk and systemd all fall
back to BLKPG when BLKRRPART fails with -EINVAL, which is what a loop
device without LO_FLAGS_PARTSCAN returns.

loop_change_fd() only rescans when LO_FLAGS_PARTSCAN is set, so those
partitions now survive the backing file swap and keep describing the old
file. The new backing file must have the same size, but its partition
table can be completely different, leaving the partition devices mapping
the wrong ranges.

Call loop_reread_partitions() unconditionally. Without LO_FLAGS_PARTSCAN,
blk_add_partitions() returns early, so this drops the stale partitions
without scanning the new backing file.

Fixes: 267ec4d7223a ("loop: fix partition scan race between udev and loop_reread_partitions()")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Daan De Meyer <daan@amutable.com>
---
 drivers/block/loop.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..378163fdf957 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -552,7 +552,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	struct file *old_file;
 	unsigned int memflags;
 	int error;
-	bool partscan;
 	bool is_loop;
 
 	if (!file)
@@ -606,7 +605,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	loop_assign_backing_file(lo, file);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
-	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	loop_global_unlock(lo, is_loop);
 
 	/*
@@ -624,8 +622,12 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	 */
 	fput(old_file);
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
-	if (partscan)
-		loop_reread_partitions(lo);
+	/*
+	 * Rescan or, without LO_FLAGS_PARTSCAN, just drop the partitions of
+	 * the old backing file. They can exist without LO_FLAGS_PARTSCAN as
+	 * they may have been added manually with BLKPG.
+	 */
+	loop_reread_partitions(lo);
 
 	error = 0;
 done:

-- 
2.54.0


