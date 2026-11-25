Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603113;
	b=mxiZyR0E+z6UBCl0jW/Lm/b6yirHy4iVHAi37JXD4uGQiZEg+inzihidQiIzszWHI4WN
	 4XFDzIiTYXCo6fHJtq6cWSr460rN23I2DFB4sWChHqnK1tJ0jmzlcimOIbl/6jQz8heR4
	 mqn4vuptbWQ1yQ0BI9OlRUH/agQ3wRsB0Rp3+7gtMe5+R+wgMHJGVmqknCriW7779nelb
	 Q5m1eDgmxjoMr/+0R7pmuTEdpZWxKYTbPYeA9zUPCe96HV4MD8FuC8Wrf9lJdVXww8qwE
	 y1WIx3wPlYUrDJ26UuAKMB6t8Zmg9cuYnDLN6mi0Q5z4/TevcpqoMFPPewAn+MHkxpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603113;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=44nXhpxh85PdGT8ehDYyIr+spSK5wIQkQCzYKnGfgwU=;
	b=Y92e0p3nUL4UH+YPPwPHTQYUsfJ6CWddjE2yom1RsrH2kyFzBy3i3OhuX+8tB6poBPV8
	 6FUwzg5UfJ3OCZOLXviXXZRkIXDQAzLMabhY9LyGgeOYZihfNw9g9WIzG8Svw/i61YHXP
	 jF0Cp4prGC0RlcKwqC5qot8aCdWfNfWHfQg5zv2IYNdyaPoSjYhmAer3W7qIDefAzVgcA
	 Kzq7CntDStPFgIMsaxKaW96y80n9zFcA1nbWTtq21tKfPj5xqOe5ZWd/snUkKePhRYqdp
	 w6Y6MKWxQRcwz0zMUN+NKjzD/0K+bDtceBP0x2gIt56DzyI1W36islYLB7BjVSnao0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ajisYZGF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1482606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ajisYZGF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A1D1F000CF;
	Wed, 25 Nov 2026 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603112;
	bh=44nXhpxh85PdGT8ehDYyIr+spSK5wIQkQCzYKnGfgwU=;
	h=Subject:To:Cc:From:Date;
	b=ajisYZGFTkOwHCkA2Wh5/b1LJxeeSRQls6pJ24Plk3lVfgOKklxo1W1S/tpJbuPMg
	 5ZNlPGYldyKn350kZxIXXgm0enFlU9IG0tivp4nLiNP2ByONkdU2JoAKfLODAI/vUV
	 CXcGcYUvugVOarEm0b28b0HEiUXOq+BSezu9oBGk=
Subject: FAILED: patch "[PATCH] ksmbd: refuse to read a handle that is not open for reading" failed to apply to 7.3-stable tree
To: wahidzk0091@gmail.com,icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:26:24 +0100
Message-ID: <2026112524-enamel-landslide-2197@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 2fd145f8865bb1a6c38a3dc68fa44290008789d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112524-enamel-landslide-2197@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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
 

