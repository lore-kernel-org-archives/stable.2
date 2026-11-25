Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603119;
	b=ovxYhnDfUuhdUwXUHDx8Rq+0aorvK7eEmYY7XHQ/FxMQAQXzRDAy6XOSveaGDCl4DO4W
	 2e79aKAN3N918Z0AjMzCtX/mPgH7m8g6JMgy9ZnC9k1BDC90sY1+WtVYtGMiylSw6xZ9w
	 K3pTGAVSNRJvOSr7QC67fqutPAOX1D+kCFj1fMsO0CCA67lEe0+WNMXy9mKfr1eYQPOwU
	 xtps2Qq3o2nOZrkvXWToLWcSaIa5txGmEf0YOEiP4TdsP5GX14ejKLydZpktYVJ4zLkSX
	 +4+1Q5KYP41OdK756iNAhjSF+pGvi6kg6bGczMEwVhtrYzCm/cVtF7sF3YG3KnHU7jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603119;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zP6Vc2gLXeVD8llyzTVq3X8YfuQgDFh15GKdd6HhNzo=;
	b=WiSfvXWYvS+mNiMfML/OpqP7lICixMx92psZrcDueD/YWBB/9mxmEMSwVI3F1PtizQe5
	 Y0qFY2sDZ2egvf8EHat7Vx+IfVhNtQLVuKHF+WA6fWLMvVt/DjYLmhmOIv004n+2sRTcS
	 8uDGlnygF3PS7SFAKYhXG5ER3r/haOWIz+pjGAZnC3xXEaCl2jNmAYafq48e67cRYO0Mz
	 1kbXzoV9CyFywNZMTJ6UUEICIcdillFMcm8xoKAQSRWEzqzskCPJcETuNfeYx5ngtzAE1
	 2cPcjj/V2Lcwn7yfeNZjMCgEXTCLjYlFmu3gWAlMZC3KLFsB+uvORjWZwCnNd7t4g7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kK8BTZfx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B902606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kK8BTZfx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E9A1F000D1;
	Wed, 25 Nov 2026 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603119;
	bh=zP6Vc2gLXeVD8llyzTVq3X8YfuQgDFh15GKdd6HhNzo=;
	h=Subject:To:Cc:From:Date;
	b=kK8BTZfxM+iYbgJddI4jZbH8VuPyat9/qjD8fEqneyrUfSdaxy2TzyYRWhw1Zk5R2
	 vfhYh0rSLjbM9GbQmPUJXK+Ok5YP0dk/jDi8ydoArOZKSARLvIYWHTUkH+YXX0RtPJ
	 Nh6LZxgRRDHN3kDBMXXiyBla/tFYZV79rTt/9xZQ=
Subject: FAILED: patch "[PATCH] ksmbd: refuse to read a handle that is not open for reading" failed to apply to 6.6-stable tree
To: wahidzk0091@gmail.com,icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:26:25 +0100
Message-ID: <2026112525-paprika-cricket-1873@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2fd145f8865bb1a6c38a3dc68fa44290008789d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112525-paprika-cricket-1873@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

