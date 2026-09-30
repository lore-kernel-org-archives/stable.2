Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF4374E62
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738171; cv=none; b=nRuJXMg5gyeXs/m6LP8e/uAacnF5N8QJtgJVq8MJkBGZsdVPs4uN2k8vZ7oYa5fJ/TusStWhR00P3EKHt4RXoWksY1s0O7pzXf5ODx9BDT71PnjX62JGhHs+pb9RdpXRxxWokhHj9FIbJC2vDKGnGpd86CQgjkVSBrF0oNSk4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738171; c=relaxed/simple;
	bh=IC92PZfoZHbreQIxR4qR1CO81wBQHzCesL9Aad4kxh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImXMJeAUmrE+F3LRs49UdbeYkzGOmRrNDvZ+XBMkUk0Equ2Rj+I4kV7y5F+hc3xz7duymGMgQ+C3KbFg2Mf6wfIKCQQFrszPOG9jfMMhOzAMHh8ZWipLqJFzjw9hAfRyDhmF11ePUkgCmt4Yvc8N/aNguPULZt1lZlLT/ssz3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6Fv7sB/; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6Fv7sB/"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0aa9d356eso3818841a91.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 20:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790738168; x=1791342968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KsWU53Yi2qDRmGXPspGFNXStVCSzC4dS2J8cZG+p4IQ=;
        b=I6Fv7sB/0/zEzJk2OdRfGXPmUwY8/Et4jfHFXDhmQMujmJtEX3rlrzYXsuy+TdPHTs
         45TYrR3oLnyzn/FMqbNpwmUe/+1pu53jjlAxYeKfJJ6hGUGuomK4w/zGq2bdeyO+0US9
         MnwHUkcNL315pww6YXIMPXfPHLNWVKOsTfJ1MzS4vKSCPX/pcHNmaXJyOVAaogK4YsBe
         eoQooT7lsHr6NaEUequhvlvec1rqdc2DouXit2tWQ3s1rsre1wjfLz+kw5LVMWo3lGcE
         NZdrHW06Q8tb3ePKme8J0x0+zMUsyt5r4EbB+DnFRAGJWeCfahlsSAB3q5aDCEWiLmwK
         qe8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790738168; x=1791342968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KsWU53Yi2qDRmGXPspGFNXStVCSzC4dS2J8cZG+p4IQ=;
        b=gvcRg0q7wif8YRQBhdw5cA1m+7gjbTA7xx6cOdZnxxshKAVrVMqyf6eCIUqBEbYukh
         BmIX8w9kadtdYBZEaULOGcA8ifnAbaj9HaEJGneKTbNziXZCf12zXCL+ThKcV6Zc1IoR
         Escy680Jz9+I3dAmYftpOE7G9Hzt7fGk50vOkc+3ctn36Sg6uahmIsbxAAQk800NN1YS
         zvm+DsrAoNGKjpUZ8I7IqjNMQ6cK89zAhvjbllH/6dUYc0HEFidAnN0L2ErpWorr5nln
         P2dvyhZfRmUb1pE0HN8f/YnQtKocE+o1zv/uR4F0Ml6pJTcXtuZIAB2xpgO6JWUpaKoz
         yO3g==
X-Forwarded-Encrypted: i=1; AKwUvByjmQYDnmZA0U8AU6UIbKHEXJRA9bmHdnn0730MtrTXhzLet6ZUTdkHVG345vSpbulUNujY2dY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEV43M2CfIhVKvyys0+PpZjq91PeYV1MCTW46C/3kZ5SCoqmKw
	Q246/w/mvIRhBQRCGb8aG4aI5mxG219ixWZXfsUitdVN9ZXvS9c+xeC8
