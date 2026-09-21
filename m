Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF255353A8E
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964718; cv=none; b=WkbjxY0KaSNOBiFFBSgBcLJ+cR5VxdldOMsVppD7RuiE/TnCUa1mPltQzLygHdGPJ6cTgkNAqKRsP0/2o52jMWO2qqIEm8uOsfH+JGkyDuHX3bkJyFXjolyQ/TudgPBSLO3pMwwNw1wRKenhtkYA3TJ02QTXqfCVsHGGG281olY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964718; c=relaxed/simple;
	bh=lmv/kMixHGFS3QpnzkQ8nUhoay9B6977hErANqnurJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSCnq8yN0C63q2hl9pcw4YvrZg3Lxc5hSucMcudgmUdSKwprJSSqkSUDcoQZ8YzsdaIlzdMcsWmk5LJeSORJZiJ0Lws/xgY2fu4oWuiy+CG2RPNUTAOetFdR1K2xsctVMrkcoawqltWEG2R8950Zno2nlVVz9guN1l9Svh19PcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJixEFE/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJixEFE/"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398c066106cso1958828a91.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 21:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789964715; x=1790569515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s9KMY1SLRdQDkWCn6M8OfPBp9JKFqPjjGpB3XRiiwlk=;
        b=iJixEFE/zv47njZxHRCfA8yNjEP9YJhZXmYh5H94q8MfOWZLVvBLH/t6jc2Bgt6UXz
         itBfhV+lPbiSt/B3hbiGuiEUs0rEW8JB8VhVShJswuXVxx8sYHeBr15hlgOfqfiQ/a/4
         HgfaBN5JJw5efjNjWYIZtnzyiIkQ/yOT/AiNDv+d9qWcdO18PoY2XOL+cASaNbmOCIRJ
         VTrT4JqFKw0E7gOGiJE4+NqEgmfsbhiHdrmwme4ZIXlbb7kZvHoMECizFPZO0niK9fbD
         6XVN6JHZnnhB5CW6MuoY3CgXBwAJJK/7tl4H76UgfaHswmy17cUQHlfv/qCVtf+KmbOd
         0B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964715; x=1790569515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s9KMY1SLRdQDkWCn6M8OfPBp9JKFqPjjGpB3XRiiwlk=;
        b=YloeBbNFqy74EJQ9U10NBR7wbYIevpJjs9UqUPGuywNl8q0qVf5NiCguUk4SQOA61l
         N1XHyNo15xZfb71x5eiNNxe7w2Hyj1g8WplfD5Zc00ZISQUgc3X5ulv/dbuFMfHD2kNI
         rHyberIRnUSuK+PAZPOl4ki3zyOXiwRmSXGR2hE2uJt8tUB2tQ4gMRdAtHgmkHDYhqN3
         xAAlWEHtFMMR4rJIvS7SgfoI65AM8zEhcztS8e635iucD6XKLPRR1DhzS0OsRzfTkJJD
         ncbRoRqJCAw0MIakoKaB5DyNEJTLzCU+3HtNs1hdGLLKpNL5h+Yf/KxEOyMwRRH6uAaa
         aNRA==
X-Forwarded-Encrypted: i=1; AKwUvBxp7mJFLHtDveALsDV+9itD4CnFeKDxzlcd9D69xx7A6cDmwEe1xWGgf5MpbiV62MOA+N6Hz5w=@vger.kernel.org
X-Gm-Message-State: AFuF++mYEv6FOJcPWu0Fif6T9Maz/jJGxz5WKMq53r5R47oopMyP0ZaP
	mtSKH093NJDMD+bfyfHM2c9GAtA7YPptnkN8xlUwSwk70smn1mH2oWWD
