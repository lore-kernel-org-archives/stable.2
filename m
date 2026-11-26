Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705391;
	b=Cf4uXnFym1StspIaG+evlemQie81T+/2jpzNm7OSg/69cq1N1C5gtm0GlC7i5UyPM0Zu
	 nC6G+8mc6qEDuEPOaa79TKSRrFgPtH3J/IO4xCvveBCNbUhTAdzHCYZvVd+Hut89x8+0r
	 9FI3vNzEp+jOElkQIbtkBa7Azs/7pf7PMgAeXKpUJeVX6Rct/fPaqPt/21pP7jhBCcyTJ
	 xokb/8N90IroHDWsQZ3SEkZegN7yFeAhDgdqwXm7iMWVLhLKmRjCKwjv81FI3XFU0jzso
	 qVDrtthLfgvvoyFhQQYjm8HRxNyc/rZbNl600UTjBW7a+dbbo7VIm646NJZNS51QSJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OdQm0Q6TDofJJ2xa9WWftT0SCMGe1qFct7jgb2nCB70=;
	b=VxSnWvQyYQqQdm/RHsOaYxF8LsaKCqIo0Dz9lpdPCB1TjOSUUn0Tn+7sZBaiZvuIKphy
	 HYNuLks2qncN7BfWZDVAQnJrLYqALhTqydwv+R9DanbXtn/CrTp/zfQhnSMGgqVWCnKc+
	 1r6Sr7XiGyvX89wjSu3aSKzq7Ju7UlEbpb097QTQHFoD1PQGDWQ+brWcLyRy5UOp1AqQV
	 HADdMt+z1hrhWUy2BdBpFjjRBKK+Ga0jAXnezSHU8OHibKJm+iPefhdkgKv9uDjDbdwlm
	 CNFy6lAiU+XKQuViXjvP5x5PWZUfq28ia8cItAjlcHpyu7DXWjb4WHtItzPaagYVHnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXXUyJ7v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F2606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXXUyJ7v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D651F000C6;
	Thu, 26 Nov 2026 15:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705390;
	bh=OdQm0Q6TDofJJ2xa9WWftT0SCMGe1qFct7jgb2nCB70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RXXUyJ7vFZo7fywVAsL31KRs8GbDAVZIi0hmBrr9kWW18hIg9ct7SlKMF00ECu7sy
	 OkWY+xjVrbaNxh0yx5q2HYFlpkUOXxcGLRINOq5+SN6gf8d65xCPYEKfaM+fGuC0k5
	 jE9yuErkmSyLCW1FDADikLHGzsOvs8ZjFl/Wi9ZMT1HL+NOPIxbA7br6LAtRDccU/E
	 LwI7xgBb8e7pCZYyPr//EnxpG/psK8zHfMh0dWMiEMa+ZoeL1rQVAOY9rT7XJBDKu9
	 tdtZXekNA4Z8Hp9+g/Lur66p064m5y/vNbrkX6FPzqUM07q8dCCJMyZHykSDFf3ZdM
	 od/OrEA25CElQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm persistent data: don't ignore writeback errors
Date: Thu, 26 Nov 2026 10:03:08 -0500
Message-ID: <20261126150254.2213694-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112546-flirt-danger-e920@gregkh>
References: <2026112546-flirt-danger-e920@gregkh>
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

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit fa887f2ebee7aff97eb87b3365939616ade09774 ]

An error returned by ie_cache_writeback could be silently overwritten by
another successful ie_cache_writeback. This commit fixes disk_ll_commit,
so that it doesn't ignore the error and returns it immediatelly.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Fixes: 6b06dd5a9722 ("dm space map disk: cache a small number of index entries")
[ sashal: Kept the tree's unsigned i; and missing blank line in context lines, with the writeback error-return fix applied unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/persistent-data/dm-space-map-common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/persistent-data/dm-space-map-common.c b/drivers/md/persistent-data/dm-space-map-common.c
index bfbfa750e0160..3ce5548880051 100644
--- a/drivers/md/persistent-data/dm-space-map-common.c
+++ b/drivers/md/persistent-data/dm-space-map-common.c
@@ -1185,16 +1185,19 @@ static dm_block_t disk_ll_max_entries(struct ll_disk *ll)
 
 static int disk_ll_commit(struct ll_disk *ll)
 {
-	int r = 0;
+	int r;
 	unsigned i;
 
 	for (i = 0; i < IE_CACHE_SIZE; i++) {
 		struct ie_cache *iec = ll->ie_cache + i;
-		if (iec->valid && iec->dirty)
+		if (iec->valid && iec->dirty) {
 			r = ie_cache_writeback(ll, iec);
+			if (unlikely(r))
+				return r;
+		}
 	}
 
-	return r;
+	return 0;
 }
 
 int sm_ll_new_disk(struct ll_disk *ll, struct dm_transaction_manager *tm)
-- 
2.53.0

