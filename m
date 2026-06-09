Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212BF39EF01
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781038690; cv=none; b=KlXprSOy4CiBSoq5DmCNjh+cJOtjDxUnruSBv3GQwlSfxKU/UcWmAFnHKdn89w/agQXgnKOtbUz6CIOy9tfaPiV0aAS5XfHdTBcB5zVNp3ZGC0ZCMnl0pqNU1K6XHd7irJw9q/28KhyFMOEAVaBmmtgsitB7iVtABxTCA1kKUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781038690; c=relaxed/simple;
	bh=UrFWH3+Jj0iu3sM6NcI47XG3l5xEFECwvcwGZZSofM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f03lxgbf4duSYjta3K+Z/S86jBp2amO+gHaDw0oOF2NgyQIV0+8x31GRP5d4PGVtRUWrW5No97KOZ/0KxNNnImWY2e2b67ZzUnW9pDj1BdJyedJS5sugF/BQ7NQZuwUXXoUQ2BJgDtBldbXQEomwJKu6U/BXFBtaZsmPympG/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=PLQ/BALV; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="PLQ/BALV"
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 1D0301C0F3F
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 23:57:56 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1781038666; x=
	1781902667; bh=UrFWH3+Jj0iu3sM6NcI47XG3l5xEFECwvcwGZZSofM0=; b=P
	LQ/BALVgNujTLZFL37l/dDEGgZ4QssJa5dg7ltfSryU9+AX5eo9C66yTd3/hPVnT
	DKK95dOg4UXMGMbU3LNbH/a8zotzJefF3/nOTwy1omz7ugyRW3f9uE+l26zskqmA
	aGwRHYKAJ0Katwo3uXd7xI637he94iB6bhIE/AjbqM=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bw8YlOPPnnyq for <stable@vger.kernel.org>;
	Tue,  9 Jun 2026 23:57:46 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id EB43A1C0E63;
	Tue,  9 Jun 2026 23:57:44 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+7efd59a5a532c57037e6@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: lock glock before dumping consistency errors
Date: Tue,  9 Jun 2026 20:56:50 +0000
Message-ID: <20260609205733.840893-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_dump_glock() walks the glock holder list and dump_holder()
dereferences holder fields, including the owner pid. The holder list is
protected by gl->gl_lockref.lock, but the consistency error paths call
gfs2_dump_glock() without taking that lock.

This can race with holder removal or reinitialization and make
dump_holder() operate on a stale holder.

  Thread 1                         Thread 2
  --------                         --------
  gfs2_consist_inode_i()
    gfs2_dump_glock()
      gh = first holder
                                   gfs2_glock_dq_uninit(gh)
                                     gfs2_glock_dq(gh)
                                       spin_lock(&gl->gl_lockref.lock)
                                       list_del_init(&gh->gh_list)
                                       spin_unlock(&gl->gl_lockref.lock)
                                     gfs2_holder_uninit(gh)
                                       put_pid(gh->gh_owner_pid)
                                       gfs2_holder_mark_uninitialized(gh)
      dump_holder(gh)
        pid_is_meaningful(gh)
        pid_nr(gh->gh_owner_pid)

Depending on where the stale holder is dereferenced, this can show up as
a fault in pid_is_meaningful() or as a KASAN report in pid_nr().

Reuse the existing locked glock dump wrapper for the consistency dumps.

Reported-by: syzbot+7efd59a5a532c57037e6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
Fixes: a739765cd8e6 ("gfs2: dump glocks from gfs2_consist_OBJ_i")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 fs/gfs2/glock.c | 6 +++---
 fs/gfs2/glock.h | 2 ++
 fs/gfs2/util.c  | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b8a144d3a73b..548ce5f8866f 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2100,7 +2100,7 @@ void gfs2_glock_thaw(struct gfs2_sbd *sdp)
 	glock_hash_walk(thaw_glock, sdp);
 }
 
-static void dump_glock(struct seq_file *seq, struct gfs2_glock *gl, bool fsid)
+void gfs2_dump_glock_locked(struct seq_file *seq, struct gfs2_glock *gl, bool fsid)
 {
 	spin_lock(&gl->gl_lockref.lock);
 	gfs2_dump_glock(seq, gl, fsid);
@@ -2109,7 +2109,7 @@ static void dump_glock(struct seq_file *seq, struct gfs2_glock *gl, bool fsid)
 
 static void dump_glock_func(struct gfs2_glock *gl)
 {
-	dump_glock(NULL, gl, true);
+	gfs2_dump_glock_locked(NULL, gl, true);
 }
 
 static void withdraw_glock(struct gfs2_glock *gl)
@@ -2537,7 +2537,7 @@ static void gfs2_glock_seq_stop(struct seq_file *seq, void *iter_ptr)
 
 static int gfs2_glock_seq_show(struct seq_file *seq, void *iter_ptr)
 {
-	dump_glock(seq, iter_ptr, false);
+	gfs2_dump_glock_locked(seq, iter_ptr, false);
 	return 0;
 }
 
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 6341ac9b863f..f58c532d193a 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -217,6 +217,8 @@ int gfs2_glock_nq_m(unsigned int num_gh, struct gfs2_holder *ghs);
 void gfs2_glock_dq_m(unsigned int num_gh, struct gfs2_holder *ghs);
 void gfs2_dump_glock(struct seq_file *seq, struct gfs2_glock *gl,
 			    bool fsid);
+void gfs2_dump_glock_locked(struct seq_file *seq, struct gfs2_glock *gl,
+			    bool fsid);
 #define GLOCK_BUG_ON(gl,x) do { if (unlikely(x)) {		\
 			gfs2_dump_glock(NULL, gl, true);	\
 			BUG(); } } while(0)
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 83b8bb6446e5..3417d1553b13 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -342,7 +342,7 @@ void gfs2_consist_inode_i(struct gfs2_inode *ip,
 		(unsigned long long)ip->i_no_formal_ino,
 		(unsigned long long)ip->i_no_addr,
 		function, file, line);
-	gfs2_dump_glock(NULL, ip->i_gl, 1);
+	gfs2_dump_glock_locked(NULL, ip->i_gl, true);
 	gfs2_withdraw(sdp);
 }
 
@@ -364,7 +364,7 @@ void gfs2_consist_rgrpd_i(struct gfs2_rgrpd *rgd,
 		"function = %s, file = %s, line = %u\n",
 		(unsigned long long)rgd->rd_addr,
 		function, file, line);
-	gfs2_dump_glock(NULL, rgd->rd_gl, 1);
+	gfs2_dump_glock_locked(NULL, rgd->rd_gl, true);
 	gfs2_withdraw(sdp);
 }
 
-- 
2.43.0

