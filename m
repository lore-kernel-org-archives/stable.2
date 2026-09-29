Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61491AF4E9
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670440; cv=none; b=MgDStuinGOuluDI1hMuft1NHiSEEIOMdD5hr64aGGhM4TU7V2CAtEj6OBuzbEcZ8UeSooSSLpHRau/EVXNCSihkZX1R/Y3PYfC4vdDhMl7k3tcX7YAb9bhCjjixEaH89psPf5fI5s0gYPJ1qgxmQiKtbdB3tVdIeRcpx5T0P4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670440; c=relaxed/simple;
	bh=K2IZwYq9jlnJXV2L8zjrB8w8lwHNmqB1IR3VZalWjFQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D8NroF2P3z96ze+OW0FYaHQ5s+Ihi8vG4D/BZbdg7Al9WUsZSaAUlDQ6Z4KKxgmTFP1xLjg3TN40+BKWaqiXPSjB41rTFHIBBGMm6TaOk+ME+v+z822060DXE+RQchAxjqM++z9zHm4kKvrUh55hsaZDVgkH37eJE8ZnS8c3fg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dVuFSkhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dVuFSkhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215D21F000FF;
	Tue, 29 Sep 2026 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670438;
	bh=fNhAiuZ6p2O5+Jieh/WoMJsTILtmAmwyfW0U1V1ap2M=;
	h=Subject:To:Cc:From:Date;
	b=dVuFSkhS5QL0KrSqFSS6hCSd+xAOEPcM+Spyp2GbjWWwNZlf/GiSQKzsgwLsxsGQl
	 sqFw/ew8MigEdbjiIl2foHGEK5osF5nf0xFQb/QfDpeavzWxwgy2ESX4X7iisd1J1S
	 0CKgCllYVslMJhRziLQFhJiEKx/ghqnll8vnJKAU=
Subject: FAILED: patch "[PATCH] mm/hugetlb: do not dissolve gigantic pages without runtime" failed to apply to 5.15-stable tree
To: xialonglong@kylinos.cn,akpm@linux-foundation.org,david@kernel.org,linmiaohe@huawei.com,mhocko@suse.com,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:27:05 +0200
Message-ID: <2026092905-mystified-upstart-3f7b@gregkh>
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
git cherry-pick -x a363c62a653cc8b3e21da9545fa4e028ef50f9c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092905-mystified-upstart-3f7b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a363c62a653cc8b3e21da9545fa4e028ef50f9c3 Mon Sep 17 00:00:00 2001
From: Longlong Xia <xialonglong@kylinos.cn>
Date: Sun, 23 Aug 2026 12:40:51 +0800
Subject: [PATCH] mm/hugetlb: do not dissolve gigantic pages without runtime
 support

dissolve_free_hugetlb_folio() doesn't check
hstate_is_gigantic_no_runtime(h) though remove_hugetlb_folio()/
update_and_free_hugetlb_folio() silently bail for such folios, so it frees
a still-listed folio and, on vmemmap restore failure, the
add_hugetlb_folio() rollback corrupts the free list.

Link: https://lore.kernel.org/20260823044118.1097121-2-xialonglong2025@163.com
Fixes: 6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: Codex:gpt-5.6-sol
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4f6f58bf3db6..d28972cd33f5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1967,6 +1967,15 @@ int dissolve_free_hugetlb_folio(struct folio *folio)
 		struct hstate *h = folio_hstate(folio);
 		bool adjust_surplus = false;
 
+		/*
+		 * remove_hugetlb_folio()/update_and_free_hugetlb_folio() bail
+		 * for gigantic hstates without runtime support, so dissolving one
+		 * here would leave it on the free list and, on vmemmap restore
+		 * failure, the add_hugetlb_folio() rollback corrupts that list.
+		 */
+		if (hstate_is_gigantic_no_runtime(h))
+			goto out;
+
 		if (!available_huge_pages(h))
 			goto out;
 

