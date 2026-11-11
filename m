Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419402;
	b=42S3Irq9hFlNk2YhI+uXKRkXz6qvEU2FxuAd6D634Hvk/WSW/80IQ8XyrUzClElGOK7/
	 N6et5KsekP/ex+Bike8pBVZK9kdOR94w9OxN75jGWV13NOWLJt5J19ANWkL7yC+HjIhtO
	 zrFcgSJxFItUo7tkz6QQVdZvfB36sz/12U5v0K1TJrHCmrO2RGGm8l5F4g1NjgNjcOABO
	 H1gWUn2X/CnjvSC1ynaUNsoXISKV9fV2V4ldmNfvlFWvMacoeQ5Ukbr4ty88zprekwA6i
	 Nk2ornFTibgwW4OOHFZP9ctVA/bbIQKHovBScYijf6TTpdyEiOLZB3ol2Omf7m6+ppw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419402;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dGSSrsltGu3YoArYKQxdKd439Q9tXLkVKgzBuJFs6os=;
	b=N7EpFTMTI+i0WDWosVX/Qku4fv3OGcRCiiu3zeYLTQDO3qamGJ7wuxyjCHs0mxGqfyyH
	 nKaau4NnXsQ1Ap/SJri4nVERKSEfX11Rp0GSPyxoc2snOVJAIF8gjk0kF/Pq8pLh62EFt
	 jv04sKPHxuG6V7W/Y9jIrcHQ3sTlXBHw+yfkMfSRBg66JlknCKVR0Z1oHTNKV6XkDb2Cd
	 uAnn9RTtzeu+I+ZoW9Q3v/q2jUeXcxpUefSeteVhF4SBwjSxXpdDh2oRR9zAOevvEYYtT
	 1rReu3l4w6lI6hWEjkurcwsef5NFq+yx0LIckmqc6HztcRGUk/++ZkXEmQvC54qerRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TMxIZ/gq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0635606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMxIZ/gq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F501F00A05;
	Wed, 11 Nov 2026 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419402;
	bh=dGSSrsltGu3YoArYKQxdKd439Q9tXLkVKgzBuJFs6os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TMxIZ/gqUA1zwk1DXVIdoEZsCDCmK+JVbLc7FqGsbceo8GOK1vrY/j7tD4UT2l4OS
	 vM/IQn9RASPJxsVsKi2TloB+eGRS8TSPR8SM+D5KxeO/7QWYSq7Nbs8CzWD0KxIcS1
	 F5z37UdjjrukHjBGNWfFcHGcsRZUmih8DB9bi6+nTNdOZ4ocZgfCZjjdKiMgZNMuxm
	 VlT2l7iHwAoYY608SzBt8BAp3rMdeowQVSz4+nNjvH5cqNg9ZIcS8DImnU7pTFK7T/
	 jmURVs9WYBaTfG/5Fe8r4jO2a9IYVQ9ZOJ6gdH7hvCPRVxC6s/n7hanRRjFtuh7+sU
	 A2eWS9/he5mXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samarth Narang <samarth.colleges@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/ksm: keep soft-dirty when merging a page
Date: Wed, 11 Nov 2026 12:49:59 -0500
Message-ID: <20261111174942.3699316-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202210-failed-5.15-2efc6332f18b@kernel.org>
References: <20261109202210-failed-5.15-2efc6332f18b@kernel.org>
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

From: Samarth Narang <samarth.colleges@gmail.com>

[ Upstream commit 2efc6332f18bfd848f74f3d5ba45b31450601faa ]

replace_page() maps the KSM page with a PTE built from scratch, so the
soft-dirty bit of the PTE it replaces is lost.  A page written since
"clear_refs 4" then no longer shows as soft-dirty once it is merged, and a
soft-dirty based dumper treats it as unchanged.

Copy the soft-dirty bit from the original PTE to the new PTE.

Link: https://lore.kernel.org/20261021182157.1873726-1-samarth.colleges@gmail.com
Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: LLM
Cc: Xu Xin <xu.xin@linux.dev>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: adjusted context because flush_cache_page() uses *ptep instead of ptep_get(ptep) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3ed1bd6085f91..26d9beca82095 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1163,6 +1163,10 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
+	/* Preserve soft-dirty when replacing the page. */
+	if (pte_soft_dirty(orig_pte))
+		newpte = pte_mksoft_dirty(newpte);
+
 	flush_cache_page(vma, addr, pte_pfn(*ptep));
 	/*
 	 * No need to notify as we are replacing a read only page with another
-- 
2.53.0

