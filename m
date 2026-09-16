Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD24B826D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577361; cv=none; b=OZ8xq5+WdAmSrGT7V4vyp5RM2VH1FxY1V/i49/5x3cc4bGUBwDDaQ47WGIQ2SkEQh5cypvyDmkXlBWkZf1qR+QSrQwpKDAdbbjhVyK+s9RKQBYmyjMkmIACG4DGzZo5YMYsK0rvcNvvfDCX75LamDp62ZiHIT9Qfci9h+IDMNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577361; c=relaxed/simple;
	bh=N3MYbi/3Vx5110nPOS6wJ1VtHYa27Qz5M1gLRgyZQ7w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ntxAhio1vdfJySE8cn3lYWH/RcVwsVkyCT2R41276pjLGo/aEUs0taNDkRwJCEsGFmzFL8ZXR2rLxxXDMOG0tDfQmRY5wT7Yka6xbHQYaMfunTd0ReNi7uPCIzbE4ydcowWen+GMI2yDWynkDZxcn3Fsi12Xmcc4Rhwe0HniR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iXalRnY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iXalRnY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0261F00898;
	Wed, 16 Sep 2026 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577354;
	bh=BDNM0cgXcWGeWQ/aydiXPOrYiU6B9Y2bDQgWf4atfSY=;
	h=Subject:To:Cc:From:Date;
	b=iXalRnY3HUcUYLI200TNXCJGD7vmLTJ2bIC8Y4B0jP5y5zP/pUa+1knFul0bWG0jb
	 Dyr+slRPBnO60ouFdmSzz+8SAc2UT4H5eIcB1/foGMskY3+CM88A++ZJi9gDtYaBIE
	 aXHcr3n4EYuPcVDF0q3hS27TJQIE3MURv64h7oG4=
Subject: FAILED: patch "[PATCH] smb: client: fix file type corruption in" failed to apply to 5.10-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:43:45 +0100
Message-ID: <2026091645-securely-gory-bc5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 65d5dbdc089be42fc48a6f77bc6b648307f34b17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091645-securely-gory-bc5b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65d5dbdc089be42fc48a6f77bc6b648307f34b17 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 6 Sep 2026 16:01:16 -0300
Subject: [PATCH] smb: client: fix file type corruption in
 posix_reparse_to_fattr()

Setting the file type in cf_mode without clearing the existing S_IFMT
bits first is wrong as it corrupts the file type when cf_mode already
has type bits set (e.g. S_IFREG | S_IFCHR == S_IFLNK).

Use a local ftype variable to collect the new file type and apply it
after validation succeeds, clearing S_IFMT and setting the new type in
a single assignment.  This avoids stripping cf_mode on malformed
reparse points where the function returns false early.

Closes: https://sashiko.dev/#/patchset/20260906172005.627163-1-pc%40manguebit.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 8a19dee564b8..616ca2dbfac4 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -1212,6 +1212,7 @@ static bool posix_reparse_to_fattr(struct cifs_sb_info *cifs_sb,
 				   struct cifs_open_info_data *data)
 {
 	struct reparse_nfs_data_buffer *buf = (struct reparse_nfs_data_buffer *)data->reparse.buf;
+	umode_t ftype;
 
 	if (buf == NULL)
 		return true;
@@ -1227,7 +1228,7 @@ static bool posix_reparse_to_fattr(struct cifs_sb_info *cifs_sb,
 			WARN_ON_ONCE(1);
 			return false;
 		}
-		fattr->cf_mode |= S_IFCHR;
+		ftype = S_IFCHR;
 		fattr->cf_rdev = reparse_mkdev(buf->DataBuffer);
 		break;
 	case NFS_SPECFILE_BLK:
@@ -1235,22 +1236,23 @@ static bool posix_reparse_to_fattr(struct cifs_sb_info *cifs_sb,
 			WARN_ON_ONCE(1);
 			return false;
 		}
-		fattr->cf_mode |= S_IFBLK;
+		ftype = S_IFBLK;
 		fattr->cf_rdev = reparse_mkdev(buf->DataBuffer);
 		break;
 	case NFS_SPECFILE_FIFO:
-		fattr->cf_mode |= S_IFIFO;
+		ftype = S_IFIFO;
 		break;
 	case NFS_SPECFILE_SOCK:
-		fattr->cf_mode |= S_IFSOCK;
+		ftype = S_IFSOCK;
 		break;
 	case NFS_SPECFILE_LNK:
-		fattr->cf_mode |= S_IFLNK;
+		ftype = S_IFLNK;
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		return false;
 	}
+	fattr->cf_mode = (fattr->cf_mode & ~S_IFMT) | ftype;
 	return true;
 }
 

