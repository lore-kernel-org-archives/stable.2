Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315036F426;
	Sat,  1 Aug 2026 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785568428; cv=pass; b=Ab0D277LuQ0IK9R845d5sYBZ1fbkmzvB9NfXc918gUZbDlH08vG/6pjuJolyLWOgOgYEF+EN1uXV8wI1FI9CovDPmgnU6D5LEjTKv06tWrru+btxcgE9puresUVz+jhPK/1OG1b934IkF2z/jWmFHAa8/td9ZHXntFXGUXJB+Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785568428; c=relaxed/simple;
	bh=oizwROL4CHKC60FysL967VYh8hqBgJnGvmTxG7Pv2ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sn6+AkHrSBko5UvM/gUArqViL7P3BfFeK4iaTWV6dTQ86wOSNORdKRuqz84eKmnMVNuzCil61q8i74+oQHXz2xvAMhFWgBAlaWCywQTBmQbutB/zAXUNf/wiRRV3TKzAfMa4IuFY7C9SzaE5KL2KZCnasNOXjX8kvfeuPyDcfUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=hG2TByt3; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="hG2TByt3"
ARC-Seal: i=1; a=rsa-sha256; t=1785568405; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=h7axT5jtfCKDHoYtVZtckK6vLTlacVrY3fqcs5pGGHzISRFyR+ohZcsCBlGYUbXm1svcoxqOxIA5pF9D/2wqH5olnNRne1HWo6KNVI1TzyENUOscmmWGtPo7ATRky6j2QbljR2OoOAZlBthP2PwVoV9PB4MlVORAZuuYdN6tbVk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785568405; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VFcBWjC5ahhLk/neaSsNkFwzuJ7YbdmtTkJ6fhx0ABw=; 
	b=Vh2Uwd7HrABO/Yf2e0PE7E6Qxc7fXoKKHajsHyTcGyY6NW502Dm41MMpNqK7cAtLRRzwx5oIRWolbzoq0X17aCj8cfzX6OcGIdPY9x3nOwwz0jpAvlUDOiEnjozyNh84LJdxbWlyj6sQyiEEgfv3c6x4UGYOJM4ZDpAtspWCrME=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785568405;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VFcBWjC5ahhLk/neaSsNkFwzuJ7YbdmtTkJ6fhx0ABw=;
	b=hG2TByt302FLPD9hkvrc+reFFieid3MDtXVW3r62oKsz5Ev80mssq8oIf2iHxh9s
	I6uSLfbBwapMY6Vd23DaUJs55MrsQV5+bzW6sYCFdUg1qR41HQQW9S9VKtRfX3dH5CC
	cR4v7UPBNFllRYMIyVAB5NC4eBKf0ce4LRLZmcVc=
Received: by mx.zoho.eu with SMTPS id 1785568403940788.5619489921191;
	Sat, 1 Aug 2026 09:13:23 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ufs: create the root dentry after loading cylinder metadata
Date: Sat,  1 Aug 2026 10:12:57 +0300
Message-ID: <20260801071306.59484-2-ali@iusegentoo.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801071306.59484-1-ali@iusegentoo.com>
References: <20260801071306.59484-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ufs_fill_super() installed sb->s_root before it loaded the cylinder
group structures for a writable mount:

	sb->s_root = d_make_root(inode);
	...
	if (!sb_rdonly(sb))
		if (!ufs_read_cylinder_structures(sb))
			goto failed;

When ufs_read_cylinder_structures() failed, the error path freed the
in-core superblock information and set sb->s_fs_info to NULL while
sb->s_root stayed installed. get_tree_bdev() then reached
deactivate_locked_super(), and because s_root was present,
generic_shutdown_super() called sync_filesystem() and the put_super
operation. Both dereference UFS_SB(sb), which is now NULL, so a mount
that fails only while reading the cylinder groups oopses during
teardown. A crafted image whose first cylinder group cannot be read
reaches this path.

Load the cylinder group metadata first and create the root dentry last,
so the superblock is published to the VFS only once it is fully set up.
ufs_setup_cstotal() and ufs_read_cylinder_structures() take only the
super_block and do not use the root inode, so the reordering is safe.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/super.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index c4831a8b9..7deecb395 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1199,6 +1199,15 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_maxbytes = ufs_max_bytes(sb);
 	sb->s_max_links = UFS_LINK_MAX;
 
+	ufs_setup_cstotal(sb);
+	/*
+	 * Read cylinder group structures
+	 */
+	if (!sb_rdonly(sb))
+		if (!ufs_read_cylinder_structures(sb))
+			goto failed;
+
+	/* create the root dentry last, once UFS_SB(sb) is fully set up */
 	inode = ufs_iget(sb, UFS_ROOTINO);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
@@ -1210,14 +1219,6 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto failed;
 	}
 
-	ufs_setup_cstotal(sb);
-	/*
-	 * Read cylinder group structures
-	 */
-	if (!sb_rdonly(sb))
-		if (!ufs_read_cylinder_structures(sb))
-			goto failed;
-
 	UFSD("EXIT\n");
 	return 0;
 
-- 
2.54.0

