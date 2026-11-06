Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929984;
	b=VEjypiz9E4VPFbw12CHxm2vNKzZqFJADF9s8WJ6bal/vWzfu5LfMu/It+pw/kOgDwb2C
	 8/gb+LSF7+GAHH95QK6MgIvBBrZyZQsPK5ebxc0rptd12oEqRk564nD8EsR5ZNin2IT77
	 mS93NpwvrFo3kDXLOFzM+4TlX0WOuFtOpKqR8O5Y3ebGJ1d2beiVcIB64w0qkayiEUfzo
	 mDOxpspP49Dw4HZDrFuI79uIWMskAyOKTT1dV+jhBajgGAfO7i5MH/aWYQcQwFndAGglL
	 PMx2o9EzlyA5hArpQRetr3eTyn7tbWqIyiGnxTtiSm8lC7JzVGApo1WcRhY9gjtmxmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929984;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ab5MPyD6fpoEy2U4ecu3XRi7sNLVpZ+OjiiSq7aBEvM=;
	b=KK9CTdygALPiiLZeYBDGsvB6NbtSKnEVEVh8fNhq8Z02UiUFydtyD+5gcu1bsP+w7n5E
	 K4/PPDFrKVveBRq42WdK8hI49SODvRBQ9Iz5RLuFIbKawbtB5FVMwhLNUI1hsyzY0aYCv
	 m5VBqp4xsZtd7byIwpw74VVPhkmEZoKKK83Sr0wZ6WZKTwSI4hys1JR01WdfjvLEvVpwu
	 KPetL0HcqsSrXAqEgcxjxFwAet3p7qEHtrZjnCvKymZUihwYGU2bOOyTNcadwNlZdldMc
	 6Q1GUhgoyJXACI/mp3KF1N7ee9irGnUpEInrwuSlXmhhl2BbozzXrDcmSO2OnG92kpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1Jfj2rE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED6606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1Jfj2rE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E667E1F008A1;
	Fri,  6 Nov 2026 01:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793929983;
	bh=Ab5MPyD6fpoEy2U4ecu3XRi7sNLVpZ+OjiiSq7aBEvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c1Jfj2rE/cOzdB+EKsSNBRL9GMHNsyJXubxMIBeQz6MX8q8LvlGMTOCxFoldX/uAm
	 3IRE/BY84XBVvLta5CdRRvFO6gug9zYToBuIBwlmLyis0OlAzOqMGMBw1idGnF9TKl
	 ZD4/hYDaF9U55Ro8W5QPbtPDUGc1Mw3HQmHo7e3QVd6rkFVYMoEK851c29YRBFICkL
	 c1F6UlNtWyUyGA9YTUIqvfoUg85rvacnBxpFwJKCF9bRVnw+EnH5POBau7ojJfSlDP
	 oeZymGhwrRUWmbwTL48/DGbDbe+M486RUkLxwphTUPxbgpb3B2L0sRDSWkmIeLo/Bc
	 ZN75FK0xwwReA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/3] NFSD: Move version-specific ACCESS maps into per-version code
Date: Thu,  5 Nov 2026 20:52:59 -0500
Message-ID: <20261106015247.3620698-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106015247.3620698-1-sashal@kernel.org>
References: <2026110436-sputter-backdrop-7c80@gregkh>
 <20261106015247.3620698-1-sashal@kernel.org>
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

[ Upstream commit 3423b5f91d80d3a76424e1c9f1d0f95d4dd80101 ]

nfsd_access() owns three static tables that map on-the-wire ACCESS
bits to NFSD_MAY flags, and every NFS version shares them. That puts
protocol-version specifics in the version-agnostic VFS layer. The
NFSv4.2 extended-attribute bits are wedged into the NFSv3 tables
under CONFIG_NFSD_V4.

Give each version its own tables in its proc code and pass the
matching set into nfsd_access() as a new argument.

Splitting the tables also stops the NFSv2-ACL and NFSv3 ACCESS paths
from answering for the NFSv4.2 extended-attribute bits. Both use the
NFSv4-augmented table whenever CONFIG_NFSD_V4 is set, so an NFSv3
request that sets an xattr bit has it echoed back in the reply even
though those bits are undefined for v3.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260810141900.33846-2-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Stable-dep-of: ccfc4db5ab74 ("NFSD: map fh_verify() status codes for NFS_ACLv2 replies")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs2acl.c  | 46 ++++++++++++++++++++++++++-
 fs/nfsd/nfs3proc.c | 41 +++++++++++++++++++++++-
 fs/nfsd/nfs4proc.c | 42 +++++++++++++++++++++++--
 fs/nfsd/vfs.c      | 78 ++++++++++------------------------------------
 fs/nfsd/vfs.h      | 15 ++++++++-
 5 files changed, 155 insertions(+), 67 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 190f5a0019009..f978aa2be36aa 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -15,6 +15,48 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
