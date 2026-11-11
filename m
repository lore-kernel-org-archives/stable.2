Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794432435;
	b=HIv7nH2dnr2fLmSLITr3YeqniDIVnXgpl0ecODfl1tWWXnS7LK107CxCp6C6y4vFf3aI
	 yD1CB4wv8s4jsxRsy0/UxaqfbI3WMTgjmorF1bNJ2Colfizz0+qjAnWW4lTPhO+2Sl4AT
	 OHLpaCNnfJK8gAHTZi98JwEM3HZtS0QM7wiMJLLpGtG9VbsU8YbMMtsA5qOsRyqsS4BRZ
	 81EpXD5jVt8MBSRwXXY8kjb8daJK7HpiOfYfjWsZ0w1V6sIbsI0Z6xi4eN8yHftrl5ogz
	 DO32rQTn888OJdPf5XduJ013AHzW7Kx6sZyrT9SCadmo0ZFoccOj1n9K//erNIzfP4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794432435;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HSzm4oZJ4b5+Oyn6PGHQlKE9of+VYMiXW/E19mZXLVk=;
	b=SapmLIiHIUIljwYp07vp8Vk3R+/wf9Wu01b5iOtit5H0wUFHhgkUv+aSDokYCjw7CplW
	 eH8cYr0cJER/CMIFhv0Ax/LCWrrzDekIUyDy+eT8g9FI7Ty5CGuhnOUw3sUX4NYB8Tyf8
	 Jezpcd+Nl40IvmVjIOq9H8IvEcOOoJDKAAqrJ7q5q0EFICVVmx2ly5rKb/8EGTf30rPBf
	 LwyG8rB8VkGNg7q4myXxTLNiI45HxM2JZM5PcpjOFC/FcBeKig7vU2E6daX3zhB2lManu
	 tIHkK+o0azmcEpOKsCgkKlP0urOkHnF4fG9lGhsjsx0xGhmyOD/qlrleMM+iltbjSoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9RfFHre;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CAC606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9RfFHre
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F701F00A05;
	Wed, 11 Nov 2026 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794432435;
	bh=HSzm4oZJ4b5+Oyn6PGHQlKE9of+VYMiXW/E19mZXLVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d9RfFHre1UDdkG9nyzcJGNnc9CWVyzMUIePMgrAROquWqf3F1gQt9xO1zOjsBH0WM
	 h2GMl9ukTuO2zj9mSIeYVvyjNVi/rs4k1R8jgVl2b+48Fy0zcRc7SojJrhxjkaI8sN
	 tDzBuGefuFy6RU95hPNp0hnghW4PpQWZaSyjcrJx0HUtzCEgzRmB8J9Zq8/+FEG3YB
	 +74A5ewWMGuxXHSpmLp5XbgbTc0cndk00kEvPr445w5nfIH9V+UN2ORvZDp0a2Hklg
	 dv0ludCwJ/0CcbwjEpQKbWTIzMcR6v/piAZGPBAcMsHvkiqIeBBKkLilxR4SAHVMvq
	 rkqTxje67+RZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guolingxing <guolingxing@tju.edu.cn>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] btrfs: prevent deleting the wrong subvolume by ID
Date: Wed, 11 Nov 2026 16:27:13 -0500
Message-ID: <20261111212650.4069123-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201050-failed-6.6-1960146913b3@kernel.org>
References: <20261109201050-failed-6.6-1960146913b3@kernel.org>
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

From: guolingxing <guolingxing@tju.edu.cn>

[ Upstream commit 1960146913b31b288ed2cd607d103ee3b41681d4 ]

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
[ sashal: adapted the error path to use err instead of ret and out_dput instead of out_end_removing. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 54e3ec0685834..3b0c962d7a2f6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2535,6 +2535,17 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
 	inode = d_inode(dentry);
 	dest = BTRFS_I(inode)->root;
+
+	/*
+	 * A concurrent rename may have changed which subvolume the name
+	 * refers to. Verify that the resolved ID still matches the requested ID.
+	 */
+	if (destroy_v2 && (vol_args2->flags & BTRFS_SUBVOL_SPEC_BY_ID) &&
+	    btrfs_root_id(dest) != vol_args2->subvolid) {
+		err = -EAGAIN;
+		goto out_dput;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		/*
 		 * Regular user.  Only allow this with a special mount
-- 
2.53.0

