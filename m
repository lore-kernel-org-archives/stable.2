Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045869;
	b=ZQjgL/TycNBAfkO9i1uydnKX0SJ+hLppNt0vdqx016pKQp1TMi1aZuMPQYw7JNDeoK/A
	 sXVvKpXZvp9VQOgC1QsX9gxDeaQcNM8d+bOi5Hl5FrySYlmElCrEJHuMf55gNg1QNrjzI
	 YHl0wUud4krRS1Rbi2d3XVmFXa9HHhhmN31RlEuafPCcf2PywNmpQpSL64KzyFAH/0YIq
	 N0ZO2fYSB1mrkZVONBH3TQSZalXLUcs1gDj5KjvpL23U3sTwythygBbUsElZiHaOb+j2q
	 x0MUFR9VLaIOJVrMDK/Y+wGfrz8T2jYvyYgM5dN9xjx0lp3bq7y11VnQrIPXIybqs7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045869;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m/7iDaTKNrI6r9xB8EttqWHd1sJhVr9ArVi2Ei1Ml9Q=;
	b=HQqeOFozwcMp1tJEPlDp5aJ/EC9iNE7MQGv8J+dw5buo/aQuCBaM4bYbck/XGbydNfO6
	 B8C2I+p9+46EnzCQexsGE/nYuES6SvNObUWpPqpXtzWI3GS5HOYKuUKZ5ZKloHVRZcuvt
	 I5nVN3LYoOQ/hrE+pb/j92QvjqYZVbLbheqB3Scr4S07crEGNI1ROX9mHQMalE1CcCi8Y
	 +vi17ggijKuf2hgwwPxdog8pU8d/7iKZcSyuhE9q2WZua3bgAwlqDLKQW5p363v88g4xu
	 wxhiCQT5XaAIVVMvt5/jIpH7BfK3yRCY2Z8aWRELc5YpugcdOyD4Uwacm0fnAWWq3JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2yGgPlz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A019606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2yGgPlz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139B21F0089F;
	Sat,  7 Nov 2026 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045868;
	bh=m/7iDaTKNrI6r9xB8EttqWHd1sJhVr9ArVi2Ei1Ml9Q=;
	h=From:To:Cc:Subject:Date;
	b=V2yGgPlzBMR8+p7EOrdMcTvC4XMluEHmNwSAEoKBjb542UjlVKmOBM8SJjpWBWg3S
	 +8/wCiuqdxWMSr7CJM6gWoNzp9aYqE/AvNSgO57/INWqoZ7IwVySylBj0rBqZ5WRwg
	 fiXxwGJOcu4ClTOIAju+WqUHHzFRVRDCMXkT88Yoa28Ud8AB/8ZEGBr7AstO/PQB1g
	 gYgdEXdz8CLU6XHW7paY2Sn6T3M3oo2kad6n8JbitV6+AzO+C73PLPb5TkwH+ZZVl0
	 KKYYdiyYvjdF+hvHR1BqwWJDwZ3OpeuM3QS8We1VL2lg0jC0QAgA0G1Y22yyaDfRPZ
	 OUdM42MWuBL8g==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: disallow max < min damos filter range arguments commit" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:27 -0500
Message-ID: <20261107050426-failed-7.3-1bfb9384ae0e@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 1bfb9384ae0ed52d61eb601b655014b7815ff849
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050426-failed-7.3-1bfb9384ae0e@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




