Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435253;
	b=XSMQFUUxsmQ7XdZrgoBamlbnPbd/RzEZF09Sfwc8jFlHR1xgYweptv4hwTYgI6oEOPJA
	 fctfAHwejIS7VknkrBT29N23/O+XwGWaXdn06Um1hQm30n+I1WqZsUGtD804Aa+BjBYwr
	 SG7xlpiIGEsd9p50cfx+SLGZBxxzz+8QTpzeMVJ35XEPq5CXcoCX5qah4iNPz4mmSdC7K
	 r7jTGsdhlBUoIiW0Jh+UfxM3UgBXRbQnWQu+h5a+7wWy0abUf8WrrEJaOQeSR2xCAe0cl
	 isMZNW+5J/14pTDkILYzQepXVoHoQaVMIIK8lkvQAOGDdsTMN+pLagIpWT1es9suLyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435253;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=brKBWLXKR71sPjxBvUT1F9vkh2CUX1PMRbcAfKhcV2I=;
	b=TdFxqgn3IcCXueu6rTxM6fT5sGR1D1l1fRQwa74e4RW0GNLRM6M8luDGQUGat39i3as9
	 MFy96BAIPxg0jf+ft+W0KadEcIZLoRYhW+pIPNs5wz0RR4A4kpy1UnXCvJz9kUtoNq/S7
	 XvnnOGqY+ma3RkfNkPWEGFzP/PkXmoEIFZurARa6JIWS1xcYw/p96gtnVcvpuIoHib0oX
	 GaB4QP/yLuY30RYy+DI+cn8NeELpgSzygE0sfE439Ecm8KAPVpJ4Hg2MBdOc+wTYoU/ws
	 S9oskxCFtD9FwQqiUUAPGc6rAY0urGrmU2ZivAcblCNqLjobDhNuzNXWjDnqJN7dQoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KoC74Npt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9221E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KoC74Npt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A11F1F00A06;
	Wed, 11 Nov 2026 22:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435253;
	bh=brKBWLXKR71sPjxBvUT1F9vkh2CUX1PMRbcAfKhcV2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KoC74Npt23RCyBuEXNmnOylPj5XS9hKVsU0R1BMxIUM5zvjvQ/KmY/RZud296epAT
	 p9foV1UXWyRvXGL+4wWDVCvSAWlQ0pNnJH8hl4SzCnO9ZUwXpALQh0hkEqJHGznBPF
	 /CFc848IdbiSko1vZxXVET0K5y/sp6Ct0UhtqdSIXkzA1KJC8f0BF5SkeVZgtF6pvE
	 hx5uvWBlFeUzUC7XMLKGnm5ch/ThK7wmMqlQLKl7Ouucf/8IQbaSpqA3jqWTHS9q8M
	 0lL6N+u5Yp/W2AGpA8touVywZ+Cv9Q2yTbbmkzZ/Fq8ifc2HP0wiGpidjozQGaUrTX
	 t22MQ07QuKXRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guolingxing <guolingxing@tju.edu.cn>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] btrfs: prevent deleting the wrong subvolume by ID
Date: Wed, 11 Nov 2026 17:14:11 -0500
Message-ID: <20261111221338.4076497-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201533-failed-6.1-1960146913b3@kernel.org>
References: <20261109201533-failed-6.1-1960146913b3@kernel.org>
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
[ sashal: Adapted the error path to use err instead of ret and out_dput instead of out_end_removing. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 760da6706f4f9..1b0dd3228aa1e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3446,6 +3446,17 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
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

