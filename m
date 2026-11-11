Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391855;
	b=Ane+olb7ZSIkHQXBtUYOMtP4ovY2kD9rV8uEn/mL86HURoOk4XBwAYhMqvpKbjioqd6r
	 wR2LT61Br0k1bR1S7HHDP/Wda6c7NeWbj1MDo0jNqVBTJCZqUcNzol6yRLXbT/5Q7bPkq
	 lfRPnK7b8g/jYq4gGyWF2A/WjtBDzmOOA/Gc8DlSZTeM5pcbvXiUtVXlKLWN5ZNdhOvy4
	 qRNjALVQAGgY74wLjySeHfxV95/DdJ8gQaqBPx3nZIRoFoKYdbxyeZoZXfgT+bF4M5PJN
	 wQ4ID+aX7Adv3zxAdPfx7N8Cv3skrxqZsmo1wVAvIe6j9ogIgYeeAatycxJT0vCDVbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3jmYuqK+pQF0PqyrxCK+pZjUR5xDVd0PTykcrV14pak=;
	b=EaJLR5lzZxwFurOUHX09A8CrhckwTxa1H9ZfRUw+XusgMmAJF7FOsY36c2hG8zuq8X4k
	 MzLjjeYbYkqLw2nvbUdoPaDZfocGTYtV7fVFWJxs2YVX2AiA109j7jvWzgk3VtSRN8UsJ
	 YXSQ3USM1+XIiEvg5tkuq1GDM4wGZamWOmR/cAYIBUlxHtKHut2IZPGKKXHvcfNc2PRFd
	 gYdT/O1JQ3g2TYOoh0kNYutWYIrVCaHoWFoLQFoaNVNrdDwsBHALRSVbjfyS7jr0BBOLi
	 3r7gGOxUq8eGM1vgAz1t7HPrwfP46ERld6s0UeHRgNS3J+rRBQblIIjUOTua7xr2ciw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osTPVFOa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041FC606A331
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osTPVFOa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0751E1F00A05;
	Wed, 11 Nov 2026 10:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391854;
	bh=3jmYuqK+pQF0PqyrxCK+pZjUR5xDVd0PTykcrV14pak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=osTPVFOaUEuhQ3YtY5Ci/Cvdnaj1zBZR5lC3PH0YCoJJOUuFYqe/4AHysT9CsWxaD
	 Qn14kJeUDWtcPWtmKfDn3PzgRquQoFF6jSkXNMqg1f/vH7RXbqQEOXzLndvHQNFVlf
	 lhBGPDHa0TUrZQ0+6mJGv4UXf1vLR6UDS7jmqHkgjJ21GMCjmqEfsOedEx9uHd1qAy
	 cV3qkL8G2txrHc3cKNj6gx+kimi9JttKyymLVULdhQGJTt8cOs9VKRkkaTYDqiH0Hn
	 FNSUu0jKmAMVJ3g6n4aCDZEaNgDlFklYTchn8Ne9smIivHHCoaEVr0ZtfY1on946sU
	 z5fyGCYmd6cZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: sung byeongchan <tjdqudcks0424@naver.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ceph: validate MDS reply fragtree split array length
Date: Wed, 11 Nov 2026 05:10:52 -0500
Message-ID: <20261111101034.1490144-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062912-failed-5.10-8cab7e7461f8@kernel.org>
References: <20261107062912-failed-5.10-8cab7e7461f8@kernel.org>
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
[ sashal: Adjusted include placement to account for missing bitmap and mount ID mapping headers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 8154c08d54977..b7daa7d76dea5 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -12,6 +12,7 @@
 #include <linux/ratelimit.h>
 #include <linux/bits.h>
 #include <linux/ktime.h>
+#include <linux/overflow.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -101,6 +102,7 @@ static int parse_reply_info_in(void **p, void *end,
 			       u64 features)
 {
 	int err = 0;
+	size_t splits_len;
 	u8 struct_v = 0;
 
 	if (features == (u64)-1) {
@@ -119,9 +121,11 @@ static int parse_reply_info_in(void **p, void *end,
 
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

