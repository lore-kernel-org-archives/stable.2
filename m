Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046229;
	b=1HRMvjpVkfzJVlvBrWDiegCEE0znRrsWVsV1Pj6fOmIkIGPRSOT6kxyRMKA9L2nXWMPy
	 2u4JwdVuteUGmlC8d7CnhylEu1a5QIhjO3ejDdL1ELM7UH9LdA1xi8LVByBDJ6hky1ZeO
	 tBfi55nMUjjaFS2fLmhWyVw7eFbZpH1CV46HIPaaWDLztV61539dN/J4fhmwNzGOGuuHG
	 wk9gFuglO7hCPRzfepZ9YJYu9NYG9IEfkDk2S/5USiYqRSX8afU0gNyO9eTu+bofpPVlL
	 8ORiWsZn23F46wVCj+VCaYPkV8yNDKYUsZUhEspjralQGpCXP5UsKzkjYOF/nKgIAMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xMeVUy7pJH6UcBaY9Qo/YxwUgwKpofQg5X62MILPnG8=;
	b=de5RVQaQd9w4rQsvOb7w6VGthwUvudtv5mejGJEKEbgNftp4CXpCqR74/ZCOTyrZMngq
	 KV1Y8tFWsFJqfnYdFJTdnZFh7xg+khHe6dq3oCrZdRvU5BTVqzTd3tLImzGwm40mYwx0+
	 ixVpyrR8I6y2+mh9kJm6qfOj0Js0jCTL9VP6XRWZrGHI8lEAPEG3MejkE+yXeJESd+1u7
	 yxjR6ooNmzHPDlvkzjtuJ/4eIckK8y0vgRg3E6pTdyTkX+2JZhBGWznZg4sajZTBrSbKW
	 297q+HnI8I/VlZ4IAajju7xSCPhXR+GWgZkpDf0lqyKySMhU7LguaQCdYNOPycFXeqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBfF7XB2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CD606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBfF7XB2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763BD1F0089F;
	Sat,  7 Nov 2026 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046229;
	bh=xMeVUy7pJH6UcBaY9Qo/YxwUgwKpofQg5X62MILPnG8=;
	h=From:To:Cc:Subject:Date;
	b=jBfF7XB2AxP+KFZi41MUyz/2hedfAo9MpdohYsw0dVigTb+PMPZ5SEk00RKDa/j9o
	 CGa4ejteCIaoauuBiQiHXW9MM5qt4Wh7rB2T1HlvAacmP88Y5bN4m6t5kRhev2wK9k
	 gJnINLBhz0vbYpZxepd/SIp4d7UxdPSnAKOLO84XIfVgmejJdL+Y4QeYmvfC7nW53b
	 Ipie4B2XeGJ7RP+XMlRZsJBLWRqNOZz+43SQBx46SM8BWReo0DpwLDUrTaZPzYrrEq
	 HHiJwrvvPvcquKGoh6PrXM4cm4I7tS+YLeR3VzgIK/jb7UHsbJ3c9gPH9JT0iDRTAi
	 upF9Mc+rQFdLQ==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: drop centralized filter range arg validations" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:27 -0500
Message-ID: <20261107051027-failed-6.18-1d2397b2c414@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051027-failed-6.18-1d2397b2c414@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:22 -0700
Subject: [PATCH] mm/damon/sysfs-schemes: drop centralized filter range arg
 validations

DAMON sysfs interface is validating wrong range arguments for DAMOS
filters.  Now the core layer is doing the same validation.  Drop the
duplicated validation in DAMON sysfs interface.

Link: https://lore.kernel.org/20260914142327.92510-6-sj@kernel.org
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/damon/sysfs-schemes.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8c8ab82c8facc..a4ec5d54cfbd1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2832,27 +2832,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
 			filter->addr_range = sysfs_filter->addr_range;
-			if (filter->addr_range.end <
-					filter->addr_range.start) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.53.0




