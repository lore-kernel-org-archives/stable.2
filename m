Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3B2C9D
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221116; cv=none; b=oKDgQUurhc5zbknq6MDA+bFjwEGkmIOHNeHy2Kg+Anqa7K4SFmktGTf/91q8dI13rMpcmI00CnH+jjUjSGt/Z1LK9vUOTvaz6Y7qw+iVYwSWwhWJodt9rhQI4r8fhm3EPRCJpO1ZSs3me8yl4bKmIhkFIl6Eat0BC2LyXvYd04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221116; c=relaxed/simple;
	bh=vZUXEAD1FCBY1JN6EM1lD1nEIjH6B5ApX6jCvKalcZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nePPPseXqrWuwRUZQpTHppwgbD30ZNv3NSOTSQSF41M2DMBvMKEOCGq65QBOa70KA2HqHgSxQSysCafzzAaoNyOiDtkN+TD8SlWSRyiUY/gcYH4EijXKXWx8Eiq3RmsemsG/G1DMkb1T1jSMaVcYRMxrsWGiR5OOVOGGSteDAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJvAKvmF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJvAKvmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535901F00A3D;
	Sun,  5 Jul 2026 03:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221114;
	bh=dERfe+sRnEwrYxnedPVJnCwWewOocmxZdnXJQqnqPCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eJvAKvmF8nE6Ux6dekmS2bcXP5sbizuPr6DZaWL0A82Ew3pVTHEHibHl5hll4TY85
	 zgdPU03YkcEty9G7KFvAlg7Y30iEk/IIL705uM7SyY9qCP1Z8pGQShX0leIeyDhUh+
	 Iq+f1EcXQfy7hRnfK2DnEHogndb/tVYyR/BnZqkyEPfDNL0qEt+RrB96j8PBk6LroH
	 9TRXfIeDeQd/JMlM7tO4FQ7Q8t2VVNGXekA8fT3IPyaaat7jOrER64X1mz5N9D1RbQ
	 qBrmiKgOQpcGDcWb79DANdzLn6i96FKKXcX4zeGX1vrv7Xy58gALOdYC80Qnkq/a3H
	 /3Jc2HT0outCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] NFSv4/flexfiles: Remove cred local variable dependency
Date: Sat,  4 Jul 2026 23:11:48 -0400
Message-ID: <20260705031150.1600970-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705031150.1600970-1-sashal@kernel.org>
References: <2026070242-poker-barricade-3a69@gregkh>
 <20260705031150.1600970-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Curley <jcurley@purestorage.com>

[ Upstream commit fec80afc41afa3016421115427df8d00dc491ee5 ]

No-op preparation change to remove dependency on cred local
variable. Subsequent striping diff has a cred per stripe so this local
variable can't be trusted to be the same.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Stable-dep-of: 2c6bb3c40bc2 ("NFSv4/flexfiles: reject zero filehandle version count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 6469846971966b..8d43ba6e3ecc23 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -531,10 +531,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		if (mirror != fls->mirror_array[i]) {
 			/* swap cred ptrs so free_mirror will clean up old */
 			if (lgr->range.iomode == IOMODE_READ) {
-				cred = xchg(&mirror->ro_cred, cred);
+				cred = xchg(&mirror->ro_cred, fls->mirror_array[i]->ro_cred);
 				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, cred);
 			} else {
-				cred = xchg(&mirror->rw_cred, cred);
+				cred = xchg(&mirror->rw_cred, fls->mirror_array[i]->rw_cred);
 				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, cred);
 			}
 			ff_layout_free_mirror(fls->mirror_array[i]);
-- 
2.53.0

