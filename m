Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818478;
	b=esd7fkgPHbjugL6tVlCeq5SJI7ikrYqCpx7/lHVo+QlRPC2DFwhZJmWVmqwiKps/DJxv
	 CW5otsjAHJTU5JW6sD4d1zdhqt2qx84COR5nd6xhSXmwdilQDC5JGGzamUEdSwyszVqPB
	 GdFne5knO7vx+ITHzGTzZtLOcb5wehbHQBoLe2jRica21JPxKM/YpC8WOmedfSpdX+Cl/
	 28d60uns2qLdQnUVgS7+DzCOxqZZL/ZPFIJwF9vMNHxm+QMRBhvFXlYIyWdGiKhWZm4kN
	 M1eyyT80Jvf/+bOOeF9IpeuIjeAJSFgTKC/aVLHNWUZSNdHSDaC5H+lQbIQPxUtW2ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818478;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bB3PZ4K8ca5cKosAfieW/ppiUgty4cDiDhE+0KdFuPs=;
	b=kTG074TnlxTmHc6BAix4iW6Kzs4ZlMlK7INac8cy2nkU7eE35U6DtpYRRQ3cZiEyQw2h
	 7ezg2zAEYLoWCdsATuTuF3Qu/Ws9oPqNZF3wNW9Acy/SjzfzP6K/9rlOgcYJ2u1cUbp6x
	 9OpKtLvkUu6f9nHyqa7en8VTwVQXpdGRNS2Eis61tv5xXi7VuyuFWko9qVn5AcS7TVPRb
	 k+VpJxaUwCM4Ot9OXVzTvbdXCH8ueOm6THECmTj0azv+Q2IWd4kDjY+6dRUY9CYd9C52U
	 WbS05sXXCeghY3jaOCXZVS4KEKULNpM80Iug2LN1JCexY0Oz6oHsVimgl8xIH2PMLnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JAMtamcA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE360A260D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JAMtamcA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05951F00919;
	Wed,  4 Nov 2026 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818478;
	bh=bB3PZ4K8ca5cKosAfieW/ppiUgty4cDiDhE+0KdFuPs=;
	h=Subject:To:Cc:From:Date;
	b=JAMtamcAKXAFiaoVwqVrU5snGkcZVJ3Mv8VUVpo2Q5bsYMCxx/sz7DuIIbFGfMk+M
	 /n/b1Nvnf829YEW9hpi2NZAgnebqQ2yK0gwtVFIXa9A6f1b7Ksislfav47uX8TMryh
	 FvAFxU1AyV7+ZazeuUQ/1ZtU/RV53zz3i2uH6zvI=
Subject: FAILED: patch "[PATCH] NFSD: return NFS4ERR_EXIST for a guarded OPEN of a" failed to apply to 6.18-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:54:29 -0500
Message-ID: <2026110429-earphone-deferral-7e10@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 89318a02fe1c19aac6d85a17c45800544bd3cbe0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110429-earphone-deferral-7e10@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89318a02fe1c19aac6d85a17c45800544bd3cbe0 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Sun, 6 Sep 2026 14:41:41 -0400
Subject: [PATCH] NFSD: return NFS4ERR_EXIST for a guarded OPEN of a
 non-regular object

Commit db8b567ffa98 ("nfsd: (almost) always open file in
nfsd4_create_file()") moved the regular-file type check ahead of the
createmode logic. A GUARDED4, EXCLUSIVE4, or EXCLUSIVE4_1 OPEN that
finds a directory or symbolic link under the requested name now fails
with NFS4ERR_ISDIR or NFS4ERR_SYMLINK instead of NFS4ERR_EXIST.

RFC 8881 Section 18.16.3 requires NFS4ERR_EXIST when a guarded create
finds any object under that name, or when an exclusive create's
verifier does not match. The type-specific errors in Section 18.16.4
apply to opening an existing file, which only UNCHECKED4 does.

Fixes: db8b567ffa98 ("nfsd: (almost) always open file in nfsd4_create_file()")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260906184141.3453309-1-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bb74eef43938..3a82af381a8d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -430,7 +430,17 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				       oflags,
 				       open->op_iattr.ia_mode);
 	if (IS_ERR(open->op_filp)) {
-		status = nfserrno(PTR_ERR(open->op_filp));
+		int hosterr = PTR_ERR(open->op_filp);
+
+		if (open->op_createmode != NFS4_CREATE_UNCHECKED) {
+			switch (hosterr) {
+			case -EISDIR:
+			case -ELOOP:
+			case -EFTYPE:
+				hosterr = -EEXIST;
+			}
+		}
+		status = nfserrno(hosterr);
 		open->op_filp = NULL;
 		if (status == nfserr_noent && create_status)
 			status = create_status;

