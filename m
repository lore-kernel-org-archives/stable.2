Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88BF4ADD88
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714230; cv=none; b=Tzv0DP/On0fJdEiJJTP9NKyfouEbfVeWFMeXEo4QpePLYaVe6J9aQcOaJ0EFa1Ok0foSBDRj34e11fPtPDIi4re/NmSYXTnRsrRYvo2cjGiY1GhYSAsODKRdytwE/ifTwgEQvjx3f1eeuNuicpEal60ok7hnXI2sdolfcuOl2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714230; c=relaxed/simple;
	bh=3pH63PZrNIrrK9dHFELvurvMG28vzwC0HG3QJj/W1Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xz35XZaMgOWM1r8HXPgr8ePbE8BT/PMJLQmvN+xveg8R0R4q3mqKJ8PiLMTq4a94fWGWm2p6qxXkBB6IteWQRquzQMB62/KQHb9FGSHtYcnewK/ZskyW2tXROV6pKpi4lY4uBtiQyg4ZBOwEckg265aLXAI4G5PNUs05zRE9ZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN0Xl8JT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN0Xl8JT"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so9973387a91.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784714226; x=1785319026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qlo6v/j1mktOqnKmy44ulbYNPMM7z5pnpSzY1f8OpC4=;
        b=lN0Xl8JTQnIZs26ANuUHuQR2zaqnqrM3lq6CItENpC9dBlq8Lx/ZEx6HWGC3EWh2je
         KZ9skkRtFPt9FxRQ9Uj85cB1VvLkFUnsDyqz8bCCOwrjJk6+3M3Tr2iUrxKxZd85kRtV
         uZW4GwhGRYRBsYckndlj1i/oIckJ1Bc7P4x+6TLSf1BDKafDMPMXeQBtpu0v4H4+0OxL
         Amlkvb+ZOfif6c5VUZnKnRpXnfmqhDUp5aQm9vpo/ruAeKJUpnosHWrCSQ1yjxZcMR7N
         61mr2AB+ehChT1I4zlM7QA3s4p1GPtslR0a+sktqQSitNbq567HnuD0Sy9SrzaG8Fvll
         cOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784714226; x=1785319026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qlo6v/j1mktOqnKmy44ulbYNPMM7z5pnpSzY1f8OpC4=;
        b=rGHPSdTA8gAhPpZgs7ydiv7z6wI9Csls5f37bpFCPJBP5qS4zPcvRdQJTcG1bh4DSF
         1tOPkgo8Gr6+/r+6wpkGWDiPobq78aLrHx0umly6YaLiAbyECpxesdjWdTJLxZ2rljK+
         Xq59s7Q2SbkCQplZe6MrugZtjSm3hFmpo7pBIQLobTKToAf2sJyc9Wm3XHafcfA0alyj
         c+MOdcFkM36oxoKG+p4TM796v0eOAqFwT+rDilfkIrFxYJuY7tZBzoeEr9yokzHTS8Xh
         DjRugOP+XCDRLlZQ8vlds1HnUtDvFREze9HdqY1FwAc/W92U+4vGcolw8T8kZ79cusTa
         5Bwg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2pgkjQUM4kknPUXzvwCp/jILedwZXnQ9LlZ6NReuk+wLS9AOZczcUkdke59WrHAipleKdAVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0MuP7WgWigToUAhBSyKRIQANKl9r2KXnyUwpivCU3oJe4DSPS
	yJVf0WIUU9qHxbF8UjfmXD0e81WqYTNMtU2S5XM3T68Xwc9ob9+wZKsF
X-Gm-Gg: AR+sD118I48JkLCPGl/v4VGY8+YwtHwyClh9OnEAOXTwSnob4I1mYbHwfmAFslv0ZZT
	IwR27CogHgloNoo91vGKChnUfoGd25ViUxCmJJi7pkbzSvqQJfr0+EBWkFubPEp1aJNH646/qEo
	h6oPPsEfhp9sNjvlSv4adeDt0w0kPZQfqRbgV1SzfYTLZAfSN/eAbpJ+iS0MueiRda1+zpak3z6
	6xKyc7EMwk1Ww/Qj9ncN3CKJ2SgELnEprgjKkIRLXsvbOJIOxROJhdW33fnEUI5tjoAsPwbxxkO
	LDaYdmjEPXDa4XJqXJd4brOhzbBFh4JGq0tsIDvqSMxs/x64Xj8s4Zvn6dGjSwBaEAUEIr3cVIc
	pZwYUhJrZMEaiAU5u68zWUM9rGgRz6Cw340qxxmjElH40wKqwAFmdarE8FQGsMPMWhA/dA9THrn
	5ANnS/AHvODwtBxWaYzWsQAHI56lbhtlsP/AGeeBUZFBEEZKSpN9O8
