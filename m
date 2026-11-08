Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168909;
	b=Gju0vKehoqGkA1RElDOUCD8ZOz6eiaJVaYsedIhazHgn0bAG3g7+FGl2BjCgnAiSG5Vx
	 EhiG5diuux6+PV1tEtLbyPMnbdCfKcxiovjDvd8DPpvSqOFp3D1L6o6nbnZd7UfwhUNNw
	 F53s/6l/ZQNqMuU721QkWra0voXvi0U0ML8xzROSXUlCmunxXprOIiaRG7SBVFM/ztORG
	 xHPsk14O/C0DuVX1OLcJav1XZFWlSxWJVzRkArcC95fA4zPgBaagkFi7fQnr7rZWpHRNf
	 MyS9UdiGf3Uq7Cpi4qudtIMUNUkEjYrQ1vYVe4anSyT4mjfbna62KmLsnlInwvkeQCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dECklwOd4xlNmvN3OSaJ4I8wcJsGZw3Lw9lBlak0+Zw=;
	b=ksCMwC3T4S6DIqZU6UUruH3YIuO+ow6QzdJVNgpaa4WrQhgK3L9r+5k98OUoKDs4jkMw
	 LRFNNQqG/G1EEu8SmXzTRBsE+TW5xj51WO8KElYnVj1GWeRHonhRyxM5vdwoJ1S4QX1HF
	 v4OslOOBTlEMQOBTAfk498IycNkFbWK0B6O9WLrHO3L8UH5KETig6Kw9VJpO3drjp4QIN
	 Yi5ICgKFnCvMZge7hn4H7jjsQXGgsjomURI2JUoCTa3btInoY3ITyNdVoRDPpu9ykJUvj
	 Oih5hnfX/YCh7DiR5ttX+/ev2Y9AB0J4hddbpyTxaHwVDSADJfPoHC6rvfZMDFDALrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTAwnfME;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C45606A33A;
	Sun,  8 Nov 2026 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTAwnfME
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14481F0089F;
	Sun,  8 Nov 2026 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168909;
	bh=dECklwOd4xlNmvN3OSaJ4I8wcJsGZw3Lw9lBlak0+Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LTAwnfMEsvSFbLjwqnFYcCAs4S0/lDhCFRuaXuAZCX56sSlXQ89h4tUvh7dpLlZ1m
	 krBONDu+XOF2umWiJZ+Vsovl47kKYjM5fH7bUuSum0TIKyFgvKQB+H0KnUP9nT1NJ6
	 iT5k79I8qztVPOM2PTxKxn7b5wTA/t+ZNZyh453TJaFCat1RSacv/YMtsiIK7qyP7P
	 hMwGD1wd+7sWDTLGO51y3CTTiKoysKmRnQTPHtTLPXU2o1d1El2ZcYDl7aTmZXokJF
	 5smheUGWZrticD8L0UndQcKTeqTwTbD3hMDibg3NCrNawRXxMRWx3H6vgVPdR5HTi7
	 FutAhU7JzBr3Q==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.6.y 3/3] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Sun,  8 Nov 2026 12:14:55 -0800
Message-ID: <20261108201456.116824-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108201456.116824-1-sj@kernel.org>
References: <20261108201456.116824-1-sj@kernel.org>
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
 mm/damon/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 99e934a6d1ce9..61d45d40fc1d3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1088,6 +1088,27 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	quota->esz = esz;
 }
 
+
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
@@ -1115,6 +1136,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		damos_set_effective_quota(quota);
 	}
 
+	damos_fix_stale_charge_pointers(c, s);
+
 	if (!c->ops.get_scheme_score)
 		return;
 
-- 
2.47.3
