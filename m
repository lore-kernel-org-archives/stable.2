Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050038;
	b=ZRFrDiF7eZ39XY594UZ9ITNWiIlsAwSzI+6tSmsJiomzYj9LbMdJ+ch+ooy9f9cPFBBV
	 Z27YmPquCxdyfhD/zpEZmJnFbx8d8LLZ29dwbhd5B+sScf1+8vA8ms62EKkvVRzsix2jS
	 Uf+9+mrNpNqgZrsNX2iZaT92096dLXS8WeDkbZZBS82/9vlzlPu9mryP7KdF3RvL+7rYi
	 fsXopT3ei05NGMfcd6Yd+9PEzG8xnyVeRWnONAW9G/gklSurwjrzdOkx4B90eopR5oXay
	 DbL3bqdCMYunJvcD3qpv4ew/Tk0G4hvcpQ81rVXhWCoLRcUaCOEG3QnYXOoUEdFsx5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050038;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xn9Uo9+O6y/9flSD1Eb56yiDy+Q1RutU5o1EKiC5BCo=;
	b=sSvgsemLV+LlSt2avU56UJf05qXetoTOahlPZ6hv1Lpn87D1cl2PcBFxbnGhHNwdmHFp
	 nMUx8mueg9nJpFfYgdWnEmVm2Pj20k7CUZ0s4QISp+J4GqSX1d4VzXX7CrTdQ1Xdahe/2
	 0gmO+3T/2F+5Wo/iQMBHBWruhIGVEiVzy6kNH5pmwZxZGgwmDtjfPu6pYErtL61+khlkA
	 FZW37lZmGmC1gWGLm1oG7t0PAxofzUfDQnPbJtXRCX9DvxhMvKb3N8C/EnHs9RcbsWkZ2
	 CniNwl6+NcKPu3zaZJcy0Yg7P7K9oxYJ7sF+8jybgj2uYHp/Jg9AjmY3XZZkmj80I7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPGGf2er;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E9606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPGGf2er
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83AE1F0089F;
	Sat,  7 Nov 2026 11:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050038;
	bh=xn9Uo9+O6y/9flSD1Eb56yiDy+Q1RutU5o1EKiC5BCo=;
	h=From:To:Cc:Subject:Date;
	b=cPGGf2erAsIcTXBYlPZDXb4Vv52iRW4xSfIyeoYUhMb5qWjoNVesVQbpWQTCdLPmO
	 7Ga8B0h2q++9Ara883tLx4fxP/c/w+eC9SoVe6+66VV5RTaDbIY91uA2j2jWd/wxi7
	 r+4dzznrVytfAGTnQixkQ2G0ZylTVGFmrU10nNgbPJv0AVtrLCvzY145efIyrSupnJ
	 V+fcBUr1sz1JD0rUdLRX1xG5pB1r3WPM7NFHsYUjz60bnX49tc/zwzjZez297Ad7NP
	 w2Y4FOeWkmK+uMa3wqEar9xmEp+W9MtGYUIoT1itIqQYHjbsVvt5+gjnd/WpkRaIXt
	 lTrucBUb9//Uw==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] splice: avoid stale f_pos writeback on error" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:56 -0500
Message-ID: <20261107061356-failed-5.15-79b496ebe382@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 79b496ebe382866e3a05090b7dc9ae95e85e65b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061356-failed-5.15-79b496ebe382@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




