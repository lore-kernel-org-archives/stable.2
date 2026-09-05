Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7E2EEE93
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573594; cv=none; b=Rf2KcvQIAVyXC2c1OoN4H/U1y0f+51WBU8uFNkmjWLx3xlUTmksJ6m49XDDgqhpXaXD33ZyIf57hfJneJKjdLYGy9/UwnyclqdwapCV0oC5GXh5499AEEmYJTvIzATsv+sYS1ocOT+rsWhdL78b46uHO042T6ihZgJfhidWKVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573594; c=relaxed/simple;
	bh=Vk5wy89aAq8n2/37s4fMFhGS9gZ5nc2VOLQCIix8Ejo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMR2sEDa+HzU5zuwybeUqhg8aO5td2diIwlyModKZOt2yyxrd/WwoZLvswj797QL0Nt3SHVwyks189AXPQV7JO8VgHwme0nVi3neJ1NIxJnyK6SSEHqNIAa93UjlBLJFPC3PSQ+U00xp7bY8Z2A1aS0vTqbZgyxREGs/JgRaCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5uebHs9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5uebHs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC0E1F00A3F;
	Sat,  5 Sep 2026 01:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573592;
	bh=v2bDjEBvb1ovgi2wfGtUM9sbwU7qL93iNcqZWoHh0aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C5uebHs9eRrXifq8MAUaNaY0eTZzefVwnWfig49LfGASSTBXLtRzWACkCMi6UnuNI
	 ca7nc4TeVRiNLbIHJ9F5drR6LvEbqQ6GZtThQOPyvrx6oI+aOamihN3JYSkAHcZXab
	 LYAIsUEsG+I9irfiEUBaKY5lEf9qztOioSbehneCSKZEWMLofLbtG4eiU4hLm0m/0K
	 nOe1ubIcztVN33teDkffb0eqyUvjj8tyIS9AMPZzpEJeFufOmfQ303QalmIcuSCNGI
	 R2SGKqrGmubfvMAuzTypx70gf/aUpzvJBr68NnVEJdZfOPNY/DYyYQMvYmcM7JL/VX
	 kGhVj3KFJvPFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] nfsd: move struct nfsd_genl_rqstp to nfsctl.c
Date: Fri,  4 Sep 2026 21:59:49 -0400
Message-ID: <20260905015950.1825770-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-marital-swizzle-715d@gregkh>
References: <2026090358-marital-swizzle-715d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 1ed3df33bdbda5fd639571afe9c7cd282ff82cd9 ]

It's not used outside of that file.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: a99d720ed2a5 ("nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 15 +++++++++++++++
 fs/nfsd/nfsd.h   | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1da5c40d6722a..c806e074d6488 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1411,6 +1411,21 @@ static int create_proc_exports_entry(void)
 
 unsigned int nfsd_net_id;
 
+struct nfsd_genl_rqstp {
+	struct sockaddr		rq_daddr;
+	struct sockaddr		rq_saddr;
+	unsigned long		rq_flags;
+	ktime_t			rq_stime;
+	__be32			rq_xid;
+	u32			rq_vers;
+	u32			rq_prog;
+	u32			rq_proc;
+
+	/* NFSv4 compound */
+	u32			rq_opcnt;
+	u32			rq_opnum[16];
+};
+
 static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 					    struct netlink_callback *cb,
 					    struct nfsd_genl_rqstp *genl_rqstp)
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8cecccdaf9ee5..02026ab030d28 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -60,21 +60,6 @@ struct readdir_cd {
 /* Maximum number of operations per session compound */
 #define NFSD_MAX_OPS_PER_COMPOUND	200
 
-struct nfsd_genl_rqstp {
-	struct sockaddr		rq_daddr;
-	struct sockaddr		rq_saddr;
-	unsigned long		rq_flags;
-	ktime_t			rq_stime;
-	__be32			rq_xid;
-	u32			rq_vers;
-	u32			rq_prog;
-	u32			rq_proc;
-
-	/* NFSv4 compound */
-	u32			rq_opcnt;
-	u32			rq_opnum[16];
-};
-
 extern struct svc_program	nfsd_programs[];
 extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
 extern struct mutex		nfsd_mutex;
-- 
2.53.0