+/*
+ * These maps are identical to the NFSv3 maps (nfs3proc.c). This enables
+ * the behavior of the two versions to diverge if needed.
+ */
+static const struct nfsd_access_map nfsd2_regaccess[] = {
+	{ NFS3_ACCESS_READ,	NFSD_MAY_READ				},
+	{ NFS3_ACCESS_EXECUTE,	NFSD_MAY_EXEC				},
+	{ NFS3_ACCESS_MODIFY,	NFSD_MAY_WRITE|NFSD_MAY_TRUNC		},
+	{ NFS3_ACCESS_EXTEND,	NFSD_MAY_WRITE				},
+	{ 0,			0					}
+};
+
+static const struct nfsd_access_map nfsd2_diraccess[] = {
+	{ NFS3_ACCESS_READ,	NFSD_MAY_READ				},
+	{ NFS3_ACCESS_LOOKUP,	NFSD_MAY_EXEC				},
+	{ NFS3_ACCESS_MODIFY,	NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC },
+	{ NFS3_ACCESS_EXTEND,	NFSD_MAY_EXEC|NFSD_MAY_WRITE		},
+	{ NFS3_ACCESS_DELETE,	NFSD_MAY_REMOVE				},
+	{ 0,			0					}
+};
+
+/*
+ * Some clients - Solaris 2.6 at least, make an access call to the NFS
+ * server to check for access for things like /dev/null (which really,
+ * NFSD doesn't care about).  So NFSD provides simple access checking
+ * for those objects, looking mainly at mode bits, ignoring read-only
+ * filesystem checks.
+ */
+static const struct nfsd_access_map nfsd2_otheraccess[] = {
+	{ NFS3_ACCESS_READ,	NFSD_MAY_READ				},
+	{ NFS3_ACCESS_EXECUTE,	NFSD_MAY_EXEC				},
+	{ NFS3_ACCESS_MODIFY,	NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS	},
+	{ NFS3_ACCESS_EXTEND,	NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS	},
+	{ 0,			0					}
+};
+
+static const struct nfsd_access_maps nfsd2_access_maps = {
+	.regular	= nfsd2_regaccess,
+	.directory	= nfsd2_diraccess,
+	.other		= nfsd2_otheraccess,
+};
+
 /*
  * NULL call.
  */
@@ -180,7 +222,9 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->access = argp->access;
-	resp->status = nfsd_access(rqstp, &resp->fh, &resp->access, NULL);
+
+	resp->status = nfsd_access(rqstp, &resp->fh, &nfsd2_access_maps,
+				   &resp->access, NULL);
 	if (resp->status != nfs_ok)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 7d8ddb7bfab0c..b3c6341907018 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -48,6 +48,44 @@ static bool nfsd3_time_in_range(const struct iattr *iap)
 	return true;
 }
 
