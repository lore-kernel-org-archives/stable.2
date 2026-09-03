Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB844AFE38
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443148; cv=none; b=M/MqsWgYtI5MKXIfU+kiYmkqYCWsYj2Jzf00h+Vggq5c8bgyMOAsMRjK03PqB0vPcrCEzDF3rnunv68Tnnco21ZRgoC8dJZh/iBMT/d+w/OYT5OH9aZPpQ8N6zOtZ4TMet0BvLPl/bEU/4nafPy4+DFeQw7aLn0tBy2hJ/V6JXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443148; c=relaxed/simple;
	bh=R4zbYoUBb9sBIotUKr9L34WJQSZl3OlKEYcwkH2o9uE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u2xQaDdzDUGRjFZtX4aIVi/CbczpFQZgFldZNX2oJvriJg4tlfMm6hypRm043dvVxUaTic8z24ibUrYv8kXg4FNfba5KxaEJuzEHelqXe7ZSnrUrHujle+rHhkmq9sI33Lu9XkftU5xbiMUUB6WMLt3On1/7869E8Ew9aFok0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w8olWo1V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w8olWo1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B2E1F000E9;
	Thu,  3 Sep 2026 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443134;
	bh=pwAf+ampds13JKeuc0SnVs47D+rn+hSARjnukzRaEdE=;
	h=Subject:To:Cc:From:Date;
	b=w8olWo1VUFqrNdCDyOPg/rDqOTz/iNgpYZPtlJ0GFk+hL19I1Ifx2GlXqWFD5A/Gk
	 E0FOLopdPEyWKSxb+WpDSx3RzQgLQRSwZE7pWYBN54mptC6I/EgmxOgl+PFAvwnLDE
	 zb6i3WY4Zvc8jYkTen9XV315nOpAQEWqIdSysBaQ=
Subject: FAILED: patch "[PATCH] nfsd: reject out-of-range nseconds in NFSv3 SETATTR and" failed to apply to 5.15-stable tree
To: robbieko@synology.com,cel@kernel.org,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:19:07 +0200
Message-ID: <2026090307-suave-unlucky-a08a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x eb0eca7720662ba5847df1510e73801f7f473094
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090307-suave-unlucky-a08a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eb0eca7720662ba5847df1510e73801f7f473094 Mon Sep 17 00:00:00 2001
From: Robbie Ko <robbieko@synology.com>
Date: Tue, 16 Jun 2026 13:39:59 +0800
Subject: [PATCH] nfsd: reject out-of-range nseconds in NFSv3 SETATTR and
 create ops

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

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index aeda7a802bdf..617a70d13292 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -29,6 +29,25 @@ static int	nfs3_ftypes[] = {
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
@@ -101,9 +120,14 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
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
@@ -265,6 +289,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_vfs_create(rqstp, fhp, S_IFREG, argp->name, argp->len);
 
+	if (!nfsd3_time_in_range(iap))
+		return nfserr_inval;
 	if (isdotent(argp->name, argp->len))
 		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
@@ -400,8 +426,13 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
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
@@ -415,6 +446,10 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 		.na_iattr	= &argp->attrs,
 	};
 
+	if (!nfsd3_time_in_range(&argp->attrs)) {
+		resp->status = nfserr_inval;
+		goto out;
+	}
 	if (argp->tlen == 0) {
 		resp->status = nfserr_inval;
 		goto out;
@@ -471,6 +506,11 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
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

