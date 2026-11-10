Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273127;
	b=sXDknWEyjWGwItC72r6PPMHun+r/XuDk39XHRV7A8CT0PwksOLfl7vSSP51hRSsb3sRe
	 jEBOxIHG4HWn9yjRe7ij0hXXB7D5hoSMS2CwRDiC19oGTw2sVTqVxFwwjE45BVtheSwmK
	 ZcEcbAjAO8hNtz4SbWXJRecgvL3WWeddOz9qPjtOjTJGVCCKhS7bsWpOgngquTFoYRuuM
	 dAMvdrtkdlfI9xscXWWRjQOii/bLmFUrGVTwzuP/gbjgfKHOSUYO21Ulvhjei7P15++47
	 qFeGbY1Gwdmai8PZ+So/EziICBBFaY7cW+emhrIqw3J/h0RzCR31OqsJoNrLOV7xjkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273127;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oSacK6NIcJO2km1kuHYWCD4AqH7qwVrN+MvhNKDzE4E=;
	b=xT7ImL+qn6W8zs/p5vf9dHd6baaa13VIa2gwibiCD/oc25BhhpP/2fr6QOinWvwAF36J
	 Va4YTp+14CYMGRTu9wplSlJJPKM7IBcgKkaZKc3agxDK4iJN37Eumx54FOvk9IkcxZEBr
	 GJo0G7KGdQm8yQKZAhTC1GDXJrsGq8sA/c7jI3DVwzRKuQHR6IBMoEtu4zV+LGRreOO9x
	 KZoKYo6M1ZTu9QAssV/t5j/iFSE/KRlalLfuudNbz06BCyYyOMC7jGKBatolqeN5WbtTb
	 iBCOrRC7geNgtN+A1zOuGPcApmTYu8mzt3uP/df0/hqAfjgeg1tqI3nMMOHYo4BXskQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kedSVI+o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C22B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kedSVI+o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916BB1F0089F;
	Tue, 10 Nov 2026 01:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273127;
	bh=oSacK6NIcJO2km1kuHYWCD4AqH7qwVrN+MvhNKDzE4E=;
	h=From:To:Cc:Subject:Date;
	b=kedSVI+onkTydc+SYJvS8EJGqhYZuCcV8Vkq2tV+181aPhEH9p9sIIFgOXQDaaPpy
	 rOg9LblkiJve49PE5Llfq52EQ9suVvFUxoavWNk6ocm62i0DBZY5EBnyIIYpGLcGPs
	 uKtaCbVOYoMXgZ1QRk20oZwM82GAcVJ6ECBmzh5AGSdJIYUJOkyecSnFk7/aQVn92n
	 jvoJKAbtI/GqId3GGylEeTC+ATZPY7vx0zUtp9WFOsKolsPTuAG05KBDnz6ngbQLx0
	 zLGSbnBnLzoSmf7QjEny+FYBV1+xhYoEnXn3MC7I0L1oXL6FpYt4fPwQxUn/OljSb/
	 Fn00aCHhmh/eA==
From: Sasha Levin <sashal@kernel.org>
To: kylebot@openai.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	hughd@google.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	usama.arif@linux.dev,
	willy@infradead.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/khugepaged: flush deferred unmaps before dropping a failed folio" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:12:04 -0500
Message-ID: <20261109201204-failed-6.6-854e5ff8b3ce@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 854e5ff8b3ce2a776586cabebaeae645c992345b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201204-failed-6.6-854e5ff8b3ce@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 854e5ff8b3ce2a776586cabebaeae645c992345b Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Tue, 6 Oct 2026 21:10:01 -0700
Subject: [PATCH] mm/khugepaged: flush deferred unmaps before dropping a failed
 folio

collapse_file() can fail its reference-count or dirty-folio check after
unmapping with TTU_BATCH_FLUSH.  Both paths put back the isolated folio,
then unlock it and drop the lookup reference before reaching the common
try_to_unmap_flush().

The page-cache reference does not keep the folio stable once the lock is
released.  Another collapse can replace and free it.  With its PTEs
already gone, that collapse cannot flush the first task's per-task TLB
batch, and retract_page_tables() skips short or unaligned VMAs.  A CPU can
therefore retain a user translation to the freed folio.  This has been
reproduced with unprivileged MADV_COLLAPSE on a memfd.

Flush at out_unlock while the lookup reference and folio lock are still
held.  The common flush continues to cover the accumulated pagelist on
both success and rollback, preserving batching on successful collapses.

Link: https://lore.kernel.org/20261007041001.43181-1-kylebot@openai.com
Fixes: 6d9df8a5889c ("mm/thp: collapse_file() do try_to_unmap(TTU_BATCH_FLUSH)")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
Assisted-by: LLM
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Nico Pache <nico.pache@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
---
 mm/khugepaged.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4b71d010b2aff..da91762f6358f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2467,6 +2467,11 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		index += folio_nr_pages(folio);
 		continue;
 out_unlock:
+		/*
+		 * The folio may have been unmapped with TTU_BATCH_FLUSH.
+		 * Flush before releasing the lock and our last reference.
+		 */
+		try_to_unmap_flush();
 		folio_unlock(folio);
 		folio_put(folio);
 		goto xa_unlocked;
@@ -2477,9 +2482,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 xa_unlocked:
 
 	/*
-	 * If collapse is successful, flush must be done now before copying.
-	 * If collapse is unsuccessful, does flush actually need to be done?
-	 * Do it anyway, to clear the state.
+	 * Flush before copying the folios, or releasing them in rollback.
+	 * This is a no-op if out_unlock already flushed the batch.
 	 */
 	try_to_unmap_flush();
 
-- 
2.53.0




