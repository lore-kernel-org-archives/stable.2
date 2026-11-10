Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272813;
	b=HuJPL8ZBVNjCTnNagw37JsB8HPE5ckQLQvproa0UCClAZSyGKiJfPpjenI60aei7NjZ2
	 uUz+tuhHsvhG6yO/7u4B7370i2XSA0lYCiSJ1i4ScWGxLgvbQj8jR64q97UrT48sDmeOq
	 ACWg7V+v0FYARTT/iRcWBjXldVod2+kaxvvUUjEKEcIVHGjv90ktK2BzIVO6MSsJzBTEo
	 QRX4MrYK1BU4SR0j1vkQDCaoPVdp8vgTB0PoILsEjUqupwx8HFPyK9pO16F8RP/rNu5W2
	 EtF7SwDDf3o3JR328ZESPUFd8ZaBJuEWH0TU39cskEC2SewMQgJnxgHSBObFHwslPGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CCbXL6fU8ER3Ov0R5/5TEtqR81C7eiNv4lWGugQgElE=;
	b=wPGEoMEquJV97mXAyewC/K7Weixk4vDwIJWBiUyKFl5P7ygu2J9rI6q1KuiUtoPD3+1b
	 M7KrZoESZX/uz6dCIj3BUACmrJtU41hKii700vBGB/qbtXLcy+pXd0iajLmnuwcmCOKey
	 M4+wPns6ePIGncMplcefTqOGxZR7eguBsahL6H+2qI+l1luLrmTQpG+5vF53pBX29zyi1
	 dYpzgxGyEAe8AcYjCdNoIuy4V3i6kMtcmWwj9l2NbEFtrTD681rb6joQu93+XJ2K6MDSf
	 ZhiQ3pQ1UuxV7vNe2BSFJkJr0ryAWN9Y0j8LiYUPc0uW4rNPqXPxmWo/e3KtwO8EQAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCl2dZx6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46970606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCl2dZx6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F641F0089F;
	Tue, 10 Nov 2026 01:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272813;
	bh=CCbXL6fU8ER3Ov0R5/5TEtqR81C7eiNv4lWGugQgElE=;
	h=From:To:Cc:Subject:Date;
	b=SCl2dZx6efN8XkxHyjS0oMUCPWeClIaA2s3e39I/H97HoQ6vZeb79vmWiRJj9gRhd
	 BhQAbB6k3Go+9PWADlBh7XJt6A8iQM73HUhQn2sjkvvGeMc6hw9Dyu5QGepkQ5oH9O
	 2kuJQKNkwYl2nhBml5O2nBnwpwxD5r/qz/rKc4Gghlu7urP6muveSy4aK1d+coB0Ee
	 shDzuL7GsRb6TGfTNuhfUnJnCkt4CU2bukEm/sARn8MsRtNuddMAoS3b4ANeZTU4on
	 8roNrx05qUXb+K/OrWeV7yLpkiaB+Li4utpL9aMyFcs70pbT3wDYC01GIqqyLE7VOn
	 gz+wUDbpGy7uQ==
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
Subject: FAILED: patch "[PATCH] hugetlbfs: enforce F_SEAL_EXEC in setattr" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:51 -0500
Message-ID: <20261109200651-failed-6.12-b7f570e7cea7@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b7f570e7cea761ec7eb4a3a9557a3a082d14e88c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200651-failed-6.12-b7f570e7cea7@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




