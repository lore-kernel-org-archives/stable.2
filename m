Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D16B67E;
	Thu, 10 Sep 2026 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009243; cv=none; b=oaKnG+m0bxxnEY4G6DNQRrAkioeGtaOHtydLJ69uHr9twdRy9G27xMGDp309AGQnSUQ/K1a3qilRiyxgMTdJ/o4qva82WAN1WAII7/Ofen8ndkhSp9jKZRDZIWqgQahuVadSRtwC/WCkYKaVwdx2YsLTIkozuvUla47oLY62phk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009243; c=relaxed/simple;
	bh=A7PNGMGbQtnRVCFeuXx3tq5V8XXMyBCnWap9FB6QgiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9TQe3bwcjXxD3FZXNDZpo8MsvKmcwGptin4eCI7eOS3tEW3z5x9DIdXl9nvheN9oCb35bFKQSMMZnttZzR58j8lx0wD4eRKDwHxR5JElj+b5MyO/xGwDzA9WxGqFb+w8NkKD6TjHOLAWCtjBo/xMoMMziWEjdHGW5pMtEQ/giw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=XOeb8x3y; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="XOeb8x3y"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789009237; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OTFLWrl+qAjkSWXHIgQqkXGjVHwsQiyRzO/dH1S63EM=;
	b=XOeb8x3yHfSkpmaam6xnfRH+F9KD46ZSwKSH7ZJKNiyNznabGswKfOEHZlHiXIw4K23Sv/WT1ZsRM0i/pLdsQr9drOdm3GbwiOR7jRvpCai2yzAqa8yMS1SQwwdkdB5Nt5nE09wD3E82sbP75AOy+MucBR5FjX58pUcHX/NRaK8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07731052|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0118688-0.000212665-0.987919;FP=6717226604748474298|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jA1h9UI_1789009236;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jA1h9UI_1789009236 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 11:00:36 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Thu, 10 Sep 2026 11:00:35 +0800
Message-ID: <20260910030036.1045515-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908062119.402027-1-zhugl3@xiaopeng.com>
References: <20260908062119.402027-1-zhugl3@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MDS decides how much inline data to attach to a reply, and the
client parses inline_len without any upper bound: ceph_decode_need()
only verifies that the message actually carries that many bytes.
ceph_fill_inline_data() then copies the data into a single folio
with no length check, so a malicious or buggy MDS returning more
inline data than the folio can hold writes past its end.

Clamp the length to folio_size() so both callers, handle_cap_grant()
and fill_inode(), are covered.

Fixes: 31c542a199d7 ("ceph: add inline data to pagecache")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---

- rebase onto ceph-client.git testing, where ceph_fill_inline_data()
  was converted to folios; clamp to folio_size() instead of PAGE_SIZE
  (reported by Alex Markuze)

 fs/ceph/addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4a2d3352a..3c7cf8a5e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2266,6 +2266,12 @@ void ceph_fill_inline_data(struct inode *inode, struct folio *locked_folio,
 	doutc(cl, "%p %llx.%llx len %zu locked_folio %p\n", inode,
 	      ceph_vinop(inode), len, locked_folio);
 
+	if (len > folio_size(folio)) {
+		pr_warn_ratelimited_client(cl, "oversized inline data %zu\n",
+					   len);
+		len = folio_size(folio);
+	}
+
 	if (len > 0)
 		memcpy_to_folio(folio, 0, data, len);
 
-- 
2.43.0

