Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E270399372
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902352; cv=none; b=icCYBkGs9VrMD5n/LaIBt6AdYmx3SvBoZ5cyRSf7h4m7/kr+j102BnKWArsun61WMtBqgD1UWxkmxeG9Ek6SGj8LMT1dmp8366vXuVgYX0y+LZThdIHpCeoAlSo8ERhFXs9TgF1OPD5eteEKEElzH4ONGY7QwanyJgkVBvuglcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902352; c=relaxed/simple;
	bh=+DoKu9AqbiyYeOx7qu96oenwsdqRMtbCnGeWzlsfMlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdOJdZE9bmXW41nq5DIJIFTnMkUr/tkutRNx6UL795FO0gB/YjE9JaMbcc7PGIQt2W0NJxZ5ejuzFDkx89GlOfu2HeLjeIWoyDH0rk1xuk7LcFkfXypeRILU/1DTJRRm/srBwVbpl0BItjg6vgnniHPoOLp44c86aC0yn/DQii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdjXBP1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdjXBP1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDC21F00893;
	Tue, 13 Oct 2026 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902350;
	bh=3ucvozH4bBthCViaDI3Zv42KNopsgT4zACujCzfsHxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fdjXBP1hXZwkSzKsieri7ONcV+ST33DSPgjEBHh0QXzR/be4mZWfdpsr3Ifc70Ei5
	 fqwEQYSy27j75G+Sro7xu+FJT5cKaiLQqmrJSRc/FoWTbXXRhFT0jg/S3jbwM4MyBF
	 5kCJQ4YkbtA5l0t1ndZR28a6Pdv6nQMdBs9M4qZK4ryfo/+//lGNzkqT988r2XTjZY
	 Gzo6PEoK5Ra7viq0zs/D/J78woFljl0Bb4A6wZIu8P6c80fKej0qQvGuycDrP9yeKg
	 7YwTq2/PhBuyqdYZAJseprAwOJ1x3WvzgHmFwucMfWtXgr7fXvPNEcvcBdf1xESztS
	 a+T157taQb2mA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	syzbot+bdff1ecf726d2af66afd@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dm: fix reading free memory in do_resume
Date: Tue, 13 Oct 2026 10:39:08 -0400
Message-ID: <20261013143850.4044093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101223-profusely-doorframe-dbf3@gregkh>
References: <2026101223-profusely-doorframe-dbf3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit c9417c1c5269e2bd0570fbe53e4ec03a8d31f008 ]

When do_resume calls dm_table_get_mode(new_map), the call is done without
holding any locks (it only holds a reference to the md). It may be
possible that another concurrent ioctl on the same device will swap table
after dm_swap_table and before dm_table_get_mode. In this case,
dm_table_get_mode(new_map) reads freed memory.

This race condition was triggered by syzbot.

This commit fixes the race by reading mode of the new table before
dm_swap_table. Note that new_map is also passed to dm_ima_need_measure,
but this function doesn't attempt to dereference it, so this call should
be safe.

Note that this is not a security bug because only root can trigger it and
the commonly used tools such as lvm or cryptsetup do not call the ioctls
concurrently, so that they can't trigger it acceidentally.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: syzbot+bdff1ecf726d2af66afd@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
[ sashal: Replaced blk_mode_t and BLK_OPEN_WRITE with fmode_t and FMODE_WRITE. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 4cfdd50e32d70..57d0bc1545b73 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1166,6 +1166,7 @@ static int do_resume(struct dm_ioctl *param)
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
+		fmode_t new_map_mode;
 
 		/* Suspend if it isn't already suspended */
 		if (param->flags & DM_SKIP_LOCKFS_FLAG)
@@ -1193,6 +1194,7 @@ static int do_resume(struct dm_ioctl *param)
 			}
 		}
 
+		new_map_mode = dm_table_get_mode(new_map);
 		old_size = dm_get_size(md);
 		old_map = dm_swap_table(md, new_map);
 		if (IS_ERR(old_map)) {
@@ -1205,7 +1207,7 @@ static int do_resume(struct dm_ioctl *param)
 		if (old_size && new_size && old_size != new_size)
 			need_resize_uevent = true;
 
-		if (dm_table_get_mode(new_map) & FMODE_WRITE)
+		if (new_map_mode & FMODE_WRITE)
 			set_disk_ro(dm_disk(md), 0);
 		else
 			set_disk_ro(dm_disk(md), 1);
-- 
2.53.0

