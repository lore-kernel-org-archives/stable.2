Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B2429827
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950408; cv=none; b=DvqtgVTwxWjvg8v8klD/Ha2hyNPuRKR/cR8OHiL//hacs4NPCq7140RIJYwv80qKY7WNRVpHEWTs0qnwzylF72ZHaJJUvubkRFA4AYIqTqZq23mB75jXyrveQ27Yan2UPC7s4ZUbZYcBreW0iXZBaZ62vSFJ5HrTIaNvwW2AL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950408; c=relaxed/simple;
	bh=OaPZS0j9EQ45eZPvsBdH8qtOBXSNe5+kvJyyuy/zPig=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WLi7f4zywnMpaN743wzE66XLuOCuhepkPmOD6Wmv8QaaIdDdmusq/QjZqd8tDtXz4zhmQRBtn1H6Z97POK9xhyhwoQ6XD02BhnCjhBswQNRjJYOUTMANoy87POtGbJWAWcB2rIEXoZeri7SSpS5Q+jwoU+/B35yaaQstAnMF/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l2DR9TkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l2DR9TkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307861F000E9;
	Mon, 13 Jul 2026 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950407;
	bh=iUQzt8hMfSMXKjgDboSiAalc1vcy5UE8zy8bAa08aK4=;
	h=Subject:To:Cc:From:Date;
	b=l2DR9TkK3cJ6VHlXSByWze2LB/W253nWqYNl6ef41jllXm9DIgc9kKGLNAhUc/Yyw
	 bcGnPltT3SCujjEEq06/7b0z3C+3qUgRjQjQvKoK7VUDnB0nUIyJ7gvZC6qgKX7APn
	 pISb9CuF28C4dMzRYvB3SWQ2iSExXGAyRNetv+Ko=
Subject: FAILED: patch "[PATCH] mm: shrinker: fix NULL pointer dereference in debugfs" failed to apply to 6.1-stable tree
To: qi.zheng@linux.dev,akpm@linux-foundation.org,david@fromorbit.com,muchun.song@linux.dev,roman.gushchin@linux.dev,stable@vger.kernel.org,zhengqi.arch@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:42:40 +0200
Message-ID: <2026071340-handed-risk-625c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e30453c61e185e914fde83c650e268067b140218
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071340-handed-risk-625c@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e30453c61e185e914fde83c650e268067b140218 Mon Sep 17 00:00:00 2001
From: Qi Zheng <qi.zheng@linux.dev>
Date: Wed, 17 Jun 2026 17:00:52 +0800
Subject: [PATCH] mm: shrinker: fix NULL pointer dereference in debugfs

shrinker_debugfs_add() creates both "count" and "scan" debugfs files
unconditionally.

That assumes every shrinker implements both count_objects() and
scan_objects(), which is not guaranteed.  For example, the xen-backend
shrinker sets count_objects() but leaves scan_objects() NULL, so writing
to its scan file calls through a NULL function pointer and panics the
kernel:

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
Call Trace:
 <TASK>
 shrinker_debugfs_scan_write+0x12e/0x270
 full_proxy_write+0x5f/0x90
 vfs_write+0xde/0x420
 ? filp_flush+0x75/0x90
 ? filp_close+0x1d/0x30
 ? do_dup2+0xb8/0x120
 ksys_write+0x68/0xf0
 ? filp_flush+0x75/0x90
 do_syscall_64+0xb3/0x5b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The count path has the same issue in principle if a shrinker omits
count_objects().

To fix it, only create "count" and "scan" debugfs files when the
corresponding callbacks are present.

Link: https://lore.kernel.org/20260617090052.27325-1-qi.zheng@linux.dev
Fixes: bbf535fd6f06 ("mm: shrinkers: add scan interface for shrinker debugfs")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index cda4e86428c8..cafb56630132 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -183,10 +183,12 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	}
 	shrinker->debugfs_entry = entry;
 
-	debugfs_create_file("count", 0440, entry, shrinker,
-			    &shrinker_debugfs_count_fops);
-	debugfs_create_file("scan", 0220, entry, shrinker,
-			    &shrinker_debugfs_scan_fops);
+	if (shrinker->count_objects)
+		debugfs_create_file("count", 0440, entry, shrinker,
+				    &shrinker_debugfs_count_fops);
+	if (shrinker->scan_objects)
+		debugfs_create_file("scan", 0220, entry, shrinker,
+				    &shrinker_debugfs_scan_fops);
 	return 0;
 }
 

