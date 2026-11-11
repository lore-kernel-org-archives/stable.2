Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385741;
	b=xDt2Pa0RvAmEZcyR1sLElaZ/IjMspcFtZDm7U8I9CnTTdq3nOOGq7PM8RxT5XEAR6DkC
	 +GMwOYtM1POimpCB3VyIW/KwfIW38+msaknvm0vJFMjSN77njrURnIGY7E8xZiIt67WM0
	 IEJHfo0Qzwnwrpw1BOSMomGcV7C9neyVMjUw4MCVlPw9nHFGHquJhiN8zfDbaKsUw4vuv
	 FFr2WEH8mi1LvmwYxRubkyxhT4oBTY8YyH4AEdQtJY3oEZIxowU/EPDtkh8L9WAokiEHp
	 BdqSY4HvkACuUP3F/dLOLWXwE/XA6k9RGkZKAp1RTKnG1pudkhwKcu3/feePpmkPkKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385741;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YGkj40Dqx0czRNk9Rg8DBKwPgNsF2kkY70YRpq4l/2M=;
	b=CNgyM0uMWJdf9dzJOzvtaPYV0wcv+u2m+tIXcakfqAexW4BKbllwMzTklRMMA196sHOJ
	 QmXPsp7q+QpBcC5Sy66XWlA1scT71kRGapwcengua4vYDR77P+uKF4GfLUgxlCYuFuFVS
	 9ok9/FkXvvXuEI3F+jNshcwOC2mSZmnZsM+5qSXnsyfHyQg0RLlNdQZEJHF1mVldN1vsu
	 49KPgYpFK6uM+zkh8gc7WaBtoEUeazoSECgKfDXuykXKBxlUjRj4733IlKs729VV3WM3E
	 988KPifso7ztBxeY9qIv9ZCHAM6UAQnsyNAolyti5NBzGmVj3twVABjoNZ6FvFr5Vbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtXR0Lqj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510860A3837
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtXR0Lqj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096451F00A0F;
	Wed, 11 Nov 2026 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385740;
	bh=YGkj40Dqx0czRNk9Rg8DBKwPgNsF2kkY70YRpq4l/2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gtXR0Lqjv6iVG9LU+tcmczLSZN/vLf53X4oe5xSslPfU247m/klPCR3v/Ra56boeS
	 kGUsbFrRSNUSPAEjvXqJlwa8sbCpVAA3RiAhSeMqpE424lw0OYsG9yHIESX5KLFhwB
	 hPQsRpdaHmEavXtG+xzjOB1YbrN2rXTD9MM9caTkSav4SnL6nbDsaITlntcjSqLIdS
	 8NYp05Oprm7w6IR82/lIcb0+dn29MaMpOuu7WpbGBO6j6wYJLpSRGhokglmpdWd6XL
	 0dzHfEgyfQe1M8n4w6ejsWLZOeSJQAzeTn1GnzTlIl7qdbn9V2OS7r7YjuUWm76WUS
	 vCc9JMEwaxtUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: sung byeongchan <tjdqudcks0424@naver.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ceph: validate MDS reply fragtree split array length
Date: Wed, 11 Nov 2026 03:28:58 -0500
Message-ID: <20261111082641.1447389-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055519-failed-6.1-8cab7e7461f8@kernel.org>
References: <20261107055519-failed-6.1-8cab7e7461f8@kernel.org>
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

From: sung byeongchan <tjdqudcks0424@naver.com>

[ Upstream commit 8cab7e7461f81ea1e0fd45082b50bb3c04c0bb10 ]

parse_reply_info_in() advances over the fragtree split array using an
unchecked count multiplication.  On a 32-bit client, nsplits=0x20000000
wraps the byte length to zero, so the reply is accepted and
ceph_fill_fragtree() sorts far beyond the message front.

Compute the split length with size_mul() and require the complete array to
remain in the inode record before advancing the cursor.

The malformed reply faulted in frag_tree_split_cmp() twice on the tested
i386 baseline.  It was rejected without a fault twice after this change,
while a normal reply and a one-split control remained functional.

Cc: stable@vger.kernel.org
Fixes: 2f2dc053404f ("ceph: MDS client")
Assisted-by: LLM
Signed-off-by: sung byeongchan <tjdqudcks0424@naver.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ sashal: adjusted context to match existing includes and the features-based parse_reply_info_in() implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f8b469c900dee..d03a003b9ca30 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -13,6 +13,7 @@
 #include <linux/bits.h>
 #include <linux/ktime.h>
 #include <linux/bitmap.h>
+#include <linux/overflow.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -102,6 +103,7 @@ static int parse_reply_info_in(void **p, void *end,
 			       u64 features)
 {
 	int err = 0;
+	size_t splits_len;
 	u8 struct_v = 0;
 
 	if (features == (u64)-1) {
@@ -120,9 +122,11 @@ static int parse_reply_info_in(void **p, void *end,
 
 	ceph_decode_need(p, end, sizeof(struct ceph_mds_reply_inode), bad);
 	info->in = *p;
-	*p += sizeof(struct ceph_mds_reply_inode) +
-		sizeof(*info->in->fragtree.splits) *
-		le32_to_cpu(info->in->fragtree.nsplits);
+	splits_len = size_mul(sizeof(*info->in->fragtree.splits),
+			      le32_to_cpu(info->in->fragtree.nsplits));
+	*p += sizeof(struct ceph_mds_reply_inode);
+	ceph_decode_need(p, end, splits_len, bad);
+	*p += splits_len;
 
 	ceph_decode_32_safe(p, end, info->symlink_len, bad);
 	ceph_decode_need(p, end, info->symlink_len, bad);
-- 
2.53.0

