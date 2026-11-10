Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273806;
	b=FrqvAlqrh+kbdNPvdNs0AOQE4rN37D2UvZgbo4QwA6y7KVZaOgJ+xxIHfDje49b3T8cZ
	 83pETXaKVidkrHYb5JX2IO7JVrDUuu1u+yi/tOMpLugljxtwL0SJaaLH7IoP6Bdyqjkxu
	 kYbK5/bWNUY4TydhOF2axQqVeXY9Ap2r5FSMv7VmtTbH8oWeVDczBZc1PtTN9DAFKnOIh
	 SBvVnmvXypz0gRMYdxXhOSA6mqFOpTx1WjqLwfAyv+y/sVPikvD/1EnYcQo9pGPTtb3kr
	 e8sA1SKM0/D5w3OMngn9wE9kgoOOQjWnSyzVgseH3YHJXMz9NrZMwNvUika1E4UKSuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273806;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eBO6p7EfrF8TLvU28GBeZs/T00esIKcQUcDe7XIgfN0=;
	b=IHZYjx8dxhZdLIFyVCmUIf5Bem/FZmOBkfG+5B6EM87/CCki95OEJHg2jEP7TJUBt2/m
	 riLBbTpF69Lb8YZAnuZSsznDs5Tk30A1gfZC+kWe2jeLLxC1h78376fVk0nrIwSFChS6B
	 GXGgdm9nLGwwGdbqIlRQwyaCYJc9yVaIMUXumWu/NA3cTMRsdwJPa+waLOi9hdi13yAmJ
	 yGAbJeH5nD0hrV4XVPko0ZtxYrPkKjTWpfgn18FD7HHlXQgox1/G/Bt3EfQ8ucYQuvqQf
	 eHkwUlNf4QjRcn8Oa63UhuHY4tSCmrtaV4zSaSrlQBvWD1cKHJ93eVYRaPrHzdTiz6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuAuYjYx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25876071843
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuAuYjYx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F13F1F0089F;
	Tue, 10 Nov 2026 01:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273805;
	bh=eBO6p7EfrF8TLvU28GBeZs/T00esIKcQUcDe7XIgfN0=;
	h=From:To:Cc:Subject:Date;
	b=RuAuYjYxJpTOKSDJiipRSJdOpUtCWV83lTLvlykZBfV2m8pLqRqsu0MJcTaZvIAL/
	 yXaywWtpPuw9y2/TLqLqDVPlP74e95TtGG7H9cPnqN8ZozPnWhKPbvppPMe3+SyLsj
	 tOXZlX4Fsa44Xzj5YunuSlRs/hS0V7ESuASuAVrvxaRjlwO+YPd5WoVnVffJrHs6bA
	 Vr1KNnvD87xzBqXtgrOLM0vI9wh6+wfCrAlVkfRdPnystNrvXRNcLn+JxlNlden3jf
	 ojYE9WqYFKJsFV64SkoCHLcXxTDe7IKIpeY0ov8GDbBzNVfLjRx/SXk4pQHKfrtaY4
	 AKrd5XS+VuX9g==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ljs@kernel.org,
	muchun.song@linux.dev,
	baohua@kernel.org,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:23:23 -0500
Message-ID: <20261109202323-failed-5.15-21a3888d3d2f@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 21a3888d3d2f87b7f15ccea1f0befd57346fe899
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202323-failed-5.15-21a3888d3d2f@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 21a3888d3d2f87b7f15ccea1f0befd57346fe899 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:51 +0100
Subject: [PATCH] mm/gup: check for overflow when converting nr_pages to bytes
 in GUP-fast

The overflow check in gup_fast_fallback() only covers the addition to
start. The preceding nr_pages << PAGE_SHIFT can already have truncated
the length on 32bit.

Users such as RapidIO's rio_dma_transfer() can derive such page counts
from a 64-bit userspace length.

Let's just check_shl_overflow() to reject any such overflow with
-EOVERFLOW early.

Fixes: c28b1fc70390 ("mm/gup: reorganize internal_get_user_pages_fast()")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-22-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1c2ac7c66c309..ba4907b352323 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3225,8 +3225,8 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
 		might_lock_read(&current->mm->mmap_lock);
 
 	start = untagged_addr(start) & PAGE_MASK;
-	len = nr_pages << PAGE_SHIFT;
-	if (check_add_overflow(start, len, &end))
+	if (check_shl_overflow(nr_pages, PAGE_SHIFT, &len) ||
+	    check_add_overflow(start, len, &end))
 		return -EOVERFLOW;
 	if (end > TASK_SIZE_MAX)
 		return -EFAULT;
-- 
2.53.0




