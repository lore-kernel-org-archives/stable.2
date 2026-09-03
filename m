Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908774AF9DF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443195; cv=none; b=pHsIlP6Xja37HteqT3HInCebKAxNj9e47CBB6ZwxCgtvmFpruBdTDokKCUTerPheKJZpxbgt2/CP7I5kpHPvDe7R2GzOPciPvCKRHVfhLtagL8ChHXHekHRUlsMZZLaOlElKQ8sQm+qVqp/62Oy7JmW4mM3Rey1cWwlTWKl85S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443195; c=relaxed/simple;
	bh=FENan/nchL6s8C2CgXYNhIqn8ximuEzj9PiyNz7/iv0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vFEL/SLdl87OIE6EEWgaKIvN2HbXErhCkBM7GVSJ4xB8xennBlW1UZLP6WTgzWVlbfr0TzIP4NUiIYPs9mvyZhQw13Q+UivuTCGmhgwv0ZPZTot5vKrneGmILtIpcRCNZOqwJU7AVJvcE1p5CyE8JaVp0IHqcDERjXrAKc6V1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yWzpEZrY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yWzpEZrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D5B1F00ACA;
	Thu,  3 Sep 2026 13:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443188;
	bh=rtZ8gcEAlYsgACkeQ8kffD31Cl5OY4syeRnhYPXFfBE=;
	h=Subject:To:Cc:From:Date;
	b=yWzpEZrY0+BO3cNg5mLOKxaiwh1xmc6dnhFQ8ZZdwRGPxyYneAzZsbsX/WpHB12xM
	 dOm8j1xgCp+1tT39e8nRtoVAz5U/zu4CmnjAHZeckEAPPl+1s+BsQWWFnZ2vFwLlEl
	 OPPXFbb0rnHtoFPCtUok37yN74uFKwolJoGCLjgY=
Subject: FAILED: patch "[PATCH] ceph: bound copied dentry name length in NFS export get_name" failed to apply to 6.1-stable tree
To: michael.bommarito@gmail.com,idryomov@gmail.com,slava@dubeyko.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:22:17 +0200
Message-ID: <2026090317-designing-flagstone-ad4f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x eff8013c5a8916613c742ae5a2cc341cb605c0ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090317-designing-flagstone-ad4f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eff8013c5a8916613c742ae5a2cc341cb605c0ae Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 11 Jul 2026 11:07:05 -0400
Subject: [PATCH] ceph: bound copied dentry name length in NFS export get_name

ceph_get_name() copies the MDS-supplied name into the caller's
NAME_MAX-sized buffer with memcpy(name, rinfo->dname, rinfo->dname_len)
and then writes name[rinfo->dname_len] = 0, without checking dname_len
against NAME_MAX. A malicious or buggy MDS that returns a LOOKUPNAME reply
with dname_len > NAME_MAX overflows the buffer. __get_snap_name() copies
rde->name / rde->name_len the same unchecked way.

Impact: a malicious or compromised Ceph MDS overflows the NAME_MAX name
buffer in a client's NFS-export get_name path, a slab out-of-bounds write
reported by KASAN. Reachable when a CephFS mount is re-exported over NFS.

Add ceph_export_copy_name(), which rejects lengths above NAME_MAX with
-ENAMETOOLONG before the copy, and use it in both ceph_get_name() and
__get_snap_name().

Cc: stable@vger.kernel.org
Fixes: 19913b4eac4a ("ceph: add get_name() NFS export callback")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index b2f2af104679..debb9634b9e3 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -442,6 +442,16 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 	return dentry;
 }
 
+static int ceph_export_copy_name(char *name, const char *src, u32 len)
+{
+	if (len > NAME_MAX)
+		return -ENAMETOOLONG;
+
+	memcpy(name, src, len);
+	name[len] = '\0';
+	return 0;
+}
+
 static int __get_snap_name(struct dentry *parent, char *name,
 			   struct dentry *child)
 {
@@ -513,9 +523,8 @@ static int __get_snap_name(struct dentry *parent, char *name,
 			BUG_ON(!rde->inode.in);
 			if (ceph_snap(inode) ==
 			    le64_to_cpu(rde->inode.in->snapid)) {
-				memcpy(name, rde->name, rde->name_len);
-				name[rde->name_len] = '\0';
-				err = 0;
+				err = ceph_export_copy_name(name, rde->name,
+							    rde->name_len);
 				goto out;
 			}
 		}
@@ -580,8 +589,8 @@ static int ceph_get_name(struct dentry *parent, char *name,
 
 	rinfo = &req->r_reply_info;
 	if (!IS_ENCRYPTED(dir)) {
-		memcpy(name, rinfo->dname, rinfo->dname_len);
-		name[rinfo->dname_len] = 0;
+		err = ceph_export_copy_name(name, rinfo->dname,
+					    rinfo->dname_len);
 	} else {
 		struct fscrypt_str oname = FSTR_INIT(NULL, 0);
 		struct ceph_fname fname = { .dir	= dir,
@@ -595,10 +604,9 @@ static int ceph_get_name(struct dentry *parent, char *name,
 			goto out;
 
 		err = ceph_fname_to_usr(&fname, NULL, &oname, NULL);
-		if (!err) {
-			memcpy(name, oname.name, oname.len);
-			name[oname.len] = 0;
-		}
+		if (!err)
+			err = ceph_export_copy_name(name, oname.name,
+						    oname.len);
 		ceph_fname_free_buffer(dir, &oname);
 	}
 out:

