Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A506E3AFD1A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547503; cv=none; b=MXROW6K3WrS407bErwo0PfnmAbJczJyti0kPyjzMtk3j6AZ0VbsPBWvFuV4tHzq0rQs4kKiRneooSoOumJK/y8dj9hHojx1zPIszU6S7bAYidvn6BVDtpq5WzeSv/p7lDlO3keoDrrmQiZB1BZ5/wpahi+Qpy0Lo+DqPCzhKlj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547503; c=relaxed/simple;
	bh=ge2+9hNBQ4+EN32vzKc048EJMk+dj8nDdx0vDr9ky28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt72h1fdpKwWVdRYYA88AYgdsPLDJswJmuOgQnaDYZziyAalxNJV3yF4qW+FeOpzYE4RQfSkLdD0GGpjq+VqvDlSr5h+nGwizEk9CS3RxNvjYzein2YxVEIOmaXxbRABx+vXMSTDGLiZjeTTW6t3aJI+VPEU9Wx9QoeSTWAYjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPqUX7Hh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPqUX7Hh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF931F00A3E;
	Fri,  4 Sep 2026 18:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788547502;
	bh=h2FxEchpuU+eyPrMDnnc3VMDhOJbr8avwtR3jT+lb/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LPqUX7HhzWs5AQzIHoeltfVQ/UJ0y1wDszgyNMdGtwS0R85ga7tFHLnIgyz422W89
	 XX1TCtjKSCDmZp8OmlhReFkzbltoqTFOXgYm96dijO96Y+k4F15FSsekpWn1WtsMBw
	 OWusfYza/Z3XSDVvAfrdqpiMdD4jZohlkKqo33Z/vmsAe2QAp7u5q+8CjhomF0M7Ds
	 vOvDR+oeNoZedwyDbNd+CXUdcgOFkZ/h3eHPdvw9eFRA1TAGkbcRQrJyCwxYv1kLfy
	 XzGcV+IPHaakfG+9kfhudVJyB+ZpGMpySBPkgrEmryTAmlWo1RvtI0RflDJmx58Mnv
	 d4Eq0OxutxA7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Mason <clm@meta.com>,
	Brian Geffon <bgeffon@google.com>,
	David Stevens <stevensd@google.com>,
	Minchan Kim <minchan@google.com>,
	Richard Chang <richardycc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] zram: fixup read_block_state()
Date: Fri,  4 Sep 2026 14:44:58 -0400
Message-ID: <20260904184459.1345418-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090354-deafening-decorated-22e7@gregkh>
References: <2026090354-deafening-decorated-22e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 8b05d2d8af817c6a1e23032df51e7ad83030d543 ]

ac_time is now in seconds, do not use ktime_to_timespec64()

[akpm@linux-foundation.org: remove now-unused local `ts']
[akpm@linux-foundation.org: fix build]
Link: https://lkml.kernel.org/r/20260115033031.3818977-1-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Chris Mason <clm@meta.com>
Closes: https://lkml.kernel.org/r/20260114124522.1326519-1-clm@meta.com
Cc: Brian Geffon <bgeffon@google.com>
Cc: David Stevens <stevensd@google.com>
Cc: Minchan Kim <minchan@google.com>
Cc: Richard Chang <richardycc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ Stable tree note: The ac_time conversion described above is not present
  here, so retain the ktime_t conversion and microsecond output.  Move the
  timespec64 temporary into the scan loop instead, allowing the follow-up
  bounds fix to move nr_pages initialization under init_lock cleanly. ]

Stable-dep-of: 391f057f44a5 ("zram: fix out-of-bounds access in read_block_state()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a9f71b27d235a..d1f4b61509a0c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -886,7 +886,6 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	struct timespec64 ts;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -901,6 +900,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
+		struct timespec64 ts;
 
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index))
-- 
2.53.0

