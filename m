Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258755;
	b=WZI0VwqH96TQCREJxJ5s8lbvfLYaePm1dTUmp3YQHI97uGBZP9Sb+5VdcPkdLIQJX/LD
	 iCf6wwqZC3pefQySNPA7pyhoX+05M9nCx6nMdalEJLhOIUV8uvwAgXk/BxH/TsC6vAez7
	 E6ZmN8EJmsZSChRcR/wxmuzp/o3woiaiP39InAV4zPeHAigrTEzVIvQ/BjEc2MMqsW8ZN
	 Dez/NawrxaozfbvukAFz8CNovhBVfn2Gb4LizrS+TEY0QEuPaSmcoTl2ZESM7ifjuggnf
	 voghfAJUSJimmxgHPRMJe8AS1Gb6uyYlHgTm7JihX/dmXzQy+7o/eRy9vE2XNXdArMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258755;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P9MZDpMBL1efOa3cR3sTvts0HeFfgHnU4RcOYvH/PDU=;
	b=mSUHS8RH6GQxY5/ROLuVWJ1Dbyu8O5VptIif81bVcCEWglGxLjnYWTJmq3484UDCpXH9
	 3xRvoImb3A9BWR+orTFYBGRYpFR/JjJNjna8VEawrz3wvCxxzSzHyS4s10wknUyolzT5T
	 Qaxvua9I5TCOCZKd5EyCzElm20Qmq/GfCh5cYuuzdr4/WeYXf+J36LGrOGMXUJXsq2f51
	 F6MTK/BfLIuNt6lXU2hB0/jB6lLnUt2G+KE2sRUrtiRJ53zZ/Q0hRnloVCwDZWzH0VV12
	 u4r1/imJkTliIXmcTgoMoYU+nv9WH1i3OS+QSKgvDYbURl4JEiAx5+xBJnIvL5Q1PFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=NLQPT0EE;
	arc=none smtp.remote-ip=115.124.28.145
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EC606A330;
	Thu, 29 Oct 2026 07:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 749EC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=NLQPT0EE
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793258744; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=P9MZDpMBL1efOa3cR3sTvts0HeFfgHnU4RcOYvH/PDU=;
	b=NLQPT0EEvDW0n+kz74/ziVrrK5BwdV5bPtmy4p7G50Y+8mRBR9wG7ia0H3qs7Tk1k1vIWrJfuPJzT/+VpRQxRQCXRVh/6u4BId8ZC9DPTB7GrK1TSjQZQf0ou9rTQd/GeIa4TQJZxreAD7QUEOs1pPMmh+yIzJ6kDZ3OmaOh8Bc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.091733|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00806524-0.00170358-0.990231;FP=17293248045670746106|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034138;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.js46iuG_1793258743;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.js46iuG_1793258743 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 15:25:43 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] squashfs: read symlink error before putting cache entry
Date: Thu, 29 Oct 2026 15:25:42 +0800
Message-ID: <20261029072542.4131873-1-guozh23@xiaopeng.com>
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

In the read error path of squashfs_symlink_readpage() the entry is
put back before its error value is read:

uashfs_cache_put(entry);
= entry->error;

Once the reference count drops to zero another thread can take the
entry back from the cache for a different block and overwrite
entry->error, so the value read here may be stale.  Read the error
before dropping the reference.

Fixes: 675f02e5e656 ("squashfs: convert squashfs_symlink_read_folio to use folio APIs")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
QEMU boot with the patched kernel: normal, relative and absolute symlink
testcases on a crafted image all resolve the same as before; the error
path itself needs a concurrent reuse of the cache entry to observe.

 fs/squashfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index 6ef735bd8..9d729af20 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -74,8 +74,8 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 			ERROR("Unable to read symlink [%llx:%x]\n",
 				squashfs_i(inode)->start,
 				squashfs_i(inode)->offset);
-			squashfs_cache_put(entry);
 			error = entry->error;
+			squashfs_cache_put(entry);
 			goto out;
 		}
 
-- 
2.50.1

