Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC134E74D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644613; cv=none; b=B0NXG1oF89iEzv/zAycMqW5NjxZ5+sZ1V8y9OQS7P4EEROretWzyQA8F5OrRslUU4uksPdk4FcUhEtodAKJpof7UY8aHPuF8dl9zPAN06nvUQYJBUjDQNih65OYKvBl9gLFrmACRfGQyoensYroiML9J7EC2zHtVNEzBnRtfAVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644613; c=relaxed/simple;
	bh=LBE+DzbIHcBl61J58L42UePYYwZY9qAoR3sJVUt51ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTnO9Fu5IK2fxHiqWBiIBlF9ql4H7Nj8QJNEBKnENKd1JuV+SCSJq4GsC2wVYnaLKfajYnpo94ZFVsx7HIxRirQ6nmze5qAm99KXzV3lg2EeWcEwZENbIyJevXRAB5gE6ZHtvbf2beOUVHlukHJlMiEAvj10zEulb0WQHfXosRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJmu9Ehn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJmu9Ehn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197481F00A3E;
	Sat,  5 Sep 2026 21:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644612;
	bh=KhK7hC+jAf8HDfauR9iOtbm8ux6a8ddl66DSShyd8V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VJmu9EhnFXO7MXOXadaQFp6DWNvLDumqBA9kFqPkaBPSrDIGzNNcWzYi8d7Xay1iv
	 P3WbTykqbeLX/Mppf2zjWE3gDHNJKxETq/OrObH0Zo9aNJFP13NDIV0OwWZXEZ65mt
	 27ASO8R+zggHY6eugERUGs54WKqcSYizcQ2Kdgjmmphlb0Rdi2N8R5LPGNH3wq0RdD
	 1elUU5/i4j6wPMD/LLRqDyTxa/IRVxYR1SukHUX8BekPmvl09nH6YwsqXqKJFAkSKR
	 6NsqOWDQeYQ5bwamdRfgYdQWfpqZ2klo1oAyPUVcrLwjfu8F2O4ABIo7MrGod2yJDz
	 7zhvEHPG5QcOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
Date: Sat,  5 Sep 2026 17:43:29 -0400
Message-ID: <20260905214329.701331-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905214329.701331-1-sashal@kernel.org>
References: <2026090320-unvocal-subtitle-0ff5@gregkh>
 <20260905214329.701331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit d0beaee498e11880e72826026db0e9c9890fc114 ]

For an async COPY, nfsd4_copy() called nfs4_init_copy_state() before
dup_copy_fields(), so the s2s_cp_stateids IDR was pointed at
&u->copy->cp_stateid -- memory in the per-rqstp COMPOUND buffer that is
reused by the next request. dup_copy_fields() copies only the value into
async_copy, so the IDR slot dangled at the transient buffer for the whole
background copy. Any IDR walker then dereferences reused request memory:
the laundromat reads cs_type from it and, if the bytes look like an
expired NFS4_COPYNOTIFY_STID, follows into
refcount_dec()/idr_remove()/kfree() on garbage; manage_cpntf_state() has
the same exposure via idr_find().

Duplicate the fields first, then register the stateid on the stable
async_copy. result->cb_stateid is unchanged.

Fixes: e0639dc5805a ("NFSD introduce async copy feature")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260710-nfsd-testing-v3-3-a0ff7db6aa3e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9812360931819..0ca9eba332439 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1832,11 +1832,12 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
 			goto out_dec_async_copy_err;
-		if (!nfs4_init_copy_state(nn, copy))
+		dup_copy_fields(copy, async_copy);
+
+		if (!nfs4_init_copy_state(nn, async_copy))
 			goto out_dec_async_copy_err;
-		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
+		memcpy(&result->cb_stateid, &async_copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
-		dup_copy_fields(copy, async_copy);
 		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
 			       FMODE_NOCMTIME) != 0)
 			async_copy->attr_update = true;
-- 
2.53.0

