Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282517;
	b=VwRLYmuoNP7va/hyFZc6KOEkI0X5cemMfMpvymP1Gn5imAkh49Nvq8pjsk2BT4fwuo96
	 ehLmBzVPTIMgPZsEbF/UlZm6HU5QoHmU8shstV6m4tKh1qY4J8+PgCbRUVu+7Z0czMsvM
	 2bIwBs60sx/UVEGtYDq31sGbs9zWqevlcnwfStW0YLCavlovPeLfyzq8T3XqCqEETEMkl
	 sqYgtyBHsvFQjSPOPsSlV4AgYN4DH+X/UNrsADdu20ueZDBXOJvBaiL/siWWZeFcQm/4P
	 fou4HoCPJbDpuT4tavl8AOCIqLv2un3B1cEFyQAOWe/2uE0simbm6h16Ei2LMXBByrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282517;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gjAAU9dHzCL4VCLRvbtNKsugn+WVRmkwHLbXmwPXWw8=;
	b=jD/RxJy82yyfOnLDFGT424G2A0qRwDN/o6Pb0/5Kz56qNNal/0AuWFC0X4I7oozuE5LR
	 bSPUtG4nqnxSFhZn7nqAAtu16eHkfZ8O9QOciFX0saReK9pibMYQxgMHt16j6Be2gL+Nk
	 gI+0LWQd3byOTVc/nGJtPH9uh7oyzUjS9HCAfCvE5T2bnupeD20dJ6O4SOodlEN8bDnYh
	 uxOmT9nCtBHZBCw97SknmNPkgZNB9iL/EOykrUWYCf3tELh0A3+lk1duSYlWByIe1dpIh
	 nhZGEbzdiLMV0gez2xbrKdAQmFCd0pk8vybcTRbd+BKvU1wIqPsgEuUdOMPSJfmdFOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwampCu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D9606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwampCu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2CF1F008A1;
	Tue, 10 Nov 2026 03:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282516;
	bh=gjAAU9dHzCL4VCLRvbtNKsugn+WVRmkwHLbXmwPXWw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RwampCu6r9XQ8M/ttWrF+oM4wP1w4D5v/tuzsz4pgdVrEldkbu0ZfUOnvIw9QRxfT
	 a/Kt8Xiegb2l0a1gC1xzPx8IpWORf+xeA0iT1ENf17ZjGsXau4wLMkFbw7cIjAvyII
	 6c9M6UbU9cRThBuGBnkiIKhLCTnjpiObvcD5zjdpDRD/fMOz4EjbieRB+8/aQuBK9T
	 T/8CoOtXh8tYGnD8msMC+nrTUN1N+cNepTchakB8TP8NWgd2/PrNrQ5XVtMVsk7nnm
	 gff2QNxcyJmkKOS6M6Euh5lJc/i6tK7R5+12HuUqD5HwtHXYJMI/LbtligRlxAea7x
	 msKhSR8WwQ/SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Daehyeon Ko <4ncienth@gmail.com>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fs: make sure to call fsnotify_inoderemove() only once when inode is dead
Date: Mon,  9 Nov 2026 22:48:34 -0500
Message-ID: <20261110034813.276743-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055741-failed-5.15-669bb5af15d4@kernel.org>
References: <20261107055741-failed-5.15-669bb5af15d4@kernel.org>
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
[ sashal: inlined inode-death checks to fit the existing __d_instantiate_anon() alias-creation flow ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7d75ff9d507d2..f2365d269eeb6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -365,14 +365,16 @@ static void dentry_unlink_inode(struct dentry * dentry)
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
@@ -2070,7 +2072,10 @@ static struct dentry *__d_instantiate_anon(struct dentry *dentry,
 
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
@@ -2117,7 +2122,12 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
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

