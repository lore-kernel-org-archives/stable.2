Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BE37F010
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578920; cv=none; b=p0xLKdhZgkQl5Vp3OvH9VR9MB+4DnRrAtmLyYL0A4DC2uhAErfQ378OoAzUOYYwSeTzNnDExNvwnMdm6vMR2GcvzE2fzpWWfBo1bv+nFOBY6MYxBCEBlGhkUsBP2K2A/3iB434IqAIzMCdr0YgH6EAYl58CfXQhXTFqS8qjtB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578920; c=relaxed/simple;
	bh=Rm7H3DjqGwnN55rDMqfP0hjkc0z6pTg4Q4K9PRmWR2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIDD4YMRY9aklY4USCuR0W+yAraWu5MbyWI8OvSMH8nlWefxy8FgvIn+woKalrIXCypMbgMBCnVhu8yJ92a0OZHZHikJ3FKujHm9vBXlcu6KctgLDlA5rlee0vZJchDKowee1+erQGHqhNgOeP0Z2ZS4WwogVLCHMeGDp6LsZis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMYyGa3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMYyGa3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C35E1F00A3E;
	Sat,  5 Sep 2026 03:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578917;
	bh=o2iJwsXEcEjAFeHUOHOSDarM8t3cfR6F3jVBQ+b1uRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PMYyGa3+VL5aiLuSmu5lhpyjzQlTJmJwauomzTOe01og/wwu5jN3pZ01IgHs9DHwa
	 1UY9AKN15txPttqoVMJmTO6juRJB08E1Ug2YmUay0dbKi0OEia/jBj6kIfYui0SfX9
	 K1qEdTucWqB0nHMhXha4A1AK89LjxgVQSYb0h3nLvUBxGb6YE9tlrNdB7uFOi/UEV1
	 WaP4/kFGRt/ZJU+8wsw+N8npGmnltDdk0j24ZL6uZ6GvdHPJSWaEBceDNdpESBVlwd
	 QWFuwOeoKeELh4it3BaEwbQ3ljj+ac002FRIvvFEbu2+sx5h4YYYB0z+Y1fhAal9Ld
	 USUfMcZOEcrOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 7/7] nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing delegation revoke
Date: Fri,  4 Sep 2026 23:28:30 -0400
Message-ID: <20260905032830.1915148-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905032830.1915148-1-sashal@kernel.org>
References: <2026090305-dowry-plaster-fff3@gregkh>
 <20260905032830.1915148-1-sashal@kernel.org>
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
[ adapted nfsd4_free_layout_stateid() to tolerate a NULL ls_file in the older cleanup path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 8520c9d00bda7..bea7513a0de90 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -235,11 +235,17 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	nfsd4_init_cb(&ls->ls_recall, clp, &nfsd4_cb_layout_ops,
 			NFSPROC4_CLNT_CB_LAYOUT);
 
-	if (parent->sc_type == SC_TYPE_DELEG)
+	if (parent->sc_type == SC_TYPE_DELEG) {
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

