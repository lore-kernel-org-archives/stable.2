Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.188.205.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867558;
	b=w3G1QZmh6qqHZH5P96s35bOc7am0UR9c9e9Xigmn/1TBCFe6rpJcecY0xN+9MiN/6hmx
	 bwfHLAy+l+Ff7QqpsbBdSVicWzNFWxOu7qAJdoM8Bvpgzb39VhWTEthmidpj3Jwia9ZYp
	 WvOB7QZEMiPcztdqMwiSacvk7Q/2/IPzjfBbqLrFRT2UIpto3rrSVzREr9favED8DFv8K
	 gij9gb03UG0/sydk+PT8an7wjhpnAzz5IJE5eERdtJnRmcMNMpClOBCY2ndTR7GrsYhVB
	 UKvjVC7cmnvdw+vmy5VgDPBwBIjEuYxd9jjpmLwcOL6XRHa3Zqh2Eqe/pQZTrM6jBTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867558;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=XCxQCrS2YkcMEarnP11f4FMhAihrrdPWjwdE8lp4A1g=;
	b=lLLYxacmMn63F5VtrcfpdIEBX2p0V3JhcVl+a2Hgrv3E5bgCgQA29Ccf1ZkA08l/ReCA
	 ZnP1FXbupBszFJpsoYbci2htzVpDKBWd+YbYcATq/JdGl9sCAU6iiZf+XjTD/vTEv3+Jd
	 QbwVaQRa9phde3r5SkV3g8pMa64vTD+9wPaLmr/2VOlP8k4iXa+p6Yb942DHY89PGW+Z1
	 pTLSw1j8ynVmYeliJaeBbMq2fysDqg7wmOxczWn3bnaTTYowiWaYC+2fFSH9xFaUKelyd
	 ljng32xjGqYnXOdTWY8cG0xX8DCFERoeI+05hWos+q1xJprW0ka9eiT0zMS29NceATw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=NFAfqwJE;
	arc=none smtp.remote-ip=93.188.205.243
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424E606A326;
	Thu,  5 Nov 2026 08:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9424E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=NFAfqwJE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793867544;
	bh=OYUweBZA65VpgamjYb8wE+YAw63z9eeO80M25j90k5E=;
	h=From:To:Cc:Subject:Date:From;
	b=NFAfqwJElyibEyf6bAaM2DCAqcaqlbP/IsM9rU/pZHA6bCUZIBnDdewOnJG666I5i
	 owT5H3TdCv8FsyH7M4LxZOw7oJInuF9G30jbomJFMWoPujEKlSGi2j4LuQn6nMRUXT
	 mWfL8Ie0yKJS023q+NsUOU6eA/UnYXkyCvHFaj2UhugFRc44dRX4cTH30iNBn5gmOb
	 hK0B/PbO+Kv4Femjgdr2WXkPNaG7WR4+NzIjWnmZJIz9zo5djUEimO3la4CswOiEwB
	 24KuenmiXPBt8WuRNKhcE60G0bFW/GOnyWilKKHnNmmhp69IeeBPYBAhMhXO55A1He
	 PR0Ld83WhlA1A==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id E839C1FA18;
	Thu,  5 Nov 2026 11:32:24 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu,  5 Nov 2026 11:32:23 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.31.238])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jKwXl1zt9z3FLD;
	Thu, 05 Nov 2026 11:32:23 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Xiang Mei <xmei5@asu.edu>,
	Jan Kara <jack@suse.cz>,
	Weiming Shi <bestswngs@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] isofs: fix out-of-bounds page array access on empty zisofs block
Date: Thu,  5 Nov 2026 11:32:08 +0300
Message-ID: <20261105083209.922-1-mdmitrichenko@astralinux.ru>
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/05 08:08:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1;patch.msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207247 [Nov 05 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/05 07:56:00 #28800192
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/05 08:08:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Xiang Mei <xmei5@asu.edu>

commit 68d4d3e78150c7ed7d1195af63ad1e6ace30c661 upstream.

zisofs_uncompress_block()'s empty-block fast path returns
pcount << PAGE_SHIFT, ignoring the incoming poffset, unlike the
decompression path which returns bytes produced relative to poffset.
zisofs_fill_pages() uses that return to advance its page cursor, so when
the zisofs block size is below PAGE_SIZE and a sub-page block leaves
poffset partway into a page, a following empty block over-counts and
advances pages[] one element past its end, after which
"if (poffset && *pages)" reads pages[1] out of bounds.  rock.c only
rejects a block-size shift > 17, so a crafted "ZF" Rock Ridge record can
set it below PAGE_SHIFT; the bug is reached by an ordinary read() of a
compressed file on such a mounted ISO9660 image.

Return the byte count relative to poffset and zero only
[poffset, PAGE_SIZE) of the first page, matching the decompression path.
The page-aligned case (poffset == 0) is unaffected.

  BUG: KASAN: slab-out-of-bounds in zisofs_read_folio (fs/isofs/compress.c:290)
  Read of size 8 at addr ffff88800f5eac48 by task exploit/142
   zisofs_read_folio (fs/isofs/compress.c:290)
   read_pages (mm/readahead.c:184)
   ...
   filemap_read (mm/filemap.c:2814)
   vfs_read (fs/read_write.c:574)
   __x64_sys_pread64 (fs/read_write.c:769)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  The buggy address is located 0 bytes to the right of the
  allocated 8-byte region in the kmalloc-8 cache

Fixes: 59bc055211b8 ("zisofs: Implement reading of compressed files when PAGE_CACHE_SIZE > compress block size")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Link: https://patch.msgid.link/20260712234150.3213467-1-xmei5@asu.edu
Signed-off-by: Jan Kara <jack@suse.cz>
[mdmitrichenko: Keep the existing memset()/flush_dcache_page()
 sequence and limit memset() to the remainder of the first page.]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-89778.

 fs/isofs/compress.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 710368536cdf..67217439b4c0 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -65,13 +65,16 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 	/* Empty block? */
 	if (block_size == 0) {
 		for ( i = 0 ; i < pcount ; i++ ) {
+			unsigned int off = i ? 0 : poffset;
+
 			if (!pages[i])
 				continue;
-			memset(page_address(pages[i]), 0, PAGE_SIZE);
+			memset(page_address(pages[i]) + off, 0,
+			       PAGE_SIZE - off);
 			flush_dcache_page(pages[i]);
 			SetPageUptodate(pages[i]);
 		}
-		return ((loff_t)pcount) << PAGE_SHIFT;
+		return (((loff_t)pcount) << PAGE_SHIFT) - poffset;
 	}
 
 	/* Because zlib is not thread-safe, do all the I/O at the top. */
-- 
2.43.0

