Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A142D75B
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177603; cv=none; b=QX/6zPZMj2i2fXIodsPOQ3192paMtIXiqJO/1/xOyhrIRkRmeJTWylehoFYmLhOi38/1+OItIRIYO5Gkzxku073pmWbIg17ezr3yrwmHY8WJ/be5nCnf+rF16v7ITAa+Hwkk0btdJ9tzE8cEN5tFDM9ejl6sB8+2zOT4Po+/lio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177603; c=relaxed/simple;
	bh=p2+ISToaqttj/YJXfseltchQL3Ouc7fkeE8YFtpYlYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=En2B9vbKcPSaMr5+fOEKD1Ie/osEK2wwXxMAUZys2wMmmU+DW0UzhzqSQosBW1q4DIDlQ7m1Tms/0WhuaFW8k4ntptYvPrfl3y7Et/lsGhs2z98vP+tS61c6pFUxw1ccR4rkm9Ach6BXzIE06auNX+XzCsCCpui5GHry0hi/bDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkzol7AS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkzol7AS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53C21F000E9;
	Mon, 27 Jul 2026 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785177600;
	bh=l5rEWuRmCJQbJaADxTZQnxZiPGHwPEBT+rm4ADbiR28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xkzol7AStX45vaHlHxLgTrYiZdTwQqgZsnbAXSrNFrdHHfD58fr3spRnS1ATL0Cvo
	 1N+DamAcbVr2w5eTg5chQi2yEd+Mb/IGGgjlV/Snwn9l5OA4u/4niiL21RHGerT4bk
	 VPib81gXNBSFju/dYBNjTpE3pooUBk78ZpOaU+bIpNneL+gFLJGIrLM3tQu/WkbJdi
	 gz8N8/00Fyqgx6ztiEQmY3wY2cwdTwjKGL7yPHDzqsfo9lAr1MJ0NtYWMBsBmHEpZZ
	 czqpDn07ciBtH4J/LVNzfnqKjm/2QzXc2fc3GMc/27Y7rA6eBbPSsODn1dOMJV5ssa
	 tb6wn03FlD9KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] dm-integrity: fix leaking uninitialized kernel memory
Date: Mon, 27 Jul 2026 14:39:57 -0400
Message-ID: <20260727183957.1545701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072033-produce-defense-a018@gregkh>
References: <2026072033-produce-defense-a018@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 7bb03b2b01b814a9fc14afbfc2cbb2cca5b34750 ]

If hash size is less than device's tuple size, dm-integrity is supposed
to zero the remaining space. There was a bug in the code that zeroing
didn't work. This commit fixes it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-4.6
Fixes: fb0987682c62 ("dm-integrity: introduce the Inline mode")
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index b661be629da260..0a7be46701a9c2 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2502,7 +2502,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 			struct bio_vec bv = bio_iter_iovec(bio, dio->bio_details.bi_iter);
 			const char *mem = bvec_kmap_local(&bv);
 			if (ic->tag_size < ic->tuple_size)
-				memset(dio->integrity_payload + pos + ic->tag_size, 0, ic->tuple_size - ic->tuple_size);
+				memset(dio->integrity_payload + pos + ic->tag_size, 0, ic->tuple_size - ic->tag_size);
 			integrity_sector_checksum(ic, dio->bio_details.bi_iter.bi_sector, mem, dio->integrity_payload + pos);
 			kunmap_local(mem);
 			pos += ic->tuple_size;
-- 
2.53.0

