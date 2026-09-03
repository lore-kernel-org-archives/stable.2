Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCA3F5BD7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429386; cv=none; b=mhGj5wWJ/NeypvHNRv2w6RSarG9NBokWzrq3EsjmLMfA1r29dezlCplcSfQ+NI2sYpPvnLxyqkYqyAifRbvvc8KXM/pxuZDR850bUmY1Hf1hdNxVoxrdObp516SG1sghgQp/+qx9dCp4+DjUfbVTng1EJu9poloxi1imdyVJcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429386; c=relaxed/simple;
	bh=hRuOLgXhB+WPMRAUf5/DJP08uvCSXwvBRuLFldgBs5I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OAsoJIsiHf5RnVfU2/0o7x0E53U6GCxRrLf7AvWuF0pSDjSymXajHnTb5/CxVrNQMKkgRaB/Md5RQBaz3/OTRlkdrQLpaBH71diS5voJi/yDhKerBMSvQSdFfSvVrXxRFYX+tpTGgy5aNGQGBO2kA6z3D2FbsmILLOlYBgiO+zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zsIzQFCn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zsIzQFCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5731F1F000E9;
	Thu,  3 Sep 2026 09:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788429384;
	bh=5KAjGdcFdapfg0Es6RRAB87zUjDrH5uwavE4g612KT8=;
	h=Subject:To:Cc:From:Date;
	b=zsIzQFCnweMxCDHtQL7PRtB3SX+0xUl8G3NaE8mt+5Qy9JBoZ2jLSeXt/rCNcuFPW
	 v1Jug1f7avqCBUsGh3325TB+pVfSO77ZNz1cDZfYjPLSEABL6VLb1+zJ/1DGrJQdzc
	 QU0t21hkXBN5pm/2B2pYw9Vloe0V8sr5KztMCR68=
Subject: FAILED: patch "[PATCH] ovl: fix double end_creating() on the casefold-mismatch path" failed to apply to 6.18-stable tree
To: vivek.parikh@breachx.ai,amir73il@gmail.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 11:56:19 +0200
Message-ID: <2026090319-clanking-sandstone-d89f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 077ab8985ee278c3d8618182d335b0f0cd919e16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090319-clanking-sandstone-d89f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 077ab8985ee278c3d8618182d335b0f0cd919e16 Mon Sep 17 00:00:00 2001
From: Vivek Parikh <vivek.parikh@breachx.ai>
Date: Wed, 5 Aug 2026 10:27:54 +0530
Subject: [PATCH] ovl: fix double end_creating() on the casefold-mismatch path

ovl_create_real() releases the new dentry twice when the casefold
consistency check fails.  The S_IFDIR branch calls end_creating() and
sets err, then falls through to the common out: label which calls
end_creating() on the same dentry again:

	case S_IFDIR:
		newdentry = ovl_do_mkdir(ofs, dir, newdentry, attr->mode);
		err = PTR_ERR_OR_ZERO(newdentry);
		if (!err && ofs->casefold != ovl_dentry_casefolded(newdentry)) {
			pr_warn_ratelimited(...);
			end_creating(newdentry);	/* first */
			err = -EINVAL;
		}
		break;
	...
	if (err)
		goto out;
	...
 out:
	if (err) {
		end_creating(newdentry);	/* second, same dentry */
		return ERR_PTR(err);
	}

end_creating() is end_dirop(), which does inode_unlock() on the parent
and dput() on the dentry, so the parent directory's i_rwsem is unlocked
twice and the dentry is put twice.  The second unlock releases a lock
that is not held, which is what wedges every later creation under that
parent, and the second dput() drops a reference that was never taken.

The branch was added by commit dfc7da402ccc ("ovl: Check for casefold
consistency when creating new dentries") as a bare dput(), which already
released the reference twice; commit fe497f0759e0 ("VFS: change
vfs_mkdir() to unlock on failure.") converted both sites to
end_creating(), adding the double unlock.

This is reachable by an unprivileged user.  The casefold consistency of
the layers is validated at mount time in ovl_parse_layer(), and again on
every lookup in ovl_lookup_single(), but ofs->workdir is the internal
"work" subdirectory created inside the user-supplied workdir, and that
subdirectory is not re-checked.  Marking it casefolded after the mount
therefore makes every ovl_create_temp() inherit the wrong state - and
that path reaches ovl_create_real() through ovl_start_creating_temp(),
which uses start_creating() with a generated name and so never runs the
lookup-time check.

  unshare -Urm
  mount -t tmpfs -o casefold=utf8-12.1.0 tmpfs mnt
  mkdir -p mnt/lower/d mnt/upper mnt/work mnt/merged
  mount -t overlay ovl -o lowerdir=mnt/lower,\
        upperdir=mnt/upper,workdir=mnt/work mnt/merged
  chattr +F mnt/work/work
  mkdir mnt/merged/d/sub		# directory copy-up

  overlayfs: wrong inherited casefold (work/#5)

and the next copy-up blocks forever on the parent's i_rwsem:

  mkdir           D  start_creating+0x65/0xb0
                     ovl_start_creating_temp+0xb0/0xe0 [overlay]
                     ovl_create_temp+0xa3/0x1d0 [overlay]
                     ovl_copy_up_one+0x1f1c/0x21c0 [overlay]
                     ovl_copy_up_flags+0xf5/0x140 [overlay]
                     ovl_create_object+0xb7/0x220 [overlay]
                     ovl_mkdir+0x23/0x40 [overlay]

Drop the end_creating() from the branch and let out: own the cleanup,
which is what every other error path in this function already does.

Fixes: dfc7da402ccc ("ovl: Check for casefold consistency when creating new dentries")
Cc: stable@vger.kernel.org
Signed-off-by: Vivek Parikh <vivek.parikh@breachx.ai>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a7a393b04277..3cd8194cbb1d 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -188,7 +188,6 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 			if (!err && ofs->casefold != ovl_dentry_casefolded(newdentry)) {
 				pr_warn_ratelimited("wrong inherited casefold (%pd2)\n",
 						    newdentry);
-				end_creating(newdentry);
 				err = -EINVAL;
 			}
 			break;

