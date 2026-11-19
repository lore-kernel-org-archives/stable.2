Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795131682;
	b=mSspxfoew4HT8LbVxpwjbmOsude7rQMN9n/D7W1C4yxMhD5fYLmm4wllm507fn4t0xD4
	 Oznj0lTB3qaxsbLDoBIQvV4K4a8hI3h0xDUbX2ip9Z+GTTYcGaUWbhqS1I5VUfMYTWlgN
	 FqZthyV3TT8Y5dHJTeFs+6RQk8cMF6K+Wl5j/U9cYX2Nme14CgrIjBsXvecrz93mVZRla
	 aU45F/hZgnHDJxxrYPGv6478XXz9949xVsM6reronIfdwn2aBqw8HLaS/46juENpA1o4b
	 +SMbsgjpsh8jo/TloRJQaOzQaG3B6DSJrM7VRqhJa6ecu9Nq8JXxx3YfrxDyPqA8ToA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795131682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nKWdvn5g3LWqbr6kSTOS4+Q+mYE0fgsqV+kyH0HAgJc=;
	b=tZDjghCkuXAn/g7Qr+IkX1AFAI8GMS6HRYaeuASZNcRtNAlNgLvO8EeCtAsMqsotfVSk
	 kzEM3riDmw/Kpq3W4VhTLZxSrrl8BAIRrfcSwrxfwVh1FlP3x+cKBwTkxrTJd4BHtjfPE
	 2whj+PZMpmBhnaZQXIEkz3yZ3JNKIbE9eZvPZI8y7x6P/x++Cu0+N2lq4d9GRRmRYk03+
	 h50imDaNBR8oDN/pvg0gtrmYfh8BNpDwAPXqfBWW1e3sFX7crrj0/dBpHM+lwxModFQ3+
	 +9NZL56PC93GeWigqLorQi7tbwtDN16UnRXSQ5XO1xvdnEFnJsHOMH0PTK5V7PgSKrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uavAA8Gu;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C660A2638
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 620C660A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uavAA8Gu
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67da69e7c31so414141d50.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795131681; x=1795736481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKWdvn5g3LWqbr6kSTOS4+Q+mYE0fgsqV+kyH0HAgJc=;
        b=uavAA8Guf8WpnuTNpWimlPENJzUf8jbi7z9vm+4+bM3r6bbHArdER6HHyjbhAroXL9
         tX1WDOkGFYXp/Z8PZbeNdlWudF/fgIs6dmff5+n8b55qWrsGD0lXa5aNLl1svV+NQSik
         BInwZLE8LD5tLiSiqOjLoRe73LDHVO8WtEP2iZ5IEuzF0pnoIcjBi7nBgmlgFW1uvgEL
         dNeqagXulZh2q8aM4G6lvtAj50AfM4xSaQD2ti4kX3T23AiGMymqbTuPwp+G1acY/ZcK
         rBP2PmLWd8jaYjY/2GLCYVawno+kEBBao6Uesp3u3pcN9WPYQtrAfALrEojDy6Vu/DB0
         suoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795131681; x=1795736481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKWdvn5g3LWqbr6kSTOS4+Q+mYE0fgsqV+kyH0HAgJc=;
        b=jVhqBlQrK9sXgqKgQ/7HdtNejZSFHX5q1rttE5gIncg3N7tZ/6PWMH8zHbcn84X6jx
         t/yCeb+SED5wZKeUkl0YTOE7EqtYHTbBEwHo43TyRqW4SIc1m/QPwycYVHmm2ZbX6shb
         mk2J8Lv1PXFpbHuuk7QfErLPIOAwgF/Q3BRuq0RV0SXD/TPhXNyqQuCi5Qlf+0CzFQDl
         k0WBTmLDzoFtw1UIfJrxGiz5uYR2xACVPVcGp7dvJnV1KA5vsRbCHsN26eJG/nRxHUL3
         Ie0i4ZrK/O8jlkMfCTJxHukHKmI1JxuCnUGM0GAOUk8rX0lAJ0G5seLhF3bMhyPIBC0Z
         guCw==
X-Forwarded-Encrypted: i=1; AL+hErEUvl9YWczI57RuYDNKqSPKBzfACNlc+YE/svGwZu1XqkLrGQM59Hzs0FCtjEMaHJqFGD5pOjY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lCpfpl1QHPshoaRBES0d3tw2KBqxYwiX0ew5MDKUEe68MCFXw
	v3AQIh36rkcduNGnkZsJ/2du+MD12GaCNkRjD4veSWrVxx3xJTGuZr767Yv3FSRFHqw=
