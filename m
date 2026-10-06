Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029535AC0E
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283913; cv=none; b=B+6NvGzuFPUX0UIOfSXDiGQVG7T3eNebzpKdMacyfJVh+6ZxfocEcF6wN3j413tSLzSRRN6BSolxdl/rjTPJ8D0qp02HVsw9SJZ6vLRtXaCDffUADthT4s1qeusCjew41NmrS/F3ZSO1OsW9BboIhzLeETWp4PCxauXkPFdpxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283913; c=relaxed/simple;
	bh=LuyziXPlCFJ01VbiESW95qg1GoVoMAU4nqajgXgVaO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dh+rfpfTeoM8dmu9T68DF+hit4prvjz4PVWf5GAK778A26eGUU4iCm/6CaY77ghPYr6loh++8gVRbEg+t/LahfKiEcvuL80yhVBFsLwD3dWpmrG8jdzBs6S8it3PhudaNmZ4xcwRkYCNj2uxEXkdiZL/+29X0QuamjDmaKJfLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPawkpun; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPawkpun"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8258ac98bc2so2101554a34.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791283911; x=1791888711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SCTv/ndgRDuXwjW+M6LtHiJwH/r3XSV8PS/58Df+I+8=;
        b=JPawkpunnzbRh6m1kj/e6KnD+jYi2WWbsyO7PhKJLLeu2g00oGuol1gl/KYmRTWXyN
         NWmdaKrgPMH73uA3ri4Nv05XrCi6hNAV509CMzioZ3qu3j81b+pRuYs1a51yS0JvdQaw
         9wSkjicQctmWT0HO/kcD6k8mKx7QlpS6h4qDR9XAZ/V3Z47B3WR0Gj1B92pwV3VgAjq+
         gd1omDJv2jHBBCS/haqFDrnjk7pGHq0Ln1oT+xRGImbdTiyWN7yu7ALoU2hl9FcN6JcB
         Fc12GB2VBpp71WoQVqLuz3aWQNyRurLmt61dweeTSpL8rheOTzZbP85i2oiEtVhMJZlw
         naFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791283911; x=1791888711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SCTv/ndgRDuXwjW+M6LtHiJwH/r3XSV8PS/58Df+I+8=;
        b=k87ho++GB9881uxodePhoy0nGveZnZrkH9hMEcHHMYYLLMyNcZ/7accvw3l353SQEm
         JasH/5CHEzoJh7pPCuOI7Wc9FViC10x3BH3sGBCU0MX6SGiA3NExOfNjTqwDgbapO45p
         KTlL5yk7RzCETHrHhvvKQS2Z1f54zdxm/ev6T6Bs5BszleRdoZ/33F5SvSh7jszcw725
         8QyLi9opHob/m8GCG+ATNEvwEICzjblqC2kbrK0l1tIL6FoqBx/l1hxHOuJiQ2eYLwNG
         Iih2n8QLPF+Xl/3/IIMDUB7Bmb9cIdxiHebsWc2FGJjskadE9DaoPtZweVa5KAgbS/eE
         2oig==
X-Forwarded-Encrypted: i=1; AKwUvBwuhEXTK4aWHlbhBAekJp4xMFpyASU0csGASppSSFwfrO+cG3ne7yf0897vvCy005Kk/uHpR3c=@vger.kernel.org
X-Gm-Message-State: AFuF++mx7u+f6WEuHJyQYHsLcNEuGZk6CC/c8typ3HN2uft8Jzc78Hfi
	T3rbvY6hVjJocuMMyE+n+qepQtOVT0mKCQoLFmP5QPo6OgMbnzjEvfF1
