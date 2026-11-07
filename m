Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047318;
	b=LQY7LwwQfN0T0ZpxV9t6g3ir05zjSIn1g8q8yQ+qpJdc5w6ToBLhpgRkaJ+JewHeXJKy
	 6jtEMhjVHrxlstA54Ipj7FPaRZCyE3dd25IhxsB5SjXj7404/6OfzleLatuc75h2/M4lY
	 +wSvXWlIabnqIdiVe9vbPeK4e+mYKFbhn2XP0zw4Gc3J5WAP+UtJhIEvsa7dd07O7Y7oZ
	 F6MhoLKlZXKH5/FpRZteqpIjVCL9REGe3af32QpE3HORhULj4MUEGY9ackTJ2TI5dY3Vj
	 WWNlz9Pd8dZNeyKwe0NMYN5MedMfQaRL55FXBH1CJKJNRXk5ZnO3SFl47E/5HiREH7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047318;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bdZ2CJKfL/Z8EYQjHtwaHLvDzf5kXlPltae7EZBFOcU=;
	b=KspPVtUovhM8ap+rRofW70VA6oakWdCh7uEgR0Ys1S+KTjcj/Cu4B6fSf93ADl+MdfOr
	 7j6XdK3pFus39j5/fYbChqXtKljsWs+23HGqu9uW5+9gABRLrHQT8gZSwOR1RiC1P4nZu
	 kOFivF1UUiqeVDp9t0Rtjj0XzyY3UXkiM2JpCUf8QZmS1HyiLd41uhlNl6D0lLMmVbFQn
	 5H254WXSaRSEaV4uI6wrLECuFF0PNW0LIHEyLoBIY8qZdG5EScPT3KC1Ps5BSRIYkeG/8
	 W5WbWUpA986Hlw4PRH6TadSsiX6paw+rjarX1k89hHlomD39SMPeyMQdHNYYPw5Zqqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WnVwEjv/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7965C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnVwEjv/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88AC1F0089F;
	Sat,  7 Nov 2026 10:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047318;
	bh=bdZ2CJKfL/Z8EYQjHtwaHLvDzf5kXlPltae7EZBFOcU=;
	h=From:To:Cc:Subject:Date;
	b=WnVwEjv/4OXY0L91slUYfT2mA8+71QgxdJ7WINGX7fPlPnvj15LJ17h5Lw1sGYjVc
	 0nXhD3RSpWNKGyBvct4G4uxExj8qG5GkSWDed90obs/n2HdLUgEMmsBC4Kj9OCqFWt
	 TXizIrT+RoVIPaKHCOvjDoOC4atTRUxPJVeijcyoOa04gwxTqOkkn1KGmGoqCeNPXl
	 y+Sg6qA+e0j+d1nUX1uMyWQeVAJ//zZu2DhxUfAJFWENAQRWMA4ZEbzKsebX8Eat3S
	 GmmCQd+MQNbhO8706iBrJaARsNpvwJYwngpIJOf2kbDRhGC2FK1Y93JlcnNS065FDY
	 E6pZpI+mDzTjw==
From: Sasha Levin <sashal@kernel.org>
To: amir73il@gmail.com,
	4ncienth@gmail.com,
	jack@suse.cz,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs: make sure to call fsnotify_inoderemove() only once when inode is dead" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:36 -0500
Message-ID: <20261107052836-failed-6.6-669bb5af15d4@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 669bb5af15d41a21359d00a441490f87a88eb52a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052836-failed-6.6-669bb5af15d4@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 669bb5af15d41a21359d00a441490f87a88eb52a Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Sep 2026 18:49:25 +0200
Subject: [PATCH] fs: make sure to call fsnotify_inoderemove() only once when
 inode is dead

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
---
 fs/dcache.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da67..8f17db2724b38 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -450,6 +450,17 @@ static void dentry_free(struct dentry *dentry)
 		call_rcu(&dentry->d_rcu, __d_free);
 }
 
+/*
+ * If inode is unlinked and doesn't have any aliases (i.e., all fds pointing to
+ * it are closed), it is pretty much dead. Except that file handle lookup could
+ * still revive it which causes issues to fsnotify. So once inode reaches this
+ * state we make sure to block creating any new aliases.
+ */
+static bool inode_notify_dead(struct inode *inode)
+{
+	return !inode->i_nlink && hlist_empty(&inode->i_dentry);
+}
+
 /*
  * Release the dentry's inode, using the filesystem
  * d_iput() operation if defined.
@@ -459,6 +470,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
 	__releases(dentry->d_inode->i_lock)
 {
 	struct inode *inode = dentry->d_inode;
+	bool notify_dead;
 
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_clear_type_and_inode(dentry);
@@ -469,9 +481,10 @@ static void dentry_unlink_inode(struct dentry * dentry)
 	 */
 	dentry->waiters = NULL;
 	raw_write_seqcount_end(&dentry->d_seq);
+	notify_dead = inode_notify_dead(inode);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&inode->i_lock);
-	if (!inode->i_nlink)
+	if (notify_dead)
 		fsnotify_inoderemove(inode);
 	if (dentry->d_op && dentry->d_op->d_iput)
 		dentry->d_op->d_iput(dentry, inode);
@@ -2237,7 +2250,12 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 
 	sb = inode->i_sb;
 
-	res = d_find_any_alias(inode); /* existing alias? */
+	spin_lock(&inode->i_lock);
+	if (!inode_notify_dead(inode))
+		res = __d_find_any_alias(inode);	/* existing alias? */
+	else
+		res = ERR_PTR(-ESTALE);
+	spin_unlock(&inode->i_lock);
 	if (res)
 		goto out;
 
@@ -2249,7 +2267,10 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 
 	security_d_instantiate(new, inode);
 	spin_lock(&inode->i_lock);
-	res = __d_find_any_alias(inode); /* recheck under lock */
+	if (!inode_notify_dead(inode))
+		res = __d_find_any_alias(inode);	/* recheck under lock */
+	else
+		res = ERR_PTR(-ESTALE);
 	if (likely(!res)) { /* still no alias, attach a disconnected dentry */
 		unsigned add_flags = d_flags_for_inode(inode);
 
-- 
2.53.0




