Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818482;
	b=D064r3eX/PWbrVhKM08bP+vbm6AUO5uYBDzNqidh3Fb9vXOtDIbiHfHdVFecqKzxrCsn
	 KCQL2eQnlaE5GFII842fu0+HP69DAipjpEtGG2DuU0x1TZzqGDVd/rpXRxv1Zz1ntdDXj
	 IOfSvFYscD0H9xyJzIPK9h0giqnWqM56QxlTjPT/sOygGZLPbOXWWBiaD0246TzsFBXlI
	 OAmxU5yOwNG3B8HfOYXbh2pnrJN13EkHPtSB4OFJQ3cEwpyfI+PRxpI7NNsTOGthbuMUk
	 v/tdvWW//gfRzqEY3R1BlXFfM7NkpwpIsSJsGgxsfCmm/S/yUCDpJ2aLS/G7BbLpALA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818482;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/dN98mfpRO3T/ALs1SGQ7BvpfU3vm91/oOfyjM/2L1o=;
	b=YFsniHcJdm4NucY3RLsV0d6Mo5vfEA071LSi5VS536fk9LWFCa7pC5UgNVRkZNz29s7R
	 F3HW+wErY+NA3uNNW50GpqWTWCW3humJfv7mR9+MJwh7VG9HCR9T1d+hraPGSVoVJF37I
	 sh+FCER6kDvrozsfZ6P5RWdplHEfi0SOziqs7atC2iqEXlBEFMNEICp2Q6bhjM4m0Je31
	 nkV+vMm2Y8KMrh6R5uy5o6IGkRKLFh+IgwkXcSab5wXLToEd/UDaUNyxBg0PHA4Nq2Lo8
	 ibwPETfdWxJ2srjey7Khjz7yWMI8IjrzUF2OUQjrgykU/w9Shu9lXxq0eHfpD0vVCNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aS86r0fN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED6606A334
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aS86r0fN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3831F00A15;
	Wed,  4 Nov 2026 18:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818481;
	bh=/dN98mfpRO3T/ALs1SGQ7BvpfU3vm91/oOfyjM/2L1o=;
	h=Subject:To:Cc:From:Date;
	b=aS86r0fNoAyMX22TVTU3bIuhRz+ZstiMcLeQQak1FEjSQCNeG1/qHgxnoqD77DuM3
	 GjOLrtR3EEzCeH0Xs/jK1Xro028/Ch1kQzlBpsXO1Ecas+yHMKrSvQK6Ubr/1Edldv
	 h543vqE0LWUR1mxKhEOPGWetDhCEnkfAgMJYEaUg=
Subject: FAILED: patch "[PATCH] NFSD: return NFS4ERR_EXIST for a guarded OPEN of a" failed to apply to 6.1-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:54:31 -0500
Message-ID: <2026110431-dreamy-predict-faa4@gregkh>
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
git cherry-pick -x 89318a02fe1c19aac6d85a17c45800544bd3cbe0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110431-dreamy-predict-faa4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

