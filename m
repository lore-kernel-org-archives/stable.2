Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B11349CD2;
	Thu, 27 Aug 2026 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811153; cv=none; b=Ocr1rhO2bN2NaTmNKQpF0yEKTka6qPnjB7u0UU/O5X3CYxJBgNIb6Td8PhjsVsNcbrnXxnohceHdSEOc4J5UafbxTQJncLl15upmzoIV65EA2xCuVaAfCs6UerNmLzXxWGvesm3uuxFSAZ4J5RGgoeVBDbwpJ1L28sKboRgkE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811153; c=relaxed/simple;
	bh=QTGU2DYrPRgSDUTLKI6uT39M3G0dRr/WuHBBOu901m8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IVuMgxQlczwd/vRDd1fXQIisCc18CCcjr5DW/+X7dWurLDCTae/T/9aMokjx89887hALkAIGnjTmfOf6aH+BQkdk/RtEc8xpXVq0pkUfP0nnTwcQm6C8HpCwdDMrCbppABBEB8vugOnwYIOZoM+HV01rla8nZCiA/xENmxb8Nws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hgLQWAVj; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hgLQWAVj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CR
	OxOA+PJzwhkCPgSsF7XPYb1lchYZZ6knL6OH1ElmQ=; b=hgLQWAVj+M528DbUdd
	CDzjwT9JfHhxnSadDHZh/fSh+ILjSfcR3wDmB/BM6ffqRdOUTuRdEQ9BE+IKJnsI
	ngaenRfn8uyEZ4FynMXVWSCMM+7NuFAd2nlnQTVUBUvVrw9Eoa3f21rXFIkDqlD7
	XNUbDlQKxXfVYojtzcj4PGDPs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC37aUx1Y9qkXlaPQ--.24874S2;
	Thu, 27 Aug 2026 14:12:01 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v2 1/3] md-cluster: fix error handling and superblock update in update_size revert
Date: Thu, 27 Aug 2026 14:11:58 +0800
Message-Id: <20260827061200.79753-1-ghuicao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827025229.40138-1-ghuicao@163.com>
References: <20260827025229.40138-1-ghuicao@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC37aUx1Y9qkXlaPQ--.24874S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF48XFW7GryrAry7Xw17GFg_yoW8Zr1rpr
	WxWFyYy3yDK3y8Gw47Ka97ua4Fk3s7J3yUtr9Ika1SkryDKrs2kFn7Jas8Xa1q9rZxXFnr
	tws8XF4kua1kuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joiihUUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC+xEAkmqP1TEs6gAA3-

From: Cao Guanghui <caoguanghui@kylinos.cn>

In update_size(), when cluster_check_sync_size() detects that not all
nodes have updated their sync_size, the initiator reverts the array
size via pers->resize().  Two issues exist in this revert path:

1. The return value of resize() is immediately overwritten by
   __sendmsg(), so a resize failure is silently lost.  The array
   remains at the new size while other nodes have not confirmed the
   change, with no error logged.

2. The on-disk superblock still retains the new size written by the
   earlier md_update_sb() call.  Other nodes that receive the
   METADATA_UPDATED message will re-read the on-disk superblock and
   adopt the new size, while the initiator runs with the reverted old
   size, causing a cluster-wide metadata inconsistency.

Fix by checking the resize() return value and logging an error, then
calling md_update_sb() so the on-disk superblock matches the in-memory
array size before broadcasting the message.

Fixes: 818da59f97d6 ("md-cluster: add the support for resize")
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---

Changes in v2:
  - Fold in the md_update_sb() fix (was a separate patch in v1)
  - Combine error check and superblock update into one coherent fix

 drivers/md/md-cluster.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1349,7 +1349,11 @@ static void update_size(struct mddev *mddev, sector_t old_dev_sectors)
 	} else {
 		/* revert to previous sectors */
 		ret = mddev->pers->resize(mddev, old_dev_sectors);
+		if (ret)
+			pr_err("%s:%d: failed to revert array size\n",
+			       __func__, __LINE__);
+		md_update_sb(mddev, 1);
 		ret = __sendmsg(cinfo, &cmsg);
 		if (ret)
 			pr_err("%s:%d: failed to send METADATA_UPDATED msg\n",
 			       __func__, __LINE__);
 	}
-- 
2.34.1

