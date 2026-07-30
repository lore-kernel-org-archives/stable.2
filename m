Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75E296BCB;
	Thu, 30 Jul 2026 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372716; cv=none; b=rMSgXd3dM6e96ZbKjGz9QlD1YObhUiVrnpNSQE3GFBX/erYJ6v3zrlqRWfypbN761USEBvov4Cnc0yjGToYdsWpqSstrAFTtIsa6XkoYADjReRI3IVt88nYVkcW+zyXcOlJIzlRwTFyRhrFxHZ1W1CW2shm5Q6nMbGJxXF8y1mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372716; c=relaxed/simple;
	bh=NqC+RkPF8N9pixYdSt3w85V44GE1evqWTXImUv2vySs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSJ6NGDZZd0MWg+lpELDMxA5slti7wKMX5YcBICZ4tInnqPu14mxfReuXRiMYilqi/y0ALWbN1wJoASdnUCtTiK5IB51vEQOEl3TDY483a3gp5VWKU6mWNUZZRdOPDf/16QxzhysiGnjoYrZs/sclz31fQd00eIMPt2uGcgdoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEsQ5yjM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEsQ5yjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8ECA1F00A3A;
	Thu, 30 Jul 2026 00:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785372715;
	bh=KOkTBSVx3hc9Wg8+80vwysBoAd9JkHnFQUKihMYqscM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEsQ5yjMCKU2wNJ5c8J4nAPL0CN2WHom5KxZIHuYOkkLcy/Zm9E1y92eHijNfeek7
	 ZnfHzNfHOQUK6Lq7fAX1RPWSao93r1zlMvXo+VekARTF/wy3iZ6sY01+xDn7TaTjN8
	 rclie75jvQ4sSoImg54CTXDXYJgoBJlGZ+4W7fvStNA23QvWUP6lU/tWuJfjmXUluW
	 JvBFt64/rGHSGJqSf6CO6tMfI6AYh0tjSqVBmwbElGM1j+oWS+E9oHJgLjP4uYRYM2
	 GhJecqrdcEWKZQzwZ6yYLRo2UEIe6GRRp8epw7DjOPpwU7mRM9sCAnKwEmrW3GueHq
	 mykzFSkv7fSyA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Yang yingliang <yangyingliang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/core: validate ranges in damon_set_regions()
Date: Wed, 29 Jul 2026 17:51:45 -0700
Message-ID: <20260730005145.104960-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072900-remedial-nectar-f412@gregkh>
References: <2026072900-remedial-nectar-f412@gregkh>
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
index 3e221c888e302..4ab1ed472fbcc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -215,6 +215,12 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	unsigned int i;
 	int err;
 
+	for (i = 0; i < nr_ranges; i++) {
+		if (ALIGN_DOWN(ranges[i].start, min_sz_region) >=
+				ALIGN(ranges[i].end, min_sz_region))
+			return -EINVAL;
+	}
+
 	/* Remove regions which are not in the new ranges */
 	damon_for_each_region_safe(r, next, t) {
 		for (i = 0; i < nr_ranges; i++) {
-- 
2.47.3

