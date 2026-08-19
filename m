Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0B4963CA
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787162816; cv=none; b=cAK1IMdRpu2JmHjbxk0urNlTFBgcSxxr+VbIdN9y6LDMatazPDnTYBYUZo0jqyPUGnrb0EFUmNXyoIwWJLtpRYAaGlFfHKvNgdlCGgEp7hGXcyyByeFx4oRKafhZ1dIba5MmgojBUWmJt3HDtIn8ZqN/ATA76MZvdP32wOpALjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787162816; c=relaxed/simple;
	bh=Vuh4F2Hkn+qxramOw6V2x4Rl7E5NHhxeeBgnVsd19l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5RDCdm12h7WzzNdOVU2YwlkhxpFwME0g3+7b/y8BR9LCZnIMkCYP5yuxlCCKp5yMWzOjl3TaKfIAjsMF6BvGa5Ph3B4PzkJw+FXPaaFnnHr6e3TwXMXdjP56mwLxYKPwHuKCsJtjYwW0o0deRhkMe3yxwaYCVSS9rWiQ5ZaOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pE4D4IKL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pE4D4IKL"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca88130e09aso704596a12.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787162812; x=1787767612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GIX06LK7ExT+q3Aigt+SM74hjeyo4GTr/pSIL5HQvw=;
        b=pE4D4IKLTDGjYBuD9EDoGc9N5wnWx8TiCcqKtyyUaT43tk4XiYeJQWBCYfWQYGXfhm
         nOQZ5K6b8VFTqXztnG6J3xT30y9/3bCpvs0WPEjKKBFZvB1xm9/9jeQj7Pw7V1vtE3X1
         I0hU24FK4ewo64uQibgUynuRY3ufPP1qxi6L9OrwOaQRkzO8VMRCcafyM0dAKmIvMAnM
         HRNCL/FpVVTTaPNjgrxxU76gcjExQjP2olQ5Et1oqzz3MxJFfLjHsjWhYCKtVgM0oF18
         guB1S0kgKJCmHNbBZAkA5WIZ9jfyZxA1bb4mG9N3+yAJLTRDnGuYMgDiid+3uEaXE749
         8CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787162812; x=1787767612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GIX06LK7ExT+q3Aigt+SM74hjeyo4GTr/pSIL5HQvw=;
        b=rjSl2p3PdR6icVU4b0ZEVQs9l1+cRvOmOuOFXfEPOFw/PeLtqT8FjjGl7x9DaOM26+
         ESrS2ScWDwo2FMoUFo+M3NVEJuC4wdIVvMbjcs9ayFD2yNSbsxiyZd/GLtXtIgpJCQsh
         rBv+5mZ9PqNd0bo8qIrHqDwakdu8AlnHI6UhhC/+RyWEn0XaavkHAaTH7M/ElvLIvFsK
         4jG0t2vdkaoLNNPnMa48/FLMAq8Cxi1GtuOUNZ4u8/5cK9u2u9kTdv2facCakpDatmff
         jfC+KbN1f0XtonrgSsnNMujbUREWfqvwoFCvReRtSbpe0Rn6J8tdVtDHtEtywSc+HYyX
         aakQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBlGLTMHzpSwCGvMockscml6elMHRI9SgkjzLtkKa2bAl1DiAZLjcJdcOrp7dfYVdHVaFm4TY=@vger.kernel.org
X-Gm-Message-State: AFuF++l0un4AJw0TDanU7WDvQRPey9KYLh63ZcLHYwrITvjxMwou3dHR
	o7Dq1DezqFrW1cIXwO15rNott8BcSn/7jN6Lvh2aLYE8AB3YNGtz9aig
X-Gm-Gg: AR+sD11zTXIoRAbeRU5qejc/dtNNfFenCNOCijY2++Xralankk585qKpOZmNSUeXjic
	n2R4MUWGw2MrVosG/rMYHq94Se2W4DtyGJwqoIwMPGzm4A+ZduSA2GdG/skFF+kGxBV3scFlv8y
	P2LEkr2yEmF58knIJYuMNdJ7OoeI7YXvTEcxR8VaB+A0AmnVAxOL9yBo4BAqN0FQs3F/1I5PtbW
	51g+xpD5SdrTj61UYcPGEAMXl4roIAhd6x2X2s07pDpVEv2YfXnVBRxx8dxmw6uODGLVslf3BSh
	whqXXEwaC00s9mnw9enxzrkHpfEgiOPbWYRlLuvgWhX8tcKFhIvbdpkrHfssEm3FStoSUikkeop
	2ZC/cJg+0Xx8W9JoS7gdBt4g/dmTu+3qDROomExdadSZyRrjOE2+JWAAf8xwxCAvBOIp5cnSxF/
	72Dteu1zqKWXINvDYsIinAzdLNYdo3x31ai3iCz+cDeepbCFO510LgvkAgQIKpkk0kNpMoaE+EB
	gMf74mYfvgeTqJv/FIM2+Q+3Ktb+ZkguXdHSwD+B/TMjDzS3kKzEVlQF9/Dl51y2oR1oaowTrzy
	dyhf1wyOJK/SGCtD5rXVmqk=
X-Received: by 2002:a17:90b:5105:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-39581070da4mr12594675a91.15.1787162811435;
        Wed, 19 Aug 2026 11:06:51 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e7c:8:f24b:89c3:b14:d945])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef7a0easm10426663eec.12.2026.08.19.11.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 11:06:50 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@vger.kernel.org,
	Sunmin Jeong <s_min.jeong@samsung.com>
Subject: [PATCH] f2fs: fix to migrate all curseg types during free_segment_range
Date: Wed, 19 Aug 2026 11:06:35 -0700
Message-ID: <20260819180635.1165300-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

In free_segment_range(), the curseg evacuation loop only iterates up to
NR_CURSEG_PERSIST_TYPE (0..5), missing non-persistent in-memory curseg
types such as CURSEG_COLD_DATA_PINNED and CURSEG_ALL_DATA_ATGC.

Even though these in-memory curseg types are not saved in the on-disk
checkpoint header, they still occupy active physical segments at runtime.
If an active in-memory curseg happens to be allocated within the segment
range being truncated during filesystem shrink, failing to evacuate it
will cause subsequent writes to the curseg attempting out-of-bounds I/O
on the truncated storage range.

Fix this by expanding the curseg evacuation loop upper bound to
NR_CURSEG_TYPE to ensure all active curseg types are safely migrated
out of the target range.

Fixes: d0b9e42ab615 ("f2fs: introduce inmem curseg")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ffaa7ba76a1b..192b16ac02f8 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2222,7 +2222,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
 
 	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
 		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
 		if (err)
 			goto out;
-- 
2.55.0.691.gc56d675ccc-goog

