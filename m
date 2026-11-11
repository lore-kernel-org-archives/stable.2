Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412740;
	b=H4J8wZONwixZUNqTgVVO3H9EYt9daa83EMU2zU34McnUBKmgCweuWKP9qZarFtF+sPpi
	 eUZc6ZvelYsd83HdsQnf6F4t6Hp5dAn+juwWShjiQhcTf21qTwFrRKl+RFxqw4x1RlLul
	 WUiHqfplV82KRnkIDWP2oOwH1NAeCUIcJRE6uNu+odR1Z13oApwrcv5iVywaS7hU2cG3v
	 xzWweQ55movwytuiNTLEhYKYotvj+IX/gZi6UHXpaYSlPql/s8oWfFXCOnUz2VVKUOP60
	 r8OlWPs8Lw0SmPsRumXZevH/ns7LtRRCWSe5mS08yux7kny4hKwm4ac9FnbqYhCZueQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yLXtlNa8g/qu67D3ICgjRmRUd9hiuO65oBDS8hdf64E=;
	b=KhZ89OO4U6JnpGc0XCxcrUT33hD/Ip1yZIeCHlo+lrOM+0LuuU3Jikq8/Dadh3tDMCf1
	 9gBpDlHQ1NbwKle9nq8AxQPV/GjJlGbfOQZyP9j9B+aulSn4oyogqTJH4epn0qlHNnJM7
	 tZN+ECVjQv/mXvwymUe9z4HTMK+nburNjTigfxMRqWc91qu93fviQaVyIhvgTT5yzw0Kb
	 Xkz3F2ZBuHa9BaQdyGL+vtNetVz2YFstm+iweMrXOvuUTZa0dgSTuO5xnuz6tIrVfL+Xb
	 9sSptW6V2nxlCD9OzpYVSM88WbOMVUr8ySOrVsnIen5bM58zAc6e0EUQMKc29RUExbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aX8J8sae;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A87606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aX8J8sae
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC931F00A08;
	Wed, 11 Nov 2026 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412740;
	bh=yLXtlNa8g/qu67D3ICgjRmRUd9hiuO65oBDS8hdf64E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aX8J8saeOPTLa7qG6QLIeBbwvyb3LT4AHHK0avKswHgZv2B1oKIRukBw64tI76UXV
	 TAARsgA/6BlMkJxr8LqRBFBeUn8Jb3H0OtzWS8UtgSE6RsN7d1q5Tp7vOjGvMnm+BT
	 3fphR+O/pZ/0P3EbBqT3ZkA9W8xELxsjl1V0p+udk2JxXna2hgqgCaCG0AHD3r09MM
	 XCFwH8FdbrDdTL2ne/GrRfa4UyY7/3xPLHhTeMHbabnrGfJYC1H9d0iN+1bU0lfHFr
	 xwx2D/cNnGTeJosm38DtN2rnLQ1QCJ5n+BuV5kTNNVBoKPrAn4FgItIWUm0tUxf1uY
	 /cDDieYDHk44w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] splice: always fsnotify_access(in), fsnotify_modify(out) on success
Date: Wed, 11 Nov 2026 10:58:56 -0500
Message-ID: <20261111155849.2761399-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111155849.2761399-1-sashal@kernel.org>
References: <20261107061356-failed-5.15-79b496ebe382@kernel.org>
 <20261111155849.2761399-1-sashal@kernel.org>
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
index b939b101fd832..70008e08998f5 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1081,10 +1081,8 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
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
@@ -1109,18 +1107,11 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
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
@@ -1136,18 +1127,25 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 
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

