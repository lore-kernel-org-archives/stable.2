Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88C40862A
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923900; cv=none; b=KCDq07IRfuRkw98NZ0LuI99gjfOD0XAJNt6chlmRIO8bHd+abKjKJ+Tl9fEzzjbM88l7mI2QHMHgDJGqr2heF6tFahYRggrliUhqPZWpSY1ZQA+9Z5WYW4NY+T5sufM+utu+iB0oaLzXsNKzStfoP8Jxf6gE+NBVLdJMZX+xTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923900; c=relaxed/simple;
	bh=RqnKsp2crqS/JxveShtMeRpJy//g/Matq1g1zJf42Iw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rfBMirNqvL7WaIAmypTMNMCA3kZK7UXUxE0+avF+oirL8rrcfPJILagZpdS0gJne3A0G/SbJULymyjdBOwPznzIPyeIGQd+G2oFEPm7tCHrioWlGifIhKWPTQh7cF/pvXO+7BBUXUQtTa0QKBy4ktbWOPm3cn5WyO+lv0wKrDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=INym2M5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="INym2M5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB381F00A3A;
	Wed,  5 Aug 2026 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923898;
	bh=TFpbL42quCsO4JAG7nUxr87QP0cgXDr5BJlyPM2EInE=;
	h=Subject:To:Cc:From:Date;
	b=INym2M5O0GJ9mvp779KrKwDy3+6yF+fbmcFK9lwKF0nshw8zEsE2Lg4tYRAWUwXK0
	 fCg9aKINDNWCX8nqm/PDqrigNkkpZaxzAbMY2MSyn+LJ7yFq2BhPAN5JMq4GH5rwZc
	 w/OLv7ve4FsKp86CZTilX459mNYFO+qJy99aBris=
Subject: FAILED: patch "[PATCH] binfmt_misc: restore write access when removing an entry" failed to apply to 6.1-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:54:12 +0200
Message-ID: <2026080512-populace-barterer-83d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x db1856ea9196cf6e015d12199a34c0b9313c7bfa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080512-populace-barterer-83d7@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db1856ea9196cf6e015d12199a34c0b9313c7bfa Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:02 +0200
Subject: [PATCH] binfmt_misc: restore write access when removing an entry

Registering an entry with the MISC_FMT_OPEN_FILE flag opens the
interpreter via open_exec() which denies write access to it for as
long as the entry exists. Removing the entry closes the interpreter
file via filp_close() but never restores write access, leaving the
inode's i_writecount permanently negative. Opening the interpreter
for writing keeps failing with ETXTBSY long after the entry is gone
until the inode is evicted from the inode cache.

Commit 90f601b497d7 ("binfmt_misc: restore write access before
closing files opened by open_exec()") fixed the same imbalance in the
error path of bm_register_write() but the actual removal path has
been leaking the write denial since the introduction of the flag.

Restore write access in put_binfmt_handler() before closing the
interpreter file.

Link: https://patch.msgid.link/20260710-work-binfmt_misc-locking-v3-1-a162f7cb58d6@kernel.org
Fixes: 948b701a607f ("binfmt_misc: add persistent opened binary handler for containers")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 47aeb2b68d3e..adab06d18550 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -162,8 +162,10 @@ static Node *get_binfmt_handler(struct binfmt_misc *misc,
 static void put_binfmt_handler(Node *e)
 {
 	if (refcount_dec_and_test(&e->users)) {
-		if (e->flags & MISC_FMT_OPEN_FILE)
+		if (e->flags & MISC_FMT_OPEN_FILE) {
+			exe_file_allow_write_access(e->interp_file);
 			filp_close(e->interp_file, NULL);
+		}
 		kfree(e);
 	}
 }