+static const struct nfsd_access_map nfsd3_regaccess[] = {
+	{ NFS3_ACCESS_READ,	NFSD_MAY_READ				},
+	{ NFS3_ACCESS_EXECUTE,	NFSD_MAY_EXEC				},
+	{ NFS3_ACCESS_MODIFY,	NFSD_MAY_WRITE|NFSD_MAY_TRUNC		},
+	{ NFS3_ACCESS_EXTEND,	NFSD_MAY_WRITE				},
+	{ 0,			0					}
+};
+
+static const struct nfsd_access_map nfsd3_diraccess[] = {
+	{ NFS3_ACCESS_READ,	NFSD_MAY_READ				},
+	{ NFS3_ACCESS_LOOKUP,	NFSD_MAY_EXEC				},
+	{ NFS3_ACCESS_MODIFY,	NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC },
+	{ NFS3_ACCESS_EXTEND,	NFSD_MAY_EXEC|NFSD_MAY_WRITE		},
+	{ NFS3_ACCESS_DELETE,	NFSD_MAY_REMOVE				},
+	{ 0,			0					}
+};
+
+/*
+ * Some clients - Solaris 2.6 at least, make an access call to the NFS
+ * server to check for access for things like /dev/null (which really,
+ * NFSD doesn't care about).  So NFSD provides simple access checking
+ * for those objects, looking mainly at mode bits, ignoring read-only
+ * filesystem checks.
+ */
+static const struct nfsd_access_map nfsd3_otheraccess[] = {
+	{ NFS3_ACCESS_READ,	NFSD_MAY_READ				},
+	{ NFS3_ACCESS_EXECUTE,	NFSD_MAY_EXEC				},
+	{ NFS3_ACCESS_MODIFY,	NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS	},
+	{ NFS3_ACCESS_EXTEND,	NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS	},
+	{ 0,			0					}
+};
+
+static const struct nfsd_access_maps nfsd3_access_maps = {
+	.regular	= nfsd3_regaccess,
+	.directory	= nfsd3_diraccess,
+	.other		= nfsd3_otheraccess,
+};
+
 static int nfsd3_iocb_flags(enum nfs3_stable_how how)
 {
 	switch (how) {
@@ -185,7 +223,8 @@ nfsd3_proc_access(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->access = argp->access;
-	resp->status = nfsd_access(rqstp, &resp->fh, &resp->access, NULL);
+	resp->status = nfsd_access(rqstp, &resp->fh, &nfsd3_access_maps,
+				   &resp->access, NULL);
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9ee02a6d00868..f19d8ed80a9dd 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -69,6 +69,43 @@ MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
+static const struct nfsd_access_map nfsd4_regaccess[] = {
+	{ NFS4_ACCESS_READ,	NFSD_MAY_READ				},
+	{ NFS4_ACCESS_EXECUTE,	NFSD_MAY_EXEC				},
+	{ NFS4_ACCESS_MODIFY,	NFSD_MAY_WRITE|NFSD_MAY_TRUNC		},
+	{ NFS4_ACCESS_EXTEND,	NFSD_MAY_WRITE				},
+	{ NFS4_ACCESS_XAREAD,	NFSD_MAY_READ				},
+	{ NFS4_ACCESS_XAWRITE,	NFSD_MAY_WRITE				},
+	{ NFS4_ACCESS_XALIST,	NFSD_MAY_READ				},
+	{ 0,			0					}
+};
+
+static const struct nfsd_access_map nfsd4_diraccess[] = {
+	{ NFS4_ACCESS_READ,	NFSD_MAY_READ				},
+	{ NFS4_ACCESS_LOOKUP,	NFSD_MAY_EXEC				},
+	{ NFS4_ACCESS_MODIFY,	NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC },
+	{ NFS4_ACCESS_EXTEND,	NFSD_MAY_EXEC|NFSD_MAY_WRITE		},
+	{ NFS4_ACCESS_DELETE,	NFSD_MAY_REMOVE				},
+	{ NFS4_ACCESS_XAREAD,	NFSD_MAY_READ				},
+	{ NFS4_ACCESS_XAWRITE,	NFSD_MAY_WRITE				},
+	{ NFS4_ACCESS_XALIST,	NFSD_MAY_READ				},
+	{ 0,			0					}
+};
+
+static const struct nfsd_access_map nfsd4_otheraccess[] = {
+	{ NFS4_ACCESS_READ,	NFSD_MAY_READ				},
+	{ NFS4_ACCESS_EXECUTE,	NFSD_MAY_EXEC				},
+	{ NFS4_ACCESS_MODIFY,	NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS	},
+	{ NFS4_ACCESS_EXTEND,	NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS	},
+	{ 0,			0					}
+};
+
+static const struct nfsd_access_maps nfsd4_access_maps = {
+	.regular	= nfsd4_regaccess,
+	.directory	= nfsd4_diraccess,
+	.other		= nfsd4_otheraccess,
+};
+
 static int nfsd4_iocb_flags(enum stable_how4 how)
 {
 	switch (how) {
@@ -809,10 +846,9 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (access->ac_req_access & ~access_full)
 		return nfserr_inval;
-
 	access->ac_resp_access = access->ac_req_access;
-	return nfsd_access(rqstp, &cstate->current_fh, &access->ac_resp_access,
-			   &access->ac_supported);
+	return nfsd_access(rqstp, &cstate->current_fh, &nfsd4_access_maps,
+			   &access->ac_resp_access, &access->ac_supported);
 }
 
 static __be32
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fe27f6b404268..792c0b327755f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -773,64 +773,21 @@ __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
 }
 #endif /* defined(CONFIG_NFSD_V4) */
 
-/*
- * Check server access rights to a file system object
+/**
+ * nfsd_access - Check caller's access rights to a file system object
+ * @rqstp: RPC transaction context
+ * @fhp: target NFS filehandle
+ * @maps: tables mapping on-the-wire access bits to NFSD_MAY flags
+ * @access: requested access bits on entry, permitted bits on return
+ * @supported: optional output of the access bits the server supports
+ *
+ * Return: nfs_ok on success, otherwise an nfserr status code
  */
-struct accessmap {
-	u32		access;
-	int		how;
-};
-static struct accessmap	nfs3_regaccess[] = {
-    {	NFS3_ACCESS_READ,	NFSD_MAY_READ			},
-    {	NFS3_ACCESS_EXECUTE,	NFSD_MAY_EXEC			},
-    {	NFS3_ACCESS_MODIFY,	NFSD_MAY_WRITE|NFSD_MAY_TRUNC	},
-    {	NFS3_ACCESS_EXTEND,	NFSD_MAY_WRITE			},
-
-#ifdef CONFIG_NFSD_V4
-    {	NFS4_ACCESS_XAREAD,	NFSD_MAY_READ			},
-    {	NFS4_ACCESS_XAWRITE,	NFSD_MAY_WRITE			},
-    {	NFS4_ACCESS_XALIST,	NFSD_MAY_READ			},
-#endif
-
-    {	0,			0				}
-};
-
-static struct accessmap	nfs3_diraccess[] = {
-    {	NFS3_ACCESS_READ,	NFSD_MAY_READ			},
-    {	NFS3_ACCESS_LOOKUP,	NFSD_MAY_EXEC			},
-    {	NFS3_ACCESS_MODIFY,	NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC},
-    {	NFS3_ACCESS_EXTEND,	NFSD_MAY_EXEC|NFSD_MAY_WRITE	},
-    {	NFS3_ACCESS_DELETE,	NFSD_MAY_REMOVE			},
-
-#ifdef CONFIG_NFSD_V4
-    {	NFS4_ACCESS_XAREAD,	NFSD_MAY_READ			},
-    {	NFS4_ACCESS_XAWRITE,	NFSD_MAY_WRITE			},
-    {	NFS4_ACCESS_XALIST,	NFSD_MAY_READ			},
-#endif
-
-    {	0,			0				}
-};
-
-static struct accessmap	nfs3_anyaccess[] = {
-	/* Some clients - Solaris 2.6 at least, make an access call
-	 * to the server to check for access for things like /dev/null
-	 * (which really, the server doesn't care about).  So
-	 * We provide simple access checking for them, looking
-	 * mainly at mode bits, and we make sure to ignore read-only
-	 * filesystem checks
-	 */
-    {	NFS3_ACCESS_READ,	NFSD_MAY_READ			},
-    {	NFS3_ACCESS_EXECUTE,	NFSD_MAY_EXEC			},
-    {	NFS3_ACCESS_MODIFY,	NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS	},
-    {	NFS3_ACCESS_EXTEND,	NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS	},
-
-    {	0,			0				}
-};
-
-__be32
-nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *supported)
+__be32 nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		   const struct nfsd_access_maps *maps,
+		   u32 *access, u32 *supported)
 {
-	struct accessmap	*map;
+	const struct nfsd_access_map *map;
 	struct svc_export	*export;
 	struct dentry		*dentry;
 	u32			query, result = 0, sresult = 0;
@@ -844,12 +801,11 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
 	dentry = fhp->fh_dentry;
 
 	if (d_is_reg(dentry))
-		map = nfs3_regaccess;
+		map = maps->regular;
 	else if (d_is_dir(dentry))
-		map = nfs3_diraccess;
+		map = maps->directory;
 	else
-		map = nfs3_anyaccess;
-
+		map = maps->other;
 
 	query = *access;
 	for  (; map->access; map++) {
@@ -859,7 +815,7 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
 			sresult |= map->access;
 
 			err2 = nfsd_permission(&rqstp->rq_cred, export,
-					       dentry, map->how);
+					       dentry, map->may);
 			switch (err2) {
 			case nfs_ok:
 				result |= map->access;
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 5937bd78d4291..bdb58422a3fbd 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -37,6 +37,17 @@
 #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
 #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
 
+struct nfsd_access_map {
+	u32		access;
+	int		may;
+};
+
+struct nfsd_access_maps {
+	const struct nfsd_access_map	*regular;
+	const struct nfsd_access_map	*directory;
+	const struct nfsd_access_map	*other;
+};
+
 struct nfsd_file;
 
 /*
@@ -100,7 +111,9 @@ __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct nfsd_attrs *attrs,
 				int type, dev_t rdev, struct svc_fh *res);
-__be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
+__be32		nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
+				const struct nfsd_access_maps *maps,
+				u32 *access, u32 *supported);
 __be32		nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct svc_fh *resfhp, struct nfsd_attrs *iap);
 __be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
-- 
2.53.0

