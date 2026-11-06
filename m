Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971585;
	b=lUpbCMt7hBkEpDV8R5iVupsli+1EH/txzVNCeEB4GUU+BCYA3gaKFzC53xbioz/PJ/xr
	 ARKEgleqip3q1nEugcP0En9T5QWfrjbUAp6UNfRP/dIYNNWXn/YRgiGpJy7s7c3VWMzoy
	 4BTn8LIhl4RMYKLfariQZiOuRrcVmTCmD8Xw9VjeqaTxrl8iOW/bNlbNkgmdfHlIRA7LU
	 dxqMC2W6zFtgCBgZTD189QOa7tQdrqaMNqQW/gKwZ/8fc5xATRPmio4uszYeDQCNxOFBf
	 M7ZVa4eGBwvvp5gRp4zNmp76ARZoc7FMPAzxCiH3ShDqpl86gAQUntGqSnuqpcKzu8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971585;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GJMMC7PUwXRnLdQ6sH+mU9SRIt1WE5b6wIy/9L6FXGg=;
	b=0fF+wzf8fqv5dHMDjDHSfS3vp6huuW+sFV+5OcSVLr5AHP5grkVIQbD7SxgTCUpePmOL
	 fv0DScnkyAHF7vZnQdCA7YSlEtC2BMwdGrwU9UQm1UYvw71bH2gz3VHZtR/sCO37Ijto3
	 UROsLe7MwqUbCbiCwoHuvEnB5t7FI5VaoopoysvOe4e2+XJ+yzZUinLNME+0uVk6O1AFm
	 WoU1xV0LEL9WP59AAb6Us7TrN6oP//9mDSvU9tjWjEg/H4cbTHRO9L+pn74lEbi5vKH/E
	 q+KgKbST+sf5ZtTwXzXY0QnG7YfMQTEppX2GVqYZRV9YHHJ11Ri3mPjF1JGNDXlPaZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0aK5X5k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39121606A331
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0aK5X5k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4A21F008A2;
	Fri,  6 Nov 2026 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971584;
	bh=GJMMC7PUwXRnLdQ6sH+mU9SRIt1WE5b6wIy/9L6FXGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U0aK5X5kuZ6p1ZznlRrnmDF8/x0a0XAWteeSNJGovTgFQYxotpJNTFqg/3vxqbamm
	 43Yrz7r37Zc+kp68WARaQik5MjNpV5UAtQGV9jHiXUrdltUXCI0tyg/1ddYmL1u775
	 1OlCupyTpENZB+KyrEKyrI+WCKh1PG+RNTUAQhGSrmXsHc9gtgk8stI7xKHx0BKCiv
	 0sVvaihmFwv0jdfbH4KEnUxxNP/oFgXbYIIuHy37WiDwmZHOQPs3BYxiMtAlsYaRD2
	 iIpJN+hBypz1KojFx0jaRirgktiHkGbjQhiIgtQG3rpsUoivHaVbImP1NqZqCNkDKO
	 AQHlYNoteNx4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] NFSD: Map flex file layout IDs through the request's user namespace
Date: Fri,  6 Nov 2026 08:26:23 -0500
Message-ID: <20261106132600.78517-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110410-obvious-deplored-2c50@gregkh>
References: <2026110410-obvious-deplored-2c50@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit f913d5d2130a584d1a027ffe3dfd88b6be2e0540 ]

nfsd4_ff_proc_layoutget() and nfsd4_ff_encode_layoutget() translate
the file's owner and group with init_user_ns, but every other identity
nfsd places on the wire goes through nfsd_user_namespace(). When the
transport carries a credential from a non-initial user namespace, the
flex file layout reports host-global IDs. The client copies those IDs
into the AUTH_SYS credential it presents to the data server, and
svcauth_unix_accept() resolves that credential in the transport's
namespace, so data server I/O runs under an identity unrelated to the
file's owner.

Switching to the request's namespace introduces a second hazard.
from_kuid() returns (uid_t)-1 when the target namespace has no
mapping for the owner, and the IOMODE_READ arm adds one to that
result to derive an identity for which the data server denies
writes. The addition would wrap to zero, handing the client uid 0
instead of an identity distinct from the owner.

Translate both IDs in nfsd4_ff_proc_layoutget(), which has the
svc_rqst, and carry the wire values in struct pnfs_ff_layout.
from_kuid_munged() substitutes overflowuid for an unmapped owner and
thus never returns (uid_t)-1, so the increment cannot wrap to zero.

