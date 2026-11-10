Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272558;
	b=eHCGKseMQQbAaA0HN/hWxUK2t2PrxdCytxJwR3VxR8jJGXBXr6P5Fcej6a781gi21RbM
	 qYSDXd+WGmsFnTQuBJDCrcTrPuA3c4UJJm0aV8vCAscTRSJ7HtyLi95KOlgQ2HYDzxmnN
	 prsWAz6dtJisJM0vxfMpwSd7J5E3EUkBd/CQrmkWYyiyBDw3kysxk3mCW8uXevvAujvre
	 nguJd+/YriYOYLUwk+otBa8+p1tI70v69jR2CUte5sMIkrp1jckMB3hlwROgXmpRCnwSc
	 42hbfxmQab6N0HUdaGlImIFD/udgfmxTcXrctAiK3I5/lDxQ9sXfPpKGtN2VJahgUHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272558;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=r9OJf4S5ieMMw+vdRg0gwqP1+0gpfsj3jUAdzC8g/yo=;
	b=ogtj5bq1/s49srBUsS/0IHoJOdh2qd+qmCrI05mxfTd0tNH3Dbz6XiewEiJsrOn41y+h
	 evoqGXXlzOK/hWXywdylKC27Rb6kBoD+F8mP2YrFtCUZ21DHEJx0xGIg6y7Qf78s6UaQD
	 qRKTdPWzgbS40KF4f5Jr3oeKuLs4SmGme+g/anaVhU/+sITsj0FToXUjq+1ERwzsTrqNI
	 bpG9RSypjZRlvVvXDAKA+4vNYUFEohq/LTlEhZwNbXHlHpJcnFuRNycHrH7KirypY+Vd2
	 naK9Ddv9RJOJJYj5po0ow85MFYqdDwMPWhZ6OjiHXhh1dz0vot76DSw5c18NRUL593g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DghbeDQ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32750606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DghbeDQ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A861F0089F;
	Tue, 10 Nov 2026 01:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272558;
	bh=r9OJf4S5ieMMw+vdRg0gwqP1+0gpfsj3jUAdzC8g/yo=;
	h=From:To:Cc:Subject:Date;
	b=DghbeDQ6qQb5AojAAR6EL9zaL0Lb5/dn5Ji0z+ksBuU5/S4wYRFUDNHwEp6i4jcm1
	 MN+sJm61dSdIcOZOb2WbdPtrDTHzYtgK7/fX8Fk9YOR+fpz35zVa1W8mg2TqLDB9ip
	 zP2cOQqHaAGAIJCCF7AsrS53lls10tTK8o46ZDQXeL9uVTgiaTp8BmWoN06M0lG3eS
	 wvwWazq8zQLLJLXPcb5a8d1/KPL6U6fB42p5spzMQ3nt29nVkWnFygx/QnNqntFniC
	 B8u33pNzXkNL8VAgngiWtKkb0awRUVRtdKPpB7d/LoW95nts/ITdJVK3dzsCvZlNYW
	 8Vem8zBjJnskw==
From: Sasha Levin <sashal@kernel.org>
To: guolingxing@tju.edu.cn,
	wqu@suse.com,
	dsterba@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] btrfs: prevent deleting the wrong subvolume by ID" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:36 -0500
Message-ID: <20261109200236-failed-6.18-1960146913b3@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1960146913b31b288ed2cd607d103ee3b41681d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200236-failed-6.18-1960146913b3@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1960146913b31b288ed2cd607d103ee3b41681d4 Mon Sep 17 00:00:00 2001
From: guolingxing <guolingxing@tju.edu.cn>
Date: Sun, 18 Oct 2026 15:38:10 +0000
Subject: [PATCH] btrfs: prevent deleting the wrong subvolume by ID

When deleting a subvolume by ID, btrfs_ioctl_snap_destroy() first
resolves the requested ID to a name, then looks up that name again
under the parent directory lock.

A concurrent rename can change which subvolume is associated with
the name between these operations. Since the deletion path does not
verify the ID of the resolved subvolume, it can delete a different
subvolume while leaving the requested one intact.

This was reproduced by repeatedly exchanging the names of two
subvolumes using renameat2(RENAME_EXCHANGE) while deleting one of
them by ID. The wrong subvolume was deleted in 9 out of 14 independent
tests.

Fix this by checking that the resolved subvolume ID matches the
requested ID while holding the parent directory lock. Return -EAGAIN
on a mismatch so that userspace can retry the operation instead of
being told that the requested subvolume does not exist.

Fixes: 949964c92843 ("btrfs: add new BTRFS_IOC_SNAP_DESTROY_V2 ioctl")
CC: stable@vger.kernel.org
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: guolingxing <guolingxing@tju.edu.cn>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 43a945345cbe1..847fdc19bd402 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2393,6 +2393,17 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
 	inode = d_inode(dentry);
 	dest = BTRFS_I(inode)->root;
+
+	/*
+	 * A concurrent rename may have changed which subvolume the name
+	 * refers to. Verify that the resolved ID still matches the requested ID.
+	 */
+	if (destroy_v2 && (vol_args2->flags & BTRFS_SUBVOL_SPEC_BY_ID) &&
+	    btrfs_root_id(dest) != vol_args2->subvolid) {
+		ret = -EAGAIN;
+		goto out_end_removing;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		/*
 		 * Regular user.  Only allow this with a special mount
-- 
2.53.0




