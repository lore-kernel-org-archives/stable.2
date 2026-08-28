Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F85380FC4
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919913; cv=none; b=Z/efkMYSt0ASqh0cB/vX2+ZREfIjiZ9lwF9T8mFqTFns63PxyGwfmZ/ctGWG5QdyX9I2jEPUGSMTrRA/71bMvltuaIHfKrgHGFKkJ+Asf22s2Sxm9VQ55EZSxgY2FxWzHDigkkknyXhncLKjZyv1Xe7RaP+8gG/is8Bt2+chDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919913; c=relaxed/simple;
	bh=pWoBE0Ap013VoeV2vp85NB4S53A3uBMfxaaPmtJIfxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cI+KflKJbYZTA/ucGzZEO5WfTpkfB1e7jJP6yJ4wEr+ziMzFDE0YSdvri2zRewLEDV/a9jSADoV2GOXBxh0xeNkbT/BjZJiCmPq0ozlKvS6Vvp251hb5uBPoFj8WR8BH1MqlF80u0IJH2Nl0BX9+gmmhhtdhtrG+O70WfgxdLLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNSVbBat; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNSVbBat"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc891373e0so7224335ad.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787919900; x=1788524700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ghL++ZvF6V2+SKQri2NFYRwIeM8mcziADY1V3awfvk0=;
        b=FNSVbBatkQeZNEeKJGramg+chWGwQfHIyvV95kioQRtt79F83HLA/07KFs4Be2nHQs
         1YCkqjLplZDNUhN8XK+CLsPGSoJ2uK3R9C7OLfCd9TWc1LORtR2RWw44FqgJvfixTfbk
         5gIy1Lpn1FiJnGCbeoePoKceET/pkkTrl9Nz/Olt9nO09IFJ8IPnQ/vRh3VpEKGp5IFJ
         Ptatx2FssVk44TfCab2xlauTFIZz/9Nn7T48vEl9Qrebzs0ytzb7j/G3f2kZhY/ATsq3
         ajpDgq+VcJkqExKYbdgx+PbNmlV/iDs5WVNst6usgnHG2kY+oHjkBGQ5Wspkl2urh1me
         agEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919900; x=1788524700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghL++ZvF6V2+SKQri2NFYRwIeM8mcziADY1V3awfvk0=;
        b=EOFq3A7uf3+Hgdp3VcHdHxBh7ZVMy8czMcVJ5WYLItFqmtpc/FCAY5pHX+EqzqB4Q5
         TRKL1BOpfaKbcb2w5UnSj+PPjlRR7wGpHqCek/7of4/G3dvtEn3+kcvsz1bvIelbHder
         umfnlrmvO1kO8IhpoH9K/R9WJg/0uwOglbD+bnnp2lk5c4tM/X+Aa6FReDU0Ur0kZcaJ
         EL+MQ8gtS/V4recXFVgK49F5dOt6h2ltwWfU/EknKyxfOCo4880A9aEmBimFbJtlcKVJ
         GARRjLwr9MFJuQIcAF6H9xDnXifCPfyCZUbjFqp/Tt7O+BVXdSzBjUUxfoTJpChcIkV/
         p7ew==
X-Forwarded-Encrypted: i=1; AHgh+RoGYbJ1w/v47rFeoG6AiSJjodWFWzAlGOzugyNeM626WiZIhw3eX93uF8hFVBhgfhkSeTCafiQ=@vger.kernel.org
X-Gm-Message-State: AFuF++moP+h4kClYHFmfHLFzP0bTgsi38HnZG1/y9vposCJLzzq8VfGT
	ngq7UgYkOmrjV7e8hNP9nmOF19X7fxKUkzUMwhWmDRyrwUzLvYnOaqgn
X-Gm-Gg: AR+sD133svRxcu6KLDvgrPuoRgCpLJ0DRGjyVT1KKtTPtSeq+xqkwsAW63MEGHY0Amn
	UIiD0NmeyEPcMdCD5AaLB4K8akaXh+QQg/dSyQ8XMCHnWa3LQwsdOzInA7mX7daf8NH0u9XnNqn
	JoZgWZFpFA/F6AeHoV7MSdvOZf4vqLHugCnAeVKVcU4vV0/OGwJB4a28+nMNNqOeamVrYMa7rdW
	cqkLoLoS++QQM3WvJTu14CzUARqNEe7nqS+18tFrGsoOfDQYaNRJao7WFIjsIitxrakQVnXJID7
	XU4T0t2OGnTcpCX7JODmrWpVc6p6hgLBRxSZR8qfofIa876r1QIBojMg1XGHD7rmdV0HtisYOhV
	jrZ9U5Ty9N8DmTSgTZRYXsQheBPHNV42mF+P8zebgsqL3VixZhPrlak8wGtOmiViCTLCV6S+f3B
	qMBH0QtdO1aeu5zxjvH8o9Z5csuQWlaGpnKMNCgXjexZd+sUBPAGAF4JJj1UlECIgv2fT4NjygR
	cInCOMmGY7teRuamAeaqTiW
X-Received: by 2002:a17:903:22d0:b0:2d6:ccc5:a3dd with SMTP id d9443c01a7336-2d74dc2ff23mr111979445ad.4.1787919900181;
        Fri, 28 Aug 2026 05:25:00 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7594fb48dsm4969115ad.14.2026.08.28.05.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:24:59 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	daehojeong@google.com,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] f2fs: sync pending discards before reserving device alias
Date: Fri, 28 Aug 2026 20:24:51 +0800
Message-ID: <20260828122451.1154128-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A released device-alias range can accumulate pending discard
commands. The reserve path later makes the same range valid again
through f2fs_reserve_device_alias().

If pending discards in that range are not synchronized first, the
discard thread can still submit them and hit __check_sit_bitmap().

Handle the synchronization under sit_i->sentry_lock by moving the
range wait into f2fs_reserve_device_alias().

Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Cc: stable@vger.kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
v2:
- move the discard wait under sit_i->sentry_lock in
  f2fs_reserve_device_alias()

  kernel BUG at fs/f2fs/segment.c:1228!
  Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
  CPU: 1 UID: 0 PID: 79 Comm: f2fs_discard-25
  RIP: 0010:__check_sit_bitmap+0x2e1/0x4e0
  Call Trace:
   __submit_discard_cmd+0x921/0x1140
   __issue_discard_cmd+0x524/0x12f0
   issue_discard_thread+0x686/0xe20

 fs/f2fs/segment.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1e7e745be71..50d49ba3e11 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1916,6 +1916,15 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 		__wait_one_discard_bio(sbi, dc);
 }
 
+static void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi, block_t blkaddr,
+				   unsigned int len)
+{
+	block_t end = blkaddr + len;
+
+	while (blkaddr < end)
+		f2fs_wait_discard_bio(sbi, blkaddr++);
+}
+
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
@@ -2684,6 +2693,7 @@ void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
 	seg_num = GET_SEGNO(sbi, addr_end) - segno + 1;
 
 	down_write(&sit_i->sentry_lock);
+	f2fs_wait_discard_bios(sbi, addr, len);
 
 	if (seg_num == 1)
 		cnt = len;
-- 
2.43.0
