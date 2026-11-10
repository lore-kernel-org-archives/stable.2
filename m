Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.106.246.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280291;
	b=s4Zi0Xa7GW2ttKk+TaJvDWQvPddz3PZhvPMOHcPijbjcEO47uVc6tu0SW+jUjBJN/Jgw
	 30zH6Q7MAKrcI6DTQIQ2uK8iLHWge6QSeY+VA7FGI0Md4LbwdqcNnvplGkFxaNxazp4d/
	 q0itB3TyKiJAILgU2Y5Uao8I5pAVn13EIE7HMSoJO1avd9RICaTGNoIG3D5PfTxF/D3v/
	 4WY/1gISHXv5V3GnXD1LyZa/dI39htAkhDQbYr/5yyUrGU376Tro//x4SGcuvzbMXQrxY
	 UmSrwq3MhyWq1UkhhUbTW0Rg7GeBOviL/PdPknLWKKBdJm4ICpzvCyoXNTCP917TXew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280291;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=FIpvMa3wn5FZQAdDiPNRSToi7YmcTP1ItKtt8a5mV10=;
	b=R1/V9dwzIhiW1phBom7i88bV8qBE7AY2m+T+HNhbx4uyb4gSeRRlRXb4VuDHNNgmFbaW
	 FZbqpGAAxf1jrNNsUR34XPc7SrtFuAlyHj6PjQc0jtXbKy6wy1ToSB94qYgR1bFX4Na/G
	 8JGOLPp+oEIs8o7Uhw4EdAjJDQIaT2pxaRXL+OdEM8ZYgWxzOcLNDn6tBHzvG3TnUvAit
	 tZPg71+tsSuIyN8KTgUBjngj1l2PG1YclMN+kKtnGvlLlxtyXwvKWC/CYrqkD3DSDHR45
	 iDcQe1DOHxI/xrkWQRU9TMcXU8MIAqP536kUrQYX3xI57FNeDAi0/REkKyyTV2pUBYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	arc=none smtp.remote-ip=64.106.246.77
Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED9606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31ED9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from XA1730-0357L.amlogic.com (10.88.19.140) by mailsc.amlogic.com
 (10.8.11.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 9 Nov
 2026 19:11:22 -0800
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
To: <stable@vger.kernel.org>
CC: Jiucheng Xu <jiucheng.xu@amlogic.com>, <stable@kernel.org>, Chao Yu
	<chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.6.y] f2fs: force out-place update for all writes on compressed file
Date: Tue, 10 Nov 2026 11:10:56 +0800
Message-ID: <20261110031056.1641-1-jiucheng.xu@amlogic.com>
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

