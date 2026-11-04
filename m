Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802928;
	b=BQFExUTTBHXzRf+9QsUfALNT1JHX4E/XhPuAUkDe8GFiGIF2yx+iwP/q7c4WOlhgHPgD
	 /AqmvTWUbgC3kw/8nlhRwLYh4MsgBy/ItYgLARLXSGjrh7eSUb1jzrUdzyHl0bNLHBB0i
	 ZUOFtN52go1OM0ssZe9KbaL1g4pg5JiW3LYJpmChCdGNP8t3RaXN188VFXiopx877lmLV
	 EtJRHW4E6ytoh6KesMhIbaYVj+NzSSd82K3HqIpx81+b1rbDpr7pWkeNDbonJr0BnqhMl
	 fGTyr9rCXYf9vjMghEe4IA1ne/plxbBufVcaE63hgTmtb0F9if9h/apO6I3cdIxjnGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802928;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=u10O5kJB/twb81Sj3YkZOzTn934nfLyych2QNbg+BHI=;
	b=1pdK4VDavZVioDVyGf5SFDZCYxQ+FT38dB06zSKZXHh1C3bytsAJVZhMSTVixIn/wJfq
	 MJIFni/HYoJ8x14UUIWF4beRLHHAOI4hAkZ3IlZmpX0qXKc9cuKxo9+VrVn1DadX+c/gI
	 WcFeNw6ly58ujZj07rpgOEPXd/1ChKal8STg8y73B9B2lAvCpR3f5C/aUPr+q9K7itzHC
	 lzvjZ8hBBuatuCleWudgMav4zaAz0M5O1WcwlXwb4jjURFH4kdH57VPB54ziV2eKOYgOV
	 6mOflPzVjwoEQlht4uHEhtd/5BMYDyHBmcK+vWFUuUu7HdxDyv/9psLZoMxepWeLlXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wsLtaOGd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E9E606A334
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wsLtaOGd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32941F000C1;
	Wed,  4 Nov 2026 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802928;
	bh=u10O5kJB/twb81Sj3YkZOzTn934nfLyych2QNbg+BHI=;
	h=Subject:To:Cc:From:Date;
	b=wsLtaOGdultKviTB1dxTD9ZyAvcrKgzNr5dYxuOeIjI7Eetm+QxLW1aOmXL1R6+1j
	 qSBRWUfL03g88ffqt/wFkUOM3RM1B1IxfWTf4HL4IIHeB7zMVb3Hhi70ROiyCaYDea
	 ipAfCOU2oMU7oM/KS8++1lslBLYL/pNvKgt4LRYI=
Subject: FAILED: patch "[PATCH] ovl: use the pinned upper dir in ovl_fix_origin()" failed to apply to 6.6-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:35:27 +0100
Message-ID: <2026110426-unhelpful-couch-c92e@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4f61ff2ebfb3d2967b83b6a4d456242244d5a61f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110426-unhelpful-couch-c92e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f61ff2ebfb3d2967b83b6a4d456242244d5a61f Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 10:47:10 +0000
Subject: [PATCH] ovl: use the pinned upper dir in ovl_fix_origin()

Renames made directly on the upper filesystem during a lookup crash the
kernel.

A dentry that is passed to vfs_setxattr() must be pinned.
ovl_fix_origin() passes upper->d_parent to ovl_set_impure() without a
reference, and the lookup holds no lock of the upper directory. A
rename on the upper filesystem changes d_parent, and only the child
pins the new parent, so a second rename and an rmdir free it.

With delays in ovl_fix_origin() and ovl_set_impure(), renaming the upper
directory twice and removing the intermediate parent during the lookup
of a merge directory without an origin xattr gave a KASAN
use-after-free in vfs_setxattr().

Fix this by passing the upper dentry that the overlay parent holds.

Fixes: 9678e6303057 ("ovl: fix inconsistent d_ino for legacy merge dir")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: add helper ovl_set_impure_dir()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index ca899fdfaafd..cf7908a39f61 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -942,8 +942,10 @@ static int ovl_fix_origin(struct ovl_fs *ofs, struct dentry *dentry,
 		goto out;
 
 	err = ovl_set_origin_fh(ofs, fh, upper);
-	if (!err)
-		err = ovl_set_impure(dentry->d_parent, upper->d_parent);
+	if (!err) {
+		/* upper->d_parent is not stable, use the overlay parent */
+		err = ovl_set_impure_dir(dentry->d_parent);
+	}
 
 	ovl_drop_write(dentry);
 out:
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 7f3558372c59..c89739e5338b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -572,6 +572,12 @@ int ovl_check_setxattr(struct ovl_fs *ofs, struct dentry *upperdentry,
 		       enum ovl_xattr ox, const void *value, size_t size,
 		       int xerr);
 int ovl_set_impure(struct dentry *dentry, struct dentry *upperdentry);
+
+static inline int ovl_set_impure_dir(struct dentry *dentry)
+{
+	return ovl_set_impure(dentry, ovl_dentry_upper(dentry));
+}
+
 bool ovl_inuse_trylock(struct dentry *dentry);
 void ovl_inuse_unlock(struct dentry *dentry);
 bool ovl_is_inuse(struct dentry *dentry);

