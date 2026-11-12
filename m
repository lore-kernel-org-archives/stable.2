Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442955;
	b=T2ZPWKlgBbVEiQW4Rk2PkRGjTNgHshiy8olGmyQg1r9y4OddKKRit2QRuGd5Z4JyWt7h
	 gjs6Sm/TdfRxGAsy+0Dt8/WEk9P1evEw9RMJOdA0Qv59qfUIB05Z8lswRgOqdUUFlYxae
	 +Oy/DJKdwE0uf2rIvqpRz4SwBMWwkXIr+AvHVzPlF9krOTEaqsoleb7+z0pSmjdcmZjEl
	 YhTkd4CjvwK71CwAVu/D6dFy0mGKBjmPYk/j8OU+09SUu8egIROM5clN1XkQp1CX1x8eR
	 nYhBVArO6W9RMKv1aRSazlXwbrRTSGBeBqHcVRzkejVuRgB5vcP/e6nhUljH/kE0mpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442955;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o9nN4K1hpc+aFwsGHDXVDrx7hYL6LIX0M8yg+4Xprqg=;
	b=2H5Ijw0YEE1U0dqo1LxhZK5lYyyBXsoJJgBtdbx6sn4BMDulttlOWDF/Tw10j1X1RObS
	 wJYjtn+SGJa99FyacZvraSYFBnk1Z17i12laXtDAv2RckDCdbi89J7DapzLtqr7Qblyrq
	 0A6c7eud5wmmtbO/almqKtDSJop4lZEQr0asGOHaf6k7QSx+8lL1L/KJ2w372r+xe+AS2
	 hViYPgQH8Ncc36SKLd+0HFWD8sR24MShlzWlN7x4U45OHvOn3Cy0KJhIjhVHQ5bnsDrkl
	 h0/nPppn2uUHlQnNR1hLYGHy3RXi96NpEN9JvnUjwiHzLCKBXVGqjJyz8rw64BDns0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igrly0HC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642D606A324
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igrly0HC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E901F00A05;
	Thu, 12 Nov 2026 00:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442955;
	bh=o9nN4K1hpc+aFwsGHDXVDrx7hYL6LIX0M8yg+4Xprqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=igrly0HCMcI4iL48U9BMcnm6R92RaUl1/SbSwFRwy0tR7Yf/5zkL44iXxV3a3Pi0K
	 R24Nk6r1O5/+M4mZ6SBEuAvjfaUz3xe3oyG1a/x8SNorF+AyYYWWjpAqkGm+7g/Glc
	 eVoa8JQP0HJIYhN4Nh9PYxpv9xtkKVo5MDn09pbTrS1IRNVW+Rhvd6Z+vkikPSLeqm
	 f5yx6TeEvycxBRY1kUhNwZw0v5dUSlgyUltgpU83IEObSpUa+GAl/sqDlpFDi8nrf6
	 MPvel5awGtXjw0Dxb0JQY6k1JuUfDJVgXpNc+VlWzbvfinSMYGm5UwlRC6xSlGJ4q5
	 eRKtx5S86SaIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guolingxing <guolingxing@tju.edu.cn>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] btrfs: prevent deleting the wrong subvolume by ID
Date: Wed, 11 Nov 2026 19:22:33 -0500
Message-ID: <20261112002205.668605-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202551-failed-5.10-1960146913b3@kernel.org>
References: <20261109202551-failed-5.10-1960146913b3@kernel.org>
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
[ sashal: Replaced btrfs_root_id(dest) with dest->root_key.objectid and adapted error handling to use err and out_dput. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 16c397062809f..9d865ac974923 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3072,6 +3072,17 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
 	inode = d_inode(dentry);
 	dest = BTRFS_I(inode)->root;
+
+	/*
+	 * A concurrent rename may have changed which subvolume the name
+	 * refers to. Verify that the resolved ID still matches the requested ID.
+	 */
+	if (destroy_v2 && (vol_args2->flags & BTRFS_SUBVOL_SPEC_BY_ID) &&
+	    dest->root_key.objectid != vol_args2->subvolid) {
+		err = -EAGAIN;
+		goto out_dput;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		/*
 		 * Regular user.  Only allow this with a special mount
-- 
2.53.0

