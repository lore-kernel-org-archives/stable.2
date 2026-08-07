Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8940A942
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141548; cv=none; b=Pvl0Dy+yT0xAg83IhEBn3mqyuY9ZOSBJvA4gIyvR4lFTGt1ArNx1KK7YLqaEq3Uw6KZ1BF42mXz5fRUdv9K+JHD6qdmUPLoP4AypK7W7LjIBny+rhP93KzerNkSdF/gmlE6wbcd8SgMmH7c616kJY4ERI0qRETH8a4YatiCy+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141548; c=relaxed/simple;
	bh=6uQwBGWEjZuhKsUQK1tKjft/7EC2hQBMsN7FbBN6pCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDdoL/UMTt6syCEErgb+sdFXVQISvmVXx6MrDGXw9TSwTMi8mtZBuew2nLmSqAYlMAWxDZlFcfeWPCTOW43U3BuTMsZRKEHpmmdcFXlKoqaIf/Nl2E4M5DkJ83ejNe/L6ewmdmqKW+l6j8gWsaYDa+RuaJ6rg+Azi3c8LM2ngX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK452ali; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK452ali"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27BF1F000E9;
	Fri,  7 Aug 2026 22:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786141546;
	bh=pVF8YwSbb/2VN4fcRon1QpmOBINC3+FbKsUEMTq8LO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PK452alio2HBlDjgPHYem/ATDzxQiovguXSa9seHI856QoXdpZeRUAf55ffTAgzhd
	 R0S28eoYumLnWIm3ocTcpnadc5Bc+boXnZqvuI5dzg0D3OaNy4IOlW4knNLskE02CB
	 FaNEgeP+4sXwm74FvpyhBX7vGkr7HwMfVCCgHAxox3kBzi4MGgGC0ppGe+bIgeefCQ
	 8ntLTaNYY0MuX2uavQW0+IP7mBQJYfi0QMZe6lZPBpoeZNWgnE6FkSZW2nosR49tjh
	 ncGP0QkTuMo8TtDWD4A+F6MhOkfFp1SwMfd/CXVvZslef5NpoApfQr4Fi7jHMI2X7J
	 neSM37zeShWMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] libceph: Amend checking to fix `make W=1` build breakage
Date: Fri,  7 Aug 2026 18:25:40 -0400
Message-ID: <20260807222541.3839701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072928-spindle-pessimism-d1f4@gregkh>
References: <2026072928-spindle-pessimism-d1f4@gregkh>
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

