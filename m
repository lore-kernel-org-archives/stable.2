Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47EE38CFE1
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710231; cv=none; b=dAzyWUGhxk9WSBFckhUtLgvYsTL1s+BmjTnpPhRR+8KjWSC42QOf8lbYiopBenkv0dh/yIUnbitQOw9XgPULAHdULnuuggJQmYowHqMMAVsPtOx4CTEneYUOSa1KjCL+yohz1h5N1NOItqTtrY2OSNmaICi4sHGLPjM8q0tDWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710231; c=relaxed/simple;
	bh=K2am0cL4WbsLKrxDZy26F6QCum0Y0yJn40UMh7b82o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJyKB4AsXBYj3AEGFu4izQ+7+UEhteX2isQsLM6oetPLeRg3ISWQWndkFizqeyT2XaMdngATpwoUEMzf94mMQ/jAuh7G8nPVg33GZgveUk2tuoVWTM4dRsrvRTYBwDgvr7QzIA9hZdkvAdEVVtZuG256RXSp5kNz5wiLI1Fik6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoBQkZWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoBQkZWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F398F1F00A3E;
	Sun,  6 Sep 2026 15:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710226;
	bh=f7buUnzP94VPjXMQOz9Y6ZhHIdtB2EnwfVgncqnOgx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RoBQkZWmexHA0aJuwdoF4tOUGgoO6qiH124QwjHaKyXUZe2sd2P+TdnwyCkgyGkue
	 +a0HFLxrXVVR3DRAgMS1bl1FSAoKtYExiKmELnodPjSK9utxu2YarfZjC8jhefidie
	 ehZnvEj5IKwzQVTLpvqPOUhOADcEi4Oj2ULuFJBEYUoDzpwmLXRKsK6LjEDcr6STns
	 o0qO6vp8eY7by6NsowZSpaH9elPm4sW38FDReLbhHYPZBapQYa8VRIPZOSdlMvu2jA
	 6L+/QUJ2npZThLOBvTnTCyKKz9lrlvswl2fCWn/Q8NMpowEfwz7NfJKi3q6ltVkLJ8
	 D+iG/FceHst7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] btrfs: rename ret to ret2 in btrfs_recover_relocation()
Date: Sun,  6 Sep 2026 11:57:01 -0400
Message-ID: <20260906155703.1520234-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906155703.1520234-1-sashal@kernel.org>
References: <2026090358-pursuit-extruding-d750@gregkh>
 <20260906155703.1520234-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit bd0d9a619a870f8c6745d2b4f57508bc5106e282 ]

A preparatory patch to rename 'err' to 'ret', but ret is already used as an
intermediary return value, so first rename 'ret' to 'ret2'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 6d8ba4572922 ("btrfs: drop recovered reloc root refs on recovery failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 625142d8ede43..9fc7eb7250677 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4181,7 +4181,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	struct extent_buffer *leaf;
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
-	int ret;
+	int ret2;
 	int err = 0;
 
 	path = btrfs_alloc_path();
@@ -4316,9 +4316,9 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	}
 	err = btrfs_commit_transaction(trans);
 out_clean:
-	ret = clean_dirty_subvols(rc);
-	if (ret < 0 && !err)
-		err = ret;
+	ret2 = clean_dirty_subvols(rc);
+	if (ret2 < 0 && !err)
+		err = ret2;
 out_unset:
 	unset_reloc_control(rc);
 	reloc_chunk_end(fs_info);
-- 
2.53.0

