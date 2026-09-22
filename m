Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6D3BED7D
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052378; cv=none; b=n93yX6W2okL2OW0fZ/S7vbc3rinJQyP1kptV+6CFpqbSjk2236ZLNNaStmbEYoPBe54yXZzUs7eujGiVAEpCBXqChe/WtBtPh8n9kCUoDkxHWQHdwtZR4FLhD/SVAu++o4TnCqpXNGGGhk6r8Qn/5zArZcGLzr+Gl2GCMYH93Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052378; c=relaxed/simple;
	bh=LmqjBasxDWd9/DMzUXY/MJPkJcpcAJYfwEVP/qtHFmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgqLKH4OEh2dxnRq/ax0ncQUUtf3n8fdNKR5e2zdt1Cziaj0VouC71pkEZseeWfx1X3tVWpFSNm7x8J56agU7j9QJWRVSw2/+ox1cQidiGK4sAxWBR96sm94fTJU/MDF4b6gR1UD+TTlFRY6189/zk9E17zID9JH4MHN+QEaFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6TKSxS+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6TKSxS+"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398c066106cso2896437a91.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 21:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790052373; x=1790657173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3E+ocT2Bhu1iX7K4xkDhu5H7aG48frP1ov4mPcFNMD8=;
        b=p6TKSxS+3n5KXKvQNMuj1ceiHogZzRt+Ix9wwUuBtRE6VKdXLY1K07u6E3k8FtSd/p
         lfiSIe8ZE/Hvvc/rThv38IX4jMepEQwojMu5p1MG3d6dFrZ17/yNmGIVuLH4wVhEFjpr
         dr2Dn/JCKsBYl31lFQ8u5M2p8qb5++wn9pkynZs65WZ7I7TqeLHJ3FH7U6uY9pB0fORT
         GU0tPU8y3cbXzLEr8J9QuTiP+iw7CFObuGTBPPjGGvIlXU7plTGIsH6TBEvENXulG6ef
         s6RCyFO0+l386GOYfzh7dRpDIhjb2X7EOPXRKRC5yLSM50CG6cWj61ra7HXRKnuwZA/4
         XySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790052373; x=1790657173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3E+ocT2Bhu1iX7K4xkDhu5H7aG48frP1ov4mPcFNMD8=;
        b=Rdaqe8H9W1VvPQ54/Nmi6dXEnA2v+qQN1Lnp24zCoFtpkx3tReMb7nMa9SckJMM937
         92ktB4HyTW1X9/XY/mECtT+GxA94jISeHqBXpSBQ6RrkQVbmfAfTdgpdhwbH6iH/5Ptc
         YSSWTuyUku1aR9SLYWCMuD9Lwc/ueiYA7uIi9dp9OBbuJBaELxW7dwhmZMx8kmYUGoxv
         oPNWFWl/B1ZPGUxWCBjhMxlCVZPqvrH5HAHcWIbkfu/VulkTeLsxeSHojPr00IuJmgsh
         ng0rnOoG/Uuxp2qXhXnlwVvoWburzfcGM9iOxZ5DuOcdqyC177w3y8bcyb5XxZHsNvX0
         lfVg==
X-Forwarded-Encrypted: i=1; AKwUvBxxNkzW+BobSwatD+ehPbcXTAHmuNCf1E3UOc7YCUHv+H4UuR3gnepclyWJGvEpZUnQyQN4DZE=@vger.kernel.org
X-Gm-Message-State: AFuF++n37alpIgWUejAEJJaLYGHkEcJSqq8j7qyOAR1YfmDsJPhLMNjF
	yzZPfNqWObn3eXwSe9MtihUCy9CK9K3BzrrDP529vqPzg8DPBlpeAwOZ
