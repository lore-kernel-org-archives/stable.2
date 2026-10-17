Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D503CC9F6
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792208461; cv=none; b=MsZbizM5DGrWa7eRnINP7pT3kDwviVPknxSe2bGvGtDpuRiH5+dD612ssM/zXdd1LEuA4yL4A2ayakcaXMyrTqEuv70Kl9puqMr7lAC7tVkdjFNA7CulP8YEVqYYwY8/rNjL2thxNpF1orZIg67At1EWCrO/9Vj+dtwCz7mH7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792208461; c=relaxed/simple;
	bh=Y1bl133ZdUib1Spm1gYj9ptIgV2t1Qw5I02BgWvvsZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLmNntnpLixFvJpyB+8ST8plJp6NOeUZWZgn2ELGwjudiQeWMW5RMaI7g2wC4FgxHhksK/ND4bOc2fddWxWHClU93jsTq878PR53g76HlxUnEgMZHL+grsKsarMvq8L7P04aCyo/RQVcvLp3gFDFcA+ZxFyhEEcRaPs6e3ENcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrciUTau; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrciUTau"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3a4c78ee4d6so88562a91.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 20:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792208460; x=1792813260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mISF2YrSQB8JbgqvEnoo7X2DvInAFDBMsF8kaHx60+4=;
        b=jrciUTaufx2KVdl+NBjF+FCRofh4SjKDskZ3f6bo9dK01e6uPDNMYs6qV/DrMdL5Eb
         hdMotquHcYn0kC56PVEwvtA6yPLcad5eqW1oNV42KWKB1nERUZlrsn00NmmwSb1snxCy
         sNIPboIahbPyK1SQCDDTnlnTPZf+OZJHdr4zHTZjbw+GrkTHscvlB6/2FwR9WHxJHJop
         cxlVYLed3jEtTXq3vFwoUKodYJs+0AOkabo3a2B8agV8Pi9hO/HsDEKTIFD3OnW0hMzZ
         IzsS6QugBVYRV+9xFYVde/0VfBfJriIJ4tXUBJBogWtv3vvDJXqq2RxVIeQj2f+TJBQc
         F3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792208460; x=1792813260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mISF2YrSQB8JbgqvEnoo7X2DvInAFDBMsF8kaHx60+4=;
        b=m7gxFEB1lJX2CBzYWP3rKGgJTr6wVjpZUmKj6hv2cVebkehrig6chLMXkZOYkvb2wb
         BbPRkhMN5HlLVyEzedyzcvqQMPygbgN0eUOOnL/tz33xWmKQW7YeopYgsEU1x8smtuHP
         /Zo6wtbSo2HRv83+wFdoC5giHqK95eRiL5k0s3LJ41DclBUT6d2LKZ9fHpj3GB/A51Dp
         03YiJWnvLfdTg2tDFF/5kGDHXCNaKFuHnzQ9MWVHRwhKaQTYo5zBOlB7ehffXOwVJszx
         IoB1gfmiCU7/m3SPLn/2CQsLyS5urACdWIW6B+C9Pp9O4xA6np3cTaUpsXbBvBCYEmWH
         igQw==
X-Forwarded-Encrypted: i=1; AKwUvBxS3TaGIoY7KWmwI/oGLzar0tj8o5sL1XJYlUMpqVTbOnKbnZNIdUoRYS6ZvYW/mXB/e1bOMOk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVXKByjwRmbACvPdXPRkIfnwcxwN2DnuN/KIbJDMRZ3V+b9OnF
	AYiVmAtn+C/BKiKyJh0Mi9tKSVlzzX/UPyYASl9wly/kG4pl5k2PgNwR
X-Gm-Gg: AYBFou3eTyjGKDLA4Ll/tG3wmtVTdMmAZ9gnqBVJG1FeNL0+IKnQBEMCS9v/5OtZhc9
	VjnoAOyGystYfkL0YRq0dRcn/ojg1NMYA6cu5cTyaYBWixVRFv7KzwKPLaKJRvC8iR9uov0JV9f
	mk45X3umwOyv3I8mM8nJBaYMvXteQ8+yPtKAH+f9YTGJ12PBPbysCzW9mlgVbLQgVqgfAonWtCR
	WJFlImiYe8bXlMxJke9t31vIMbfflCh7ccQbLiRkLQshsZqgU+5zC1bvnekkXKYIF1pmcWinF3A
	Uh1z/e2bKRZnf+pxwnAi/5arDc39huYiV66gq9VR16E3ueA7m0aFgqqRk7f+fCOiy4Xa74HSXNy
	lthxeWYl94ZnuGL3psACPHY0qJw8FRpKUvPn9rAB2f8PgtVPI1Dxo7dpKZD0pf4U3+pusadi0RB
	PAp3nvTTxyM1sGEfsoTbEIy2CCaW21Brsc8gPzPvA6wGApVnPqHm0KwekYw1huHxlO
X-Received: by 2002:a17:90b:164b:b0:3aa:ff60:9bb8 with SMTP id 98e67ed59e1d1-3acef167affmr2330778a91.3.1792208459839;
        Fri, 16 Oct 2026 20:40:59 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e7311sm11708667a91.4.2026.10.16.20.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 20:40:59 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: linkinjeon@kernel.org
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ksmbd: avoid restoring only in-memory EOF after allocation change
Date: Sat, 17 Oct 2026 12:40:50 +0900
Message-ID: <20261017034051.72932-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017034051.72932-1-charsyam@gmail.com>
References: <CAKYAXd_50E7cH51hxKi9xWfE3Hjyj0PhwccgsuGX416pEJVs8A@mail.gmail.com>
 <20261017034051.72932-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SetAllocation requests a size below the allocated block count but
above EOF, ksmbd truncates the file to that size and restores only the
in-memory i_size. The larger EOF remains on disk and reappears after a
reboot. A 3-byte file preallocated to 64 KiB can acquire a 4 KiB EOF
after reducing its allocation to 4 KiB. Extending EOF this way is not
a reliable way to reclaim the preallocation beyond the old EOF either.

Only use this truncate path when the requested allocation is at or below
the observed EOF. A truncate to the existing EOF still lets filesystems
release preallocated blocks beyond EOF. Remove the in-memory-only i_size
restoration. The size check still precedes vfs_truncate() taking the
inode lock, so a concurrent shrink can make the truncate extend EOF;
that race also existed in the original path.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/smb/server/smb2pdu.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2da6163ee776..d06bdc8b23db 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8636,24 +8636,17 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 			pr_err("vfs_fallocate is failed : %d\n", rc);
 			return rc;
 		}
-	} else if (alloc_blks < stat.blocks) {
-		loff_t size;
-
+	} else if (alloc_blks < stat.blocks &&
+		   alloc_blks * 512 <= i_size_read(inode)) {
 		/*
-		 * Allocation size could be smaller than original one
-		 * which means allocated blocks in file should be
-		 * deallocated. use truncate to cut out it, but inode
-		 * size is also updated with truncate offset.
-		 * inode size is retained by backup inode size.
+		 * Truncate at or below EOF to discard excess allocation.
+		 * Truncating above EOF would extend the file on disk.
 		 */
-		size = i_size_read(inode);
 		rc = ksmbd_vfs_truncate(work, fp, alloc_blks * 512);
 		if (rc) {
 			pr_err("truncate failed!, err %d\n", rc);
 			return rc;
 		}
-		if (size < alloc_blks * 512)
-			i_size_write(inode, size);
 	}
 
 	fp->allocation_size = le64_to_cpu(file_alloc_info->AllocationSize);
-- 
2.43.0

