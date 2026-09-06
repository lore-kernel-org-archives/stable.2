Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0430D3FE
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711505; cv=none; b=OeHP94EPZDCTFlei3WlNcM0f8av8t0O6nsXLD57Xch1Ta4RNtJQAqr6c1BrtRcZVDVxU93EAzp+o/SLmUBr6orutuR8/AHxsaGRNKKMl6NPUrRpowuzGBICSkNamwSWshQ27vOpfyiYKVJ8XEwDXq1mMNQ81A0421eVj8PzH0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711505; c=relaxed/simple;
	bh=gUalDxmSI/3Ywu7OzAe4bvt/zh8SRL9z1kk/0GybI1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ig5GmB3JF2F9qR5QzifW1uYSUnkrrn+bfi7f98kKR3qln53FbLIcH6OtREtGDZP7nusRGC3hVKWxTbC5pqFWW7n22pvp8mlal6OXR/P4E/keiiPbvn1dre/MW1Mowc9FOXmrZ0XCQ4npdFIPIg1mIu0woEbs+7dU2DFu/CYLRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVk0Do+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVk0Do+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149CD1F00A3D;
	Sun,  6 Sep 2026 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711504;
	bh=sKCgGSbtyShfHn6nFvkjJg6LMxk0OiStPsbmmV2t+94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HVk0Do+mrEelz/90E9tOMvm0quus8TGKoPdTQOjnLtfYOGn8Jse1hF1dP3AwrAefm
	 Pamdyi9hJF63whNskHJHXJ91BG/E+b49x7BroR2nIKuAaDeZCbTiDJ7TpvA0CfWVFJ
	 r5+SD7fs7gi9hWCbXR66YsMP5e4TZ5ujrAZtcA0apkfzwlsp9jSEIy29tywKcd6yHO
	 dxUFtdZ/SiVkTBiIFLgjfQGXC5qOTlawqul5UbSzWf8UWcKnyvazSDvxpwn5BjPmb0
	 PkA8++aiH1wxKwMXu20hzzDgzNI/jsYj6X9l5l0OI67ufMaMQMp/e59nd0m7yzBZ8E
	 22TkHTrk+JTXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] btrfs: rename ret to ret2 in btrfs_recover_relocation()
Date: Sun,  6 Sep 2026 12:18:19 -0400
Message-ID: <20260906161821.1555270-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906161821.1555270-1-sashal@kernel.org>
References: <2026090359-pebble-underpaid-4ffa@gregkh>
 <20260906161821.1555270-1-sashal@kernel.org>
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
index 8e465849c26c3..7aeb3ece89bc8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4207,7 +4207,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	struct extent_buffer *leaf;
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
-	int ret;
+	int ret2;
 	int err = 0;
 
 	path = btrfs_alloc_path();
@@ -4342,9 +4342,9 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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

