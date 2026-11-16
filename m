Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811002;
	b=Y/ukEkvqbmPtkoAo/LY+EIg4Zmqg37QmNW4He40/JL+3OgwDTbtkN8UW2nNA2j4yYbkQ
	 Xh3C5pjYuUvEwHmmR28Ns8OXbuz/B6Xj4yQHGJkhn5BwThoJzwhTkIbjWjPi4y/zoKW3B
	 muzPgqlMfkOPIu8LDhbvxGLc9nGNkLQazOr8tuzyk6EKSPZzxPeXJ789O3xSwfg2oW+Vc
	 cn9fjHw+VEpgZpRzT2dgHHp0ggfwq39R4bma22A02KdepDfOpIYc01tE+MuumW03kQFSd
	 AQxzBURaOaewHQjr9ycRbul+tuJaGqYWytTG5tGCX66P3uDbqjtHo4c8DKDHf++ggYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811002;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y5zoxUgTuZ5PnFPOT8698Pc92IH4J9fnPH5OLYH4+2E=;
	b=X1hxdrs49hS0Gb7uOgdl7MLGmzZ2iRtXkOU1wTJ4Oc8nUcdu/W5DtR+fCeENg46IK4o/
	 PTVOFJBYbAHjBShK5grFbXrMxOM53DO/u5Pv9IecWU7kPQbJy6hpjUa4mcBYowkQwdkW3
	 V6jufo5Y+v84HXtt+3Ip702LFGzuXSlcMgjTBG3kbdo+6/ZPBqMPJ55fSuOucUBB9Z4uq
	 9TxhJIC2qShPdoMDbSh+CTYYt5APGeBl8u1aBlNQzSQS2XhtdXwSkbDxwD1UbV76EWwuH
	 0Ec7fvB3mcjNqJJ3iWmzIWho85pW+SKFmwx2IukW99SyODotK6A3Rf3/jcOHsaY4c1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nnFTOXXp;
	arc=none smtp.remote-ip=91.218.175.79
Received: from mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F6C606A8A7
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92F6C606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nnFTOXXp
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/734QEm9p6S53bt1CqBXUyRtO6uKUnd0BWySzLsj+7U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794810999; v=1; x=1795415799;
 b=nnFTOXXprSw+7ZkZJXRX+5kba0sYilWNw+7bwX0Ohs6tX5jQ3mdwGHSmVNDV/LaczhXs7XlR
 I0w3zwV4zVicP/wQIFybiUu8y4+8tTvRPi8jCUwP/2ttRUOVupTPYCsoy5kpfe+JUnUx9dJo/zQ
 z/tsDJ2dWcoFE7OUkN+iSU5I=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id d552c4ece8e63456;
	Mon, 16 Nov 2026 06:36:39 +0000
X-Mizu-Trace-ID: d552c4ece8e63456
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	byungchul@sk.com,
	david@kernel.org,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	liam@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] mm: don't PTE-batch a swap-in of a folio with a hardware-poisoned page
Date: Sun, 15 Nov 2026 22:34:56 -0800
Message-ID: <20261116063624.1382944-3-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261116063624.1382944-1-usama.arif@linux.dev>
References: <20261116063624.1382944-1-usama.arif@linux.dev>
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

do_swap_page() checks PageHWPoison() on the faulting page, but the
large-folio batching path then maps the rest of the folio without
looking at its other pages. A poisoned page that is not the one being
faulted gets mapped anyway, and the fault that would have reported it
never happens.

Skip batching for such an anon folio and let each page take its own
fault, where the existing check catches it. do_set_pmd() already backs
off the same way.

Leave a freshly read folio alone: it is not anon yet and can only be
mapped as a whole, and falling back would free it with the poisoned
page still in it, which the retried fault can then get back from the
page allocator.

Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index d477a4f986bc8..51e72fb40655f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5158,6 +5158,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
 			goto check_folio;
 
+		/* A poisoned page in the folio must take its own fault. */
+		if (folio_test_anon(folio) &&
+		    folio_contain_hwpoisoned_page(folio))
+			goto check_folio;
+
 		page_idx = idx;
 		address = folio_start;
 		ptep = folio_ptep;
-- 
2.53.1-Meta

