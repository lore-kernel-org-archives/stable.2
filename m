Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606127;
	b=1qvhb/3CPsOzNNuOc1npJpjCghkt1BEke3Ke6Cagpeqc7MdjbfSryQxw/4Bz4bRrwmQv
	 aTMhG0ntEusPiGKg9q7kX6VJ5HQkuOQMEMD+w3IWgdaIi3n4GEjTdjQg+ZDiuh3rBDv/z
	 7aRm5IhyKAN4vQqj3XKX3Fsd6FwJhTQGXuiwhwUgMswPMHj4++LJF5mGO5DhvIOIGWHT2
	 qUqWxhklrElmURAjIBlOjpBmiRDXtW/hV3/U1vjM9v+c1Fjp2R/sTQ6cbmUI9k5dNhwH7
	 rm/r8QOWELvILIWfpexaEWT5dedgs99ZzGRQrPQkPeEHJ5dLehp0mePMyWWMNUNq72Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606127;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5jxHGNSNLI009oSmxsp7IhysxwXODbieSJtrsSJ9ISY=;
	b=WvrCDEDMQFKjcL5hHhK2pCEZvI5zDZ6VoVjmMRmJAxwmwJ0UsULmFG1FDgugjCOyPBao
	 tH8adMSHJdboAEzbGDOlN5GS7rae7eJbXyXYnF4PNYzhnMz9rdSjRahL9cVKWU/lzAJ+L
	 V6cMOMB7YJPf2lm1YHZyffvc6aW2XHIbo+ZbtV7I4KCyFmtLdG21W+NX301EWuX2yPU51
	 ghYlQ43a/mHG9L30x0OrfuHtsgcSG3lXegmh60+tVakUzbV8q7lhMxvyvGPPGRD5xlTP0
	 39cOkFPJFhvWnLXZMVNhhcTsGjtXeXMLLElFXuiSrfmzlxLt9wkoPEdGk+nvKQ9r8IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I2Q5EYok;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DBB606A6A9
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I2Q5EYok
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2621F000ED;
	Wed, 25 Nov 2026 11:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606127;
	bh=5jxHGNSNLI009oSmxsp7IhysxwXODbieSJtrsSJ9ISY=;
	h=Subject:To:Cc:From:Date;
	b=I2Q5EYokpc8jhOe+5dfG8qoxQCgOmilZTuFYY94KwyX0RlCDmW1SR2oZZFpHdgVqK
	 L/QyfR3Q3rIWMJo9L636q6gqrAeGVDsyVS/zRlzpzteT/5Spyv9m8QXrQo38s8uI5A
	 +qRvGxVB2i1PFmhB5n1FFlNR9H99Hu/2PVifOPk8=
Subject: FAILED: patch "[PATCH] smb: client: stop reconnecting and replaying during a forced" failed to apply to 5.10-stable tree
To: pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:16:00 +0100
Message-ID: <2026112500-hacksaw-placidly-7d87@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x f778a530f28546956e5f58db486fb74376f5d869
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112500-hacksaw-placidly-7d87@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f778a530f28546956e5f58db486fb74376f5d869 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Wed, 4 Nov 2026 11:36:28 -0300
Subject: [PATCH] smb: client: stop reconnecting and replaying during a forced
 unmount

umount -f of a gone server on a hard mount hangs the teardown.
cifs_kill_sb() flushes the deferred-file, cached-dir and oplock-break work
and then cifs_umount() sends a tree disconnect, but on a hard mount every
reconnect wait in cifs_wait_for_server_reconnect() and every per-PDU
replay loop (gated by smb2_should_replay()) retries forever, and the
per-tcon abort count that umount -f bumps is only snapshotted on entry to
smb2_reconnect(), so an operation that enters after the unmount began
never observes it and waits or spins out the teardown (e.g. a close work
item wedging flush_workqueue()).

Mark each of the mount's tcons dying, master and per-user alike, waking
their sessions' waiters, and have cifs_wait_for_server_reconnect(),
cifs_tcon_retry() and smb2_should_replay() give up while it is set, so
both the reconnect waits and the replay loops stop at every site, however
late the operation entered.  Keep it set, with the mount's tlinks pinned,
until cifs_umount() has dropped them, then drop it on those tcons that
another superblock still holds, and hand no dying tcon to a new mount.
Also treat a tcon that no mount references any more as dying, waking its
waiters when that happens, so that whatever still holds it (e.g. the
cached directory laundromat, a cancelled close, or its tree disconnect
after cifs_prune_tlinks()) stops too, and never reuse it.

