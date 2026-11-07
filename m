Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049476;
	b=StOnyseF3CpwUlzWFmzAJQXnQp0sOHNDYKQ8sOiB0u66wle3s+TjrWidOIk0PHUmdKGI
	 9KtN1jN0ZavuwbanEvRBz3bZFGXxFuujap0sCjFBF4cUfJL2swF9xTqvsN6jFyzqIhe0a
	 DUojqFxwPNnm93zSS3UcYZgpj3U44yY5Sy2HoLK6HfgKPOgWE72+bS6LEpySkWV1UZ8+s
	 LL5RwjI9BahmjsUbHTM2AfDsEDwNxJBF3VaGxORPWTeWk/QlXnjZNv6r8+WazbnEMRmdm
	 5INNcYp8SY5K8i6gnOOzTmkPpyi3E2G1rUyHYo3SAcZOWiG3oh0oNb4CTfjc98jVSVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049476;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1eOVyCCLMcOvI4ZoDixfp8+G4jYCQG5RWmJfZ6Huv0o=;
	b=QbZnP3AInTY2c4hRNy+CGrX12+y6dc0Cf3KBCl4KM492j90Fo17hT/+fsSd7fgQakPSE
	 72VOIgge0Lk3Vy9mN5hjsUGKVlIk8f3m5nSDymkFOHZ+cq2wbqFBjLBecXKhOzl1EXVH5
	 oJSRgZCJE5zpYf33m65wURMX60iXJDvi0Son0ZXxv6J8QTxDv50ATUApxsAtutLXQZi5r
	 HZMtVVn8jKNLxhz3izPngjY9v5/LHibC8OVv4ljrI59QQRoQ3FR/yrDv7Pe+yhb15e6Uv
	 +5Z4k7TGzx69cT9IlL6kbtosa+1hSLDQA4yh9rRYBo7MFU2Pypw5XPn+fFULNreuACg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmCu8+Ez;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC646606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmCu8+Ez
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F5D1F0089F;
	Sat,  7 Nov 2026 11:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049475;
	bh=1eOVyCCLMcOvI4ZoDixfp8+G4jYCQG5RWmJfZ6Huv0o=;
	h=From:To:Cc:Subject:Date;
	b=hmCu8+EzC5cX/ql0ukDN5tAmEoK0gbqtjLBPuptnA2WDmjSQtzGqKmuDeZMrqZEs3
	 urz2qoE+sN9DZU5Slct4ffDguY7pqR49B5kqZt9+VVndapbN0tQX8Byg1o2L2Igbbw
	 QNY44tyunXle3zN+FVTps72/FTTcMu0NWj1eK5NT/x1dtaEpQkrhQCIHEvu5Rm3oBE
	 KjSnKOVyb7b4Ltrgn6nFkORVQPW2rgWc8CE4CSPHPHYhcZHccJjwZWwMiN5HVDSf0a
	 hzFLIulxK2U1a1cILvjZdZnH8rR1lFt35nBD5yLitS/z7X1ZabBSJ2h6LktfbavTO8
	 MUJwjQ3PQ+DfA==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: disallow max < min damos filter range arguments commit" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:33 -0500
Message-ID: <20261107060433-failed-5.15-1bfb9384ae0e@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1bfb9384ae0ed52d61eb601b655014b7815ff849
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060433-failed-5.15-1bfb9384ae0e@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




