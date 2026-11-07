Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049019;
	b=4cmdnaN26km4x5VfUD70E632EvGfdKXu/znB1gP/VBMWfCQEPFpLISmhzQqAiNUxjTQ+
	 A+FJ+GOEkPNQSmeP3imUWAPmQHnt5zLHceeVDy0W4ulA0oJ3mp/kS+CVot42NVeFnM1Ai
	 hUp3CjjWgXxcX8GlgS4SHfgH0jVOU9aqOzB4G0FjwA6SohXW+Z44JCa6lU2L+u8bkH68w
	 +esmgPpamFCy1KBpQ9AxpoxArfaOvuAcbmBygzi1vYeUL0GncOgChwE/tyZxiQrUn7Y8d
	 VQ3lUpNPJ+mx5nYAp21jAxK/aLWdCoviyPUF4mP/2Q2IiS3eATQ7QFHA10F8eDcLWxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049019;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0joekEClLzdpbVYW2DkDXFQp3Xb24A2IVHBskbqEOIk=;
	b=H7/fujHuWbSb6vl4ISw6W/BMrFvNoMljfh7VRlk/G00rDiL7yc2m7THfmy5adlD1kesQ
	 TQzEQftJ0LcR2vKtngnP9RaXOWCV/YVC/bM/Zit1wYJN/WBJJuKazv0UW28ycDMt+E2RN
	 zbCP0+IFFsguW2HLMsA6DHw0+blSEonHw+FPAdCAAW+WJP9GgwxcujtI9AI3nJMNl2WsH
	 kMkkpP8o1i2s9w50hYNUXXftXiwmhfWoF2IHcWbNb0UKzBk9GLP0916YAS6i+eYdeSnfC
	 bCYK556FhzhTuukvmQcIu7H+vk2j7nLXkM6seKws/rN2tkq/7MziJMal9t7hVL+a9Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcUy7Wy8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7D606A33E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcUy7Wy8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF28A1F008A3;
	Sat,  7 Nov 2026 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049019;
	bh=0joekEClLzdpbVYW2DkDXFQp3Xb24A2IVHBskbqEOIk=;
	h=From:To:Cc:Subject:Date;
	b=ZcUy7Wy8m+rbtl4zClA0zQ7tarRhpEArXWxaR1xBI3+n9jlkyTqSkzvI8EnmmBw7X
	 UU+iavewO5f06x3ZhDIir6oLHOcWpRoDWBT/85Mit1DFR29PtBzBDXaFhlYMPoBZ2K
	 qXqS81zbK5BqdXmO8DdKQqJTmQ9ewsTDHSatDk5q96rpSCi729kdXq21oke0ljQZcE
	 ogxFy3UWdgKGXg0ErDt/sP3Dsmxg/SVrk+5Wq+8jAMV0eAKBHwL36XgW6yerSaoB0Y
	 cwO0FEvOX7UpRdyfOsTP/mhSP/RaatKxg114Ocn2Fs6qp+7WoTjkWU4cRctkmQpQUu
	 KkWw//s8BRFrQ==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] splice: avoid stale f_pos writeback on error" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:56:57 -0500
Message-ID: <20261107055657-failed-6.1-79b496ebe382@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 79b496ebe382866e3a05090b7dc9ae95e85e65b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055657-failed-6.1-79b496ebe382@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 79b496ebe382866e3a05090b7dc9ae95e85e65b2 Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Sun, 18 Oct 2026 14:17:08 +0900
Subject: [PATCH] splice: avoid stale f_pos writeback on error

do_splice() snapshots an implicit file position before calling the splice
helper. Since splice does not take f_pos_lock, another operation on the
same open file description can update f_pos while the helper is blocked.
If the helper then fails, the unconditional writeback restores the stale
snapshot.

For a directory without ->splice_read, a file-to-pipe splice fails with
-EINVAL. A concurrent directory mutation and getdents() call can advance
f_pos and refresh the filesystem's revalidation cookie before that failure
restores only the old position. The next ext2 readdir can then trust an
offset inside a directory entry and copy data from the adjacent page to
userspace.

Only update an implicit file position when splice returns a non-negative
result, matching read and write. Keep explicit offset updates unchanged.

Fixes: 7995bd287134 ("splice: don't pass the address of ->f_pos to methods")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Link: https://patch.msgid.link/20261018051708.2422394-1-4ncienth@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/splice.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index bc243ab8dc431..f4bce35890671 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1377,10 +1377,10 @@ ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
 
-		if (!off_out)
-			out->f_pos = offset;
-		else
+		if (off_out)
 			*off_out = offset;
+		else if (ret >= 0)
+			out->f_pos = offset;
 	} else if (opipe) {
 		if (off_out)
 			return -ESPIPE;
@@ -1401,10 +1401,10 @@ ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
 
 		ret = splice_file_to_pipe(in, opipe, &offset, len, flags);
 
-		if (!off_in)
-			in->f_pos = offset;
-		else
+		if (off_in)
 			*off_in = offset;
+		else if (ret >= 0)
+			in->f_pos = offset;
 	} else {
 		ret = -EINVAL;
 	}
-- 
2.53.0




