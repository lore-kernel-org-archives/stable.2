Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577B3F4DF2;
	Mon, 20 Jul 2026 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546049; cv=none; b=cjF0eLqYUfbTqC7rpTNxoU5KcwbK701lUi4A1rM4YJ9nJzcyfoN3KAipdHqRVDmyr2IDR2yDyhszQwwniXJjcCviYHFR5LEA3tt5sCa2AQ2bPzRbP53COiwSwvjCNeWBrlZIz9GqgC0Z7fY5Y6ri+yGZNqm4736eyPNT3ebXMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546049; c=relaxed/simple;
	bh=YI82VNNEo/LwgUIDuwttqbRtglLcASOGSIS8oEAYia4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6t1bO1bhl9PHDCyHL8k3TQcgl/cOTGc3+Z7yqUY/WbyFFnk1cVnpqYY4pZ7tnqQRp/n7mYg8cinyqAodcaB2lYAqEtqTXCiAa2u9AVkDtjHaJYNWs26dJBMpia7w8khA2PLVLi06vwyv7rIiRbT3X6n2/gf4nHcy2OkiH2vjfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10F71F00A3A;
	Mon, 20 Jul 2026 11:14:05 +0000 (UTC)
From: colyli@fygo.io
To: yukuai@fygo.io
Cc: linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org,
	Coly Li <colyli@fygo.io>,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH] md: do overflow check for sb->bblog_shift in super_1_load()
Date: Mon, 20 Jul 2026 19:14:00 +0800
Message-ID: <20260720111400.2120834-1-colyli@fygo.io>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Coly Li <colyli@fygo.io>

In super_1_load(), sb->bblog_shift is an __u8 type value loaded from on-
disk superblock. It is used for badblocks API badblocks_set() by the
following sequence,

 1930   rdev->badblocks.shift = sb->bblog_shift;
 1931   for (i = 0 ; i < (sectors << (9-3)) ; i++, bbp++) {
 1932           u64 bb = le64_to_cpu(*bbp);
 1933           int count = bb & (0x3ff);
 1934           u64 sector = bb >> 10;
 1935           sector <<= sb->bblog_shift;
 1936           count <<= sb->bblog_shift;
 1937           if (bb + 1 == 0)
 1938                   break;
 1939           if (!badblocks_set(&rdev->badblocks, sector, count, 1))
 1940                   return -EINVAL;
 1941   }

bb->bblog_shit is in range of 0-255, variable sector is 64bit width, for
an invalid bb->bblog_shit, it is possible to make sector be overflowed
by the following calculation,
 1935           sector <<= sb->bblog_shift;
Then in turn when call badblocks_set() at line 1939 with the invalid
rdev->badblocks.shift set at line 1930, may result an overflow inside
_badblocks_clear() in block/badblocks.c.

Although there are many places to call badblocks APIs, the non-zero
shift value is only used in super_1_load(), other places always use 0 as
the shift value. Therefore it is unnecessary to do a general shift value
overflow check inside badblock API, and just check here as the caller.

This may avoid unnecessary check, make the badblocks API code more simple
and elegant.

Fixes: 2699b67223aca ("md: load/store badblock list from v1.x metadata")
Fixes: 1726c77467833 ("badblocks: improve badblocks_set() for multiple ranges handling")
Cc: stable@vger.kernel.org
Cc: Ramesh Adhikari <adhikari.resume@gmail.com>
Signed-off-by: Coly Li <colyli@fygo.io>
---
 drivers/md/md.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d1465bcd86c8..67f8edf4db36 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1918,10 +1918,17 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 		bb_sector = (long long)offset;
 		if (!sync_page_io(rdev, bb_sector, sectors << 9,
 				  rdev->bb_page, REQ_OP_READ, true))
 			return -EIO;
 		bbp = (__le64 *)page_address(rdev->bb_page);
+
+		/* check for badblocks api. */
+		if (sb->bblog_shift >= BITS_PER_TYPE(sector_t)) {
+			pr_err("md: %pg: bogus bblog_shift %u for badblocks.\n",
+				rdev->bdev, sb->bblog_shift);
+			return -EINVAL;
+		}
 		rdev->badblocks.shift = sb->bblog_shift;
 		for (i = 0 ; i < (sectors << (9-3)) ; i++, bbp++) {
 			u64 bb = le64_to_cpu(*bbp);
 			int count = bb & (0x3ff);
 			u64 sector = bb >> 10;
-- 
2.47.3

