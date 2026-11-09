Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193588;
	b=baa/P/pHT29+2+2BIoG3FWS1Fyq5lhZrZX/5KOcr/Fb861fFfp2nAq24ziktQ6GPgEyy
	 OZCmISrbZoC9DD/5RAUptQW9ddaK0Nq481qQfeC5lL74qAOXXDNetV6gPZ2jSPSo6C8Kt
	 0qZmOOzeXlwM+kEF6P1jppgGuyM/jTnGrpjhU0n6vBOLDhaTO+VostVl+FFHoYvbzlAAh
	 2VM86uONV7NWwMDHqJzBXblUiRdrFcZy8R9iWk/0qdEqfmbNobnjd5osK6li/Yoi0aAMw
	 l74heL1C7HPg36EKGLXUpFcATQM4ewEDajwVnn8pK1bkI5sV/EDIrMIKOIPgrq8TirQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193588;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=lAk9QaoYIDXujghGW5MvMpSf4nfmRdRYorkDZVNY9Oo=;
	b=vrKk1pAjmrmo+YI2MA0BgUijiyGF862rcqZWMEh5eGW7yBaVqDwy0NIh2Tem+et2wA4R
	 ZGDeRcUlle7Eo1NEBcQUL5LRb9CQAhWwPoLQwIMUafEpjMryDE7CvBWcawimVg8Xte7QN
	 goBKaMYj0lglv0WSz4BOCo563/mze1MqcFaAWDoCmtO4WJBWRXb1SmLN0NFkpncxhgeHX
	 vaQmnox0UJ5yKmxVTUeetHJk7bI9QnxpfNYsFFQCgzJmCT9UTyS6v7FLr/joawcjNKiov
	 uzAE7jiwmLHPK/RRYhXYuNH2YcXQcGneOdOECb/ujVgVm/vvDzUAs1H2RJvwy5R7csg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ubsLLDod;
	arc=none smtp.remote-ip=115.124.28.51
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5363606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5363606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ubsLLDod
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193580; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=lAk9QaoYIDXujghGW5MvMpSf4nfmRdRYorkDZVNY9Oo=;
	b=ubsLLDodfwv0Q2XBaWqZophPskzBWHIq3/jJrj0sCqK13NuKKTg17a9HiAhZpsF5ga36AimL+xqf3MIT/6vSAIyQGB5/eyf89Z+OIlfbOLvaWROgjSlSIsbATiQZJHKlE4nEYT9vlWzTfiBKnbq4P5yGFD/WzlX5Mpvz1cmzwnw=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07838292|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00999677-0.000253952-0.989749;FP=6654756752071198712|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jzgcZpN_1794193578;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jzgcZpN_1794193578 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:19 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.1.y] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Mon,  9 Nov 2026 11:06:18 +0800
Message-ID: <20261109030618.419473-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107055510-failed-6.1-9c1d14d3b66b@kernel.org>
References: <20261107055510-failed-6.1-9c1d14d3b66b@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52 ]

The MDS decides how much inline data to attach to a reply, and the
client parses inline_len without any upper bound: ceph_decode_need()
only verifies that the message actually carries that many bytes.
ceph_fill_inline_data() then copies the data into a single page
with no length check, so a malicious or buggy MDS returning more
inline data than the page can hold writes past its end.

Clamp the length to PAGE_SIZE so both callers, handle_cap_grant()
and fill_inode(), are covered.

Cc: stable@vger.kernel.org
Fixes: 31c542a199d7 ("ceph: add inline data to pagecache")
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ Adapted for 6.1.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; dropped the client warning on trees without it. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 fs/ceph/addr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 9f664a9..1920ac6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1678,6 +1678,9 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 	dout("fill_inline_data %p %llx.%llx len %zu locked_page %p\n",
 	     inode, ceph_vinop(inode), len, locked_page);
 
+		if (len > PAGE_SIZE)
+			len = PAGE_SIZE;
+
 	if (len > 0) {
 		void *kaddr = kmap_atomic(page);
 		memcpy(kaddr, data, len);
-- 
2.43.0

