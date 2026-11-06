Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932978;
	b=e02lwOL+JtXXcnMtXPi7O1lDOW8/LhWNBQuXcH2IBOFlSQ/VhiOyvQE+SVSGAwfZUF7r
	 hDIxfM3SP8Trb3fFrJeemMg67BiWDVSjZuPrgTmNouRCr+TLW2KwnVcPWqn8sl1sRrjqI
	 ZaZbQcb/ft85c+sAEzItofQL4Bbie+mHKVPNe5OAXEmvOzlvOd3RWdQ5ahgru29k46rti
	 1VQzbozv5Jj5jOy8cP0gv24552YbubD9Gkzw5i1HXTTCzztCcz18AuYpI2hlg0IQDii/4
	 cV+qpMaJCVdqCdhjm6loO7aKwsimYvVnVPGUXuNti7908GfUfK0kMYmQtY70MXQ+uDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=l/bwVKmAEMmmvy9KK2yMbFvXy1acIES9UJn7lsy9kQw=;
	b=U3Uxe8KXubcvmUel50z80cMh5YPQaG5OLLnI92cu5qiEq3GpVnaENYOdDvSIdghg8xxH
	 4tcjqjAs0mM1xLNQ/rv4x2vcUjQ1rjqcsgYgtjD4seNgEI4BFQLujFsT2f36VOhDGHtOg
	 947/T+brl6arRjB0TSmADvaxE5YPGTAc9cmMQMALN3WbN6bL/AR9x7T0fSeicnotLyrk8
	 4TH4eFGDpNR5XLWZQUqgs02Hs1RL1NsnYORabuLJfL+3RZSJ2PgM+3g/dKRPeVUb98X9Z
	 uG3tO7lQ7JFl4wuh2jBN2v0ybqq0mYwdp7QT34dWTq8QawdhHfYgH07mbOMZ1012N/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhGS8N7n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EE0606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhGS8N7n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A161F0089F;
	Fri,  6 Nov 2026 02:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932977;
	bh=l/bwVKmAEMmmvy9KK2yMbFvXy1acIES9UJn7lsy9kQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BhGS8N7n8xMc+2hJzOs8bIFN/az938SDN9e+iMOcT2UBVcN2Vn31WEj7oOXPqyDk7
	 wgxaPO047OEcycEXZ6258sQIpGJk8lFd3u5C4LCDaakiw1VlFn0V6wNE94ge4aUM3K
	 /D3EM4XNt4fxdjFkMjAOIbd/cc8IZzoWyvW36bCfFryBGuAyhZxk+qI5vwNbZk95QF
	 0s6UJMHU9sbxSaU/7jMqFZ9HgPrpjW4TRC0hTPCeQLwb8S/nMUA7+KGQ0U4Rv0aNo8
	 aQCXKgyM+xBaFVGh+KxCZCOexO5a/IGWjtlNyQyRCgHOBBs63NTfPI37uzFFrpLcul
	 BIzneBx4+yPNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] NFSD: Count the delegations held by each client
Date: Thu,  5 Nov 2026 21:42:55 -0500
Message-ID: <20261106023407.3730085-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110428-retention-sandfish-d9c2@gregkh>
References: <2026110428-retention-sandfish-d9c2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 5d5a6e996e7c36bc2f7b035743c16f2bf03a227d ]

struct nfs4_client records the delegations it holds on cl_delegations
but keeps no count of them. deleg_reaper() walks nn->client_lru under
nn->client_lock, but cl_delegations is serialized by nn->deleg_lock,
which nests outside nn->client_lock. A caller there cannot take
nn->deleg_lock to count the list. The cost tells against the walk as
well: an O(n) count per client, on a pass that already visits every
client.

Add cl_deleg_count, maintained at the two sites that mutate
cl_delegations. Both hold nn->deleg_lock, so the counter is already
serialized against itself and needs no atomic of its own. The decrement
sits below the delegation_hashed() test, next to the list_del_init it
pairs with, so it runs only when the delegation really leaves the list.

A reader that holds only nn->client_lock is not synchronized against
either update site, so it can see a count that does not match the
list. Such a reader marks the access with data_race() and may not
depend on the value for correctness.

No functional change.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260817-recall-any-keep-count-v5-2-3b2cffce701e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Stable-dep-of: 9af39c0773ef ("NFSD: Send a meaningful CB_RECALL_ANY keep count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 2 ++
 fs/nfsd/state.h     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 42035bfebda7a..222f2aadaafad 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1423,6 +1423,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 	dp->dl_stid.sc_type = SC_TYPE_DELEG;
 	list_add(&dp->dl_perfile, &fp->fi_delegations);
 	list_add(&dp->dl_perclnt, &clp->cl_delegations);
+	clp->cl_deleg_count++;
 	return 0;
 }
 
@@ -1454,6 +1455,7 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
 	++dp->dl_time;
 	spin_lock(&fp->fi_lock);
 	list_del_init(&dp->dl_perclnt);
+	dp->dl_stid.sc_client->cl_deleg_count--;
 	list_del_init(&dp->dl_recall_lru);
 	list_del_init(&dp->dl_perfile);
 	spin_unlock(&fp->fi_lock);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 926e4e8063b33..fd61bac52721d 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -525,6 +525,8 @@ struct nfs4_client {
 
 	unsigned int		cl_state;
 	atomic_t		cl_delegs_in_recall;
+	/* Length of cl_delegations, updated under nn->deleg_lock */
+	unsigned int		cl_deleg_count;
 
 	struct nfsd4_cb_recall_any	*cl_ra;
 	time64_t		cl_ra_time;
-- 
2.53.0

