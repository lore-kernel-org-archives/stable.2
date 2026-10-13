Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB03F871B
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903503; cv=none; b=aqM4IustRHi1kMvWsfMw45ocl5KibvRp8krw72xRZhTYPay8B9wBdO0pAJhjIVi014mCkzsDEaYzPMvPwvVQVLs6yMBzVzdMtLzPGl6NEvrSWJLwZrNSm80lucLHehYPmObTMG9BJLgMCd1LIejgbvtsChJzbAu1VLAdHgAU3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903503; c=relaxed/simple;
	bh=WZc2u5yUu0RtNt1UDgIg2t6VDqGya6haL9QRtmGZqyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaYSiiINensEhaNLX4WLU4LrGKA5GcyEdVs8pU2zNUWk0V98nvsebz2oEDEcD4Q6G9rkDcyARKwnYhg0w0JXpf6HTIX3owV1fNtwoBKGk8MW7nBIsacupZWcr4nAlq4IS/XHSJP66r9tC51w952tTKMWBQx5J8fx14OvCPZL1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWFq1Y4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWFq1Y4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554221F000FF;
	Tue, 13 Oct 2026 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903501;
	bh=NkuW575T6MZ1UbzPH4xyfmzATYLb7dkjpFFnNkxZuw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nWFq1Y4Ovt5GdWpqtO8TJ+tlE2Maw1fFeEaYX62ytCUjE5ptlc3BFjLAR0pN6dnNu
	 RwOVCgbQe4njlZSFn3CIvc3zj6nIpm0Y+6pGKx5wlPXL1oczpP29tGchvWu8LLXN//
	 LTJDdZoTe2+pO2XvKPfNLht6Hj04D7OdcIU3RE6iTjci2Khc9PXTlPP6A5cm9wnz7z
	 iMFKYMtUYctQIpfc+NYy6oii8MKvjJRlBOgAy6IWGXHY1uossT8lLj2LKahhrwxF9K
	 bcmkULR0StgOggv2/qvJih6bPlktjCTFcVddlbXpmqMz2y+BmGxv12u+Gg2+8pmp/7
	 cilRdsSF/CsJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	syzbot+bdff1ecf726d2af66afd@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm: fix reading free memory in do_resume
Date: Tue, 13 Oct 2026 10:58:20 -0400
Message-ID: <20261013145807.90957-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101224-cough-approval-fc0f@gregkh>
References: <2026101224-cough-approval-fc0f@gregkh>
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
[ sashal: Replaced blk_mode_t/BLK_OPEN_WRITE with fmode_t/FMODE_WRITE to match the existing API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 12bc13bde0af5..d067006285e64 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1065,6 +1065,8 @@ static int do_resume(struct dm_ioctl *param)
 
 	/* Do we need to load a new map ? */
 	if (new_map) {
+		fmode_t new_map_mode;
+
 		/* Suspend if it isn't already suspended */
 		if (param->flags & DM_SKIP_LOCKFS_FLAG)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
@@ -1091,6 +1093,7 @@ static int do_resume(struct dm_ioctl *param)
 			}
 		}
 
+		new_map_mode = dm_table_get_mode(new_map);
 		old_map = dm_swap_table(md, new_map);
 		if (IS_ERR(old_map)) {
 			dm_sync_table(md);
@@ -1099,7 +1102,7 @@ static int do_resume(struct dm_ioctl *param)
 			return PTR_ERR(old_map);
 		}
 
-		if (dm_table_get_mode(new_map) & FMODE_WRITE)
+		if (new_map_mode & FMODE_WRITE)
 			set_disk_ro(dm_disk(md), 0);
 		else
 			set_disk_ro(dm_disk(md), 1);
-- 
2.53.0

