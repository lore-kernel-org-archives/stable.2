Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542169;
	b=aAdW3SkLnsG3alcun8V97GlxyH05XOWL9eFSr6cknJWoAneVjAzlRCZ3KO8bLy5tEpeE
	 NziEWxhOge1JNaTy79CoYpKV10Z1eJh4N9s+EaWPKisf3kIBCaVRKoOar6o5l4zAo5vyC
	 BfJp52wymrDLXaIF6IgN2uZ2T8zJ8zEycl7Ea/puR05S9fFQbTIcTCss5/1QmkOnu6X8W
	 dYuNkapEFo6JCGlziT2WqRdQVmHwS748QWJ+X5JZE8wfhgjJYzcyZ+GoZsyL20/htoGWx
	 WtGRZIwmUpO0mV+mKMdXU735DF/hz8PwfPmryCe7mNtlNgfRnNTacwgrJf69MmA7i3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542169;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J3Z/iG6i8DU6ZQh4DtG79WYAyIaGqOiYgKvVjjJnoCE=;
	b=UZq+Pv3j+A1NKBav12Th43dLBk62niYx9N5XTllGEkxedPzllEEDV8RNmEo0V+kGHzy3
	 u0YG8AYoAOifRS70lZmBRfhQOm1Dlp8P4WPpSghcXu+XsVPmMlltSyb5SfvBDLd8tZcMq
	 Afr3s6JDJCy4UwM8JqLGE97RRT+rQ4p5gOvcvV62pAu998F4Lgb8KkX2y/y044RakaTJd
	 DHx//EVPieIVNohYIrA28gtwtZuYW0Weq8NISeKiDtH8yzQSt3uKNzZnpPD0rL+gRo1fP
	 Fz3geo9wOn2UnQCVaOHTrAE/pM1EZ99T0+1qYontDHBvLeFJUtECAAZ5TWgVeYjHdXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLcuXCvt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB8606A32A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLcuXCvt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D891F000C6;
	Tue, 24 Nov 2026 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542168;
	bh=J3Z/iG6i8DU6ZQh4DtG79WYAyIaGqOiYgKvVjjJnoCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GLcuXCvtBoA0aaBdRiNPm8SB/zRuneT7qHhmIGAlu6cflbN4UXYN+zv5BKeI1iIBf
	 boAy6RwCTp6nF3ThHXFy7Yp/JzoPPujhAf6YnSWMznRGBKF+9hRZWZ2o3eZRF5jOb+
	 qn02rLI6fJqalQIdDVryOLJW4uRiXXwMS8yuMxCPoeY6DAVnrsxenexCpfkmxE3iWQ
	 3BCtkgrQ645Wnt1DXa4p9bajtzhRAZsMcfbtGuoAlD3uEwGJebq14npIAbRjC6u0L8
	 oqQH/74ddIxbHki5hU/+U4a5olJKXTKPqtoNbe5ZJg+UcQoUuTVaS6RE9bEn0lcVuv
	 XO2taUuGUsPbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shashank Mohan Jain <jain.sm@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] errseq: don't let errseq_check_and_advance() hide later errors
Date: Tue, 24 Nov 2026 12:42:46 -0500
Message-ID: <20261124174229.2018672-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124174229.2018672-1-sashal@kernel.org>
References: <2026112440-lark-unfiled-3dec@gregkh>
 <20261124174229.2018672-1-sashal@kernel.org>
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

