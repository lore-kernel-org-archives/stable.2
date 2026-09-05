Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F56F2E8897
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788626450; cv=none; b=PwZgAJvYLvudenSMy+HY84dTP/Fxx+Q7sE/LqaWBqU3RMldbuSanjoe6jU+cEWMS/iFdKCPVmIqfZSWx0tl/cgTPuWwp3hW8X119FvAUHPxPA2vnuMBUoDBuMKojuydPDCUqevKpYYjRB5bi1y8lrbklLKQe1eT3jG5ZDnXtP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788626450; c=relaxed/simple;
	bh=Bi7uGM4Mau65oeParTbOUtt2bsD05UCg5o6VYJILrMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKNiWk0Rw5gKIhW2nE8Y8zVnf5jgHJdFkq6VkUi2tsjZ5yEv2CULOZK8m5D/6vsT91OLKjMtvNXKl80JrNww3Gg6LKjUlfQ8Lq5b/ykwv6C34qtzYPxwIEjOprpaPd6Igx/+GYYeDwtJR0ciKUh6NCX7+ie4zKqpUlRYwEoZoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm1YB+l+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm1YB+l+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC43A1F00A3A;
	Sat,  5 Sep 2026 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788626449;
	bh=qsEXmR8tgPYw/vubk+K7oduLwLlET0/WSKuriEN8K2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cm1YB+l+HRcxroqkPeBvPfgfWFprVFjr/9kOqUdFGN9rwO5aGqAxi4c7OnhaSTgOr
	 9bX5LTsvddlN0OccsEdI15rvDVlm3WTHCzV6l1yn1sU0FxCa49TxmT6xgKBNHh0hlz
	 jPazTTWUtr0DZu/OqMRsQ520quhKXI57p3Ubds0RW88C6BkToM/LZ2YNucMTrNgTtu
	 VS/yd7QzwprDemnaLQ/74Zl10GGZH3gDeBUEjBIGK3UqvSxxWAD/Ft5kV+sma0Dt2Q
	 zCB43m/bTcSDd+yg/GhycI2U/r6sTtp6myTdwoGA92HR1GJno1yB95/ItAhh2nbcy4
	 ZZywPr3MfJBBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing delegation revoke
Date: Sat,  5 Sep 2026 12:40:47 -0400
Message-ID: <20260905164047.457754-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090305-musky-peculiar-c632@gregkh>
References: <2026090305-musky-peculiar-c632@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit ca94ba36172046be6a694a7986f6931e47ed4d51 ]

nfsd4_alloc_layout_stateid reads fp->fi_deleg_file without holding
fi_lock when the parent stateid is a delegation. A concurrent delegation
revoke via the laundromat can clear fi_deleg_file under fi_lock, causing
nfsd_file_get() to return NULL and triggering the BUG_ON.

This race is client-reachable: two NFS clients can trigger it by having
one hold a delegation while another opens the same file to force a
recall. When the first client doesn't respond to the recall, the
laundromat revokes it. A concurrent LAYOUTGET from any client using the
delegation stateid hits the race window.

Fix this by taking fi_lock around the fi_deleg_file read in the
SC_TYPE_DELEG path, matching the locking discipline of the
find_any_file() arm, and replacing the BUG_ON with a graceful error
return that cleans up the partially-initialized layout stateid.

Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260530-nfsd-fixes-v2-1-f27e8eb4d974@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index bcf16dd07d488..d0b76aee54f83 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -167,9 +167,12 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
 	list_del_init(&ls->ls_perfile);
 	spin_unlock(&fp->fi_lock);
 
-	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
-		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
-	nfsd_file_put(ls->ls_file);
+	if (ls->ls_file) {
+		if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
+			vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL,
+				     (void **)&ls);
+		nfsd_file_put(ls->ls_file);
+	}
 
 	if (ls->ls_recalled)
 		atomic_dec(&ls->ls_stid.sc_file->fi_lo_recalls);
@@ -234,11 +237,17 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	nfsd4_init_cb(&ls->ls_recall, clp, &nfsd4_cb_layout_ops,
 			NFSPROC4_CLNT_CB_LAYOUT);
 
-	if (parent->sc_type == NFS4_DELEG_STID)
+	if (parent->sc_type == NFS4_DELEG_STID) {
+		spin_lock(&fp->fi_lock);
 		ls->ls_file = nfsd_file_get(fp->fi_deleg_file);
-	else
+		spin_unlock(&fp->fi_lock);
+	} else {
 		ls->ls_file = find_any_file(fp);
-	BUG_ON(!ls->ls_file);
+	}
+	if (!ls->ls_file) {
+		nfs4_put_stid(stp);
+		return NULL;
+	}
 
 	if (nfsd4_layout_setlease(ls)) {
 		nfs4_put_stid(stp);
-- 
2.53.0

