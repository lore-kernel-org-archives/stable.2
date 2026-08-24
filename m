Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A453233E8;
	Mon, 24 Aug 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578376; cv=none; b=EhFqKK/Pw+/FGoPBB9RkenjuX3ZakO+GAi8r/8dYu2NE/sbuiksGqKXeWf/H1vPbDYto1GmFDhDoWcTBGfGAHoSQE5M3V6x80VTdZXQviAxxAMCS0sEjyv1Shb02dnGLs24C1Se7/Ic3rT7Fe3N6dE/aYIRsdZ9CmIp20r5TEs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578376; c=relaxed/simple;
	bh=bqxr7tJMlMv9QBqyGWY6/PLr9AYldw0DmoB+D9A7GFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFj6nsQdYgX86BBFMLhLO60oIauvyFh6LaCzeeEsttca+LZZsDBx1sC9PBDLazr0fjPksVmVk6SLV+r+yC2/knvzb3EihNW8a1gMj2kVfaknFn6Enpth3KNKL2EJm00NhIsvTeYITojN1R3r6aYMSAC+Ggn3VS7jgbQ76psEl9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8kAsPfC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8kAsPfC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9339C2BCFB;
	Mon, 24 Aug 2026 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787578375;
	bh=bqxr7tJMlMv9QBqyGWY6/PLr9AYldw0DmoB+D9A7GFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G8kAsPfCd3v0QZK65ZQP4KbhzUnGfCQ/YNdkoQ3WwCT14wzGj9hReIH273n2r91cC
	 hf9cQNH9FaJ/SegJFP5aGHT+oSKJgm80aw235CTOzila7GC58WdE3xJQgbnh3pLrQ4
	 WM+MOFoLPeHYdlmGlNN7hiznkG/ykacFsN7uBre0tLzM2dmmPP4vFHSrKCsef9+AAu
	 oITHQNzQTS01lFe580bdiAAWEN0TmE/7m+Sn/alE9JlaAHLvUaDxgpysh07csx+4Gw
	 0hxsbC4hK2ZL98jZpXhYDhFXcqtp0LsIjBdPRveODY9Bxf5txAk1Zdg9c8XbhyJlqe
	 ic6rZ/mqXn1rA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887D9C5DF94;
	Mon, 24 Aug 2026 13:32:55 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Date: Mon, 24 Aug 2026 15:32:48 +0200
Subject: [PATCH v2 2/2] nbd: drop stale partitions on NBD_CLEAR_SOCK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-b4-loop-nbd-stale-partitions-v2-2-9815a577cebd@amutable.com>
References: <20260824-b4-loop-nbd-stale-partitions-v2-0-9815a577cebd@amutable.com>
In-Reply-To: <20260824-b4-loop-nbd-stale-partitions-v2-0-9815a577cebd@amutable.com>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nbd@other.debian.org, Christoph Hellwig <hch@infradead.org>, 
 Bart Van Assche <bvanassche@acm.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Daan De Meyer <daan@amutable.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787578374; l=2227;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=IJsYukTCp+gKDcCUl73TRLZtzYPIPmGwnx1/NOZHD4E=;
 b=+3LKI5LgUmNDygotKLNLsRXKAEF5uxws+wjt9ChSEsGXFVqJWzbH+YSsSCGOVnRyU54fmfXoR
 ve0kGD09ernCUHrWvT8l+uWR/XeooSDOTbqrxfcNt+Ur0EoXvdUX9wz
X-Developer-Key: i=daan@amutable.com; a=ed25519;
 pk=I1l+WwrtmzRgofA5SQ1wTuJi18fjh91w+f5uRkFeZEA=
X-Endpoint-Received: by B4 Relay for daan@amutable.com/20260712 with
 auth_id=868
X-Original-From: Daan De Meyer <daan@amutable.com>
Reply-To: daan@amutable.com

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


