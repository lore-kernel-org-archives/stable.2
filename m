Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E3368D73
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786188332; cv=none; b=m/WqKa3TdtgdFymQOMRIV/ftZoFyTBrbQwrkuwIRJyft0D20tUZ4slVSkYg1hI13Eavp39AZtQWaz4GwxlFMtFSoiTiFu7skivB8NNvUBH2QDWsDLOiFrySwwItP3f/xi5ScNCEgAiQXG3eH/y+0XG7GEZhdRzwT1j2Mz56yjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786188332; c=relaxed/simple;
	bh=D9idh1bxe+PJzG/E1AQ6DRo7hPvBqlDFpHjhGZf4snQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJV5OYwa/1PAqMcyrbFfAoh6BdXaaaXHQr16cIjZ2krdV0PfgTpYOMp4QUiN7/mVpKQNncbkexz4GEhvEpS/Ox84bPgEj7TFvty5DaZQNzCh6x/whid2rQMF63dtInnMFQeLQ5bwULpFhhYkjJAXoTt+3wlvu4TFdHivIawJr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyYeDMWg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyYeDMWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB4C1F000E9;
	Sat,  8 Aug 2026 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786188331;
	bh=oICWOmP1ErSSC1LNGPejYPueg+GN0VrUv138xZDp7kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kyYeDMWgPvNirmbBx2UBao4y6YW40xUgydzmbhnDxlMtjlKLDtHaaa/lXXsAjbakK
	 iBlTM0uQceMbBhO9UciNVABgMX9hTEUNEGPoeq2dfuy0toitB1bTQFZRZV1Fc237tb
	 G1F5FV4YhZXwnld5+bgEOpwHZ6Q4DOxjI6okvySgYL8BzrG3sQlIU9tQ7IrRdDfVJZ
	 MI6VfXfvZ0+tRltepbTY0ef7y02zNMpDkcfWVCAgVvdIHUss4hoCz1xFPQopkjx/IS
	 3GPUHIpaKZQ/rpAwgLh3uoXpB9zDRpx/R6Lo8WkBaFMJ8oA7WsforQObMiQ2TwoTcy
	 ZkHvW/zOjWakw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] libceph: Amend checking to fix `make W=1` build breakage
Date: Sat,  8 Aug 2026 07:25:27 -0400
Message-ID: <20260808112528.101249-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072929-ritzy-confirm-991b@gregkh>
References: <2026072929-ritzy-confirm-991b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 04d8712b079327409b09dee628378f9583e2e035 ]

In a few cases the code compares 32-bit value to a SIZE_MAX derived
constant which is much higher than that value on 64-bit platforms,
Clang, in particular, is not happy about this

net/ceph/osdmap.c:1441:10: error: result of comparison of constant 4611686018427387891 with expression of type 'u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
 1441 |         if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
      |             ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/ceph/osdmap.c:1624:10: error: result of comparison of constant 2305843009213693945 with expression of type 'u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
 1624 |         if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
      |             ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by casting to size_t. Note, that possible replacement of SIZE_MAX
by U32_MAX may lead to the behaviour changes on the corner cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Stable-dep-of: 9f00f9cf2be2 ("libceph: bound pg_{temp,upmap,upmap_items} length to CEPH_PG_MAX_SIZE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/osdmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 033e8cf57b0ea..763f22a06f05e 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1422,7 +1422,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
 	ceph_decode_32_safe(p, end, len, e_inval);
 	if (len == 0 && incremental)
 		return NULL;	/* new_pg_temp: [] to remove */
-	if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
+	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
@@ -1605,7 +1605,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
 	u32 len, i;
 
 	ceph_decode_32_safe(p, end, len, e_inval);
-	if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
+	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
-- 
2.53.0

