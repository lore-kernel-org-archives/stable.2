Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C84A8FEE
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439481; cv=none; b=E9MxxYJQrMwIM8Dpw7d72XAehLS3pMkfOmZ8Dly3iv4U8rYbwe+iVZ498gOjH0YbJJ+JzGFYxnaC5S7CwlcDI7PP5bxLJ3MNyTgb4f0CHSzJZdVbFEHFwok1xsfYsg69rrILJUuLn2Mobi4apuV/43nKKmeC2zc61hXDyr04L7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439481; c=relaxed/simple;
	bh=xeO5427NFWifStX+bu0qi+BE6DWvZmKxWVM481nB0V4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AXEX5fGSA0lEPskKGsCtrlCzyCA6X04OYFLlHP4acStf7PBHsl8dlonODrDsBfpHJx3+YjxsW/ZfS1TtLpz0sdDrNceww2m6MXLCRs7oNXFKPQX/AFaG7ZCEZZlxR86hg8dz79ciYYV0wvfgw1k4hYq0MdVV1KCYV1FW4st24MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ud1gE/PF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ud1gE/PF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8FE1F000E9;
	Thu,  3 Sep 2026 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439479;
	bh=z/uBSQAcwkeACo4B8R0qo+cbnQY+YTZpIhtiABn06a4=;
	h=Subject:To:Cc:From:Date;
	b=Ud1gE/PFa0QqZP5b2iHJ5cVd0VqcJwsiOswEiFpUze0ZEZ3jRsZXln5kcE8MkbAad
	 8xnEEkWp2XaxkQqajz+W5PGgmNEH5Qy3IDF2AQWKCPv8eC1O70yCpYLg92PXhDbBXD
	 Qx3ASMmS4aoPH4yhNUkIXJv91wRpAXoRtBov1Zr4=
Subject: FAILED: patch "[PATCH] mm, swap: ratelimit bad swap entry reports" failed to apply to 6.12-stable tree
To: leitao@debian.org,akpm@linux-foundation.org,baohua@kernel.org,baoquan.he@linux.dev,chrisl@kernel.org,david@kernel.org,kasong@tencent.com,linmiaohe@huawei.com,nphamcs@gmail.com,osalvador@suse.de,shikemeng@huaweicloud.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:46:22 +0200
Message-ID: <2026090322-roaming-sherry-27d1@gregkh>
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
git cherry-pick -x f9dc428249ed962a70acf301f01eae8578449161
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090322-roaming-sherry-27d1@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f9dc428249ed962a70acf301f01eae8578449161 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Tue, 18 Aug 2026 02:03:40 -0700
Subject: [PATCH] mm, swap: ratelimit bad swap entry reports

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

diff --git a/mm/swapfile.c b/mm/swapfile.c
index dacef34a3ed7..53bf01d5f7f1 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1899,11 +1899,11 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 
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
@@ -3883,7 +3883,7 @@ int swap_dup_entry_direct(swp_entry_t entry)
 
 	si = swap_entry_to_info(entry);
 	if (WARN_ON_ONCE(!si)) {
-		pr_err("%s%08lx\n", Bad_file, entry.val);
+		pr_err_ratelimited("%s%08lx\n", Bad_file, entry.val);
 		return -EINVAL;
 	}
 

