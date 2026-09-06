Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B34CCDE5
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707451; cv=none; b=rSp89QIGS22zOhJm06L/OB2JtmkYNi9GQDepKz860tH+HwKlQWvbJFidNN9A2tui4utOGbNG+xNHis1aCBzLU84ZuMr7DInR35lRR4rcSnuT1s+savv2w5sXpxMfzIbqABt4nmTrc1LqPIGEJiFoL44wfbyAbr0sUh69nYRtgZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707451; c=relaxed/simple;
	bh=6KxZKAxHpmql9LMoghEqcnPRu0i5j1SwIxydUwWrNhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+BjRDIau85nzb27WMxvGFZFJGNBHB8WrSkBnaMwdDrmI/P0lGevG3GQNKEgIy+eiK3DjpSXw1JS5ITtTm2uUWskSrUZSTDHeYKxM/zNSDV+6/NcNYu+jRjMycMPjSC/biOfmUSwd1BZj7ceLbPvW5TBB3trZ5uOVtnJL08ErNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arUpkdJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arUpkdJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0E31F00A3A;
	Sun,  6 Sep 2026 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788707449;
	bh=Mgo34bvm8X8EDHXNUSgaxUX4VaY+n/q6PwkwXst27Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=arUpkdJ5Us46pcMFIypf7s0M5WQjqfvxgCl9i4+IUidiKmsyVrx/pg7a6GB2OWOJM
	 DJz7aCK+C5l0MACY7wMOriGAWihd67D+RL2o2pCCtYAQ6M3Jn1RXEUMpmI9x+2K8IN
	 KFbMJf23N7tI6rvW3nw7wNIdWuaIeuCW3T/aICp+Gb4VPfsf0vfop+boPtZ8CqRIYD
	 2wM31U3GIOn75PrzrBKADixZevC6cm+A6mm/ZuxMtL2RfKwXXVKovMBiFmYYamPzqd
	 CY9IKxIr3X52CBZoOzFk8HdiPenx5lIQtp+NoUTW3YkWVCXBuve8jmWOsnAefUraqR
	 T1OwIRtAg/Z6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nfsd: reject out-of-range nseconds in NFSv3 SETATTR and create ops
Date: Sun,  6 Sep 2026 11:10:47 -0400
Message-ID: <20260906151047.1394055-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090308-framing-charity-2ed8@gregkh>
References: <2026090308-framing-charity-2ed8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robbie Ko <robbieko@synology.com>

[ Upstream commit eb0eca7720662ba5847df1510e73801f7f473094 ]

A client can send an NFSv3 SETATTR, CREATE, MKDIR, SYMLINK or MKNOD
carrying an atime or mtime whose nseconds field is out of range. The
value is well-formed on the wire and decodes cleanly into a valid
uint32, but it is not a valid timespec64: tv_nsec must be less than
NSEC_PER_SEC.

Nothing in the setattr path clamps it. notify_change() runs the time
through timestamp_truncate(), which does not reduce tv_nsec below
NSEC_PER_SEC when the filesystem supports nanosecond granularity
(s_time_gran == 1), and the inode atime/mtime setters store it verbatim
(only ctime is normalized, via inode_set_ctime_to_ts()). The
un-normalized value then corrupts on-disk metadata: ext4's
ext4_encode_extra_time() shifts tv_nsec left by EXT4_EPOCH_BITS, which
overflows the 32-bit extra field and clobbers the seconds-epoch bits, so
the stored seconds (and thus the year) are wrong on read-back. XFS with
bigtime mis-stores the timestamp for the same reason.

Validate the client-supplied atime/mtime in the proc handlers and return
NFS3ERR_INVAL before anything is changed. RFC 1813 lists NFS3ERR_INVAL
for SETATTR and describes it as the error for a value the server 'can
not store ... in its own representation'; the client maps it to EINVAL.

Checking in the proc handlers, rather than in nfsd_setattr(), keeps the
rejection in front of object creation. The create operations create the
object before nfsd_create_setattr() runs, so a late failure would leave
the new object behind and turn a non-idempotent request into a namespace
change that reports failure. The check is therefore done up front, for
the create operations before the object is created.