Fixes: 9b9960a0ca47 ("nfsd: Add a super simple flex file server")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260720141442.783935-1-cel@kernel.org?part=3
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260720163724.810227-1-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
[ sashal: Extended the proc_layoutget callback interface to pass rqstp from nfsd4_layoutget(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/blocklayout.c       |  4 ++--
 fs/nfsd/flexfilelayout.c    | 24 ++++++++++++++----------
 fs/nfsd/flexfilelayoutxdr.c |  4 ++--
 fs/nfsd/flexfilelayoutxdr.h |  5 +++--
 fs/nfsd/nfs4proc.c          |  2 +-
 fs/nfsd/pnfs.h              |  4 ++--
 6 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 55d98062077ef..d7189f3deb683 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -22,8 +22,8 @@
 
 
 static __be32
-nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
-		struct nfsd4_layoutget *args)
+nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
+		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct super_block *sb = inode->i_sb;
diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 041466513641c..9a681e032bfb6 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -14,19 +14,20 @@
 #include <linux/sunrpc/addr.h>
 
 #include "flexfilelayoutxdr.h"
+#include "auth.h"
 #include "pnfs.h"
 #include "vfs.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
 static __be32
-nfsd4_ff_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
-		struct nfsd4_layoutget *args)
+nfsd4_ff_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
+		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
 {
+	struct user_namespace *userns = nfsd_user_namespace(rqstp);
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	u32 device_generation = 0;
 	int error;
-	uid_t u;
 
 	struct pnfs_ff_layout *fl;
 
@@ -49,13 +50,16 @@ nfsd4_ff_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
 	fl->flags = FF_FLAGS_NO_LAYOUTCOMMIT | FF_FLAGS_NO_IO_THRU_MDS |
 		    FF_FLAGS_NO_READ_IO;
 
-	/* Do not allow a IOMODE_READ segment to have write pemissions */
-	if (seg->iomode == IOMODE_READ) {
-		u = from_kuid(&init_user_ns, inode->i_uid) + 1;
-		fl->uid = make_kuid(&init_user_ns, u);
-	} else
-		fl->uid = inode->i_uid;
-	fl->gid = inode->i_gid;
+	fl->uid = from_kuid_munged(userns, inode->i_uid);
+	fl->gid = from_kgid_munged(userns, inode->i_gid);
+
+	/*
+	 * Do not allow an IOMODE_READ segment to have write permissions.
+	 * The group is left intact so group-readable files stay readable;
+	 * nfsd_setuser() squashes an unmapped uid to the export's anon ID.
+	 */
+	if (seg->iomode == IOMODE_READ)
+		fl->uid++;
 
 	error = nfsd4_set_deviceid(&fl->deviceid, fhp, device_generation);
 	if (error)
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index c05d1d3e20210..4bfdfee1bf9ce 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -32,8 +32,8 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 
 	fh_len = 4 + xdr_align_size(fl->fh.size);
 
-	uid.len = sprintf(uid.buf, "%u", from_kuid(&init_user_ns, fl->uid));
-	gid.len = sprintf(gid.buf, "%u", from_kgid(&init_user_ns, fl->gid));
+	uid.len = sprintf(uid.buf, "%u", fl->uid);
+	gid.len = sprintf(gid.buf, "%u", fl->gid);
 
 	/* data server entry: deviceid + efficiency + stateid + fh list +
 	 * user + group + flags + stats_collect_hint
diff --git a/fs/nfsd/flexfilelayoutxdr.h b/fs/nfsd/flexfilelayoutxdr.h
index 8e195aeca0237..3e2dc4d070f8d 100644
--- a/fs/nfsd/flexfilelayoutxdr.h
+++ b/fs/nfsd/flexfilelayoutxdr.h
@@ -35,8 +35,9 @@ struct pnfs_ff_device_addr {
 struct pnfs_ff_layout {
 	u32				flags;
 	u32				stats_collect_hint;
-	kuid_t				uid;
-	kgid_t				gid;
+	/* Values to encode; nfsd4_ff_proc_layoutget() has mapped these */
+	u32				uid;
+	u32				gid;
 	struct nfsd4_deviceid		deviceid;
 	stateid_t			stateid;
 	struct nfs_fh			fh;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 556396ae846bb..e993a72dc8298 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2258,7 +2258,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	if (atomic_read(&ls->ls_stid.sc_file->fi_lo_recalls))
 		goto out_put_stid;
 
-	nfserr = ops->proc_layoutget(d_inode(current_fh->fh_dentry),
+	nfserr = ops->proc_layoutget(rqstp, d_inode(current_fh->fh_dentry),
 				     current_fh, lgp);
 	if (nfserr)
 		goto out_put_stid;
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index 4f4282d4eeca4..c29de1795b2cb 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -29,8 +29,8 @@ struct nfsd4_layout_ops {
 	__be32 (*encode_getdeviceinfo)(struct xdr_stream *xdr,
 			struct nfsd4_getdeviceinfo *gdevp);
 
-	__be32 (*proc_layoutget)(struct inode *, const struct svc_fh *fhp,
-			struct nfsd4_layoutget *lgp);
+	__be32 (*proc_layoutget)(struct svc_rqst *rqstp, struct inode *inode,
+			const struct svc_fh *fhp, struct nfsd4_layoutget *lgp);
 	__be32 (*encode_layoutget)(struct xdr_stream *,
 			struct nfsd4_layoutget *lgp);
 
-- 
2.53.0

