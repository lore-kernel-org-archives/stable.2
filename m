Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160713A244;
	Thu, 30 Jul 2026 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374197; cv=none; b=iULbnn8jBTURvaP9i3QXs31mfAottbZQDKidmqaHeXEY2KWCnNRZHtuXVr3XeXo6fHqVIkSK6+WBxtAX3qth1OpYf7gX+MtUnl8a/eo7mRF1coWQFPFR4CRziutoTx4oHIKKxouEAoUf+2l0gqUlvSMtHPs2TbObot0nIpSdaZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374197; c=relaxed/simple;
	bh=lzStTUwp1wLtGvYfYR7u5w30dZRNhmlalElw59h482Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsIkVs5/gCkB0Mm5KlbF4Qiw20Xkjgdy4AWKK+eLM9x0Vyqp1jyGdMs84T8h1PsYkm7s3Klb4QIhOTkSaFdNmDQ8UZ6ZugACRRmbUAtU93DHTcL7cRB+q/UwprjX0ztBkcOgWEdWKSAUerVDdp20zPrkK4Eflu4EwRuB/D0DIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/GmpIEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/GmpIEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D5E1F000E9;
	Thu, 30 Jul 2026 01:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785374195;
	bh=xO5y1I21gsQGSFHb7idDe2+sgJNP+oggq2xobeXgzv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b/GmpIEu8ZPHUlEh0ZguGDTYtA8nZiLUHbojTaNsFlRwr5ASIWL5gWIeP4DBBQKPY
	 DPSASHfnaB6j9ut1JhaKLlvsU3hAwAA1gaZbRqkIKqsT6w9UcpZM7m2zXn79ffVqAB
	 FpKTm+30Qrj9DT3xaQOLUqlhzAZ2Mnl62T1Y+2W3vDacE12/h6X9tliN71ChveyZ7U
	 imU0TbDdT/8xyYx9esWbctMOUEwTjHsPcFPWHWqhCu2+9QFrKFQ4ftlWeYqzsgGWBA
	 0XVRplr/0c3d1ROBKgWcsQQhYGVq9vPFxGr70wLp3gt1KHA9bB1gtW461UGDa2u/bJ
	 32DKjSWN6AwpQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/core: disallow overlapping input ranges for damon_set_regions()
Date: Wed, 29 Jul 2026 18:16:26 -0700
Message-ID: <20260730011627.130930-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072944-dove-thirsty-518d@gregkh>
References: <2026072944-dove-thirsty-518d@gregkh>
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
https://lore.kernel.org/20260730005917.112632-1-sj@kernel.org

 mm/damon/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 437a52fd6e0ee..734ab958ec576 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -210,12 +210,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 {
 	struct damon_region *r, *next;
 	unsigned int i;
+	unsigned long last_end;
 	int err;
 
 	for (i = 0; i < nr_ranges; i++) {
-		if (ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION) >=
-				ALIGN(ranges[i].end, DAMON_MIN_REGION))
+		unsigned long start, end;
+
+		start = ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION);
+		end = ALIGN(ranges[i].end, DAMON_MIN_REGION);
+		if (start >= end)
+			return -EINVAL;
+		if (i > 0 && last_end > start)
 			return -EINVAL;
+		last_end = end;
 	}
 
 	/* Remove regions which are not in the new ranges */
-- 
2.47.3