tv_nsec is a long, so the comparison casts it to unsigned long (the same
width) rather than to u32, matching timespec64_valid(). A u32 cast would
truncate on 64-bit; the unsigned long cast also rejects a value that
became negative when an out-of-range u32 wire nseconds was assigned to a
32-bit long.

Only client-supplied times are checked: SET_TO_SERVER_TIME requests
carry no client value. The sattrguard3 ctime is deliberately left alone:
an out-of-range guard simply never matches the object's ctime and yields
NFS3ERR_NOT_SYNC via the existing guardtime comparison, which is the
protocol-correct outcome rather than rejecting the request.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Robbie Ko <robbieko@synology.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260616054027.2360930-2-robbieko@synology.com
Signed-off-by: Chuck Lever <cel@kernel.org>
[ inlined timestamp validation while preserving older status handling and nfsd_setattr() API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs3proc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 19cf583096d9c..6c5a5fd4caa58 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -76,6 +76,13 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 				SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
+	if (((argp->attrs.ia_valid & ATTR_ATIME_SET) &&
+	     (unsigned long)argp->attrs.ia_atime.tv_nsec >= NSEC_PER_SEC) ||
+	    ((argp->attrs.ia_valid & ATTR_MTIME_SET) &&
+	     (unsigned long)argp->attrs.ia_mtime.tv_nsec >= NSEC_PER_SEC)) {
+		resp->status = nfserr_inval;
+		return rpc_success;
+	}
 	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs,
 				    argp->check_guard, argp->guardtime);
 	return rpc_success;
@@ -245,6 +252,11 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 status;
 	int host_err;
 
+	if (((iap->ia_valid & ATTR_ATIME_SET) &&
+	     (unsigned long)iap->ia_atime.tv_nsec >= NSEC_PER_SEC) ||
+	    ((iap->ia_valid & ATTR_MTIME_SET) &&
+	     (unsigned long)iap->ia_mtime.tv_nsec >= NSEC_PER_SEC))
+		return nfserr_inval;
 	if (isdotent(argp->name, argp->len))
 		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
@@ -389,6 +401,13 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
+	if (((argp->attrs.ia_valid & ATTR_ATIME_SET) &&
+	     (unsigned long)argp->attrs.ia_atime.tv_nsec >= NSEC_PER_SEC) ||
+	    ((argp->attrs.ia_valid & ATTR_MTIME_SET) &&
+	     (unsigned long)argp->attrs.ia_mtime.tv_nsec >= NSEC_PER_SEC)) {
+		resp->status = nfserr_inval;
+		return rpc_success;
+	}
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, S_IFDIR, 0, &resp->fh);
 	return rpc_success;
@@ -403,6 +422,13 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 		.na_iattr	= &argp->attrs,
 	};
 
+	if (((argp->attrs.ia_valid & ATTR_ATIME_SET) &&
+	     (unsigned long)argp->attrs.ia_atime.tv_nsec >= NSEC_PER_SEC) ||
+	    ((argp->attrs.ia_valid & ATTR_MTIME_SET) &&
+	     (unsigned long)argp->attrs.ia_mtime.tv_nsec >= NSEC_PER_SEC)) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 	if (argp->tlen == 0) {
 		resp->status = nfserr_inval;
 		goto out;
@@ -468,6 +494,14 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 		goto out;
 	}
 
+	if (((argp->attrs.ia_valid & ATTR_ATIME_SET) &&
+	     (unsigned long)argp->attrs.ia_atime.tv_nsec >= NSEC_PER_SEC) ||
+	    ((argp->attrs.ia_valid & ATTR_MTIME_SET) &&
+	     (unsigned long)argp->attrs.ia_mtime.tv_nsec >= NSEC_PER_SEC)) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
+
 	type = nfs3_ftypes[argp->ftype];
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, type, rdev, &resp->fh);
-- 
2.53.0