X-Gm-Gg: AYBFou3HUvnHrqlcCLoGCaj8VmIqCfBiQzFmwHf3iNRmEyN1smUGit/ItD7LF8AjFJ4
	xe4jy8vYl3rUprQHfym07oddbNPEYfjoBYRU4S1Y2rmn77RN991wJiVyOnLKKEWOhlLFS1UsyLK
	mAfUBSbKG4IWOYY0xjyICBgmIy3VZf42kQGQUQzwrKts6GU2qQoW3K0n0HdgaEDOddTy+5ZfH5k
	37E7oCYzIi7Jm+hBHKg90/YfpaScfsDRTPpDVJzwlELLi4xbJdNWHSO2dcG1yKV0IfI5LnOHdCL
	z2awChZMBXnt4LUFUXyOmU/AIwPQkI2Uutuh7VlqDwwAfSgCTgab0wVTD3RRkTyl6pUVWa/ynD2
	v1rT8/OYlr/8AbqxUEAG9gfNYvWI5QiF+rj9pXM45icHBLqa/s+rNVmT45494i56TMmC3n9WTDy
	dDWVc9zAdkb+6fh4Xq7+VQytxH391jdz8ieEJ48wHEF0MmhHQinV82dn58oXabqtn5DdfY+BnrY
	KADBE/Dt5jsfJdRKBLgZPVOgSGpY/gp9yMv/28=
X-Received: by 2002:a17:90b:55d0:b0:39e:6a81:c921 with SMTP id 98e67ed59e1d1-39e6a81c9bbmr14597347a91.20.1790052373331;
        Mon, 21 Sep 2026 21:46:13 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:3443:b4ea:307f:cc4a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e570d9esm937101a91.10.2026.09.21.21.46.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 21:46:13 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: Yu Kuai <yukuai@fygo.io>,
	Song Liu <song@kernel.org>
Cc: Xiao Ni <xni@redhat.com>,
	NeilBrown <neilb@suse.de>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH v2] md: validate bblog_size when loading v1.x badblocks metadata
Date: Tue, 22 Sep 2026 12:46:06 +0800
Message-ID: <20260922044606.30774-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <fad92649-e362-443a-93ea-205b11247e6d@fygo.io>
References: <fad92649-e362-443a-93ea-205b11247e6d@fygo.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In super_1_load(), when the on-disk feature_map does not have
MD_FEATURE_BAD_BLOCKS set but sb->bblog_offset is non-zero,
rdev->badblocks.shift is initialized to 0 without validating
sb->bblog_size.  The same field is validated in the
MD_FEATURE_BAD_BLOCKS branch ("sectors > (PAGE_SIZE / 512)"), but this
branch bypasses that check.

A forged on-disk superblock (malicious storage device or crafted
image) can therefore carry an oversized sb->bblog_size.  When bad
blocks are later recorded, super_1_sync() sets bb->size from
sb->bblog_size and md_write_metadata() issues a bio larger than the
single rdev->bb_page, reading beyond the page and leaking kernel
memory contents to disk.

sb->bblog_size is never modified by the kernel between load and sync,
and the MD_FEATURE_BAD_BLOCKS branch already validates it, so checking
it in this branch is sufficient to cover both paths.

Fix this by rejecting an oversized sb->bblog_size with -EINVAL,
matching the existing check in the MD_FEATURE_BAD_BLOCKS branch.

Fixes: 2699b67223ac ("md: load/store badblock list from v1.x metadata")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 drivers/md/md.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 680b34a63cb3..1caa92b40f9a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1934,8 +1934,11 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 			if (!badblocks_set(&rdev->badblocks, sector, count, 1))
 				return -EINVAL;
 		}
-	} else if (sb->bblog_offset != 0)
+	} else if (sb->bblog_offset != 0) {
+		if (le16_to_cpu(sb->bblog_size) > (PAGE_SIZE / 512))
+			return -EINVAL;
 		rdev->badblocks.shift = 0;
+	}
 
 	if ((le32_to_cpu(sb->feature_map) &
 	    (MD_FEATURE_PPL | MD_FEATURE_MULTIPLE_PPLS))) {
-- 
2.53.0

