Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F984A49B9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440829; cv=none; b=JrIV5EBYs9NiCPPZQOLg62iskMWrJKaj316GqKrKRs6nZeZAJpY3ftTYnN92gp9FVI0CkhBHvI8o/h2TutuCo1phho7WE7MUx6FQ8zDLWrWzbAQNiSXspwCj0vsOhFPEX84l9116q2VPgCyIH7qteyWEdcyjkQ1sU+qafqA+Mgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440829; c=relaxed/simple;
	bh=EqzGpzUgC4jtaggZti3/8k4Zdbb7AJ+v6BXWfd5Xuqc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qwMYCL1RbQEhUaeS3QJp5dOkgRG0x25iC5Cf/YxImewn603EwbvPDwkwcP6khwcIPdWRsHoads0tWayj+mS/S2weesd+VORT21Yl65jTrs+RJ89VUopPl1IBpruYRYeNtZbm133q8bMMOCYpIrIA+UTATH1QptAzEwuuG76Drcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N0hq9mw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0hq9mw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651391F000E9;
	Thu,  3 Sep 2026 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440818;
	bh=IHmanfKmx0NQz97qsUK4vk53aOxHijvro7ZPB0jrDXE=;
	h=Subject:To:Cc:From:Date;
	b=N0hq9mw+Ul+NNdSGllrUgi/RUR6tqZk96xt7chBHul4vpAHDPcEI6Nnpu+T/T3voG
	 S2zNJ6gcgMmaM0FKEhqU+dz8keDSRHbFntjx6/5858s6pfPGwYkhWg1rk0+Yw+Anfv
	 WG5G0RTsjnvft/tNXEza+SAbh0qM0vyA4Dqh/RYk=
Subject: FAILED: patch "[PATCH] zsmalloc: account for handle size in class lookup" failed to apply to 6.6-stable tree
To: xialonglong@kylinos.cn,akpm@linux-foundation.org,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:01:49 +0200
Message-ID: <2026090349-deniable-copilot-d36a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f7bf5cd5b5f2b13fe2361860880c4e214c08b440
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090349-deniable-copilot-d36a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7bf5cd5b5f2b13fe2361860880c4e214c08b440 Mon Sep 17 00:00:00 2001
From: Longlong Xia <xialonglong@kylinos.cn>
Date: Sun, 9 Aug 2026 19:55:18 +0800
Subject: [PATCH] zsmalloc: account for handle size in class lookup

zs_lookup_class_index() lets zram recompression decide whether a newly
compressed object would use a smaller size class.  It currently classifies
the payload size directly, while zs_malloc() adds ZS_HANDLE_SIZE before
selecting the class.

This makes lookup disagree with allocation near size-class boundaries.
With 4 KiB pages, CONFIG_ZSMALLOC_CHAIN_SIZE=8, and 64-bit handles, a
1025-to-1024-byte recompression appears to move from class 64 to class 62
although both allocations use class 64.  Conversely, a 1049-to-1025-byte
recompression appears to stay in class 64 although the allocations move
from class 65 to class 64.

As a result, zram can accept replacements with no allocation benefit or
reject ones that would save memory, potentially marking the object
incompressible.

Factor size-class selection into lookup_size_class(), account for the
handle there, and use the helper for both lookup and allocation.

Link: https://lore.kernel.org/20260809115518.3791787-1-xialonglong2025@163.com
Fixes: 7c2af309abd2 ("zram: add size class equals check into recompression")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 8204b76f7830..825022a7a328 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -552,6 +552,11 @@ static int get_size_class_index(int size)
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
@@ -1117,7 +1122,7 @@ unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size)
 {
 	struct size_class *class;
 
-	class = pool->size_class[get_size_class_index(size)];
+	class = lookup_size_class(pool, size);
 
 	return class->index;
 }
@@ -1407,9 +1412,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
 	if (!handle)
 		return (unsigned long)ERR_PTR(-ENOMEM);
 
-	/* extra space in chunk to keep the handle */
-	size += ZS_HANDLE_SIZE;
-	class = pool->size_class[get_size_class_index(size)];
+	class = lookup_size_class(pool, size);
 
 	/* class->lock effectively protects the zpage migration */
 	spin_lock(&class->lock);

