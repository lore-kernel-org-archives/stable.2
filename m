Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020454A8FE1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439484; cv=none; b=oUyzXuiH+okSt+AGoVpARBO/WilUAcPDl8dYCgQRfZJFtTgT65LggBPbHaAWAejYbHFNnDx8Su2fjGKVyCYnToBkCLzyxEVNdUlX9QxDeEEx3L0W6Xi8R+4VB9KAe9HMZOvZe2ew424btjiPCVV9zlErtFlrGoqqYK/wd+NWCzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439484; c=relaxed/simple;
	bh=iUKPXkw0sOsBMhPCb6zXhKQByYRgLPM38QTIqWyQjxk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lk2BLQrfadQ55pH86AoGdiyEifPIYGj6F9iiKcjr3K9jQplVCTjDXxFZr8No/a8qQqpKamL9/RsdSOUKQm1UBqg1NnmUI+R+ztszPG58qas2iGjNRiWYHLihAmWeaOJzVtk0bQDowjnGFiicHWX8/mg5i5EjnCuv2L6VvxnpYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RRZQVLlp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RRZQVLlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDCC1F000E9;
	Thu,  3 Sep 2026 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439482;
	bh=s7bBCY/s3suHuLWexs11jj/Oa94dwRnGFzXilWnjC0A=;
	h=Subject:To:Cc:From:Date;
	b=RRZQVLlp5UQz+vGLiMADw2vzkugwYytqvdWyamXn/0Pdhfvue+CU38+11kW0ZvNH7
	 SKVd76EdVo11PziFOCMI+v5K9CB53oN+Hs+yG2W5uylOtqJQzb06j3wbtfvzzB8+LN
	 /WdJyddhljbAv2MSdyi35xgsZEWpv2fXtEda7hY0=
Subject: FAILED: patch "[PATCH] mm, swap: ratelimit bad swap entry reports" failed to apply to 6.1-stable tree
To: leitao@debian.org,akpm@linux-foundation.org,baohua@kernel.org,baoquan.he@linux.dev,chrisl@kernel.org,david@kernel.org,kasong@tencent.com,linmiaohe@huawei.com,nphamcs@gmail.com,osalvador@suse.de,shikemeng@huaweicloud.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:46:23 +0200
Message-ID: <2026090323-probe-impolite-bac9@gregkh>
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
git cherry-pick -x f9dc428249ed962a70acf301f01eae8578449161
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090323-probe-impolite-bac9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

