Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701097;
	b=v5FasceXbrleOkZ4rdYwVnI7H6Os4mzvW7MrHbkG9XkduTw+ADKswMtAAOE0amZbUwZK
	 urb8lfGAyG3fTY1L99m17g0qgXE2/nmC6ijKjrVUQOycAwEvsByf2fK4xHGGwWHPMuHZr
	 wFX/rAgggLgHAOdlFk0gcx7wSoagOcuc8UMT15JamSR2aw0CmR/FmOvV9C5LowAKBggKC
	 ugh1KaMBFYpBJFIzF4y13zyc3I2+CCY/5J1PIDZHvV1M91Hl8JIFkl3x9acobPzY8Czqm
	 iu3ja9nmU5MxskzX+8vMurHGnm+lzw00yXaKJZaiSpY9mnDXdU9m9ygpXGmekUGb+VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701097;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=U2s5+5tlHMoCBaH+SbFetaHmzAB3z9Y5EvLGYLKWVLI=;
	b=rSBtIG6cEcIWfLfLl3Vb8A+CfJBimhWNdAua1SdkM+0NofyHYcfw6M/UeIuAMuOMb0sX
	 hUKVUdPOGbf1ZLQFG/cykPQMxsLGLSIVXoabj47TJ3mm/C3DslWt9rZFgLIY+5K5qGG+D
	 2N8pIomeHA+9l5/zdI6mSHok1OZbxStiWAwVmpLoV3HmDahmOI0crco8KvSFUcvB3zAGO
	 r4aQgv8aqw8n+bz728KSYMBGntRHGVAPtIuy/YKCDfHm7ZkYKvDMKar+8uPCRWTss68ZK
	 TOR7HghzwaT3ZUhdQtT4bQqL6JIAxQJ4TgOGu3CEAZQPgZBfRQgafKwnsibyS7Z63mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="PJL31b3/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B3606BF82
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PJL31b3/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22821F000C1;
	Tue,  3 Nov 2026 10:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701097;
	bh=U2s5+5tlHMoCBaH+SbFetaHmzAB3z9Y5EvLGYLKWVLI=;
	h=Subject:To:Cc:From:Date;
	b=PJL31b3/krOGB9O+1si5z4+NA3CWuewUse+GR70N1XGNj3UyM9FhnE+ItIibfgF/f
	 zR3l5KJLQRPsFzNEXDzhbhdDEzAtJnk1afIZct6Usu7/ZoaBaYODQleZaVV5udAwbR
	 uVXAAU3prB1SNj9YgiMPw7MkxWyhy8AhHptwQUvs=
Subject: FAILED: patch "[PATCH] ksmbd: preserve unreadable named streams on open" failed to apply to 5.15-stable tree
To: charsyam@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:18:15 +0100
Message-ID: <2026110315-jumbo-caliber-efb8@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 80c816c047f7cae3c99cc75740c1f5d2c4d97b45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110315-jumbo-caliber-efb8@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80c816c047f7cae3c99cc75740c1f5d2c4d97b45 Mon Sep 17 00:00:00 2001
From: DaeMyung Kang <charsyam@gmail.com>
Date: Fri, 9 Oct 2026 00:25:37 +0900
Subject: [PATCH] ksmbd: preserve unreadable named streams on open

A write-only client can open an existing named stream with FILE_OPEN_IF
without permission to read the underlying file. The case-insensitive
lookup finds the xattr name, but querying its value length then fails
with -EACCES. smb2_set_stream_name_xattr() treats every negative result
as a missing stream and replaces the existing xattr with an empty value.

A failed xattr list is not proof that the stream is absent either:
for example, -ENOMEM can lead to the same empty replacement. Preserve
listing errors and create a stream only for -ENOENT or -ENODATA. The
latter can occur if the xattr is removed between listing its name and
querying its value. Return other lookup errors without changing the
stream.

A write-only FILE_OPEN now reports access denied instead of name not
found. FILE_OVERWRITE_IF and FILE_SUPERSEDE on an unreadable stream
also fail instead of appearing to replace it. Stream writes and EOF
changes already need to read the old value, so such handles cannot
update the stream after opening either.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 79b0a9aee860..b57942263e13 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3420,6 +3420,8 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 				     xattr_stream_size, xattr_stream_name);
 	if (rc >= 0)
 		return 0;
+	if (rc != -ENOENT && rc != -ENODATA)
+		return rc;
 
 	if (fp->cdoption == FILE_OPEN_LE) {
 		if (!strcmp(stream_name, "AFP_AfpInfo") &&
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index eb0212e9a5f4..d21ed90454f9 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1962,7 +1962,11 @@ ssize_t ksmbd_vfs_casexattr_len(const struct mnt_idmap *idmap,
 	ssize_t value_len = -ENOENT, xattr_list_len;
 
 	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
-	if (xattr_list_len <= 0)
+	if (xattr_list_len < 0) {
+		value_len = xattr_list_len;
+		goto out;
+	}
+	if (!xattr_list_len)
 		goto out;
 
 	for (name = xattr_list; name - xattr_list < xattr_list_len;