X-Gm-Gg: AYBFou3ZaNEfvpBEEVP/js0aAsZJsKxo/ySDcfK+l7Wcdmzpkk6akqQt2RymWkPKS7Y
	zhLYMznY0Ijd1TO0RD9jHUqeuWnIu/7gCqRx1g3mRrWN+BO5iOOw4uBs9saQNcMoACDZ9Q/F4UO
	m7hN117I3BZKrqyptdMsdh8/1eeP1p/2dcZ1UkxHVB7qLNXPXLytoDmiEqtL15S1DNb/TRRHP84
	eCDZnLFDUG/fj0J1nqpuXr6GKqGNy9YMVoR+6fLYK3DfKcd8DfmXmCMziGnb9BPoW5mHongDV1P
	+h1WcTu1BpnJ/YpHOkpq0jykDYu8pFB56cSQLpPT3BDoZYwyPuQFq+mUJY5LoLxEfUlTHH+ZmhG
	YsfhH5Losbn8sVWlJEg+cbKChCTIg3Gqs1GHJN0UsMDqG9HC95oAxznwevLS6FvQiSsg9xWzoh6
	EWmMcLrANuiluUitu5bQ8cMcxNCs409mJCIwPHQQVnlHazUFvArUBNZ54BIo+iAhd1SH2Y+3LCM
	QImAH/m6Ps1y/k2Ax+BQBsuAp9YiEx5wdf/5HDhjBI61aODcL9zWrjDMtWU/E+VjhqzKUcyPrdw
	2kERXKnj5g==
X-Received: by 2002:a17:90a:c089:b0:39e:6c68:155a with SMTP id 98e67ed59e1d1-39e6c683333mr7499291a91.34.1789964714711;
        Sun, 20 Sep 2026 21:25:14 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c5b3932sm11742139a91.13.2026.09.20.21.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:25:14 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 4/6] qnx6: release sb_buf on mmi_fs error path in qnx6_fill_super()
Date: Mon, 21 Sep 2026 04:25:09 +0000
Message-ID: <20260921042511.1473629-4-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260921042511.1473629-1-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org>
 <20260921042511.1473629-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting with "-o mmi_fs" (QNX6_MOUNT_MMI_FS), qnx6_mmi_fill_super()
allocates the active superblock buffer_head and stores it in qs->sb_buf
(QNX6_SB(s)->sb_buf), while qnx6_fill_super()'s local bh1 and bh2 pointers
remain NULL, and jumps to mmi_success. If a subsequent validation or inode
initialization check after mmi_success fails and jumps to out, out1, out2,
or out3, the error cleanup at out only calls brelse(bh1) and brelse(bh2)
(both NULL), leaking the qs->sb_buf buffer_head reference.

Release qs->sb_buf at out when it is distinct from bh1 and bh2 (using
qs->sb_buf rather than sbi->sb_buf because sbi is not yet initialized if
mmi_success jumps to out on superblock level validation failure).

Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted QNX6 mmi_fs
image on /dev/loop0 that succeeds in qnx6_mmi_fill_super() (allocating
qs->sb_buf at block 0) and then fails root directory validation, followed
by flushing per-CPU bh_lrus and pagecache via /proc/sys/vm/drop_caches and
POSIX_FADV_DONTNEED: on the unfixed kernel block 0 remains pinned in
bd_mapping by the leaked qs->sb_buf buffer_head (sb_buf_page0_leaked = 1),
whereas on the fixed kernel qs->sb_buf is released and evicted cleanly
(sb_buf_page0_leaked = 0).

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the mmi_fs qs->sb_buf leak fix into its own patch (4/6) separate
  from the double-brelse fix (3/6), use qs->sb_buf instead of
  uninitialized sbi->sb_buf, and remove Markdown formatting from the
  commit message, as requested by Damien Le Moal.

 fs/qnx6/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index c4a35d81e67c..124b60b47c8e 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -467,6 +467,8 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
 out1:
 	iput(sbi->inodes);
 out:
+	if (qs->sb_buf && qs->sb_buf != bh1 && qs->sb_buf != bh2)
+		brelse(qs->sb_buf);
 	brelse(bh1);
 	brelse(bh2);
 outnobh:
-- 
2.49.0
