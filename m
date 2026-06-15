Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D73EE1EC
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533236; cv=none; b=Gv9VQwEtWQs3/WVIgYaC7xdhYszotrJLWJ31Mk3cXT9xZYHm3GVfXx+Kq+XftpC3qslUDKkYbxDoFCPlyHXNZ6kjn0AmIKN//vodCsguo/9TfkwVl1tgSNMpOx7weRUTyzIescL3AR/86FMmxP0WXHvQKnzuRGRxRHWRWkvUfAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533236; c=relaxed/simple;
	bh=kFq9P6OfIvOin6Gslt40yrSflszxtXME8F1DQqOf4oE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QRtqhIdiNsR1nSxy6oVO4kLO5ekDQsHxm69XFwx8DmEL0TBpy3itatFX1oScLf4+o9fU0gbKT7OtxNwONF+xDya3foz10r6Rd2FCvBT8EwsyiemI039O/WHthm1rkQ1aaUgYC1qSwl4eiq/QJu+2kCLOxXP2hDiilDJxQJo7w3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K6lqSDNk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K6lqSDNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F221F000E9;
	Mon, 15 Jun 2026 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533235;
	bh=4fxI6JdPR7aJZSKtAKOSakzmJcmvn4JcFjdEDj9Llos=;
	h=Subject:To:Cc:From:Date;
	b=K6lqSDNkDo3fOgJs0ZPwCEYQHmgNL2JoxjqWlQCVvmzXw9tcCMG+5qLjnsPHnvAA5
	 qmk/5ojBJpF0chHoRSkO+AAF5kOdyypL2UuxUMDOWcWc+RMvbxyDyRV5JybTtVBYrz
	 6cfbOMKpTjvkD0X2OEGlYdn70dcZOvNOo65ErgIg=
Subject: FAILED: patch "[PATCH] mm/huge_memory: update file PMD counter before folio_put()" failed to apply to 5.15-stable tree
To: yintirui@huawei.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,chenjun102@huawei.com,david@kernel.org,dev.jain@arm.com,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,npache@redhat.com,ryan.roberts@arm.com,stable@vger.kernel.org,vbabka@kernel.org,wangkefeng.wang@huawei.com,yang.shi@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:19:12 +0200
Message-ID: <2026061512-encrypt-banking-e175@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8d878059924f12c1bc24556a92ec56add74de3c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061512-encrypt-banking-e175@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d878059924f12c1bc24556a92ec56add74de3c8 Mon Sep 17 00:00:00 2001
From: Yin Tirui <yintirui@huawei.com>
Date: Tue, 26 May 2026 18:13:37 +0800
Subject: [PATCH] mm/huge_memory: update file PMD counter before folio_put()

__split_huge_pmd_locked() updates the file/shmem RSS counter after
dropping the PMD mapping's folio reference.  If folio_put() drops the last
reference, mm_counter_file() can later read freed folio state via
folio_test_swapbacked().

Move the counter update before folio_put().

Link: https://lore.kernel.org/20260526101337.1984081-1-yintirui@huawei.com
Fixes: fadae2953072 ("thp: use mm_file_counter to determine update which rss counter")
Signed-off-by: Yin Tirui <yintirui@huawei.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chen Jun <chenjun102@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1f78b73a0ca4..653f2dc03403 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3133,7 +3133,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			if (!folio_test_referenced(folio) && pmd_young(old_pmd))
 				folio_set_referenced(folio);
 			folio_remove_rmap_pmd(folio, page, vma);
+			add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
 			folio_put(folio);
+			return;
 		}
 		add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
 		return;