X-Gm-Gg: AZFdTZefeSKzT9c4sQj2zUImL6FYMl3Bk6MzAkz7A3Gb2KC9hBcBk6Yb3gkMytcxZ/+
	plgTtlzTCNsHinlo+2dc7m7JS73ws6oiZyBYVeULRCs9W3h7WuAXiqZ4DO/VQi7LOrmHOnDpAZG
	SB42+3YRNJ/Ratr610cqG1zauS5/F5Ckj20W6RDr2m+4pJg50KdWG17YxwxUOVbKJ1msjdxjXpM
	lS2+6lJF6iyZnnSRZa7IsyTYmtSFDoGJsRiRXsL7oIaMEA91Vhfhw+BBFDcchfmcDVetzrJEvsO
	vVQ6Argd8871KMGj/wA2YNTcYngNRe8DA5opJU/XlPx80KikBMFlJ0/Za8kTDBN2So/ONmbHYPu
	TMEbJ448v8INnZ5xOXUPi0E3fOF2/BvaPe3AjCYLjuih8vSfK1HUfaDKUtuY0v5cLdFOIVDC2AH
	pIJm/ECc49ZXPhdL38p+qrUbgKa0Ib8rI6/MtEb4J+IZmwMdmD9qvw3MV3JIrHkAuKMUox6zHgW
	7j3tilw9Lj1l4ntnYixdwJ7CgL/261Ln4qX2OFNxpU3tm7tTki6GiNhnd1iWUCtNDQ1trP1qE6K
	sHUIUnOuInfwj0w7TOpl5ZfTpv5KUOBa6XTsFcPhvnvulANGUc7zzfXuz5nnS6enKfGnHe8Bxh2
	bYXoRya5b4g2izhnqjZjoxMUTCpKyVxYM203PjuGIgEKLEXRpTktUsgcV6S1U+Y/3IaauDkM=
X-Received: by 2002:a05:690e:419c:b0:679:f97f:fdf6 with SMTP id 956f58d0204a3-67df448c769mr466727d50.66.1795131681346;
        Thu, 19 Nov 2026 15:41:21 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df338e8fesm796893d50.16.2026.11.19.15.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 15:41:20 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/5] hfsplus: reject an allocation bitmap that does not cover the volume
Date: Thu, 19 Nov 2026 15:41:11 -0800
Message-ID: <20261119234112.720963-5-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119234112.720963-1-slava@dubeyko.com>
References: <20261119234112.720963-1-slava@dubeyko.com>
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

The allocation file is a bitmap with one bit per allocation block, so
it has to be at least DIV_ROUND_UP(total_blocks, 8) bytes long. This is
not checked at mount. hfsplus_block_allocate() and hfsplus_block_free()
look up any block below total_blocks in the bitmap, so with a shorter
allocation file they read and modify bitmap bits beyond its end, which
are never written back.

The only guard is in hfsplus_file_extend(), which fails with -ENOSPC
("extend alloc file!") once the blocks in use approach the bitmap size,
and hfsplus_block_free() has none. On a 64M volume created with
"mkfs.hfsplus -b 4096" whose allocation file size in the volume header
was changed from 4096 to 1024 bytes (fsck.hfsplus reports the volume as
OK), writing two 24M files fails with -ENOSPC at half of the volume,
and after unmount fsck.hfsplus reports:

  Volume bitmap needs minor repair for under-allocation

Fail the mount if the allocation file is too small for the volume.

Tested on a KASAN and lockdep kernel: the volume above is rejected at
mount with "allocation file size 1024 is too small for 16384 blocks",
the same volume with an allocation file of 2048 bytes (the minimum) or
4096 bytes mounts.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/super.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index d23594d12064..6e4068e53b4f 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -777,6 +777,19 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sbi->alloc_file.inode = inode;
 
+	/*
+	 * The allocation bitmap has one bit per allocation block. The
+	 * bitmap code looks up any block below total_blocks in it, so it
+	 * must cover all of them.
+	 */
+	if (inode->i_size < DIV_ROUND_UP((u64)sbi->total_blocks,
+					 BITS_PER_BYTE)) {
+		pr_err("allocation file size %lld is too small for %u blocks\n",
+		       inode->i_size, sbi->total_blocks);
+		err = -EIO;
+		goto out_put_alloc_file;
+	}
+
 	err = hfsplus_ext_load_alloc_file(sb);
 	if (err)
 		goto out_put_alloc_file;
-- 
2.53.0

