Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560361;
	b=mMivoMPKc4hgNBsiR1bPX/vhNiBlvYaUJkhGjz+yLbWwj6AP8pwbIkwHdVDVXFuoHEXT
	 NEHO4fqj0dptITUpfHKROTMLRp8/d4MJo1SXX/IUgrnZUGXxuU+7DBs+7CdMBNJJqTvgV
	 zJhryPwHzJrvn/yr57SZSbhYqdsK6vNbDSAQ2bOdvJ8UU7Cc5nxxuD8QcZItBd9hQ3FIT
	 6Dj/QKGW8u6EruuU8hgXZnKH/cyZ585nzrqniFG89WhPYiPOsDgUVaJF5jLn+Tc/AOHNr
	 jh0u9OW49IfBaftww7xQyRCVhUt3vJ/p+pVf6mmP9scaYNySRnZpLOzTm9WnwtRonHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560361;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NMqcnj4ClRvs99NQVlexxdbDiRdSObTalxzF0DAvXcc=;
	b=pO24dICwLJXlcw01fZOSLG0gVehmDnF68nMEBlnYGbEcW1Z42nX9TueW/tOIVv2GQ3jy
	 bevFy4a81S3s5KFyM5fZC6DxgEGGeQZqlWh8sRRpefL8iDY8zoEMGEed54LfpNm9Trnb4
	 jAG4oEjT5ebp2EqwtKVaE8B84IChoYed+nO5c+DZ+up70MztmsRvATnXOyysEucJTcqvh
	 JKVWVratwPsRH1/KYYTo8eV4hoZ7QDzYttzvm7VQdIkbpCYjPMmPcfT7ZC4bTCJATTJyr
	 BZ6AiusZG4KHnChf3EjYNcSr/vgZEwW9htmJBm8OyX8+T60OOvGmi5FkC4oB7RKPMjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b6H/ZQqd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1179D606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6H/ZQqd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67FB1F000D2;
	Tue, 24 Nov 2026 22:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560360;
	bh=NMqcnj4ClRvs99NQVlexxdbDiRdSObTalxzF0DAvXcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b6H/ZQqduCp+DyiJCSy0huDmG+356UDNu4C+ce8Nl8StBnZkDFrXwtGez1zZctQUg
	 wizPlRwD3Z52X2BzPm4h7yHBUyk9omCzU69A1AFmIfRe+YVVIHejLw4xtekwkJ99oL
	 NvUfrZh9HUw+Ca1rKrZtazQ7bGkxkLjsFEFB9nhULqXnRzGOm71hCnLAShEaMXAOCh
	 DBSVYwIm34HgTGaxOk2FvyeOWdFHaThgBo1dNVun+pFomwHcY3WClY3zAeOiEbMHko
	 gCo48ueYaFnaRY0nYiBy7dUmK2YzQYX0iF8Cx+wjLTD7yax2lidX+7JXlZaijz0CsF
	 /+Bpg4G8zbDEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cheng Yongkang <teel4res@gmail.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] btrfs: reject refs=0 subvolume without DEAD in SUBVOL_SYNC_WAIT
Date: Tue, 24 Nov 2026 17:45:55 -0500
Message-ID: <20261124224517.3116600-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124224517.3116600-1-sashal@kernel.org>
References: <2026112428-spearmint-famished-4675@gregkh>
 <20261124224517.3116600-1-sashal@kernel.org>
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

From: Cheng Yongkang <teel4res@gmail.com>

[ Upstream commit 9a58e56e70f610e29b53821e9c706600e529cca3 ]

btrfs_ioctl_subvol_sync() assumes that a cached root with zero
references has BTRFS_ROOT_SUBVOL_DEAD set, and asserts that before
waiting for the cleaner. Two states break the assumption:

- A corrupt ROOT_ITEM with zero references and a matching orphan item,
  on a writable filesystem.
- A failed subvolume deletion. btrfs_delete_subvolume() zeroes the
  root references, aborts the transaction, which forces the filesystem
  read-only, and then clears DEAD again. No on-disk metadata is
  corrupted in this case.

With CONFIG_BTRFS_ASSERT=y, both reach a BUG().

Change the ASSERT() into a proper rejection to avoid triggering a BUG().

Fixes: 6c83d153ed86 ("btrfs: add new ioctl to wait for cleaned subvolumes")
CC: stable@vger.kernel.org
Suggested-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Link: https://lore.kernel.org/linux-btrfs/dd97efe9-91ec-495b-b698-acff1447421c@gmx.com/
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
[ Rework the commit message, drop the ad-hoc RW check. ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 091d090b650e0..2bf61cf1fd6bb 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5224,8 +5224,12 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
 			return -ENOENT;
 
 		wait_for_deletion = true;
-		ASSERT(root_flags & BTRFS_ROOT_SUBVOL_DEAD, "root_flags=0x%llx",
-		       root_flags);
+		if (unlikely(!(root_flags & BTRFS_ROOT_SUBVOL_DEAD))) {
+			btrfs_err(fs_info,
+				  "subvol %llu has refs 0 without DEAD flag",
+				  args.subvolid);
+			return -EUCLEAN;
+		}
 		sched_ret = schedule_timeout_interruptible(HZ);
 		/* Early wake up or error. */
 		if (sched_ret != 0)
-- 
2.53.0

