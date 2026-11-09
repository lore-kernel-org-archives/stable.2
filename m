Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193584;
	b=N1GPM8nhrWMZwCIxK341JVkb6nmxMg0xUDzOA0zknRT7TchYtjykG+b3RXkj9s2eRVMg
	 C0lWjeh5P/+I11ThzY6GuD2t/O17H1YOyBLw42WOD0BVMy9vSRq8Rb7y+HGRVWc38V1Id
	 BVmcRtGi+Q3dzShHsrUkh72QClZbvcF5/q7KGKzK/JeDNtB89+RaX8nI07mRp9EVca+Ki
	 oZDZKSEVJT7uQEirkbS+oQ6/nhM6xisyuEGEa5D+/fVGqamn0/LSpQj5bGtC61wibDTBa
	 Aigkf5coghXc8AMJr/KCwIiWRYEaJhsVdKPogdhahUGgiIidZqS00SGxRt6OkU2gDIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193584;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=uZgKj4NUnXx1bEj+DnShtGTxsitlQAwqIFpOv4Vd/co=;
	b=CdVvrlMcPPbhYl6/e/7r6gtZ3K+e434TkBlEnPid0BTAaEuEy5Ait0bSMkYuEiGl252f
	 sxW11SZZZSi6sG3yRxH0wfyVGa8aX7MSpvlvF2UFY1D6IgZGvygpzkukTgq2thk5c9bEN
	 m6HtMNz9/SML+vbxVI3RcLNL6hulS1H3tIU+Ymevw1y6jEba3KUdMh4O4gvz75FpbSl/O
	 41zpIYchW9hc6P+wbMrx676fUTLfLDeuICWfL33dartMNgbC6MHPqpPOtZxGNhOHaWn2r
	 KFbkNzbnH8Z/zfZzz3Fm87Ws/Jczgd8EncHryexf8W0iIgvx94yjNIm4/eBfXreoooQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=aqUaU8n2;
	arc=none smtp.remote-ip=115.124.28.147
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948E606A32A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C948E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=aqUaU8n2
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193574; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=uZgKj4NUnXx1bEj+DnShtGTxsitlQAwqIFpOv4Vd/co=;
	b=aqUaU8n2iAMCH2jNgxapwGu+7ypSh5yWlwACFpKS++7pHrt0i4Rq3d+pdUOoodULwCBVoNif/yCDfNYAy3Q1XF9UMcZLybnitRzN+W0BdhZQuHfuikxZ806YRFUn/KhiedBCWmEJRUjsSacu7wbXhBfUBSTVQqEhaxk6scfUfKQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0774473|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0114857-0.000187447-0.988327;FP=6645749621535934392|1|1|3|0|-1|-1|-1;HT=maildocker-contentspam033065158064;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jzjQmoS_1794193573;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jzjQmoS_1794193573 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:13 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.18.y] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Mon,  9 Nov 2026 11:06:12 +0800
Message-ID: <20261109030612.419344-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107051454-failed-6.18-9c1d14d3b66b@kernel.org>
References: <20261107051454-failed-6.18-9c1d14d3b66b@kernel.org>
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
[ Adapted for 6.18.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; dropped the client warning on trees without it. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 fs/ceph/addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index cfbd884..3cba742 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2203,6 +2203,12 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 	doutc(cl, "%p %llx.%llx len %zu locked_page %p\n", inode,
 	      ceph_vinop(inode), len, locked_page);
 
+		if (len > PAGE_SIZE) {
+			pr_warn_ratelimited_client(cl, "oversized inline data %zu\\n",
+						   len);
+			len = PAGE_SIZE;
+	}
+
 	if (len > 0) {
 		void *kaddr = kmap_atomic(page);
 		memcpy(kaddr, data, len);
-- 
2.43.0

