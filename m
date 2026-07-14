Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA84298CAB
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040625; cv=none; b=QitUjwyqqmsSkSmpjK6BZ513KV5bcy+PWZOOC95NSzgqPgNaI6UyKgHovia+AAOxkKqiqMe7xnLh1mzoKLC0P0MnSBCkq/+mY85xz0HIATxCWKPobwFCwMZqGHHJeLIicyHskejwZZwveoSIyIjAKvio8tv54zyP5/lfdpaUo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040625; c=relaxed/simple;
	bh=ceh+SZ8ZzMJuOKnkRNGAqOpAY+cFRHfb8CQWKFw8SW8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mHzHxpzVKXcYhWG0VE7UWJmwtVFuLM3XgFFuvGVSrhQ4Z+vVrj8euz2pvzDWRMqYM1GpnprQMTLZsuIP0XUyZFKSANHc1igJI0xlLwLsvloFI+kS8TkgRkDB9g/JrZ6/1s3VgFvbM0ufeSWcQGPN+iEZd0JK0nBzIk+PdHJRmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ou27CzQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ou27CzQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0738D1F00A3E;
	Tue, 14 Jul 2026 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040617;
	bh=/NILfgx/Fg73RD1Wan2zKppUzsPlKbx/KgsHmWBwH5I=;
	h=Subject:To:Cc:From:Date;
	b=Ou27CzQ/3s6+L7uXdAhmf33M9Lkocr3MwU7fEHHLex5iPWWrskBT7oPHG6wcpZgmU
	 6H8pfUfBEmk7cajzDtzsnLVFxM6zgABkvTQ4ye3Bx5UBnCKcmz7eDCYVV+DVBy6CD7
	 RHR/gGA5+i3jrQPSL+8OdqCDpt0H4RX/CkHlEbyc=
Subject: FAILED: patch "[PATCH] smb/server: do not require delete access for non-replacing" failed to apply to 6.12-stable tree
To: chenxiaosong@kylinos.cn,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:47:08 +0200
Message-ID: <2026071408-mortuary-smelting-096c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 851ed9e09639e0daf79a506ce26097b296ed5518
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071408-mortuary-smelting-096c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 851ed9e09639e0daf79a506ce26097b296ed5518 Mon Sep 17 00:00:00 2001
From: ChenXiaoSong <chenxiaosong@kylinos.cn>
Date: Sun, 28 Jun 2026 07:42:43 +0000
Subject: [PATCH] smb/server: do not require delete access for non-replacing
 links

Reproducer:

  1. server: systemctl start ksmbd
  2. client: mount -t cifs //${server_ip}/export /mnt
  3. client: touch /mnt/file; ln /mnt/file /mnt/hardlink
  4. client err log: ln: failed to create hard link 'hardlink' =>
     'file': Permission denied
  5. server err log: ksmbd: no right to delete : 0x80

Fixes: 13f3942f2bf4 ("ksmbd: add per-handle permission check to FILE_LINK_INFORMATION")
Cc: stable@vger.kernel.org
Reported-by: Steve French <stfrench@microsoft.com>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 727ba86ede36..097f51fc7ed6 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6921,16 +6921,18 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 	case FILE_LINK_INFORMATION:
 	{
-		if (!(fp->daccess & FILE_DELETE_LE)) {
-			pr_err("no right to delete : 0x%x\n", fp->daccess);
-			return -EACCES;
-		}
+		struct smb2_file_link_info *file_info;
 
 		if (buf_len < sizeof(struct smb2_file_link_info))
 			return -EMSGSIZE;
 
-		return smb2_create_link(work, work->tcon->share_conf,
-					(struct smb2_file_link_info *)buffer,
+		file_info = (struct smb2_file_link_info *)buffer;
+		if (file_info->ReplaceIfExists && !(fp->daccess & FILE_DELETE_LE)) {
+			pr_err("no right to delete : 0x%x\n", fp->daccess);
+			return -EACCES;
+		}
+
+		return smb2_create_link(work, work->tcon->share_conf, file_info,
 					buf_len, fp->filp,
 					work->conn->local_nls);
 	}

