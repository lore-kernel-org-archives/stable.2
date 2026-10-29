Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793251866;
	b=HKda5eZz8uCpCUoIkCfVnpZTVfEDBfSmoB4sv0CHkc6UZgMdtLewNRwpguHZGWaiDHHs
	 DpOghzuVssWPpPWihfCQGTe7VEpgRnD8LNQsqJ6nC0/It2S21sPufpfgx8LobVIyIPG+t
	 LBkLmv5ESghf84WL6/LcSDu9MsH7S8QFhogI/Zs7VZkfgnVvxo1x8VP7yqUkztU1pTSYD
	 yj+iaZYbqvarrbVnhmjvHTo56JLMPaZR+3PLhLnzHk/J9oXVx1zEug3WIZqUSVSc6hZIy
	 VGyzipxjziAsUFCulogGgcKyJDBE+KHQO4soZYCrx8rnd50xy/aOEOQva3c1i5KHC4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793251866;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=2WMOO2p95M9ThYIGbReouUB1EEEiCid5uIcZXbX1JvU=;
	b=KwW3eKkvPZJJs7rQL6xmHSw1UlgdRLYL6qwzcW9d/hIHdyUYIkx3nTCPJlJYYuo/i04r
	 3ZS2Fh3xi1smVu/B6bRnESyP3oHznl+/PjZtqDWOzha8gc6aQKPDupw7Ub7e5KczBSt6T
	 SconKvH2i7DN7kwNHz5HvjSNBc+qHW5LDb7IRTuyCnffy/Q9HCWvGeSDdYYScPRE/fs9H
	 OzinUeZUC8RzviDy9Xj/4HdEhc0fN8gp1cEgUnw4GXby792Z1MSPTodcfmr7nyKFrW4G5
	 ZUVjJfRSbWAXN4an+To72TCFGFreW0ym6yfZ/kpel7Q72kak8+gheB5bcfLJUvS5ZtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Y3vU77yn;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFE4606A31F;
	Thu, 29 Oct 2026 05:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AFE4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Y3vU77yn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2W
	MOO2p95M9ThYIGbReouUB1EEEiCid5uIcZXbX1JvU=; b=Y3vU77ynFsjqZ9ZqEY
	5/ycXmO/8NQqHDoOXjWKuVGuVo3kTQkXpy7hiDfNUd3a+BDGOGKv3UD20YEcZFnW
	2tcmJ2fboq/TJ0GtMbCwQnMET2w/Vo0P82InuILekOACobvnJbglKE2qJ/SAYweF
	x5ZY1ti4sqMQ0dXBqcnZIGrWY=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3X7zw2eJqnygTDQ--.62701S2;
	Thu, 29 Oct 2026 13:30:25 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH] media: mediatek: vcodec: NUL-terminate debugfs input
Date: Thu, 29 Oct 2026 13:30:23 +0800
Message-Id: <20261029053024.2526059-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3X7zw2eJqnygTDQ--.62701S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyfWFWUCw15XF1fuF47XFb_yoW8WryfpF
	Z8Kw17Ar1kJr9Fvr18Cw47ua45C393XFW8CrW3Ww13Zwn0qFW2g340yay3JFZ2yr9FkFnr
	Jrs8uryxWw4jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USkskUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzREGQGri2fHwZQAA3v

mtk_vdec_dbgfs_write() allows userspace to overwrite every byte in the
persistent debugfs buffer. The read handler later searches that buffer with
strstr(), which can read past its end when no NUL remains.

Reserve one byte and terminate the copied input at the updated file
position before releasing the debugfs lock.

Fixes: 5e488a4fd859 ("media: mediatek: vcodec: Add a debugfs file to get different useful information")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 .../media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
index 2da11521fc7b..8528534e41ef 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
@@ -77,8 +77,11 @@ static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
 	struct mtk_vcodec_dbgfs *dbgfs = &vcodec_dev->dbgfs;
 
 	mutex_lock(&dbgfs->dbgfs_lock);
-	dbgfs->buf_size = simple_write_to_buffer(dbgfs->dbgfs_buf, sizeof(dbgfs->dbgfs_buf),
+	dbgfs->buf_size = simple_write_to_buffer(dbgfs->dbgfs_buf,
+						 sizeof(dbgfs->dbgfs_buf) - 1,
 						 ppos, ubuf, count);
+	if (dbgfs->buf_size > 0)
+		dbgfs->dbgfs_buf[*ppos] = '\0';
 	mutex_unlock(&dbgfs->dbgfs_lock);
 	if (dbgfs->buf_size > 0)
 		return count;
-- 
2.34.1

