Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.106.246.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280478;
	b=ec3ILYohyHdrdwnJ9dpTUOTKp9ClgIUrF7ZdeQU/qtZw5angJ2S9gGS25jQ5jRKdeZA+
	 UZfy3h+Og1qMu3JNoDjjmQvUrGvf77eVHK+Cz3hcp0iWegytKvHAL/dES4ouGSwuvRy+5
	 Z+S27YDV1dADmCvV8Ov1UKtMN6WiROYNWuQwcP4/322nJPUeyfor0Qk9iCJe8520JU4N6
	 KWnmG2GT561h1SGdQRK55Lx0w9ruMcDswWZdqaXsHNtBUoqaQHt5k6/Hstsb7fCzsF2od
	 jXhuR5vLltaud22xOU5W07Q5crr6zTUC2lM/5bo/rktTQP6k6sX6tUJProG9I29Iuag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280478;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=qqke9PMED+FLGs/bDq1q+x6lQYGaEXwMTGxveGhgiuI=;
	b=tWA3lwAd7UNPUqq7QYvj0DfDe25CEv6YMavJs7pciZ6sDOet+9ZOQSln8JoVmVbOIyui
	 /HBRBxnUnCKFfOE2Gi5umWB9TbJbyq1EpR7MO8guWkIPvNtDMQtS6bZkqsPnz2cN0dMtf
	 JDd2LCT1a5s5QzBqpEf8+b4bhpAEjGiyRtO0MxxW/LfoK0RTiQfMoKP/xCCrNlarlwZCq
	 A7V70iz/RQkDH6QzAhKBFeRuRwJa/FTRzlgL0H4UM7mwaY8DI5y4rW4av0n40tbsLCynE
	 zbG1pCzdWTZW2eTcKp2yzvUIPbS9AMCOvYj+GDRrlxT52UtPT+Kav8Wn4QLeNN/OQcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	arc=none smtp.remote-ip=64.106.246.77
Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB42606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BB42606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from XA1730-0357L.amlogic.com (10.88.19.140) by mailsc.amlogic.com
 (10.8.11.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 9 Nov
 2026 19:14:35 -0800
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
To: <stable@vger.kernel.org>
CC: Jiucheng Xu <jiucheng.xu@amlogic.com>, <stable@kernel.org>, Chao Yu
	<chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.1.y] f2fs: force out-place update for all writes on compressed file
Date: Tue, 10 Nov 2026 11:14:24 +0800
Message-ID: <20261110031424.1730-1-jiucheng.xu@amlogic.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261107054156-failed-6.1-a64a3fec11e7@kernel.org>
References: <20261107054156-failed-6.1-a64a3fec11e7@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailsh.amlogic.com (10.18.11.5) To mailsc.amlogic.com
 (10.8.11.35)

commit a64a3fec11e77a3a0dc0009bdc58b925e45a1bb4 upstream.

For compressed file, compressed write may fail and fall back to raw
write.

-Thread A                                         - Thread B
  - f2fs_write_multi_pages                          - f2fs_down_write(&sbi->cp_rwsem);
   - f2fs_write_compressed_pages                    - ...
    - f2fs_trylock_op                               - ...
     - f2fs_down_read_trylock(&sbi->cp_rwsem);      - ...
   - f2fs_write_raw_pages                           - ...

Thread B acquires the lock first, which causes Thread A to fail lock
acquisition and fall back to raw-data write.
IPU_FORCE is enabled on small-capacity storage devices (< 16GB),
so f2fs_write_raw_pages() overwrites the original compressed data
in-place.

The in-memory node has been updated with raw-data addresses, while the
node metadata stored on eMMC still remains in compressed state.
If a power-cut occurs before the node is flushed to disk, on-disk
inconsistency arises: disk data is raw, yet metadata treats it as a
compressed cluster, leading to decompression failure.

To eliminate this risk completely, force out-place update for all
write operations on compressed file.

Cc: stable@kernel.org
Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
(cherry picked from commit a64a3fec11e77a3a0dc0009bdc58b925e45a1bb4)
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
 fs/f2fs/data.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6384ac931bb7..4a0bf44b3a54 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2662,6 +2662,13 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (f2fs_is_atomic_file(inode))
 		return true;
+	/*
+	 * rewrite low ratio compress data w/ OPU mode to avoid fragmentation.
+	 * If IO comes from compressed write path and fallback to raw write,
+	 * force out-place to prevent metadata-data inconsistency.
+	 */
+	if (f2fs_compressed_file(inode))
+		return true;
 
 	/* swap file is migrating in aligned write mode */
 	if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
-- 
2.55.0

