Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669621;
	b=1xuuKK8tKQ692r33hHtgyNv0aUyxlnjG8dRxgkTSs99al2b+WKm4SUoMaEYLUI9DZ403
	 LgaXV0pVAY4rAtr4UmEbkV573I8JSJd06BgWOQjF6DxBsVOMPaAZJbryu+JfFpFpMsG/R
	 9IE3EZYK1QqlAY/IGLy7na+2n61iEj53dYub7JSVzpErJUe66B4JYfgOASNMX5hLO25sg
	 yXYXY1FfGg35J4agb6ZLsP1AlZz7zvVIijkf3Hp6rtIyoqK/kK48zS8RwAG6A8UZuub1z
	 8AT4oWwW8kr0/Qx/rvZCphXF686ZNHGt4+EYRqdt/3hNIMVrMwiAX3njn2+AeeHxBGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669621;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sbe8nbmG9CpDhbXb2R4phS5qMz1GHK2DDklG/eO1+Eg=;
	b=j2aDtfBpmALBJglH7Mi41De1Zus8O5w94atsoCnIVP6zjYgsNPnShZTIII0s4VPJgFgW
	 TQXunmxCgKRG+QOPZVWVoNVunauD+e0ZpD+rQ2bTxrzS1dK/UA0eXVwzKZpTPI+/Vum9K
	 QVZ3fm36ayxAqOJ/+1lAQHDCyBNUtzxjWFpdQZ+5u89YIKq6+wqVJSdXQMPIC1/TEZSbt
	 3HKfKxzqrsZHIBU4NXttwIG8bC2N852rYao+Fl6lOdIrZDHxIsdtcTpnmAtpLIbQ2vS9o
	 p57Vtw/bu1rhhV7W8ghxxrwYPwLWaXs7wQ4mjYiRo9fAnRGo2Fd0M2jDT2OMbl0F5cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRM57qbK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95909606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRM57qbK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FEF1F000C4;
	Thu, 26 Nov 2026 05:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669621;
	bh=sbe8nbmG9CpDhbXb2R4phS5qMz1GHK2DDklG/eO1+Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRM57qbKHYkXvUOth5MOFuvqjDWhlPAdZGVyUD7NuAm1QzrM535/nnfwdb7/1IXbi
	 zV3DuQKaDvZEVhW6ZzDh0Fyrk4f6A5L7FPgTQ4HTnn3jRywjjzqtZ/ArDPMgM0br1o
	 vehFx49EjzsMFZlcqv1z/OtV8FLUH5v0fmFDgIRw24Ap1Fhj6X9Hic89HGtkQYAK5c
	 KsK0J3sqOMc0I3efkQMntKFEobmkfoxRbBCD7VKrnrJARu6q95TvdU/sPhaFzXtYvF
	 LBwlE0q/uPXPazF0ujWb9uleDSpDunt8zx3bEa2kkeZmi1mtpKt3bZsdxN2mdmfV08
	 8fIyYt5W1NNKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Tejun Heo <tj@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dm: fail a REQ_PREFLUSH bio with data when its preflush fails
Date: Thu, 26 Nov 2026 00:06:59 -0500
Message-ID: <20261126050648.2100171-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-activator-retract-73ba@gregkh>
References: <2026112517-activator-retract-73ba@gregkh>
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
[ sashal: adjusted the condition to use bio_is_flush_with_data(bio) directly, since this tree has no requeue_flush_with_data variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e4ebdd3d56d47..ee729dafd924b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -960,7 +960,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 	if (requeued)
 		return;
 
-	if (bio_is_flush_with_data(bio)) {
+	if (bio_is_flush_with_data(bio) && !io_error) {
 		/*
 		 * Preflush done for flush with data, reissue
 		 * without REQ_PREFLUSH.
@@ -968,7 +968,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
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

