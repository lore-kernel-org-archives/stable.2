Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794556834;
	b=O68DNg1loBJ3vxTdsVAXYgBazoWFGX70pGeYFynimbso2chpAvKwr+Ztr1E1Ryv2EBXP
	 4Z4jlWFVd42jxif+4iD5iU2WgjmkPg9FzzrAeyY2iZmMeoPyd79lVlAnI/LGobXHC2iP8
	 ntuKSXT34csc7HSX8vPohuOAXTO08YVg977cCxs6wCfD8hyn9J/i2BSOXAMGPjVR9hFAd
	 xBVvrMiJANbhZDTZ9+Xtq3jKO120khdPvK4gZSJ0+GfjFRXjyLCt4fEbsHzd2dbKYN492
	 CN1Fs5bUQ9oeqtSxg6FI7FA9qUklaNLcA15HLEgdbGIJXQnAGBFvAO3eKjNVHNp/wZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556834;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FJa51iLhuBZSvZgaCQyHA9gsweQVYJTDEV01suKMIE0=;
	b=5MpHh8qtDT6Wj9iY1bb80eMW7wizLXt3sMKQyf+cNns2kXd59IG8N6cMkDiSYtfRQMri
	 7jhhcuhJgMJnlgV2E5/Ysf7RCYLhgev+DVK4gtQOcSCOcDQkWKW1LXhfH6AUzeyyU2RyH
	 3XZIq+mEdKlGdycESi6UwAcvko9NFJ3rCqQcGSG3mjtku8HyUxoiGZazXIE5hb5R3prVO
	 R3FW9IdD3RVV8Ut/8Y6na8Vm1smteNzZb3Vlc22VfVDg0BJjzgRgNG/VNks/2HUKaNPga
	 XXjAytBHCuLosjRfwaglSP7l2gHXvFznkTzU/TUAZmdJIUPkziBAaoxzux7TPTWytHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Uj27P7sS;
	arc=none smtp.remote-ip=91.218.175.49
Received: from mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF6606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEBF6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Uj27P7sS
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7f/HfuvjReljqnkx1PiPbyRP13u071+OBhrkb2fzJn0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794556831; v=1; x=1795161631;
 b=Uj27P7sSyQz1dIHNZPj/+ON3Ac+auHqKW0BMmEmuQVEwG185KoeIVYm/lgjuGjdWnbi5Pcbc
 CBBLOcDygtup77pvCE9Lv4LcECzdLW64L+FdO0py492cU97iRC6lnrR3jI2WmTejNiorI0wtq/Y
 +G5OjPB+O9X/GEeqDo/FUo6M=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a9fb94107abe5fe3;
	Fri, 13 Nov 2026 08:00:31 +0000
X-Mizu-Trace-ID: a9fb94107abe5fe3
X-Migadu-Flow: FLOW_OUT
From: Youling Tang <youling.tang@linux.dev>
To: youling.tang@linux.dev
Cc: Youling Tang <tangyouling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] exfat: fix iomap mapping when writeback races with truncate
Date: Fri, 13 Nov 2026 16:00:12 +0800
Message-ID: <20261113080013.2432300-2-youling.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113080013.2432300-1-youling.tang@linux.dev>
References: <20261113080013.2432300-1-youling.tang@linux.dev>
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

