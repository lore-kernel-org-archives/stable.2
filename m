Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167515;
	b=37Pd9TXa6kg+kIaHgD6AFugm+01B2kgju/S/PSzxxM8rDVlHqmRAK00Ek2dLKMl8PC2a
	 N6vS7fqu3hzy2ITWrkTeTQyD7QgwdLmiQ89lVvoci0Mm25x5MxIcb7VWeqemhC9B5fh3k
	 JUJF8Q3WS6Q8ouLt7PeGF2Mf+FdvggPDYdzHVnZ3uhl9CO6sQZGWmjEFlo0Br7mnQDsJg
	 9mKUx68mPH0gkY+9JttQ9RVsf/LMV+I6vdsNCq4g3iMookHsoBHoe8ZvULJAxG1xskHKQ
	 RoVkCaV33yIdByMl1Wbvl1D/B2aH64BM9ACPT8OPXCjpSnMZcJztD4UbnUTXEF+kaiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167515;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lmfkuEncO7HrgAvrvHVaRTSKNdQ3l+JsObN4du/E/II=;
	b=ONUv3Y/bXLSW0H100N56QnoOmiAxJByqjxwkfoxuhTG4n1NbIGiS8R8PJKmoe0uEmrnj
	 G/nhUxBhPoa3+nkwBZk67ttiCbWfIkGYppB73Cyzv2lhaeKSjVX4lP4FjgEpxV6b3+BKk
	 WuBqD+lOFu72zvULYYUVyI6kzvsGqRbyyE4lxLVwxUt4AxarmWUbGMNEtty/A8sNXDeQq
	 AtJZPBBdvMgDsens/FEtOBPOT2YrcSnSvh4itJ3faw+hMHXFJzEITJfUydKz6BbBKiIu2
	 +jb4S3mmPGGcdwEK1zrVJ8WysrzbbQOFgWYREBo+hgslvnCeuTgz9iNlKD+ve/YwLYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVWwxJeE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89471606D809;
	Sun,  8 Nov 2026 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVWwxJeE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3644E1F008A2;
	Sun,  8 Nov 2026 19:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167515;
	bh=lmfkuEncO7HrgAvrvHVaRTSKNdQ3l+JsObN4du/E/II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VVWwxJeEFsdCKe/oZmO70wy3CLjkq+dbaLQBYHovLEo0MvUIDKZNciyh8j94v+Jzt
	 eE9/0sShh7R2iqJ/0J9MGC38DIdvDzJfNGi1Sy0uIlIzxY/fAbGUb/Wgh75ezGIarA
	 IbfLGoXBdu02K4bO2CQ2CBGh9OcSBrDb0JQWGOb6r0cWFv9iNSSjci/hWBVA15cfEK
	 7GWZpNIsd9Fb4g5TtwAv1T9TeLCGUQqgBr5Rz/bVOFvPYyICpra6ZMyXBEkUnGFjT1
	 4JzfbLHXiW+j0iHNOU+m/Q+PI87jvVZrJw1W1yP/yyZ3jFWbYi2BZ+Mffen5/ge7Fs
	 oDwa/ag5xAOXA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.12.y 5/5] mm/damon/core: remove unreachable damos charge_{target,addr}_from
Date: Sun,  8 Nov 2026 11:51:44 -0800
Message-ID: <20261108195145.115792-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108195145.115792-1-sj@kernel.org>
References: <20261108195145.115792-1-sj@kernel.org>
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
index 046c07b86a6e7..badd0628e5eb2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1686,6 +1686,26 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	quota->esz = esz;
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
@@ -1714,6 +1734,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		damos_set_effective_quota(quota);
 	}
 
+	damos_fix_stale_charge_pointers(c, s);
+
 	if (!c->ops.get_scheme_score)
 		return;
 
-- 
2.47.3
