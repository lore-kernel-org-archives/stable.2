Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678947;
	b=2sjvivM+mg5X0fwIdn42jok4w2A4sozLUsUlQ484stcYGLO9rvOI7TGOFQ2qZx5jYPzx
	 GnHB6WtPpRgCil9crKbcSizGLBdrvT98hSqYARWExZd0wUm0JCZhBwZW5l814vizE88JR
	 Rj5roFxlAD03zXDeiOeqQvSjv1bS1/GwcORT1rUthwecoKkQ4rvPCPPnmH/SI/klws6Pq
	 M8RpOlTYk2c4zvZw1345Eh6IQD7GSSWRLu4k+V0AjXELeECq4VVrrnM+BZFi4UvfoDu+u
	 syRGyl86U5sMsMVEJjE3XVcQZKVIIyGMlJB+DyKa3qx+snqbklin0bpvdDj3X9UbJ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678947;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5g472a3W7vVawC72w7jxU2fEzFDDELB8yS2gjaZQmsU=;
	b=APPYZboBv0KDuPadrRkeEjw+mPuZXuWW6G1OroNTF1KauhWG/JCVXtE67+kHVD2UIV47
	 rDJ57yoPJOTtaNznPOhKIBY9J6EvSzTR09GXXBw0aE62QJCehLTUaQAG1xJDdiwf706iZ
	 rznhktRJpCQkJY7MG5SwiC/rilHN3oWrV+Av5lGIPzp4lb8Zv7terswXRxL0/lU5p3UaA
	 2EObZ61cL5DKSU3IM9lxBARkPufYPWNh0enE0yc2xFsj0qukdTsY+EH2cMzzagOEo+tOx
	 t1cUWCgnlr4BjnJGibheGvgiWVTZPghq2jorXhF7QPhI+aYAfMHWzQOVFMsCuobMwEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JImdU/3i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFACF606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JImdU/3i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1640F1F000C1;
	Thu, 22 Oct 2026 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678946;
	bh=5g472a3W7vVawC72w7jxU2fEzFDDELB8yS2gjaZQmsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JImdU/3idoz7p4lOhZ7p1dofm97NKdnQ2sxbW4yCBoa8/ITessr9U8BVuSttjd6ga
	 uWys63X3xEAd7o5k5zAF6uV42rWqpDZ3NPKu93Byp8pDoynfLCYAgGolYaMRRM9u+D
	 3ZpiKqbUms+Tebg5H7P+m3DtFn++pbvqvd0GJ1QVvyEH5ilvXPAGcot92lE/gWlTPp
	 TQH73uMJSkoD5oR0JVXqtY2SNO7UoYstvBf59oE13mb0YtJT6OccIFvfjsp9qzXfUp
	 fabLTnPq3MY6D/Gcs6GpU/TyQPnT4dHvcQDgnSCFN+K06CEeNjaStL78P3V3sSczk9
	 VgRBM9IzjIqPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ben Cressey <ben@cressey.dev>,
	"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dm-integrity: fix infinite loop on discard with large tag size
Date: Thu, 22 Oct 2026 10:22:24 -0400
Message-ID: <20261022142214.1516335-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102106-hacker-likely-7fd3@gregkh>
References: <2026102106-hacker-likely-7fd3@gregkh>
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
[ sashal: Adjusted context for the absence of keyed-discard support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index aa6f3e71c4fa2..74cce5111637f 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1814,7 +1814,7 @@ static void integrity_metadata(struct work_struct *w)
 
 		if (unlikely(dio->op == REQ_OP_DISCARD)) {
 			unsigned int bi_size = dio->bio_details.bi_iter.bi_size;
-			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : HASH_MAX_DIGESTSIZE;
+			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : sizeof(checksums_onstack);
 			unsigned int max_blocks = max_size / ic->tag_size;
 
 			memset(checksums, DISCARD_FILLER, max_size);
-- 
2.53.0

