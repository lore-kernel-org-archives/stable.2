Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597536;
	b=QwogY4tTYJDJx832Rv4XIW4h+xWFkScxWvdUeN3v7ENSmBqBAWljZn089E8EqJqogwnt
	 j6+0CfflaUW5IT/noiQ5c94ePZ28N9UMVTOae6pyDkbzrDI/AuBYssF4g/YdEMUupRgt4
	 FkHMBSRxHUCUPJ9hRk8tdzHTIeXcAb4W5n02+2pVOUwzLldFyVxx/tqmCY+7HViRqqG1d
	 wF4vXCJd/9aIzNR/hAxUIrL2Rck8QePKjDcP/4JrMj7MgG+MCLW0qPcBXMW0aW3DJhdhj
	 fenG0eaMTHedmn9z54Ei+xogn5PAiZYdnvlmmTrJkNcOUPqvvKtazfqft3uRgPMpsHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597536;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aJB/2X8l5COcDY86rIjqmviE06415T7DkW3kaDyXJZo=;
	b=Gf9sH/kAHJcmIy66i+7//EN6vXPlXRv5Xm0pnwLUj/K3KkoXpVeQsLPwu/RrActpc9Nc
	 U+cpWxo/+cLFsSCcEc37L/3HRf8kw0JEHE/NhieMUVSvExmE7nXuZEVOBd0s8FSX/329G
	 yq70pap/MgWIF5HbDQlQejbQefVThK9iSE6VY4PzbmxHVTpsgHNYKXTSyEJE66wLNR3h2
	 mlBDAZS6UZQPrG0bdb+NrNH/jrRA1SDtbqgiBSmgcjxJadh+Zs058pxciWrewvDaj3NwJ
	 GvParvRpp14+RyQqOH8YkaSkNAT24OGU/MLqjRefYtmX7z7Fj8CfDWc2P/1e9c+Gh4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJYxfArd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B64606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJYxfArd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B430A1F000C4;
	Fri, 13 Nov 2026 19:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597536;
	bh=aJB/2X8l5COcDY86rIjqmviE06415T7DkW3kaDyXJZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJYxfArdNDry1W9BvR/ur4gTBptwDVFbaUmWh3mXqHp6HPW29AvmOit5jtQgQ4pph
	 3GZ5kQ9VR0yWQnFdfwbKqd9UpFJW4sjkQBeUIVEbvIfuBKq0FMtE5rgnHfXKdtpm18
	 gd06dK6pgrTvENqlK5Y9ymHNXiTfSYH0m2G+WEa48SWFT2ID70YcKlb45zHoeoZ0Rg
	 wNN6cfHUB8g0/QJjESc7qiNJI6GJyfxC+NJrAJBlZTmufZB56+YPetnP9aAsvCIyiO
	 uzk11J0XbtLSAp7bFS6oWZ6vE/pU4Rcc9Rxk3RKOUbz8TErg6vOfQJMj0GfK6qy7U6
	 theheJDSeEToA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Harry Yoo (Meta)" <harry@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/vma: don't leak the charge for stack growth
Date: Fri, 13 Nov 2026 14:18:54 -0500
Message-ID: <20261113191520.2246763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201853-failed-6.1-b1ee87802111@kernel.org>
References: <20261109201853-failed-6.1-b1ee87802111@kernel.org>
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
[ sashal: Replaced vma_test(vma, VMA_ACCOUNT_BIT) with a direct vma->vm_flags & VM_ACCOUNT check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 471dbff3e11de..4138cc91827c2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1974,7 +1974,8 @@ static int acct_stack_growth(struct vm_area_struct *vma,
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

