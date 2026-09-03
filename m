Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C744AA1D0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439574; cv=none; b=sooKEqj8SoJDChGp/MyjbJmYaLA1vJ35rvRrH4ewslgcMqAvc4RhXw7KAsmCaR0dLit/ciSEa24RcVbYFlC1LvBI2Z4Xdcesj0MhIYCTpdwGfCMvn1VVoHm8PxCbJsyRGhpufwGXgIKO8IZm5vceSNiBX+T1FJpkiNbN6k/lCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439574; c=relaxed/simple;
	bh=Ce61uN+spVFiVYUoSN7F4Mrpr98buAjPOWPJYd7QZ9M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kXKIPzl05mTJTy77vAk/gDLeGFj9Gk6q3Wp5ZvX86mOmsxj/XF1mzrGpIlhTevnzgqi8bQ9x8j/iMVqzo1l4T+ciLmmEwJUJb5jjjkoWmXEb+pGFWkU7ggtZBRewpKz18jAUImsj+fkFvir1w/dndb/ygAcw/4Vm1f4Arw+ZTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MFhB5/75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MFhB5/75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743571F000E9;
	Thu,  3 Sep 2026 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439573;
	bh=ib8rgg69qoL4pON2xlVPDdccTTa3T2FMPBKaWNfwoeo=;
	h=Subject:To:Cc:From:Date;
	b=MFhB5/75vpp8utieU6AkDwCCrZ+9hsv5k+PDppatOroTuxb9rR2NjZkKw06Y0E4OW
	 Axr911e7LtPB7cvK7zn7SupJKdE6M/CtEaGaUE1WuA8safNpr60pULppHJED7ImXsA
	 wO2+qGqkch/Dqgfl0jKq3hu4ZGnBc2OHoH3sWjfs=
Subject: FAILED: patch "[PATCH] mm/page_owner: use memcg_data snapshot to avoid TOCTOU in" failed to apply to 6.1-stable tree
To: ye.liu@linux.dev,akpm@linux-foundation.org,david@kernel.org,hannes@cmpxchg.org,jackmanb@google.com,ljs@kernel.org,mhocko@suse.com,sashiko-bot@kernel.org,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:49:14 +0200
Message-ID: <2026090314-dagger-sharpness-8cd1@gregkh>
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
git cherry-pick -x 90f095b816e25c6a9e4446d299bac5007fdcb3df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090314-dagger-sharpness-8cd1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90f095b816e25c6a9e4446d299bac5007fdcb3df Mon Sep 17 00:00:00 2001
From: Ye Liu <ye.liu@linux.dev>
Date: Tue, 14 Jul 2026 09:51:08 +0800
Subject: [PATCH] mm/page_owner: use memcg_data snapshot to avoid TOCTOU in
 print_page_owner_memcg()

print_page_owner_memcg() reads page->memcg_data via READ_ONCE() at the
start to guard against tail pages and NULL data.  However, it later
re-reads page->memcg_data locklessly in two places:

1: page_memcg_check(page)

2: PageMemcgKmem(page) (via folio_memcg_kmem(), which includes
   VM_BUG_ON assertions for tail pages and MEMCG_DATA_OBJEXTS)

If the page is concurrently freed and reallocated as a THP tail page or
slab page between these calls, the VM_BUG_ON assertions can trigger on
CONFIG_DEBUG_VM=y builds, crashing the kernel.

Fix both TOCTOU issues by using the memcg_data snapshot throughout.

Link: https://lore.kernel.org/20260714015117.78351-10-ye.liu@linux.dev
Fixes: fcf8935832b8 ("mm/page_owner: print memcg information")
Signed-off-by: Ye Liu <ye.liu@linux.dev>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand (Arm) <david@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2e3880053a34..e18512a49e38 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -540,6 +540,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 					 struct page *page)
 {
 	unsigned long memcg_data;
+	struct obj_cgroup *objcg;
 	struct mem_cgroup *memcg;
 	bool online;
 	char name[80];
@@ -549,11 +550,14 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 	if (!memcg_data || PageTail(page))
 		goto out_unlock;
 
-	if (memcg_data & MEMCG_DATA_OBJEXTS)
+	if (memcg_data & MEMCG_DATA_OBJEXTS) {
 		ret += scnprintf(kbuf + ret, count - ret,
 				"Slab cache page\n");
+		goto out_unlock;
+	}
 
-	memcg = page_memcg_check(page);
+	objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
+	memcg = objcg ? obj_cgroup_memcg(objcg) : NULL;
 	if (!memcg)
 		goto out_unlock;
 
@@ -561,7 +565,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 	cgroup_name(memcg->css.cgroup, name, sizeof(name));
 	ret += scnprintf(kbuf + ret, count - ret,
 			"Charged %sto %smemcg %s\n",
-			PageMemcgKmem(page) ? "(via objcg) " : "",
+			(memcg_data & MEMCG_DATA_KMEM) ? "(via objcg) " : "",
 			online ? "" : "offline ",
 			name);
 out_unlock:

