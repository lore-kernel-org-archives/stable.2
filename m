Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163551;
	b=ijwerZp38JYja4PFTy5niulnKP0tJrwecc4rRoDiRvv4GrYUhZiOgmQsl9CgI7Yb0hjk
	 /TUSa8Z0RMccJgjuR0R5XOpuuHImtwaihZXtGM7UXzMdYLfK5ipSOzGxp1Z2I2i9L3GMi
	 waRdnWPM/vUKmb41hWZ3GMJaGztQeH9PaKFyHjAToWrPtzbkM48gUPsy2+rSMgWHd4TPf
	 6cTIKOseGPUWSXzIPCmRbUyhOHwWEFecqDb+QYKTkq7Na1bFug79Gm46fF3kiZPO5S4Nd
	 /vXYzBbJWKq7zBFrDPnEf48PY7WWd/SckMpyYh6QGFw3jERhnfAQbG5FbNCnMBqsung==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hPBW/7zRH6GMUll1hA8NAc0pSWv7wG1/hRY77ehO/Hk=;
	b=gYdDoyWDIkDeHk1VQtTmpdxYSmDZ8OmINarjTmIwDbPxW5XQaA/YozDVbv/e0kYAK0Y4
	 /2zg9Kthp+NqOcxMLimWNDZb+sL3Q422dkltE5eq1D/Wouu4jXlKNv0AvZCReTNrl8rFL
	 3UQUBbCanF8Xw6lZJ99F3Xear60WWu5lJ85Kqr1dWk42bA99qRu0tB5mgMLOJ6OIhiU9k
	 49kz7dnaMIgI7cYcyUnVjaMSpy7MnNtmRBGwTJuAcQuqTnbQqxsz1LXkxSQiB7Gt7CG6P
	 laOmJpDwP6rzia4I0JfJxGocygB3761bqdph+xGTNLRX5L+doIR/rqQv2NdI/AxtMlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZ53phTq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082A606A31D;
	Wed, 28 Oct 2026 04:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZ53phTq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24901F031E0;
	Wed, 28 Oct 2026 04:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793163551;
	bh=hPBW/7zRH6GMUll1hA8NAc0pSWv7wG1/hRY77ehO/Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YZ53phTqRYy50H9NdBl2+e6SCITiwm4R1hbz0W4awbu9Gyt/ZbaW0wmFqGd771/P3
	 qafFXo+1pFpMofv+4GBzjcHOs0aBa7hR1PgfrslTfDMlQmmR2gveO6uQ7iWE8z3RN1
	 zeNnjBheeKuuqgUgSDFoS1f5Rzs5cMTFBrWRsweiw4kbt6N/k7IUn4HN//xH2VXAdJ
	 72tDXn7BYd93Cv0SS+ZEin0lU1p7GuAlNR46X60zjWKTyfWuoOVZnZoFypHd8bALTJ
	 AbjGcd48jpCMonjyTOu1gNJ9Q/VTlrENIc/iJ1hKdo1u2Ccpk85wPOx0mGnoEDz0ml
	 a6Y4n/vRrHAVg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.6.y 1/2] mm/damon/sysfs: put target pids for damon_start() failure
Date: Tue, 27 Oct 2026 21:59:00 -0700
Message-ID: <20261028045902.148624-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028045902.148624-1-sj@kernel.org>
References: <20261028045902.148624-1-sj@kernel.org>
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

damon_sysfs_turn_damon_on() allocates and sets up damon_ctx to start.
If it is for virtual address space monitoring, the setup increases the
reference counts of the target pids.  After the setup, the function
invokes damon_start().  If damon_start() fails, it deallocates the
damon_ctx object without decreasing the reference counts of target pids.
As a result, pids can be leaked.

Fix the leak by putting pids using damon_sysfs_destroy_targets() before
deallocating the damon_ctx object.

Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 46980a4bef23a..d95fda1054a00 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1465,6 +1465,7 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 		return PTR_ERR(ctx);
 	err = damon_start(&ctx, 1, false);
 	if (err) {
+		damon_sysfs_destroy_targets(ctx);
 		damon_destroy_ctx(ctx);
 		return err;
 	}
-- 
2.47.3
