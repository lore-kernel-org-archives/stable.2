Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275803;
	b=YXZ4CgrCbPF9AOXshw31s77VfzE3/9PK1fHvxc86sowV1Ze9XCDlk4Ylyx5+kS1aVAWi
	 xnHF3HAL9foScWxXsjJgI4juRNqqolHasxvI4pdY/Qwfj7yaSq12GjbUbaUyS3jOutSOA
	 jf7aiHWCWl3FY0FRyl6UT9RppK3gC9oY3iJ3WRQCoxF3yX8KVImJdbPTV0WwjDfG/y9bg
	 jIVmRVIqIXIkslaDDwxd9bJe0DdZB/xnHcWK2yQHVsXSKrDeh18DnHajthdB/5XCzaWSk
	 Qp6s17yr7ndl2AQOwgOS9J1lwMV1BTGyjIqq0n7p2mgOeiJ2ar9hjsjtqSEFyLMtvtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275803;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=LvJjo3aq3LVIbYGLQbbB49XqibrBTaCDizFKFPy5Dlo=;
	b=hwsXyyZ+DzMc2y2/DtzPwMqgd6zdjBt6ADEZuLpcTy66HeVlOQ3QrPI4qdh6rSgouHga
	 2Q6rhBh5NqbL1cJxUTQ8BgTrpduuaX3eKqxdaXtRIX3VPHlgkiLoQkVxPrIHuirZ2+p+z
	 NPzhtY2qvZJ2K/h+OVVX6I8z0PLG/ueTliCtnDAoc6UL1S4fU95jsXNgZ/E/JsVOeibm5
	 Jdl2sGy7vUDnxLkhHnkgIu4kjU7cDtPmedtpTT0ZXOteAI8+oNFAmWy17YcBkjjJykYNt
	 FEFDzTkm1ZBzDruo2LwLpMri7RMus8W7fHNbFgZfw3kwQ0EzA1zwGt/G2J/5nQEl0rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MzsFQiLD;
	arc=none smtp.remote-ip=115.124.28.97
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD49606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD49606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MzsFQiLD
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794275799; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=LvJjo3aq3LVIbYGLQbbB49XqibrBTaCDizFKFPy5Dlo=;
	b=MzsFQiLDJGVtCJZFhpLVN3QjFxBBh1LdnNlUv5yrDoiqLw4KfYvwqxUGHlOrjvWNZiobyF8RNwiLWS0oXTYS/NPIZlwVwQghh9I9b0BuCzyijNm426rRyUAglrHwnZSzbaiRLxD1BMEaJ/UQ51Gu6iwW+5RBebIS4EIWNfqUYgY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07529649|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.142357-0.000670672-0.856973;FP=6645661660580546488|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034254;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.k-TpqV5_1794275798;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k-TpqV5_1794275798 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:56:38 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 7.3.y v2] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Tue, 10 Nov 2026 09:56:38 +0800
Message-ID: <20261110015638.469378-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109030611.419331-1-zhugl3@xiaopeng.com>
References: <20261109030611.419331-1-zhugl3@xiaopeng.com>
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
[ Adapted for 7.3.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; the trees with pr_warn_ratelimited_client() keep the warning (7.3, 6.18, 6.12, 6.6) and the trees without it (6.1, 5.15, 5.10) drop it. ]
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
index e598b2d..3cad3f3 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2209,6 +2209,12 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
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

