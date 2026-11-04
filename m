Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818480;
	b=p76VJIPDMyfXgJJWerDg8moMMJriAtuppxZ+iWCvloIlPjHZNQ6VFi2CTUzk/WiL1JvQ
	 5/MD6JyBOOp7ZbtIhrWDz33XS1hT2Iy7MciTI64DzZEYgWf3lQtxOW9GQL2z9uAKJWwtG
	 G1KxQYoI77BT9MLcjexKnM6KmrYeKMSftNqGOKHSTzVigdMAVudscj/i0oFEAKk+wzBwI
	 uEgaKcowkECCacLEHtiHYv+OLaVkCDaLTW9lkBaRKN78o7LpvJ4iPlUseeHK7He7nq/cf
	 b9BBon+P9ZVZbtve95u33A+k/MzmRoFqU3x7wZOEmJNDoxVmO1gp/m2UeS8yJQSQ5qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818480;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FMyxoGd5CBsuHrr0WOZ7ZIsZoew4X8lrpYn1S1WR0PA=;
	b=HLeNpF86gRfwQgMvMEDzlmHBRNUKbpJ8Hazr4fBO2i5NG+o5XzYLzNfAjRnoM4aaHeRb
	 S+Lu2C3vnL3Navw2OKWt/Ev1PkfRYyfCz48DyoB0yqxJl7DcPPhjv1h21KL+xa4VokZeV
	 v5FaWHWRfKfX5E9xWOl1WQmrXn+q3iov/oCra7pbpDDZMT1PdJx22q7MyzoU+ZOF5Z+NT
	 qXmRawkIHj4UP9HqT3BFHnEeuhnWp0SF2p03ymuB9I2O41fY3pRf5ZM5CW93Oo+pk/Ixa
	 K/tcoYXkcoXGngAFvBQ6g8lJElJp9wRztw6cT6DXF180BjTjlmsLZMlj+qlRbrRtNJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HR0rBHA4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FFB606A334
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HR0rBHA4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919541F00A15;
	Wed,  4 Nov 2026 18:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818479;
	bh=FMyxoGd5CBsuHrr0WOZ7ZIsZoew4X8lrpYn1S1WR0PA=;
	h=Subject:To:Cc:From:Date;
	b=HR0rBHA4Rkf0sUcpAUG1CGDNw77suftr9glew8Zvg99QNe9N408TUR/MwcdjQgJXu
	 DbLWJxbT2hKSGzP3N6rdwZIQg2QiklaYi7tfGQAgCHktX8ppkqB/1xZf+qKdqAxfKX
	 ee3ouziXzgpKc+5PE0lhI06fgwsyu1aap+vP5m3E=
Subject: FAILED: patch "[PATCH] NFSD: return NFS4ERR_EXIST for a guarded OPEN of a" failed to apply to 6.12-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:54:30 -0500
Message-ID: <2026110430-landside-veggie-d182@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 89318a02fe1c19aac6d85a17c45800544bd3cbe0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110430-landside-veggie-d182@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

