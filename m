Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792675900;
	b=zaPJqw9qwvgBfAa1OPKK/B2I5/5cNy0Ptz0LjN2jjLf2sPX9d7ml0FKYSP8YbKGDcKGD
	 kWrbZSFRJaD+X48NvmyHtu4N+wLK4cjRK8aqAlG4xq6/tCSZGCHPUyADxeVor/4FP2E6l
	 U7/fGqg7qmlCUlC9QoGd2ZSVgOtYHwvwewk6MkJ7oeA9LC91BG+QhZkhFxLM7PxreYWBC
	 1odcMQ5K6UgGIYecPQ37xr8UZMTOaSwxvfqXzdOrLdzh1xKl5dkOL61b6Hh21T4e6J9dO
	 HCp7MzgeWsQdKrJH1ITUpgZO9778iYGlG9LmwWmeo646Bel3O223JTO84dvMl9Zn6/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675900;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0tkDDnV0w78Z3mlPUa+vDDHH1bEm6rgLoCJLEs/Eiwg=;
	b=N/qiZoaCIv+7l9ccwqZ+A2P8t6sNeQt+jzuEPxJJLTkb+oGCA+/FIcfUH5BiAg6XsqlE
	 WAbH02MrFDA2XEdu6ugnaafMNyNjYkF7ntDgs9dW98VWGLwNv9mLsh46fNr8hHMUDtxRT
	 esVOTiAwuOoA3D1qqJfF5kI3N0PFYf1Rp1ipNLnUu8KLa0LyXlOs05dXEOONWo05TOIHg
	 SAM6lU07dN4QSMCwxBTrbh1esqrHGs4/vLzBCA3jCBUdgF/7YTJx4NdcHGUjjf8GYKr0m
	 HTjqwmBirmO74vfK/8nWt02CLy9Q2NKjs5PKxNEZ+C+F6ebawWuubW2ZLocmAj6CpGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcDd9xmc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD70606A319;
	Thu, 22 Oct 2026 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcDd9xmc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792675900;
	b=rDsnfXfdKbQnPjXgxLgtasEwG8hsdGzI3IJmMGYadYJuHDAT7G7qFhlmeFoFK2PgLyf9
	 YznxiElSzdoqNmasKYU/SaCGphQmMDYGUEWzu8osyml3xAluvzEXiKpYCCVjBcnO9adW3
	 Nz0NK7BsKmbv1FWmr9M1sILvvUXsxnnLC2JZksJYMS7M7ohzHIgh/ZK2pQN/Ho/DKdiLs
	 9coLaK6lrEMRUhdr2omVkTbiAYYOGyv3svqxJHfzsoYFPjRtkuJkQG7XC13qFvn1rq0/o
	 OJxYNVY3L463T7ihmJ+jneIHtN9rbXgoSXzwq+8AyjlGlwr7Q+EZ4oiAyRBWfBfDYEw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675900;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0tkDDnV0w78Z3mlPUa+vDDHH1bEm6rgLoCJLEs/Eiwg=;
	b=InIrMYaQMBz22aeJL2SBnDdoaOwqR2YF46kOWN5IcOefH1YarW+FvWti+wmO1A0GL72C
	 StiPhpShdcFBpiB7MfuublUCNgb7+Lqc2ABS3MjuVGm6bw9Ukvjk121kw4OFFLVwrm8q4
	 gHRvhvSD59epLbKie8oytc/k7mhT9aTwLPhESicHTf/6fH0lPRpVJTqiQ4IaOLzplNqfl
	 BKP0JEi1vByDVEGcWjzpJrwspd/g/0OcUs0UoZGky6PBTbkWXcOJHN/n+8Qkfq/0UQoH0
	 b/KVX3ZeqDW5eW5yWxPxpNVh3VXh3L/a3B2nUdrHHJZ1o8Hlyr6wmsf3Jh9kjoiMARg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 553F31F000C4;
	Thu, 22 Oct 2026 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792675900;
	bh=0tkDDnV0w78Z3mlPUa+vDDHH1bEm6rgLoCJLEs/Eiwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hcDd9xmc1BMHG0b2bkjS7rXek3ucLzH0BWBH91eNZwx0+ZQoCYmvSDs6ICbL4dQPJ
	 kAs4W8w3QM+53ot0ww9CErfGVSTSY9QP1olRvSCgkqzbugEngLRJ34ncttcUq3FN8w
	 Y7DCKeU/fg5Q6PsNPlDe+/jtkf5m2WZJDrgLibuEzC/NLU+CkJFENsyjgFf+7IxXyB
	 1m7OsKifMDH8B4jLbya8phCJ8Zhs1oL29BVGGL7Oap/dsovCSItHXcMLU8aw5LZEyW
	 rgLWGoXRYnEuHh1UQFfdhKS3DocwnVlyNdsXmsqiCMCdwQdF9AjvBOB0vnu0eoKMkx
	 /3COdXaD5kHOA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DAE4643592;
	Thu, 22 Oct 2026 13:31:38 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Date: Thu, 22 Oct 2026 15:31:12 +0200
