Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818483;
	b=aI/cQQ6eOpT9Vl9Rj+7GfFhkurA+Hm/XR0O2zcWEBAUgjr24cCnLgZVpuuRUwgIrN5OL
	 Op2ka1U+u7rvNBhbw6LPtuW7F37vH1rWiQHmhnSqlJaoILUNmKRThXc+5v9n2Ol0hHvjE
	 EUZrV3XRy+E+u6SW9ZVEPFBJvzplqbJM0T6EOLXs0nAx2hyxfpz1oK7b558SUUtVv19rm
	 qSNAXDjo986H/E3pJ6QWYV7S2sy0OT97L/bN+/fJsYIG8h5gA2yrFixQUBImzP4QhiznQ
	 1biMXlRtmnwCwQB+jR29IFgyN8BVTLM405oqujZ2uCRRB48RI6mG0f/WmY2FRCrTNow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818483;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aMqTqv56S5uTmGyxmkyXlVy8h0dkx+Ix7WJUcSWdBqM=;
	b=pK/C5zuE9xppXVD++/qdEpQtjMKEEgHz6cWcYhQcmqCr8VT4T324MNzjun3/apmYrXFp
	 r3uIVmM3KJin9J1KwVqT/mYMRGINul9UQQ7gpKq3DCjZ23h/GxkiAnGscuxiyAA4Dd7+M
	 nDJIkyhTBQIVU0JIF/POW3iwt73XfZ1YMXZWoWxrS8MMYaQWVP2xgPZ0q14Hz8czmeHjN
	 5tZxdcjnzG8TwY9M3of5FPL2hfV9pizuf4/i2spV9wDOQ5F6IV91hyTzIGFBjVmgkPEY8
	 B+4Vly4eqP4xe0Yu1l7lckfN3CJcA1VgtLWqIMdJoucOwYf5Yev7sO0bb4/wW4yl5Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uERgAf7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262B606D838
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uERgAf7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59C21F00A1B;
	Wed,  4 Nov 2026 18:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818483;
	bh=aMqTqv56S5uTmGyxmkyXlVy8h0dkx+Ix7WJUcSWdBqM=;
	h=Subject:To:Cc:From:Date;
	b=uERgAf7HrXAJE/SAhFb5V95d3RoSaeclnjfJVvFmL8gLXI6vJBpMBbwQI2yzZgzzR
	 YYsXvy8+6mSpBH3wIFAa7m4SkROGg0qI/8H604LgtVaiacRmdRC7PSlPlmHXhvNtFI
	 LsaMmRKnCkvHRa6/ewXfJl+vJWa4qnFpKKmXF3to=
Subject: FAILED: patch "[PATCH] NFSD: return NFS4ERR_EXIST for a guarded OPEN of a" failed to apply to 6.6-stable tree
To: cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:54:31 -0500
Message-ID: <2026110431-radiation-plop-a81e@gregkh>
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
git cherry-pick -x 89318a02fe1c19aac6d85a17c45800544bd3cbe0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110431-radiation-plop-a81e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

