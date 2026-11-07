Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050476;
	b=wV43J2AaTRMdNnpYgNdZ0wWI31Md8ljTP+uWN+5fu8AwSkU3L+X8IRB8sMFL0q/Iy4g6
	 V7ZjWr+e6IaX57HqbXq8yuW89m9KiesBwFOqeJlwf96tFwKexyw1/w41Xa1rTvmDQkXIt
	 nZOVTsqV/TSQHuDBAOykupukhhtNlHRG7L2YSUFls3cJtcUrLfcylYCtereGE2vjVaIeT
	 /+613uOls+aVoQoGnF6ol7VjseIaK+7WXu0ZWs6jXma0xagIOmfGKGsyq8wt8LK5J/H5r
	 NNCzwqgaljll9/XOFWuTG8p/ZwFEic6ZeW8c5RcCItPcLAQyPqDfoefgG9KQt/UwRJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050476;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=J96n+MmgXQ8ruM2J5XeBTDCkwGs/hgQcBui/qLT0OLY=;
	b=kBwOBcyoWW12zmulIYHiYVO84UZjWLb8TANDQX0PemUTenuZ9zEOqRxtQj/OWyO/GWR4
	 CgLAMKq363Z+wwWE9QoJmYxraPGCshEBXT6g32v2WA96vubHZUvsTuWgts6AD15edds+z
	 jxytRX8K0d4lxfRQL2zZyCfC2IdpXQkaXr+EYGPBwpkWRk15K/j7I1XUfAlxWIDv9vTjI
	 b4LP04Kkgt4v6boaORCAk0HQgJqXbB7bzytxEwrM85cvAsh5+udiYJh143ih8T3hKR5GQ
	 TVDC/nzEzvZKG9WcUBbPUDebXtc97Znui1nk599XtC3xW9at8PGYWqqX9f8do/6+nmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvKzWnk4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE25606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvKzWnk4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30B71F0089F;
	Sat,  7 Nov 2026 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050475;
	bh=J96n+MmgXQ8ruM2J5XeBTDCkwGs/hgQcBui/qLT0OLY=;
	h=From:To:Cc:Subject:Date;
	b=XvKzWnk4ojNfEE1oK+O1UPUZkkl+FkOlc8X6Zp1Wvb0X/0KmOmnmqwNxjEH1b1VqZ
	 R5J56iWnrLv6gO6VpooJ0bR/Lc9uVWLjOEelLPSPPJJipyOc6bCI1Ypcfc2XWZlFQ3
	 h39dBv1QAlu+3CAJU4ADg014LT5mcKQcCWbplBBLN4mo9dzTPXFymnAC3xF3b+An3E
	 QwBfc1qvj1Qn3Vmaay9tTKvcH77J0Ep+Bd2A7voQM6kIeXR0fqWstojbLDomS2wphu
	 o6Vbkyx4SbeYgt7bJYroYG6tAeQdhYp1YYHL+pQOd4S8OgSLs/NbOYt8po+/oymFUf
	 Bzaxd2ocYu+0g==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: disallow max < min damos filter range arguments commit" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:13 -0500
Message-ID: <20261107062113-failed-5.10-1bfb9384ae0e@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1bfb9384ae0ed52d61eb601b655014b7815ff849
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062113-failed-5.10-1bfb9384ae0e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




