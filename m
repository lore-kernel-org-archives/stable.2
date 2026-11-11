Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414000;
	b=j2RRUxpJYBZXcArLakwaUkny5SEAkMefnajcW/xCfFKYxV1TCjzRfDfi1oBnfwiZ7FMj
	 WG9JjEA/sDyPBibI7ucvNYAigjpseqbgN7aadmfDV4GElOVRvmeufIiKlWSCeQqDNAn5C
	 Z2rhHWHm6wKVRBi6sWnGuvnhe9GTt7Nw1wdEgRl8OO0DCq7/+TnuoH89XfvuNuQYtzjgN
	 3KeTMLw2PR0KKfN8uKpSFz43Z+kpihB2GZXHoXPT71EBpTi9gekQnYF2GVoqiKi7b7/16
	 gNqAd96HjXVPLRcrfZSVGamO2Q+goVRHIYvB+Bg6ZWNbsb81AaOcjCKYeq7G75Hu4yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414000;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vVNJQiodcJI4f/sVySwCkeCVNfceD3y6SNGFYOmaZvI=;
	b=krWPzKaUXrzZuMb1Mg7tge71dmR4rNywoOsyBr+8v0Dq8fpIrgY0Un9KgWvVTm7u4aEc
	 EzMtVAahU+M0J2c+9W142RFyHKhkkmCsxPUXXf3oxv2HCCZOndW7fqynq54zN9JFxBGao
	 bt3HhLw1nJVWg//WlmC33JHJrlAkiXvZeW+Dd4S/+uuFjZId7vPG8YA7sMs0CRxGcxWDS
	 /HL3nVa+eQ/bKtdrqA/vmZ376YHfckM+BzfBtGCoWRd1bBa2o0tYIH5Pk1uBWe0VAUIgN
	 Wviyw+sVSkQEg/Px+1cjgdQkxwa/00abZ6Q8QEPI179fnOqS1SKs37j7o+W368uhPXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDMmMlce;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F860A263C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDMmMlce
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C47B1F00A05;
	Wed, 11 Nov 2026 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414000;
	bh=vVNJQiodcJI4f/sVySwCkeCVNfceD3y6SNGFYOmaZvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VDMmMlceaYef7L4xxFSnHhl0vbJFccg0RJDtKVZ1m0gNalbBQEedkohfBYdeTWYsN
	 rRGMRzgDRAGVwdajqntB3JsbUKc6pt7gbjAnfIhMHfnBm5QIdCfp6nICPke9bGoPVz
	 +LwHyCPpukUTPhYcTZemMnjjwomnIQU4w5Rp75RXxpwtx4rlLklfjGNNA9tjjW75kd
	 loUnMXunDr6+NUQYKwyjbTRsAR8rENy+XrBI1Lf5Q+BRAVc0CACNcNKJLVAa/raE8K
	 A6XmsUx1oXK1PPRMOZUxUa3JOXYSaEw1sfZ0gEJZAJ5xs05BXmmD6xy1vscVxq2Ruf
	 W4c/d1IBP1/4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] splice: always fsnotify_access(in), fsnotify_modify(out) on success
Date: Wed, 11 Nov 2026 11:19:55 -0500
Message-ID: <20261111161949.3187571-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161949.3187571-1-sashal@kernel.org>
References: <20261107063106-failed-5.10-79b496ebe382@kernel.org>
 <20261111161949.3187571-1-sashal@kernel.org>
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
index c4d3ac181a9f6..a11d5ab38ca63 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1052,10 +1052,8 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
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
@@ -1080,18 +1078,11 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
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
@@ -1107,18 +1098,25 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 
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