X-Gm-Gg: AYBFou0CXfoJrgdC/RP86tDMpptcVIY9tlyxmKPLOiarDoHYWUGJ893Ll3EsNA+ITWk
	TlMuuipfgj8vKVM/fB+55CywhHaNoql8k5uUbKD8o9WqPZafWlZWIo8jjtIbZBh65FGEeVwUP+e
	4Ud+zScPtOMmX5Wps2diOILUhjBXpilITqduUegYeN5kKEEevkI3WCrVvW2fLGcRdUksWWO31Ac
	E70dJzNDgzXEHXjcIC7sQZkUcDjHzX0Z2pFsSclOuJbzkUGV0DBCAW2Bo/ziGiaeeVTJIIRzXG4
	TUo1X9N2PaWA8vmYXmtzq8s8H3X6fGc9992D0djqR2tmOzisWYhe7YA0pMKRwwq7yjRlebVLxJg
	xoZwBEQfEplMjGaIDWJZMLcopt5jGzjEe0VWR4EG+Gx89bKqV6ryKj9YxRQWtr8nQJ9Y49c2Uou
	fJ9icoc8bdyEdZ9kk+DCMbzwngFcQ2UrlovKY7m5YmVSxy3W+8L7hZ3L1vfNBBS4pcVS/vuo+lS
	rozwHVr4j7ZZMLtFL/myJ/7S8ClQePU0IXEqVyVA78zac1H3YThNxlxuIGiQBDGkuERO2bv9poM
	3AacAy5Pgw==
X-Received: by 2002:a17:90b:48:b0:3a0:d2f3:fa80 with SMTP id 98e67ed59e1d1-3a4d102d42fmr92163a91.6.1790738168349;
        Tue, 29 Sep 2026 20:16:08 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ce1c9045sm588743a91.12.2026.09.29.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:16:08 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4 3/6] qnx6: avoid double brelse() and fix sb_buf leak on error path in qnx6_fill_super()
Date: Wed, 30 Sep 2026 03:16:01 +0000
Message-ID: <20260930031604.70544-4-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260924073920.2782917-1-benquike@gmail.com>
References: <20260924073920.2782917-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_fill_super(), when active superblock selection chooses sb1 or
sb2, it calls brelse() on the inactive buffer head without setting its
pointer to NULL. If an error occurs later (e.g. Inode.levels validation
failure), label out: calls brelse(bh1) and brelse(bh2), resulting in a
double free of the inactive buffer head.

Additionally, if mmi_fs path is used, sbi->sb_buf is set by
qnx6_mmi_fill_super(), but on failure after mmi_success:,
brelse(sbi->sb_buf) is never called.

Set bh2 = NULL or bh1 = NULL after releasing the inactive buffer head,
and release sbi->sb_buf on error paths at label out:.

Tested in QEMU against tip of mainline commit 62f4c998b297 ("Merge tag 'parisc-for-7.3-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux")
using a loop-device reproducer mounting with mmi_fs option: on the
unfixed kernel, failure after mmi_success leaked sbi->sb_buf
(sb_buf_page0_leaked=1); whereas with this fix applied, sbi->sb_buf is
released on error (sb_buf_page0_leaked=0).

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- Rebased cleanly onto upstream mainline commit 62f4c998b297.
- Added QEMU test procedure and verification details in commit message body.

 fs/qnx6/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 080f7698a5e0..d425daee090c 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -399,6 +399,7 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
 		sbi->sb_buf = bh1;
 		sbi->sb = (struct qnx6_super_block *)bh1->b_data;
 		brelse(bh2);
+		bh2 = NULL;
 		pr_info("superblock #1 active\n");
 	} else {
 		/* superblock #2 active */
@@ -405,5 +406,6 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
 		sbi->sb = (struct qnx6_super_block *)bh2->b_data;
 		brelse(bh1);
+		bh1 = NULL;
 		pr_info("superblock #2 active\n");
 	}
 mmi_success:
@@ -467,6 +469,10 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
 out1:
 	iput(sbi->inodes);
 out:
+	if (sbi && sbi->sb_buf && !bh1 && !bh2) {
+		brelse(sbi->sb_buf);
+		sbi->sb_buf = NULL;
+	}
 	brelse(bh1);
 	brelse(bh2);
 outnobh:
-- 
2.55.0.1082.g2b9226bbc0-goog
