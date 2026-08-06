Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9343DA31;
	Thu,  6 Aug 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012636; cv=none; b=aL+rkP3cjlur74pj9WOHuOqaDTytBkdLWkb5Y/EQpRoUCkE9HccvJJsiCZWHJ6K5a1OGM10C7V86aJbDSMzMLl2L92JWw3SrCslzZBnIRe2a0yGdq16KO6673QHZUePz8gpKdl08mImE0/3+A8RlwhmTeIaChAyq3pR954gaNr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012636; c=relaxed/simple;
	bh=5N4byFi48Usq0E0E1wWfeWSFfpdvFWOvoclzXvRnohY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAGHANPQNAV2HlZptHHvi2ZFmrlvOt0LPdE6tWQAzH3BebIHBiIXNd84ZpQjzphxz1FB2Eh4rwwD9P5jjffE3CvX61O0ume0XY5tUpbNSIe41RZUQjeiK5UddEO3Y7iciloU+XuWboAA6HSr95pvVxafsF9FQNWJHK/UkgaHS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUpk6/wg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUpk6/wg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 205AAC2BCC7;
	Thu,  6 Aug 2026 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786012636;
	bh=5N4byFi48Usq0E0E1wWfeWSFfpdvFWOvoclzXvRnohY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BUpk6/wg8TIzhtstcdXIAE5wrKbmeApUh5FNqhh3bDKI4b0iFMgDPs1ZoMwlFZxYK
	 523T36UXznh81o+uJynmxkKJQiTsWlnvFv9zE7QwrQdbLNlOwaC9j/QTEpyx/rCwpu
	 H/bPe+fwFUzGWqNpE0leagxyszAk1HRZRB/3YrRyTjp+2tnfZAtJoW6FyMdDlbbaaH
	 CO9njpHx9b5zQVtUCducswzJuvhckyuj7EbSAwRT89CYMZUW8DbrpMc5rrXmUKArG9
	 NlG8kmOPYWeFIQ3KBCGwskevyz6sJf5wSzIzKDEwIJkrd8xl9HjsFYkV6UUcmeD/rP
	 PofXYY+U4fziw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00123C5AC79;
	Thu,  6 Aug 2026 10:37:15 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Date: Thu, 06 Aug 2026 12:36:58 +0200
Subject: [PATCH 2/2] nbd: drop stale partitions on NBD_CLEAR_SOCK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-loop-nbd-stale-partitions-v1-2-67bb75a8d7be@amutable.com>
References: <20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com>
In-Reply-To: <20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nbd@other.debian.org, Daan De Meyer <daan@amutable.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786012634; l=2049;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=aLcawfodzvP0fJXSj8HpdGNkZURTQ0aqxMLBOWMxTBU=;
 b=FM8lQ6abSH+zQI5Z+faOY250ag+68dCCs2+lZanTrB/pXeFbfrlYyr++1nnOotORedCbB25Wi
 BG8tcLAeyPCDuYpUajgzDzZn5VKM0QQp16W6N0V9jHiLc/A0lWx8wmU
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
Signed-off-by: Daan De Meyer <daan@amutable.com>
---
 drivers/block/nbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8f10762e90ef..cdafe9d39369 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1612,6 +1612,13 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd)
 	nbd_clear_sock(nbd);
 	disk_force_media_change(nbd->disk);
 	nbd_bdev_reset(nbd);
+	/*
+	 * Drop the partitions of the disconnected device on the next open. They
+	 * can exist even with max_part zero as they may have been added manually
+	 * with BLKPG. Dropping them here is not possible as that needs
+	 * open_mutex, which nbd_open() acquires under config_lock.
+	 */
+	set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);

-- 
2.54.0


