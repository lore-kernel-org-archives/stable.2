Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597044;
	b=fs3920V6jQlL5SNMfgx7WQWqjRxQA9UdEJtIZrbt8wNOA+E7aNeKC29LVKOT2nQNSVIP
	 DdTR9ODdiXjR80Oxp6NoEdJ51GvSq/z3HL9o4HJ4VCVc7fUoeBzICiHsyM7F+5xjdLJAi
	 aMNCkMzYMXYgtqdMGnc4njVjrCGSAFJEv8jlY7WGtqsIWDuV4+emvtipLY9lL/ACWsN8C
	 lVzXW6u58gEA8z5q2RGFaVA5OLs6bWSwxDuQnZ6VsRI5zR/3446pcV3A0Ps13l4NHEvWi
	 Ux1gSgIYeETbeBCEqduAEb+wTDBhK/yVhDRqO8E8jUNapxA9XXLXEvD3RnARFeRyxhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597044;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mrRaZMJ6oT5ehtz2KnGpKZWdK4+wnkSsQrG95A5YG4Q=;
	b=aPpz1gXhiSUyM2UTb5C7Qq/EflzPLCuPqNysoRNX3Byv8QyXJQfhkEBwTWtTWTv56qqt
	 WEAwr6onIX1RFkZ2kfZbgZ03QGPSLdUYm+mZJJqschvNctsivC4nChoSgiXmhLX8aNEOU
	 VdZaLO0XoizNFk1zbRO0Ay/3mOCpJ5glySPq9mVejblDIOUhesRDeI8KLy3Iw83L5sQci
	 rgffTj9Cp1H8wuPfOIXtMmo7sQOWs2+GnVtue4uI5+yB7rHIaq+OJooKqK4/g6TVVWj6o
	 YhgQZv9oZkkmN2TejvEq0IBJnjfG63w7I4y2duvk19YTfAKVjmmM4AjeovGSxZARMVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrXlKJ+Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C770A606A33D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrXlKJ+Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BDD1F000C4;
	Fri, 13 Nov 2026 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597044;
	bh=mrRaZMJ6oT5ehtz2KnGpKZWdK4+wnkSsQrG95A5YG4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrXlKJ+Z29VhNvL/UW2jGPJ6Ys4vRUtPbVDuoGL2XEX+gwVe4+WXu+BWhKPHTNonH
	 8QoCu3rTqApqpQmQHS39jK7vt7kYAYOGvhFWs0l+7JKste55f6Dy+XcPSPaystC997
	 b2JHmm6fNXyiWRDZljJnN5mAxpoo0bJ6JKbvxvXcMLiiQixw0XzFz01xD2Gl49uG6X
	 ITgRWin0tpWRx0hC59zd900zOo8Hy5QZcjXcMZ8Y325aG6MyOwXDvYrFmvI/Ky7fhy
	 8/wmyK0lEmX0FgX7ktf04Crvu6or8xc4Rt88W1lPJ8OBSp4NJ5gNGzmnJC1IwyMAoG
	 qADJxNesBtefQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Harry Yoo (Meta)" <harry@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/vma: don't leak the charge for stack growth
Date: Fri, 13 Nov 2026 14:10:42 -0500
Message-ID: <20261113160252.1972556-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200926-failed-6.12-b1ee87802111@kernel.org>
References: <20261109200926-failed-6.12-b1ee87802111@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit b1ee87802111156e27557e82acc31fa7dfc76e2a ]

acct_stack_growth() charges stack expansion even without VM_ACCOUNT.
This can happen for read-only or MAP_NORESERVE mappings created with
MAP_GROWSDOWN. Unmapping these VMAs does not release the charge, leaking
Committed_AS.

Only check and charge growth for VM_ACCOUNT VMAs, matching mremap().
Unaccounted growth skips the overcommit check while remaining subject
to the other stack-growth limits.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-44-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Replaced vma_test(vma, VMA_ACCOUNT_BIT) with the equivalent vma->vm_flags & VM_ACCOUNT check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c930e03bd7997..e2c51c6ed83d2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1040,7 +1040,8 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 	 * Overcommit..  This must be the final test, as it will
 	 * update security statistics.
 	 */
-	if (security_vm_enough_memory_mm(mm, grow))
+	if ((vma->vm_flags & VM_ACCOUNT) &&
+	    security_vm_enough_memory_mm(mm, grow))
 		return -ENOMEM;
 
 	return 0;
-- 
2.53.0

