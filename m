Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385473;
	b=xpZiK/X6kLioGZOAUqJ50+BQU26MiC1i6CKB6L6L5qo+TSHquNdPLHWKKSySnZjV82zd
	 tY6HB4dmR2pQ9ToZ08EexGZzKD4cXTurSh/gZSex5qQ2yz2xvMJMbUHfeQG6opvCCweR4
	 IeaEbJAYTXQJYcRBf+l4mkfke0Lnlae3J8jqpi43pLBv8BeHyeig12P8RujmsHL0zMR96
	 QB63T2js25LQSrnOHCeYyqdbsvvb9/nDVJ0PA4BNtutF4bup7OyO0d3BuA45X83GJAwwa
	 a2mKiMe5+sNrNhBxeovSDf5P0ILhDXCWlB0hYoNpAAxmE2qr4H4kU4j0nzapFaTmeSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oqPI9wS7xdqjn/5PDAEj5r6VlEs5wiu6GooWPzl6N1s=;
	b=CRuBlzFxKRuviCDgMo7FBqBOJwANEK3yzpFH6y86SYfuB2/w0yvdLTlEDjrAh2KIVDkM
	 nwtGwtgqgR9Efd7gp7vsIAPTHtx7kaBJceJRgIhN1DGXzlphRenp9z6xTZ/JlQpX67E9n
	 0HCvSrDhXFSys2/kR6//k83cZljQTYMEy+jmyE/U1sPYRhM0qYu9irA8+8/XKwGw6Ye8Y
	 d78i+UYgVEwi8pF/1uvLjHArzOwbTQNzidtch1sCuESvty7cX4+tLUwxfRo2HoQEV0mO3
	 IMQv2nGG5yLYV9fPlfhpCXJL7iUtk9AW+sg2ZGMOK0JHUuSUKZ81lvhD9GvRwo584Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqA5uZqF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA906606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqA5uZqF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3901F00A05;
	Wed, 11 Nov 2026 08:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385473;
	bh=oqPI9wS7xdqjn/5PDAEj5r6VlEs5wiu6GooWPzl6N1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OqA5uZqF8H5W7Dk/tQUtjyHfohO7l36gDpUuXPBgwubBZNcqWGxXCAI2VrtlofB02
	 3pwN3Gf+T8higOF/aEBkVL83/FKzdTReoDpp7C3FIUl/wcakEHtNTcTLNZ2PHKIQ9l
	 jJ7nHHW7Lw90nkEXnSJrPuH/4olmSGLAPGx2lTMEuhPjiItraauyTEYfF/Tbnb4Z1p
	 mxaW28NK9w/xfWpK+e7zACuotdAnGfmap7HMIG5V3rUk1aP/ZUedBXlUBVKvNPnAs9
	 +Ooa6NJGwTGC3yx1fAm0qvSln1gz6TlAa09Y1hRiUviILbEuF5/C4bLY/lQ6awZb8J
	 WYfEEKKQaAV4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: sung byeongchan <tjdqudcks0424@naver.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ceph: validate MDS reply fragtree split array length
Date: Wed, 11 Nov 2026 03:24:31 -0500
Message-ID: <20261111082212.1430125-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053931-failed-6.6-8cab7e7461f8@kernel.org>
References: <20261107053931-failed-6.6-8cab7e7461f8@kernel.org>
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
[ sashal: Adjusted overflow.h include placement because the mnt_idmapping.h include is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 321acdcd29db0..331cb321cbc82 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -13,6 +13,7 @@
 #include <linux/bits.h>
 #include <linux/ktime.h>
 #include <linux/bitmap.h>
+#include <linux/overflow.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -103,6 +104,7 @@ static int parse_reply_info_in(void **p, void *end,
 			       u64 features)
 {
 	int err = 0;
+	size_t splits_len;
 	u8 struct_v = 0;
 
 	if (features == (u64)-1) {
@@ -121,9 +123,11 @@ static int parse_reply_info_in(void **p, void *end,
 
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

