Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696215;
	b=xw5wM6CIJxB2i7jlD6A6/Dm/kUtl2d99Y1w/TElvNpOwewbVDCOas44a0hGVC1nR7mFV
	 QyLNjd27S5WP6JmCyxhYHK9NMLgGYvk0AJNLq3/ztcV18AMC4LB3olO2iLF6l2kLgG1n5
	 Rhbp7FsRU1V0tBMS0J46bJSHOnK7yBMhijQANeITWulkq7Lq5l/y4gpymMnsQAxM1R3Wf
	 e8FFLTiufupXTf0Xo/NzEjyUFB0gyqJihdC2P99WmIa1mXPjefrE6acD8e8K6lHcu4E0Y
	 GhdHDkHbaJVHI/dQHeKCl6t2CHMTY3QjBcYSJ13e0DZasmWNWFcakEAPG2n0JbO7Jpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KB9O4Aps1vB5J0drIudb7KeayiagDdQOT2g2nYo4vMI=;
	b=Nac30vKFpsopJgfkzGjuRdHW61vFPLBxSegnUHDXklbTfpgOIIoPNKkMlQ8Nfb9JG4Ws
	 Js0sjYeIh8NprbY6Lioi8PyQ7KaFNr7J+kcXxIxWP+F+bXq+b6PDCN2WzFDAngwTDXWLL
	 osrxhRTtLxM6QEg8TmSRgJyxRW+VrSDY1Ny616OlPlrSFNpIefMSnbWboRqw0xaoSoyhR
	 RYga1ExxUJejbHVK35zFawldCo2rAHlmatMiLDbqMlRogBltgnb82/BD7g11v4GUzs9qX
	 2tPVE1fBRMZ4bySV8/5xRrUObFIFraxfJg5JGbxel5AV9iVrV+FAZIMifqhbbq6VTBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8czqC5K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCCB606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8czqC5K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF001F01825;
	Thu, 22 Oct 2026 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696215;
	bh=KB9O4Aps1vB5J0drIudb7KeayiagDdQOT2g2nYo4vMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i8czqC5Knnl475ORvb6rHTXllblrB0fNhQw5QYVm9hPuyU+1b5I/7JApqGpDsGqzv
	 My6UvzfrILEZy+ptqomcKJgaK/TwveXsT3EBir9skNUMp63KAVVQ/E8V7pdNvU+hRh
	 bJVBFJP8Ckf1hrwoZ4C/PdY+jf2P+fgolJIhADlRbhMFdIwPyqNZKRlvXij+S2DtBj
	 SKjmjJJaK7bujPXMmy0xVcO3/7ZFyLkC0C6oW4LGi5lXZ5TuFeayz6Nyz9seNcbdyY
	 wD/zPJ811bdYOEbkAzTqEPPyCRFNPtVpYN4t4WlriZ4O4fTLLAxKwYB0VBPtL5cL4L
	 PRuOF0zMJRlkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ben Cressey <ben@cressey.dev>,
	"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm-integrity: fix infinite loop on discard with large tag size
Date: Thu, 22 Oct 2026 15:10:12 -0400
Message-ID: <20261022190946.1761316-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102108-cahoots-counting-9b8e@gregkh>
References: <2026102108-cahoots-counting-9b8e@gregkh>
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

From: Ben Cressey <ben@cressey.dev>

[ Upstream commit 18d80c77b4c7dd20699e81cedfbbff4e9d198f28 ]

When integrity_metadata handles a discard, it fills a buffer with
DISCARD_FILLER and writes it over the tags, max_blocks blocks at a
time. If the kmalloc fails, the buffer is the on-stack array
checksums_onstack and max_size is set to HASH_MAX_DIGESTSIZE. So if the
tag size is larger than HASH_MAX_DIGESTSIZE, max_blocks is zero, bi_size
is never decremented and the loop never terminates.

Fix this by using sizeof(checksums_onstack) as max_size. The array has
MAX_TAG_SIZE bytes since commit b93b6643e9b5 ("dm integrity: fix a
crash with unusually large tag size"), so max_blocks is at least 1.

Fixes: 84597a44a9d8 ("dm integrity: add optional discard support")
Cc: stable@vger.kernel.org
Reviewed-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Signed-off-by: Ben Cressey <ben@cressey.dev>
Assisted-by: Claude:unspecified
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ sashal: adjusted context to match the discard handler without extra_space accounting ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index eb13b98ba0a9c..4181151637304 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1620,7 +1620,7 @@ static void integrity_metadata(struct work_struct *w)
 		if (unlikely(dio->op == REQ_OP_DISCARD)) {
 			sector_t bi_sector = dio->bio_details.bi_iter.bi_sector;
 			unsigned bi_size = dio->bio_details.bi_iter.bi_size;
-			unsigned max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : HASH_MAX_DIGESTSIZE;
+			unsigned max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : sizeof(checksums_onstack);
 			unsigned max_blocks = max_size / ic->tag_size;
 			memset(checksums, DISCARD_FILLER, max_size);
 
-- 
2.53.0

