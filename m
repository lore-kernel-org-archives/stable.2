Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A74380FCF
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670442; cv=none; b=RdpJPvWVoCx8znzZLcgfcdRGDD+xYfMlcFSegeJ9oiITyxTOvtWxT62RFxImn/jushnHUens6Ce8NG+acxbWIFj88nC90xTAjmWABmidjhbSgRMwyLjhgmqrDq/o4aJ2fNqVb96ug0AzwRgssgNR0FXK+Bb3Rloihu8teZ8t6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670442; c=relaxed/simple;
	bh=zR6qnxKjwXhqZdCODizblZ2SmgY/PEPySAy1ETg9tAw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oAvni/g/n3jq1PrJhuL8DBHiNRhjYumagwc1WnXna5kjq967bQL28NvNVxJ+m/iwzATVcItDoM2b6m03q7T9bhHTepB4CF5/1F/MocFnYGfsn0PAO43hPyN9objcpsP1QhaKZW7J2GjUxa8cA8TkxQpKT5Sz4Id4HEwUVVBBQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A7gEXuwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A7gEXuwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16EB1F000FF;
	Tue, 29 Sep 2026 08:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670441;
	bh=DWaEqKxlAs9T1KdP2FGIGt2Jl8jER2fu2v5fDOleYz0=;
	h=Subject:To:Cc:From:Date;
	b=A7gEXuwCUH/XYduqc0RPp6lyBIEMzQensMtMwE8QrzmHaw8sL5DubL38ZpicZbM9H
	 RC32/PVTz7G/FBm+GwlahztXJf3Piq2cujaBYpZcjXNcm01YZrNJ5lwSn/vVbakHD/
	 X+p1pX9ob4ESpfjF81LTZR5tY5Yq/JUpL+sR/iGU=
Subject: FAILED: patch "[PATCH] mm/hugetlb: do not dissolve gigantic pages without runtime" failed to apply to 6.1-stable tree
To: xialonglong@kylinos.cn,akpm@linux-foundation.org,david@kernel.org,linmiaohe@huawei.com,mhocko@suse.com,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:27:05 +0200
Message-ID: <2026092905-greeter-coke-d3db@gregkh>
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
git cherry-pick -x a363c62a653cc8b3e21da9545fa4e028ef50f9c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092905-greeter-coke-d3db@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

