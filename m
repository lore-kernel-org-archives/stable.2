Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794557254;
	b=pF8otwu/l5rAY7gXKfQgSU2CRFsQLNr+ES5jNC6i8coSQy90VuCxjhL/nu1pp5iJsX2t
	 SRNjayZU4AbglQ3M0bKgbVBCj/N2HMk+cyGrLTTLTHHZK7vGBBMfkevM/picUNKR9KgBC
	 23WOMsP91cUJAw9VbO8vj/n1AV5LMDI7sPv3ddhdZPUqRSME5T+Hg4Xbh/bc05McdBYG7
	 4WGakniH5iySVNmlQjPSXhcVRmNIiFtBaXii13LYSKoxs2Dh0mtB/7G6vnSs3McSwowov
	 J/RMFPrlnPFoEqi/O+Z42lgIr6BFKqi7bqJgfGaKTMIETHY2vMAquVY5c9ht+4mVGuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557254;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FJa51iLhuBZSvZgaCQyHA9gsweQVYJTDEV01suKMIE0=;
	b=iCUmQZOrJziOF5ZwpNFY4cqhxyHNF3g1R0134e8ZR522p/lIlBqL8EtfGZP0oZusrvu1
	 dIqfyx3RZ+8B5RXG0r4N/fo1jKbqauFpJE28VNj0XjzWSvDGLWL5ddEg1zzdVxtoVCQEL
	 eH3MynCbvCV5ewcCpphlcbHF3F992a7dj09W1Um1Tv7j3UMXrUeYOX35t5zW4Ve1ONV9K
	 QRkDjN/WHVFzPgN9he9IgjryajyRPzsCWaqc0fnnEs0NTIGok1d3wDZ7clrQ+Z0nBEV9r
	 KU43IsonurATIAdbjKlVtXDfZotqMrphNkXGyTDYTmiZKkelWSnmUSOZK4D6nDVR7xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="XlARs/9g";
	arc=none smtp.remote-ip=95.215.58.253
Received: from mta1.migadu.com (out-253.mta1.migadu.com [95.215.58.253])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417BD606A890
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 417BD606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XlARs/9g
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7f/HfuvjReljqnkx1PiPbyRP13u071+OBhrkb2fzJn0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794557252; v=1; x=1795162052;
 b=XlARs/9gfpDrxjj0XEPzjxIh/mBRSiTOSsg/y+Gjfs2SlVZlotI0UJA6O4vHyu6lslpdMJwx
 b6z8RcmgsMztpRL2u+jS0eHz10uMGzwWVhxW3lFsPsSnS9/XOh2kkJrxDe9xwgsZuKVCu6yP0x7
 07o8hevuG1MV1TkLxfgFunCs=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0a072412acf0b8bc;
	Fri, 13 Nov 2026 08:07:32 +0000
X-Mizu-Trace-ID: 0a072412acf0b8bc
X-Migadu-Flow: FLOW_OUT
From: Youling Tang <youling.tang@linux.dev>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@163.com>,
	exfat@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] exfat: fix iomap mapping when writeback races with truncate
Date: Fri, 13 Nov 2026 16:06:56 +0800
Message-ID: <20261113080658.2440516-2-youling.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113080658.2440516-1-youling.tang@linux.dev>
References: <20261113080658.2440516-1-youling.tang@linux.dev>
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

From: Youling Tang <tangyouling@kylinos.cn>

__exfat_iomap_begin() reads i_size twice: once to detect a range that
starts beyond EOF, and once to clamp the mapping to EOF.  A concurrent
truncate can shrink i_size between the two reads, so the clamp can
produce a negative length.  The unsigned cluster index subtraction then
underflows, making exfat_map_cluster() believe it has to allocate a huge
number of clusters and report a hole.

Fix this by reading i_size once for both the EOF check and the
block-aligned clamp.

Fixes: 82a81a7352bc ("exfat: add iomap buffered I/O support")
Cc: stable@vger.kernel.org
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/exfat/iomap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 4e6f3ed9dcc8..11823591b3a8 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -51,8 +51,10 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 	bool balloc = false;
 
 	if (!may_alloc) {
+		loff_t isize = i_size_read(inode);
+
 		/* Completely beyond EOF. Treat as hole */
-		if (i_size_read(inode) <= offset) {
+		if (offset >= isize) {
 			iomap->type = IOMAP_HOLE;
 			iomap->addr = IOMAP_NULL_ADDR;
 			iomap->offset = offset;
@@ -61,9 +63,8 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 		}
 
 		/* Clamp length if the requested range goes beyond i_size */
-		if (offset + length > i_size_read(inode))
-			length = round_up(i_size_read(inode),
-					  i_blocksize(inode)) - offset;
+		if (offset + length > isize)
+			length = round_up(isize, i_blocksize(inode)) - offset;
 	}
 
 	num_clusters = exfat_bytes_to_cluster_round_up(sbi,
-- 
2.43.0

