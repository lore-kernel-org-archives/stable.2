Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD9C3F9A0B
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533269; cv=none; b=aG1nUiAms8m0Ct8OqY7iFBnoz5oQPrGArbcmpKhM+BGEmoNnRk1LakzHPNAV5SE7XDBqoJlWYv20Y7PW+tCtcYwMhyPq2Z2B/jiarpA04eqay8jgZRjVjBJb2IGt//ncS3zAiTl+BmyXN8i8yOBav7emFrcvVEb79gp/Fs8P9Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533269; c=relaxed/simple;
	bh=4LQm53I0dvc96s74Y13Tcrw++bBeCF3WBndnnvMBWj8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I8ML5d7ogQDk0Xg2J0xTK7+ApKu1i+vZ0losaellpkVeKsd1QMLBrNUEIEUAkPmr68n1h/SFzHJP542UmpHcGkbneyNDiy0+vKVr8RaCZRr+MxNiO4yWADm3OODiXqu02I5pXbKTE0OzF5B0+mi1bSTMRUWV+EfMKcos3ZLcxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JMr0s1H8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JMr0s1H8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C791F00A3A;
	Mon, 15 Jun 2026 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533261;
	bh=kHPe7bH9RCKn9nrR83RUG2epj1UICpiwncmZPfhVjoc=;
	h=Subject:To:Cc:From:Date;
	b=JMr0s1H8LHxaN4YhmbsL00zEVn3/6ErlOEQ70wGQGWoYSQ3L78duhacWC2icDpVzL
	 fjhMXQ9oN7gfqbBZ2XQkkzyGhkoPAifoAG5nHcI3NNXT9E8LGPXgVi+qYWVJyaav6z
	 XlrabNO6Vyu/j2d/Vu/yfBN1+2Go5xx3kXKRAkdA=
Subject: FAILED: patch "[PATCH] mm/damon/ops-common: call folio_test_lru() after folio_get()" failed to apply to 5.15-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,foersleo@amazon.de,shakeel.butt@linux.dev,sieberf@amazon.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:19:32 +0200
Message-ID: <2026061532-emu-stopped-b17a@gregkh>
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
git cherry-pick -x d6b8b02a27b3dd09ec12144322b3dac46d9bc9ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061532-emu-stopped-b17a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d6b8b02a27b3dd09ec12144322b3dac46d9bc9ef Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 25 May 2026 09:22:55 -0700
Subject: [PATCH] mm/damon/ops-common: call folio_test_lru() after folio_get()

damon_get_folio() speculatively calls folio_test_lru() before
folio_try_get().  The folio can get freed and reallocated to a tail page.
In the case, VM_BUG_ON_PGFLAGS() in const_folio_flags() can be triggered.
Remove the speculative call.

Also mark folio_test_lru() check right after folio_try_get() success as no
more unlikely.

The race should be rare.  Also the problem can happen only if the kernel
has enabled CONFIG_DEBUG_VM_PGFLAGS.  No real world report of this issue
has been made so far.  This fix is based on only theoretical analysis.
That said, a bug is a bug.  A similar issue was also fixed via commit
3203b3ab0fcf ("mm/filemap: don't call folio_test_locked() without a
reference in next_uptodate_folio()").  I don't expect this change will
make a meaningful impact to DAMON performance in the real world, though I
will be happy to be corrected from the real world reports.

The issue was discovered [1] by Sashiko.


Link: https://lore.kernel.org/20260525162256.8317-1-sj@kernel.org
Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org [1]
Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Fernand Sieber <sieberf@amazon.com>
Cc: Leonard Foerster <foersleo@amazon.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 8c6d613425c1..c3e4c871b0bb 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -32,9 +32,9 @@ struct folio *damon_get_folio(unsigned long pfn)
 		return NULL;
 
 	folio = page_folio(page);
-	if (!folio_test_lru(folio) || !folio_try_get(folio))
+	if (!folio_try_get(folio))
 		return NULL;
-	if (unlikely(page_folio(page) != folio || !folio_test_lru(folio))) {
+	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
 		folio_put(folio);
 		folio = NULL;
 	}

