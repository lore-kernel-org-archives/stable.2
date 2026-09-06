Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AFC3D47C5
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701319; cv=none; b=Gd8cbKENBNsXSOtJgSZYKeDExWj2UvPLDLqJaTwv8PQeIFx9PMg6JeCY8ie2aVLa3+VC+/lC49TQdHG2Hu2+1DODjrDdeGdUkCVePopYO09JW/SsUq99Ir3htw61d/d61kO1tBkIDwSGtKGR6kCY+ucxik+MScqure4EM5NwNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701319; c=relaxed/simple;
	bh=SWUworE4TanJalgMDSdnIHOb9P9dlJLPfKhDoVZmJ/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVpjuHhzRGJUnGk4DG4ozTuWE4Gx5ClJYGya51mQczHmaa81I7n3sxlAnSBpQNfaX8meXcgOuQ0XVrfbBATYNiRuf1wy1aqcoXSMvqmK9J6S/RCRug8c+0BN60+Fp5fXQbeW8z/Gzk2ptxX7eTHGKPmB51GkyD0J0BLpDlWbFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtTKcLXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtTKcLXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A031F00ACA;
	Sun,  6 Sep 2026 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701316;
	bh=joRK9bv2oY/I5N94l1wApt5SUKdAwDnw9zHly65n+RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JtTKcLXYum0U/uxrZGZYnEztV2DqwN7BHjZCadNRNb5K9N/FCBv8O/0YFIYpW59Uu
	 xnf0txSUiravWFhEMV/5DOMF/4LF7eXfjb17xkUGOwVR5HWYcULFli4PgZt2SzMIfl
	 a67V9OOJiW76dYPeMa0SQvTJm7Lj4IjCTDDstt+ll5WQrF6+Q9J5EjrjIZQ+hpGpsP
	 Q3Gdm1TilSq8CZmrhic7LqxywH3eVbfpDJ9KqhhlFDG7C31la9wPue3aLPe5+b6XP4
	 qCJEL8Eu0+bFaasXoFg3ZlEKj8TUuTfyvC2G0u0lMvMiKUD+K8fWkiSlAO0rGTipCu
	 fOIN4rPMB8B7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/7] nfsd: handle NFS4ERR_BADSLOT on CB_SEQUENCE better
Date: Sun,  6 Sep 2026 09:28:28 -0400
Message-ID: <20260906132831.874344-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906132831.874344-1-sashal@kernel.org>
References: <2026090304-heroism-outclass-581e@gregkh>
 <20260906132831.874344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 999595a651a87f4285c53710b5f600d6a141f526 ]

Currently it just restarts the call, without getting a new slot.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 01c5d5f58a5d ("nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 52a2f5017c63d..3512e967bc754 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1204,6 +1204,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
+		/*
+		 * BADSLOT means that the client and server are out of sync
+		 * as to the backchannel parameters. Mark the backchannel faulty
+		 * and restart the RPC, but leak the slot so no one uses it.
+		 */
+		nfsd4_mark_cb_fault(cb->cb_clp);
+		cb->cb_held_slot = -1;
 		goto retry_nowait;
 	case -NFS4ERR_SEQ_MISORDERED:
 		if (session->se_cb_seq_nr != 1) {
-- 
2.53.0

