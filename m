Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B861624C0;
	Thu, 30 Jul 2026 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373714; cv=none; b=C8vlUvwYsUUm7YH5ncNbDGfJh8C+g7OfFyroFVhhkLM32tXqg3irbmZMPAOlpXDWkzezfimf8GRCY5CxSsgo410UIoQxkdjIRaQU7bdudV2pLjjbChvOLlRAvlrRy+ltj3PqZHupliYJrnLY22WA56m8BCYC0SeVhDUJdVFnAE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373714; c=relaxed/simple;
	bh=NJmnQ5b7V5HSWqObbMDdyUKlBzo03jZQJfGRvyOggKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clgmKl9QlS4BQ8OVIBmD4yD0ttgdOd7OX01cdOeKbRQ5QOZp6jNs8a8sPA/Cjgr2lO/tOGdfOzCOIT33+77TYHSILjDYJIq9GzkrTgWQTLkZPqii3Zqjw9D48pFttmQZwKLn5qtWqCXMtlZW23aCHexdIp/Pns6cpBWiVzpIfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3Cw8R5w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3Cw8R5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7B21F000E9;
	Thu, 30 Jul 2026 01:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373712;
	bh=N3ih1Ca3VFOYZqGwyWcqvXTeWeLXvuc94wtduj0b42k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A3Cw8R5wLvrrQk7tWag/GjHX6Wrt4N/IYU6+EysA4UVC1FsZTVVaago1czPD2GZjp
	 gorXWNbxe34mAnpwHIuQ9mFjY8KSKJitmVLIR3hZQ/Q3rHwGXqq0zhoUFXbClQSV0H
	 FAsQ9Qw0fhQpBSRr/M682vE0uA5wFqi8nVzC9xV5OudUlEVzN6KUPrN+kILmsdYR1h
	 HTQezrqq13x5ASgxbOQLq1wOkavYaS5VjtgVAdZPQGCvOkHcKdpG9lbzTB9JlNf7ym
	 RRZwyjNfXJLXWp0BCyGuACnRKMk6WhE8KYbc0MB2dugPFPOCHf9tY0HP5NYww3Stnp
	 jpMxfxxb5LKzA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/core: disallow overlapping input ranges for damon_set_regions()
Date: Wed, 29 Jul 2026 18:08:23 -0700
Message-ID: <20260730010825.122432-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072943-comfort-paramedic-aa3b@gregkh>
References: <2026072943-comfort-paramedic-aa3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_regions() assumes the input ranges are sorted by the address and
don't overlap each other.  Hence the assumption was initially to be
explicitly validated.  But commit 97d482f4592f ("mm/damon/sysfs: reuse
damon_set_regions() for regions setting") has mistakenly removed the
validation.

This can make DAMON behave in unexpected ways.  At the best, the
monitoring results snapshot will just look weird since there will be
overlapping regions.  DAMOS will also work weirdly, applying the same
action multiple times for overlapping regions, and make DAMOS quota weird.
More seriously, depending on the setup and regions updates sequence,
negative size regions can be made.  It will trigger WARN_ONCE() if the
kernel is built with CONFIG_DAMON_DEBUG_SANITY=y.  Depending on the
monitoring results, the negative size region can further trigger division
by zero in damon_merge_two_regions().

Note that some of the consequences including the WARN_ONCE() and the
divide by zero depend on commits that were introduced after the root cause
commit 97d482f4592f ("mm/damon/sysfs: reuse damon_set_regions() for
regions setting").

Fix the problems by checking the assumption and returning an error if
the input ranges don't meet the assumption.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260703165610.92894-1-sj@kernel.org
Link: https://lore.kernel.org/20260630041806.151124-1-sj@kernel.org [1]
Fixes: 97d482f4592f ("mm/damon/sysfs: reuse damon_set_regions() for regions setting")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 954157679ec34661c2e87e7eb796104a797c32db)
Signed-off-by: SJ Park <sj@kernel.org>
---
NOTE: This should be applied after
https://lore.kernel.org/20260730005145.104960-1-sj@kernel.org

 mm/damon/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4ab1ed472fbcc..70ac1f08753d1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -213,12 +213,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 {
 	struct damon_region *r, *next;
 	unsigned int i;
+	unsigned long last_end;
 	int err;
 
 	for (i = 0; i < nr_ranges; i++) {
-		if (ALIGN_DOWN(ranges[i].start, min_sz_region) >=
-				ALIGN(ranges[i].end, min_sz_region))
+		unsigned long start, end;
+
+		start = ALIGN_DOWN(ranges[i].start, min_sz_region);
+		end = ALIGN(ranges[i].end, min_sz_region);
+		if (start >= end)
+			return -EINVAL;
+		if (i > 0 && last_end > start)
 			return -EINVAL;
+		last_end = end;
 	}
 
 	/* Remove regions which are not in the new ranges */
-- 
2.47.3

