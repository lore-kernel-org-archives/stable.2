Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225BE4BD359
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902851; cv=none; b=hTwXPY57moS778t/ElJbntF5D1VYmjU9RAADoyMaSapeEH7XY8COL2lXHn7L2ZZ5ds/15ReCNSew6/DMqaxEigvdv/J124q7g9NQMP+p4MrLjP0g5NueUYXk8uB0iIMs3NY4F0fKbt2YbExtxWwS0jOJUpteaJLpF88Z1CwtLw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902851; c=relaxed/simple;
	bh=rOF7FapUimfcfmUM6NCWMWYnNiEeelJnBr4hbjPXndw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPCzMec+ez8vw7i48w1Y10y3dAApnVCGtofzl25cO/+9m/2Ej59+tHZMnhaOQqGi14kUaObe3AlzJvtbfWM/xn3FNTRx70WX9TZ484wNG7mQo4EtpoH01UrDIMIXu/LmjsGEm/Ku4HALrpQHnbLKKW6qFIHbYLND18xNT5hrhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H99FbGJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H99FbGJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805901F000FF;
	Tue, 13 Oct 2026 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902850;
	bh=P9WNdpy1FL0d7m+kIBXwi1956uHSjh3tBsIxy4wilWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H99FbGJh1j9ipikGudXZY5Pld9G1NyHgJZPEfDt8YOncUkfp5U5TTm1h5zFwXM5HS
	 piiTPtJkU81Rr4vFAcUCRM+q2EGzPa2aTfISNKxCm8eZKgL8XxNdXVQUsQTNlP6GCP
	 wyTbEIsOqu3dYVjQS8hrns0qXU4+sTu4lSeSviLQ2kZFKes03Tf/Dex9rha6eNSsIr
	 s5UQFthwxmUAizdg8HahHxMVg9f2298a1lLsg7AkgF+0daQpmR1Hq0/FYwfmbnV1U0
	 LUL7WZxQU4mWO+75J3M1SWDkwg1MFm2qz3UiP2pVZLiZPUVCYFU/RMVERlnNmD8vyk
	 lB8Q9+P8x84uA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	syzbot+bdff1ecf726d2af66afd@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm: fix reading free memory in do_resume
Date: Tue, 13 Oct 2026 10:47:28 -0400
Message-ID: <20261013144710.66437-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101223-trinity-renewed-a2ca@gregkh>
References: <2026101223-trinity-renewed-a2ca@gregkh>
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
index 2c1e6eb93b787..816b9527394cd 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1151,6 +1151,7 @@ static int do_resume(struct dm_ioctl *param)
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
+		fmode_t new_map_mode;
 
 		/* Suspend if it isn't already suspended */
 		if (param->flags & DM_SKIP_LOCKFS_FLAG)
@@ -1178,6 +1179,7 @@ static int do_resume(struct dm_ioctl *param)
 			}
 		}
 
+		new_map_mode = dm_table_get_mode(new_map);
 		old_size = dm_get_size(md);
 		old_map = dm_swap_table(md, new_map);
 		if (IS_ERR(old_map)) {
@@ -1190,7 +1192,7 @@ static int do_resume(struct dm_ioctl *param)
 		if (old_size && new_size && old_size != new_size)
 			need_resize_uevent = true;
 
-		if (dm_table_get_mode(new_map) & FMODE_WRITE)
+		if (new_map_mode & FMODE_WRITE)
 			set_disk_ro(dm_disk(md), 0);
 		else
 			set_disk_ro(dm_disk(md), 1);
-- 
2.53.0

