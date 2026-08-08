Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5757D4C6D
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 02:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786157504; cv=none; b=d2BTllqeIXba1mcZLYACTUJjyuAMNKS5DEV90Ym3gFtZYqpivyIFpxwJ22cFWJwM/x2XOlprTaAn4dmOT8myjvumNcyFm6EN9qzx8E3se12WoNypUvEq5Yt64phRtueWYoq4id/3xIqNTgjmPNyK9pRHs/vlYkFcowlun8H0hDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786157504; c=relaxed/simple;
	bh=ICZ4xMplfqxrltNZDAYYPi2UI6HI6ucMz6IxAlCr+H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHE1gf413wqjssXp1+XB0uOMZiRn9qLzMMTcco25HNR53TgbVpys5JTJSiRLX7aCv5FqIhL/ja2j8JjafjUGv9Mka4TlRqOnTuvCrr5ND3WIF/W5euB71WpQZDjBtGQ94j+iuj+FxeqsHDRqtm9/wenTQBuDC2Kwun1dGQPMkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu1+pdsC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu1+pdsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598C41F000E9;
	Sat,  8 Aug 2026 02:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786157502;
	bh=28u7eSTA2fQCk5ln0Yo4UjAewFOWFDq8ZAmKKJExeMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nu1+pdsCmBf1xeITo09fV3cCy32qh2CQOcM2n4R7+1meRq/jtQHZF4Gu0BtT1z74W
	 r1hvbDsLADWOjyuUEBlq05M2cVLLYXcINxOZuYl1aNc2dB47KQ4ZrjZ+3zknZO2KRh
	 HfLqnE18iPyJGJySDgbHCCYWOxn/XvWVGnVTzkuuW0fRHmAvDLWxpvtdChyqq+DCPC
	 oQ74w9VNI8YnEVHqlEp4P43qAWjDZYDYta5d1uj+UWni+zRIC44CcBnDtDRQDgdxJb
	 RpH1XWc+esUnLjSSF7llL9xEP/fFiA6BI77AUjqAQ0NY2i57qxd11VZH37qnEEduhS
	 S8g69rfC6vFRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] libceph: Amend checking to fix `make W=1` build breakage
Date: Fri,  7 Aug 2026 22:51:39 -0400
Message-ID: <20260808025140.4026434-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072929-reentry-rebuild-7ed9@gregkh>
References: <2026072929-reentry-rebuild-7ed9@gregkh>
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
index c34a5bf86831b..e8f392658b20c 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1438,7 +1438,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
 	ceph_decode_32_safe(p, end, len, e_inval);
 	if (len == 0 && incremental)
 		return NULL;	/* new_pg_temp: [] to remove */
-	if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
+	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
@@ -1619,7 +1619,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
 	u32 len, i;
 
 	ceph_decode_32_safe(p, end, len, e_inval);
-	if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
+	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
-- 
2.53.0

