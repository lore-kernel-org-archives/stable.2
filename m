Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274086;
	b=u6glPLOVO50OE1taizK2eE8bYFfpc4kcP0cryGORU3OJiGjtVDN91IIaQZk6WrMYpB0q
	 Lcth939xvn+5mPPBrnWVAx8mcEIDV7mlXTf4y4VFer82eIoQGGbpHFAnW8fxuzzWKQLSG
	 xt4AWgq1VQ4r4hHcaZRtNbGgZ1EUQ+UMxyOaz15FSqDCqJ5PrVPPEW4Ge9erNX4AayB5y
	 ztxXzBYbjyUha0BH+Wzi0c0OEppnbr4AEpfa5/kVjGJScOFiCYgv7eHrxgirrUHGxc6PF
	 80Hr1yn6cRYvIvLeVQsJmZpJTvKQyR/GD9mOsA1aW8z91twCBxV8KoFm7h8QbTtZ6Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7F66Sd6gHYIuLABtYbqo5ZmXQVS6A/aMy4RqkjUvwFA=;
	b=UMHQQssJIOBoMM3B1mypw3WY0LGcaaz9O7Nl/2iN9Iu3ncVWaJT4+OE/G/3xz1X/NRQG
	 KWFEqZ8+F/Wf1aoj9tQUfHkKBiOxmcow+D45tdwqaLUSoJdyY0k+h9QCmADYA3whgkVkO
	 GUXRP9RBqkN3HV0s0w1wS1uzRe05plwP2VSlRJ1/a/WbxQtD9HtTrVvJjY1xYCKfrA9kn
	 W0S80eupIDE19XEAPk+RFsRrLdbj4pn86nd4FnY5D1GYmYg7fkQ33GKy4/GszeQN6pbxQ
	 4CXSXsm5KMy3WvgRdwJe3qrTOm49wlamfTmdJIYUrx/etnf54Cwc9tCjhIQWDShD3yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuTlPGLV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599F606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuTlPGLV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117AB1F0089F;
	Tue, 10 Nov 2026 01:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274085;
	bh=7F66Sd6gHYIuLABtYbqo5ZmXQVS6A/aMy4RqkjUvwFA=;
	h=From:To:Cc:Subject:Date;
	b=AuTlPGLVnutMyFE9hfzJqCFaaGV0Xjom08/VhpuG2oWZlPr+b1EasioqNuLTYnjQu
	 krF88fSEYIKpGPazgwjcF4ANNUEzM1WmfSTdR8vasfb6srETTmCJgQCI5yRc33MA26
	 ulQfi73k1mDQmjyYlfyV1UjrPq31/P6WI8wiC4vohtFeV6Ulmf1FnSwkktt4G/0o92
	 9j2MVqbSF/4gxjH0nq1Glm9T6ug6yF5K7/wwwf9zEERXrHTrkvPBuDihURvqXUINo8
	 JvD90p5BoSRe0k6NhF/NsnyxtQP8Ctaq8gKgpONVDhO4xeznGbf1MNTOSfGqZdw3Ib
	 sMqrWnFLtXsJg==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ljs@kernel.org,
	muchun.song@linux.dev,
	baohua@kernel.org,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:03 -0500
Message-ID: <20261109202803-failed-5.10-21a3888d3d2f@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 21a3888d3d2f87b7f15ccea1f0befd57346fe899
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202803-failed-5.10-21a3888d3d2f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