Also stop the reconnect worker from wedging: smb2_reconnect_server() holds
a tcon or session reference across cifs_wait_for_server_reconnect(), so
with the server gone it never returns, pinning the cifsiod worker and
leaking the tcon, session, server and cifsd thread.  It only needs to
attempt the reconnect, so fail fast; it is retried once the transport is
back.  Reopen persistent handles from it once, without waiting, and
reschedule it if one failed for a transient reason.

Reads, metadata and SMB1 reconnect waits outside teardown still follow the
hard and retrans mount options, except on a tcon shared with another
mount, whose waits and replays give up too while the teardown runs; a
task blocked in one can be killed, and open files keep umount -f from
reaching teardown (-EBUSY).

Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 6c26f82b9cca..8cff7857b450 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -352,9 +352,46 @@ static void put_sb_tcons(struct list_head *tcons)
 	}
 }
 
+/*
+ * While a forced unmount tears a superblock down, keep its tcons from
+ * reconnecting or replaying so the teardown (flushing close and oplock work,
+ * sending the tree disconnect) can't hang on a server that is gone.  It is a
+ * count, not a flag, so a tcon shared with another mount only has its retries
+ * suppressed for the duration of this teardown; one no mount uses any more
+ * stays dying until it is freed.
+ */
+static void set_tcons_dying(struct cifs_sb_info *cifs_sb,
+			    struct list_head *tcons)
+{
+	struct cifs_tcon_ref *ref;
+
+	get_sb_tcons(cifs_sb, tcons);
+	list_for_each_entry(ref, tcons, list) {
+		atomic_inc(&ref->tcon->dying);
+		cifs_wake_ses_waiters(ref->tcon->ses);
+	}
+}
+
+static void clear_tcons_dying(struct list_head *tcons)
+{
+	struct cifs_tcon_ref *ref;
+
+	flush_workqueue(serverclose_wq);
+	list_for_each_entry(ref, tcons, list) {
+		guard(spinlock)(&ref->tcon->tc_lock);
+		if (ref->tcon->mnt_refs)
+			atomic_dec(&ref->tcon->dying);
+	}
+	put_sb_tcons(tcons);
+}
+
 static void cifs_kill_sb(struct super_block *sb)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
+	LIST_HEAD(tcons);
+	bool force;
+
+	force = atomic_read(&cifs_sb->umount_aborts);
 
 	/*
 	 * Reaching here after a umount -f means the mount is going away for
@@ -362,8 +399,10 @@ static void cifs_kill_sb(struct super_block *sb)
 	 * writeback to a server that is gone) rather than looping forever on
 	 * a hard mount and hanging the teardown below.
 	 */
-	if (atomic_read(&cifs_sb->umount_aborts))
+	if (force) {
 		WRITE_ONCE(cifs_sb->exiting, true);
+		set_tcons_dying(cifs_sb, &tcons);
+	}
 
 	/*
 	 * We need to release all dentries for the cached directories
@@ -397,6 +436,9 @@ static void cifs_kill_sb(struct super_block *sb)
 
 	kill_anon_super(sb);
 	cifs_umount(cifs_sb);
+
+	if (force)
+		clear_tcons_dying(&tcons);
 }
 
 static int
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 0b66f2c9c9a9..4e16347886ed 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1207,6 +1207,7 @@ struct cifs_tcon {
 	int mnt_refs;		/* refs held by mounts, under tc_lock */
 	int mnt_unlinked;	/* mnt_refs of tlinks being built */
 	atomic_t umount_aborts;	/* nr of umount -f attempts */
+	atomic_t dying;		/* umount -f: stop reconnects/replays */
 	struct list_head rlist; /* reconnect list */
 	spinlock_t tc_lock;  /* protect anything here that is not protected */
 	atomic_t num_local_opens;  /* num of all opens including disconnected */
@@ -2408,9 +2409,16 @@ static inline void cifs_reset_oplock(struct cifsInodeInfo *cinode)
 		WRITE_ONCE(cinode->oplock, 0);
 }
 
+static inline bool cifs_tcon_dying(struct cifs_tcon *tcon)
+{
+	return atomic_read(&tcon->dying) ||
+	       (!tcon->ipc && !tcon->dummy && !READ_ONCE(tcon->mnt_refs));
+}
+
 static inline bool cifs_tcon_retry(struct cifs_tcon *tcon, int aborts)
 {
-	return tcon->retry && atomic_read(&tcon->umount_aborts) == aborts;
+	return tcon->retry && atomic_read(&tcon->umount_aborts) == aborts &&
+	       !cifs_tcon_dying(tcon);
 }
 
 static inline bool cifs_forced_shutdown(const struct cifs_sb_info *sbi)
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index b7a7fe372d47..15123c7b9373 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -244,7 +244,7 @@ int cifs_match_super(struct super_block *sb, struct fs_context *fc);
 int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
 void cifs_umount(struct cifs_sb_info *cifs_sb);
 void cifs_mark_open_files_invalid(struct cifs_tcon *tcon);
