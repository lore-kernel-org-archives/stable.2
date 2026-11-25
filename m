Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604583;
	b=2tvoh7yAq8P7Yv2BaLTUxTl4mUjEiKKW6SGy6eXJhlZq94foOEbA985SYbMP27nY7NW2
	 pViVz756/fzJK10JX8lhewQPL6jGkxJyOUbsPY13xLfmUDilbblhBkZf3nw/IDM91ckWl
	 qdMbyasnEWeOyV+OQ40tMvlmEVslQomeImxGgysCGDUSMP66buJDxP4ZnLAJXSsSPpFk6
	 vGzmE7M6x51I6xxjtVWS6LhuNDsGV4pDfLRfOwX8H6mPqg67wIXN49J1iSW+OZVsO8z1t
	 15ozjfmnkmpm9Ij5rt9AcNEMn8e6vJrJx8rjFbmPeB6IqCn5DkErYKCRSmxac7qAVHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604583;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=B+v53Gerb6YrWUOapkW07Z9WOu56js3tXeDvT1xka40=;
	b=EVG5G1sB1zq+EfMJQH+Ipf8Ap388iV8qJ8J8Evx4J6UXryYXwignnUCz6YJQRWHRy6Ag
	 /4pdB2W7DvbC5KVcAEwdQHry9dAR5CZXrTijqmMWwlw5QdmRofoqsFaUkAE3EusjtKpYA
	 WDVSnbb8fvbdSv+OaViKACAl0wsXumbHymrNK+D5p4TR7Eo6h54oqn9tTl2Pc0P6BSq4C
	 PEigCEmsGYgsllmwN2/bgbKm/OPue3geXA5ZHzpCG8c6cBfDVzV3m3rDbJv5cqcRThC/1
	 b9Xqdz0P0yVrClb8SDfu36Rwm4q9LaarhdLJsABWQ2L9gFRVch6l0L1uZoEfdsJGdSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="nA0OPA4/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A7606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nA0OPA4/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0981F000D8;
	Wed, 25 Nov 2026 11:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604583;
	bh=B+v53Gerb6YrWUOapkW07Z9WOu56js3tXeDvT1xka40=;
	h=Subject:To:Cc:From:Date;
	b=nA0OPA4/zrVLYJNdhyVq4HKmX3PwnY+9P+mbjkxb9Uq+ApnI4ovCXiNmzI2tJkKm1
	 g+jlAiOPyXLYW20U00seK2JuPcIx73exTzs7QLqhSdw0YzvcPUqjd1JMFgraDNj1Dd
	 cJlAAnfmeIZnOg8E7rjzVWftINS+VcuHmJO9A2TI=
Subject: FAILED: patch "[PATCH] ovl: bump the impure dir version when linking a file with" failed to apply to 5.15-stable tree
To: daejun7.park@samsung.com,amir73il@gmail.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:44:49 +0100
Message-ID: <2026112549-garter-shredder-8b5c@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 86e2facd8630cc2fdec6ea80c53e370b26b441d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112549-garter-shredder-8b5c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 86e2facd8630cc2fdec6ea80c53e370b26b441d9 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Thu, 12 Nov 2026 12:58:09 +0900
Subject: [PATCH] ovl: bump the impure dir version when linking a file with
 origin

Linking a file with copy up origin into a non-merge impure dir does
not bump the dir version. readdir then reuses the impure dir cache
built before the link. It reports the upper inode number as d_ino of
the new link, not st_ino.

Pass whether the linked file has an origin to ovl_dir_modified(), as
rename and unlink do.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-98f207b6-3936-48e9-a40f-88f20be4db7b
Fixes: 4edb83bb1041 ("ovl: constant d_ino for non-merge dirs")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index e0a164e22d67..8fec18dc5fc7 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -368,7 +368,7 @@ static bool ovl_type_origin(struct dentry *dentry)
 }
 
 static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
-			    struct ovl_cattr *attr)
+			    struct ovl_cattr *attr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
@@ -393,7 +393,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		ovl_set_opaque(dentry, newdentry);
 	}
 
-	ovl_dir_modified(dentry->d_parent, false);
+	ovl_dir_modified(dentry->d_parent, origin);
 	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink, NULL);
 	if (err)
 		goto out_cleanup;
@@ -491,7 +491,7 @@ static int ovl_set_upper_acl(struct ovl_fs *ofs, struct dentry *upperdentry,
 }
 
 static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
-				    struct ovl_cattr *cattr)
+				    struct ovl_cattr *cattr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
@@ -582,7 +582,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup_unlocked;
 	}
-	ovl_dir_modified(dentry->d_parent, false);
+	ovl_dir_modified(dentry->d_parent, origin);
 	err = ovl_instantiate(dentry, inode, newdentry, hardlink, NULL);
 	if (err) {
 		ovl_cleanup(ofs, upperdir, newdentry);
@@ -647,12 +647,12 @@ DEFINE_CLASS(ovl_override_creator_creds,
 
 static int ovl_create_handle_whiteouts(struct dentry *dentry,
 				       struct inode *inode,
-				       struct ovl_cattr *attr)
+				       struct ovl_cattr *attr, bool origin)
 {
 	if (!ovl_dentry_is_whiteout(dentry))
-		return ovl_create_upper(dentry, inode, attr);
+		return ovl_create_upper(dentry, inode, attr, origin);
 
-	return ovl_create_over_whiteout(dentry, inode, attr);
+	return ovl_create_over_whiteout(dentry, inode, attr, origin);
 }
 
 static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
@@ -687,12 +687,14 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		 */
 
 		if (attr->hardlink)
-			return ovl_create_handle_whiteouts(dentry, inode, attr);
+			return ovl_create_handle_whiteouts(dentry, inode, attr,
+							   origin);
 
 		scoped_class(ovl_override_creator_creds, cred, original_creds, dentry, inode, attr->mode) {
 			if (IS_ERR(cred))
 				return PTR_ERR(cred);
-			return ovl_create_handle_whiteouts(dentry, inode, attr);
+			return ovl_create_handle_whiteouts(dentry, inode, attr,
+							   origin);
 		}
 	}
 	return err;

