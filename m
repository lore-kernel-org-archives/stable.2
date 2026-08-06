Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002E43F4D7;
	Thu,  6 Aug 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012636; cv=none; b=tt8GyEKqhyokU6kFupgokox7CQ7seT4o2Ls+LKclneUPv79Hyvo/BrbwXZk4vY7+MBVZWDFKwhmtwy0CNKQjVkOBPXN3vVeKGFQSWOAYyhOnwhGySV7rkyO6r4Dr0mN8S8pqA8eH/IApmUTP/kwA05b5TA/EVrTxmB63R7JqMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012636; c=relaxed/simple;
	bh=2UN5bVSsLcRwVZBbPTmNXh9Gzb+lT78X32fNrSgsuGY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BoQfv0bAiOQ1WDE2UFnwZiI1mAjmm8Wvu0OlQOUaytiyOMeW3NaJDRnZWwdY4612BkVCSPjfMcNKIDP0qCL0MIcjmJaPOYwF1B/OgoEex0STdMEilTiG6o9GchRFUJaZReZTUTqzvFB8Ah1vcMleIdnwHg2oZicLlc7lvxU0s5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXEqN6Id; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXEqN6Id"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04E56C2BCB9;
	Thu,  6 Aug 2026 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786012636;
	bh=2UN5bVSsLcRwVZBbPTmNXh9Gzb+lT78X32fNrSgsuGY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qXEqN6Idv15p9VSWtgMtXUbK5kcyOVTQ38rxE7ys8Pz3Y2V87MjRLkXYQ7PtUa322
	 dvdPqInUdDh3eI5IgWVcw1mr+GeimMyHrJ5KPJpOVhENd3pacBvmncMgeXuTUdcz3U
	 4Oj6M+En5cRQ75hh45XhCs/iAzhocLEclk8oH1R82Dm1p3ISxq2u4xpTqkuwWliVHP
	 oI1Wfw1JY+dmhUqWdpJBo/02lR6j3ChGCcoCZH/5ia12gsVuQPuWlIs8tQ86Nzv7nN
	 NQ96eHOvLwkS64ZyxdD+gx1H2xEUUiE4fd6eT2cwHy01hyPCLHfQdvdxc5K243nJCG
	 WmjBW1tZqlcyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD3C5AC67;
	Thu,  6 Aug 2026 10:37:15 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Subject: [PATCH 0/2] loop, nbd: drop partitions left behind by the
 GD_NEED_PART_SCAN removal
Date: Thu, 06 Aug 2026 12:36:56 +0200
Message-Id: <20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1Jm7UASpIpXEReTZLQjNSmZVITSu
 5vo8n3+exsoF2GFy7BB4beo5NTAHgYIE6UHo8TG4IwbzdmM6I8457xg8hG10sy4UKlSm6foojU
 c+WTJEbTEUvgun1/+evuzrv7JofZmf3hSRl8ohalPL9LKBfb9C31TrjGZAAAA
X-Change-ID: 20260806-b4-loop-nbd-stale-partitions-2d10ede71a2a
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nbd@other.debian.org, Daan De Meyer <daan@amutable.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786012634; l=2033;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=2UN5bVSsLcRwVZBbPTmNXh9Gzb+lT78X32fNrSgsuGY=;
 b=B9ExN1sNpe5Df1yt64T76mW0spT0jluy5FnkBH61VKFQkUJm1IvGm3x8cIY6U0ckHpYeMYX1l
 AtQnLTykOCIDTUCzrQFUOkVRf9adg3KwFx80gIjzH9oQNmLsh8gof1K
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

Both were tested with the blktests loop and nbd groups on 7.2-rc5. New
cases covering the two paths fail without these patches and pass with
them; they will be submitted to blktests separately.

Signed-off-by: Daan De Meyer <daan@amutable.com>
---
Daan De Meyer (2):
      loop: drop stale partitions on LOOP_CHANGE_FD
      nbd: drop stale partitions on NBD_CLEAR_SOCK

 drivers/block/loop.c | 10 ++++++----
 drivers/block/nbd.c  |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)
---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260806-b4-loop-nbd-stale-partitions-2d10ede71a2a

Best regards,
--  
Daan De Meyer <daan@amutable.com>


