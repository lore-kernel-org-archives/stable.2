Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494188;
	b=rhKpfFLyj3AtDFWhd1d06VR4igAn+5my7BqKqEic4b4qyoTR9Oj+TWBcy6dwjbUST8OE
	 siMUz/piqQikx/eJ0CBDFrgu4a5Evua7Ub3h/2//0jqoXwlXhiUQEkT6sVlYELcCfDnn6
	 lpYLA6fvs5wtZUklXlQG7ZQGjmONMB4kLkss1uKh6BxbqzypmUG1AZAIsdDd3f5PyNYUs
	 jnAX9slBFs/geD9JaDhEmygknvPgU8/Hc5nn5TZAvxUMedBIp9g1AB+ti9RK1QpfdiSvp
	 pqZaeBy5J7vD6cSLcU0UPaMnMMDVFyIJWZGIMMmESIfMkE1W+4DPPRHK1/OFZW78wtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494188;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=iuzgYOetjEwmWta8zi0uoBa/jwtVmeRA9xZ/AyBm8jo=;
	b=kG4xt+xv6v0+LzAI5XaaNvvyZDCgt3TQpoZ5xEbJDPZuymq7BSBD3Vvu42lEORIkS48E
	 l9j9gh/88P4YrYUWcEda+uPff4C/Lcgx3GQT+8XS1Sb4Q0JTbREN+OrveLURkJ8vYB5jV
	 /cRtsl6KU/jEFIgQAV9YQMAGwsklkU3xRt/GBpCBt3xl7YPahDrEVsL28/0wonzSr39Vn
	 wtRzQTvoz8p86o2GH6TZYLws/EqVTSsrFFDF8mVcpuVNe+vCMqEMT/d920DKlVer1Bf3E
	 +dS1XBFYEbJUcIkdwoOnahNtE4BN3f+Ku9ho9V2KYX1pdcOiQL8qeksYeVt4KfiY1ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=G6JlhGgc;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8D606A896;
	Thu, 12 Nov 2026 14:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0A8D606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=G6JlhGgc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1794494184;
	bh=asyjPwOhKptYqzqqVtJaS27mflvDHUXnhBb4i7GC64A=;
	h=From:To:Cc:Subject:Date:From;
	b=G6JlhGgcdMSw0tQ9S0fq1SAhDXC3WT3Y7003Xj7xGK8uOkhaFNzz7FOaGwmxz0AVN
	 3pc7KPph0qeXPVwLNEpMDlIZQJb+L1KQ2FxfreEUEYKNVKAlEB/DR+pcs8H6+fue4H
	 DFG5S2bA1S3xNHtuvZXo44DHArpUDv0DyN+IqH22MycRR8+KJucoNRO7vnZyvW4WkU
	 XR2DLfIehb0WeNHQQRRO3uOxTUE5XJWiGHWwERiGZFgqJP8wFeKOjlvRz8cbvF1fSj
	 ln98dKuWN6q2fafvpAVvBU9W0K7PLWuEMGWDQCXbLRm5JhYQcB7UQ+93n4dzFQ+diU
	 UOkuYyVfsBfzw==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 2E7B2255D3;
	Thu, 12 Nov 2026 17:36:24 +0300 (MSK)
Received: from mail.astralinux.ru (unknown [10.205.207.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Thu, 12 Nov 2026 17:36:23 +0300 (MSK)
Received: from DESKTOP-D46TNHI (rbta-msk-lt-981255.astralinux.ru [10.198.28.246])
	by mail.astralinux.ru (Postfix) with ESMTPA id 4jQNHV64J7zWBb;
	Thu, 12 Nov 2026 17:36:22 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: Jan Kara <jack@suse.cz>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	linux-fsdevel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] isofs: limit empty zisofs blocks to their uncompressed size
Date: Thu, 12 Nov 2026 17:35:40 +0300
Message-ID: <20261112143541.269-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/12 14:03:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 134 0.3.134 ce9cca31102af372fedb0df49d70b90f771aea0b, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, sashiko.dev:7.1.1;mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207443 [Nov 12 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/12 14:02:00 #28858911
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/12 14:03:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

When a zisofs block is smaller than a page, the empty-block path in
zisofs_uncompress_block() zeroes the rest of the page and returns that
length. zisofs_fill_pages() then advances past the page without reading
the remaining blocks, returning zeros instead of their contents.

For example, with 64 KiB pages and 32 KiB zisofs blocks, an empty first
block should zero only the first half of the page. Instead, it zeroes
the entire page and returns 64 KiB, so the second block is never read.

Commit 68d4d3e78150 ("isofs: fix out-of-bounds page array access on empty
zisofs block") accounted for poffset but left this older problem in
place. It was pointed out by Sashiko while reviewing a 5.10 backport.

Limit the zeroed range and returned length to one uncompressed block
and the available output space. Only mark a folio uptodate when the
range reaches its end. zisofs_fill_pages() already zeroes the tail and
marks the partially filled folio uptodate at EOF.

Fixes: 59bc055211b8 ("zisofs: Implement reading of compressed files when PAGE_CACHE_SIZE > compress block size")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20261105083209.922-1-mdmitrichenko%40astralinux.ru
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
 fs/isofs/compress.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 2d23abaeb874..c471007a76ed 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -64,16 +64,24 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 	}
 	/* Empty block? */
 	if (block_size == 0) {
-		for ( i = 0 ; i < pcount ; i++ ) {
+		unsigned int bytes = min_t(loff_t, 1U << zisofs_block_shift,
+					  (((loff_t)pcount) << PAGE_SHIFT) - poffset);
+		unsigned int remaining = bytes;
+
+		for (i = 0; i < pcount; i++) {
 			unsigned int off = i ? 0 : poffset;
+			unsigned int len = min_t(unsigned int, remaining,
+						 PAGE_SIZE - off);
 			struct folio *folio = folios[i];
 
+			remaining -= len;
 			if (!folio)
 				continue;
-			folio_zero_range(folio, off, folio_size(folio) - off);
-			folio_mark_uptodate(folio);
+			folio_zero_range(folio, off, len);
+			if (off + len == folio_size(folio))
+				folio_mark_uptodate(folio);
 		}
-		return (((loff_t)pcount) << PAGE_SHIFT) - poffset;
+		return bytes;
 	}
 
 	/* Because zlib is not thread-safe, do all the I/O at the top. */
-- 
2.43.0

