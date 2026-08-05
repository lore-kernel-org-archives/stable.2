Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3673FF8A3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923897; cv=none; b=sozkz38666KtO2bgpPEQllP/nSqGT1Ejs9Bf3C1lLc5h0VJHQt7FI7N3dpA6UOy+3NGuxdWGGOyiMcwnOdQp6OeUB6bdgUdz4cT+qFZhG0NfDPvf75+39UjBGYkis6NNpaTulgS9V8c1tvdXuZMVYLMohw4FEGn8vamwiq/tTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923897; c=relaxed/simple;
	bh=vW2D6v4OKipRy4KdT10WRoxSX3WO43/9asUz3Gm/NmY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DKyJxebzFHIG91SQQ9it9s24w4Vuj0uFj/hRDi1sKuryv6seDKZVVO7KAhRpnBwMkH4y4MaPZGCZVegScmlPjrs54/ku0Z3wv1bvV6PnoSjvCpPn+nuRNsOa90iCxu8jiOMY+iwm7EsRqaLGQ9WxyXiHglcQRpEZMgWrPx+WzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ysvv78Jn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ysvv78Jn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501FE1F000E9;
	Wed,  5 Aug 2026 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923895;
	bh=62PxHRuy0ExQzyfl6IZ6JF9YvZXAE9T9avOJEXyEEW4=;
	h=Subject:To:Cc:From:Date;
	b=ysvv78JndZ4Gw6y81FyT9ODgBdB7lPP4RoK/Oe5nL5piRN+T1ZsNgRuRCMoPwm3PT
	 3CSwJeKsRS09bg40MEWpjGNHttVAGzKiIc3AS5pFO97LjVrPXTmC94drW0rqLNdvzX
	 OcUoRjvdHesU6jJWdsTL7ffUpghqMd8BYzKFrSKE=
Subject: FAILED: patch "[PATCH] binfmt_misc: restore write access when removing an entry" failed to apply to 5.15-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:54:12 +0200
Message-ID: <2026080512-motto-postwar-7c00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x db1856ea9196cf6e015d12199a34c0b9313c7bfa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080512-motto-postwar-7c00@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

