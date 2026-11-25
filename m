Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603116;
	b=fURG0R+vax8mdefu2WxTwLLc0ha8R0uxBZoy50MW2UJ202E4Bjf8u6fzhvGUcIWQrBPp
	 Z5PKJqAilDdS0pxUw6yXgUDn7ASkuNy+X9xytECZ5nv4MYomyGZgXWsRir8I2U1CivV83
	 e0d7Ze3eCSQVfrKjCKzoGiAL9Z8IYidibfw5p81VIgRvhyEuTXPks/IIWE6Xq/ARr9mc8
	 zg2yBYRSIFU4+nS++tNY5R6tpF1K3ryhBNb8yDC0q2vWrc3FGGRRXRMayEuYbxhTsj0OO
	 f+dhkWCMokErHaPA5mAVnivodDgw5SjfBWdUW8XMJVAHNWOa496VZ5iH3vEIpFsmnsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603116;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G6TAWIPop1V/U+KsGG2lNkefhzwQMqSIz4eWZazWg3E=;
	b=rZf3SD/Cq+o9P+SY3hAsi9R2FyulLbij3rvMbFru4P3OpspiLgQXvABoRxLkZT/UAuFH
	 NE5fksgCP/I2P4Aefo3kUbeCZ0d2DUpvqzBiXMpj9atJ7w8p+f9ktEEah60pqJrjHZjOK
	 GrFx12oGa+FzYRCoRSyXSD4b69f5tYsbz3Gpozo60k/qLoMmtWdYtMndEnRSa7iqLOCKf
	 bDoX41XBI36GL9xD/Cj3G+DHhrMRHoZhzdhi9Xhdg52FwnWUDIAyJqKK2vUCAwwCy7Z/Y
	 nQve/VXeEcobJmDGgOwkWmIk6WslmkDu/vrjeK0/ZChPxKZgw0NTv50y8wGqYA4kWKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nOG272PN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51155606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nOG272PN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F261F000C0;
	Wed, 25 Nov 2026 10:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603115;
	bh=G6TAWIPop1V/U+KsGG2lNkefhzwQMqSIz4eWZazWg3E=;
	h=Subject:To:Cc:From:Date;
	b=nOG272PNxggLHLA5BwkTnCPUiAZxHln5EGuWHuySS9ysf12rWEafEL6zAKOFcUv4i
	 ijHwc8fh1Aj30KksoGfC+B1tcxPuwyRGk0bUcFE5INsBv9IGF3YEvmOyk/dU20yogB
	 d8YVi/CiPiHrDcP0VJpTnLLvvenmzqxvyI2fJXok=
Subject: FAILED: patch "[PATCH] ksmbd: refuse to read a handle that is not open for reading" failed to apply to 6.12-stable tree
To: wahidzk0091@gmail.com,icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:26:25 +0100
Message-ID: <2026112525-gambling-extended-40d8@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2fd145f8865bb1a6c38a3dc68fa44290008789d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112525-gambling-extended-40d8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 

