Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048424;
	b=UH5pv9QaBMY6WhBvBbocQKLTwk5srF65mvFxm88aVY1ywdgq6xw5eLnC0J+8IDu02+YC
	 SJQ2Sw5900O7SaqhyUXCNrvc57yMKek2oNKIcn6FDNaP+f8dbK0YM4Pud0UMmvBSeVcBA
	 rWONlyw1NACG4FiwpgYGgJvmu1E/HSVUG4NxDuDUDZlxBF/MeAd3qqj0bN/RtPZCuVpUu
	 gcWtW5Aurj7J+MWMiJWhRQZ8kz+vHTl9tXORR+l2B+qNQxiQQuZZY11+bSVaQahjWyfxo
	 UrHKnIGCZRcQjEVlSthuZU3j81IzZDp1XYZt1V4+B58ug47ZpQMDrBaxM8J9T5H1Yhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048424;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TLnNZwiGG1a5uB6e7dcZ/6Gauac5d0yfnebweAWPVk0=;
	b=UQW3AIiJ+UL2xq+WGKm1efaHSjXuTA8bPqMTKJNIAJEEfuQXISKEhvhA7N+lgTDYZ5C0
	 OLodB9w/IiLfghCTBA+iqQa5qIj1Xryxh/ZDpO8tHFwFvA2a1e29j/aC9xxJs+zgbDSVO
	 /wlJGWfOJLzKFVHyEjhrN6BQXz9iySne4eim/Muk41RUA6Nmv7x0HjvrmYdxDguMS0+QD
	 5enD+xgHe51j7jDEzFVI93NtUDwKpfZDFQKqUc+2nmHbRTdsdxDqdXLE3IDwja+gSQq0P
	 8pV7MPTz0wusqVtt5CFwakwMjXTz3DAA8Kp9OEsQo7+CNnGV27sZHN6v8jrEVDTVOVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzIOISVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C00606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzIOISVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD9C1F008A1;
	Sat,  7 Nov 2026 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048423;
	bh=TLnNZwiGG1a5uB6e7dcZ/6Gauac5d0yfnebweAWPVk0=;
	h=From:To:Cc:Subject:Date;
	b=WzIOISVMBP35QQJPkQW3OTuuNzNCW/04/6lYkeNz3w9GfT1sXSlslcFJIwFUvmwOP
	 7yioMqYJrcK1PvoGehmFwTCXsWhB8pKpNgA8hYLU/fDP+tuC5UWLwB2RhRW7fonrQz
	 2J9+0whGV0SUDD6zGUYr8No1LMV7Azei5F8/bVQZhprnaD+Ls8ohSeZEhEhVMvvsmB
	 0eVfH/n5pzCQiX0/8NyI202PsYqnURBF+PGYav0v6dua2rLX60EhW+wQK1OOpaD1Fm
	 2Wp2ysa6MVe0b25fnka2joqBRbVO18c61E+b43h9+8WxxftzJfgCjYgXTim7sBgzoe
	 G329SzhUqWAgw==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: disallow max < min damos filter range arguments commit" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:01 -0500
Message-ID: <20261107054701-failed-6.1-1bfb9384ae0e@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1bfb9384ae0ed52d61eb601b655014b7815ff849
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054701-failed-6.1-1bfb9384ae0e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1bfb9384ae0ed52d61eb601b655014b7815ff849 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:21 -0700
Subject: [PATCH] mm/damon/core: disallow max < min damos filter range
 arguments commit

damos_commit_filter_arg() receives range arguments for a few types of
DAMOS filters.  It allows any range including max < min range.  It is fine
for the logic, but makes no sense to support it.  Actually DAMON sysfs
interface is doing the validation on its own.  To avoid duplicated
validations in multiple DAMON API callers, it would be better to do the
validation in the core layer.  Add a validation of the given range.

Link: https://lore.kernel.org/20260914142327.92510-5-sj@kernel.org
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1932a50252079..5fdacb9dcee5f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1325,15 +1325,21 @@ static int damos_commit_filter_arg(
 		dst->memcg_id = src->memcg_id;
 		break;
 	case DAMOS_FILTER_TYPE_ADDR:
+		if (src->addr_range.end < src->addr_range.start)
+			return -EINVAL;
 		dst->addr_range = src->addr_range;
 		break;
 	case DAMOS_FILTER_TYPE_TARGET:
 		dst->target_idx = src->target_idx;
 		break;
 	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
+		if (src->sz_range.max < src->sz_range.min)
+			return -EINVAL;
 		dst->sz_range = src->sz_range;
 		break;
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		if (src->range_max < src->range_min)
+			return -EINVAL;
 		dst->range_min = src->range_min;
 		dst->range_max = src->range_max;
 		break;
-- 
2.53.0




