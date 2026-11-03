Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725411;
	b=O+Eevyd3CjPtZsBMjQ91fh4Sa/obQ6WE27qv2Js4Ig5l9bEzdyvBwOAvlyR2i4i7XmnL
	 oJ7lk8CibYQu46jNdwRDj92MKuSXfHnD7fHqYiZG8VXyAZ2c5DX1aQw8Lxi7JSL4bRfpe
	 UhCUNMPPLIabwzMOuW21g+FU4doNo7S/BjBWGzO36rZcsX2FIwnWUkg8WwuqLRJU6RtDu
	 c4+x53I//9Ig4UjN43KK/crXxD/7aTpiEbY68dVVhF7a/SZn4zHx9v+KKOkQtj2TzTMAQ
	 xRZlAHi0qAfXwwAvS7fHUF79x8AHMNrAFHkd18KY+oztJU2C4llTg2x2JKCJNB7LjDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725411;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aIvBbbGvjSVrFvfUuTeZWOW0EpXEgJisrpfsN8WF9cg=;
	b=GTZZs3ltOiMSY57nmOyF5z95EkrbR3kMr9GM6LqnGMhaQ+UWtqVGRlyonedV/no/+LZx
	 YbPZkHH95Ov5k00tgz4EOt18NtnR5qiGD1wjYJMRUmwPNiPKeHxO0FpegjTPtV3D0ipKR
	 kvHhT9WqymcDOBozdqFEef8rFeCexf8kGdPsHedLbMrUekZYqcIhxT0Yo25oQGVdV2DY3
	 CRc5eacZA5B9eZodrnicUwDqk92V9Bg7C93rhg0T9FnEGQ2JnzMERA85GrlvzVe/TSpdv
	 gf1n8fu9cYYJ1ZqYHk9LBGptWPeJYd3ksMRi5agjKx/IBScirzwsCT6Z4hnWuQzVYrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvpasBvE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25342606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvpasBvE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FB41F000C1;
	Tue,  3 Nov 2026 17:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725410;
	bh=aIvBbbGvjSVrFvfUuTeZWOW0EpXEgJisrpfsN8WF9cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XvpasBvEQELw4NkodzACFvJTQhZF3JCU/ZcJmkxp54fD22JGCxqksUX2nKaqJE65d
	 8rOQjpLB0gLjvVHaUdaLxmISv0aKJ91T/VoCGp+w59N4AVGoUwnOIbYIR5gvM1IkHB
	 rXm8plB1ZL/tnNyV2asUf3fJbMaxFxO4M/i8o8pOMHUDBblbF81N2G5nr90iCcMnCs
	 99BUAI/X9IvoEBS3Fwln5bskLq7UBLe6KWqzfdmKeAHDXnvcQYcyBnamS+mmThTvUn
	 1YK/E+WKs82QUlynyDzj0EY1NtwkAizK7LaYoWB5qdyoQGCL9mK56pb2weX8NJcmF3
	 WRkNYyuAVuQIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daijiamu <3058704216@qq.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/4] ksmbd: use clear_and_wake_up_bit() directly
Date: Tue,  3 Nov 2026 12:03:25 -0500
Message-ID: <20261103170318.645584-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110310-spool-turban-3d3a@gregkh>
References: <2026110310-spool-turban-3d3a@gregkh>
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

From: Daijiamu <3058704216@qq.com>

[ Upstream commit 8852052e32df965a76daecbd8cda0ecf950b54df ]

clear_and_wake_up_bit() was introduced by commit 8236b0ae31c8 ("bdi:
wake up concurrent wb_shutdown() callers.") to replace the open-coded
clear_bit_unlock() + smp_mb__after_atomic() + wake_up_bit() sequence.

Replace the sequence and drop the now-trivial wake_up_oplock_break()
wrapper, calling the helper directly at each call site.

Suggested-by: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Signed-off-by: Daijiamu <3058704216@qq.com>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: f728cfee6929 ("ksmbd: fix app-instance non-durable supersede session UAF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/oplock.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 1b8c3482d1e4e..25ff8408f0ba2 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -763,14 +763,6 @@ static bool wait_for_break_ack(struct oplock_info *opinfo)
 	return false;
 }
 
-static void wake_up_oplock_break(struct oplock_info *opinfo)
-{
-	clear_bit_unlock(0, &opinfo->pending_break);
-	/* memory barrier is needed for wake_up_bit() */
-	smp_mb__after_atomic();
-	wake_up_bit(&opinfo->pending_break, 0);
-}
-
 static bool oplock_break_set_ack_wait(struct oplock_info *opinfo)
 {
 	bool ret = false;
@@ -826,13 +818,13 @@ static int oplock_break_pending(struct oplock_info *opinfo, int req_op_level)
 
 	if (opinfo->level <= req_op_level) {
 		if (opinfo->is_lease == false) {
-			wake_up_oplock_break(opinfo);
+			clear_and_wake_up_bit(0, &opinfo->pending_break);
 			return 1;
 		}
 		if (opinfo->o_lease->state !=
 		    (SMB2_LEASE_HANDLE_CACHING_LE |
 		     SMB2_LEASE_READ_CACHING_LE)) {
-			wake_up_oplock_break(opinfo);
+			clear_and_wake_up_bit(0, &opinfo->pending_break);
 			return 1;
 		}
 	}
@@ -1260,7 +1252,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, struct ksmbd_inode *ci,
 				SMB2_LEASE_HANDLE_CACHING_LE)) {
 			if (!oplock_break_set_ack_wait(brk_opinfo)) {
 				atomic_dec_if_positive(&brk_opinfo->breaking_cnt);
-				wake_up_oplock_break(brk_opinfo);
+				clear_and_wake_up_bit(0, &brk_opinfo->pending_break);
 				return -ENOENT;
 			}
 		} else
@@ -1309,7 +1301,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, struct ksmbd_inode *ci,
 		      lease->state != SMB2_LEASE_NONE_LE)))
 			goto again;
 
-		wake_up_oplock_break(brk_opinfo);
+		clear_and_wake_up_bit(0, &brk_opinfo->pending_break);
 		return err;
 	} else {
 		err = oplock_break_pending(brk_opinfo, req_op_level);
@@ -1319,7 +1311,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, struct ksmbd_inode *ci,
 		if (brk_opinfo->level == SMB2_OPLOCK_LEVEL_BATCH ||
 		    brk_opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
 			if (!oplock_break_set_ack_wait(brk_opinfo)) {
-				wake_up_oplock_break(brk_opinfo);
+				clear_and_wake_up_bit(0, &brk_opinfo->pending_break);
 				return -ENOENT;
 			}
 		}
@@ -1342,7 +1334,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, struct ksmbd_inode *ci,
 	ksmbd_debug(OPLOCK, "oplock granted = %d\n", brk_opinfo->level);
 	if (brk_opinfo->op_state == OPLOCK_CLOSING)
 		err = -EAGAIN;
-	wake_up_oplock_break(brk_opinfo);
+	clear_and_wake_up_bit(0, &brk_opinfo->pending_break);
 
 	return err;
 }
-- 
2.53.0

