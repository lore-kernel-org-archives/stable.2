Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21764271A94
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557826; cv=none; b=YGKIf9olnruCnxU3GWJNUJT35rkI6Wnn8xPlMXvLlFtgAAL0AIEwiQLgl9LJi/WXamMAkLugUp7SeG73BHQ5P9D2hXQnzbIV94u8dZZZetpnyFOeiY5GhCg/c3At1H2DVNRmlJ83i0zF4BzmOunwpOu2L/Efgnm/SqTaEJcAndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557826; c=relaxed/simple;
	bh=sRSH8V24hTjdYC0g9RqMlD5O5gCW0hzcOlPpd8qJA30=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hrp5okMvX4GKFhgFXmFsOl8G5TDkwVw+eVdDJPs75VjtnXI+WOmALRAwRwnykJlJnnvJ78GwaHJ+bz2lq+7rWK+5Icyhtv/hDum/MFqCs5jBINn3Pr5duHR5FkHO1IShlYWzAZvEerACQ464EiH30umaodGdRuNRE968Oh3XIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XiC6Umn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XiC6Umn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0051F000E9;
	Mon, 20 Jul 2026 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557824;
	bh=Z2M//3Desa5v1gPQzgPscIc01kGtwbXOwPZxLF+h6Z0=;
	h=Subject:To:Cc:From:Date;
	b=XiC6Umn91JP66BlJN33VBT6TWaphnXprkpHaL8X4IQmw0q0xn4pno/vQPvjmaS3PA
	 vICe+nxpRPii9EdpE0A7RwSNw/GnZEKLcmOwBioBXv9ZBxFeVUfb5WC46jZFglRrxJ
	 l82JQrUsBq5ynm2+fPpPfb7s8G04wOE66h59CV7I=
Subject: FAILED: patch "[PATCH] fs/proc: fix KPF_KSM reported for all anonymous pages" failed to apply to 6.12-stable tree
To: tujinjiang@huawei.com,akpm@linux-foundation.org,chengming.zhou@linux.dev,david@kernel.org,linmiaohe@huawei.com,luizcap@redhat.com,stable@vger.kernel.org,sunnanyong@huawei.com,svetly.todorov@memverge.com,wangkefeng.wang@huawei.com,willy@infradead.org,xu.xin16@zte.com.cn,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:30:15 +0200
Message-ID: <2026072015-monkhood-mutation-c524@gregkh>
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
git cherry-pick -x 81401cebfc1598306b0a981b5f9ee5b58c1aac52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072015-monkhood-mutation-c524@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81401cebfc1598306b0a981b5f9ee5b58c1aac52 Mon Sep 17 00:00:00 2001
From: Jinjiang Tu <tujinjiang@huawei.com>
Date: Fri, 26 Jun 2026 09:32:52 +0800
Subject: [PATCH] fs/proc: fix KPF_KSM reported for all anonymous pages

Reading /proc/kpageflags for any anonymous page returns KPF_KSM set, even
when KSM is not in use.  As a result, tools misclassify all anonymous
pages as KSM merged.

In stable_page_flags(), if the page is anonymous, then use (mapping &
FOLIO_MAPPING_KSM) check to identify if the anonymous page is KSM page.
However, FOLIO_MAPPING_KSM is FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM,
(mapping & FOLIO_MAPPING_KSM) check returns true for all anonymous pages.

To fix it, use FOLIO_MAPPING_ANON_KSM instead.

Link: https://lore.kernel.org/20260629033122.774318-1-tujinjiang@huawei.com
Link: https://lore.kernel.org/20260626013252.2846774-1-tujinjiang@huawei.com
Fixes: dee3d0bef2b0 ("proc: rewrite stable_page_flags()")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Luiz Capitulino <luizcap@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Svetly Todorov <svetly.todorov@memverge.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/proc/page.c b/fs/proc/page.c
index f9b2c2c906cd..7d9387143435 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -173,7 +173,7 @@ u64 stable_page_flags(const struct page *page)
 		u |= 1 << KPF_MMAP;
 	if (is_anon) {
 		u |= 1 << KPF_ANON;
-		if (mapping & FOLIO_MAPPING_KSM)
+		if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
 			u |= 1 << KPF_KSM;
 	}
 

