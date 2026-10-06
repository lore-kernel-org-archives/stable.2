Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4841DEE7
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290506; cv=none; b=X8T+X0s5BNBies3c7C09F287PBsMpQ9/MlVQGBwX/4Mil//S/6G3pSawfVerOrq84z/8VGMZkc3gYtWBrMnAL29uaDsvcwX03UIoFHjGApDCKikMVQBe+qDeDj174FH5vmqZGVTRexuCaKwfFCrKKkc+0+PtUZxJqZaEyjx4H3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290506; c=relaxed/simple;
	bh=wEI+4IdRoiUkNy0DoaQdDHjN5i4HToizYZEOsF0bWzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0twsv+8/rTiWknrEJs/FwxAtc7VWO3xHniRIOrJ/SUleBZZc8t+qjQywuiXS1sQEsQe7r4YtxF07AraGoYwkZwqGEGOxbwWWoTfPMQ6HNHmF7H8mJmKSZ55Ds/rfCU1SqgKgZ7g8fZYotsb0UQ86L0S3+/5KUNc4DKzUdKHToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSYdkStq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSYdkStq"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a4c80d3d5aso1018725a91.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791290488; x=1791895288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Vk3+2cGga50xeWMdbFK+urEdPBF53lIfPHsg3pEZLA=;
        b=eSYdkStqB0q+7mlmVE9cQZU6cyViqmnK+wCu1c2nx/MGUTRhjhW1F0l2cTy1tNbLTB
         1NS00wUpIpBbumt7xCFMjrilYc3SSJTO6p3Vwn1elJIz8LNabQ9B6+VtdBCNH4p8IvQD
         kQuU7oMjKbBwjrT3y2BtybZ+5hSa+I0QOt2eT/mIHZYCVLt+CLlkyoIhU2REjPa0+IqA
         nAWfxtkDvHPeTlchtUxy6tC2JPuPqROH6iVXImxEb6Hqv+TWLyocr95Q/M4vaOJgliSH
         BJpxYOXTVfuMDlkwbVgrsMvYCsXUjIHjgJHOif4WEm/+4arV1uyqg3Q40qEdliN8e3Xq
         knVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791290488; x=1791895288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Vk3+2cGga50xeWMdbFK+urEdPBF53lIfPHsg3pEZLA=;
        b=l5yvW1QkmLxkkbz90Dza2KF3OnnR+Qa5hM1nF+MUHMDKakihUg1sXeiWY2qrZw83aW
         AhwKwkxe3+glY6pfWArOwhHOTiMlm0pasZFN1lGqPro608Dr1wtJW+oZVzCdbrn+2Aq9
         K/TSX/crtCGhQQIfvkVm217el00HGAN+fEzLMej5nzNOjix/ZGr8mXnET67oaMitcrjP
         gXCemY02WD08HYIFAwPGxbFuT5x3w9NQAmzepy96ps7cLJqAj0UyJNTwv6j/JQhRIb+i
         kXTP3rtc//ZfzDAvLjQEtLOLEoqPKr/tNadOrIHaFIUjGRywYqhvsm/hBqES/KPVBnGi
         j7dA==
X-Forwarded-Encrypted: i=1; AKwUvBwyRmZiEiz6pdO1ijRqORgB42hZqg3PTPjQJ6nYekYvNW98bJoVF1C45abUlduh1wuoudmVeJ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYItntV3FB764MPPgz9IEe3spQWJuOeAEK6R7Z59UdSlMvSFyCza
	+rGmirBqdQZ8k857HU2cHxsTzbBGQXj8qajYw+SsB8zD14fjMmClkCRF
X-Gm-Gg: AYBFou2uV6uTWqQdkXBdcc0ihVFuKlehI2XfsAOmc2MG6RLuN5oMZayzlfil928Hygp
	ncjmPz9u0z6lH06LLlJfS9CBx70Gszc7kb5jWehOuWLCwAP5GgHOetmjPxBSEc9wi4thbuDcUCq
	+U9fOPkKwluKnUIEJ1KX17XrxrqXYXFZvB0yd+eUkGlsNk0jnlF1FptOxKWinHICFnT+7yHvdrx
	vao9aZStwfWtJ1mTqLLgC4Bfpn4MYTFc3A08cF0VXrSXn0hdnDqE9tkve3y7MXwNgcldcYeyM6c
	kvMy9gt9rh0X/xJIGjA5kzyM1Ps8S60gvHnsMXk5fXxZcOvJ1Ho7tBDcd307rizfrHCZxiGi7Ib
	cz5HneJAM432L5/n/+Xgf6xaShalz85BqgoHRaTvmNSlaMk/cpesmNuC9jDO+cYmxdFXbt1fKdi
	LT0rAOrtIqrm3wEvtphy6V3spqN7FTWH6M8mL2OtX4GlwaNZyEMj0pODkk1ZnNuZBj4SHWd2L1E
	8rTVsC2rLs5HvEY
