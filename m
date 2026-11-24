Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546423;
	b=0scjUXFhwos26tHmqGDrIih+pn4Nisg8fzD0WTAzmi8Z4Cldkbjtq7xtzM8GUZOtqkJy
	 IjwTebhlkWm/cpKEjmrI0o+aFUM9SR51tt9bdOh+8X37UiNm5Nmua3EgQRPKFtUF0F1jZ
	 nfqcJ4kh4iVeaWmOiLKlYkYwlEMt6VUEcRUQLL+NbD3W3cMPYfdHoC1w7YX8QjxQIyjS6
	 hgnyJiqNONELIQhBUKtd5+eSiP60uHs7nmXaXU6cybf5kdzhV2PN+b5dEvt9+KzinZD6h
	 1pYb2qDO7sIcJXRev1VLLbp/ApfvG8MCqSdyzvERsphk523tBWHVDkAx6OcaKLk/rfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J3Z/iG6i8DU6ZQh4DtG79WYAyIaGqOiYgKvVjjJnoCE=;
	b=w+ZGDP7NF/LqDSv2YS+5Uo+nqhoKrMwHVlyS9Ma6exg6xeUQWYwVmZnJ9tSuRvmcN+le
	 7n9zu7mNN8tdGuf7Orb35v2Nnhe3f8JQeq6vCU6XtDs6BcvZPhXGm492oOHp1XG4tUBlk
	 S3Pz0YNUlD0coIxqDNH6qBvot2pWtKozfI2Dx+d/9JDtMdbnfD0UtBJvNeztFD7RZJAdR
	 1pWZEC9GJYApSKhZqf2ggsDrC6UHNcqJi2B0/1/6Nhe8EnLwTgXEeX2JtRyyxssTlYGdu
	 B/tRk3J5mKd0t6IuqLkYArcICLpizCaZxfjaTD6EC+WJ2MVyGlYa/cbhMbYSfpCuJ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B/NTanJD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61026606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/NTanJD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DFA1F000CA;
	Tue, 24 Nov 2026 18:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546423;
	bh=J3Z/iG6i8DU6ZQh4DtG79WYAyIaGqOiYgKvVjjJnoCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/NTanJDNPoGtqGvMzlXZMXRUJgRhF3EWCb8+WpAYyJiSoyAd9YVpr6Nplp1LYthJ
	 azCY3QL3B00TXzPwhGYAVRxLIg0GW7z/ietpUnkkLMuFzuct43wx9M4tBc8rP44z04
	 XJxf05himwOKaH4T8JSSmUPrhHHlnuNLAxWacdL2rHDG9hyv8c3OWdFSLTCN9jdrRo
	 IJsj2rAHbUf9dj7O4RWQ7iuVP5nB8CCwxEa2qsgd83CaHioQLQXopb0RtCMqDASpt9
	 DbqKgIsbIJRkPqXKc5gk2vb0e37tWHu3P8owFwTeIU7yzGctsMn5zsda3B89RCnLmJ
	 ZEJPJyrj8VWgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shashank Mohan Jain <jain.sm@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] errseq: don't let errseq_check_and_advance() hide later errors
Date: Tue, 24 Nov 2026 13:53:39 -0500
Message-ID: <20261124185319.2501381-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124185319.2501381-1-sashal@kernel.org>
References: <2026112442-swinger-raven-ec45@gregkh>
 <20261124185319.2501381-1-sashal@kernel.org>
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

From: Shashank Mohan Jain <jain.sm@gmail.com>

[ Upstream commit 94defd41d80f10bbe883c0c8d1b28d1665b6b153 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/errseq.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/errseq.c b/lib/errseq.c
index 13a2581c5a878..ea4ff9cc21669 100644
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
-- 
2.53.0

