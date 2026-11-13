Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597719;
	b=HiHIz4FvM4YielDafKgDW6J6iGfw5FOnlLgPoSelfoSBdqJ2AsylGaN+2oa7O/y+vhBv
	 JsQ0dssFYKwXJtxlfauv9C48YvWPmZOcOXBKXb7prlrRWanbLNVOnIjrUeFMYNaPYQU8v
	 Qn+niEZnX8GsgqF0RE2e8HawTr1DhlnzfLOV80C1Ac/8zmIUxf+rUPdi8bPzVAHAPBT4Z
	 ndjgmqs+QojIvd022HtF0b08P3HNb30AGLRd2KXQYjfS5Ovv4p35O0JP9edb1twwaLjWE
	 aFaw9v26Lb6eSnJ9oRoTuBY+xPv5gleiYCjN/3stCR4+b1fJqCpHxJ3J7Grve1LVNzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597719;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yOdKuy75cRnyQs79xpy7O+gr46FbF871AIlY8d89www=;
	b=5MAJv4ULzbnj4Xy2R+OVie6nstdJZaJOGsjVtl1o48xMibyArQXThetZnRD87yiM9eK4
	 +HymBjpjlxQ3KDw8wyj2JJejqgoajqvvNfn1ZDNhySnHXSDnmyg+yt3+JSHSToD6eujnE
	 7m+1Vvrq93ivtTDjEXPId8+JffL/SLiqQIcrJB1MT0AnOJpOfuK2KtEcOGh1HP+bb9qm+
	 POOYFrAJhB077QLMIh+aCVbtE/1M08mkRgY8IJeLQtXgTinOEWnttSxK2RaSrU+hZCfck
	 vnHIiyGt7KGI3t42UsuBnSUxbXRPqmGcFn1VHS6r7sAlaf2JW0ny8a3fkGOizj87nug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9fZByHM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C9606A884
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9fZByHM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9882C1F000C7;
	Fri, 13 Nov 2026 19:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597718;
	bh=yOdKuy75cRnyQs79xpy7O+gr46FbF871AIlY8d89www=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B9fZByHMBoYaPUBZogYukSvvgDV9ibySbAQsZJ2Lm2V3jbr3mDgZQoYWg8lNmuBDn
	 h1BAxAQTWZ6TaLWRvnWpCBnLmLqgShoYwIt2/Hldp/C/MD0qATxuBIIZC3pxjbQ2ow
	 lffHm4Jq18UR7S5li/9wA28cYT3+O1k/ri8dxXXQLilYVrayP7ZMQrg4tvBxkxEek9
	 msl4gyQGTkyFI2hBRl5ClCTPoOM5WmZo3VsQH5FfCOwisf35YR8wg/q9hjy52wqiQj
	 8+c1loZ7/frIr3P9OXvMltDPj5UvQtgMK8SGZPw7lKc1j5EHkaz9YQg8XZwOqZY4qw
	 d2B4mbRS5s6Jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Harry Yoo (Meta)" <harry@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/vma: don't leak the charge for stack growth
Date: Fri, 13 Nov 2026 14:21:56 -0500
Message-ID: <20261113192121.2289844-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202824-failed-5.10-b1ee87802111@kernel.org>
References: <20261109202824-failed-5.10-b1ee87802111@kernel.org>
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
[ sashal: replaced vma_test(vma, VMA_ACCOUNT_BIT) with a direct VM_ACCOUNT check on vma->vm_flags ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 290822968e218..8b819f050ce50 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2399,7 +2399,8 @@ static int acct_stack_growth(struct vm_area_struct *vma,
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

