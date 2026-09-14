Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CA3DD85F;
	Mon, 14 Sep 2026 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395817; cv=none; b=RUk1aHFln1xrXz90RtLYzf/VBKPRdgiHb2A4KqcFDRkEy1bFS42wvdxpmWyYnm6CtdbZ+UD2kwWqDlUjXTK+CfMyw/PLFxUIs/ugBzkWtWALWpG64ovbtc3+Dw7y8wlPMqnQzneb57CBxsCt7TQrwZ3OpS5nqgYi3rfYssibs0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395817; c=relaxed/simple;
	bh=gZK1bNR/6VsrE2g3Gf0chVwSQZHcPPaYBk/SDLvircU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzELhengw3WRyihzMsYbNF3xT9G4euZB2/qYuPOmf7L+sMBXEOVP5DCEHzX1fKmIjI3Oj7xGId78gbCwBE+UOmhbTGMix1WpwuVZXVYZSb86GG/HGs2ZZvnX78JuFrs4H7PDCAWYwOFNtC7rGFT2uZS+SXW3n4LByAotOXmgOMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnBIhXhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnBIhXhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727C41F00898;
	Mon, 14 Sep 2026 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395815;
	bh=umQcJFGrr068QYat6Lud6jcAzEmAFL/l4IbhvroBRbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UnBIhXhgSEQ7UU1Y7A23DFOancx7pojdDvKQJG3K18zt1+0sp17kaIancC0qgk1MB
	 P9zgKlEBxWUhS8wBlbpaotWyNZnDSf+dhF/27pMH4jmWVSo7prg8DURkYQZT87PIwc
	 OJhAUiuXPjlsZfJRSViZceuZVzfqqP9qrags/bDvQ59ntrEaY7rF+cdcdmLtlsWKgQ
	 GwxbjxomNNk5Sl/bDh4/NAbWNggLW84miZrDaFjyQvYDgRY3yadolbgvgM+8S1nDUg
	 8MCPy/K0o8UtR6990zfSxZ1V/xKVkXElsFjyYi2m11aNswq8wdN3L7ARKo1diDXg3o
	 OyB3o+HJZ+tTQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mm/damon/sysfs-schemes: read sysfs_filter->addr_range only once
Date: Mon, 14 Sep 2026 07:23:18 -0700
Message-ID: <20260914142327.92510-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914142327.92510-1-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface reads the user-provided address range arguments
for addr type DAMOS filter twice.  Once for validation, and once again
for assignments to the variable that will be passed to the core
layer. If the user updates the argument in parallel, an invalid address
range could be passed to the core layer.  Avoid it by doing the
assignments first, and then validating the assigned variables before
passing those to the core layer.

User impact of the bug should be trivial.  From the core layer's
perspective, the invalid address range is not really invalid.  It just
works as having a weird address range.  No critical issues such as a
crash or a leak could happen.  And sane users ain't do such parallel
arguments update anyway.  If they do, such racy behavior is arguably
somewhat expected and deserved.  That said, there is no reason to keep
such races.

Fixes: 2f1abcfccd86 ("mm/damon/sysfs-schemes: support address range type DAMOS filter")
Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3de4d804e049f..3c1c1cb387fec 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2831,12 +2831,12 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 				return err;
 			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
-			if (sysfs_filter->addr_range.end <
-					sysfs_filter->addr_range.start) {
+			filter->addr_range = sysfs_filter->addr_range;
+			if (filter->addr_range.end <
+					filter->addr_range.start) {
 				damos_destroy_filter(filter);
 				return -EINVAL;
 			}
-			filter->addr_range = sysfs_filter->addr_range;
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
-- 
2.47.3
