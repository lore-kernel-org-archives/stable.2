Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645BE4D0CE3
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577274; cv=none; b=ndfiY2Rf9qvLb/uej782k7RGB9W3Q7Pioq5IVFhr5nVN6hQ5r2NJfU9wPhpHIPUfgYuEhsHlolN1gyOHTYZFG0b0XfI48k0CZ3a0gK4jybzKLfjwky05fA9+0Sx9teG7FqwEwXWBo7B0R6V1fOHoA8LFhDcpX54EwKwWqDN/6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577274; c=relaxed/simple;
	bh=AIcOk5FYSxAZXVTFK+JloB7/D/St0k06oekZhai7Trg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MViOI3bWyDFZzVloOfSvHeBBUTaAwOevo2TtD/QwHi+2ybEuRd1jHtSI2aF+G0RpoAcRC4GeH8nZPTvvVuw59HqAr3YKV+jmMyM2LHJuoUFDlMupydePRbMamuuDCPPW6UXrsatJ+u06w2k+oQFWMNsBdYGU1E2ct+yzB3mOy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fnfDSkxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fnfDSkxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B751F00893;
	Wed, 16 Sep 2026 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577256;
	bh=XphaQeRdNEp8eSXm363TnXkvGvip5+rHiwAQqhPGQgE=;
	h=Subject:To:Cc:From:Date;
	b=fnfDSkxFjvyxfCx7O6lW8PAYVabu+iHi5VLQxxS3HE3IdaEZ04nYer02nniVk0+XB
	 luB1Q40hVfy8kB5Qgxxrc1ct/U/FwnjOdWykirzul72jeKNf0lbc1D6bwe9gQkhlCY
	 9aiAAoRtgrj3bKFCPleLedIwsH5ShbrS3Efmc7HY=
Subject: FAILED: patch "[PATCH] smb: client: pin DFS superblock in iterator callback" failed to apply to 5.10-stable tree
To: kmehltretter@gmail.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:41:44 +0100
Message-ID: <2026091644-blouse-acre-e296@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d806d5a85dcbe2a0f181b2f0f9f61ddfbefa1818
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091644-blouse-acre-e296@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d806d5a85dcbe2a0f181b2f0f9f61ddfbefa1818 Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Wed, 2 Sep 2026 20:28:14 +0200
Subject: [PATCH] smb: client: pin DFS superblock in iterator callback

tcon_super_cb() stores a raw superblock pointer, but __cifs_get_super()
takes its active reference only after iterate_supers_type() has dropped
s_umount and its passive reference. Concurrent DFS automount expiry can
therefore free the superblock before cifs_sb_active() uses it.

A deterministic KASAN test reproduces the race as:

  BUG: KASAN: slab-use-after-free in cifs_sb_active+0x77/0x80

The same test passes with this change applied.

Take the active reference in the callback while iterate_supers_type()
still holds s_umount shared. cifs_put_tcp_super() remains the matching
release.

Fixes: bacd704a95ad ("cifs: handle prefix paths in reconnect")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 46e1382e8e04..d4db3f91a91f 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -891,8 +891,14 @@ static void tcon_super_cb(struct super_block *sb, void *arg)
 	     t1->ses->dfs_root_ses == t2->ses->dfs_root_ses) &&
 	    t1->ses->server == t2->ses->server &&
 	    t2->origin_fullpath &&
-	    dfs_src_pathname_equal(t2->origin_fullpath, t1->origin_fullpath))
+	    dfs_src_pathname_equal(t2->origin_fullpath, t1->origin_fullpath)) {
+		/*
+		 * Take the active reference while iterate_supers_type() still
+		 * holds s_umount shared.
+		 */
+		cifs_sb_active(sb);
 		sd->sb = sb;
+	}
 	spin_unlock(&t2->tc_lock);
 }
 
@@ -909,15 +915,8 @@ static struct super_block *__cifs_get_super(void (*f)(struct super_block *, void
 
 	for (; *fs_type; fs_type++) {
 		iterate_supers_type(*fs_type, f, &sd);
-		if (sd.sb) {
-			/*
-			 * Grab an active reference in order to prevent automounts (DFS links)
-			 * of expiring and then freeing up our cifs superblock pointer while
-			 * we're doing failover.
-			 */
-			cifs_sb_active(sd.sb);
+		if (sd.sb)
 			return sd.sb;
-		}
 	}
 	pr_warn_once("%s: could not find dfs superblock\n", __func__);
 	return ERR_PTR(-EINVAL);

