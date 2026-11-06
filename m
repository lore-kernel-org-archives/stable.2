Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932754;
	b=EuMs0CEIAGCoMh2fauuOJVSIoOjFNNUk1wF1LL9oxbvHvR6VD9dbb9SlKwNHcRll+JDM
	 74Y5I5f14as4holQQ+IQI4UXGLPaI99OnPZUNMkVqvUF0Bjy2Qvzp0Yrg1EL7AMzxOa4V
	 pGOvID5eu1ieQ37cFjdskAwXCPBBE+9jpK4sXy/yGN0/CZJtaQ68ttlj9/gIDez6ymE7K
	 E2LQc+fzy8HC8tQKptqXqBR2y99slcoKbu90hps0AAT+awAYyfVrc1RENnDNci+ZkdK+H
	 jSStLtP3v6QeTXqnHBiQqFqcVeRH3mKpWLb82u8uMhdoJwmCICF612oop4mNFauGUUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932754;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LkmW5anCK8JzAjX4/JQNkcWImJ0dkkKINPYqOIUl59E=;
	b=PzjnnccOrVqg0yD3EptYGtjZNsP4eZ/daAxFcL+nBl4hKuBrTtrjMfePZLvDxBqsQI03
	 RGx47/uabEAhAQpSz912mdS/8P3bGtDKmA7ayXilPEgpsMb4PGsCCRxtbol8VMFNDLSom
	 BwPgc0nRlHE1swY8MHyYD1/K4wXBHrh+u3gVjzSUbkCbNt6EzsImVb7cAku2ehvng4TaK
	 sFjAghgCQ5YakEu8gdsaOSFkrgKv0xnhhAHTaHJYsmcVfSfORBmzwiiD0wD9MT/cMl7Qi
	 TSkNjUIjozBf+tLgqrjknHL/tkm1wkwI15dluP0nqVURsw6kZ/j5Pp/5WjOkSuGbARA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBzYTtkH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A11606A33D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBzYTtkH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243EB1F0089F;
	Fri,  6 Nov 2026 02:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932753;
	bh=LkmW5anCK8JzAjX4/JQNkcWImJ0dkkKINPYqOIUl59E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OBzYTtkHCIfTQvjRIKaVx0xO85i7+aR3YodM3U69yJWbrBzghdr7jbi07tgRTt+0d
	 BBENLL6mMb5ZgGFkwlG73550GAMe8yltPwg2gO7MEdlS3K4ZHbRcEVMawvFWGHURbK
	 Q/PEO+tjeFiFWmiN38O3UZ5/zLJQCggOmChj+iwcct5T9D3b58WTl+YDDpzXn4u696
	 Ft0QeNGU8R+v6JMJzOvAf2tWLZkglRKL8s5SkXvdpmHTSJFU6abTadO3GODV9liGov
	 1/LrnzmNc5w/1UBu0fNz0/lVHIsO8aybhM/xdCK+Ihn8lOlsSpSauEaqrkrF1iA4BC
	 36J5aca5PneGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] NFSD: Count the delegations held by each client
Date: Thu,  5 Nov 2026 21:39:08 -0500
Message-ID: <20261106022849.3786687-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106022849.3786687-1-sashal@kernel.org>
References: <2026110416-cleat-grapple-d472@gregkh>
 <20261106022849.3786687-1-sashal@kernel.org>
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
index d2878bf1e7181..43755bce08f95 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1420,6 +1420,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 	dp->dl_stid.sc_type = SC_TYPE_DELEG;
 	list_add(&dp->dl_perfile, &fp->fi_delegations);
 	list_add(&dp->dl_perclnt, &clp->cl_delegations);
+	clp->cl_deleg_count++;
 	return 0;
 }
 
@@ -1451,6 +1452,7 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
 	++dp->dl_time;
 	spin_lock(&fp->fi_lock);
 	list_del_init(&dp->dl_perclnt);
+	dp->dl_stid.sc_client->cl_deleg_count--;
 	list_del_init(&dp->dl_recall_lru);
 	list_del_init(&dp->dl_perfile);
 	spin_unlock(&fp->fi_lock);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 4e0e36b81b203..1909d744d4ac5 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -457,6 +457,8 @@ struct nfs4_client {
 
 	unsigned int		cl_state;
 	atomic_t		cl_delegs_in_recall;
+	/* Length of cl_delegations, updated under nn->deleg_lock */
+	unsigned int		cl_deleg_count;
 
 	struct nfsd4_cb_recall_any	*cl_ra;
 	time64_t		cl_ra_time;
-- 
2.53.0

