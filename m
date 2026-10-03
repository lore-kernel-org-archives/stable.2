Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E427314A6F
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033771; cv=none; b=ZQze7ozOL3/br/C9mR2FMTmB5e2277+SGqx2QdidX58StPLBWouFrjIcyRTSDM/LeqHEwfNbMsg7dCKQx0BQyQIYz+QPssT2XQFORqOMuMH/gJVSMgbxrKwDPFcWzNjAy2KDj8LyIC29TY2Aq7shuQXY6ECc8v0ZnWLoJYO3xPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033771; c=relaxed/simple;
	bh=kanH5nrEGV9rBshPi6IZ1hxQwvU1wVcijDAq3o/Dn2U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bvzF+Ww8sFxuUeTtRvsNHJUZMdU3hfd60tmdFFXcbHvbw61DxqzYGgfoUAaj5JRsJjiZCjJfzCIypanN3hJAwoBd4rLqTRxdQNk/n5aafgvCJZCmBgdyogAhcXcMWjYOptb7QtMUmfiWVYaxx2Klj0Gk/0WpPZdW2Foh8p6wWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FpQMKyCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FpQMKyCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215D61F0089B;
	Sat,  3 Oct 2026 13:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033769;
	bh=SCD8Kwh0fwE2CscVqL6WJrgfANv2lHvhiZAsjp01/Nc=;
	h=Subject:To:Cc:From:Date;
	b=FpQMKyCbdO8Qn8K8j7nRsKebgfXM/gLxaomGW+iCfvtISfSdFTDJ9Ttxy0OI6yS9c
	 WdRJLz4GYcZrTqC93DEIDF92b9dl9MVjpTNx3HBFkmWHC6j+FNUcPNZM1mhXu8nFiK
	 Pp+IxkO/u2F/W+5mqbF5I5zXNPzhg7RWXCnnaHLE=
Subject: FAILED: patch "[PATCH] mm: shmem: ignore sysfs configs for shmem forced collapse" failed to apply to 6.12-stable tree
To: baolin.wang@linux.alibaba.com,akpm@linux-foundation.org,baohua@kernel.org,david@kernel.org,dev.jain@arm.com,hughd@google.com,kas@kernel.org,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,qi.zheng@linux.dev,ryan.roberts@arm.com,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:22:39 +0200
Message-ID: <2026100338-roundworm-goatskin-a51b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 72c3d682c165b836b54a3d07a01f72e39c47022c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100338-roundworm-goatskin-a51b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72c3d682c165b836b54a3d07a01f72e39c47022c Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linux.alibaba.com>
Date: Mon, 14 Sep 2026 10:12:41 +0800
Subject: [PATCH] mm: shmem: ignore sysfs configs for shmem forced collapse

According to Documentation/mm/transhuge.rst, MADV_COLLAPSE is expected to
ignore any THP or mTHP interface settings.

However, after commit 26c7d8413aaf ("mm: thp: support "THPeligible"
semantics for mTHP with anonymous shmem"), performing MADV_COLLAPSE on
shmem will depend on /sys/.../hugepages-2048kB/shmem_enabled being set to
"inherit" (although that is the default), which can cause MADV_COLLAPSE to
fail unexpectedly.

This could cause a userspace-visible performance regression.

Fix this by returning the result of shmem_huge_global_enabled() directly
when MADV_COLLAPSE is requested, allowing PMD-order collapse while
ignoring shmem THP/mTHP settings.

Link: https://lore.kernel.org/063f655b4d6c4234f3aa27ed6ecab10283ecb880.1789351825.git.baolin.wang@linux.alibaba.com
Fixes: 26c7d8413aaf ("mm: thp: support "THPeligible" semantics for mTHP with anonymous shmem")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Closes: https://lore.kernel.org/all/20260908125105.1510704-7-kirill@shutemov.name/
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>

diff --git a/mm/shmem.c b/mm/shmem.c
index 897fa2b61346..848316eaa7f4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1847,8 +1847,11 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 
 	global_orders = shmem_huge_global_enabled(inode, index, write_end,
 						  shmem_huge_force, vma, vm_flags);
-	/* Tmpfs huge pages allocation */
-	if (!vma || !vma_is_anon_shmem(vma))
+	/*
+	 * Tmpfs huge pages allocation or forced collapse ignores
+	 * sysfs configs.
+	 */
+	if (!vma || !vma_is_anon_shmem(vma) || shmem_huge_force)
 		return global_orders;
 
 	/*

