Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7711E51FCA3
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546943; cv=none; b=lvH10rjRBMdjBxwuRokEqRBa33XW2Q9cwV++OrphzWOik7OLyI7VFJ0N8HXuy8NHbe5bk/RKIekRPHKjffNidtNcESm+bU7S5JxQOuGEg9enPhcsf3h7filgE/slYKS9UNL0eS2+kaRUS4+Lhu83yjS3hs8ZYZsQP1UyEmmByNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546943; c=relaxed/simple;
	bh=65qspm8/guh+kL2hsC+RpGmjMWhULcNeG6qBd5nCGpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7rWipeyvaaoIkgyA4IEqg1oBB0O3i6bnsHmxx+/WAu1cfs7sdZRr/G1zntzBG172fuj6qmYCcr6PCYNz3G1k+3ee9dfminAPRbWaFb8aHtNDlL6E2HyCbGgP9FmNFOJVdY+XOnorPG0aD68rbWsYebsOaA13GJ07CblS+1zO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIj1UuhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIj1UuhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E371F00ADB;
	Fri,  4 Sep 2026 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546935;
	bh=eeYGFAshXMnaYqe4C3Zc3m9IC3Yob4GreiPltvIMjSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hIj1UuhMyRNa9cIMUtLZpZ3h9MWFaHYMwYCApUY0hQTkB7PWxtVg6xywoGIIs1yPu
	 3aJooNvuchFRsl1jfs08OatNlGHzDZAnOsapTypcjFLgUu31NdP3WERpUScrsvY5wt
	 8pIIonE9DTpZtx/y61LN8SScfNKuWq8XfE8YFBBFsxzK+WAE2oHteu33JaGcPRDfU1
	 uKq6RW9hKUattdbko7huP14eUbpCCG10nJJFMvgQynL67LKZ+lIaY8747BqMme4W/I
	 pjzK3ZsNYhdK+tvpTFbi/wiZH1iqq4eUyj+puFK56E5UfPtuYo30vxZwRA7aq1CUMU
	 orGJer7N2VFkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] zram: fix out-of-bounds access in read_block_state()
Date: Fri,  4 Sep 2026 14:35:31 -0400
Message-ID: <20260904183531.1325433-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183531.1325433-1-sashal@kernel.org>
References: <2026090353-upstart-iron-3320@gregkh>
 <20260904183531.1325433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Longlong Xia <xialonglong@kylinos.cn>

[ Upstream commit 391f057f44a51cc9418da5cba78b014324174264 ]

read_block_state() calculates nr_pages before taking dev_lock.  If the
device is reset and reinitialized with a smaller disksize before lock
acquisition, nr_pages still describes the old table.  The subsequent loop
can then call slot_lock() past the end of the newly allocated table.

Read disksize after acquiring dev_lock and checking that the device is
initialized.  The read lock then keeps the table and its bound stable for
the duration of the scan.

Link: https://lore.kernel.org/20260804065919.3970386-3-xialonglong2025@163.com
Fixes: c0265342bff4 ("zram: introduce zram memory tracking")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index de5533fadc675..740ca88bb6733 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -903,7 +903,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	char *kbuf;
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -916,6 +916,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		return -EINVAL;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
 		struct timespec64 ts;
-- 
2.53.0

