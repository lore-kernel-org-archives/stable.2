Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72AD3A872A
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291537; cv=none; b=bx5wH9jLSSBtsb/TUxaJQc/2oNeWPB88STB4PonbWH+e4W45m9BFje5lj8xanCoG0kitVdvY7VlsR8pEh4RI5ztx3Bx8FJPDdN2IpwUZGKtYoASeh//rJAb6iXK7NqU3FDX6cznSgyZGJtSUFdutjhmLNMjBt09lTGDySMsbs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291537; c=relaxed/simple;
	bh=UeIrXYW/VOxDTD1TKQsKUhc6+O1yPrNl8u07x7at6IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CwUUOKUHx6CixTcTnukyh5EaO88FdOaZ/Ip1zdL+KyM2glSDpwPb+hptZI52R6MBEAGPocfR03TbcrtqsPSP2MT2X1ytq1PNZ+KlSLfsHW1cci/XAuQk4CJdLMcS2BA2eqWq3aSPQv+lUfXb8uQ20Fn8z8RTkBM7NRSF3AszCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVXj74Kz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVXj74Kz"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8422871b42dso864499b3a.3
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291534; x=1781896334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgxUDA4EtUN42F2Wh6P6RN7etfV8gAwcKvN+qwmZsAw=;
        b=RVXj74KzO2qZGtobSQcwZuoykj85mBdAG1t6MRSNnqlxOqay0QXJ8L30J3hW7cCSLT
         RLKShI86qLmd2mQK6z2RY82YWynRkWf5+dS/SgVYpJ8zk9oLxWXL43SZdVC3GMBpHNsL
         O/jXUKSuGr9OqpXe21po/KAD6bhn7eWP+cZ8mGyl+PoZFAvnF+iW4Rm3sehR2ngHp//p
         QsV1/N+KhvzgJP6svO0tQN2NWs8jswXAWqJcLn+TUYFf05Vibc/bxekFY3qRUOVSCo4l
         ozCh3N/pa1K0nOHQ3WcOmhUHFc2/wbfoDBwHd+V1i+vOw39weXc09ITzvVwqoVexjyOE
         og0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291534; x=1781896334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgxUDA4EtUN42F2Wh6P6RN7etfV8gAwcKvN+qwmZsAw=;
        b=KU7YXocKRfIqJGj2YPNug1EeQB3CINF0ZZTSMvx+yCBe2vW+G8n5sq2GvPA1bBSFbO
         y/HeWrsyD+fFBWyaPfAkpSnInwRtXXpD0iYyyaEui1wiQQvCJVjnczvs1OUl0fYox11M
         J3oritkbdIVlQrjGV3aVMxaaVfBjIppOMayJvhuc4tv9yC9nBj+fTJ3OX/dgCH9W6t6C
         3oBop4b8xMqQPLEDFrlAEwCao8UT0xKXtJxksJVYGmeMO33KuB1cRCnvzm0uxdLBqnNN
         RTXAkI0J+mAKXdrEOEXc8Ew0r0bdOy6iGKfp/IPhATRKWilRe/H4e/LVuy0KEHy7H/7M
         +ziA==
X-Forwarded-Encrypted: i=1; AFNElJ9E1rBxIaHcuKHLFQH494JJNpi+5O+VUH5IwCvBzAUEjpolJM1tYIAAx3N3cuLdQ2DtcSUZn24=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsbi+sS/bnCahdJAKG0OW9X5BHfFUtfqfQSdjyUC4tKFMtA6Oa
	dgvjwibE5nl/AKneUmm/r5QUiHccKEth9zrc9+ig54p+1yFQTpHqj2dfd1+IYyOl
X-Gm-Gg: Acq92OHo4Nl5Ob6yzjU1pkg+BAPLH3ZiT7SKSiPwbng0JjVrba8dqC7O7cWvhP2nIZ7
	fkd4ciV4aAxm+M/SJNIi/tOBq1ivfhgcDFCbAN1551LcAYiYQVHz+M2pDaKO6rUjNVuNeUJ/VDK
	Hqo0c5qzkwDzSGaazURzGNCxwxpgAQPJ5GngpAteawDB/gtrpERbqN54VVUMdB0CrHZ1gdE0jGg
	On+ytCcSeW+4kQK/AD9pqmGTDrb0svwpSS9qpRG59YErxp1cjGmzhcgOWPVMr1eEC80TvAirGeR
	bey37WqIZkRqC7n4STmxPoQ1Efsrm/6UD06gomndgImBesgpiFyVDsFHJalovRs7jOSW8M25FIB
	qOvtcDZUHWH28LOGCeXnRzoIMwF6k1qSQVMrT/Zi1W8k4pwSTBd9jSshslmxiYlp4DR72dFIYW8
	X/zhvvdf1GyI8v359saizHlWKwFB2UcC4+c3Wb+6kqdrse1uGI
