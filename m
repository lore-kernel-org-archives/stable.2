Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5975474E
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644613; cv=none; b=sNEEGT2t6LHNlC4Wk6GZpdeRh2m75j0fDMrPpkXNxvc1p7te4M6INnRDfGQPWQtayPBGn7tOZQpWtd8LAKo4iWkuOCJKM+fJ2pQKclB1Y/FxkecogU0G3r+PLMGEAc5zOj/4NWEq5p3iPH/hOPYz/i4KFUvXE4qYEDwqQ2hOMYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644613; c=relaxed/simple;
	bh=wUx9IsxbyWWEAsXtFz63kGizeLgOcW2psjP9A1IgVRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5w7XRUKTFEQwvRTlw67J0GqGJjjsk/Aqf5UulXbey/othw94XZ5L4/0QWAB9jDGtb45l5WaXrUDi3GMVQ8LpNcOxnC9ngoaECiHeNoCP2i1qk7/PedcoJaLRa8iiHOsBQolUldreKIDXe10Jzr8JYqdQvC24gZZd/yJAeOnKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onHtLLS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onHtLLS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E11A1F00A3A;
	Sat,  5 Sep 2026 21:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644611;
	bh=yucpB8F4sKQnP4+OULHD8zzUZuMKeKccOAPMr3cBtCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=onHtLLS3IwyNNUy/SyH5aielTP7LSQ5gpktqf3rDgA7EdUg8vRp0DwhOScax3bKu+
	 42EC4DR2lr8NlM/+3JbAa5B8XvdoGMrv52knLvJmNyyB4BwX2o3cmmEtyYLXbo9FXd
	 xnrhlrpme/JFlPTU+L37NjbPokcjWeGoqXMAwBAyLf0KztNu7woJ0TcJuKiVjgDUWd
	 wGsixTWKbiafgUlQQ3ZgGsGAtLhzQ7GU8v66C0nxGSJyNWFtraTdBGIbo1W8f6r0Eh
	 iS8ZkKSt6C81Mmq06Zp5T8mUNtgx6GD0/Ce9m1GJsRC6P1YZyScbHUbvnW0GlVJEWi
	 7252CCIH/4Qzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] nfsd: update mtime/ctime on COPY in presence of delegated attributes
Date: Sat,  5 Sep 2026 17:43:28 -0400
Message-ID: <20260905214329.701331-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090320-unvocal-subtitle-0ff5@gregkh>
References: <2026090320-unvocal-subtitle-0ff5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <okorniev@redhat.com>

[ Upstream commit 4183cf383b6faec17a0882b84cd2d901dba62b16 ]

When delegated attributes are given on open, the file is opened with
NOCMTIME and modifying operations do not update mtime/ctime as to not get
out-of-sync with the client's delegated view. However, for COPY operation,
the server should update its view of mtime/ctime and reflect that in any
GETATTR queries.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Cc: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

[ Stable adaptation: Linux 6.12 does not contain the Fixes commit or
nfsd_update_cmtime_attr(), so omit the timestamp-update call sites. Keep the
attr_update context needed by d0beaee498e1 ("nfsd: fix stale s2s_cp_stateids
IDR entry for async COPY"), and alias its newer error label to the existing
6.12 cleanup path. ]

Stable-dep-of: d0beaee498e1 ("nfsd: fix stale s2s_cp_stateids IDR entry for async COPY")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 8 ++++++--
 fs/nfsd/xdr4.h     | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5767080362e85..9812360931819 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1831,12 +1831,15 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_err;
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
-			goto out_err;
+			goto out_dec_async_copy_err;
 		if (!nfs4_init_copy_state(nn, copy))
-			goto out_err;
+			goto out_dec_async_copy_err;
 		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
 		dup_copy_fields(copy, async_copy);
+		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
+			       FMODE_NOCMTIME) != 0)
+			async_copy->attr_update = true;
 		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
 				async_copy, "%s", "copy thread");
 		if (IS_ERR(async_copy->copy_task))
@@ -1854,6 +1857,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 out:
 	release_copy_files(copy);
 	return status;
+out_dec_async_copy_err:
 out_err:
 	if (nfsd4_ssc_is_inter(copy)) {
 		/*
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index a83a52b0f5181..ec8d532001290 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -598,6 +598,7 @@ struct nfsd4_copy {
 
 	struct nfsd_file        *nf_src;
 	struct nfsd_file        *nf_dst;
+	bool			attr_update;
 
 	copy_stateid_t		cp_stateid;
 
-- 
2.53.0

