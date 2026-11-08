Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165751;
	b=lEsZRJILb9DL4pkn66o7plmr4GuFQsDM08uJSxDY5r7IOCN8p4OoT8Dbt/6AXGYC8LWZ
	 2zSFXiwTBWGYgKQA8O+43C7+nNRBZWUReLWT2hkTtrotNmNrk9Jt9llfGrDt5/vZw73Kq
	 Ce1TZ/LVIIng759i9eNZwSXMxt1CjGjpPS7bpSeVui4BByxaUCmsv5W7M7kS5H9vUlRaA
	 1z5gSRc3VaUqSoCZLGbHwihY842geikBXdL9MNH0arH//HvLM5BWKKJ2M8vivutf/N79G
	 aAVKE4Nvb5UZwYnE9UfSGjRhKwUVHoD6ILrv0EAR6PGP0xrOfnSZnFjANy/ryL3jHMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165751;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oUgpNIq5y7P8hrOoDRzoRBlVsghumVDo96fytymZU4o=;
	b=CU/WhiGLQxOvIdWvFBu3NLEWoJCyELs0zFvey+L3jKw470Dm3zv8rhyASg2PJFDdKgqo
	 gdoXfbGDFI7QhWhjqG60xdfeqEq3RA/xbA40UL006VMEB9ZYu3IagGqJN4nFJhvBa2s54
	 5HpiNmoORofEiDBSdc1N1AuZC6o1vNxJJcZ7UHXOyyGFcXoaBBIgE4IMdyzx5FwBTWldh
	 Vvjaxabq68zJRU2MB/clsP6kxHDcfP7hJowIsN4+K6P8Um0om80ZLYXPabVrehe4hG7Uf
	 GJRiwxFI2Y4UExqb036eE7WQdJKUFNMoSLgjRREh/dkbYVAKS5ZbNrIZ4d3Mg7s3ebw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyxSBYy+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B5606D80A;
	Sun,  8 Nov 2026 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyxSBYy+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A306C1F008A3;
	Sun,  8 Nov 2026 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165750;
	bh=oUgpNIq5y7P8hrOoDRzoRBlVsghumVDo96fytymZU4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hyxSBYy+ZbiG1f/nMT8s23nOmEzncM825cfwxYgWkFd88wNDXqh4irfChr2u/b/a0
	 nHZXZGkQ0I95CINQI+3l5T5pAzmzaBaIuf2esEEtE4Q46z1WblVquDw4AsKNjgUVd3
	 cpo5U5d3R6hpv8lgL8zBsEuAaAV8hr8ie0Q1x1R+1tf/hd7g1jMOyjVmaRJrrjCaPP
	 0SX00Nm2F5E9u9GSO5mxoa1pw4e4v852Q66bbb2WQyqHZCZHdaGRw/+cIxZWyD2HDm
	 Q7BipHtMctHHzLC7dIQwe6mZbn8gbnJFiq2n8mri7CyJqcLy4ZjRa/zpvL24h1mYzK
	 gtEiYmSKD8Q7g==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.18.y 4/5] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Sun,  8 Nov 2026 11:22:19 -0800
Message-ID: <20261108192221.114362-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108192221.114362-1-sj@kernel.org>
References: <20261108192221.114362-1-sj@kernel.org>
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

Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org
Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Closes: https://sashiko.dev/#/bug/linux-cd0c55fc-0cc8-45d8-9637-3334811c49b8
Cc: <stable@vger.kernel.org> # 5.19.x
(cherry picked from commit 5695abc4e742b947f586bfb6a080a80ad9957e5d)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f2666770b5436..00cd0e2a1e341 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2261,6 +2261,26 @@ static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
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
@@ -2297,6 +2317,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 			damos_trace_esz(c, s, quota);
 	}
 
+	damos_fix_stale_charge_pointers(c, s);
+
 	if (!c->ops.get_scheme_score)
 		return;
 
-- 
2.47.3
