Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275809;
	b=TR6xn/twPuBmfoROBNAAlnFoE4W2Ip6xbT59rewnc2cnL8seF4yg1WExSI/rMHsWiKSx
	 ktdFU3rfwGTWkT9/vtHh2hVWmxPDAwUGXxFzPUYJXTLIGxNKU+BRzGKiCAS1bj4d2hf0Q
	 4L6DtAt5Se/VC2E51PagiW65dDDVXo6cwuGk8rRV0JLz+GHLTaN/LW7drreND1dcVRme3
	 LDdOm/GxYT17OeZBZUaL8wQLziU81LkChNyH4QReUFDGVthlRCPPUmjrjZ0MFQeJIE4BT
	 78sCSMu2M+mXu6KFzS1u8UyG0j2ywunF+moJRWxr0djplEzQDfar9ST5AFJjhC0NVsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275809;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ip1/FNU3wBBfjj5PoWWGHRKXpGo3d4IfC8zyDvgGu/I=;
	b=4Or4c9M5jYFDhjVAeQMhJ8d+NfriSfISw6qIBWW0/UJBIKf1h8T9+4dGBgLBO2Nzb9BW
	 1ULTpN2BZ9QvV1wRxehkqqS116i/Fw6ZaOZMdGpaGwVvMOuOIqlqy1MZnQZ6q+ipXv9Ef
	 11VQ4ROoGLjzPuulGkzEqFIPCQlbMOLfRNft3YP48LtNGMm4vdv3+pwTZuOVhRpIg2MTE
	 FMz8gSNeJa1pKJJWFdFyre+IclQgl5TqeLiwI+K27HTsZfIaJIED+qXYyQ/xqQ/u2sAmO
	 FjgsdXqnYYz5lwf1LddwYi7R1SHDJY9+cCmZ9uZjO9fC7A66AuQaGJ42rIIYC1sgArw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DM4PnrqF;
	arc=none smtp.remote-ip=115.124.28.171
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB1606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6DB1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DM4PnrqF
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794275801; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=ip1/FNU3wBBfjj5PoWWGHRKXpGo3d4IfC8zyDvgGu/I=;
	b=DM4PnrqFelapunz1IdaaPYBbQtDdg38wmlxhFhBlqffb4xrasR+8PrklhKtjfpz6h/SAtB5rgOuSRKcslKJIu3RwSD0rHmtUTII4bggQLIIw5F1Y9CIEJkcKDrh74DPL38VVEYCSac5rL8ZtYPiuDHCbeDxLlOyHGN2Pof8ytms=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07511362|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.140015-0.000657105-0.859328;FP=6645732029324724152|3|1|3|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.k-U47rO_1794275800;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k-U47rO_1794275800 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:56:40 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.6.y v2] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Tue, 10 Nov 2026 09:56:40 +0800
Message-ID: <20261110015640.469442-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109030615.419410-1-zhugl3@xiaopeng.com>
References: <20261109030615.419410-1-zhugl3@xiaopeng.com>
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
[ Adapted for 6.6.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; the trees with pr_warn_ratelimited_client() keep the warning (7.3, 6.18, 6.12, 6.6) and the trees without it (6.1, 5.15, 5.10) drop it. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v2: fix the pr_warn_ratelimited_client() format string
    (literal backslash-n), drop the extra indentation level
    on the added if-block, and state per-tree whether the
    warning is kept (7.3/6.18/6.12/6.6) or dropped
    (6.1/5.15/5.10), per review.

 fs/ceph/addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a5b21f4..1dcf319 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1811,6 +1811,12 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 	doutc(cl, "%p %llx.%llx len %zu locked_page %p\n", inode,
 	      ceph_vinop(inode), len, locked_page);
 
+	if (len > PAGE_SIZE) {
+		pr_warn_ratelimited_client(cl, "oversized inline data %zu\n",
+						   len);
+		len = PAGE_SIZE;
+	}
+
 	if (len > 0) {
 		void *kaddr = kmap_atomic(page);
 		memcpy(kaddr, data, len);
-- 
2.43.0

