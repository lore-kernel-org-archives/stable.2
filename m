Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05914A60F;
	Sun, 28 Jun 2026 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782608249; cv=none; b=LwuLLkZYZqIDUXbjC63P/P845Dr74bJ8tHVOgbtVpPRZF6UMdt2YILj27CPxl5L3DTZHgbG4JEm7WvubEWUsNfITl3ylwXv8WeQkEEAeLqokTO/FlQxxfoyVpW+5nLwBNy6AjvBmPWFsnkCWBJtotHWthonysESyPhTG7MtTVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782608249; c=relaxed/simple;
	bh=K1cEz/iitud3LvmFxGB0jbqbtJ/55PTUSVs/uhRx8IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YsFKarBj3eIHePNgxxkTiOw6HV1M9wtCFa8zUMyJ+Flgfu2Rv0KzYw8tRRoCejpdNbsWcrus/PBJ586V2lYVbwyvZ1IwL/0cB7uHV1q+9Kc5ZlTCIaciiFy7gCZRhoI8xQ8QMyJ+KSlpsF4KqDh2PF7NSDz8AyeLeseNbAW2ztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQoWwsCX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQoWwsCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04AA1F000E9;
	Sun, 28 Jun 2026 00:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782608248;
	bh=tznSpU7jKgoi/IAc701RjRwzUrhhlndb6N0yCpqUF6Y=;
	h=From:To:Cc:Subject:Date;
	b=ZQoWwsCX3UlTCy9mLO8MoRulCOcTI/rsGY6DC+7jYEDPeCSwHh3DuH6UUYn/qvglO
	 QeTKbLss8rNnaeU7rPAlafnix+x2kEETjfv6ZqkZfHogiEnIagnXH0I1FEVVrIMMhf
	 HzmndrWiHEBMFTQrKyHNCkgozfwLjTCNvtzjD8Q7+7twokBaA8NWh8dxk8dBE+PVcN
	 SLPWtrgdbrBfurx9a9mfbbpRmiijXXK3T0Uw0gQowPODmqJgobSD8x+36sikkGjeLR
	 ebX3SI80TknbXFhnECtX10/IvQbWBqpRjjcbslINxKkY3KLhGNVea6YHrac4Tbvb4o
	 ZRRkqzqVJRy3Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [RFC PATCH v1.1] mm/damon/core: validate ranges in damon_set_regions()
Date: Sat, 27 Jun 2026 17:57:22 -0700
Message-ID: <20260628005723.28549-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core logic assumes zero length regions don't exist.  However, a
few DAMON API callers including DAMON_SYSFS, DAMON_RECLAIM and
DAMON_LRU_SORT allow users to set empty monitoring target regions.  This
could result in WARN_ONCE() on CONFIG_DAMON_DEBUG_SANITY enabled kernel,
and divide-by-zero from damon_merge_two_regions().

For example, the WANR_ONCE() can be triggered like below.

    # grep DAMON_DEBUG_SANITY /boot/config-$(uname -r)
    # CONFIG_DAMON_DEBUG_SANITY=y
    # damo start
    # cd /sys/kernel/mm/damon/admin/kdamonds/0
    # echo 0 > contexts/0/targets/0/regions/0/start
    # echo 0 > contexts/0/targets/0/regions/0/end
    # echo commit > state
    # dmesg
    [....]
    [   73.705780] ------------[ cut here ]------------
    [   73.707552] start 0 >= end 0
    [   73.708452] WARNING: mm/damon/core.c:359 at damon_new_region+0x6e/0x80, CPU#1: kdamond.0/758
    [...]

All DAMON API callers eventually use damon_set_regions() to setup the
regions.  Add the validation logic in the function.

Fixes: 43b0536cb471 ("mm/damon: introduce DAMON-based Reclamation (DAMON_RECLAIM)")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260627170057.1867-1-sj@kernel.org
- Fixup the commit message for how the fix is made.
- Do the validation with min_region_sz-aligned addresses.

FYI, this fix cannot be applied as is to the commit that introduced this
class of bugs, because damon_set_regions() was introduced after the bug.
I considered making three fixes for each caller to make the backporting
on the old kernels easy.  However, the first LTS kernel having the bug
is 6.1.y, which has damon_set_regions() and all the callers are using
it.  So porting this to necessary stable kernels should be easy enough.

 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d99f7a297fdde..df0cc699494fe 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -356,6 +356,12 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	unsigned int i;
 	int err;
 
+	for (i = 0; i < nr_ranges; i++) {
+		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=
+				ALIGN_DOWN(ranges[i].end, min_region_sz))
+			return -EINVAL;
+	}
+
 	/* Remove regions which are not in the new ranges */
 	damon_for_each_region_safe(r, next, t) {
 		for (i = 0; i < nr_ranges; i++) {

base-commit: 7c001190b88a32f80c93a6ac302af59a9756309c
-- 
2.47.3
