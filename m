Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0836D503
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660819; cv=none; b=X9en5po1CPTo91Q1BesTPSv3PnXVX8tITE2L/WiMMlRYEGC0nuj3BpywD8ATQpQOgnCfcHUszVEOIwcLmbDJvmPLOz+ONsRB2hPI8XYlu//eQm6xm/wLVFlbZZulTxzor8aEIttaIjznTYDJuxr+XPjEECEbCxU+BPyHvsCVQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660819; c=relaxed/simple;
	bh=lHBTyI5zasfNyjDfvpZ4k1I58mY7hc0rUJEtouz2CKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbWG3X4yvaURZBHQYWmoNfJ8TFdsVUpCZdyB/qTURuTfhfqO3JcyK7A3Ffmb30+DiO/ALhrovyAgEA24NULVD9PYiTQjfLUdcPqsK0H+jrgr6uWGOXWEZtweQb2yQ1DpnzcqMuRlNeBGsIO0xX3nUSkEg1c/TnHJcvicaGcIEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC7P7EPM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC7P7EPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD0B1F00ADB;
	Sun,  6 Sep 2026 02:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788660805;
	bh=6jzfW3zrdyJPuBaVgHsQkxB6ZtpaKidGThrr/ibkSSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bC7P7EPMW7oYKCs0J0viQVpey9Y8vttbkGdrlF2EEx/T0hiVL6aQBs1EP6Ojfam91
	 WzQZR6A4wnWZTNiE1hUrCPaH3KbF0xoR7eoSWoUE6ay/8H++GTHR6OGFMnMQo4hutD
	 CPbNSB88edJxfvsXWb2vjGSrCW96Kzes8ECmIPO0QJMEHk+Dj0HDga0RNumx0WmbEE
	 aSsriZZXsXqHwq5AEZDyV5WWXZIbXxyosQTCoZz2fcbWzD1zkZh5aDVEme78/LJEvA
	 vI3GqsNJHaNnTv9ODhEi3VFWbpNrvYsZnDt3Ptox6Ya0xTK3Hl6qggNK7SPLBxoHzi
	 nXaXVrA2jsFlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/7] nfsd: handle NFS4ERR_BADSLOT on CB_SEQUENCE better
Date: Sat,  5 Sep 2026 22:13:18 -0400
Message-ID: <20260906021321.760525-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906021321.760525-1-sashal@kernel.org>
References: <2026090303-scrap-parkway-2bf7@gregkh>
 <20260906021321.760525-1-sashal@kernel.org>
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
index d0e5f46f0f7cd..c918fd3452f31 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1202,6 +1202,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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

