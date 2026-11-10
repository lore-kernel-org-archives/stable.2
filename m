Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281368;
	b=GViD9C/k/HtZXcA3lcI3ivRZDCSwSiJtZe1A4nfYAxby/llHSHN5rHgxe6CG8zCrp8/j
	 vaEZt5oT+RDhc5Rk/XSLchbe69inSXk19YLVkL8pnLuI6O+yaa9+j4ulLoWrsbTCf85oJ
	 qSZ9AH+utZwYptZmmiTJAa2iR9YpDOxGMdLPnFlOLgaIvN4EyRf8HlYySzScuPv971UnN
	 5dqPVQIhrhwt1wKZpn7sEytRidhfeRxlsahzPkxjORibsQPeOZqsBZPc2w5dEgso8O6zl
	 0088DJfJM+r8MvBqh3zgtVv0rkoFRnL3V2j2IExhnP3TOx47k7zAanP3Vz7WcvhACFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281368;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7Lpv+peJpeMVyEj3sOEoV+NDqK01BXuCZeYFCARe5N0=;
	b=Q2n+GP/O/QOW1P4rlWsalbK91LsO9euUCbeMjLzMumcvBD+CfMBAaaXB8BYWZ1ZTF0F0
	 W6UsFXCSB5e3FQz3j2FEU9uRq3f2IvDuyDIQTQ+Tptp8tEq9n83Ldbqyb2oKNEhA/m8oj
	 iBaIwCP9J09jMHtYxx/UP/Qp3pXkE9qfPCaqKzAx9VbYwLTts99DF7tQr6fsB//Lkrbg1
	 A+Qu3LiXMvMMKrYvyXHwrtw7zCdkowWbv1jUexDE94mvKicLBZYTgM5TGhciya/5s16FT
	 QSL9S0XiS2VoIOeAWaJM1Vqi9gst0RJ8XxTFq/kbk5TlcBjJwoLt+Y4lfW55h3kfrsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAUciLCV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F9606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAUciLCV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C000F1F0089F;
	Tue, 10 Nov 2026 03:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281367;
	bh=7Lpv+peJpeMVyEj3sOEoV+NDqK01BXuCZeYFCARe5N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MAUciLCVMlamVgYHPCG/NvQ6yzwPpOl5WZ5QpAL8e3ZdbxeEs6OR6D2LHfasVKIH1
	 ZzT5A7W7mdbfvbDq+c6+s5Pd4P7kz0zQiok/YBcET/dLGvOo4Nk1yilsvZpwPJw930
	 l1kHJfnRzVLv5C6rbJgEDZYQKov/LZoYmYYbQyPQ/SNthDfULkUo6kVILEZcpX0i2l
	 XEJycILuvdUV2XxFeeNBvcNaUDCl3XoeLYfDKByLS0uLjojrgOGMaQ2LBIBdyqzcuX
	 CelP1LNNo+lnMYQqXcO1BsNd8+Zv3KLYj69Al1Xk6bJX/+CrqtshXw3SOlOOQR89uJ
	 5Fp7AwGcIX6WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Daehyeon Ko <4ncienth@gmail.com>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fs: make sure to call fsnotify_inoderemove() only once when inode is dead
Date: Mon,  9 Nov 2026 22:29:25 -0500
Message-ID: <20261110032904.180619-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052836-failed-6.6-669bb5af15d4@kernel.org>
References: <20261107052836-failed-6.6-669bb5af15d4@kernel.org>
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
[ sashal: Moved the second inode-dead check into the existing __d_instantiate_anon() helper to accommodate separate alias instantiation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e1f4a9e61e589..2b9546b381f7e 100644
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
@@ -2097,7 +2099,10 @@ static struct dentry *__d_instantiate_anon(struct dentry *dentry,
 
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
@@ -2144,7 +2149,12 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
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

