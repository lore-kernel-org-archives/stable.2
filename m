Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669778;
	b=Li7bu35D8b6pCaY2RpOs3Yg2XCig50pzoVKvhD1eNHBKWZrHkAPOcuvxwxseo7cYwrRe
	 WUw+HMTpZoUnlAhQIDsBYvy3JDTswGs3ef7rbGYgWnHTCGw+GvHbYBqFqD1/SBug5dEAh
	 CQPcVvb80gd+sQtJtopc3pA8/Qgmpri761IZBt8pogqIkjC3EP85DWOW0mEenkfzZCNnk
	 zvHcXoHchejl6T71Z6tgU8FUOC4g20A6qEBYDPDReoBiM3TGczBdqxQ/pHKzXzKb8+AeW
	 5f7IFNUZsFGkYt1fpO8HEiH8W47XrAtAuNDFgfCD+vpiotW3lzBxUwvWDk12xkirgkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669778;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=60OWFvQXBYEW3i6deUEbdz5eMdecLdNgwFKLqAE/9B4=;
	b=SNYPmLAv1+joSCumFqc7pysT7chNmm6QYV9LI59sth0muwnI63L50/GNbpszcyIbbYaQ
	 BakmXuNRAMR/ldXlDOSeFFlT03ZH4BlpIykKWY9EkYoQCeZ/z08Uvfwhf2etwUTMt1g4b
	 zWKyIC7aVZpdCq4sXZzmltUDW4cS8KO8AzhAnAdAYOHMHsiblCBcLKAviKEylZ7QZXV3Q
	 jk2gfGs6wg0KWhzfJKGUqu4Pdj5oaSk7BMEB3CCU8brKHLuE/40QsUxXLiiGNRGJSetVe
	 M+U9XQSTx4Bdpgi8aICErPtC+wjPzj9yVIlVw/cG1uxgG6yGPHGze/GHHCNI3aIKzxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hfrG5vv/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD724606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hfrG5vv/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326761F000C6;
	Thu, 26 Nov 2026 05:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669777;
	bh=60OWFvQXBYEW3i6deUEbdz5eMdecLdNgwFKLqAE/9B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hfrG5vv/3Jb+5MbbuhayYC1hnld94qaEtlSxdfc7WckZKi2lXWd43hTykKeUkB7ZP
	 IpKIEs6k5/e79Fu89iuqkDnsTFu+njRQu+WChZlt12qX5vJd9OzsHVnN5S6cBBmcXA
	 AOZZdNh/HCzVimdfn7ROC2j8JRIFTETe1MtXTbxbFLJJKJKMbxVj273d0O3ebpfieq
	 8fkU2m6/V7IbyE7MEOga+DSUFLpdQpuRF8p5iRQw8xnBSu1fmHRPYfpSUaG/b100Zs
	 UMQa07Us7DthS5PQa4a/8iszOOz6BcODU1iF2djx2I672nyg5NeEewLaebignk92Rx
	 PgYfclI1Paxsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Tejun Heo <tj@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dm: fail a REQ_PREFLUSH bio with data when its preflush fails
Date: Thu, 26 Nov 2026 00:09:36 -0500
Message-ID: <20261126050917.2118067-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-marsupial-slacked-eb2c@gregkh>
References: <2026112517-marsupial-slacked-eb2c@gregkh>
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

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit e92cd41e8e5ee5616c6c7cd4378661d942f0a7c0 ]

For a bio with REQ_PREFLUSH and data, dm core may send an empty flush
first. If the flush fails, __dm_io_complete() still reissues the bio
without REQ_PREFLUSH and drops the error. When that write succeeds,
the XFS log keeps running and fsync() can return 0.

End the bio with the flush error instead of writing the data, as
blk-mq does.

Fixes: 6a8736d10cb4 ("dm: relax ordering of bio-based flush implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ sashal: Adapted the condition to the older code, which tests bio_is_flush_with_data(bio) instead of the requeue_flush_with_data variable, and added the !io_error check there. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 0af19f3116108..0a3375309f822 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -965,7 +965,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 	if (requeued)
 		return;
 
-	if (bio_is_flush_with_data(bio)) {
+	if (bio_is_flush_with_data(bio) && !io_error) {
 		/*
 		 * Preflush done for flush with data, reissue
 		 * without REQ_PREFLUSH.
@@ -973,7 +973,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 		bio->bi_opf &= ~REQ_PREFLUSH;
 		queue_io(md, bio);
 	} else {
-		/* done with normal IO or empty flush */
+		/* done with normal IO, empty flush or failed preflush */
 		if (io_error)
 			bio->bi_status = io_error;
 		bio_endio(bio);
-- 
2.53.0

