Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272485;
	b=psFvUI92uxkyeTIb4ZpKAnstAlLI56G9gZ4gYvFuxR5WmI9vn+EauMgBIe1i+n5McRfJ
	 CcFMCpWeUuYCgqZX1tdt01BEHmVb2T88kur2Btq8rqojxCsLhc38VB/hs7fFoTY1pe3/J
	 po9B6DFGj5XiamqPFKYnNGLBPxP3AcqU93lvQYISvqhQsSIBg2Cu281DWnYdhJThCq2tR
	 r+t0sX4jskI1DQgfdpYGO4yVqgrsOZZQf8fqSNhfyChXm+dU95ehB1SltlO+XudnyMMU0
	 5fqyhNYSzWS48QY/MEFdRMRsEwc19WEnz7PnWAdDU4CsdDS4FjBT9VzcpRH8fXeu2PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272485;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4AX+DoeN8QKmosQbhUH+TDObpC9Af/2h4YteJXQqZVY=;
	b=i1cbVa1s9YaDaCq7mrqPp5S+MvQcwqndPWdWf96N8bLFg9Txpt+8IgriYWjiUA5wxHTM
	 lPutX7Qq6yzRPVe7ycAkDa3zjGQF4LlA5RFLdNvjhMj/w51tDipEAOBt0pvNSV7JgZiL2
	 mTpwPFW0Vka8EKC/4Cmv0fYhlVYfCM6t0rj3ukTke14q6GYEAiG8D0cmixbKwt0yN+5Ec
	 WFCDQ8GslzgIvEhdWP0/HwDcFQ/+plrE71wLEuzVAKDdVInLCnTk05wL4Z3+y2czI174l
	 hO1xr3DsLwwvJTGKPnjA07Mm/qoTIknSc4tQkcHdHrtvz2e44GwmlQNz4dGje7CCEag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIYlXGvS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BAE606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIYlXGvS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C381F0089F;
	Tue, 10 Nov 2026 01:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272484;
	bh=4AX+DoeN8QKmosQbhUH+TDObpC9Af/2h4YteJXQqZVY=;
	h=From:To:Cc:Subject:Date;
	b=KIYlXGvSooM/pPpcz/rzO1Fh4Hkx2dMi7pm8UTdBnfRG+7Kl3gOdSF2nUDT9ohSIF
	 BaCCUMxR1DggMnsAoDhi+m0CRjOeyFNEqHQ4suTZmBhH0+doWeDVTnSTuhnsgm0cjN
	 lsEoSWrngT4HpPFnZbVwfqvjpciCPnfM6smSl5MEbBzSZ4xVjzSCHpdUskD0lqu3iK
	 2Piy/TvObo6gCAQYGNo3Lws65d1WVcEIKz0/l3urmbwfh8ekcxb9B/momD3kjv9YIu
	 L/PoWnOeq6ysJe+K4gc8a4PD92lJ8cc8phTarevcLLPMrihK+3Fv5/cStxlLjRPYco
	 C++s+FkI4N8OQ==
From: Sasha Levin <sashal@kernel.org>
To: eva.kurchatova@virtuozzo.com,
	pfalcato@suse.de,
	kas@kernel.org,
	ziy@nvidia.com,
	gourry@gourry.net,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hugetlbfs: enforce F_SEAL_EXEC in setattr" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:01:22 -0500
Message-ID: <20261109200122-failed-7.3-b7f570e7cea7@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x b7f570e7cea761ec7eb4a3a9557a3a082d14e88c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200122-failed-7.3-b7f570e7cea7@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b7f570e7cea761ec7eb4a3a9557a3a082d14e88c Mon Sep 17 00:00:00 2001
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Date: Thu, 29 Oct 2026 11:43:26 +0100
Subject: [PATCH] hugetlbfs: enforce F_SEAL_EXEC in setattr

F_SEAL_EXEC is enforced by shmem_setattr(), but hugetlbfs_setattr() does
not check it. As a result, fchmod() can change the execute bits of a
sealed hugetlbfs memfd.

Use memfd_check_seals_mode() in hugetlbfs_setattr() to reject changes
to execute bits when F_SEAL_EXEC is set.

This also fixes the memfd_test hugetlbfs SEAL-EXEC subtest, where
fchmod() incorrectly succeeded after applying F_SEAL_EXEC.

Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
Cc: stable@vger.kernel.org
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Link: https://patch.msgid.link/20260629180247.2343229-1-eva.kurchatova@virtuozzo.com
Acked-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
[ david: use common helper; fixup Fixes:; check only regular files ]
Acked-by: Oscar Salvador <osalvador@suse.de>
Link: https://patch.msgid.link/20261029-fixes_shmem-v4-5-392fc715d8f6@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 01c4d6f44ebe0..02e0a65d596d8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -28,6 +28,7 @@
 #include <linux/folio_batch.h>
 #include <linux/fs_parser.h>
 #include <linux/mman.h>
+#include <linux/memfd.h>
 #include <linux/slab.h>
 #include <linux/dnotify.h>
 #include <linux/statfs.h>
@@ -840,6 +841,13 @@ static int hugetlbfs_setattr(const struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
+	if (S_ISREG(inode->i_mode) && (ia_valid & ATTR_MODE)) {
+		error = memfd_check_seals_mode(info->seals, inode->i_mode,
+					       attr->ia_mode);
+		if (error)
+			return error;
+	}
+
 	trace_hugetlbfs_setattr(inode, dentry, attr);
 
 	if (ia_valid & ATTR_SIZE) {
-- 
2.53.0




