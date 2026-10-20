Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792464007;
	b=mgklfd6MnApyRJTGmSGELXe4NAYz6OqZtbdFVY7oM521JUt8l6ViM22OgCi7Mc1Nrbtb
	 iiEaSe3UZFc62ZyYwM1IfwOftfxs1JvD27M+Y+0gVfyCgR6ZYFoQHzwj0FtJtsi9R5S55
	 +JAQe8m0GxNKRBVQ+ZmhIKM2szgnnUCMD2f2X4DPZbF/h2no+uqC2649E8W9OvEhsKM/q
	 3bfcZ7ErMF5+8xX4F9soilOSG8fY4UqI2wndfWoSN0DO1ZnEmW4cNrSLXblraI5wSBZuF
	 mryCceYh0W2uLtpc/AYv/5FllHRs4Ty4zmRA5RY9EwLQkrGUkD+6sqdi/iftBh8GYYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=60QPBhNMCngRfmcAjrxpcv4Imf6U8Bv5IKWR7KuqOvs=;
	b=eeAN0awRuJJ6mvSlK9aTCHAtizQSoCyH1ONvc73U9IrX6YWjxmE8otqr4klv7eT7rUSo
	 xqyMJgxk8zjDgLybn6WnjmeOc9g2KuboLnMGu4IRoJh+9OjhPsWxc9YcNcYXANxHAJA8Z
	 Vy7SWI+Sv4LQr1oZ03umTz1Cv9DAsk7tXyxDbLTk9n2QvRQSvw9CZJHmC1wna5JYvBmmj
	 5uHTkmCQfY3XVUsT6C+sR5oF5hmxZmdyAHK/6X4c7s4qUIBrIZp/hI5GNfl5kRlw75+ZF
	 I6zZ244dTbGc0U1+qxFbFzTdt+VEh38gcisPP3UmCe6EkG7eyo0e1qQO8u33q7W7TGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xyqgyjm5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A8606A319;
	Tue, 20 Oct 2026 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xyqgyjm5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9241F000C4;
	Tue, 20 Oct 2026 02:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792464006;
	bh=60QPBhNMCngRfmcAjrxpcv4Imf6U8Bv5IKWR7KuqOvs=;
	h=From:To:Cc:Subject:Date;
	b=Xyqgyjm5aAEUx7O1C9+9sZ9HoyLu1TowKrpLnSkIE2mnYWjuicwO9PecBk4neY/QR
	 qOEt0O820lHWWZw3hrx+f6My1KevhlIB/FNNOapdeq8Uub3voWMxb2nb4Sc5p+QgMB
	 hncjtTQ25QsrGw6AmtFQKsg4WlFMZsuz0ekg82bW9XeertI7dDcyOhKPjRqT0vbvqU
	 eGdfGNIsslgL/v044qhPF79CYZ+XN03Gbjj8gygXSkwtNGkAyAiXvg8GcgzJb4m1yz
	 qyhk3F4OfK1NbUu5zoNOmc2UuwaXjO8xZTM4+7XL7MF6zv+DSxIYaU908k6iF2gqTW
	 4cycCLMbtUWnw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Mon, 19 Oct 2026 19:39:56 -0700
Message-ID: <20261020023958.108276-1-sj@kernel.org>
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

damos_quota->charge_{target,addr}_from saves the target and region the
scheme's quota limit is reached.  damos_skip_charged_region() skips the
target and regions before the point.  The target that was assigned to
charge_target_from could be dynamically removed from the context by the
runtime parameters update (aka commit) feature.  In this case,
damos_skip_charged_region() cannot find if the point is passed or not,
so the scheme is effectively disabled.

Similarly, the user could also remove all the regions of the target
using the runtime parameters update feature.  It would be uncommon to do
that, but it is a supported feature.  Because the skip pointer detection
logic (damos_skip_charged_region()) works for each region of targets,
this result in the logic is entirely skipped and the scheme is
effectively disabled again.

The user impact is that the DAMOS scheme could suddenly stop working
under certain uses of the runtime parameters update feature.  It could
surprise users. No crash or leak happens though.  Users could also
simply work around by re-installing the scheme.

Catch the corner cases in damos_adjust_quota() and reset the pointers.

Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Cc: <stable@vger.kernel.org> # 5.19.x
Closes: https://sashiko.dev/#/bug/linux-cd0c55fc-0cc8-45d8-9637-3334811c49b8
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from RFC
- RFC: https://lore.kernel.org/20261019143713.98610-1-sj@kernel.org
- Drop RFC tag.

 mm/damon/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 479169dc9ac75..eb1fcdabc0075 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3383,6 +3383,26 @@ static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
 	trace_damos_esz(cidx, sidx, quota->esz);
 }
 
+static void damos_fix_stale_charge_pointers(struct damon_ctx *c,
+		struct damos *s)
+{
+	struct damos_quota *quota;
+	struct damon_target *t;
+
+	quota = &s->quota;
+	if (!quota->charge_target_from)
+		return;
+	damon_for_each_target(t, c) {
+		if (t == quota->charge_target_from) {
+			if (damon_nr_regions(t) > 0)
+				return;
+			break;
+		}
+	}
+	quota->charge_target_from = NULL;
+	quota->charge_addr_from = 0;
+}
+
 static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 {
 	struct damos_quota *quota = &s->quota;
@@ -3418,6 +3438,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 			damos_trace_esz(c, s, quota);
 	}
 
+	damos_fix_stale_charge_pointers(c, s);
+
 	if (damos_quota_is_full(quota, c->min_region_sz))
 		return;
 	if (!c->ops.get_scheme_score)

base-commit: e558ba2a16a47baf6b8e76bb11e92eb92a491e3a
-- 
2.47.3
