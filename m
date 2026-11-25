Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603125;
	b=P6h4AFI/bRfpLWAS+NYlDuv6yz+1Gl2cgXh8ofLWF3h+tz+fnr5KD4pNa49ZmUf2cwj9
	 U60x3bfLSmIvog2JzCEYQVySmhn+jFvsRhgAa2pOzMxiVulccj2DBfZU8s8OAdc1wJS8u
	 0M11O3jc9S0/1YoAIBfsV2z0UTuJ4mT3aJoPJR7i98V5LQJAQJc0ho8MDaBQrAvpHObm6
	 49E2UalSjCUO2PzxZWiCcQJWbJwwIsCgejPqPv/YCfvUSFz/vL0HS6KS7wFHAOeqyCgsB
	 VDxpJjcwGXkk+NwNgbrMHqjmRQCiPaSdVVFD1X3oH6E9nIH8g/Z+sOdcMo88mbIaXzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603125;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WKtV2wsnwg15Cjzrwi8C80afM2hLNQ7TuNOnL8QFzS4=;
	b=Z3Fs/klQtxonvCgbbCrLyFYFFOBLYRbFKJYzhf1l2M6c6CqpIZl4mS1K1tgUquNh0iTK
	 CskpAGQedmwqz0Oz97ryNZeKZ4+ASvfPH01XGBS9ScMOmE1SFv6Dpmc8eda+3TNQBv9/W
	 7aN0+gFZRebNnLFyWLoMVFALAHY5oyiJEVbaQ8jWhcElWhCCzzChaLds8xA/Aq8Zn17RE
	 MPieKYm5BbFMM4/LGnZ9IHaA/YNjT1IDo3wwc2yS5lWa0NKLW538q28IIBZUhnzyEePp/
	 FCJYh7tDldId8LHpG16Jrqx2KXqsxuDYfq9ENY+y80lsmFnbvJdautnSGYi7VavpI/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SoO3haD0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F9606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SoO3haD0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125231F000D8;
	Wed, 25 Nov 2026 10:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603125;
	bh=WKtV2wsnwg15Cjzrwi8C80afM2hLNQ7TuNOnL8QFzS4=;
	h=Subject:To:Cc:From:Date;
	b=SoO3haD0WkGEMVVQEVZ+2D8acsbit63lr2xnJx/fN2ZUl4dxLjU2mNsVqecn9mg0r
	 gNnn6NLhYJAT4WEUACs2zw2aSQvlPmstiNEOaPBI8/7y5dbFj5HaBSrxXbaxmrGUWu
	 TU6eBiFi2+bN/iRJOD9G32NYUU4OuzR4hr0besaA=
Subject: FAILED: patch "[PATCH] ksmbd: refuse to read a handle that is not open for reading" failed to apply to 5.15-stable tree
To: wahidzk0091@gmail.com,icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:26:26 +0100
Message-ID: <2026112526-surviving-carpool-9331@gregkh>
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
git cherry-pick -x 2fd145f8865bb1a6c38a3dc68fa44290008789d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112526-surviving-carpool-9331@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