-void cifs_reopen_persistent_handles(struct cifs_tcon *tcon);
+bool cifs_reopen_persistent_handles(struct cifs_tcon *tcon);
 
 bool cifs_find_lock_conflict(struct cifsFileInfo *cfile, __u64 offset,
 			     __u64 length, __u8 type, __u16 flags,
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index eb021eaa7ae7..750b5bb72dc7 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2620,7 +2620,7 @@ cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx,
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 		spin_lock(&tcon->tc_lock);
-		if (!match_tcon(tcon, ctx)) {
+		if (!match_tcon(tcon, ctx) || cifs_tcon_dying(tcon)) {
 			spin_unlock(&tcon->tc_lock);
 			continue;
 		}
@@ -2715,8 +2715,11 @@ void cifs_wake_ses_waiters(struct cifs_ses *ses)
 
 static void drop_mnt_ref(struct cifs_tcon *tcon)
 {
-	guard(spinlock)(&tcon->tc_lock);
-	tcon->mnt_refs--;
+	scoped_guard(spinlock, &tcon->tc_lock) {
+		if (--tcon->mnt_refs)
+			return;
+	}
+	cifs_wake_ses_waiters(tcon->ses);
 }
 
 static void put_mnt_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 531ef9ce2702..ea793d34ab69 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2040,14 +2040,16 @@ int cifs_close(struct inode *inode, struct file *file)
 	return 0;
 }
 
-void
+bool
 cifs_reopen_persistent_handles(struct cifs_tcon *tcon)
 {
 	struct cifsFileInfo *open_file, *tmp;
 	LIST_HEAD(tmp_list);
+	bool retry = false;
+	int rc;
 
 	if (!tcon->use_persistent || !tcon->need_reopen_files)
-		return;
+		return false;
 
 	tcon->need_reopen_files = false;
 
@@ -2065,11 +2067,16 @@ cifs_reopen_persistent_handles(struct cifs_tcon *tcon)
 
 	list_for_each_entry_safe(open_file, tmp, &tmp_list, rlist) {
 		/* do not flush */
-		if (cifs_reopen_file(open_file, false, 0))
+		rc = cifs_reopen_file(open_file, false,
+				      CIFS_REOPEN_BOUND | CIFS_REOPEN_NOWAIT);
+		if (rc) {
 			tcon->need_reopen_files = true;
+			retry |= is_replayable_error(rc);
+		}
 		list_del_init(&open_file->rlist);
 		cifsFileInfo_put(open_file);
 	}
+	return retry;
 }
 
 int cifs_closedir(struct inode *inode, struct file *file)
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 4a3ecf5c80f7..4d0df73d15d7 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -1077,7 +1077,8 @@ static bool reco_wait_done(struct TCP_Server_Info *server,
 			   struct cifs_tcon *tcon, int aborts)
 {
 	return server->tcpStatus != CifsNeedReconnect ||
-		atomic_read(&tcon->umount_aborts) != aborts;
+		atomic_read(&tcon->umount_aborts) != aborts ||
+		cifs_tcon_dying(tcon);
 }
 
 int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server,
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 0a487b24f4e7..298f549bd7ed 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2938,6 +2938,10 @@ bool smb2_should_replay(struct cifs_tcon *tcon,
 	if (!pretries || !pcur_sleep)
 		return false;
 
+	/* the tcon is being torn down; stop replaying */
+	if (cifs_tcon_dying(tcon))
+		return false;
+
 	if (tcon->retry || (*pretries)++ < tcon->ses->server->retrans) {
 		smb2_replay_backoff(pcur_sleep);
 		return true;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index fd9766125d8b..b26bfb4bd91a 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4447,10 +4447,11 @@ void smb2_reconnect_server(struct work_struct *work)
 
 	list_for_each_entry_safe(tcon, tcon2, &tmp_list, rlist) {
 		rc = smb2_reconnect(SMB2_INTERNAL_CMD, tcon, server, true,
-				    false);
+				    true);
 		if (!rc) {
 			cifs_renegotiate_iosize(server, tcon);
-			cifs_reopen_persistent_handles(tcon);
+			if (cifs_reopen_persistent_handles(tcon))
+				resched = true;
 		} else
 			resched = true;
 		list_del_init(&tcon->rlist);
@@ -4480,7 +4481,7 @@ void smb2_reconnect_server(struct work_struct *work)
 	list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
 		tcon->ses = ses;
 		rc = smb2_reconnect(SMB2_INTERNAL_CMD, tcon, server, true,
-				    false);
+				    true);
 		if (rc)
 			resched = true;
 		list_del_init(&ses->rlist);

