Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF594C6522
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577360; cv=none; b=Y1gd7RaIxlP1dVEJBPc3hQe2Md7prHoZtQSdcMV9ys+vSaYjreRqu4oOUJtt9McwVKFlR6c3kb3OCHnojE612ZQIhSf5HLgTHxA0f1204YQJFbDa8uwoPr/OtmwmQG+GLCz5D9Zaq7aR9qWGjJb1T5hbA7DS4oD6iFXNtryDN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577360; c=relaxed/simple;
	bh=vtecw5NKXu8gBddpvZ1Gf+rVJv3yrh/gZ6kveDQOrUw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LVtkI0g3xoyzNKTC5O38IBTg8+DPaOc9f0h/nE2aNgqq/pMaJT0LCqVAL9N9lHqae/KswYHBNwkztlhO5tK0FLXZCHxce8tyzw9KJErD861tYxsvpVz3pZwiP/qhCz7bs3pZetsdvkb2qxoE/gsPP2JEcYA/AM9CApaOX44MERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ib/i18CX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ib/i18CX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8681F00893;
	Wed, 16 Sep 2026 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577357;
	bh=NXQyQcFGi5V/X/yjgu/54nxzxuP6ZcNGbOeYJFS8c1g=;
	h=Subject:To:Cc:From:Date;
	b=Ib/i18CXvACKTsy9FQOwap3BfHT8e5jCoBMff2klBqt3sDwdcsNUCNP2u9RMYvQLx
	 qLfr4Y5VbZAz0Tl52NgYGC5suCQUrr4/3h2371CGvRkH2uoP2Nzz7N2ptbDvTlvONQ
	 xBB0RetcQ3o/6Bz71nFXECke/xdorq3SsZbLJ7lU=
Subject: FAILED: patch "[PATCH] smb: client: fix file type corruption in" failed to apply to 5.15-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:43:45 +0100
Message-ID: <2026091645-lip-thinness-9a03@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 65d5dbdc089be42fc48a6f77bc6b648307f34b17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091645-lip-thinness-9a03@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

