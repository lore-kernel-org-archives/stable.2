Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811485;
	b=We5QY0q0bHAIfFzVPJ1ADO5Z+XXmwOOiZthuakZ26BKhue+27gIuVvTXV+PypbmBQQ+c
	 BqbXO0FZIKZdXywR06APgHql33MJZpsryW/XNru7MdkYTeFMWUY6ZZQmK3jbgNTsmuVAx
	 Y8IBE4GJigzNFnmprX6yEBJ5Nlu2Ydca2USE0RHXDOeXq9p5cyrYxHJYf8OVLOY59tTIo
	 dsoXrOFo2/NVJ7gdEv+fmol9ShZOPRffBCSa98vAgd6/RfHa+Df2qjIYz7UCaBhwvR1t/
	 nPaAB21hilngnc9P7THErMcfePFQErUL+duSx3OUatM34OlzpzNMG7RQSWlOXyvapGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811485;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VpkQKOzSD2hgUO4KXQobYy7a0rOKz3nk4brF7xC2xAQ=;
	b=OYRw9istx707HBjd4H+lXgrVbRVMC5UFHqk7Tv83ytyx19au8w2AL6Tpl/YLkXTzmXKr
	 lihwtkMD58q2j62Bk2x4cy66+LokqzGVJ0+wb+jEpPbrid6Q5yUYVJURVAqJuJaxB+yJB
	 o8xW8GHze3g+zk3nqVLzPF1BhB5s3u/7Ub723VaG9hYkVgkp3TjGogXcV+Twebt0j6mRw
	 rBeSvDJgujkS0QlI3jSvM+f39Lw+Gx0GMbDTlFLhMqMg7G//6YQfwc2Dugkpgcm0MCoTt
	 u1BFL030CSOP5hUKV/TEmrQE94JJ0JVM87dRtS+q5z/knnfG3z3mOmwMMeDZPPFTc8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7dnWdgd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AF7606A31C;
	Fri, 27 Nov 2026 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7dnWdgd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560001F0089A;
	Fri, 27 Nov 2026 20:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795811484;
	bh=VpkQKOzSD2hgUO4KXQobYy7a0rOKz3nk4brF7xC2xAQ=;
	h=From:To:Cc:Subject:Date;
	b=j7dnWdgd1Bl978lwebtZPQyWWpCjWe4dn2z5kOXLbAhoYwmWar4ixKKTe4jexlLAh
	 QyQyRF2UZZc92Ec9XmcuYf2aDQeZhDr5HuD7CewMKoqOKep4sRwhzmmHvMd0jcdiKv
	 JJPXAq+vqNcyB8Z2m7K98KF6swgJH3Fy+jK6eozFp9pWsaFmDWy7bWYWEPXwE7UrPN
	 sENk991PPEwDFDmRbbdRJOM1LzfJ+JSNDCYShqsbjJ8xbH1cXp8oxzezQ3k6f6nODJ
	 ZdYSVRcqw7eos0aZbERE8b5icph7/rEHXo/Md+QANDZv7br4Vb2DG9d0M9RzrdCmTq
	 YIeJ7EYdNUlaw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH mm-hotfixes-unstable] mm/damon/core: cleanup damos->walk_completed in damos_walk_cancel()
Date: Fri, 27 Nov 2026 12:31:15 -0800
Message-ID: <20261127203116.92895-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

DAMOS walk could be unexpectedly only partially performed.  It can
happen when there are multiple schemes and the walk is requested after
the previous walk is canceled.

The expectation of DAMOS walk for a setup that has multiple schemes is
that it will walk for one snapshot for all schemes.  To know if the walk
for the one snapshot of a given scheme is done, each damos struct has
the walk_completed field.  It is set when the walk for the given scheme
is completed.  The walk skips schemes having the field set.  It is reset
for all schemes when all the schemes get it set.

damos_walk_cancel() cancels all existing walks.  But it does not reset
the walk_completed field.  damos_walk_cancel() can be called at any
kdamond loop iteration.  For example, due to DAMON context pause or
DAMOS watermarks-caused deactivation.  It means that the function can be
called while only some of the schemes completed their walks.  And users
could request another walk after the canceled walk.  In the case,
because some of the schemes still have walk_completed fields set, the
walk for them is skipped.  As a result, DAMOS walk based user operations
such as update_schemes_tried_bytes kdamond command could show incomplete
output.

Fix by unsetting the fields of all schemes in damos_walk_cancel().

The user impact is not critical.  No crash or leak happens.  Only DAMOS
based monitoring results retrieval could work unexpectedly, under the
certain setup and the race.  Given the best effort nature of DAMON, such
occasional monitoring quality degradation would be not critical.

The issue has found from the Sashiko bug database.

Closes: https://sashiko.dev/#/bug/linux-228a4c52-0545-4c1f-90ce-41114d8272e9
Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from RFC
- RFC: https://lore.kernel.org/20261122224054.79767-1-sj@kernel.org
- Rebase to the latest mm-new.
- Drop RFC tag.

 mm/damon/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0e6b361f97ea..a6aac382f296 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2702,6 +2702,7 @@ static void damos_walk_complete(struct damon_ctx *ctx, struct damos *s)
 static void damos_walk_cancel(struct damon_ctx *ctx)
 {
 	struct damos_walk_control *control;
+	struct damos *s;
 
 	mutex_lock(&ctx->walk_control_lock);
 	control = ctx->walk_control;
@@ -2709,6 +2710,9 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
 
 	if (!control)
 		return;
+
+	damon_for_each_scheme(s, ctx)
+		s->walk_completed = false;
 	control->canceled = true;
 	complete(&control->completion);
 	mutex_lock(&ctx->walk_control_lock);

base-commit: daba53bdc1a54c453c2f4ced54a1cd52416c3f87
-- 
2.47.3
