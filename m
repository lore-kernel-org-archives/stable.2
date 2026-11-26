Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669401;
	b=v8Mix5zGPhJv+YCIQ6DkRcR/8PdY3kLyUIByKFZYvwky2JVwIFqb4pfcrwvGcFzZS2iM
	 3req/PmrXbTK0+qEPOHyETEZMfvGIG7ySlIW1OXS3RyBI8uaEdZOnBVjoBPqbD3VRfkmU
	 s1Ha+YaPOqiJNZNvrzjnop2hqv9m09GcZqDFwaW8J0UI88Aj7gxJiJgmz+0bz7UEt+Bor
	 LR5y46K5WZFBmxKB14owor4JePXQB0UwmU6c9z/2hNWh0GXpIm9zd3imuVj2S6aiFRXRj
	 XGq/hIoOD3YrCpwzmhwg1oW6uCnQl1yQBNHRVGK4MAfBad9lXvD+j/ZKzwaGr6yBvGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669401;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VAu1HXlpUTHHj4g6UahTzKs/6g35c+Z8vLKXwQCKH5g=;
	b=ULRP6x7v8Vl7HF/yeKrdX2e1+2Lss92h3h4hW5yrLpGD/Wbp9gKAY/aI4DHaskC7VRLT
	 KOsMaq2YBhVkbIrgxSKfCjlE2vYHb6uppDmoaWaNMztTHl10VFgqVgC8MFsEgPWPlPvDl
	 0Ztb/tHPZgGRCnNLfXlxO9hpxSoBPNCxtTVOqxgqKzLzcX4NusB4p9mwyH2DzN8LANH+A
	 UdNomSLBHXwUZZNM2NNiTlSFq1oNqq5rNZAHkeF0oI5QLMewMnBFvhmBws7dC7IUyshUQ
	 4MT692ydoG/mZzMwp5uExeNIjAj+g0gIZ5ML22fZiy0MRsl5zc1noJpiQf0LAgR8DLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qyn+juPo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDC606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qyn+juPo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FE61F000CA;
	Thu, 26 Nov 2026 05:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669400;
	bh=VAu1HXlpUTHHj4g6UahTzKs/6g35c+Z8vLKXwQCKH5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qyn+juPoQyU1yOoSxuhVO+IZ4aKHkVScglR7qJ8XrWY82yjE4nDFxRHI8sRTmZoO7
	 InEP3eg/Qg7NBbNkLI4Xv5nA7aiERULXFpav8gj/M9D7YQ1RZTg4BUT3qf80p94G0H
	 gYFqjLrLZQmOSXVndHqPBJ8bOPsl84nBCfrieP5eXU2fGByb9vg2KdGapKlDLhUr2h
	 kQzRqpbleVqWmWMUW3brfsVWBzT8sNA8smV1kY8sivjTlccSNJyTKHPrPUzRhOUTgP
	 f2dh/4A/uFAZRKuXqs3SIGE8JGTOYJlgOxFN/I178XOPxvMhpYIr34kANVA9SCAe1Q
	 CBwHY4SXJ7xsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Tejun Heo <tj@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] dm: fail a REQ_PREFLUSH bio with data when its preflush fails
Date: Thu, 26 Nov 2026 00:03:18 -0500
Message-ID: <20261126045401.2029286-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126045401.2029286-1-sashal@kernel.org>
References: <2026112516-prude-hurried-f333@gregkh>
 <20261126045401.2029286-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 755d8fd6760c7..3bc41230a1db0 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -981,7 +981,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 	if (requeued)
 		return;
 
-	if (unlikely(requeue_flush_with_data)) {
+	if (unlikely(requeue_flush_with_data) && !io_error) {
 		/*
 		 * Preflush done for flush with data, reissue
 		 * without REQ_PREFLUSH.
@@ -989,7 +989,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
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

