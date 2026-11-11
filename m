Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388619;
	b=O8mqGhugjZJC43cM6I5Ug1Nz3dN8alsR2nnqZQ6vjuN/EPCM/8pqf3mVtQOlQOT8Uvys
	 4CNsMUV5+rfLuBRTaN8IaD1oETagrBxGGybKre3ns8wMmtQb4rDwl5tfyBh4GUgcsDe8n
	 eL9gqiTR4NfQA+yeFBVblsCPf5iu5kvtS3F6l4wWOvr0/tYlJ8NaQBT4a60pF/RpHkOjE
	 xDzxy7UrKEhx1c2Xk6bHfvtKjJHMb01JJ0LWkLpR6TuY2tvo5gEk4Giajn20bmOnVHTzH
	 6nXXJHzaLFIiKQsTEfw2YDHXxT6bwSZI9EwaFuGuxHWHDxFl/QIt2lZ6hUjjXfTOsKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388619;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R4fByl6RIIy5RiYS4Xw0vGWNpLrM4TQPHjZCEwDdBvQ=;
	b=Clo9QPNApu86VIZQTCS4fAcwM6ncPmaAo0SnCThtrwBF6jH9PXqym1pniiogLqV4Oeb9
	 oYNVd6Y/Wg6QPHYbC45gB9B6Eq7QHtPJ6bonWjvQP57CyfPCv+o+XXAWMFu8pzCkBD4Wm
	 9LfC851SCa+AtyenNPaIuRrn484E6FW+n9m6Jczwg4TWKrzKgPdvgjmHM/EnkOMz4UTxj
	 rdYa7IA9jP9/1ImWDIACL5CJ9p+fDumV0aXBzjBJpQFEmfKeaIB46buFlIkoNa5nmi4e+
	 TGb/nkLawS2u3ugih8wuGd0pTiCwiuTCrLHLVCzZVOdXmkbFDh2bBBt4ppq/hraiOxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2dc2rvk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06716606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2dc2rvk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3C41F00A06;
	Wed, 11 Nov 2026 09:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794388618;
	bh=R4fByl6RIIy5RiYS4Xw0vGWNpLrM4TQPHjZCEwDdBvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E2dc2rvkxwmU4IT4m/zbWYWBRPE2b8OnDjLSyHzok7WCzYyhc70lgNFW4qeZqxYO+
	 vLvoOi5vPRi3cjDUcXEQPVEXXcL6b01/gKVEG1Yq34EM5cJEwZysGL9iiAbqFRzd7Z
	 ndMzH0p1YP7DlgegC/TIk1d47gqOyw1ssD20QBLYRPNBRfAgNe0t2u+ko33Pe3iHD4
	 QRZJvpOS214tQphXFzFSHGzsaszI5xN6rPRFK8aemfEMFs6O6kDSRVbhkeTwySdCRd
	 TojLnq8XoyFSWFKUOC/etu3Od1yebEL/0ESbTyZGWJLNfeli7JjGGevYgUyyRVq5kQ
	 2BCBxGXkwPDQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: sung byeongchan <tjdqudcks0424@naver.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ceph: validate MDS reply fragtree split array length
Date: Wed, 11 Nov 2026 04:16:56 -0500
Message-ID: <20261111091639.1451723-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061216-failed-5.15-8cab7e7461f8@kernel.org>
References: <20261107061216-failed-5.15-8cab7e7461f8@kernel.org>
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
[ sashal: adjusted context for existing headers and the features-based parse_reply_info_in() signature ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d1bac25eb3e72..39992327add07 100644
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

