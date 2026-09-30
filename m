Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91A372ECF
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738170; cv=none; b=UE6VjsN4ji3n9FxqQm1OCQJz1vP84BAlYf+FL95lCzwY+WHYIB/0OZp2EG8YfeSNutPZHp8DOPFDG6gTkz8qcxeJJGxq2Pq3ShBhyT1yyYRDvcABmmo5uRi0VwAs0v7h1qQdzPRHC9M/NkkPDPFNaNiG5Sp1/SSR6+hh0+JkRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738170; c=relaxed/simple;
	bh=0DvFLtWh/YNSEWIGblWeCEsGRSgydftqKVETMB0AC28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAAkBUFHJkrT20kExFoPzhUFL7D+SsMdE4wvpJ2+RlzUXsPgqrVLSW4K3C+ocVhSJEB87bXzyGHDCBo2sXNz3azIoI3xSEDLLZXhk3FEEnlBrthDGoSkbU9LU0F4lByDNS/w/ZotJhZK6C3D2/UeM/LqGDBEO1t8hmGyx+HJvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3NaAPR5; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3NaAPR5"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a2adb9bc3cso1741939a91.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790738168; x=1791342968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L9oO5px/tUz63X6zzeE/TZluG5rtkY3Gx9MGMQ40YwY=;
        b=Q3NaAPR5L3yrx6gadDW56BAR7O7xiVZUQIOnQSmfZfrPqI6SVjVQRnHg6GZ14xfwLQ
         ep+UIMAbZk/gL4SDdoDC7Dcn1TjFvuDf68PykqhMynzxVgKmfrnFkxcdEPdEBLSpR7jm
         2Kvwv9okV3vODZePEN8Xnj7fzwCxVPRnWVD7FTj8LFON48qoPc6HnOF/fT1Di3+xkxTh
         5CH2H3Fyfp3aMGyR2w11nQhFusU4+DewxwXb6o9IDI4ruRFMwhsINyjy8OMZ/KAr31nT
         p33zIGQ3PcIaJe0kTPQ5S8gK+vmJ6456VzlNRlJLCyf2cNynGk3TizAxhkO+Hr8GwWYM
         6BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790738168; x=1791342968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L9oO5px/tUz63X6zzeE/TZluG5rtkY3Gx9MGMQ40YwY=;
        b=ixjya0gWrKBe4pY6+OA9/mOHYGrXSidaV1TiYQ3eUw3ZMPCy2tLFhD306OE4gAVHff
         ouL5A77dzfQTTJxlqDQaOZ82fItQCQaD/UU/R0PpaHM2DhKpYdzVzYjQ+9avwWTxvbPw
         xkKoy3jI8sTkVJkKpdbkjI2EnnH1ZU/cEcfGzeoL9o8R9EmpFzMRSdZ7P/80ZNqqjwGq
         YrfLIZonYG9I6ZOwrkTVD/WQgJ5ZHeFXpyLtK4hp1NMhRkuVCEXcufAGC8gBJyT92/Lp
         Sf8OUnkg9O+HLuSwV6gs6YXEHL2QfSTxs7euTI2IuagaNxhuFLKPJDII6/fh3Y3FPmKl
         97Yg==
X-Forwarded-Encrypted: i=1; AKwUvBxPmGYTdaxPH3QjPwHO/s19L1u9dz8QB3Q1H0XoMVWEHNIFs0LSvkPK0PqrHbP+AA4nGk2uUZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeFpTEE526e0mAv6k6vFOAwFZez3Sn9hwkGS80MTcINAdHSE/4
	eQoUFCJlvaw9bf6XkjDvPnbmX2XdlXxu4b2n95V4Vi1lb2l0YK/Hcfgd
X-Gm-Gg: AYBFou1LDE2Py06ffp7qkEuZaFdDO0wJmJfwYqiy6JwXCvAFUKKs5G0V5EkCw7IdUNe
	2BIqFkG7rzNjdkJRrge/UjzeL77pOz9Hu13/e7N+Yij7uKnRgnq0svKBu02Rlw7IEUciSSxvwR2
	6w7quRbhG6D2QYgOtAvRH0dXUd1g+BizoUUZx/KnLnFFqOBzidGtHlSWGUDNnQ6cJ0BQqUz453G
	J89I2F8TPx5lYTAR5jK2I3gqMZCuM8scxoQPYUGxTCRtB/9qbgTz8vZ9mEwVvJLYfMTRTPUtDLR
	CtZ7KQ5+PgM2JLqn0B4AEc8cgfxiobPuMTE4Jhda3chIWKz7LqqFntL1y7qhjC3PS4vVTOLoNQd
	07rniH0BnGlv5sdQx7ki/8PQavl85//hlo9KDjD8Tyb4Bn1G+u06fUAMwYgFxuihoKe/CHAebqp
	mMc4/rM9soT6pBrxTYRmlov8Wta6RLnyCBcu3ZY2xp09Sj4aUGuIZdaPDJBrclE3VITy9kUiPfh
	SJdPdEpi0olL+mI4wzScC20wxBRNoLnfkoEjQDUAy77BVEng71bgJ71wdycTYnkBKtslbMCqDlC
	Sfpcb27gbG0fVhUFo17k
X-Received: by 2002:a17:90b:3c8d:b0:3a0:becb:914a with SMTP id 98e67ed59e1d1-3a4d0f038femr58495a91.3.1790738167868;
        Tue, 29 Sep 2026 20:16:07 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ce1c9045sm588743a91.12.2026.09.29.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:16:07 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4 2/6] qnx6: release bh on error path in qnx6_block_map()
Date: Wed, 30 Sep 2026 03:16:00 +0000
Message-ID: <20260930031604.70544-3-benquike@gmail.com>
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

In qnx6_block_map(), if qnx6_check_blockptr(ptr) returns false while
traversing indirect tree levels, the function returns 0 without calling
brelse(bh), leaking the allocated buffer head.

Call brelse(bh) before returning 0 on qnx6_check_blockptr() failure.

Tested in QEMU against tip of mainline commit 62f4c998b297 ("Merge tag 'parisc-for-7.3-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux")
using a loop-device reproducer reading a file whose indirect block
contains an invalid block pointer: on the unfixed kernel, check_bh_leaked()
detected indirect block 5's buffer_head leaked and pinned in page cache
(indirect_page5_leaked=1); whereas with this fix applied, brelse(bh) is
called on error and the buffer_head is cleanly evicted
(indirect_page5_leaked=0).

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- Rebased cleanly onto upstream mainline commit 62f4c998b297.
- Added QEMU test procedure and verification details in commit message body.

 fs/qnx6/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index c999dcfdc477..080f7698a5e0 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -144,8 +144,10 @@ static unsigned qnx6_block_map(struct inode *inode, unsigned no)
 		levelptr = (no >> bitdelta) & mask;
 		ptr = ((__fs32 *)bh->b_data)[levelptr];
 
-		if (!qnx6_check_blockptr(ptr))
-			return 0;
+		if (!qnx6_check_blockptr(ptr)) {
+			brelse(bh);
+			return 0;
+		}
 
 		block = qnx6_get_devblock(s, ptr);
 		brelse(bh);
-- 
2.55.0.1082.g2b9226bbc0-goog
