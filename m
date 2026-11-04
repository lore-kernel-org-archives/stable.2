Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818940;
	b=zt+MBPYtbp27/nJL7xUPUlwDiqs1Obh+L2CMIs4ijaYv627xI6gl0aw9hjzi+oDMvA5r
	 z8CTkZl7MuCYJ9bSJPeO6pxF3x+bEMuQRxerUMosW9ozuZ/XXJRY2pcLIpEvCntYwR8DB
	 IdBosL6XX41PCRGvFqv6rw3Gi8iwOWPsSLpX9yqq6D58iXwb/Cz5PGwEoLhM5i1M33Cmj
	 FYz36HaYnG4DuXGO1wQpZBymCq3AccoW/m077vdOiLD2bguotLuVwer/go7uppIYi5dHA
	 v5hvMUapEuSz22GYDxM0i/Lxx07y//E6ZhZQu1sl86kgmDpxguA10IjSeWL9zR3BhRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818940;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pFp3TmuucBCO6cwBWK7xdjKtfPMrn+5knkWA2LFr79U=;
	b=CUwEAVie5ybZk2sWSBl02yCBW69HOPAiq3wt3b/WqqH/Gw4+GNdVUYC/WxLfQ9pmox9W
	 gYYXlT7nWnesEMHgwitDujU8/LvLenTnMRUrvkJx70q0iR3kBxSBBrKN+m5EyEbkAmm7U
	 3CNJsBgBadpIaEph4A6ET8ubJPtSKERkmVmmQYKaTc+QdvA/k1/msvsXLDDamDN8fw2gp
	 aqyWJ8p+/OOgstbRSAND/q2zjMGV+dczbuufChRtCUAVAija5MrrsShbKKJaAD3K60QqF
	 7ATCw3cVZyrwUBupwbczbnkIS8S192HSwMGrsdxpell1ok8zZnC1G7LuPMLUPfeaqWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=x0iB4i04;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB12606A338
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=x0iB4i04
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6471F0093A;
	Wed,  4 Nov 2026 19:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818939;
	bh=pFp3TmuucBCO6cwBWK7xdjKtfPMrn+5knkWA2LFr79U=;
	h=Subject:To:Cc:From:Date;
	b=x0iB4i04k4UaXhpmxcuMBk5xuZli0Ff6eAvYWd2yEjnV8hwtmltdFMY+VtmQ3qQ7Q
	 x1W43r2QLvAAkNivEZxZH+lbjFE2jI2XxAHVtstiCAHLfX5pvL7CxlfNYUIFQd5OM8
	 WwgqKVmV5/Zqzz13pqhwos385ZGrJhf4zpBvosrM=
Subject: FAILED: patch "[PATCH] NFSD: Map flex file layout IDs through the request's user" failed to apply to 5.10-stable tree
To: chuck.lever@oracle.com,cel@kernel.org,jlayton@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:02:11 -0500
Message-ID: <2026110411-clothing-unskilled-c8ce@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f913d5d2130a584d1a027ffe3dfd88b6be2e0540
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110411-clothing-unskilled-c8ce@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f913d5d2130a584d1a027ffe3dfd88b6be2e0540 Mon Sep 17 00:00:00 2001
From: Chuck Lever <chuck.lever@oracle.com>
Date: Mon, 20 Jul 2026 12:37:24 -0400
Subject: [PATCH] NFSD: Map flex file layout IDs through the request's user
 namespace

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

diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 9f532418cac8..c6e6b9106a83 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -15,6 +15,7 @@
 
 #include "nfserr.h"
 #include "flexfilelayoutxdr.h"
+#include "auth.h"
 #include "pnfs.h"
 #include "vfs.h"
 
@@ -24,10 +25,10 @@ static __be32
 nfsd4_ff_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
 {
+	struct user_namespace *userns = nfsd_user_namespace(rqstp);
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	u32 device_generation = 0;
 	int error;
-	uid_t u;
 
 	struct pnfs_ff_layout *fl;
 
@@ -50,13 +51,16 @@ nfsd4_ff_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
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
index 97d8a28dd3a0..c12bb7c371b0 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -33,8 +33,8 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 
 	fh_len = 4 + xdr_align_size(fl->fh.size);
 
-	uid.len = sprintf(uid.buf, "%u", from_kuid(&init_user_ns, fl->uid));
-	gid.len = sprintf(gid.buf, "%u", from_kgid(&init_user_ns, fl->gid));
+	uid.len = sprintf(uid.buf, "%u", fl->uid);
+	gid.len = sprintf(gid.buf, "%u", fl->gid);
 
 	/* data server entry: deviceid + efficiency + stateid + fh list +
 	 * user + group + flags + stats_collect_hint
diff --git a/fs/nfsd/flexfilelayoutxdr.h b/fs/nfsd/flexfilelayoutxdr.h
index 6d5a1066a903..3e1876d49db2 100644
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

