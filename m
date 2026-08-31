Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CB484255;
	Mon, 31 Aug 2026 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184984; cv=none; b=eEdD9fVGQ7aQhdGR0KXMgIQwfDdP/dD4Y1JtRIdAEVefSzkwjgHjBJAaY776DRB2q67Ran6whC6J/K4T1+wqjNmSjO21eDkO3Wrmp0LUlZF1VW2LfIqV//gypoLbPg2vHhXqu4A7TCIHJ0ruTEKA37MCQ21D1ghlwmz95czzfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184984; c=relaxed/simple;
	bh=35/yin/QF8t3Kqfg+UAOrsmVX85pqU2Iyl2wuXO5t+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MISSo033wv3cvahh5qPg8IT2px8UNwL24DUh67bVoYA25r+aDEsfcP/K+VX3wM9yrwdE8VrsVVNN9r9/pOAgxwjPTmvOl7lTgt5hIYPk1p30FXvPUBbVU9pPSTLQgZHPPFFaACUYnRWEMvfV9Y/SaSCruJOrc3C4NqH8xZvoYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irD4Ae4D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irD4Ae4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBBF1F000E9;
	Mon, 31 Aug 2026 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184983;
	bh=7ZB1yfEGzN5K33ID0e3bcOFkHhvifJ8hhhrNtAvrugg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=irD4Ae4DKcf8PeVHbMIoXVmCG2XKWzQmLktHoyVCc/ltspDG7jkbi1VoTpdxAMGrw
	 oEb7Xpdf3Fn6kS9cnBqas4zMMgM0LGPOyRcV5i4IQW5WjdW18jH6NGKAR+Gh4Oa4cw
	 0R1k0ICtEq6r/PKzIwLJQcuIcrV+y5J3NzWZzGl7jDAaaXfWZaWonfmraI2LYdS1wB
	 rWDVbqw5wgtHIqvUJAci4RFc/frCAhzqnU3V0k2h8ThWh1yTO81ZCBJmI32YtBadrF
	 eGyQDgWxzJM1pYctbEK+t4pRduc15P5dHwm92jbb/3JMWLkPXWSgHA8cMYlrVjJ4ih
	 RpmPGuf95qGpA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 2/8] mm/damon/paddr: respect folio end for DAMOS_STAT
Date: Mon, 31 Aug 2026 07:02:41 -0700
Message-ID: <20260831140254.72004-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831140254.72004-1-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function for applying DAMOS_STAT in DAMON physical address space
operation set (paddr), namely damon_pa_stat(), applies DAMOS filters to
folios of the given region.  For that, it gets folios of addresses in
the region.  It starts from the region start address and advances the
address by the size of the folio of the address until it goes out of the
region.  If the start address is in the middle of a large folio, and if
the next folios are small, some of the next folios could be skipped. Fix
the issue by advancing the address to exactly the start address of the
next folio.

The user impact is that the DAMOS_STAT-based page level monitoring
results become inaccurate.  Since the page level monitoring is supposed
to provide relatively high precision, this is definitely a problem.  It
is arguably not critical since it is only monitoring quality
degradation.

Fixes: bdbe1d7bc325 ("mm/damon/paddr: increment pa_stat damon address range by folio size")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5c6c3a597fd0b..2ab7b3842701e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -379,7 +379,7 @@ static unsigned long damon_pa_stat(struct damon_region *r,
 
 		if (!damos_pa_filter_out(s, folio))
 			*sz_filter_passed += folio_size(folio) / addr_unit;
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	s->last_applied = folio;
-- 
2.47.3
