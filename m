Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEF148B363
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996757; cv=none; b=X35c7kQ0Jpnew2jkmDjqfGJS8MfGaNogTXgNYmDtMD+psDqktCA4lQ56d+krcJMFdRuXqNkBlyNZcSw6pYT9a70Q3mR1byIfmvJZoTXmkwUlz99dYUWbjMg7Pvr7OSke/3PZR5sRj/WwdgVmV/Y6JtHWuzb64kKMCONxBtLTI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996757; c=relaxed/simple;
	bh=pYpIWyvRjMGm2sQJlvLjMeHktmKQUTtIjP/Art6Uj8I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YFvMh8+Lz+ftBA2k+26GubM6X+2k2KgizH0t2Hj2ypfZZdpr6DvKsx+zotSJ4gMF7h22/pIMveZk4B3r+CbBUDg08q8UcocO0AnyePAt87UiQ0rlopZRfHmpMKjFmmQ55mDcmdkRPzmw/r5I2cMH7ccv1voW9afDNOFeIYyK9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShO0gbOG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShO0gbOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E221F000E9;
	Thu,  2 Jul 2026 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782996752;
	bh=Za9K9EMTJmofzrtYkJby6mjfvNqbQzss/YlXdOy8ihs=;
	h=Subject:To:Cc:From:Date;
	b=ShO0gbOGUYDlpwZgunMT9Ssx29sWLGMQRXWZqlb0ZU4jBYayJWPINp+qqeYEhTo8S
	 SK7I38kd2ZQFkxaFdKiGH42ywB0/KHxcc4lvRoOfmiIXh5or24OSfiPYG/jS9DtUfH
	 nhubgWuGkEhu4uVbVnZOb6PWjjuxUBBcZrt9D0ts=
Subject: FAILED: patch "[PATCH] userfaultfd: gate must_wait writability check on" failed to apply to 6.18-stable tree
To: kas@kernel.org,akpm@linux-foundation.org,balbirs@nvidia.com,david@kernel.org,ljs@kernel.org,mhocko@suse.com,peterx@redhat.com,rppt@kernel.org,sashiko-bot@kernel.org,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 14:52:38 +0200
Message-ID: <2026070238-shadiness-ivory-4087@gregkh>
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
git cherry-pick -x 8e80af52db652fbc41320eee45a4f73bc029faf2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070238-shadiness-ivory-4087@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e80af52db652fbc41320eee45a4f73bc029faf2 Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Fri, 29 May 2026 18:23:29 +0100
Subject: [PATCH] userfaultfd: gate must_wait writability check on
 pte_present()

userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
without taking the page table lock and then apply pte_write() /
huge_pte_write() to it.  Those accessors decode bits from the present
encoding only; on a swap or migration entry they read the offset bits that
happen to share the same position and return an undefined result.

The intent of the check is "is this fault still WP-blocked?".  A
non-marker swap entry means the page is in transit -- the userfault
context the original fault delivered against is no longer the same, and
the swap-in or migration completion path will re-deliver a fresh fault if
userspace still needs to handle it.  Worst case under the current code the
garbage write bit says "wait", and the thread stays asleep until a
UFFDIO_WAKE that may never arrive.

Gate the writability check on pte_present() so the lockless re-check only
inspects present-PTE bits when the entry is actually present.  The
non-present, non-marker case returns "don't wait" and lets the fault path
retry.

Link: https://lore.kernel.org/20260529172331.356655-6-kas@kernel.org
Fixes: 369cd2121be4 ("userfaultfd: hugetlbfs: userfaultfd_huge_must_wait for hugepmd ranges")
Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index c86daf38d154..246af12bf801 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2542,6 +2542,15 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	/* UFFD PTE markers require userspace to resolve the fault. */
 	if (pte_is_uffd_marker(pte))
 		return true;
+	/*
+	 * Concurrent migration may have replaced the present PTE with a
+	 * non-marker swap entry between fault delivery and this lockless
+	 * re-check. huge_pte_write() on a swap entry decodes random offset
+	 * bits, so gate it on pte_present(). The migration completion path
+	 * will re-deliver the fault if it still needs userspace.
+	 */
+	if (!pte_present(pte))
+		return false;
 	/*
 	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
 	 * resolve the fault.
@@ -2628,6 +2637,17 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	/* UFFD PTE markers require userspace to resolve the fault. */
 	if (pte_is_uffd_marker(ptent))
 		goto out;
+	/*
+	 * Concurrent swap-out / migration may have replaced the present PTE
+	 * with a non-marker swap entry between fault delivery and this
+	 * lockless re-check. pte_write() on a swap entry decodes random
+	 * offset bits, so gate it on pte_present(). The page-in path will
+	 * re-deliver the fault if it still needs userspace.
+	 */
+	if (!pte_present(ptent)) {
+		ret = false;
+		goto out;
+	}
 	/*
 	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
 	 * resolve the fault.

