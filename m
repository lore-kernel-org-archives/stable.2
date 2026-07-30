Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0B342CB0;
	Thu, 30 Jul 2026 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373009; cv=none; b=NYHTLqa3N1v/jVXyKb0AsgLvb2FAqcd+gQTWo+99/dgTRL/FSlM+Q5Ltuxhp8N2dVdWZ8hDPiJ3OAU/2Xirlfez9u/GthsDdWh+DtRmhdm4yj2VWMVwKkKO46hN+q2Jh55EIjryMdV7Yp/muyGI5yYI1FDONDJufmn+f/Bo+YnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373009; c=relaxed/simple;
	bh=DtkxkiD9A478HEY8qXBW9Yqy+UvCCvranmkM2sYBcAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoyPCiphUCtV1rv68xXIzeaTzsLLao2mS2Xxg94dy+4QEBPce4S3aQb4aw5U57DyumoBZRcfyAu4QTx9jes0CnYnwJ2A/IFiFyc00WCcdvo8GBBjvAbkfCL7EVpJGdipZbySkIC8V4XaW5Yv4nnXb4RyXnpb8F5x4apxq8LXPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AohHDmMV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AohHDmMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AADD1F000E9;
	Thu, 30 Jul 2026 00:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373007;
	bh=zt4XsvfQmoUsuB3jF9FwECnRMx4GfwPVJ6if8Bh+4z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AohHDmMVSo8qU5+ckSCrVwDDNg+tvVhiZXMRDvyWcVXTM80+54bbS9p931iQFK2+A
	 68Kc/DC+QapwNlrQd0aJF849XvRiXg0ybsM4lafKn3w3bb+0PDybGOrzgN3Qape5Uk
	 AOkl0HkC8SiqoC3caTnbRbxdyc3pPgu4S6gF7qDIIAdRs2VuyBkyeskVVbvg3bhpLM
	 lN5eAgQ2U3YDCoKcIzMPJ0VCAg2VoOzpO30EoNODHtnkVfQwlwKH/zrifSsgBGyvJj
	 /65C9E7dQjw0hTcCXONLr49PuV2W/8ed4X56BRY6u60x+TKzz4HL3ReZUpBmICRSYP
	 t22JHVQNHNxMw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Yang yingliang <yangyingliang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/core: validate ranges in damon_set_regions()
Date: Wed, 29 Jul 2026 17:56:39 -0700
Message-ID: <20260730005639.108842-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072900-emit-mortified-8331@gregkh>
References: <2026072900-emit-mortified-8331@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core logic assumes zero length regions don't exist.  However, a few
DAMON API callers including DAMON_SYSFS, DAMON_RECLAIM and DAMON_LRU_SORT
allow users to set empty monitoring target regions.  This could result in
WARN_ONCE() on CONFIG_DAMON_DEBUG_SANITY enabled kernel, and
divide-by-zero from damon_merge_two_regions().

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

Link: https://lore.kernel.org/20260630035221.146458-1-sj@kernel.org
Fixes: 43b0536cb471 ("mm/damon: introduce DAMON-based Reclamation (DAMON_RECLAIM)")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Yang yingliang <yangyingliang@huawei.com>
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 1292c0ecb1caefb8ca064a3639d5673991e8810c)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7911599c37f22..7217bb2ef51ec 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -214,6 +214,12 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	unsigned int i;
 	int err;
 
+	for (i = 0; i < nr_ranges; i++) {
+		if (ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION) >=
+				ALIGN(ranges[i].end, DAMON_MIN_REGION))
+			return -EINVAL;
+	}
+
 	/* Remove regions which are not in the new ranges */
 	damon_for_each_region_safe(r, next, t) {
 		for (i = 0; i < nr_ranges; i++) {
-- 
2.47.3

