Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1A13CFF4C
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701698; cv=none; b=lDmQiHDkLRU4UfKOHvpY7EfxD9TLzDwfseYw2RAsRhys0A0Jt1I41Y6GXOES6C0Y01tahT7o/jaR9TKw8GYf0B4oFbJBpmXDTBWQiM9hj3qz5d8I/BP9bNSH83UWQBXQPZFy23rBkY/qzQunJP1amnd9lG+WWDxKtrmC4Wqzq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701698; c=relaxed/simple;
	bh=ZXVNZAoW/ogUzWMe8wbA0K+5x4Bh+9IPhquGTkqUZj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmBr/acXdT8HP5efpmlD0WkzBr1Yijn1NTqZ7q05d8doxhLz+PSoKNW9Y/fcM/aSrf16cIlLA7FDvr702YZw9MedqL5Fzuwj5DbcOJFs9HraCfTuUNljXY+ST7bvZp3M8hiFHUDBzkd4R5n5/8L5PygAzykh7sZd3Emjwr0oHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHZ9vWHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHZ9vWHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E224B1F00A3A;
	Sun,  6 Sep 2026 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701696;
	bh=pL8L1260CKVljHNXNRLUrF7Lq7dWzynOLcPitKUkpTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WHZ9vWHT+c+SReRzcDqdR2wEp3/zSVz0IUQOxrVyDi6Q3A3D/J8TErRNZ/FfanNpO
	 eFkDeRjDKua13+PeU70PP/WjiC8+T/61ljeHUlzgNOzmKmy9TTxqjd+Vpdg+F4v1HV
	 LCvnxPfUVgJwP8nxcITbiIaPBXlKFELDWUn7D0GF8hB7t4IU4/26nYyX1RVIFgoYxZ
	 1t4OYk0gnMEaaTFfoogZexZ5VgAXc74PQ5Tj45cicXx4pBho9PXoCpr28pTEbDNJy5
	 2q08k2trCd5oro7XARbCmbdpHVMK0bnAnfIu5wFH1YrrEsI38800iSkdT88bpR9B9g
	 7EawC3w1PJjuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] nfsd: update mtime/ctime on COPY in presence of delegated attributes
Date: Sun,  6 Sep 2026 09:34:53 -0400
Message-ID: <20260906133454.899083-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-excavate-aside-0c00@gregkh>
References: <2026090322-excavate-aside-0c00@gregkh>
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
index a4c7cab1679bd..63a4825dd15f3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1799,12 +1799,15 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -1822,6 +1825,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 out:
 	release_copy_files(copy);
 	return status;
+out_dec_async_copy_err:
 out_err:
 	if (nfsd4_ssc_is_inter(copy)) {
 		/*
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c989398eb4d8c..ae14fa145d02e 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -598,6 +598,7 @@ struct nfsd4_copy {
 
 	struct nfsd_file        *nf_src;
 	struct nfsd_file        *nf_dst;
+	bool			attr_update;
 
 	copy_stateid_t		cp_stateid;
 
-- 
2.53.0

