Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439650;
	b=qAqEjGiCl15SxPPts56jrdvyRm3gMRgQZkBHPgks8p5h85vtynV/qKdCGpq3+t4C1QVC
	 yeOus9cnpj6+K/kt1fpIRTzYce70DLP/Gk2Gkif7ahL/iDYCpRy87t780tnOPMwcO1ZyD
	 K6VbbMXVlpONTf+nWvKzIn7/JUZzzKcY/BSfF7kdek9zpwJ7OJjKpnTmP1u561EcusFIK
	 o8uBaS/FIufBu+3ir8tcG3/zRPv1BLBYeXXJV4uzFobaZQDxTe8QFeisoYTUlQIRHmDsn
	 w2R5AZG5NikJYBa2j1F2bb1PzKEnoMBBOauXQc3HUWW/LlKR+EAjPmzCMkUKqjn8Rnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439650;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2/46sAyBi+dGx8WzW+XB6NO5t0UJGePlj/Abcwp66/U=;
	b=pw/gxjRWBwbf2ptg5NzdzF2MhokE6x8JeeBDNscQyoWQaDNpccLdHOMxtPbAD8d2V+OE
	 DT2reJTySCpSurfL98J6AP0XcJXd2N8y6ZBXYnOKTuTeeIRrMCFixclgT71s39b1XAgEM
	 tlaGl4WqTQv/TGfbOW3D7CwORBndoqPajLBGY+BX1FYbDU7gi75AdZOUJPCTXtx8QR0c1
	 aA6e5k+IJM0q7nRqowyMkZVy/6iNYshoQtJd9FTBH35xtKWMbX3ZmyCR1xUPAes5B57yF
	 z5Ga/ShCSUVFgst2FiVml191tFH5t8Jox7qXQqD/nS42uLU/fv4JRx9X9yE7l8JnX+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3EBef+4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1322860A5BDE
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3EBef+4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AB11F00AC9;
	Wed, 11 Nov 2026 23:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439649;
	bh=2/46sAyBi+dGx8WzW+XB6NO5t0UJGePlj/Abcwp66/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g3EBef+4Vor0BKPZFKRrCcAGVL+AU/xkls3oZDYZYOoHttgGLQKgbhsfrpPUkwniP
	 UEFiMEobn0aw6aMBjTZxbCMDv9CSWx/yYwvzN6ku0Iu0BdoB8LszV3M0Pv7Oy4LZZT
	 xP/D7wm+GM6KsCp1Thci/BKljz/dmyHQO2ee7paeh8cjLMPC8dhtBuDZC079ihP+ac
	 oo5VQi8q0xppADrsmmL3GzLP3Y5EZ3pr2ED+pNQ3yVU34ss3MCxKw/gHjkTFC92fQn
	 iNXl/9b2OP/Su+mbY78WYHmo1YwzE+rcCzma1jNofjXDUTRyYTH6JxrlyyLihvbN7U
	 sXLrUrJy/NF9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guolingxing <guolingxing@tju.edu.cn>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] btrfs: prevent deleting the wrong subvolume by ID
Date: Wed, 11 Nov 2026 18:27:27 -0500
Message-ID: <20261111232700.42050-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202042-failed-5.15-1960146913b3@kernel.org>
References: <20261109202042-failed-5.15-1960146913b3@kernel.org>
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
[ sashal: Adapted error handling to use err instead of ret and out_dput instead of out_end_removing. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d56d6144707bb..a20abb2f5437e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3070,6 +3070,17 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
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

