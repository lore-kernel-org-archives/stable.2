Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196878;
	b=0PB1ngkwlsTDNRPFWE17vDabQ/CwJpfP+Gswv0oGoRkmC5st0NvbR/e1hok/OxwQX2Ga
	 3fR3573BenlOgK/pTJju7WEgPnzNjqty2UOshFvRVUbsg8PyoTMei5ZnHw+X45qjBG+Nq
	 ZYatKOyKHpE6qLrtRX349XIjypt1mS/o0Gt53Bb8JiqMSX/cRGmZ+dutpHf32NK+Y/gpB
	 GVRinq/Cn4zhLBUv9TI6TPpQxGLlgb4PljXExJPdclNayohZ4rc8GpDFUq+ourw/kr4lz
	 2aMyp692E99srOqz67bP5j9uLyrUmbknEtSHHW0/e810UATBVsx4s7cQERzmAC51uUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196878;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hPBW/7zRH6GMUll1hA8NAc0pSWv7wG1/hRY77ehO/Hk=;
	b=Ggnit3X6779TgVxuhkTVqCEG0yGWyP1kRKES2noX3j/ebAIAUavjZdIsB/iaE+ishapz
	 XSW+yWQkjr3Ln9S6jHIm/aqnEUY6StgKrzy/dIZ0Cky/la4SXWdoiij3ioQiztxy48iz0
	 v1YHox/l97oxPfsXO+t7WU7S6R+8t0XqGnDDyuIpfVMiqjRMA1B4hyrFlt6QeRNT5Z3zI
	 qHycYhoZH0Lfl1irGr1+GhbjGov4INU+RcXzN+QjeVG7ekHVQS+JXvkXvO9nAOQsJoF2V
	 s58tgyXcm04tVfpyWDG497cEvaSMZ6vcKfUbqltTPXEfotJIZ8q5kvAirRdeTFx4RZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QngqSkRO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C384606A321;
	Wed, 28 Oct 2026 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QngqSkRO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400CE1F01828;
	Wed, 28 Oct 2026 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196878;
	bh=hPBW/7zRH6GMUll1hA8NAc0pSWv7wG1/hRY77ehO/Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QngqSkROpFbKx0iJsex49+S4ybLbfMAzkuqorTHIDs7qAu5EWm6H+4yPLkgShGtgN
	 eT5qVSh5xtm2glCQIsvBTFD0L+InUjEGfwZ519gp1nClEGE+60ZtlGphCMZGmpuBa2
	 CGEOtW/QggNxLfMSOV9NG6UKTAY3nS/6Qoq+HlnUy8CzYsnj2znxTMy+wN76RVq5vN
	 GB+PQP8ep9bnbxQJJ9AEoTDf+DizgRAdMFNXDkZ80m1YWyNgDWo7yixnRmFp/mkMEf
	 Mhwt69njQ8ylNbvLDODXcP2hx8lA/gRu/LKupzDE9EDeRTWcIFKyO6rICE/eGSo1AQ
	 1wAIBfiRs9QnQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.6.y 1/2] mm/damon/sysfs: put target pids for damon_start() failure
Date: Wed, 28 Oct 2026 07:14:28 -0700
Message-ID: <20261028141430.161175-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028141430.161175-1-sj@kernel.org>
References: <20261028141430.161175-1-sj@kernel.org>
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
