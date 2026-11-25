Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603122;
	b=06SY4P2EPYsQCERKdij94EvhzgemZg/V59VYP6i17IqrvMfRI1srA55b9AfnAPYiFNN3
	 dsPIP7ppccYBozpQRQ840nHnd2++iKH3IxTz7z8L5Df+B2OOqsl1He8Tc4aYpBP+Oc0Vu
	 GlIHtwcrp28xJB+O2GtYwLW5nXI8i9h+Cv2OVtOARi7JWRos9I8VL9LI2e5qDBFV3FFXE
	 n7e9B1VRjmX7JfTifSBlVCrTHtkuVeIa0SSOKTigMMajsfTqqcglnyIY/WDCwiKOeB/PA
	 ga8rX7vPtlUe2TpmFZV1MX/gJaUYRkNHRIdTgSnjZtPNJa/ZziZVPqkfANLQssGakGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603122;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0N1fqsSH85C82K6ygptKAcBhm0nBS+emOplNXFLCWAY=;
	b=t+MAtIEb0IX3sfVdV2GPK9xmKqF2Y5h74FmhyEZqw2fvqAUm/RHeoBFDV3qklcEY+xS0
	 039uAuAGPNKrxTYwsU34cOYrBnS1/uZWNAFleirqkkRL6SOG+ZkQJIw16ehZnasUYgvAO
	 Lkcl3SiOCHqEjN06/jSO6u1E8xEOiwGMLF1JvxnY3tA4rhCx1VpFymIOd5a9D3PLMdXT2
	 +mzZL6SFzeXALIVF/Vi3Ba3IdrVRNqzUmxDA8oMZdKP8EjDMw66A6LVEfhfgRaiUdZJlc
	 mmjBbm6SGvMJcFFlVkYkVQRPU+PBNL45ifD7bMsdLUnNc27nrzUgsngBoCYviuAF0kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YHKiJL5E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FC606A339
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YHKiJL5E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9EA1F000D8;
	Wed, 25 Nov 2026 10:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603122;
	bh=0N1fqsSH85C82K6ygptKAcBhm0nBS+emOplNXFLCWAY=;
	h=Subject:To:Cc:From:Date;
	b=YHKiJL5EnxrlYMHoayIkNxxLVBb5ljF+4Li8WQTIJ1Xwtg1VTUueU2NdCZcuflDJk
	 lYsOR1/D/z86WU1zXE6yK/RcXHXtvqFyfe+aHJj/gbr2y2d92IO6LkfiAUL6TatQW4
	 ceGxL2N7vqvX0Pweq6luncyNv3+Xu2A6D9Foc36Y=
Subject: FAILED: patch "[PATCH] ksmbd: refuse to read a handle that is not open for reading" failed to apply to 6.18-stable tree
To: wahidzk0091@gmail.com,icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:26:25 +0100
Message-ID: <2026112525-parole-barometer-3f2f@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2fd145f8865bb1a6c38a3dc68fa44290008789d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112525-parole-barometer-3f2f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 