Subject: [PATCH v3 2/2] nbd: drop stale partitions on NBD_CLEAR_SOCK
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
Message-Id: <20261022-b4-loop-nbd-stale-partitions-v3-2-7c58ecab69c8@amutable.com>
References: <20261022-b4-loop-nbd-stale-partitions-v3-0-7c58ecab69c8@amutable.com>
In-Reply-To: <20261022-b4-loop-nbd-stale-partitions-v3-0-7c58ecab69c8@amutable.com>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nbd@other.debian.org, Christoph Hellwig <hch@infradead.org>, 
 Bart Van Assche <bvanassche@acm.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Daan De Meyer <daan@amutable.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792675886; l=2227;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=IJsYukTCp+gKDcCUl73TRLZtzYPIPmGwnx1/NOZHD4E=;
 b=SDLMBKjcSDyBAiGNS/QgWYnRmKqNgOs/BmSlZQTKdlkMwZqJHCosTH83xBE6ud2910pRQi4Vw
 UHqCmIIWiHOBf++I5GWOGa8g8zFBOEVxwdKFP0RlMhfUVdpid2D02vt
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
setting GD_NEED_PART_SCAN. Besides requesting a rescan, that bit was what
removed stale partitions on the next open, as bdev_disk_changed() drops
all partitions before it consults disk_has_partscan().

nbd_clear_sock_ioctl() relied on that. It zeroes the capacity through
nbd_bdev_reset(), but nothing removes the partitions of the disconnected
device anymore. With the default max_part=16 they linger until the next
connect sets GD_NEED_PART_SCAN again. With max_part=0 nothing ever sets
it, so they are never removed at all, even though nbd does not set
GENHD_FL_NO_PART and partitions can therefore still be added with BLKPG.

Set GD_NEED_PART_SCAN in nbd_clear_sock_ioctl() so the partitions are
dropped on the next open. Calling bdev_disk_changed() directly is not an
option as it needs open_mutex, which nbd_open() acquires under
config_lock.

Fixes: 267ec4d7223a ("loop: fix partition scan race between udev and loop_reread_partitions()")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Daan De Meyer <daan@amutable.com>
---
 drivers/block/nbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ffce519bf008..09b4ad70a5d7 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1616,6 +1616,13 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd)
 	nbd_clear_sock(nbd);
 	disk_force_media_change(nbd->disk);
 	nbd_bdev_reset(nbd);
+	/*
+	 * Drop the partitions of the disconnected device on the next open.
+	 * They can exist even with max_part zero as they may have been added
+	 * manually with BLKPG. Dropping them here is not possible as that
+	 * needs open_mutex, which nbd_open() acquires under config_lock.
+	 */
+	set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);

-- 
2.54.0


