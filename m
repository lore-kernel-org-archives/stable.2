Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411639;
	b=QHP6yZ4TbfQeBd78WkqdTf4u6OywRcw4JFdrIFD1G79sYlsmz3ldCivyVzHTptVHfUXG
	 r9SVs9OcJXowFI+eGQNyBu4+vQQwSaAr9uo187v+PioPe57IceKZQninj9Sg9Sg24NZ8C
	 mFgLR/Bf7JDfDiUOeWLYBLzXVJC6vTVCBM3YAMZkrJzT0DkZXe8GBynCSXD1ZUlOi1OQV
	 PmgULbUzr24DDEpxzv7vImf+61xO/rxD+eueRxzn/VnQZBij8EQ/DuVKw+KqdhJK1G40J
	 NvSMOXLABhhHyzj9gFXv/Mr8iNPlTV2hDk+8cg2o7TlRQNjV9CAS5Fn9w+zzF+906+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411639;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DjxWMUU8ez15EfzoUVfc9UM93Rr3Eh6olOb/HQULFOA=;
	b=VITTDFA7TE6gyNQly9heTdo+qYLCRpMdojcnQrnWC2zqI+2i5ee3Xur+wkrMMK8dr1GI
	 8O6tjxDM5tK7Zh87aErcSVSK9rvLvziJHtM4AqjSJ0qK48/cfhaF11NES1sn20UtyseLF
	 C87u1PBUi5z++SXTgGUSpYjRxoHYoPcan+yuTQd7YqwY2ay6OH2KWTWL3sQfKDm5MA7Q8
	 33BIBDEuSUlk9FQJQGx+0bbHE3bTO+zR+3X2Fqs69RyUbAClDAOM0o9hd2tLZBlKMkNxt
	 9rFk1QyujOti0gVwTRzaTMl3E2+24qQwjEMm5P67X3rDWqcpWCpoH44C4lgd8XiwjKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2gfWlre;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962E606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2gfWlre
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8224B1F00A05;
	Wed, 11 Nov 2026 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411639;
	bh=DjxWMUU8ez15EfzoUVfc9UM93Rr3Eh6olOb/HQULFOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G2gfWlreZevjgasIsqWDkjNpqD/sdVvHedjEacCRFCDh/vAM9XIMhgz6uRf9F/4lr
	 +tnlI/qT0peCKaIds2t3WDkR5k2xAuJQPV4WNytof+6eb11CH0Sfoo0Og/5EKodBTd
	 s8zxiZf55Utm33nQY3MabA/g3KJUp5BjLn1f+WKrwBgQZlkXyPEQkoA7yLa1YWj3ly
	 eEfn8OnBSAv7gizg536tUO0xcZzkZyF12XSjMsEX2wVEmG9JzKcStk/Qt633434n64
	 ebn9bXIHr4B5TBJo/eiFHRdwioPxtFqa4HM4Dc9wxuAulpmao3IYvA7wnpMWPMVLwt
	 DDfyH+CtSidNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] splice: always fsnotify_access(in), fsnotify_modify(out) on success
Date: Wed, 11 Nov 2026 10:40:35 -0500
Message-ID: <20261111154025.2714356-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111154025.2714356-1-sashal@kernel.org>
References: <20261107055657-failed-6.1-79b496ebe382@kernel.org>
 <20261111154025.2714356-1-sashal@kernel.org>
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

From: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

[ Upstream commit 12ee4b66af34f8e72f3b2fd93a946a955efe7c86 ]

The current behaviour caused an asymmetry where some write APIs
(write, sendfile) would notify the written-to/read-from objects,
but splice wouldn't.

This affected userspace which uses inotify, most notably coreutils
tail -f, to monitor pipes.
If the pipe buffer had been filled by a splice-family function:
  * tail wouldn't know and thus wouldn't service the pipe, and
  * all writes to the pipe would block because it's full,
thus service was denied.
(For the particular case of tail -f this could be worked around
 with ---disable-inotify.)

Fixes: 983652c69199 ("splice: report related fsnotify events")
Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Link: https://bugs.debian.org/1039488
Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Message-Id: <604ec704d933e0e0121d9e107ce914512e045fad.1688393619.git.nabijaczleweli@nabijaczleweli.xyz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 79b496ebe382 ("splice: avoid stale f_pos writeback on error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 30b669aca152d..ea92caf95a385 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1075,10 +1075,8 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
-		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
-	}
-
-	if (ipipe) {
+		ret = splice_pipe_to_pipe(ipipe, opipe, len, flags);
+	} else if (ipipe) {
 		if (off_in)
 			return -ESPIPE;
 		if (off_out) {
@@ -1103,18 +1101,11 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
 
-		if (ret > 0)
-			fsnotify_modify(out);
-
 		if (!off_out)
 			out->f_pos = offset;
 		else
 			*off_out = offset;
-
-		return ret;
-	}
-
-	if (opipe) {
+	} else if (opipe) {
 		if (off_out)
 			return -ESPIPE;
 		if (off_in) {
@@ -1130,18 +1121,25 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 
 		ret = splice_file_to_pipe(in, opipe, &offset, len, flags);
 
-		if (ret > 0)
-			fsnotify_access(in);
-
 		if (!off_in)
 			in->f_pos = offset;
 		else
 			*off_in = offset;
+	} else {
+		ret = -EINVAL;
+	}
 
-		return ret;
+	if (ret > 0) {
+		/*
+		 * Generate modify out before access in:
+		 * do_splice_from() may've already sent modify out,
+		 * and this ensures the events get merged.
+		 */
+		fsnotify_modify(out);
+		fsnotify_access(in);
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 static long __do_splice(struct file *in, loff_t __user *off_in,
-- 
2.53.0

