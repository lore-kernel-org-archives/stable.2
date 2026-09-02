Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602372853F3;
	Wed,  2 Sep 2026 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367800; cv=none; b=MSCzmxtqwDwfr/qNXMk8gYXJcGWD48PEO7erxt3XoML5J1dATeKJKDKuCiKkK2ue85rOcPqQoprIfju04flP+zw3KXg7GiIA9X2jCYSh/EMbJWGmKAJFLvjoqTPjevrXOHrOzwkZA71Z9+2tRIRF56l7cPo8/hr9VEWxjZF4fYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367800; c=relaxed/simple;
	bh=wJBzsw3njtfKyozBHXD6yBTsdjfZu4B9ASv8GWT65aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmZv8q9N/jtwpAy4mxxrRBqjVJrEaHDrA1ocBIAFuDjerquG1Zicfoe4A7pKoSmHCLVA/pVGJYTB6tIdycqW2FECeJJN07ZfwdRl9lM6ShwwfOnCFBaOtWaEO7GpjneXeTlI8CSdpHiGMs3A6rErKNPm2dpXT/oWHVbbhB84HjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zwICWCRm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XR0GeJxC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jKcclGBJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sKa6FBtQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zwICWCRm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XR0GeJxC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jKcclGBJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sKa6FBtQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23B231F7EE;
	Wed,  2 Sep 2026 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788367793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=043Dznb5/54VjhDAtyAXUUrtIFC9ClhD/46sskUEV1w=;
	b=zwICWCRm6gviOSKA/JcOY9GjHNm3BR0riMKLaS6yYx/RsxykRuIrg9bmRHPgqXSh1BIQaH
	+ZGFlt83CG+4lZ7bwaEOOquUQ1R46S5BkioDls7cBH63MAnBWJiacD6QOPZCh0FOPlV+0R
	2xR1iHAhxTWVhl6ksLapLXbt2aYDrZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788367793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=043Dznb5/54VjhDAtyAXUUrtIFC9ClhD/46sskUEV1w=;
	b=XR0GeJxCXrFtVWK+3A0JF4hLt3KQVhj7DZBPUxEkEYdEX+tkt8SbB4vtnmQkbtPxMbGzJ4
	N5+/0cIaCL69s0Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jKcclGBJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sKa6FBtQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788367789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=043Dznb5/54VjhDAtyAXUUrtIFC9ClhD/46sskUEV1w=;
	b=jKcclGBJjgibpHeM9Jg0TQso/HUi9gaEyKijnEgeZezmzdh9KG1n7yVBdQHEziU9LcrJAw
	+Drl7J4whHHvNIzI0H/8l6IMifnClA9sUuvU+ZK0wI2108qNhU2AZEb71sApyoiy1+oypf
	eycrzYMVwqulUhcCwf1N++03yuxc4oU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788367789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=043Dznb5/54VjhDAtyAXUUrtIFC9ClhD/46sskUEV1w=;
	b=sKa6FBtQj4Yc/C/BhYnDVF5DJEE0p7AYZGt7EGl2BRn4C55SIzCzYSFAjCjdncYAjyiBLB
	OZz4f1+/OFtstuCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5300136E6;
	Wed,  2 Sep 2026 16:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wHCkM6xTmGpKJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Sep 2026 16:49:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 654B8A13B5; Wed, 02 Sep 2026 18:49:40 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
	<linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Daehyeon Ko <4ncienth@gmail.com>,
	stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: make sure to call fsnotify_inoderemove() only once when inode is dead
Date: Wed,  2 Sep 2026 18:49:25 +0200
Message-ID: <20260902164924.1333135-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3505; i=jack@suse.cz; h=from:subject; bh=eUP3BeSPlxIgWlw//z/nYw8C25sF26bXB1q9ZjbMqww=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqmFOUYfIkAPf9NCB+93BCGuoqKZixBJOcNXBAT kSQD5NZ5K2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaphTlAAKCRCcnaoHP2RA 2aSZCADqlyjXNLG0crOMd35Rk5xEYwJvWnulTbRdd4hNZPzuAsHgrLalY4zM36CUE94WV4BSWN7 77rRgzUeYM5EwflNqKYh+ajRiod0QuXuCMQ4X/Vmz/S9aExBWdKxOaH0qdGhqSPMOZ9wndfssVn FI27GdcoB+JjQ5BKBW3DSb8S5X1cL3QUZrZtlkUTtYzdolE6AdYYPUfN6kgEIFz+mrRISVsJu9P 9IlxFJZlaFdk5hXS1CJswXTTP2YwmQRKLmS68rs5i+rIZN2DTzPyqKeKEfWKCoJ4ryZvfyeDGZ/ Y/Qe8o3k7iWYbbjLmgn/cAPi2MW+HrI1x4IWel1bes9KFQ/o
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 23B231F7EE
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[ZenIV.linux.org.uk,vger.kernel.org,gmail.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -3.01

From: Amir Goldstein <amir73il@gmail.com>

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
---
 fs/dcache.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da6..8f17db2724b3 100644
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
2.51.0

