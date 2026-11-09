Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193586;
	b=Z8JfOBxUvesFJGxXX/FB/2NaO81vzz3be8Q6xC8eh01H7axsvYILpYhB2s9ui3ARsPXk
	 hpwGoXgPppsbkn/3mL3Jmu14+Kk38ad86cCDcsRxNjUc5hqMhjfjI//vqtf0hRvgT+4RV
	 KAUMtJJvCaj4EouFDS9na+idaEjLOokixVfB7z2pHQ8KJUaP/XdPb86xUxF5CBmuuSbqv
	 bJ87H1E48d4N2UJF1iUAd6+K+Fg+hSaBW5YD+tGDgpjkSruFiSJwi0cSNqNLp0TrK5GRm
	 4i6zGE/JddcF4B5MWGhiP3TpA7ZDcxHrB0HvcfhdlwMEhRUjAdGRO8Gq0ZTvRKsJJ2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193586;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=tpx9Y6W6yn61z0LVuZO0MzgOW+Qr0mw0e1dC+8xSVXY=;
	b=B3gif39O9OEc+v8USZ3hEbZB0NEuy/3sUovqgWwfwKWmxuvOO0hEcoh8eFsWajbKtgge
	 O/7Sytpbx1zI2JhTQHZmr+XT7PIIXTBXLHGXpgs2xuMWYGtCUERflf5MIA8Fthezbkalj
	 P0QIO3qbDQ4v9MoaPwkPCNxuILPe/X2WudeBMJXi3pKvh7hLBnXzMVlNk0gZ0/bqeW/il
	 iMfd2mvVNnoBdEE73ZSsEIyrUSg0+LGdP7E3D2Tlhadv/ItZbM4RxsR4pIE1NLbfOuto9
	 n3++jNG0zpyzXVVgdH/4rnQ+ZC6ivX5I1d9kVRFejnidVG8QE+dWulY2ELzu/8/xiVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ZwHX447Z;
	arc=none smtp.remote-ip=115.124.28.145
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0287606A32A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0287606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ZwHX447Z
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193576; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=tpx9Y6W6yn61z0LVuZO0MzgOW+Qr0mw0e1dC+8xSVXY=;
	b=ZwHX447ZWH2ff8683OBSxNXKFA/0lemSa+bBs3K29AI/exEWwZP9eUyEMATCrV0RWk39obIG1teigHpP+5c84xJkB8Rb+aF91lLU0+BRDk1YZAlh333mXwoRPYq3sbxz158wIoYPqJbxSgEIWY8T3LZI+ksPfmz6M0uZuXU+ZbE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07736517|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0114469-0.000183943-0.988369;FP=6645749621535934392|3|1|3|0|-1|-1|-1;HT=maildocker-contentspam033023087102;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jzk1B9s_1794193575;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jzk1B9s_1794193575 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:16 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.6.y] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Mon,  9 Nov 2026 11:06:15 +0800
Message-ID: <20261109030615.419410-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107053929-failed-6.6-9c1d14d3b66b@kernel.org>
References: <20261107053929-failed-6.6-9c1d14d3b66b@kernel.org>
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
[ Adapted for 6.6.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; dropped the client warning on trees without it. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 fs/ceph/addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a5b21f4..a1428ce 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1811,6 +1811,12 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
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

