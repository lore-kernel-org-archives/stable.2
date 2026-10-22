Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686475;
	b=Yea/3ZytpKvQpptysfDZ2cfxeBTUYHpasKFohe81I3MuZCaCE0blBOToc+snTy8LaSvw
	 /jpn8Uo9x4tsWNSo2DsLYS+n58QYHVXfURySlcpCahTeqNBFsdi0V/5psufg/9c4Fe9W1
	 PUQp7ySYNHtOnSJkBwxFkqE8l+QDBOPmYTky0MmRXGgmDwssOfjoIlSM0hqSJ6DKfLJuC
	 bmQ8y18/ea4d/6RbAYgzQYumR8/u1NjhgqmlI5Nj1EeJjiF1TYQbPye0LiZ1NF51gW1nS
	 9hr0b3XKRi7DsoObDY5o4KVuoZS8zFHphUh7MkGRib2MF+IivJBR3EH73xip2Tbk2Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686475;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AIXLb7UmWn9Q700/NYvZ8cMUcOj/P6K1NPcRzmUNfyk=;
	b=ey9Vj0Q2iFMy0VRhZq5a8LbGonNP7JfvYUD14b1dV+aAuYfQ/G4LOONzocMFv+9cIdlD
	 CZao622SNF7Orvx2jNIahj5n7p8xA5xXR+Tkt8zoOdTdCpQ39REoTlbkxOIVBWSNAc7xh
	 kXmEPv4kyGCCiDqYAFOimnrIuq7cJ0bJcoPk+HQpyZ2iojcCqOYb64rCt5Wt8S/5sTfC/
	 2IDTxRFYjlQPWPvOGHzDhFJklK3fdTf4l87bQQ1KYxjUuhOYMgNmwzyQ0ecD2HnbAY2IE
	 fEJ2VoTOiVk7lJ2sT6ByUXBzi9FTG8p/dy/SKEfon1aASBteBkdHeUsW2SLHGAFE8Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkJq2ESx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C2606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkJq2ESx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556911F01825;
	Thu, 22 Oct 2026 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792686475;
	bh=AIXLb7UmWn9Q700/NYvZ8cMUcOj/P6K1NPcRzmUNfyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GkJq2ESxV3L7xB4KVZbQwyRStWk5R+1RkhrgfC7iK+Ny0WHVLf99NzaVaPG9iU18n
	 n1oe6z7eexnPwumu62UVFqgnAM7PfC4olzkJabriurDy9dry/qdfhPMDj+vQ7Hswzl
	 7xpneM3W4zZo49Wp7XLxtbIm7Pa8UBKmXmQyE3olwyaBHuBYrFWBjf6HGRuclM0vRv
	 E4uG6FAmBmryOUXqkIshg9cdTM2oytXaCkIlCTp4JRCuwOGU5T0tYQsImkSJ+Wo/9A
	 +mMkQMsOVJJsFQ8xbWz3CelF0kndx1pGbils5EWAk8feJ89kWlN1scybATwP2cd741
	 Va0DIFTX6k1xA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ben Cressey <ben@cressey.dev>,
	"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm-integrity: fix infinite loop on discard with large tag size
Date: Thu, 22 Oct 2026 12:27:52 -0400
Message-ID: <20261022162728.1672960-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102107-handled-starlight-f1cb@gregkh>
References: <2026102107-handled-starlight-f1cb@gregkh>
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
[ sashal: Adjusted context for filler-only discard handling that calculates max_blocks without subtracting extra_space. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index cebffb0b5a1af..5c81b57a457e4 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1725,7 +1725,7 @@ static void integrity_metadata(struct work_struct *w)
 		if (unlikely(dio->op == REQ_OP_DISCARD)) {
 			sector_t bi_sector = dio->bio_details.bi_iter.bi_sector;
 			unsigned bi_size = dio->bio_details.bi_iter.bi_size;
-			unsigned max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : HASH_MAX_DIGESTSIZE;
+			unsigned max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : sizeof(checksums_onstack);
 			unsigned max_blocks = max_size / ic->tag_size;
 			memset(checksums, DISCARD_FILLER, max_size);
 
-- 
2.53.0

