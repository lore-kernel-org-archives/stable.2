Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0845FFAD
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140974; cv=none; b=AffGTj8mZLJli534JnkLdV9D7MZrhwbNgvpcgyIOi4+4ieGcivMwhRigaMX8FyM99ddVa1sHoZ5VAyNA+lFa5eqrwWlh+35e+ryfPZeJqJyUlPLaATWlE3QkpFLBT8KHlqCseny6UeQk6lY2lsCJjA6b8fOqVRZFrkhG3vhs3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140974; c=relaxed/simple;
	bh=6uQwBGWEjZuhKsUQK1tKjft/7EC2hQBMsN7FbBN6pCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gvaq8kYn75s45aFM3pHwKuEl14c3F49p87o35l2hs5P/z1jt/VYzw10rPGBDVgPsZ+73XH6R2i0qfVY3M/QQvEdNlZCtkBzKG0pmN+q4QVhEEgpjhePVKLW4LhJG6Qp6TwO7byQAxVqpl0y2Tkzs43dvvn2A2xAd60ich4MToJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwiWHDAK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwiWHDAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5771F000E9;
	Fri,  7 Aug 2026 22:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140971;
	bh=pVF8YwSbb/2VN4fcRon1QpmOBINC3+FbKsUEMTq8LO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DwiWHDAKAAa8W2waJiX0sjaRznXEfWgQ+cjGj2MhVJkU3uJNXSQ2OC+YuVwZ3qzB7
	 SWA00cz5tstKIK8SxYmP3OEHw8nc9s6/167mDrIERb9x3JP990yb/0PzkwsSkNjNC3
	 GPgILhxatHHaUPaRGRmwnmOGfAnSpGLVFgNHf3lqSz1ABBUijOkRdzwz8CPiHRWTrB
	 d2r7PyAs8C+ScAwlskR1eGwTan+vs4tqrS1msblH6ijvHr+4CMYvrBvfVy8cuyiAhp
	 NIQ6Cmxe6FsXO60t0AdtQd23SNs1iXMRUdIU1zXURF1k32+qzjUQCb7XKsu2DDc6D0
	 cf/syYbDxz/xA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] libceph: Amend checking to fix `make W=1` build breakage
Date: Fri,  7 Aug 2026 18:16:06 -0400
Message-ID: <20260807221607.3807878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072928-venue-payroll-5f6e@gregkh>
References: <2026072928-venue-payroll-5f6e@gregkh>
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
index 30d75970be449..d8dd8c1cf362e 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1440,7 +1440,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
 	ceph_decode_32_safe(p, end, len, e_inval);
 	if (len == 0 && incremental)
 		return NULL;	/* new_pg_temp: [] to remove */
-	if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
+	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
@@ -1621,7 +1621,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
 	u32 len, i;
 
 	ceph_decode_32_safe(p, end, len, e_inval);
-	if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
+	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
-- 
2.53.0

