Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273508;
	b=NRDeC2yE+vy0os57BOwBhwTzb9haA8kw4kAfiyn2qOolI5nbjHjDm+hlXHcfB2K/R5lP
	 zr3i9B/vVY8FZQVmEyirH7Kqw7zxeD3x+8xSk5kdl1kkVSetFLR0+ZMD7g1/4hUrtHUVa
	 rBswAv2nbunpmXkyAPqLwNBwKSz/FmzWxygrdupBsQNxWx3fXa0NlSlnx97yMMzRSYzGw
	 tcBHPPjrW3viclDVZYwgZBJJ3FOPOkdbtYY9gi5EjvuGreZZV0OdxgeAn/KO9MIwVRBp7
	 JNkGwcZvlXjvpfdpWBvJe1wDTKuJV56FwfUA7eiahncNUhftdYKYroRwHDDqQwqIIkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=85abFPcAxFzeE6x3PHaM/IJL1iN7ENrb8stsSwVYaxM=;
	b=YWwfEaCjVdpDCpteGkaXDiPQ7UvUZ3Ha2d36+9EEnZ4chJNEKj2mAxuzitoIMFU2BFRx
	 jLebVmdHA3fth9dYhWcPvbNRrwG2FCAAm0MmmV6Jft3xRkUIlvYh8AQ5d2Imr5P+DI8LQ
	 Ipa5URwdc8mKD+WuJdMhAIyMKZHGKvFr5YZLH/0czgTthXyJ3g+H5NSb6Ccno3w2WG+AD
	 PB8HFasCgg5lby3Y/ebfq5wJ2fxN5xYvZ8RyBDivRKi3Iv+yYV5X9MvWUhN868D5AZOqw
	 7xJoqFStMgQkO8YXJTFv2FEiir2V2xDg9dgmaICMe6bagRBcV/2KqzuktxbYLt+lc/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0wHYMtq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218CE606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0wHYMtq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1A91F0089F;
	Tue, 10 Nov 2026 01:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273508;
	bh=85abFPcAxFzeE6x3PHaM/IJL1iN7ENrb8stsSwVYaxM=;
	h=From:To:Cc:Subject:Date;
	b=g0wHYMtqMUwfHcrg7lndb63u4kq6bubC+AdYdKNVebHg6031PmmP7OrlrXsGeOhEG
	 j5ir+Vk9okdvCPwtlO3HKa+KI6rA24jHl6Kp0GVWYWpeerTClHHQhGj4Tu7+bukWu0
	 8qovi81td0uvu6nZRRH3YeZmlVtB+h64V2EgBg03IKNVrAcClJ8DJEtz4Cbg+fa56A
	 h4cvrhiCwYmpzCWcW2T4emJQ+Y6iYkmHg1nk5abxbSenww80RdMYHXJS895kO/n7Og
	 Ysep89hl9ZBcREoiwYAZ9br5RhwdJK2SzJf9ELZ/LGgcnK5Jp9j85zZL8dPwI+Jiui
	 bUPYieXcvAyKQ==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ljs@kernel.org,
	muchun.song@linux.dev,
	baohua@kernel.org,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:18:26 -0500
Message-ID: <20261109201826-failed-6.1-21a3888d3d2f@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 21a3888d3d2f87b7f15ccea1f0befd57346fe899
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201826-failed-6.1-21a3888d3d2f@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




