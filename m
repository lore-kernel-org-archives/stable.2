Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD9509F06
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791309; cv=none; b=iGCIR5vP/JhA/gk4GdVgTfrnF5UcBJOMnVjuhYqpMVvbtGU7pjsoxP/1B4Vnin5iPF5NmNMATHPzmUNTSN+CUYXBcIdpvV/Y0JVztH2OFWlFvvqYV/b3dgt+2BcAk87d1OsYplgbCTz00FwgDTDtkspk4sX/OEskuBGyc6YcLl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791309; c=relaxed/simple;
	bh=qJfzVez0bW9BCsbyvoxLMEhLAA2t7gfbP2PtySSwxuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4MCGtGKpQwsgb9LxoQSEIa23nvVo4iJApFldSY90WBL0QEpShXmHN2UHR4a9BDWbyTifo/aznCbVO1wucx6QxM7oRqY1PKfi7AbMj2+MoxWpsWtJlRAED2wi5iXQ36W4jzXE93qbIxMEsfk+oTcXXDxg8tl2swksGzF6ZE/U6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnz1EgN7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnz1EgN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD071F0089C;
	Wed, 30 Sep 2026 18:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791307;
	bh=Aq7U+X2RHhiC3L8E/hszKrdHowAlEZp0yKERSrJBFwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mnz1EgN7f+xuAlrJfvSMSLagPuwKxNNmLqX6RQFVj5m6DccukjyQ4CCqYt6Sxhx2u
	 lncF5z7DDuS1MDdMn4YSAQaTfFgjacy159GWVDpYe7OrdWj6OV+QbK8JM00qYivy1n
	 FnLNQZIoJsHcP6wlCjw9c/OAlI0cxcdXzXqjC7i+eDmd5mc8A6/jUbuMmjshhcZeC7
	 t5FBvdScO6rBxNNtbyqCPcH4PhS8hZGIkD2PCEgM9Em3s1Lg+LDwa6DHJ16064wQRm
	 SbdYAbMIijGU+W6iPzAVrLN+vQNf4vSyUeLUvyCRy1pJuD7wpN+9ZMXBiUzVBfv4fc
	 VnwHmsnGwgCyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] smb: client: clean up failed cached directory opens
Date: Wed, 30 Sep 2026 14:01:43 -0400
Message-ID: <20260930180143.3974994-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930180143.3974994-1-sashal@kernel.org>
References: <2026092902-hacksaw-legwork-e770@gregkh>
 <20260930180143.3974994-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cached_dir.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index d7cab84644a45..476ef68ba0c68 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -8,6 +8,7 @@
 #include <linux/namei.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
+#include "../common/smb2status.h"
 #include "cifs_debug.h"
 #include "smb2proto.h"
 #include "cached_dir.h"
@@ -250,25 +251,37 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	rc = compound_send_recv(xid, ses, server,
 				flags, 2, rqst,
 				resp_buftype, rsp_iov);
-	if (rc) {
-		if (rc == -EREMCHG) {
-			tcon->need_reconnect = true;
-			pr_warn_once("server share %s deleted\n",
-				     tcon->tree_name);
-		}
-		goto oshr_free;
+	if (rc == -EREMCHG) {
+		tcon->need_reconnect = true;
+		pr_warn_once("server share %s deleted\n",
+			     tcon->tree_name);
 	}
-	cfid->is_open = true;
 
-	spin_lock(&cfids->cfid_list_lock);
+	if (!rsp_iov[0].iov_base || rsp_iov[0].iov_len < sizeof(*o_rsp)) {
+		if (!rc)
+			rc = -EIO;
+		goto oshr_free;
+	}
 
 	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
+	if (o_rsp->hdr.Status != STATUS_SUCCESS) {
+		if (!rc)
+			rc = -EIO;
+		goto oshr_free;
+	}
+
 	oparms.fid->persistent_fid = o_rsp->PersistentFileId;
 	oparms.fid->volatile_fid = o_rsp->VolatileFileId;
 #ifdef CONFIG_CIFS_DEBUG2
 	oparms.fid->mid = le64_to_cpu(o_rsp->hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
+	cfid->is_open = true;
+	atomic_inc(&tcon->num_remote_opens);
 
+	if (rc)
+		goto oshr_free;
+
+	spin_lock(&cfids->cfid_list_lock);
 
 	if (o_rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE) {
 		spin_unlock(&cfids->cfid_list_lock);
@@ -342,7 +355,6 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		close_cached_dir(cfid);
 	} else {
 		*ret_cfid = cfid;
-		atomic_inc(&tcon->num_remote_opens);
 	}
 	kfree(utf16_path);
 
-- 
2.53.0

