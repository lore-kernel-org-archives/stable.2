Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428359;
	b=mFvsM6LOw3rSv3i1T+zcXZvn5f8F6XT8BOquDs5JDjj4B+DszmlSpHgCBgVfhwvomoZG
	 7Gip00zy46+7BTAtJaeroYiXDuWD9AI/beO0T+8s4PSlzX98O4gpMsIfOUjSrarBR6+Fr
	 qM07teufz/cUHHDLgMUNizjdC6zOSLokb7DnVA3EL/HM3PcYDLX94k8HdiRD4xluWa4eL
	 7otGXxQ3W+2DTDBPaaR3i6/J8fIV/Rjjoo8FIhEbzrF5qFxF8AZkLczURall9x/2+IOiM
	 bVOfNPfTHIq9lhA7qiPI/Kf22hkwccWcLbalCCO+neHFvQotcpbhTAdtrAXAgx6oErg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428359;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MnULtRKQZcE1HvWaJ1JqZ4TIIeEBkGZYPKYG54U1zJI=;
	b=nrzu5lPE0C20B5Dmtd2owkKoYcsem0ttgDDVOQHDV5y+oWeUyXWOMgab6N+dH9RlOJTR
	 aS/MdB1iFXoNO7xNHW03Tip87x4Skwf2gOdXz8HrMAjBJfN4o1MqagFTxWNbJqYp2TeDF
	 VyO2x610YRe4SdFjrFdSnCqHH90KAk4eTIH+qB9tjU/Cw0WCrwVzeyhB6X0GZCQvvLadH
	 NocHDGqz/ZCfjvh/WwPaS7KrYap+Szpn3EAinZx2BJAK07htssi2zgVI5qxdlgEvXfQJI
	 adbMB/PB/Hgi3sXxvuWsL/ilft9htZC8S2nkHmJiGn0+Q/eYT/FMLrxrsQE24i6BGJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C5M/5Eqs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05C606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5M/5Eqs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726DC1F00A05;
	Wed, 11 Nov 2026 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428359;
	bh=MnULtRKQZcE1HvWaJ1JqZ4TIIeEBkGZYPKYG54U1zJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C5M/5EqsaJmwFyks+KfUxCPqvH9x9zfcEw7wpvP44dwdJJMysXVCToziTnQ4buPKB
	 4uuQUk2TWOvGbZ4is5ZAEHq0pGcl74gQXNBAUyUxn81mIdcQ6n/mHAUYF1nDr3lYKk
	 rCQC7MGht6V+s2QhVrP+6MankGJ1Mg2xSab/ZrRnVeVoGxN6OnZzYyeGoq4PqKX2VR
	 aDUhlPhWPgGzuxRf/dDQ4l8cvIGeWGKGOPkTa3N3anxb00G7clJF9k4i2JlH14zlfW
	 /GhmfAcEANvYbrLybmrcxJlv/mjKmOFg7KOKqZa0Flh3McAHmgy1fXjdkoY0hoYEVZ
	 YU8wlPnFp9iNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guolingxing <guolingxing@tju.edu.cn>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] btrfs: prevent deleting the wrong subvolume by ID
Date: Wed, 11 Nov 2026 15:19:17 -0500
Message-ID: <20261111201853.4048606-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200236-failed-6.18-1960146913b3@kernel.org>
References: <20261109200236-failed-6.18-1960146913b3@kernel.org>
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
[ sashal: Replaced goto out_end_removing with goto out_dput to use the existing cleanup path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9a8902012ae6d..84305ed0dc70e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2413,6 +2413,17 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
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
+		goto out_dput;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		/*
 		 * Regular user.  Only allow this with a special mount
-- 
2.53.0

