Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483103CBE6E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795724; cv=none; b=uS3cW2ZJ2dA3W9UhDs2hmoe4BiyX6PLvy3sXoXIKIHljAtTZdo09yZgyVVJrSvQFL1dPI4lIIPXHji7jJzacOv+a8T9EeKJ9LV294+NUqDhb6JU8A7iROsVhfCrpEKwTWF5WQGOVUMxZZN2vM+WmRPZWLPhHjYwnJ41T7UTo0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795724; c=relaxed/simple;
	bh=t+aB8jzeApKHm6rSfNDzuLqAZJn5N0/mZZfYZybIib8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVoFM5G9dw5oqVDu6ek8m0AP84X0iEufXX0w5lZZ3GFMsANpH9EtKWRH2LQg9HsumPAR5AKvI5Snzhj67iUm3iayzrkzEBYyHcShmOWdd2ZkMJlwgmAvsGFfWP4B+MBiGSZ6jByVf752wxZQfH6bsDFfJxlQ514JxqQ0OGyBDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqOpclaQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqOpclaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3191F00898;
	Wed, 30 Sep 2026 19:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790795723;
	bh=Ym7HK+pU2PQzT+7dU6L3bZSoFrD7fiIGSvz/fbp8TF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gqOpclaQoLmDXsQgcZiVAGQlucCcMSpmrUcdjao8QkRzylXPPZhAAgDogiIcQgYGL
	 ObVGiq34BostgAqYpF583WHEjzCpZM05/tYAkwR+RYa/rmEO9evH8hxhXfjvK894C/
	 7MnUiT05VIQO66ZjHNo1NgzSDSwf6Z1wF77BJpJw1KngeM5QSP9zzTY7bcza0r+dpb
	 R7dLajTG80uiixR3B4moAdQt7mZo+BT0nELSvbFC5GQYWap8HH83tBjiXCcP4RHlAe
	 Z3CfXOgeNo1Wj0QbkhEDk5t7UlpKb5eGtpsXOWwxy/7dBhjHLJ3uK+K3tVX5j7Vrqt
	 kJBxh/XhvmOfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: clean up failed cached directory opens
Date: Wed, 30 Sep 2026 15:15:20 -0400
Message-ID: <20260930191520.524028-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092903-oyster-vicinity-b159@gregkh>
References: <2026092903-oyster-vicinity-b159@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit d2ff5fb93ea83034025850266b5eed391f96b825 ]

open_cached_dir() sends CREATE and QUERY_INFO as a compound request. If
the CREATE succeeds but a later command returns an error, the function
must retain the CREATE FID so common cleanup can issue SMB2_close(). It
also must not treat a response error as a valid CREATE.

Validate the CREATE response before using its fields, record the FIDs, and
mark the handle open before handling errors from later compound commands.
Move the -EREMCHG reconnect handling before response validation so a
missing response does not hide the reconnect request. Count the handle
when it is marked open; confirmed close responses decrement the counter,
while existing close retry behavior remains best effort on transport
failures.

Fixes: b0f6df737a1c ("cifs: cache FILE_ALL_INFO for the shared root handle")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Tested-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Adapted cached-directory cleanup to the older shared-root cache in fs/cifs/smb2ops.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 54 ++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 3aaa45375d8ba..1539e834e8b55 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -761,6 +761,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	u8 oplock = SMB2_OPLOCK_LEVEL_II;
 	struct cifs_fid *pfid;
 	struct dentry *dentry;
+	bool is_open = false;
 
 	if (tcon->nohandlecache)
 		return -ENOTSUPP;
@@ -843,6 +844,28 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	rc = compound_send_recv(xid, ses, server,
 				flags, 2, rqst,
 				resp_buftype, rsp_iov);
+	if (rc == -EREMCHG) {
+		tcon->need_reconnect = true;
+		pr_warn_once("server share %s deleted\n",
+			     tcon->treeName);
+	}
+
+	if (!rsp_iov[0].iov_base || rsp_iov[0].iov_len < sizeof(*o_rsp)) {
+		if (!rc)
+			rc = -EIO;
+		goto oshr_free;
+	}
+
+	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
+	if (o_rsp->hdr.Status != STATUS_SUCCESS) {
+		if (!rc)
+			rc = -EIO;
+		goto oshr_free;
+	}
+
+	is_open = true;
+	atomic_inc(&tcon->num_remote_opens);
+
 	mutex_lock(&tcon->crfid.fid_mutex);
 
 	/*
@@ -855,8 +878,8 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 
 		/* stash fids for close() later */
 		struct cifs_fid fid = {
-			.persistent_fid = pfid->persistent_fid,
-			.volatile_fid = pfid->volatile_fid,
+			.persistent_fid = o_rsp->PersistentFileId,
+			.volatile_fid = o_rsp->VolatileFileId,
 		};
 
 		/*
@@ -867,26 +890,17 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 
 		mutex_unlock(&tcon->crfid.fid_mutex);
 
-		if (rc == 0) {
-			/* close extra handle outside of crit sec */
-			SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
-		}
+		/* close extra handle outside of crit sec */
+		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 		rc = 0;
 		goto oshr_free;
 	}
 
 	/* Cached root is still invalid, continue normaly */
 
-	if (rc) {
-		if (rc == -EREMCHG) {
-			tcon->need_reconnect = true;
-			pr_warn_once("server share %s deleted\n",
-				     tcon->treeName);
-		}
+	if (rc)
 		goto oshr_exit;
-	}
 
-	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
 	oparms.fid->persistent_fid = o_rsp->PersistentFileId;
 	oparms.fid->volatile_fid = o_rsp->VolatileFileId;
 #ifdef CONFIG_CIFS_DEBUG2
@@ -936,17 +950,13 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 oshr_free:
 	SMB2_open_free(&rqst[0]);
 	SMB2_query_info_free(&rqst[1]);
+	if (rc && is_open)
+		SMB2_close(0, tcon, o_rsp->PersistentFileId,
+			   o_rsp->VolatileFileId);
 	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
 	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
-	if (rc) {
-		if (tcon->crfid.is_valid)
-			SMB2_close(0, tcon, oparms.fid->persistent_fid,
-				   oparms.fid->volatile_fid);
-	}
-	if (rc == 0) {
+	if (rc == 0)
 		*cfid = &tcon->crfid;
-		atomic_inc(&tcon->num_remote_opens);
-	}
 	return rc;
 }
 
-- 
2.53.0

