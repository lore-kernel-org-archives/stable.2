Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.106.246.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383677;
	b=ySehazt4DTQAq3kmT/FFpft4F/dKAgbiGft7S0TzBnwmlBU8JKi6cSRl9n4/IJhpSNo+
	 CTYqIBbT7iZ4BueB1XA2KowowLYeD/SjYQhz6Zp3eFeTVXIdABMo8DofOPDufpXnrHQAk
	 VYAwqcQgQ77gPO7sc3F+JpIYtdIiFkz3wE3kTqwX3nK3Ahe0PDjkjTcYJpIammKXQBLfE
	 00Hahfd/tIjpm/21Wz+GNzwwDUnG477oAjwxuv5oFz9Cu7mu71DxUyVNfq8w1/XHlr1Fx
	 nEMk4wnv5NyRwFQcbea0d/KhxNohj+h0BSTPK0CmZrP+bMRjSaiU7NKFuHsFerF68xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383677;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=FIpvMa3wn5FZQAdDiPNRSToi7YmcTP1ItKtt8a5mV10=;
	b=TD4qNY00BsfKBnI7/9WlbyF9cuf2eF0Ek3hVfT9qzP5FMOhhBYO0awk/u88Cj53nk3wb
	 TfyND3Z7uny9ejO0Xp+RGwD/sjfsiEy/cKndxIcljF+X4leUNu49SjsN2IGG7I+PO06D5
	 VkEUtaF3NcJqoJ2hRdZ/uoVczV1Sxzfx8lUaxPeK97Rhd+HXYp+MK+jEJcisiWtRvYMqb
	 Y1ter/bo7RveVQnLukaN6cf4g96h+4Aenkx1/gclHT5/zJIBl7rBI3m2x/K958Kdi9CwO
	 p2uNJILDJon1pp2qLpGG6vNAWHFNH5GXqzKRyQxzra4qIfYEdhwGOvCA3wsXMgLZdbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	arc=none smtp.remote-ip=64.106.246.77
Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C62606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C62606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from XA1730-0357L.amlogic.com (10.88.19.140) by mailsc.amlogic.com
 (10.8.11.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 23:54:28 -0800
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
To: <stable@vger.kernel.org>
CC: Jiucheng Xu <jiucheng.xu@amlogic.com>, <stable@kernel.org>, Chao Yu
	<chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.6.y 1/2] f2fs: force out-place update for all writes on compressed file
Date: Wed, 11 Nov 2026 15:54:01 +0800
Message-ID: <20261111075403.1299-1-jiucheng.xu@amlogic.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261107052913-failed-6.6-a64a3fec11e7@kernel.org>
References: <20261107052913-failed-6.6-a64a3fec11e7@kernel.org>
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
index b0c633c5deb7..65f933d24fe8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2629,6 +2629,13 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (f2fs_used_in_atomic_write(inode))
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

