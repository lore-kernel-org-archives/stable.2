Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047973;
	b=N9gZP7oEfnmlAQyVOAwM61Sra3DEfyzfrC+p1VqhVmbMdkntElncLH1jGUfh11WS36UZ
	 flEq+OwxPtBt4vUScMmQVk5zaJI7r1hfDSYzFNj/00Q5QGAiRLwOZJUa98LnHlepkT/Tg
	 Cw1gOenrMMxNV83XQxgYlyZjhXBA6dwKBw1qltI1mIK7GGjyFxz5BQUnlGG+eq9lWP4ND
	 18bT/ucAm0Yelg2rntLsKI1V5EahLXlUUTWXlEPh3sc8/H9xqvnOhHSFbNbmAdxfB5LdH
	 our6HMFc80mnasFMAt+NRcjwCzrIW6B5tIGSx6+DIMiPnrwUVTBWOqzcQbFLGnCAeRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047973;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VaIGGPO2Yk3N078qsjvibSxkeBkUeLVLPST2HAFdFE8=;
	b=LEYmxKNRTzXhzJ9qLjubNvNyXCO9ZLnRHN3Aop8iy2XJdYXzMvGPYQj0iYxzS835L6NP
	 2RvqvvfpBPiMrxN7BxnKKhjHio+WPPOCoBIPT6QZ9G28+ZJuKBi/5pOebKmlfR8mRKadr
	 hfW+RqLehrCf5cS+GGqcFHJ4RTsoli73fJlhv6OO6Amrq884pq/93MfCwQAsFAqzR1x/d
	 zlSgcjxvF1adxaLyA9h9CYgfngvn/iCDomqEnaTxnQYK02Fou1FP5DPGt7k/NB3l4JIO2
	 E3/ScgPvnNaGyllUqISQTKNA2YfWAe9Z3hEP0BItmDzglfjUZS1j+hQEu9UZBnGADWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXt+MbEd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30AA606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXt+MbEd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD8E1F0089F;
	Sat,  7 Nov 2026 10:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047972;
	bh=VaIGGPO2Yk3N078qsjvibSxkeBkUeLVLPST2HAFdFE8=;
	h=From:To:Cc:Subject:Date;
	b=LXt+MbEdzIUakjBiFlBMuUyo3GZOgQGCyawm8lalRv+CXX2BD+69uwyQD4jhZQT+z
	 kksErwyQalJQWwYmBJ7gRQAGSjK3soaYVMoiWdOsjnNXgjKk8j3IuRvPQoLMsvC4H3
	 1lBSqF7L9tC3EAu6p4BJbF2NndTVVQ3Gh8ZOkoEQB4CtPI0W8kHk7UvtYtnPga1gK8
	 tIUI5jgGYI4Frg8auLUq6bnX1AsJ1y1omFA2tJfn+P7dXJ5ELydm2x8eEhIlknvhvE
	 VzcR1/itlpQCgsZyo9QjwYyUcsaTgZdJ3TXj/gIJD0eNk7Ga89jTYRdvhuvy+/tQv0
	 AH50yOosjN30A==
From: Sasha Levin <sashal@kernel.org>
To: tjdqudcks0424@naver.com,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: validate MDS reply fragtree split array length" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:31 -0500
Message-ID: <20261107053931-failed-6.6-8cab7e7461f8@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8cab7e7461f81ea1e0fd45082b50bb3c04c0bb10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053931-failed-6.6-8cab7e7461f8@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8cab7e7461f81ea1e0fd45082b50bb3c04c0bb10 Mon Sep 17 00:00:00 2001
From: sung byeongchan <tjdqudcks0424@naver.com>
Date: Thu, 8 Oct 2026 15:07:25 +0900
Subject: [PATCH] ceph: validate MDS reply fragtree split array length

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
---
 fs/ceph/mds_client.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 456330f1d3c53..de36c83e94c0d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -15,6 +15,7 @@
 #include <linux/ktime.h>
 #include <linux/bitmap.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/overflow.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -146,6 +147,7 @@ static int parse_reply_info_in(void **p, void *end,
 			       struct ceph_mds_client *mdsc)
 {
 	int err = 0;
+	size_t splits_len;
 	u8 struct_v = 0;
 	u8 struct_compat = 0;
 	u32 struct_len = 0;
@@ -166,9 +168,11 @@ static int parse_reply_info_in(void **p, void *end,
 
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