X-Received: by 2002:a17:90b:2890:b0:36d:7b62:4767 with SMTP id 98e67ed59e1d1-38e4b434f04mr22899707a91.5.1784714226352;
        Wed, 22 Jul 2026 02:57:06 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38eab3dbcacsm572378a91.3.2026.07.22.02.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:57:05 -0700 (PDT)
From: Sangho Lee <kudo3228@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Sangho Lee <kudo3228@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] romfs: reject directory entry cycles
Date: Wed, 22 Jul 2026 18:57:02 +0900
Message-ID: <20260722095702.1382671-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A ROMFS directory stores the first entry offset in ri.spec and links its
entries through the next field in each on-disk file header.  Both
romfs_lookup() and romfs_readdir() follow this image-controlled chain
without checking for cycles.

A crafted image can point an entry back to itself or to an earlier entry.
Looking up a missing name then loops forever in romfs_lookup(), consuming a
CPU in kernel context.  This is independent of hard-link cycle handling:
directory next pointers and hard-link spec pointers are separate chains.

Validate each directory entry chain when the directory inode is
instantiated.  Use Floyd cycle detection so validation needs constant
memory and does not impose an arbitrary directory size limit.  Reject a
cycle with -ELOOP before lookup or readdir can traverse it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sangho Lee <kudo3228@gmail.com>
---
 fs/romfs/super.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index ac55193bf..061275761 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -96,6 +96,51 @@ static const unsigned char romfs_dtype_table[] = {
 
 static struct inode *romfs_iget(struct super_block *sb, unsigned long pos);
 
+static int romfs_next_dirent(struct super_block *sb, unsigned long pos,
+			     unsigned long maxoff, unsigned long *next)
+{
+	struct romfs_inode ri;
+	int ret;
+
+	if (!pos || pos >= maxoff) {
+		*next = 0;
+		return 0;
+	}
+
+	ret = romfs_dev_read(sb, pos, &ri, ROMFH_SIZE);
+	if (ret < 0)
+		return ret;
+
+	*next = be32_to_cpu(ri.next) & ROMFH_MASK;
+	return 0;
+}
+
+static int romfs_validate_dir_chain(struct super_block *sb, unsigned long pos)
+{
+	unsigned long maxoff = romfs_maxsize(sb);
+	unsigned long slow = pos;
+	unsigned long fast = pos;
+	int ret;
+
+	for (;;) {
+		ret = romfs_next_dirent(sb, slow, maxoff, &slow);
+		if (ret < 0)
+			return ret;
+
+		ret = romfs_next_dirent(sb, fast, maxoff, &fast);
+		if (ret < 0)
+			return ret;
+		ret = romfs_next_dirent(sb, fast, maxoff, &fast);
+		if (ret < 0)
+			return ret;
+
+		if (!slow || !fast)
+			return 0;
+		if (slow == fast)
+			return -ELOOP;
+	}
+}
+
 /*
  * read a page worth of data from the image
  */
@@ -292,6 +337,13 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
 		pos = be32_to_cpu(ri.spec) & ROMFH_MASK;
 	}
 
+	if ((nextfh & ROMFH_TYPE) == ROMFH_DIR) {
+		ret = romfs_validate_dir_chain(sb,
+					       be32_to_cpu(ri.spec) & ROMFH_MASK);
+		if (ret < 0)
+			goto error;
+	}
+
 	/* determine the length of the filename */
 	nlen = romfs_dev_strnlen(sb, pos + ROMFH_SIZE, ROMFS_MAXFN);
 	if (IS_ERR_VALUE(nlen))
-- 
2.43.0
