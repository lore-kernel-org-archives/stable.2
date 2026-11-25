Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603129;
	b=j3tnK7zd+UwsiGbuUV4lqlwrODycPamKRyVNmadytp/ZTO3v0KoIgf0K1s9zhOq8bC5w
	 NLPg+u1HSlx3fqs8ax1pY3GL3BMlHHx1AGXuVwVolPRAG+bX9m13JyR7uuGl6JUSyywo2
	 Ze5n4vqUMpyggW3dQ1zoYycHtOUMgg2+diKKWfduQEr/CpiP4rUC3MERDyTbw3qAXCrhJ
	 YNSnzYSoUjPjWV2bE0/6sJ3YgDveSCirtm80SMB8yTopo7ku5MN5C8/sXIdH7Y2B4KpkB
	 I6YBRPY4J3SObYLyjVrUlHHKLFifKP3ZrxzjWm9IQAONpIYtC/onhK1lvu99K2FMh9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603129;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4g3V5BTMQ0kBq7iLP905ZhvZDpUT7y99Summf34XwfE=;
	b=UQnshS6HWtunkhLUyj6QxssZsB5KpHLfOwqstR2SPiC1XmEfPifjYyH2zXWFckfrFjes
	 RZq70UQDI2ckdYjKCyZjdgCt/C1eIb2a9qDU+6zhQbVZpDiKBPYIvvT3wCIunpjrx96EH
	 m4wz+b2pvxnbwEQR7auZyGveIcpwxtv5uedQTbEHmNrzn3cTDf/RdXF5qknHEiPUgi3xP
	 YjBWg8WvViiitD8Ov9IMiwPHIHn7jFNm0vOsOnSZcDGzRq5Q29NSKnvYSHoyfaDXxD1O5
	 KhogoWcDSuOBMOXX0rUbTr5GNFHUxXGN9S1CRh5Zk4Y9bWmCW2fVbeD5KUuQDGZxtyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="MM+bF/sJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C8606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MM+bF/sJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4211F000CA;
	Wed, 25 Nov 2026 10:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603128;
	bh=4g3V5BTMQ0kBq7iLP905ZhvZDpUT7y99Summf34XwfE=;
	h=Subject:To:Cc:From:Date;
	b=MM+bF/sJXg7fvL+6h423k+G7YRbBsZAeCa35CeVMRsHThRpizUqI4Kx08AHU+1Cgx
	 2Bwolle72RNfC8W3014BXESZBmjj6Um/cDv5Jj6nPx20eS6B2uzbl49x7A8Gx3pPuk
	 BbS+JTwX8BU3nQIrmzJbPa0IxU+azoFrxPu5+wOs=
Subject: FAILED: patch "[PATCH] ksmbd: refuse to read a handle that is not open for reading" failed to apply to 6.1-stable tree
To: wahidzk0091@gmail.com,icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:26:26 +0100
Message-ID: <2026112526-cider-posing-d58d@gregkh>
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
git cherry-pick -x 2fd145f8865bb1a6c38a3dc68fa44290008789d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112526-cider-posing-d58d@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2fd145f8865bb1a6c38a3dc68fa44290008789d8 Mon Sep 17 00:00:00 2001
From: Wahid Khan <wahidzk0091@gmail.com>
Date: Thu, 5 Nov 2026 23:08:38 +0530
Subject: [PATCH] ksmbd: refuse to read a handle that is not open for reading

smb2_create_open_flags() picks the open mode from the read and write
bits of the desired access. FILE_EXECUTE and FILE_READ_ATTRIBUTES select
neither, so a request for FILE_WRITE_DATA | FILE_EXECUTE |
FILE_READ_ATTRIBUTES opens the file O_WRONLY.

smb2_read() accepts FILE_READ_ATTRIBUTES and ksmbd_vfs_read() accepts
FILE_EXECUTE, so a later READ on that handle passes both checks and
reaches __kernel_read() on a file that has no FMODE_READ:

  WARNING: fs/read_write.c:518 at __kernel_read
   __kernel_read
   ksmbd_vfs_read
   smb2_read
   handle_ksmbd_work

Any client that can open a file with write access on a share, including
a guest session, can trigger it; with panic_on_warn it takes the machine
down.

Return STATUS_ACCESS_DENIED when the file is not readable.

Fixes: f44158485826 ("cifsd: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
Reviewed-by: Ian Bridges <icb@fastmail.org>
Tested-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 1f2bc76f0d09..cb3f4f5fe9cf 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -367,6 +367,10 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 	if (ksmbd_stream_fd(fp))
 		return ksmbd_vfs_stream_read(fp, rbuf, pos, count);
 
+	/* The access granted on open can include FILE_EXECUTE for a write-only file */
+	if (!(filp->f_mode & FMODE_READ))
+		return -EACCES;
+
 	if (!fp->is_posix_ctxt) {
 		int ret;
 

