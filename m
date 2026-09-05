Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78A3C2D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566697; cv=none; b=kNH3ZEIdXqa+34JE7VmgiIgvbYEyLLcEyS5iPWBNe4tYJpzdqtLm/R+OPIkKXM2FQrsT04DHXC57athS/Ilagmz6ZpJ2HSpvfIQPBkq4bB1mAD5sLRNwDK0SFYxqCnzlGY8rmkaA/i+wO7Cy3edsQEGaAEzqf+Y5BVv2kkBXH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566697; c=relaxed/simple;
	bh=Pq02RwUMpsN7ZAlw6QEXdm/RXewlgajGp+8BdvN7MW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njCeexfK6ObaAhb3gsTzlYgisI1RQGBQYqkeHUqRi8Z8EouXRRYk5rh6sMVmbJ8N49rLhR415IV1qHcznuLMBQzYkkOVXl44Nxcj8qDnV/kHnWYn/wadFA3ofXc5XAsAc8vkO6nvGP/6IybaL+yEHHdPzLYQ4NIup8YhrPo0uTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP4AO5II; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP4AO5II"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676391F00A3D;
	Sat,  5 Sep 2026 00:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788566695;
	bh=VO14Bw0ZJ+gAroWae96tbhg4JmH7OzT2wO3S37Qtl8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eP4AO5IIVjAcaZhgEk4VzEfAOiPYvecX+KB/Nv4H4VR2DDkzLt7xYMkNhnwkn3fhJ
	 NQo7QdVENAJftOvuitMDeutnVFny77OKwn9oeKj6QwXrIWvvBehR8hOBpPAynYGgUx
	 GuFBX7N803cjuXDRgr33Ax1XrsqNiKpkj+VaF7daEYPyTi26iyWoUt3cku8kCwzGez
	 +oSvVGf9viafYM9KrWX+IFRjJW/YHt+2BPvwrbeUY46qKYxK0DGxl+/gcOcusk/gJO
	 BtJ/Ce7+9cRRACSBYXTNIanZoTTePY7p+B5rmvJ5hDClvjKY06bepeGDCuLIWVX7Y8
	 WWS6rwI+hKODA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	David Stevens <stevensd@google.com>,
	Minchan Kim <minchan@google.com>,
	Richard Chang <richardycc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] zram: switch to guard() for init_lock
Date: Fri,  4 Sep 2026 20:04:51 -0400
Message-ID: <20260905000452.1656571-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090323-reflux-devoutly-8bce@gregkh>
References: <2026090323-reflux-devoutly-8bce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 0d38260c2a11de147f0c4701b344fdfa6bcdd04c ]

Use init_lock guard() in sysfs store/show handlers, in order to simplify
and, more importantly, to modernize the code.

While at it, fix up more coding styles.

Link: https://lkml.kernel.org/r/20251201094754.4149975-7-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: David Stevens <stevensd@google.com>
Cc: Minchan Kim <minchan@google.com>
Cc: Richard Chang <richardycc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

For the 6.12 stable backport, retain only the zram_reset_device()
conversion needed by the follow-up fix. The remaining upstream hunks
apply to zram paths that have significantly diverged in this tree.

Stable-dep-of: dde75313eed0 ("zram: set default primary compressor in zram_destroy_comps()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cf3c789945b41..e11f0ff18012a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2173,7 +2173,7 @@ static void zram_destroy_comps(struct zram *zram)
 
 static void zram_reset_device(struct zram *zram)
 {
-	down_write(&zram->init_lock);
+	guard(rwsem_write)(&zram->init_lock);
 
 	zram->limit_pages = 0;
 
@@ -2189,7 +2189,6 @@ static void zram_reset_device(struct zram *zram)
 	reset_bdev(zram);
 
 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
-	up_write(&zram->init_lock);
 }
 
 static ssize_t disksize_store(struct device *dev,
-- 
2.53.0

