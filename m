Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818474;
	b=HjzMU4NT0b2JVNfq3IxiTstrny7KaC1yYZYoYpT742/+Fx43rdbn8lkymTewJHEc+BUx
	 2PwjcXS0oidPWTE2bNrTFciqgz4poEfQgUuvEtZ1ZahjZBRLSeHJtqcwAsDvGwqeM0+0W
	 4sIKYUEdyaRbIfXlKz8TeTx8y1hm/kjflXDFJv5vb7qlIeZDk9wLpvAtRc9p5e+HKVCvN
	 pF98ORIXzxXJj1b7CdPfMENBRv0IU0uc1XnCZaV49lH0zgo57Lz2sKm2gKYaQdiccIy1R
	 /oN/M9yk6l12uOXGS/xfM56wI6Uw9NxsvCuh1Y+EqTkhuw5E7AGIrZp0k5zsxhixC8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818474;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6PuFCQW3PKPcxMM9qJiVrfeiqmo557GpJas3xRAdaQI=;
	b=Z0NKx4PhlUc/4nzfTv5J6WSyyymGhNa7oDU043GAno3V8W7dcmis6rzExQWdsr57NkY9
	 Ga5SSWRehBcPjqdYzn0YzVXXwKlmApUZ1yeLF/8CuyPNhETTipF45tpHRGh2Xvq6fFilc
	 egq8GcCVDMm/zNOfdKBjui94hYdlkCJOjYYwYIXQnN0+Xzu92nbYX1u/fBgnyW9l2+9/z
	 b1vXStiT+wbcTKXZmBmlrRHeRQUhsM7cYMxDG+PX4BMMC6ZANeMmvdn6/a9oTbzDh9D7l
	 7vwMRWKledP7B6X/JctJhiD+sZsKA8ezUF1UMxRmRnq9Cg+vjUAA79dykhUGuYLD3pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BRC+yHSS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3CF606EEBD
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BRC+yHSS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8794C1F00A02;
	Wed,  4 Nov 2026 18:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818473;
	bh=6PuFCQW3PKPcxMM9qJiVrfeiqmo557GpJas3xRAdaQI=;
	h=Subject:To:Cc:From:Date;
	b=BRC+yHSSrV2iOeUB4jVJcr0DWcXM2Uh9pTB5ABvnJtutrJdqkiDcP46Uvni1jaI/h
	 ecmM+V14ibkfiuo3IXVkn5kaxsYOvGeq/Ei7T7cEWyXifCvS4ZitqC/AUAHw2J7L79
	 mjZoy7yeY3eOC3GAdkTDamJV6EHLI/Bf6cWYqM2s=
Subject: FAILED: patch "[PATCH] NFSD: return NFS4ERR_EXIST for a guarded OPEN of a" failed to apply to 7.3-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:54:29 -0500
Message-ID: <2026110429-debtor-mortified-407f@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 89318a02fe1c19aac6d85a17c45800544bd3cbe0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110429-debtor-mortified-407f@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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

