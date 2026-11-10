Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282176;
	b=oi4ubHS/i9FRjJIIdG7B+KZwaaFRGnheZuei12kg/TzabBxpmLmqdu1YeeBd2P4cAQeL
	 tFWlY7JLlpDHSP8doJeFydzyumKeo6nGEmNEc1+F5iFA5ELyhc4aiRssbu4FwuJC78+43
	 ZuGSG3lPxCC9rapHfv5FyCXlTa0VfpJSl6iXlj4zIPQH+WFQl6PDz+ycgllpD2EPL9Q6a
	 5GobT2ETAqVGZUQQT8eze8SZGwXiwmETLN70ji+caVP0WcWxtYf+yxxRYdXxnwu1djl++
	 GJDk4EWrS+K5IcSs2S3Xiic2bd3+YxSqeb6Phv2VqVbPK23A0eKo4qZ5flXCZGkxc1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282176;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7aQKkusDlL3Guonb1fc9edugTVQPDMDcHRnmlWnkSbw=;
	b=CB/wmfJbzndSYF28L0mjerggz8oxYOXHv0AN5eyA6TcRDa9GZwNf+Eg8XaiOSpZz+Ehc
	 NY46ktKnD/59pTC5y+/WawkiEh2rHJipsJzeCXf78cVmujxmhTUV46rryIgYYzWXpHBIn
	 0Y5X5YBwI869YICxp8Gfxzdr/ACT+eqGS67tjrI3jpJBxOj9z/5eh0pBDeGUmLCVX0lMT
	 BhZIaByHRnQtEgRR3ZQIGY3EeajO986YmFqMYa8yXp/2R4hvcL4Ri8JvE9mF+I2yiPnM6
	 4zSm1NRY+7wE9aF2XG4cdBqiueAcEG9Yrn7gJm9g/CMolc/updMrUMAj37jj6JzQtkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3BRfPph;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF49606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3BRfPph
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECD61F0089F;
	Tue, 10 Nov 2026 03:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282176;
	bh=7aQKkusDlL3Guonb1fc9edugTVQPDMDcHRnmlWnkSbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J3BRfPphtnPL3OCbWmnEjMlwaPRm+EFIe7hdQ/6SlTzsiWRQNHz2A/BQIRisDMl6G
	 gti4K7/nDgvw25DopcBb7ctTdw/xy9g+r2RCLCJBju1jyPu9Y1AnU8RTUWnTC2/+W1
	 jbCpwY5sKekl/93s0q1lpDhIZJjmWSqWnkATU121DfDBZ/nSTYh8nSdiduhWfbpNpE
	 ll5eLYBSpDlGo38YnaZp05iXowBE8dp0Hb2jO7ZRl0NJebelki135Ap+XUKxZ+jwEv
	 7usxw7R9glOLZbLQq07ZVjeaFuI+T0FVBN0wQxspaHJFAl+NXqJUk+NGOfvMWCmtyZ
	 QEmOyCent9qYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Daehyeon Ko <4ncienth@gmail.com>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fs: make sure to call fsnotify_inoderemove() only once when inode is dead
Date: Mon,  9 Nov 2026 22:42:54 -0500
Message-ID: <20261110034228.254757-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054107-failed-6.1-669bb5af15d4@kernel.org>
References: <20261107054107-failed-6.1-669bb5af15d4@kernel.org>
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
[ sashal: adapted inode-death checks to the existing alias-creation flow with inline conditions in __d_instantiate_anon() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 205552e31b200..f1baadff1e8b6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -390,14 +390,16 @@ static void dentry_unlink_inode(struct dentry * dentry)
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
@@ -2096,7 +2098,10 @@ static struct dentry *__d_instantiate_anon(struct dentry *dentry,
 
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
@@ -2143,7 +2148,12 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
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

