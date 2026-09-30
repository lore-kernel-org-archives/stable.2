Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC9F3769FF
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803505; cv=none; b=q393+D/5EVvNtuKzRiaLuo0ejHRtJd7Ok0mHaQ8FWgA91HhEwGzcXRDVRZbsFbw3XQWfCncgEm0OeFdn9fsIiTnB6NU+sO1MH01yUJ3xFOOFTzJwqEMnhHVbdZ3ZMx6RZwXnP7KGlgJFJ7jGaMxHZ0tWeWxyDhXtgKmEe0z4NrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803505; c=relaxed/simple;
	bh=h/bpOc4zRujZZ7cSPfzNMtoeuc6cRHPih7/dJnr6kPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXqrKnCJyQq13B9atLstFncJ7S8BhnUY+975vcIk393g4kUrZ7qYmZoCKkYpL6GpL3NHaSEQHC8T4HwaQsfdMTOM0JRIgMP6PzGZT2Kxj1wU5f2S21jn3ldomoi0Bp/vaM6KM+Jp77NpMW+zTyXrJ4uf+/xDjYENOREhh9MIpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFMwQ0cL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFMwQ0cL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F211F000FF;
	Wed, 30 Sep 2026 21:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803503;
	bh=7jkUzNoRBlb7xQNXjw7ImvCQ0BtcUx0ml/EtmP7MjRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TFMwQ0cLw3q6R2IDsGsEAzRGbtp2Ps4R0lII8f4t+ny+aw6Iv6Fg13qIhOp0n5wF8
	 1Ln+2QhJJEXqKe0smQiPfJCpB2uMCLZSGaX7duhwye9yVdSGcHrd2dtFIA2MvnRP9a
	 qMKJEPxAT80KRZjCjvl5lxKfC2775qx8hIp8jY6FGMFGi+jQmhre3K1B4itV1p7cPA
	 n3kFg9cTYMYJZM8XY29aSmt9ZcAd1x4hhb/IE8dO2Vj8OaHMQe2GAEHxbwgsjwCAcP
	 JCVclVRIrVNsO5lC9HBvcSD+8tCqAbbK0nK9JOb7/ccua1KbjwAm12j9tFb3GqEgFz
	 TC06YB0v6tUOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: clean up failed cached directory opens
Date: Wed, 30 Sep 2026 17:25:01 -0400
Message-ID: <20260930212501.3174867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092903-carrousel-elevate-94c7@gregkh>
References: <2026092903-carrousel-elevate-94c7@gregkh>
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
[ adapted open_cached_dir() changes to the older open_shroot() implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 51f8ea0c89065..94a604dd2866b 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -766,6 +766,33 @@ int open_shroot(unsigned int xid, struct cifs_tcon *tcon,
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
+	atomic_inc(&tcon->num_remote_opens);
+
+	if (rc) {
+		SMB2_close(xid, tcon, o_rsp->PersistentFileId,
+			   o_rsp->VolatileFileId);
+		goto oshr_free;
+	}
+
 	mutex_lock(&tcon->crfid.fid_mutex);
 
 	/*
@@ -778,8 +805,8 @@ int open_shroot(unsigned int xid, struct cifs_tcon *tcon,
 
 		/* stash fids for close() later */
 		struct cifs_fid fid = {
-			.persistent_fid = pfid->persistent_fid,
-			.volatile_fid = pfid->volatile_fid,
+			.persistent_fid = o_rsp->PersistentFileId,
+			.volatile_fid = o_rsp->VolatileFileId,
 		};
 
 		/*
@@ -802,18 +829,6 @@ int open_shroot(unsigned int xid, struct cifs_tcon *tcon,
 
 	/* Cached root is still invalid, continue normaly */
 
-	if (rc) {
-		if (rc == -EREMCHG) {
-			tcon->need_reconnect = true;
-			pr_warn_once("server share %s deleted\n",
-				     tcon->treeName);
-		}
-		goto oshr_exit;
-	}
-
-	atomic_inc(&tcon->num_remote_opens);
-
-	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
 	oparms.fid->persistent_fid = o_rsp->PersistentFileId;
 	oparms.fid->volatile_fid = o_rsp->VolatileFileId;
 #ifdef CONFIG_CIFS_DEBUG2
-- 
2.53.0