X-Received: by 2002:a05:6a00:1404:b0:836:3f6a:3e77 with SMTP id d2e1a72fcca58-8434cd4b0abmr4520090b3a.17.1781291534135;
        Fri, 12 Jun 2026 12:12:14 -0700 (PDT)
Received: from localhost.localdomain ([61.185.160.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b020b53sm2952868b3a.47.2026.06.12.12.12.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 12:12:13 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: shaggy@kernel.org
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jenny Guanni Qu <qguanni@gmail.com>,
	syzbot+a98891ce2318fe7baf05@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix use-after-free in jfs_readdir on legacy non-indexed directories
Date: Sat, 13 Jun 2026 04:12:04 +0900
Message-ID: <20260612191204.95876-1-qguanni@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the legacy (non-indexed) readdir path, jfs_readdir calls dtReadNext
to advance through the directory's dtree. When dtReadNext reaches the
last leaf page, it frees the metapage via DT_PUTPAGE(mp), sets bn = -1,
and falls through to the out label, which stores the stale mp pointer
into btstack->top->mp.

Back in jfs_readdir, DT_GETSEARCH dereferences btstack.top->mp to
extract the dtpage pointer. It guards this with "if (BN)", intending to
distinguish root (bn=0) from non-root pages, but the -1 EOF sentinel
also passes this check, causing a read from the freed metapage slab
object.

The existing code already had the correct EOF check ("offset beyond
directory eof?") immediately after DT_GETSEARCH, but the dereference
inside the macro fires first. Fix this by moving the bn < 0 check
before the DT_GETSEARCH call, reading btstack.top->bn directly since
the local bn variable is not yet populated.

Also null out the stale mp pointer in dtReadNext when bn is -1, so the
btstack does not retain a dangling pointer to freed memory.

The buggy ordering predates the git history; the EOF check has followed
DT_GETSEARCH since the initial JFS merge, so there is no specific
commit to reference in a Fixes: tag.

Reported-by: syzbot+a98891ce2318fe7baf05@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a98891ce2318fe7baf05
Cc: stable@vger.kernel.org
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
Reproduced the crash on an x86_64 KASAN kernel (v7.1-rc6) using a C
reproducer that mounts a JFS image, clears JFS_DIR_INDEX in the
superblock to force the legacy non-indexed readdir path, and calls
getdents64 past the last leaf page. The faulting access resolves via
faddr2line to the DT_GETSEARCH dereference in jfs_readdir, and the free
to release_metapage in dtReadNext, matching the syzbot report. syzbot's
own published C reproducer produces an identical crash signature on the
same kernel.

With this patch applied (v7.1-rc8), the same reproducer drives the
identical code path (600 entries, repeated getdents64 calls through the
legacy jfs_readdir loop) and completes with no KASAN report.

 fs/jfs/jfs_dtree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index ac0f79fafaca..037121587571 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2874,14 +2874,14 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 			ctx->pos = DIREND;
 			return 0;
 		}
-		/* get start leaf page and index */
-		DT_GETSEARCH(ip, btstack.top, bn, mp, p, index);
-
 		/* offset beyond directory eof ? */
-		if (bn < 0) {
+		if (btstack.top->bn < 0) {
 			ctx->pos = DIREND;
 			return 0;
 		}
+
+		/* get start leaf page and index */
+		DT_GETSEARCH(ip, btstack.top, bn, mp, p, index);
 	}
 
 	dirent_buf = __get_free_page(GFP_KERNEL);
@@ -3293,7 +3293,7 @@ static int dtReadNext(struct inode *ip, loff_t * offset,
 	btsp = btstack->top;
 	btsp->bn = bn;
 	btsp->index = dtoffset->index;
-	btsp->mp = mp;
+	btsp->mp = (bn == -1) ? NULL : mp;
 
 	return 0;
 }
-- 
2.50.1 (Apple Git-155)

