Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67724DD6FD
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449067; cv=none; b=jPMcXS/aTWRbY3Ls8on4yllyWIeuHYoUXMjGyAQMBsz+/9cTSxymB+7BoAgy97L37fy+t2kNQCtPaLqU4X20s6EZtMwVLhbwyJ2/TW5za0Diq94UOYQDGoHwHV77ejrpQpy24BZjUMzKyKgPR9X3PHjduX7idfqEBDRYRFgm/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449067; c=relaxed/simple;
	bh=hiRQlPpIGglFRXty3EYqUEUerglqeZb/X1JgjZonIb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Coj4pwEdht4wUHBkODiooLAvIsQ3iWnUnFJ0dWwDuMvxByz1TYBaL762dM03y9DNxFc+SjxbBXjwJJ8Qzz4Ah+88LQyVgX/yKdXgRdLOwCyEZVx/stOlWmC18dSG/e1XXPIRwybMYo3XRpKQTIUEj06OZv1NHgO3YB2as8W04HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3rm6rR2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3rm6rR2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954c08a7c8so2229185e9.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788449064; x=1789053864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKRvoFT0iXNtYocSHfeIp3eZzwJLnARoSnyrks3zVww=;
        b=a3rm6rR2VzC2DjoCMYpu/51tp4kJsSlCTlyXIFe8sLzTEgr8cmyl4TXsATSQN7qmh5
         ExBYf0WSpsQHt8lSo649XNihnRkxxxgsa7jAnNymL6bwZzhrXUI1FrsaX8bOExNrz1Md
         Q1wMqdYpyw5Yi6gAettqJ7Eo9onsMm20BLbCcLFABCKRvJEvdZItsiXRjKg/HD1Ly6iY
         JPGyieFbe7wwwqRN3Yr8s0K8+39wTjW+zHkM2tnALOWbcnCfELsaX6zfulZJjp4UJc8d
         OJTZMF8tiP1ZusOVm8vHsuLYAxfLlnZqwHbkL0QbUDpC7UT3ZBfv0LK9Rb6XhT7lDifV
         jFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788449064; x=1789053864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKRvoFT0iXNtYocSHfeIp3eZzwJLnARoSnyrks3zVww=;
        b=FbTju4IwkpqB1SNiVdHfxWr7pLqncKu3YcMy7uh/MOOA+GfZXOzH8BEFwzsUgXWvVL
         XuBQrTgfLB/1ONbf+z4hlnJVpP/EzWs3A18V09WZdF7GZRqdfrYUOS0S+he2Tmr5kSGQ
         gy4g3d53NPLXBE+4qXuAjZS+Uno11VRT1tWFiZDnHP5thriDsFzBjtNLZuX4f0nt6lcE
         WONhuBj9tMzw180m5GO0FqfyEvxyxf3SS+YkSBufKfP+k1Tl1x2Q/R/bKN7AT2GGydwA
         55AvqtHjweUDyeyZymm1t0Hb2ykRwYi5Mj5DeptvpUneFEDDmC9Who4R8NIfXEv9TFBt
         bqbw==
X-Gm-Message-State: AFuF++ko/MR4upyAOlUi88Lx1GAlxziTO1IUZjBEGNDw10KOY1ix8B2F
	kTVCKKXm7tlcj63CuMQ8/6NyldME0j9tqEWwOdCiJXRW4q6ustC2JTtRVe7mHhWcdWc=
X-Gm-Gg: AYBFou3Qszuw6VSmMF0/nRZWG62niIsijRK8CwI/0HEGBvKvzItmLIdoQrhdzzJvV37
	/DfSoqqNeveg7hh0njrXTHlEPKROxh4IfXqm8hnzxus9EIP0neCGOWa4lxZbqksrUxXP7q5bF9D
	oFT1hebmcwb8GJLQyAP9ohHwIBLoRlL0AEP7+WUXlhjvGaToTt2YG5MFG5iFP0qTes4nnmzEo4K
	8lQ9jzmukaA69LhYETkTL8fhl3B2q55UoPFfUWu2NkaLaTbqQjdHbhSvCFLkNmShlHFCitmjE+K
	c+Z4dE8bKokK6JdTtb1sgISfD0yPGW6bNBCXsyFpdI0PZdkkBz3DVOcwm21fhZnRzNbXFY4irTj
	3P/7f4jJvb+KS4ZJH2KwN2C8kH10TFpHdvKaHBRpZm1toN8xfu/myZRUNdx18tHavcoam20CLIT
	F/ZBQX4lFbZZ73zSG+lboxrgO0lPflXCt8YXkMjV5QkA8Ya+HMSIl/gOKte/otVCj789mkfFQOb
	cQsEfGIfFIY4dQGcFpDAq0npvdIc1571db+zeAlaEUasbYjLST4bVHP/W5as0ogualWTfRK/Yex
	5HwJxd7+ra5Qkw==
X-Received: by 2002:a05:600c:310e:b0:49b:9241:7ff0 with SMTP id 5b1f17b1804b1-49ce558f8d6mr118094475e9.0.1788449063470;
        Thu, 03 Sep 2026 08:24:23 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm96098935e9.9.2026.09.03.08.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:24:22 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: pvmohammedanees2003@gmail.com,
	akpm@linux-foundation.org,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y] ocfs2: fix deadlock in ocfs2_get_system_file_inode
Date: Thu,  3 Sep 2026 17:24:21 +0200
Message-ID: <20260903152421.1801322-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammed Anees <pvmohammedanees2003@gmail.com>

commit 7bf1823e010e8db2fb649c790bd1b449a75f52d8 upstream.

syzbot has found a possible deadlock in ocfs2_get_system_file_inode [1].

The scenario is depicted here,

	CPU0					CPU1
lock(&ocfs2_file_ip_alloc_sem_key);
                               lock(&osb->system_file_mutex);
                               lock(&ocfs2_file_ip_alloc_sem_key);
lock(&osb->system_file_mutex);

The function calls which could lead to this are:

CPU0
ocfs2_mknod - lock(&ocfs2_file_ip_alloc_sem_key);
.
.
.
ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);

CPU1 -
ocfs2_fill_super - lock(&osb->system_file_mutex);
.
.
.
ocfs2_read_virt_blocks - lock(&ocfs2_file_ip_alloc_sem_key);

This issue can be resolved by making the down_read -> down_read_try
in the ocfs2_read_virt_blocks.

[1] https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd

Link: https://lkml.kernel.org/r/20240924093257.7181-1-pvmohammedanees2003@gmail.com
Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reported-by: <syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
Tested-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc:  <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
 fs/ocfs2/extent_map.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index bb3a56b7f9a7c..5e86c7e2c8212 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -981,7 +981,13 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
 	}
 
 	while (done < nr) {
-		down_read(&OCFS2_I(inode)->ip_alloc_sem);
+		if (!down_read_trylock(&OCFS2_I(inode)->ip_alloc_sem)) {
+			rc = -EAGAIN;
+			mlog(ML_ERROR,
+				 "Inode #%llu ip_alloc_sem is temporarily unavailable\n",
+				 (unsigned long long)OCFS2_I(inode)->ip_blkno);
+			break;
+		}
 		rc = ocfs2_extent_map_get_blocks(inode, v_block + done,
 						 &p_block, &p_count, NULL);
 		up_read(&OCFS2_I(inode)->ip_alloc_sem);
-- 
2.43.0

