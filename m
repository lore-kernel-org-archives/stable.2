Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048922;
	b=3EB0rtq1Lc0IOc7gu/tvSChAq4FwUc0w1TnYAi1ncw/bviIbF1qnLgqSrVOPSah+k4T3
	 IecAqf6A9QMAdvtiFxuRDeYjSPn2Pd8PtD7Zwz8W0CZadp73JSyGu+iV5AxghX0GMOsBQ
	 U/pvLtzWsCZRjoUnHc68f06KE68qHECEreEvD5RVh3gTNjTnXp8ahyLL6M+qzhL6LNbF2
	 bHtNeoBqgt2SF7HsB2w3dOTgIWJ4nPaKMe+/nflRkPQmdu2Xv9XOjsEoPb/JsVi+eBe48
	 MjwMO/imIyZ+c7LOv9h5/BOCmnzRlx2rNuLmOQVKQVK2ZS3CvSHod13MTjzWpJdseXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048922;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qxUv3r2ruTeJRnoTbIe/o7Qdg4exr2uDZyNBjgsjPYU=;
	b=I0TRXKw/wWxs9shnnFyXB3eGg6dLheBCLa7yQ70aPQ4y497jGw+6BqO61n/G26cvEJ7g
	 mh3FkESiqWiVDK9i3MFXpcHZkfO8XpCs1dDn4YhWoC3rZlZ4bilTzTBcUOBKcbWiwqgJv
	 gCYT85g8OKVfqbZYUs4r4U/Niq2oMtnEliIF21TPtYdIql7ktLbfakAnrY6B8impN+hfV
	 8m41FcTmGTDY/4ZHGB8CGXU8/hYVxH9gf0PZUbBaNGgyNErtmRsRpfkC+XMy5S9cxkNwa
	 mHXa854+iBUSLLV47R8O+HJmkcBNRaAJt6bkh8Fn/T0AeWwMnpayu2w80nzwr4io+Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZBzAyb8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3824606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZBzAyb8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EE21F0089F;
	Sat,  7 Nov 2026 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048921;
	bh=qxUv3r2ruTeJRnoTbIe/o7Qdg4exr2uDZyNBjgsjPYU=;
	h=From:To:Cc:Subject:Date;
	b=gZBzAyb8jR7C7v8CsOJ3NqlmtW9ag1HdGfnUS+w60cfbIDuuLNYS3RkxVX1rEu7uS
	 zU3kUUI1yHKkbR1HjPNMPbsF+ijP0haYvvVFN+QlSthuYcFwfs4Tzjr0p9cFwv3CML
	 g3rz1xnKV8sTDrLFrH8rLX33Z8wyYdyx1TAXBXjBPO62t2vfqK8YEcskw6eR5x6RyS
	 vLxVHsPl4vVRJVBdKqR/sCmeZcTqcTBOs2jsZya9xHoVt2uhHxRnRIEqatisHlYqFR
	 +n+YbpiHNfUUSZZa6eBC5jB3HMN0+8SlCuikN6SuXW4QYnUwGw2rkST0sqVfJtSqBs
	 JzfEGFIU373FA==
From: Sasha Levin <sashal@kernel.org>
To: tjdqudcks0424@naver.com,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: validate MDS reply fragtree split array length" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:20 -0500
Message-ID: <20261107055519-failed-6.1-8cab7e7461f8@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8cab7e7461f81ea1e0fd45082b50bb3c04c0bb10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055519-failed-6.1-8cab7e7461f8@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




