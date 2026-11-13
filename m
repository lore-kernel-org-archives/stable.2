Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583549;
	b=GvMVfwgdPviv4Fdb0Lose7fzmvmSnrcVGuhHh6aOGcBi9KUHiRTBTutM9u6AYB/UiTHe
	 r9Jz7F+xZV1QOqW6P242rDNe/eiDOCuE23qtNYaeipbbDNsdUKfkyjyKc8x4V2euEq/pz
	 qv9DBLLj5wPXOxQkOmikiY6l6n0zHs6DqRPrzoB/j9M2HLkihFGnsMWKaiUG4EzHI+7C1
	 0egx/jpXOGsqHfeqwq2e0Aom/s2iFMTgsZJWhFR+4ckQlNSZbdKKa9X4J+Trn082wx2Ly
	 tkZhlna05WiJnW95NPIeRJgYD2kvfDuF86o+FLDekIC+Dl9RLhAhBwHEBEcWGp2wHMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qRIxeRytAu34kev7BEdewjgF9J+Sg2Q/K++0oVSYnUw=;
	b=GrD4DKd6sSgaFFHst43yehEqf4Lve8n4yV74KzVUed3DFNFFrreViWgrlCeKpX+102e/
	 /AjyVXIESIzVFqYy0b/fb+105XyCG5uHLGjDgHxdltppfsGcOyNepVTMHntetc+uL8NNy
	 TGmjegrT6pPOujbbTWzXxKifA2X+8NSb02Wuir63RtWDCLZhRwDUz7Ag8f+N+zJ5Veb9J
	 CYxl6y0J0XJHDPnIe15U9X0WFo4+3LVfCeucA5o0QOUIu+dqfx4FJHMkZKJaR3LVq01JN
	 qbDWnRmN8rfXDEyfk76hOcNY5Je6PDOc6lpyRPyqWp7yM14yOmQpy3ge+kIU1nrWKOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+zlLFAO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68EB606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+zlLFAO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21BD1F000C4;
	Fri, 13 Nov 2026 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583549;
	bh=qRIxeRytAu34kev7BEdewjgF9J+Sg2Q/K++0oVSYnUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V+zlLFAOciIv16G4hJzCWoeiR3Ikd7aEJzoVC4wwMWyBKa8zx6RHYRs52eYWRWpE3
	 rCBZdPFWacqpCUoPvtfYgT4Ho5Rs0ww+2X0eSqg8rOVKXQm3kB4pvnlkNkX0FRL8yi
	 glL4SEYELjcwPTgKhfWcLPz0G2PHYwVbXmZDSWJrvvohk1+J6k8OteeQC0E6roIC9T
	 Rn9cHpCLUbV3PZGHUF8WlAkMarj9aasQSNjygVDq/25hwipX56QZH7bOzSy2ufjC6o
	 tw95magSbVwW3844wxk48vbrf9wTAelSynnhcWZTJukCn5wNzGni8c0kgE+reu0Fs6
	 ZvnCHFoDDwusw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Harry Yoo (Meta)" <harry@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/vma: don't leak the charge for stack growth
Date: Fri, 13 Nov 2026 10:25:47 -0500
Message-ID: <20261113150909.1841558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200520-failed-6.18-b1ee87802111@kernel.org>
References: <20261109200520-failed-6.18-b1ee87802111@kernel.org>
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
[ sashal: Replaced vma_test() using VMA_ACCOUNT_BIT with the equivalent vma->vm_flags & VM_ACCOUNT check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 0d4f344956642..1f062fa5fe742 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3068,7 +3068,8 @@ static int acct_stack_growth(struct vm_area_struct *vma,
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

