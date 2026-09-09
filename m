Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9053ED16
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954183; cv=none; b=Qchy4cS+7D6TItx5SeFr3XdpNRUPMIg7aS4M1oUKP7Hio83dhSolSRjrzCJsYJtjan5yNq3CoI3yy2swFT4gRKXzAUQbRgDLeReglIgDxpTaANvjQqG1XA/+c2faxn0SlBLcwjtR8BkAasS6vkVnjJm8y8692Z18YKtkpY9SKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954183; c=relaxed/simple;
	bh=xIv42VjExBjyIMc/l91ks7cNo3Jq+SemX5OlQtCsiss=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OIhSMARB5sZ+Yi/NXnaGAzFqt8XAF2TaH2i46ossOg1Zr7psJFLv8eAzVd3LO6vSPF/2mQRN70Yk/ZwO3vGfyeLsbp6Tf9Eqw7YbM1aPeOp1TpTbPjhoq96hmQO3FPqL9dW8AQTBcZ7usOsRMBpxN8SkpbpApWlr5uPMbExG/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=voD28bca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="voD28bca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F9A1F00A3D;
	Wed,  9 Sep 2026 11:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954182;
	bh=70EKi9kskLhktpt/TTruE6HOU6X+xpyPk2yrqoNEalQ=;
	h=Subject:To:Cc:From:Date;
	b=voD28bcajAbzYTqZv34dereQPikH/1h2Q2ieaIhjSKFMetlkKOZXnx6SLrpNMFsbg
	 G8y50pGPNKbinkk+Jy2onT8d3Vo3E6hoozhgEF8DEJAIARBzQD0LvJH8Euqh3TNPzv
	 4IduNnohUFPPkei3+xzGFtddpzcZY3gqJYadxzgA=
Subject: FAILED: patch "[PATCH] f2fs: limit recovery filename logging to stored length" failed to apply to 6.18-stable tree
To: qwjhust@gmail.com,chao@kernel.org,jaegeuk@kernel.org,qiwenjie@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:25:31 +0200
Message-ID: <2026090931-derby-unsaid-8e7f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 01027b2fcb74dade59fb833b51023f6593b6a9a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090931-derby-unsaid-8e7f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 01027b2fcb74dade59fb833b51023f6593b6a9a2 Mon Sep 17 00:00:00 2001
From: Wenjie Qi <qwjhust@gmail.com>
Date: Tue, 30 Jun 2026 16:23:30 +0800
Subject: [PATCH] f2fs: limit recovery filename logging to stored length

F2FS stores recovery filenames as a length plus a fixed-size i_name
buffer.  The buffer is not NUL-terminated, but recover_inode() and
recover_dentry() print it with %s.

For a 255-byte filename, recovery logging can read past i_name into the
following raw inode fields.

Print the name with a precision bounded by i_namelen and F2FS_NAME_LEN.

Fixes: f356fe0cba0e ("f2fs: add debug msgs in the recovery routine")
Cc: stable@kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 89af8407b667..3fecfdbd5958 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -158,6 +158,22 @@ static int init_recovered_filename(const struct inode *dir,
 	return 0;
 }
 
+static const char *recover_printable_name(struct inode *inode,
+					  struct f2fs_inode *raw,
+					  int *name_len)
+{
+	static const char encrypted_name[] = "<encrypted>";
+
+	if (file_enc_name(inode)) {
+		*name_len = sizeof(encrypted_name) - 1;
+		return encrypted_name;
+	}
+
+	*name_len = min_t(unsigned int, le32_to_cpu(raw->i_namelen),
+			  F2FS_NAME_LEN);
+	return raw->i_name;
+}
+
 static int recover_dentry(struct inode *inode, struct folio *ifolio,
 						struct list_head *dir_list)
 {
@@ -170,7 +186,8 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
 	struct inode *dir, *einode;
 	struct fsync_inode_entry *entry;
 	int err = 0;
-	char *name;
+	const char *name;
+	int name_len;
 
 	entry = get_fsync_inode(dir_list, pino);
 	if (!entry) {
@@ -229,12 +246,9 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
 out_put:
 	f2fs_folio_put(folio, false);
 out:
-	if (file_enc_name(inode))
-		name = "<encrypted>";
-	else
-		name = raw_inode->i_name;
-	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %s, dir = %llu, err = %d",
-		    __func__, ino_of_node(ifolio), name,
+	name = recover_printable_name(inode, raw_inode, &name_len);
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, dir = %llu, err = %d",
+		    __func__, ino_of_node(ifolio), name_len, name,
 		    IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
 }
@@ -282,7 +296,8 @@ static int recover_inode(struct inode *inode, struct folio *folio)
 {
 	struct f2fs_inode *raw = F2FS_INODE(folio);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	char *name;
+	const char *name;
+	int name_len;
 	int err;
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
@@ -331,13 +346,11 @@ static int recover_inode(struct inode *inode, struct folio *folio)
 
 	f2fs_mark_inode_dirty_sync(inode, true);
 
-	if (file_enc_name(inode))
-		name = "<encrypted>";
-	else
-		name = F2FS_INODE(folio)->i_name;
+	name = recover_printable_name(inode, raw, &name_len);
 
-	f2fs_notice(F2FS_I_SB(inode), "recover_inode: ino = %x, name = %s, inline = %x",
-		    ino_of_node(folio), name, raw->i_inline);
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, inline = %x",
+		    __func__, ino_of_node(folio), name_len, name,
+		    raw->i_inline);
 	return 0;
 }
 

