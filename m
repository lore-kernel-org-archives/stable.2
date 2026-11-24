Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533661;
	b=n2GraSbr6Ni4LXVgfcmzcztLh5oLUKI/S6MEKEa1vHnYu6Y/TZgNZe1ouHkeNnsW6hPB
	 zvGswkUn4fMZmgp3Te4mCe6lQHlqajPyRzQ3IkLyY2nYhQoRtjwQl7iZWc7TkXQPwyIJh
	 qGMh/zwLYa2agg1ZU2tJ4bEcY+wFNCmltFMbJeiu9cDUVMgGb7rwG2Jer2OySWdm0XGxE
	 PHbCB5lzfbYj01Rl8Wo6Hvmy4a1aL0pq5sEPlZD9assTie2E37PRafwmnyTo7SX5YAn5E
	 DAtVEqZE0vYJz9CLxbU9/dwyjxluKz75oNBdLzsCkg8hpR73QxxwS8G6vhXTbACm+yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533661;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iglPYszc1I4l4n4uKbgNNcJqB+L16Jx8vBFTcMga0FI=;
	b=2Rh0fSz0bD9jxb4G/03Ahld4WT/YPEfnggAwxw0QH/NexyY4bqTuz2b5m3jImSg18yWr
	 0+zhr4SNkXyyFJMAkOKUxxxqERP/A2boOttaaKodLII6xNquuwEveW3gxWNu7Sb63DZZi
	 ntP6zWym5gz4YY3DebWWIEIZgZX6GWwzB2Fbq48ydwxgIRo4U+bVUqbVJlNtsZXQQTqoA
	 zHPcQJmpkEzpfxswIYeVNQUa26Omk4+ysrqOarUqcJhma2AX5T7OJWStvjvukKSsUduV1
	 IbaDxUT2nCzixap3/NjSykaJ62V8CME5fp6MpQtDHaJ3tO3EV/85JcJBt07iK150Ahg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ECBqRPEQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477B606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ECBqRPEQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E581F000C6;
	Tue, 24 Nov 2026 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533660;
	bh=iglPYszc1I4l4n4uKbgNNcJqB+L16Jx8vBFTcMga0FI=;
	h=Subject:To:Cc:From:Date;
	b=ECBqRPEQxyatIdFYJaN5W45jOREkw439PQi2ngHnnYDnm3+w/9tcT1o92GIEvb2RZ
	 ruqMD7N3KVWqxX4b3nH9HlFy8IyY4RpY0ioG42XrdsxcMImctMiaqrJ5vsHJHlf62r
	 fgUPHzd9MhHmS6g/OGZQBm6eALNSVaCkq711u/kM=
Subject: FAILED: patch "[PATCH] errseq: don't let errseq_check_and_advance() hide later" failed to apply to 6.1-stable tree
To: jain.sm@gmail.com,brauner@kernel.org,jack@suse.cz,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:20:42 +0100
Message-ID: <2026112442-swinger-raven-ec45@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 94defd41d80f10bbe883c0c8d1b28d1665b6b153
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112442-swinger-raven-ec45@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 94defd41d80f10bbe883c0c8d1b28d1665b6b153 Mon Sep 17 00:00:00 2001
From: Shashank Mohan Jain <jain.sm@gmail.com>
Date: Sun, 27 Sep 2026 10:47:25 +0530
Subject: [PATCH] errseq: don't let errseq_check_and_advance() hide later
 errors

errseq_check_and_advance() reads the errseq_t, sets ERRSEQ_SEEN with a
cmpxchg() and then advances *since to the value it computed, ignoring
whether the cmpxchg() succeeded. When it fails because errseq_set()
recorded a different error in the meantime, *since ends up holding a
value that was never stored in the errseq_t.

