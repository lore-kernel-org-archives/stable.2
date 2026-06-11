Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D13624AB
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213716; cv=none; b=hQM4Do8IOksNoKVKq1tlEqIMe8RMdF9CNV+Qf+8InS4FUA8AYmExUwtN8umyT3+QcCcnWd8O8Jjp+dr2j9tM0mw8csqAK5mDs2upeugieHgyAKK+jxXlmcKjDduXONuBIkQHoFu/ZQZB+pc807hKDD6MP6nySX+5L5UVqJpVXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213716; c=relaxed/simple;
	bh=hCyXATFj3Ov2wP2Dil8MM6YMgb5iJIzEMzEDy0jTzog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBJ7xXzpH86jN4yT0xgdCxszw1ogieFBfq6+i9DTUIzjJ+WCC1kVgf8ym+oga0QIKndHrk2hE0UPIFE891gPfOm2DPDRBCbqtov0busekF97NYl3PlYglVT3FnY0mvV31IeLOglRY5A8pHAHFDm2UUF6qdlHHm2cvBSQM28b/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=YDrAs9Zd; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="YDrAs9Zd"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91562bf6c12so40486385a.2
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781213714; x=1781818514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FyL7MLnyi7BSEFK2/5LnuQPeRqNUYzr49gk95R0WT30=;
        b=YDrAs9ZdC2qn8I9ZkudaLyFrFlttKxNChFqZBuBvOhQbaxhAFpvMVYwHkBVboOn8p1
         8rRvz/aWpOAr3NcU8zlsBlrwwUPuqYS2sLI0JT+WSG1vuqB98bjhLB94ziFFAzSQYvDV
         XmJglQ+g5XQntKuznXorSAahvSYS7uHNSo2ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213714; x=1781818514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyL7MLnyi7BSEFK2/5LnuQPeRqNUYzr49gk95R0WT30=;
        b=DZED74mVXQkxnwoJv5meOEBWKZNAuvuaxzXkjb7B3r0m/zf8mTCFl+hWDeyVK3oeqY
         +W1lQ9pkm31gsiyvC4o10eNyKuCgzUZzWYuo0KhKaV18Aobq+j17h05gSfRaxkWy/Fd5
         yxls48yCyBWasE1jh1+E/u9aFVe/Jb3AvqMu5UUlwCv+jtsrltf0nZ/uiFSIe82E8niF
         sVAoZ/pmFJnZleBR9TnoINd+4QV6WBt/dXlCtNBPzOLxYch1DX3dmzRNjGTnusioUJXJ
         XQ3Qp/oE63cKZLuua+XdkdF9bAJBublkgxiuF0JavaXsfC+FZUspQm8XAVnG74sT0t7k
         o7NQ==
X-Forwarded-Encrypted: i=1; AFNElJ+T4OQiTS+OquAPLql0o8Sj7qVRLRwK9mVxkQc1X9JuoIUhon/tN0N5X7qUb4SaYu89A7SY5vY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ASSahVB4zWz+BhuxIfHuaxKsoKsUxCK08sSemEPZdgnBI1KZ
	S5pGozXN9r5O6dXLhOFBgRYwsv+h/Z/aGOASHi6+Ih8HvMMJLba7IYDdjujVW815g28=
X-Gm-Gg: Acq92OEIP9V8jqFkYWOsU8AdC/1QUEHtxWWoJwRI2Jq9ZZ4iXNxl9JAHMyL0XcUeonp
	RXUqD0zAWcjtwwF4Q5uggj0ryEVMN8GF3q67tazmcpvfi7Gzvu95uvyvb9g7O2v7tZ1lTl7uJdg
	lb3kBH1QJ7OH0XznnbRoPYTWq3FK6rM5kJ/ZJRTGAqeYmqFhE7Cl+twrLH0gnQceBRiKiza0WUU
	XUN0thSGB2Nbeg3BeufX95XnG0Lz65NE8w3esDo1dtvRPBKBywefkl7ZzvZu7uvXj4NvjCwVDtu
	9+LrGs/RpAVRqsQvAm8k++dsB9kqf19elMPowBN505YJ7F/Sy5P+umBBrNrOuV18lJ+plhITbNW
	LQYQSqxZfG10yWNqkTdw8dNU+VCc6JZGEcSSTEpzT/FT/lezq8Ei7MPKlKEf0XSYV2hv9mw8M37
	P2jEF89C5i6zde25Vpy+yraxvjuwIIJ4RxDSYyLhuTOc5nUVzgWWIyjfMxXRCAK1OwPeo4IHBOA
	v9l88V+BXcKV+XYFOiJaSE2KAYBY9+2wE0=
X-Received: by 2002:a05:620a:8017:b0:915:89d4:df0f with SMTP id af79cd13be357-9160ac96084mr730469185a.2.1781213714230;
        Thu, 11 Jun 2026 14:35:14 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a061028sm27194985a.42.2026.06.11.14.35.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 14:35:13 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2: avoid moving extents to occupied clusters
Date: Thu, 11 Jun 2026 14:35:10 -0700
Message-ID: <20260611213510.16956-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For non-auto OCFS2_IOC_MOVE_EXT operations, userspace supplies a
physical me_goal.  ocfs2_move_extent() initializes new_phys_cpos from
that goal and expects ocfs2_probe_alloc_group() to replace it with a
free run in the target block group.

The probe currently leaves *phys_cpos unchanged if the scan reaches the
end of the group without finding a free run.  An occupied goal at the
last bit can therefore survive the probe and be passed to
__ocfs2_move_extent(), which copies file data into a cluster still owned
by another inode before the bitmap is updated.

When the probe does find a free run, it also subtracts move_len from the
ending bit.  The start of an N-bit run ending at i is i - N + 1, so the
current calculation can report the bit immediately before the free run.

Clear *phys_cpos before scanning and use the correct free-run start.
Callers already treat a zero result as -ENOSPC, so failed probes no
longer continue with an occupied caller-controlled goal.

Fixes: e6b5859cccfa ("Ocfs2/move_extents: helper to probe a proper region to move in an alloc group.")
Fixes: 236b9254f8d1 ("ocfs2: fix non-auto defrag path not working issue")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/ocfs2/move_extents.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index c53de4439d93..ad1678ee7cc4 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -534,6 +534,8 @@ static void ocfs2_probe_alloc_group(struct inode *inode, struct buffer_head *bh,
 	u32 base_cpos = ocfs2_blocks_to_clusters(inode->i_sb,
 						 le64_to_cpu(gd->bg_blkno));
 
+	*phys_cpos = 0;
+
 	for (i = base_bit; i < le16_to_cpu(gd->bg_bits); i++) {
 
 		used = ocfs2_test_bit(i, (unsigned long *)gd->bg_bitmap);
@@ -555,7 +557,7 @@ static void ocfs2_probe_alloc_group(struct inode *inode, struct buffer_head *bh,
 			last_free_bits++;
 
 		if (last_free_bits == move_len) {
-			i -= move_len;
+			i = i - move_len + 1;
 			*goal_bit = i;
 			*phys_cpos = base_cpos + i;
 			break;
-- 
2.51.0

