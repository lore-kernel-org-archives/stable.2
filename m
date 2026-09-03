Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE5B32B102
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429378; cv=none; b=PdYqmxhnMtt8ks8UwYoxQrvR4UsuCImrNu48sXn5gfPvb1jILcs4ewJEErvo9PcLPSg7gtggPye9sjQSrqUfiVWcIj5lf52h800xp9ZPMtaabOKn32v6X+fQC6i4We1leQZAQAtQKAmkz0Sn5I9gX0JEgtJi6VSzXzMXaS20fC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429378; c=relaxed/simple;
	bh=vxSxyl57s6BVDpS22ZNT/uCbGkC/rQXTRAUl67Lc+qg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JXrBfR9dUf6vCJYlDxEWkveOHXhMKpKp3hJ3p5cVUONb8XiDAizyVGmh00CzBN87w48Lz6XPmisCSHuBS3GZFeEeNyHiT2pQCJQhmoPbTOJhfJs48rP2tdLQ7K84cjy1995uBFoISLfIAminbhjuLO+9apImqw3U+sZvgaf/1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NhLXTPHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NhLXTPHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D879A1F000E9;
	Thu,  3 Sep 2026 09:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788429376;
	bh=h/Qh00440DZseG2ViP+I0iIjkX7VUlOchL1Zqx16sbY=;
	h=Subject:To:Cc:From:Date;
	b=NhLXTPHIuV7LD4LnOgsdfRqEobKXVq0G+lc2ct4ne4drL00e6czWHju5/0q8wDFv0
	 djnIIp+Scc1pf6mxrmVegAYmZxD6FAqrckYbbdMTtESReB6ZYuc0foZTyPCGRFdEwa
	 pL2nGDmtsQeponCSjKRcY6jR+nUhopQHSwch/N3c=
Subject: FAILED: patch "[PATCH] fs: fix user path of nested backing files" failed to apply to 6.6-stable tree
To: libaokun@linux.alibaba.com,brauner@kernel.org,paul@paul-moore.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 11:56:11 +0200
Message-ID: <2026090311-aloft-bonfire-75ad@gregkh>
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
git cherry-pick -x f2381b546e7e6a35c9fcee0d0ccb6c042a9aeb5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090311-aloft-bonfire-75ad@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2381b546e7e6a35c9fcee0d0ccb6c042a9aeb5d Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun@linux.alibaba.com>
Date: Tue, 4 Aug 2026 11:42:04 +0800
Subject: [PATCH] fs: fix user path of nested backing files

backing_file_open() derives the path to be stored in the new backing
file from user_file->f_path.  This is incorrect when user_file itself
is a backing file, which is the case for nested stacking filesystems,
e.g. overlayfs mounts where the lowerdir of one overlayfs is the merged
directory of another.  Since commit def3ae83da02 ("fs: store real path
instead of fake path in backing file f_path") the f_path of a backing
file holds the real path of the intermediate layer, not the path that
the user opened.

Commit 924577e4f6ca ("ovl: Fix nested backing file paths") fixed this
for such configurations by passing file_user_path() from
ovl_open_realfile().  However, commit 6af36aeb147a ("lsm: add
backing_file LSM hooks") changed the first argument of
backing_file_open() from the user path back to the user file and
derived the path from user_file->f_path again, silently re-introducing
the problem.

As a result, files mapped through a nested overlayfs show the wrong
path in /proc/<pid>/maps and in perf/ftrace mmap records.  For example,
with two nested overlayfs mounts:

  mkdir -p /ovl/{lower,upper,work,merged} /ovl/nested
  echo hello > /ovl/lower/foo
  mount -t overlay overlay \
	-o lowerdir=/ovl/lower,upperdir=/ovl/upper,workdir=/ovl/work \
	/ovl/merged
  # at least two lowerdirs are needed when upperdir is nonexistent
  mount -t overlay overlay \
	-o lowerdir=/ovl/merged:/ovl/lower /ovl/nested

mapping /ovl/nested/foo shows a disconnected path instead of the user
path:

  # readlink /proc/self/fd/3
  /ovl/nested/foo
  # grep foo /proc/self/maps
  7f6e2c100000-7f6e2c101000 r--s 00000000 00:24 15813027 /foo

The bogus path is derived from the f_path of the intermediate backing
file, whose mount is a private clone that d_path() cannot resolve.

Fix this by using file_user_path(), which returns the outermost
user-visible path for backing files and falls back to
&user_file->f_path for regular files.  This restores the behavior of
commit 924577e4f6ca ("ovl: Fix nested backing file paths") for
overlayfs and also fixes the same problem for the other
backing_file_open() callers, fuse passthrough and erofs ishare, when
their user file is itself a backing file.

backing_tmpfile_open() has the same pattern but is not affected: it is
only called by ovl_create_tmpfile() for the upper layer, and another
overlayfs is rejected as upperdir by the DCACHE_OP_REAL check in
ovl_mount_dir_check(), so its user_file can never be a backing file.

Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
Cc: stable@vger.kernel.org
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
Link: https://patch.msgid.link/20260804034204.3487077-1-libaokun@linux.alibaba.com
Tested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 080c99696cd0..cc101143f921 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -35,7 +35,7 @@ struct file *backing_file_open(const struct file *user_file, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred)
 {
-	const struct path *user_path = &user_file->f_path;
+	const struct path *user_path = file_user_path(user_file);
 	struct file *f;
 	int error;
 