errseq_set() only bumps the counter when ERRSEQ_SEEN is set. So as long
as nobody has seen the new error, recording the original errno again
recreates exactly the old value, and once another subscriber marks it
seen, it is equal to the stale *since. The next check through that
cursor then reports nothing, although -ENOSPC was recorded after the
value that check reported, and -EIO was recorded again after it
returned:

  cursor f                writeback              cursor g
  --------                ---------              --------
                          set(-EIO)
  check_and_advance(&f)
    old = [c, EIO]
                          set(-ENOSPC)
                          -> [c, ENOSPC]
    cmpxchg() fails
    f = [c, EIO, SEEN]
    returns -EIO
                          set(-EIO)
                          -> [c, EIO]
                          (no bump: unseen)
                                                 check_and_advance(&g)
                                                 -> [c, EIO, SEEN]
                                                 returns -EIO
  check_and_advance(&f)
    [c, EIO, SEEN] == f
    returns 0             <- -ENOSPC and the second -EIO are lost

For file->f_wb_err this means that fsync() on one descriptor can return
0 although writeback failed after the previous fsync() on that
descriptor returned, when writeback errors race with fsync() on another
descriptor of the same file. The same applies to syncfs() through
sb->s_wb_err, which every file on the filesystem shares, and to the
ext4 and jbd2 cursors on the block device mapping. The kernel-doc
promises "Negative errno if one has been stored, or 0 if no new error
has occurred".

Retry with the value found when the cmpxchg() fails, so that *since is
only ever advanced to a value that was actually stored with ERRSEQ_SEEN
set. Every later errseq_set() then has to bump the counter, and the
error is reported. The retry loop terminates because each iteration
needs a concurrent update, like the loop in errseq_set().

A TLA+ model of errseq_set() and errseq_check_and_advance(), checked
with the TLC model checker, finds the lost error with the current code;
with this change TLC checks that an error recorded after a check
returned is always reported by the next check (exhaustively for two
subscribers with three checks each, and one writer recording four
errors or two writers recording two each). The KUnit race test added
in the next patch misses the error in 1-6% of 2 million rounds on
4-CPU UML before this change (depending on host load), and in none
after it.

Fixes: 84cbadadc6ea ("lib: add errseq_t type and infrastructure for handling it")
Cc: stable@vger.kernel.org
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
Link: https://patch.msgid.link/20260927051726.71337-2-jain.sm@gmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/lib/errseq.c b/lib/errseq.c
index 13a2581c5a87..ea4ff9cc2166 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -162,7 +162,8 @@ EXPORT_SYMBOL(errseq_check);
  * points to. If it does, then just return 0.
  *
  * If it doesn't, then the value has changed. Set the "seen" flag, and try to
- * swap it into place as the new eseq value. Then, set that value as the new
+ * swap it into place as the new eseq value. If the swap fails because the
+ * value changed, retry with the new value. Then, set that value as the new
  * "since" value, and return whatever the error portion is set to.
  *
  * Note that no locking is provided here for concurrent updates to the "since"
@@ -184,24 +185,30 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
 	 * to take the lock that protects the "since" value.
 	 */
 	old = READ_ONCE(*eseq);
-	if (old != *since) {
+	while (old != *since) {
 		/*
 		 * Set the flag and try to swap it into place if it has
 		 * changed.
 		 *
-		 * We don't care about the outcome of the swap here. If the
-		 * swap doesn't occur, then it has either been updated by a
-		 * writer who is altering the value in some way (updating
-		 * counter or resetting the error), or another reader who is
-		 * just setting the "seen" flag. Either outcome is OK, and we
-		 * can advance "since" and return an error based on what we
-		 * have.
+		 * If the swap fails, a writer or another reader changed the
+		 * value under us, so retry with the new value.  "since" must
+		 * only ever be set to a value that was stored with the SEEN
+		 * flag: errseq_set() does not bump the counter while the
+		 * flag is clear, so an unstored value could come back later
+		 * and hide the errors that were recorded in the meantime.
 		 */
 		new = old | ERRSEQ_SEEN;
-		if (new != old)
-			cmpxchg(eseq, old, new);
+		if (new != old) {
+			errseq_t cur = cmpxchg(eseq, old, new);
+
+			if (cur != old) {
+				old = cur;
+				continue;
+			}
+		}
 		*since = new;
 		err = -(new & ERRNO_MASK);
+		break;
 	}
 	return err;
 }

