Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B423D522F
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701323; cv=none; b=goCi9zJBO5bsESz2Tcvn9qauxXHLu4Hp0bomhWn/yKfb6IyGlCkbsvOIITjuqv/h9e6GmMISJQx0rHlscDOXqkyiG7K1U/+NfYLHAAsfZpdte64tj2JOwjxckgMjdxqpw8ZV59jRY/He/ygemQsmPhG3dtAnNzVicJ0oQd4KySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701323; c=relaxed/simple;
	bh=d+pmJYq8VBTtXhKBdqxA0ww/zTIe0mJcQ3qQvSp54Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVhj/SIQp0q+HkW6j5Q5wrU5uynFTpve5o47QlEe3HMy10P4dOzQ9zcf0Uyvq57VcQeJp7Tw87evtI0pD9QX/JByU/MYRuCOMJo7XC856pNQtpM9Dt3UuVDm9bzxhL8yb4i8R4z7kqz+NLiyS5hS1Vpjm4bbEGMGj1w9JJ/YZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji9W+s3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji9W+s3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734121F00A3F;
	Sun,  6 Sep 2026 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701320;
	bh=9d9Ocug6PO0u7q+WqqI5Y/m1qjFXfzf1hbnl7uu7rNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ji9W+s3hoNLeRaQqO+6cgdyDl2EzXfcmJX/ofNhmNb+jSUngEndvdbbS345LEqSmy
	 UhLkd91v4MkYbshAD9qT6pAsa1+49+cOD5+9dATu04DY0ZPpJREb3/wnXz85ZvxdwN
	 b3L/Fe6p3JfwY0HFj8/T9R6tR7n51GectP8/S2DMTS+i4dUWsYt6aoMVR8+OE7hkgV
	 Bg1CX+yE5hKIhHoQoLLqWxCVLKCND16u22aCu5sZQ1vbiRllSEGutA+rGb/tVAUp44
	 2AJ+ZTx8sgsoIgDYLAvV1+OoNocUglP1SL7jtB2HdZeFaJbK034ovD0XgVIf4p5Fxz
	 BBaVLQzFIdt/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] nfsd: reject out-of-range nseconds in NFSv3 SETATTR and create ops
Date: Sun,  6 Sep 2026 09:28:35 -0400
Message-ID: <20260906132835.874565-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906132835.874565-1-sashal@kernel.org>
References: <2026090307-suave-unlucky-a08a@gregkh>
 <20260906132835.874565-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs3proc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 3abb2923192ad..944d99be61c64 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -28,6 +28,25 @@ static int	nfs3_ftypes[] = {
 	S_IFIFO,		/* NF3FIFO */
 };
 
+/*
+ * Reject a client-supplied atime or mtime whose nanoseconds field is out
+ * of range. Such a value is well-formed on the wire but is not a valid
+ * timespec64, and storing it verbatim can corrupt on-disk timestamps.
+ * tv_nsec is a long, so it is cast to unsigned long (the same width) to
+ * catch both an over-large value and one that became negative when an
+ * out-of-range u32 wire nseconds was assigned to a 32-bit long.
+ */
+static bool nfsd3_time_in_range(const struct iattr *iap)
+{
+	if ((iap->ia_valid & ATTR_ATIME_SET) &&
+	    (unsigned long)iap->ia_atime.tv_nsec >= NSEC_PER_SEC)
+		return false;
+	if ((iap->ia_valid & ATTR_MTIME_SET) &&
+	    (unsigned long)iap->ia_mtime.tv_nsec >= NSEC_PER_SEC)
+		return false;
+	return true;
+}
+
 static __be32 nfsd3_map_status(__be32 status)
 {
 	switch (status) {
@@ -94,9 +113,14 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 				SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
+	if (!nfsd3_time_in_range(&argp->attrs)) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 	if (argp->check_guard)
 		guardtime = &argp->guardtime;
 	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs, guardtime);
+out:
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
@@ -272,6 +296,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	/* Validation hooks belong here, before name checks and object creation. */
 
+	if (!nfsd3_time_in_range(iap))
+		return nfserr_inval;
 	if (isdotent(argp->name, argp->len))
 		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
@@ -417,8 +443,13 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
+	if (!nfsd3_time_in_range(&argp->attrs)) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, S_IFDIR, 0, &resp->fh);
+out:
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
@@ -432,6 +463,10 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 		.na_iattr	= &argp->attrs,
 	};
 
+	if (!nfsd3_time_in_range(&argp->attrs)) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 	if (argp->tlen == 0) {
 		resp->status = nfserr_inval;
 		goto out;
@@ -498,6 +533,11 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 		goto out;
 	}
 
+	if (!nfsd3_time_in_range(&argp->attrs)) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
+
 	type = nfs3_ftypes[argp->ftype];
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, type, rdev, &resp->fh);
-- 
2.53.0

