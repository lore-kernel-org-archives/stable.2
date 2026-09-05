Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095693A1A21
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638733; cv=none; b=Fs2J0pX4gZ2L8r/oEFzpHk15Baw9eicxoBAGf0zDM3B3ZxNkbiA4hTVjdz3+SC5gk3fQKe7gntklCF71ckDCfRjheALv4YeCMViZd5s6PyxQhlX5i+oYCykBvDdcFfqiEx9tQXXX3NOl69ATdJ6YiSuzx5dA9FUat1kgyixlmQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638733; c=relaxed/simple;
	bh=Hj2uCzdrEY6dbu/iKeFR8w783HpvNQ8rSEJjYk8rTJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMYM2ADN2Sx4Ewe6sZnk7jJbYmcV5wQtD4I14clf8TjMz8/AtUjkGDR/pzZCACPLLjwhmJypFiU0wqtADHhj8cJ1KSCYoocDhrYiIT1i558BxlNtFCGsBmRVeDJ/P232UNmjICa99gayOMIr1qccQqMZfIhWP2ud/o9AIcDFc98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ42uf8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ42uf8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D1D1F00A3A;
	Sat,  5 Sep 2026 20:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638731;
	bh=qvGydiVf1+3yJFJsDnzDWk7PrBfrSpxBcbgJYKjAeSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bQ42uf8pQmuQE1lVry2XfXSya4hGz8C+mkihMlGP+DMrK06mdZlfv40/nH2U4G34a
	 dxhfHZxQ3D7E9/G7JWfPMytEf6zUggxFi6c1yMYjvwVIf/ktA3LY0CTgX3uvINvWMZ
	 0MV8wXpjJciMUJzOTk2upodshmN4XeWI7ZKgpn5eb0fTdcBJmtx1zZGmVClf4JCXKI
	 2ZfCIXDJF9XzuDoGe+YsFRnp4nOY7odsC8HS3218JvOSdhh0G3pQGFnlCUl3GwNdTp
	 yrqQGXpg1q6kN233FO1mIvDMOGl3Hp4vYcEOsPuMCMTtffnY3DjyR8B4Ic96rEp/Y1
	 5+LlHULLZw8vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/7] nfsd: handle NFS4ERR_BADSLOT on CB_SEQUENCE better
Date: Sat,  5 Sep 2026 16:05:24 -0400
Message-ID: <20260905200527.607284-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905200527.607284-1-sashal@kernel.org>
References: <2026090302-liquefy-backrest-fcbf@gregkh>
 <20260905200527.607284-1-sashal@kernel.org>
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
index f131c7dbbb194..8d63fc429f9ae 100644
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