X-Gm-Gg: AYBFou1KV8vX2DrqreaOT7iwL2Cn/Z9JiMiS16XuszGUtJoHKb8ypG5sIZkCKqwHMpr
	TgS/T6oGpIbHLrEgqfdeDcuQAQgeF3ETUp1xQ26samihQl/ngnQ1Lhmdu/zhHu6NFbyS08KqDY7
	BFWeHA2r0CF8aC9q4osSWb7Ee7Ct7IsMKhDQqgc7YHwqbCMD+jU0wtk5ibBBHPvY8Vy8P81WaXC
	7O9n/XKGS/phYoZ4m4Dx5p2AQHARM8rAp/HRuKvBPwO87vVlscR0zNb1ZZto1uaJFLxI62lG9Ey
	nLOPkeGV8F7p5isz0IwS0D8bEo8BpZkJc/7G14HkIWaYfA21zAvQMehi+MS4o7t3mLmWzctwrsi
	GGF8cybykZh1dl+va7Zr/I+oiczoipbwXFwzwJJhNAyJtXGQxMCqPIh88mn94kXapQ6SbaYCEgk
	klJMgPogPHPwgETmPL/3vEVZfdowNsjEoBSU3IWxrTa/XgSeeNQm3aXM3xI5joXo85k7H2OGPQj
	Dx/B14u59O/yu7AZL8Il+KzFWNakoMhjDOpgGg0Rmf3RzNeD4k=
X-Received: by 2002:a05:6830:6a14:b0:7f6:bca0:3a7d with SMTP id 46e09a7af769-823fc4405b6mr12174646a34.9.1791283910545;
        Tue, 06 Oct 2026 03:51:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8281fcce238sm2157269a34.6.2026.10.06.03.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:51:49 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v1] fuse: don't launder folios of a bad inode
Date: Tue,  6 Oct 2026 03:51:36 -0700
Message-ID: <20261006105136.3751196-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_flush() and fuse_writepages() reject writing back dirty data for
any inode that has been marked bad, but fuse_launder_folio() doesn't.

This can cause the following warning in fuse_write_file_get() to
trigger, as reported by syzbot:

WARNING: fs/fuse/file.c:2043 at fuse_write_file_get fs/fuse/file.c:2043 [inline]
WARNING: fs/fuse/file.c:2043 at fuse_iomap_writeback_range+0x7c8/0x18f0 fs/fuse/file.c:2227
Call Trace:
    iomap_writeback_folio+0x1526/0x2490 fs/iomap/buffered-io.c:2022
    fuse_launder_folio+0x17b/0x240 fs/fuse/file.c:2331
    folio_unmap_invalidate+0x4cd/0x830 mm/truncate.c:634
    invalidate_inode_pages2_range+0x629/0xb30 mm/truncate.c:726
    fuse_open+0x5a6/0x770 fs/fuse/file.c:297

This can be hit on a writeback cache mount:
1) a writeable file is open and a buffered write dirties some pages
2) another thread opens the same file read-only. fuse_open() passes the
   bad inode check and sends OPEN to the server.
3) a SETATTR reply with the wrong file type marks the inode bad
4) the writeable file is closed. Flush and release skip writeback
   because the inode is bad. The pages stay dirty but the file gets
   removed from write_files.
5) server replies to the OPEN. The reply has no FOPEN_KEEP_CACHE, so
   fuse_open() calls invalidate_inode_pages2().
6) the invalidation finds the dirty pages and calls
   fuse_launder_folio(), which finds no wriable file and hits the
   WARN_ON in fuse_write_file_get().

Instead of trying to write back dirty data for the bad inode,
fuse_launder_folio() should return -EIO.

Fixes: 5d069dbe8aaf ("fuse: fix bad inode")
Reported-by: syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e8200299b0556976e13c
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6d707f2b3bff..0ef46f6e0267 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2351,6 +2351,9 @@ static int fuse_launder_folio(struct folio *folio)
 		.wb_ctx	= &data,
 	};
 
+	if (fuse_is_bad(wpc.inode))
+		return -EIO;
+
 	if (folio_clear_dirty_for_io(folio)) {
 		err = iomap_writeback_folio(&wpc, folio);
 		err = fuse_iomap_writeback_submit(&wpc, err);
-- 
2.52.0

