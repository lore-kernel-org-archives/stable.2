Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E524F472D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454777; cv=none; b=WPKAq6fMIUwuTeOkTrAuvk63WQo/R0rCI4VOYvRXzB17dWOzybNTpAt1Ob/7BzwqmXLwk9abDbFItC/8xtapA+CN9torJZdEEnpy2D/whrYq988JyGTtGpsoUyT2npeVJhWn7KkAS1k8YQy07LRGKlGI++toL+JGVKE9Y5gE1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454777; c=relaxed/simple;
	bh=fN9ZDh2pv9fxXCINVZiQd5D+QkfXWu9pZor4lMCGccY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsZbTQVslD/yEFO4IWUbLxPEpzi92vgl+ZBGosjztQ8XPIJiKnnUYkJdVGk9YE+onb3wglh1C+E3/aVlwJsX97gR5whjDQJ+2R+NCXsAQcJFOlWaqyd6cq3pFsSpqmQLsebSVH80sorEzqEdCH7VIMRBkFbhKGtoh+bBYmmHmSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvC2hFw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvC2hFw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBDB1F00A3E;
	Thu,  3 Sep 2026 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788454776;
	bh=lyZMdFEWIEMmR6f/iOY/RRTXFV+cpLpM2oB9cFQsL98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nvC2hFw++7RbPWuAvkrZyy7woVeZRITbBJvuJZ0Ee06zEOxEPNAkwYTxysdwkdxk0
	 FqmMcXVxtKNGMPAvZLmdRqffqe0PAyZpqQdhtESoEiWeB+dbs3+Ai5fyzS09pEBLEB
	 RNZat67RUbfafaQ5/ntIDt6xJkNk7Kb3TPvHh4ZpmtYZE2T+3WOkVflg/WdkgQwhSX
	 9UK5jZCGFLwVEwaFKyGGf5IlycHnI6ssniT3CDd6k+YK5cQMcUGM02eUnJMleE3GKJ
	 2j2eYdP7N8gqvS62GxkoZsbANnH8L6ANjoaGSyJXTRuBMAtj+MP+e9DqYWvTJN3G3c
	 BHTBSY9W0AwfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Barry Song <baohua@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Kairui Song <kasong@tencent.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mm, swap: ratelimit bad swap entry reports
Date: Thu,  3 Sep 2026 12:59:31 -0400
Message-ID: <20260903165931.1089311-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903165931.1089311-1-sashal@kernel.org>
References: <2026090323-probe-impolite-bac9@gregkh>
 <20260903165931.1089311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit f9dc428249ed962a70acf301f01eae8578449161 ]

A corrupt page table hands the same bogus entry to get_swap_device() on
every access to the mapping, and every rejection is logged.  One machine
logged 6185620 copies of the same line in a few hours.

swap_dup_entry_direct() prints the same message from the fork path, once
per call: the WARN_ON_ONCE() guarding it warns once, the pr_err() inside
does not.

Rate limit all three prints.

Link: https://lore.kernel.org/20260818-swap_part_one-v1-1-a4fc58119fc0@debian.org
Fixes: 23b230ba8ac3 ("mm/swap: print bad swap offset entry in get_swap_device")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Kairui Song <kasong@tencent.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Chris Li <chrisl@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/swapfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 14a9a84d97f86..5dd9bee3f46f6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1287,11 +1287,11 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 
 	return si;
 bad_nofile:
-	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
+	pr_err_ratelimited("%s: %s%08lx\n", __func__, Bad_file, entry.val);
 out:
 	return NULL;
 put_out:
-	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
+	pr_err_ratelimited("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
 	percpu_ref_put(&si->users);
 	return NULL;
 }
@@ -3308,7 +3308,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 
 	si = swp_swap_info(entry);
 	if (WARN_ON_ONCE(!si)) {
-		pr_err("%s%08lx\n", Bad_file, entry.val);
+		pr_err_ratelimited("%s%08lx\n", Bad_file, entry.val);
 		return -EINVAL;
 	}
 
-- 
2.53.0

