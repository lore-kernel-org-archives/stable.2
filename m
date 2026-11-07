Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047852;
	b=CA4+v/YypGrkphp7+ItkWNxGMN7k06zQ6vyJ1KuGJN4aoIIGaQdyEciZOiXjxQHhwV+3
	 2mu5HNWwSch7T6SV5e+yIilk0AUN0esuzUadydgnqDGN7CTmpfYuuWAcuFPqFsMPPg94i
	 4HUbAER9epjGqAaS1ySAL82mNU48/8+Yv+4TdcBLEv3SSW0Yj3WuEoVLxEGr6VVwDKvUa
	 jZuLNvIpauM8Yo2+ytG1fhDdjyYsJIw51EGP1ARmsQ9qhxWmAoKl+V3wSvz4edGLkCsWg
	 eA/wsZrwc1k7mpbJa88tWCEpv4mSYL1OOSX3HIXxcMxZfv5k6HeWncTRIo3WLu6duWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047852;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Uw2m0fr29l0fnuVIythc7s38rMDEDdkMDdotGAbdE/A=;
	b=spLDrLq+Scpz99LVBZEXMRh2k0v1VY9qpLb7qUBIO4ercu2z+LyCL63V+X9aVfsvKHoj
	 qKZgMygsSYb6l3C1X6azHyMmAzonaEkp/U5eGKrIUvznZM4NshgQ+l4BwI/YWvovo9rXw
	 rOJheTjy2mnu9AdcTR1X6wYNHebveMlntu2epihfe2aNszHyfSHdmWWrVfe3VklSVDMe1
	 KngRTivYHLs9vcptnlyMxqrG9Hpb3Sz9YJIB9P7fviWFsKzA3XsjRBDbW2Koi60woXDnw
	 td9z9Q87RYzQ90Or99MAd5TEZEYuNfWj+mswrgnesqvRBuKoLdxoLELkufUREor1yWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6i2PIZq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53780606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6i2PIZq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21181F0089F;
	Sat,  7 Nov 2026 10:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047852;
	bh=Uw2m0fr29l0fnuVIythc7s38rMDEDdkMDdotGAbdE/A=;
	h=From:To:Cc:Subject:Date;
	b=K6i2PIZqoG4JC9djzZLC3ROmD48wdFASTF5+ahyQ7648oWH/9qR079ua3JlbL9plj
	 STBT66n8GKkOuIJ3fHeIzg86c3FQPF20Ih6Zj1EZVEaLL6V2wClqopH3XRRhRcUgcq
	 KWE5pm1dIK/HQD/Pblbf5UZUDl09HXRc5ZlHwktBAzTE7tNZJXyqzSP+5PuQKXSfhZ
	 kx7zWgmbvJHQfsYcEMmGYL4MuVgXwPUSqcGdR2Ffzar3so4357+rfg1P3lwj6XlHLt
	 sJdzuuz+IUotJOfz0Trtp6S1mJHJivdhUzj/IrXWUPKAXJ6Of2RyA+FVElRG73ENsB
	 kzvLGfnVQaoGw==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: zone: fix to don't fail to grab GC target block on zoned device" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:30 -0500
Message-ID: <20261107053730-failed-6.6-fd106ada4dee@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fd106ada4dee4b8adefec791ee9b9681b7b77501
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053730-failed-6.6-fd106ada4dee@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fd106ada4dee4b8adefec791ee9b9681b7b77501 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 19 Oct 2026 09:00:32 +0000
Subject: [PATCH] f2fs: zone: fix to don't fail to grab GC target block on
 zoned device

With out-of-memory fault injection (inject_type=0x0080800f) on a zoned
device, f2fs stopped checkpoint during GC:

 F2FS-fs (dm-0): inject kmalloc in f2fs_kmalloc of move_data_block+0xc0b/0x12b0
 Workqueue: dm-1_zwplugs blk_zone_wplug_bio_work
 Call Trace:
  <TASK>
  dump_stack_lvl+0x4d/0x70
  f2fs_stop_checkpoint+0x1df/0x5d0
  f2fs_write_end_bio+0xdbb/0x1320
  blk_zone_wplug_bio_work+0x2aa/0x7d0
  process_one_work+0x5c6/0xde0
  worker_thread+0x403/0xb70
  kthread+0x235/0x2e0
  ret_from_fork+0x2f/0x70
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 F2FS-fs (dm-0): Stopped filesystem due to reason: 3

In move_data_block(), the target block is grabbed from the meta cache
after f2fs_allocate_data_block() has allocated newaddr. If grabbing it
fails w/ -ENOMEM, recover_block calls f2fs_do_replace_block() to restore
the old block address and curseg's next_blkoff, which already points
past newaddr, so newaddr is never written. That leaves a hole in a
sequential zone: the next write to the zone is not at the write pointer,
the zone write plug fails it, and f2fs_write_end_bio() stops checkpoint
w/ STOP_CP_REASON_WRITE_FAIL.

move_data_block() allocates newaddr before grabbing its meta page and
goes to recover_block if the grab fails since commit 4356e48e6437
("f2fs crypto: fix incorrect positioning for GCing encrypted data page"),
the meta cache only replaced the meta page w/ a meta cache entry. That
is harmless on a regular device, but it leaves the hole since f2fs
supports host-managed SMR (now zoned block) devices, which only accept
writes at the write pointer of a sequential zone.

If newaddr is in a sequential zone, grab the target block w/
F2FS_CACHE_NOFAIL, so nothing can fail between allocating newaddr and
writing it. In a conventional zone or on a regular device, skipping
newaddr is harmless, so keep the error handling for them.

Cc: stable@kernel.org
Fixes: 52763a4b7a21 ("f2fs: detect host-managed SMR by feature flag")
Fixes: d1b959c87702 ("f2fs: Check zoned block feature for host-managed zoned block devices")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 18aa6a12e805d..5b948c92f9813 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1453,8 +1453,16 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		goto up_out;
 	}
 
+	/*
+	 * If newaddr is in a sequential zone, it must be written once it is
+	 * allocated, otherwise it leaves a hole in the zone, and the following
+	 * write to the zone will fail as an unaligned write, so don't fail
+	 * here.
+	 */
 	tentry = f2fs_grab_cache(META_CACHE(fio.sbi), newaddr,
-					F2FS_CACHE_LOCK_CREATE);
+			F2FS_CACHE_LOCK_CREATE |
+			(f2fs_is_sequential_zone_area(fio.sbi, newaddr) ?
+			 F2FS_CACHE_NOFAIL : 0));
 	if (IS_ERR(tentry)) {
 		err = PTR_ERR(tentry);
 		f2fs_put_cache(sentry, true);
-- 
2.53.0




