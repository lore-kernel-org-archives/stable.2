Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258746;
	b=MxCZ/lo4RTa66j9PRVdVBVhE8XnjPACrXHYzdH9NE5DFyiF/nqMt+eyIEA9hse/x4C+l
	 F5IP09nvoKNFitifcT8pY6xS3frKLBlS3wevTVGIaQMSxbtSme8/JKYW1FCZ6v/bEo2bK
	 u5iJalr/9h483sgoyZvex7yd2t9bhu8HX/T3rtzXKjnD0mLB/qAtF+3uUFHuy1tgW4noS
	 3ZjrK0WFkTrhFwRf3UqIhYCxOdF7jOIWVUdGXs6ZgJBPPnmn1aP2f275ngDwNlmaa3XHo
	 BQOFgLxeyq5jzJYIcgs0Uxg2AG+mwrZ5YQ5EN+NgwVZjiw9cF6mWIdhx5LkNLUcPc6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258746;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3cPC4IMAX3nZzZBYX9BltnE4khKsc1AuewQFslmMc2Y=;
	b=P3t9QW50v+OkkHzXpkur6v7GpGlIjGBZ+snIxQ2PK/8b0xJR86hJWSLFkkVyH6bHeDsY
	 aWjfeCZYi62kwem6hWqHYss4oYIfHVykRdZ29k27US4q4QnmgNWPYPngF5jgAMHCOrp5z
	 HUQoSpnHP7PQxMfE73Gki+uHaWprunhpA+xhe+AxWJ7vzcJyEuey/w4CA3Zz8cAY3JYu3
	 eqBsZZh7891khyjuI5gK2lYGG9Eru5HcAbazPOqtXoT11Yxa4r1MwnUr0Wa0xBEO2dfa+
	 J5OOxdsVPfKapNiRG7bTeRtyyohrbANK3SDe9jIa5stqKZuyKgODhmuUw54kf7O/zSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=GPjPGzLP;
	arc=none smtp.remote-ip=115.124.28.147
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3F606A31C;
	Thu, 29 Oct 2026 07:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F3F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=GPjPGzLP
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793258734; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3cPC4IMAX3nZzZBYX9BltnE4khKsc1AuewQFslmMc2Y=;
	b=GPjPGzLPC4cJQHVDjnpeyC4b9qltSrzxkjZSNPuctPUQ8AlV5/3PVLlevWUCspa7wg5BhUEkK0qd20grCN8Y7EvY+NHlJi0C1HF/RhFDbsTcq9GrTxOBLf93VUFMkPjJxAFarjlapAbF0J/eUvpbQaEpQYr30gay8M027u0L3Mo=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08480764|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00715624-0.00250579-0.990338;FP=9789959194124225009|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.js3X1GB_1793258733;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.js3X1GB_1793258733 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 15:25:34 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] squashfs: fix signed overflow in get_dir_index_using_name()
Date: Thu, 29 Oct 2026 15:25:33 +0800
Message-ID: <20261029072533.4130922-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

The index field of the squashfs_dir_index entries is a u32 taken
from the image and stored in the int length:

length = le32_to_cpu(index->index);

Both later uses of length do signed arithmetic that a crafted image
can overflow:

*next_offset = (length + *next_offset) % SQUASHFS_METADATA_SIZE;
return length + 3;

Keep length unsigned so the additions wrap instead of invoking
undefined behaviour.  The wrapped offset only degrades the lookup:
squashfs_read_metadata() already rejects offsets outside the
metadata block.

Fixes: c88da2c97936 ("Squashfs: directory lookup operations")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
UBSan replica of get_dir_index_using_name(): index = 0x7fffffff reports
"signed integer overflow: 2147483647 + 100 cannot be represented in type
'int'".  QEMU boot with patched and unpatched kernels: a normal image
mounts identically; a crafted image with index = 0x7fffffff returns EIO
from lookup on both kernels (no behavioural change, only the UB removed).

 fs/squashfs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
index 65aae7e2a..ffc23eef8 100644
--- a/fs/squashfs/namei.c
+++ b/fs/squashfs/namei.c
@@ -65,7 +65,8 @@ static int get_dir_index_using_name(struct super_block *sb,
 			int index_offset, int i_count, const char *name)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	int i, length = 0, err;
+	int i, err;
+	unsigned int length = 0;
 	unsigned int size;
 	struct squashfs_dir_index *index;
 
-- 
2.50.1

