Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6C380FCE;
	Sun,  9 Aug 2026 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786276569; cv=none; b=lMB74eaeuBBzCq5Oju9G25IuBx4weFxriuwybFqo5IU4L8XRqPO+kGqx8Y5Z5lh9lmKYfLhKmf1rZJg6n5Pjp2LXynf1Ivxohoj+XgqsyAD3G1SSzLat/dcw2cxm3jgZ7N0rMJkDnuy8kAyxnGTXLFqtvZhClRlJ9juJWskxR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786276569; c=relaxed/simple;
	bh=CyDBYtC/2EGnsRYdVzMpaDTGiofUQY5UUmjyaZADhgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mfinsvt1d4xBhs0OHc/AKcF4SM5In5jgWlzKEnsWD2rJcYfWoyatTY932JNo3A9HVOqkBroqM9SeEQ0DuBv4ZQa95Vh+SKnRySE3jIAkWixi9gWX3PaHflLqvveHhEdwoLzHYRE4gCBNkSZdf3sEOmBtGWN6wdsY+LEw+2VA+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XA02xsgb; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XA02xsgb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7J
	zxgtsTDUoR0wIQZpzPj4WqrX4aVTLG8zDY2f63lEw=; b=XA02xsgbMqUxmSXwx/
	7DpIUMxNgzPQJVnA2iAcq/2pbWte18lwpEAQMFnWyaHiurbPUNGrqQyC6HQqZDYl
	lsWZvmyjthlz1HMWHeRRINrmP327Sfdlu4C2eN/CR10LurDH0GVYz3Dr+RMjqAmS
	SGV0ohOHAtgjYZYQZMnx7yMsA=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCnD5ShanhqmevnOg--.50263S2;
	Sun, 09 Aug 2026 19:55:14 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] zsmalloc: account for handle size in class lookup
Date: Sun,  9 Aug 2026 19:55:18 +0800
Message-ID: <20260809115518.3791787-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnD5ShanhqmevnOg--.50263S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyxKFykKFyUKw43Ar1UZFb_yoW5JFW5pF
	47Ga48KrW5XF409ws7Gw4qkayfCw1xGF47JrW7tw1S9ryrXr1xtry2gr9093yUCr4DJa45
	WFZFyw15Aw4DCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrL05UUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC2wJ7dGp4aqKvPAAA3f

From: Longlong Xia <xialonglong@kylinos.cn>

zs_lookup_class_index() lets zram recompression decide whether a newly
compressed object would use a smaller size class. It currently classifies
the payload size directly, while zs_malloc() adds ZS_HANDLE_SIZE before
selecting the class.

This makes lookup disagree with allocation near size-class boundaries.
With 4 KiB pages, CONFIG_ZSMALLOC_CHAIN_SIZE=8, and 64-bit handles, a
1025-to-1024-byte recompression appears to move from class 64 to class 62
although both allocations use class 64. Conversely, a 1049-to-1025-byte
recompression appears to stay in class 64 although the allocations move
from class 65 to class 64.

As a result, zram can accept replacements with no allocation benefit or
reject ones that would save memory, potentially marking the object
incompressible.

Factor size-class selection into lookup_size_class(), account for the
handle there, and use the helper for both lookup and allocation.

Fixes: 7c2af309abd2 ("zram: add size class equals check into recompression")
Assisted-by: Codex:gpt-5.6-sol
Cc: stable@vger.kernel.org
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 mm/zsmalloc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 83f5820c45f9..41b03a9ecec2 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -478,6 +478,11 @@ static int get_size_class_index(int size)
 	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
 }
 
+static struct size_class *lookup_size_class(struct zs_pool *pool, size_t size)
+{
+	return pool->size_class[get_size_class_index(size + ZS_HANDLE_SIZE)];
+}
+
 static inline void class_stat_add(struct size_class *class, int type,
 				  unsigned long cnt)
 {
@@ -1021,7 +1026,7 @@ unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size)
 {
 	struct size_class *class;
 
-	class = pool->size_class[get_size_class_index(size)];
+	class = lookup_size_class(pool, size);
 
 	return class->index;
 }
@@ -1311,9 +1316,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
 	if (!handle)
 		return (unsigned long)ERR_PTR(-ENOMEM);
 
-	/* extra space in chunk to keep the handle */
-	size += ZS_HANDLE_SIZE;
-	class = pool->size_class[get_size_class_index(size)];
+	class = lookup_size_class(pool, size);
 
 	/* class->lock effectively protects the zpage migration */
 	spin_lock(&class->lock);
-- 
2.43.0

