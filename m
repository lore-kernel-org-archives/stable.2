Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283284;
	b=XQQ4Tk7BtYdkkVJZe4Cvxhi3cTaxqJ2o6b8CotsQ0EjMmFsSEtaMS0EPMmZLqgw59zhk
	 03P2TJgnxVZhbirhzvH1ikRquMEh2DKmhT5WC2PLQHYZ7VmG8IqtBbVLDreC/z0rE0Rkb
	 yS9AC09/1EKjmmrEupPq/8mHcn7ewqHKSvQriJvuwNl7Arf0PkT43/2QZNTEdyX3Uf101
	 Z66eHlwZU1/yf+TZ3AwZH1jfImgVmjAP/JZ+RDIXvcUejtEVDUeUDzGygzDgKWsldgFps
	 s85iOP//k8v9xZine0gz5Oyqp7StTB5rUN+EB8cfBbOf6h2pWAQdH4kBrUZD0BQnbVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W3XIsJrky+KEthpBoy+ONMsvdBru+g0CyQWdeAW8880=;
	b=egBDLejgvBnzeje+Fe8HO3k+sVN06dDQD+nWOnCdbvtMdYBhgbos3PUBeclaYLfa+zR1
	 CPuIaZ/+dx2+2EmFQ9AcAnR2Yv+F9qhTROqfGgiqGJm1pDmE7Igonq/SCv+uwXDwclsb4
	 I0DTWIzNSiqtqwMBtQI3VrH/AIwDNYwvocl4J/TreaY4zHlnz1PvOBgjA3FNGuygV+8mN
	 FAmn9Fv0OTFZ6wWPCafaQnbdo7r2Nsw6S/JCKvcz+WO/RPnjHO6xH2rH4VDYzXwW2Inzq
	 zzd+KCOXLutKVUs4LPduD9hKUprnt3G7pi37lhRV4/IpEpbG73CNp+4iU/bwQO9D81Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=McImbXGF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A0606CEEE
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=McImbXGF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205D41F008A1;
	Tue, 10 Nov 2026 04:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283283;
	bh=W3XIsJrky+KEthpBoy+ONMsvdBru+g0CyQWdeAW8880=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=McImbXGFX4m0JTA2dDgAGW/DnS82VY18kE3so5R/686WcUZkV88bT8utU6SI4do2D
	 RXVioElK2vdaOOGMj/lRQE52JjfwD2bZQDQoL7q70RmD95GaSa7seGVhv84+WgCIGn
	 WvkH9FXB791DXLkiD2eEwiDyAOK75Uhn2QDrRlwOMbGKM4AnyjigkY4HcAGIM1I4g/
	 hNYVhH9gLqNud2r2d3BlTWiW0AAWnmxbXwsIlQt5K4icOodVyueenO7m3YOMx/qpZI
	 3K6mSA76/VEu+qQuZ+gCYbK0UUFF+uSCyhKJN/JF6WI1cbX5RhF/ykvJPtl6DvxEFB
	 M1Z9CunIaPl6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Daehyeon Ko <4ncienth@gmail.com>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fs: make sure to call fsnotify_inoderemove() only once when inode is dead
Date: Mon,  9 Nov 2026 23:01:21 -0500
Message-ID: <20261110035948.294639-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061440-failed-5.10-669bb5af15d4@kernel.org>
References: <20261107061440-failed-5.10-669bb5af15d4@kernel.org>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 669bb5af15d41a21359d00a441490f87a88eb52a ]

Daehyeon reported a race wherein fsnotify_removeinode() can be called
when inode still has a live alias.  This can lead to several undesired
outcomes such as crashes in fsnotify code or avoidance of inode mark
notifications.

Check that inode is really "dead", meaning no nlink and no more aliases
before calling fsnotify_inoderemove() for final cleanup of inode marks.
Also do not allow open_by_handle() to add new aliases to a "dead" inode.

Ideally, we'd call fsnotify_inoderemove() once last inode reference is
dropped to make things simpler. Alas fsnotify inode marks currently hold
inode references and thus this doesn't work. Once we teach fsnotify to
avoid holding inode references, these games with dead inodes can go as
well.

Reported-and-tested-by: Daehyeon Ko <4ncienth@gmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/20260827045007.3831259-1-4ncienth@gmail.com/
CC: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260902164924.1333135-2-jack@suse.cz
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: adapted alias checks to the existing __d_instantiate_anon() helper using inline conditions instead of inode_notify_dead() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index d17c98508a088..00550fcbe0d68 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -363,14 +363,16 @@ static void dentry_unlink_inode(struct dentry * dentry)
 	__releases(dentry->d_inode->i_lock)
 {
 	struct inode *inode = dentry->d_inode;
+	bool notify_dead;
 
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_clear_type_and_inode(dentry);
 	hlist_del_init(&dentry->d_u.d_alias);
 	raw_write_seqcount_end(&dentry->d_seq);
+	notify_dead = !inode->i_nlink && hlist_empty(&inode->i_dentry);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&inode->i_lock);
-	if (!inode->i_nlink)
+	if (notify_dead)
 		fsnotify_inoderemove(inode);
 	if (dentry->d_op && dentry->d_op->d_iput)
 		dentry->d_op->d_iput(dentry, inode);
@@ -2035,7 +2037,10 @@ static struct dentry *__d_instantiate_anon(struct dentry *dentry,
 
 	security_d_instantiate(dentry, inode);
 	spin_lock(&inode->i_lock);
-	res = __d_find_any_alias(inode);
+	if (!inode->i_nlink && hlist_empty(&inode->i_dentry))
+		res = ERR_PTR(-ESTALE);
+	else
+		res = __d_find_any_alias(inode);
 	if (res) {
 		spin_unlock(&inode->i_lock);
 		dput(dentry);
@@ -2082,7 +2087,12 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	res = d_find_any_alias(inode);
+	spin_lock(&inode->i_lock);
+	if (!inode->i_nlink && hlist_empty(&inode->i_dentry))
+		res = ERR_PTR(-ESTALE);
+	else
+		res = __d_find_any_alias(inode);
+	spin_unlock(&inode->i_lock);
 	if (res)
 		goto out_iput;
 
-- 
2.53.0