X-Received: by 2002:a17:90b:4d02:b0:39d:f247:bab with SMTP id 98e67ed59e1d1-3a87267ea23mr1122519a91.6.1791290487966;
        Tue, 06 Oct 2026 05:41:27 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([2401:4900:900c:ec20:d139:f8fd:7043:7eb2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a854257d18sm5246668a91.7.2026.10.06.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 05:41:27 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+a2748ba908c108e7e525@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] jfs: account for the dirent header and charset expansion in jfs_readdir()
Date: Tue,  6 Oct 2026 18:11:12 +0530
Message-ID: <20261006124112.1703-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

jfs_readdir() converts each on-disk name into a struct jfs_dirent in a
PAGE_SIZE buffer, and stops filling the buffer when the next entry
might not fit:

	if (((long) jfs_dirent + d->namlen + 1) >
	    ((long)dirent_buf + PAGE_SIZE)) {

That check undercounts twice.  The name is written at jfs_dirent->name,
after the 14-byte header, not at jfs_dirent.  And d->namlen counts
UCS-2 characters, while jfs_strfromUCS_le() lets the codepage's
uni2char() write up to NLS_MAX_CHARSET_SIZE bytes for each one; with
iocharset=utf8 most non-ASCII characters take two or three bytes.  So
an entry that passes the check can still be written past the end of
the buffer.  Since commit de9f4f0b2c0f ("jfs: replace __get_free_page()
with kmalloc()") the buffer comes from kmalloc-4k and KASAN reports it:

  BUG: KASAN: slab-out-of-bounds in utf32_to_utf8+0x24d/0x3d0 fs/nls/nls_base.c:111
  Write of size 1 at addr ffff888039ad7000 by task syz-executor304/5946
   utf32_to_utf8+0x24d/0x3d0 fs/nls/nls_base.c:111
   uni2char+0x35/0xa0 fs/nls/nls_utf8.c:21
   jfs_strfromUCS_le+0xd2/0x3d0 fs/jfs/jfs_unicode.c:31
   jfs_readdir+0x16fd/0x33f0 fs/jfs/jfs_dtree.c:2984
  The buggy address is located 0 bytes to the right of
   allocated 4096-byte region [ffff888039ad6000, ffff888039ad7000)

Before that commit the same write went into whatever page followed.

Check against the worst case instead: the name starts at
jfs_dirent->name and each character can take NLS_MAX_CHARSET_SIZE
bytes, or one byte when no codepage is set.  The largest entry is
then 255 * 6 + 15 bytes, so an empty buffer still always takes at
least one entry and readdir keeps making progress.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+a2748ba908c108e7e525@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
Built with W=1 only; not runtime-tested.

 fs/jfs/jfs_dtree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 8ce6e4458cc2..d930e577a496 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2712,6 +2712,8 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *ip = file_inode(file);
 	struct nls_table *codepage = JFS_SBI(ip->i_sb)->nls_tab;
+	/* most bytes one on-disk character can turn into in jfs_dirent */
+	int max_charlen = codepage ? NLS_MAX_CHARSET_SIZE : 1;
 	int rc = 0;
 	loff_t dtpos;	/* legacy OS/2 style position */
 	struct dtoffset {
@@ -2910,9 +2912,10 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 
 			d = (struct ldtentry *) & p->slot[stbl[i]];
 
-			if (((long) jfs_dirent + d->namlen + 1) >
+			if (((long)jfs_dirent->name +
+			     d->namlen * max_charlen + 1) >
 			    ((long)dirent_buf + PAGE_SIZE)) {
-				/* DBCS codepages could overrun dirent_buf */
+				/* the converted name might not fit */
 				index = i;
 				overflow = 1;
 				break;
-- 
2.55.0.windows.5

