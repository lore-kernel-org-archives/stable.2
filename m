Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273335;
	b=SnkMD/RvdKbO10MU/bEOA8wyVbAXR4P78+SfAOJ0HJuXlvxN8nu/oLeJ5Xrf1/drWSmR
	 XSR2RSnIexMqJ4Bf+FF+HH9CSsUBEdMt8Icy8KfLKv19r8K1hQBXIdJDaJqhhqmWDof0t
	 7CX1w08Olai0U/32A3366OKFcgUrLnTQttPErqmruM5Al6Yp8hO7bK5u71MEPlJo8xvMP
	 0BTQqPw3t9DzCinSd2WDc2d+oiGxbav99f3oAXFVSdl7ZBvwUz4pTycC99kP1j/OXkrIN
	 YgLGS3aUitVD/Hy+jbSpJyO1OQoBgek9ecMEXhD6HSCAY+MeXK7ujq+byhdYU8kBu4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273335;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DQqbQp40ik3F4RMYlaUwHWNSTgflSqIQLM9rUrdaUtc=;
	b=ucw1YBvJDCaNS6mHrAoiKZQZRCQLyfl6qsOWTi1KtpGKEiNfCDb48Wui5lwJlbXjqb5g
	 JJG2Ua9SX9GLd2owDN8LbvXQfZQy8zBtiWHTNx4PF//vyFiRnDMkH8AxGDX/Bz61E8dq5
	 9AmrYHp3KzqTa4vEiCbw8Fo8CgMai98LqxZaGkQ08R4TgbuKIXYWcTwff/7rY0XlzL5kH
	 WfXBPobuPkRNGBrtiK7PAYoTNGCvLkOqDFE7Nbal70opbyJr1E19ARQptmtg+bIqoCByG
	 mUBWeEij5vxTmardla7Akl7ekoWHtEJT8KvxFFXvpqijk/x3M+T3e/KxtEwWyyqkYTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSQUKwPZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06707606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSQUKwPZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D851F0089F;
	Tue, 10 Nov 2026 01:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273334;
	bh=DQqbQp40ik3F4RMYlaUwHWNSTgflSqIQLM9rUrdaUtc=;
	h=From:To:Cc:Subject:Date;
	b=dSQUKwPZi4J6ccN+IyS4ZCgtCx7cklEh9KtIj8Jed9hjnwaz/Nsvw6cwn7LlNG6fN
	 vQBXB7CWVM2IREJWYM08PZUsOqoAL7mNJQ12bnQkpX2PP0P0VP2q6BvvhwrLN3zalX
	 w3a9nHVtUviIEwmFp9MMqAo3D4OuavFFXPJwApOCTwV4sXw72uNOTGPire2NmkdnFX
	 fptYjRS38VSLAHc3Bi9tncQsq0N7GXxex/bkyGQcvdgEE6hUXCw2ezENVPfbGgZUCl
	 txfuLGCPlIbOD7yrK21UyY1wTJQIH6ihYAOBRoPxHP17pB33hJ0NuvIIMYidre/gyC
	 zJtsiJQ60p9cQ==
From: Sasha Levin <sashal@kernel.org>
To: guolingxing@tju.edu.cn,
	wqu@suse.com,
	dsterba@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] btrfs: prevent deleting the wrong subvolume by ID" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:15:33 -0500
Message-ID: <20261109201533-failed-6.1-1960146913b3@kernel.org>
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
git cherry-pick -x 1960146913b31b288ed2cd607d103ee3b41681d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201533-failed-6.1-1960146913b3@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




