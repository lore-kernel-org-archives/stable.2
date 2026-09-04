Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15853C1090
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538911; cv=none; b=D1v9zVlSWf9/pNiv6uoI/FNOf11wzW1fKUraAIKUEHFwtSQZEUrhfz+dJKwAhyBuEbZS+vnKFhacRnPatgy/IKXCOvlVIbpDaGrxWa00CIBJfkK0BBZhAwiLD2UMp2Ef7ONf/28EqrfXP7eDkexemrYG5gcVTYpZ9kO+0b7Hr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538911; c=relaxed/simple;
	bh=IHeu/vY8Ldi+UPDTbGtNij6eztDixVMGEyp+8zvdq3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5G5z5ME5Q9HGA/IGPM1V044QhRMo8Tn+ReiYkR5shPa6HJLlcOpfHvVRH3nQT46bi1Ww5XkfASQdeOPX3QNZMHTDE9hUU0M6AT/28uX0X/E1tmRfysoIHr6nnXdoY5UplyaS1B7TccNZ62Kr2UfA2do07LVFZbgoc5T7Im+a0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlXMLIvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlXMLIvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2261F00A3D;
	Fri,  4 Sep 2026 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788538909;
	bh=sxRns+Xv2HloLANXz/1FUaJVmohi9dz7MlfFqFYep6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dlXMLIvoyHLb6T6+WhrbSxD2dvufxsG/QpYOKOmvlm00F2iAQkDQQ/li+pBykR7vY
	 S6XHkSrT8IFMV++Cs7ybaJBPaW9SVtqBZlaCQNgSXIDiBq6Kga8zQb6VDFm6lsZNlI
	 sSrz0BVhhoNPmL7hC4zLFUP9xNJla1xrlaooThAxSbsB2olmzQhDeWlmWEzqhorV9l
	 FdDiathYkaPjSkT1PDs1ww26olRivNGRhJtMRyl+OMwvPA5/h+H0hVihYwSxbSQQvD
	 fQXzvnUu85QeWQnvpsia6gNJTcYG9cPJ/ktPBdhVX81hHv9QXHHO8Cegcj+RVhw4DT
	 aNTfxjWsXCNVw==
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
Subject: [PATCH 6.6.y 1/2] zram: fixup read_block_state()
Date: Fri,  4 Sep 2026 12:21:45 -0400
Message-ID: <20260904162146.1210685-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090353-pyramid-reanalyze-9bb9@gregkh>
References: <2026090353-pyramid-reanalyze-9bb9@gregkh>
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
index 0c422e4179ad5..91a1cec8a6e3f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -879,7 +879,6 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	struct timespec64 ts;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -894,6 +893,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
+		struct timespec64 ts;
 
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index))
-- 
2.53.0

