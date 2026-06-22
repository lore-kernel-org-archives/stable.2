Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF1357D00
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106116; cv=none; b=qAjCvQq1/Rsq7CZF6uZ6I3SewBjPs0TyK69krjmIDJu2Z3G84jQaw5dZ5PvkfdZMn7Uo2wEME5wm1G6wv1lXmW30oeE4Lk6P3P3alcdSpf5QhDdtgf4O8Lh01FA0ldu3NcotbDfBLD8QGwB3T0q9dmpF6QFjjTgXSMY6SQFYTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106116; c=relaxed/simple;
	bh=DsBaZlqnWiQTq/zY+sKaGmxUebrLWElKIbB8p7hbDWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=F1h8GO9UTh9GHrVtNQWScb8QCpn0dLClEfz5L9rmtTO6ebti3C9L6YvGBeZXMvcSP4sJ6HaYy+wApKzyPHMsQ9/qrpa4wz3uN+BPE3q+axistdtKb0lH4NlFqRwhWGVsrkoOM6UwHQqckZ0gxXQalKMgajIG5/IFOZuCc6eGgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BteTivXp; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BteTivXp"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260622052832epoutp0310b604a899030f78761ad99c84d76b58~7UBE2ri451622016220epoutp03W
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 05:28:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260622052832epoutp0310b604a899030f78761ad99c84d76b58~7UBE2ri451622016220epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782106112;
	bh=Te4Pm+XdZHSOIHP0/XZ5WunWFBbsDXVqXfqI5GAPdzk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=BteTivXpRjWgl0PWFq4o98iA7UkovFPQt6N7VMf4SDG1X3b4zekhl4T3yzinKY0Si
	 7EKJ7H342vKf3pv7xbCbs0M9dJ7HivMRkRbkmMBRm15aPKf84YjlqWWMXzpjdlAqQd
	 MqVZsYUwMVvloORhLn6DyeZ5RHUtoXS3Y6OwGWtY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20260622052831epcas1p1cd54d25bc2de4a4dbc489ae8f2eea563~7UBEZedhR1191911919epcas1p1L;
	Mon, 22 Jun 2026 05:28:31 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.190]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4gkGvM55mTz6B9mB; Mon, 22 Jun
	2026 05:28:31 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260622052831epcas1p205548491ce904c0cfda685ed05fe7cab~7UBDqqEuu2144121441epcas1p28;
	Mon, 22 Jun 2026 05:28:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260622052831epsmtip1b49e4b635d11a43e7643a1f2b2cdff59~7UBDnjVAn1486814868epsmtip1H;
	Mon, 22 Jun 2026 05:28:31 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Sunmin Jeong <s_min.jeong@samsung.com>, stable@vger.kernel.org, Yunji Kang
	<yunji0.kang@samsung.com>, Yeongjin Gil <youngjin.gil@samsung.com>, Sungjong
	Seo <sj1557.seo@samsung.com>
Subject: [PATCH v2] f2fs: fix to round down start offset of fallocate for
 pin file
Date: Mon, 22 Jun 2026 14:28:17 +0900
Message-Id: <20260622052817.3972188-1-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260622052831epcas1p205548491ce904c0cfda685ed05fe7cab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260622052831epcas1p205548491ce904c0cfda685ed05fe7cab
References: <CGME20260622052831epcas1p205548491ce904c0cfda685ed05fe7cab@epcas1p2.samsung.com>

Currently, the length of fallocate for pin file is section-aligned to
keep allocated sections from being selected as victims of GC. However,
for the case that the start offset of fallocate is not aligned in
section, the allocated sections can't be fully utilized. It's because a
new section is allocated by f2fs_allocate_pinning_section() after using
blks_per_sec blocks regardless of the start offset. As a result, several
unexpected dirty segments may be created, including blocks assigned to
the pinned file.

To address this issue, let's round down the start offset of fallocate
to the length of section.

The reproducing scenario is as below

chunk=$(((2<<20)+4096)) # 2MB + 4KB
touch test
f2fs_io pinfile set test
f2fs_io fallocate 0 0 $chunk test
f2fs_io fallocate 0 $chunk $chunk test
f2fs_io fallocate 0 $((chunk*2)) $chunk test
f2fs_io fiemap 0 $((chunk*3)) test

Fiemap: offset = 0 len = 12288
    logical addr.    physical addr.   length           flags
0   0000000000000000 000000068c600000 0000000000400000 00001088
1   0000000000400000 000000003d400000 0000000000001000 00001088
2   0000000000401000 00000003eb200000 0000000000200000 00001088
3   0000000000601000 00000005e4200000 0000000000001000 00001088
4   0000000000602000 0000000605400000 0000000000200000 00001089

Cc: stable@vger.kernel.org
Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
Reviewed-by: Yunji Kang <yunji0.kang@samsung.com>
Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
v2:
 - Handle the case that pg_end is aligned to sec_blks but off_end is not
   zero
 fs/f2fs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8acdd94272a0..4b52c56d71f0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1916,8 +1916,15 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 
 	if (f2fs_is_pinned_file(inode)) {
 		block_t sec_blks = CAP_BLKS_PER_SEC(sbi);
-		block_t sec_len = roundup(map.m_len, sec_blks);
+		block_t sec_len;
 
+		if (map.m_lblk % sec_blks) {
+			map.m_lblk = rounddown(map.m_lblk, sec_blks);
+			map.m_len = pg_end - map.m_lblk;
+			if (off_end)
+				map.m_len++;
+		}
+		sec_len = roundup(map.m_len, sec_blks);
 		map.m_len = sec_blks;
 next_alloc:
 		f2fs_down_write(&sbi->pin_sem);
-- 
2.25.1

