Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701025;
	b=ch2fmuNUohd0RsC6ZfFryd6eY7iB1cdFExp0BCf0ZyFrE8vycitDUbM8HafUsnNQR8Uw
	 uxzcfKv6ep7K22XDbGCJ6b4aCsQocYQ/VQKdwhSo9BuSnidvvbfX3K6rnw1m67RIGIAF/
	 LfNMVyjaz/h8dWAgIJ8EUGrGaVSNLPaFGLb4tfXVTQnPeilawTTyw2aM9p7C9GX9qCOA9
	 zgL8N6Bf8Fv0mQoHQJ/riHGJbJWk+iBU5fPWEEdGbfjOGzMStSOdd0m5brH+wjv2joBZr
	 TJpHabdFtyNKy31llra9zTpeeQfAB/LsN02dMa9vIW92+dmzAvYcWZGht9++XCt1FKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701025;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sdE96IYUKW+wLkXiRF1pNaXyDUoPvrWI+JpUb7vYseU=;
	b=hAjKnAwnh8OZDMjhnX0tJQ+b3HanuI4Q6/T+O9N0DiDvvi6buud49I1WtRx/KNyVh9mH
	 4/zHhtlaWjuXsDHEVuPi9SJBicUOP217RDpw5uX+fbhvrlLvQdU7GsX1QpOh5kIHztPyi
	 UhJZv81zH9Ga/h7mwVPH2yYgGB/A4sSof7TNV2BaKviQrtaY8qcNeYRPh+YKZFG1mlGJC
	 ZF+b8gy4VNJrZzM4hj4MFpXu9E8jgz7EYkFyYFyFhL53DlLnLqAnLIHL59C5nQ7Lm8YST
	 2MewsJLbGcM8QmFndYaMdTmOjZgIRsSaCzRZpD+zT0cO294jt7FpvgKp6ttPGjI+GHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2lncoUTs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739A606B10B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2lncoUTs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD941F000C1;
	Tue,  3 Nov 2026 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701024;
	bh=sdE96IYUKW+wLkXiRF1pNaXyDUoPvrWI+JpUb7vYseU=;
	h=Subject:To:Cc:From:Date;
	b=2lncoUTs6Cs3PPO28P60B/2GCGcSltCEGVUeIGCWqmz+KKpIgdYkAy0noxFKfNWbs
	 0GPo1QFpl7rg5HSTcnL4tdBrzcxb0YPXhRybWO2c83gQWKe9DuxZODFpEHHukZetDw
	 SksS+xe3vJYfnRLHn/GBWQgzlBbd2HFyW18Wjwjo=
Subject: FAILED: patch "[PATCH] ksmbd: fix parent dentry lifetime in directory enumeration" failed to apply to 6.1-stable tree
To: cenzhang@linux.microsoft.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:17:03 +0100
Message-ID: <2026110303-stress-stardom-c27a@gregkh>
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
git cherry-pick -x 171df27077fb49b4af2c53ad2cedcd0e39664fe8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110303-stress-stardom-c27a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 171df27077fb49b4af2c53ad2cedcd0e39664fe8 Mon Sep 17 00:00:00 2001
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
Date: Thu, 22 Oct 2026 00:12:16 -0400
Subject: [PATCH] ksmbd: fix parent dentry lifetime in directory enumeration

ksmbd_populate_dot_dotdot_entries() builds the ".." entry from
the open directory's d_parent and passes that pointer to
ksmbd_vfs_fill_dentry_attrs() without taking a reference. That pointer
is only valid while the directory stays under this parent. If a
concurrent rename moves the directory elsewhere, the old parent loses
its last reference; a following rmdir then turns it into a negative
dentry with d_inode cleared, and after the RCU grace period the dentry
itself is freed. The worker still holds the raw pointer and
dereferences d_inode through vfs_getattr() and vfs_getxattr().

A remote SMB client, authenticated or guest, triggers this by listing
a directory while that directory is moved under a new parent and the
old parent is deleted. It can be done by the client itself with write
access or by other concurrent writers, triggering null-ptr-deref and
slab-use-after-free on a KASAN build.

  KASAN: null-ptr-deref in range
      [0x0000000000000000-0x0000000000000007]
  Workqueue: ksmbd-io handle_ksmbd_work
  RIP: 0010:xattr_permission+0x9d/0x160
  Call Trace:
   vfs_getxattr+0x9c/0x1b0
   ksmbd_vfs_getxattr+0x82/0x100
   ksmbd_vfs_get_dos_attrib_xattr+0x7f/0x130
   ksmbd_vfs_fill_dentry_attrs+0x435/0x650
   ksmbd_populate_dot_dotdot_entries+0x25e/0x630
   smb2_query_dir+0xcf9/0x1a20
   handle_ksmbd_work+0x5f1/0x1c80
   process_one_work+0x90b/0x19d0

Fix by using the dentry reference counting APIs: take the parent with
dget_parent(), take a matching dget() on ".", and dput() the dentry
once ksmbd_vfs_fill_dentry_attrs() has returned or the pattern does
not match.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Cc: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 7dbcfa658edd..f9fb3741ada3 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -478,16 +478,17 @@ int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
 			if (i == 0) {
 				d_info->name = ".";
 				d_info->name_len = 1;
-				dentry = dir->filp->f_path.dentry;
+				dentry = dget(dir->filp->f_path.dentry);
 			} else {
 				d_info->name = "..";
 				d_info->name_len = 2;
-				dentry = dir->filp->f_path.dentry->d_parent;
+				dentry = dget_parent(dir->filp->f_path.dentry);
 			}
 
 			if (!match_pattern(d_info->name, d_info->name_len,
 					   search_pattern)) {
 				dir->dot_dotdot[i] = 1;
+				dput(dentry);
 				continue;
 			}
 
@@ -496,6 +497,7 @@ int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
 							 idmap,
 							 dentry,
 							 &ksmbd_kstat);
+			dput(dentry);
 			if (rc)
 				break;
 

