Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E28353A64
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140603; cv=none; b=O/DSTpCkTF1NzY0+Mv9YUrywX0LFnE8gESByoCLUf723vQeXzjn9optkZV5WOPpv/ke9tvdYHGtZrZrM4je4TWGUHbe7kY9TvTKkqML8hMMDGtP8BxVLr4P/duk8v3QNS71HJKJjcoh6tsSbT3rnr+XMVXp5gvX1IbI2RbAPlWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140603; c=relaxed/simple;
	bh=6uQwBGWEjZuhKsUQK1tKjft/7EC2hQBMsN7FbBN6pCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zipn1H+yfLrl4oyJqhsTakL8i2hNDm8ytRh3I/FsapACEZziBvh8DOKVG6MkNdU6bY2FYu+8ZuYpbwnRCb5PGpmDS4JW7e5lom+xk0DcMEqBll4bUlnc6PlFqFFQX0ZHWUxoDe/+h4LFpsDkqqG2XQa5kPErNoLAGstZEGpoiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKFx26KJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKFx26KJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E441F00A3E;
	Fri,  7 Aug 2026 22:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140601;
	bh=pVF8YwSbb/2VN4fcRon1QpmOBINC3+FbKsUEMTq8LO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MKFx26KJYDmVOObz8I0ccl75fvDA8XAY/DieXLKBGOk+9GobBjRjg0A3Ig+qPGSHd
	 K+FCx+gD862si+zWYdp7mCamrLG5afy81WkKNQyub671ooq0wy3CdsagftgsB/3dnn
	 J/v3YLqXwsuzfWpU7BYIgcFYazXzZX3YTbmfb9uSb50qL47drAF2DSRXOSFpd6GdIu
	 +aCd/200+vXAwSJohgg0/6E+loWPSTI9ykXZEv2RLJZlqx/WsCHwuI4anKJvha7UE1
	 USj6CHdZwNBV2qILpLfBEioNrMyI4IoidyXsP9mdw7dWvGoMd3dq3eA+F7ataIqRz7
	 r0wUz9sbxw5fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] libceph: Amend checking to fix `make W=1` build breakage
Date: Fri,  7 Aug 2026 18:09:56 -0400
Message-ID: <20260807220957.3784015-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072927-cloud-mustang-1d03@gregkh>
References: <2026072927-cloud-mustang-1d03@gregkh>
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

