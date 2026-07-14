Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441648B37D
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040624; cv=none; b=ZDR/phNGNFuh6d8+u+LvZIvSPscT9/n7dQgA2SHiCslJ51JxOWEoEjbrG4XYAKEFwM7SqhHhMojqpY8SibpepNV1Mo/cWE3O43LNnBrX2VnbqyPSCNQEFIcdJ5bBIR5AdaMnt7G6xPAwMzCqpAu4gVP8O632sWWvDSvpxmswiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040624; c=relaxed/simple;
	bh=mqOkg2V8YAwJ46iVR74tx3XYDjEIYxYe7mx7/Y+aGcE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fk1n8I2fQQo0pkk5Ap0Cx8xe06H1lprfOXGG/dk8KQ5dfBAjTHxTZ475u4rR3e/AVUzqP7E98SGCzim3q3f+7M2/I+KfSPbkNPqETDL6X0eaAk3c3Vd18kMP5CdxYDSfYUe33m9HUiYcsSN54kQ/nn5ftHRc+ngTkhBV6VlkbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JhvIG0PB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JhvIG0PB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C1F1F00A3A;
	Tue, 14 Jul 2026 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040620;
	bh=x6zSNu72+ff8o2YnZ5t/j2d7PaOplG6gZvS0Nl5GJmk=;
	h=Subject:To:Cc:From:Date;
	b=JhvIG0PBiK4VOjIaLm8vePAmziyd++P1ZQlvQgVjCHIVefFtJ1bHU+S7ADPy+TjE8
	 xtWDmRuhqnjprHp1Z7LX0WLmb/e9kT4kxf4bFw/xxX4POwAwqIRYbaPLVPliUZEhPt
	 +2/9ysnXspZsmgAn9v/4+UDhCg67Nd9mkQ4bpshY=
Subject: FAILED: patch "[PATCH] smb/server: do not require delete access for non-replacing" failed to apply to 6.6-stable tree
To: chenxiaosong@kylinos.cn,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:47:08 +0200
Message-ID: <2026071408-outclass-pacifier-ecb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 851ed9e09639e0daf79a506ce26097b296ed5518
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071408-outclass-pacifier-ecb7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

