Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5C3AAF64
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671269; cv=none; b=MLVzWJ7czZ5Rsfq6tou9eKrLg7oOumnJjefUCTqXFPEBrUjvVQ2rRNg1HQ/EvlOzfPomHniqV2raiOahZVLb8ipuDFIsMgNivnvOPvJ30mLA7hQwRe7BXREIYT9vE+JR4LvK0UwQW5m6EQ1rZ5x87Iz6XMZ9zF7n/RnWPfCGyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671269; c=relaxed/simple;
	bh=+k9YrN80vIeRqDyUWCMeFdQ9nTKJqQq9t8OAxHdZGFY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VTKp5rGLjgpZdXC5ZnehF3tQU/nG38QlpjRYeXR8MoweaZyL3/Gwo59Xsmm6C9C+d8SzJVJhZdQraZ2ohI7z81SOQBRkgWMxWAwVDBe20uizTa9JLMyqmy6osXtd02Aw/hB09epAFEJwU2kGvO4S2tR4l9Xx6TeMEcmXVk0wnRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EQ4nXQEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EQ4nXQEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0CC1F00893;
	Tue, 29 Sep 2026 08:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790671268;
	bh=WwN7sK9wan8ETkf9PeIfS4O9EbHduHFZDEO8jkddr1c=;
	h=Subject:To:Cc:From:Date;
	b=EQ4nXQEe0DlhkKHYvkZmZESkZAHvFA63QI35jPETHTVaMsQtv/ugV0TgZDNBkKelg
	 ClQGxlNMKAfWNdKSiOlmJaSKmVy6eF+a2cpYFvtOIVxyA/5Al3DDLZ5+6LvOMEv37G
	 3z6I8qOJNymOnmlu9S18ttmNpsZshzqQxgeoCvU8=
Subject: FAILED: patch "[PATCH] mm/hugetlb: do not dissolve gigantic pages without runtime" failed to apply to 6.18-stable tree
To: xialonglong@kylinos.cn,akpm@linux-foundation.org,david@kernel.org,linmiaohe@huawei.com,mhocko@suse.com,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:41:02 +0200
Message-ID: <2026092902-struck-raving-0494@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a363c62a653cc8b3e21da9545fa4e028ef50f9c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092902-struck-raving-0494@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 

