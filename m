Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275812;
	b=0iP4bARaguURNqY8sNsQzETrdf6yanz7ALMl3d43SRqt/pihrrkSm3kLPdY0bPLb/CS7
	 T16ip7FmwsUvUSE0nJW/RWsOfuIu9GBh90ymEX2LmTOo4jG+7kWoA0LdPpnlbq6QWIJ/h
	 TjXlXWvYzKT6+9x/l57XX8mz3VsGvksLmF1ecXzIeJGS1xFQqx0ux9UsEGHSWnMQrY0Pt
	 aTqFY7e+QJ++GrBeGnNjQyaFdLHIh0t32JCvcR2EmWzowaQjeHoBZPawpBHXTz9iNIyqL
	 DgBe+DduVFnNfDHiRNAF6t4NQWlj0TgX2LVAXBnVj5jCfb8oSmHgWDOWH3lI32ppaVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275812;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=YnpkvqWeyaPYdDUZznKdg2ofw9x2azkTUDp58GQdboo=;
	b=4vKBHOFeo6e/3JqnD8FRm82y5ThKBZ/druM5Kc9xjMWEC9ynOx2vn6+B0mWMEP+EkhIz
	 RF9wCZIwyaLtvxaXMf8cr8VXIro/PmQcIww8zZm9sHHIGxmLeN/P6irDAg0EZ9bMLAr+5
	 k56uYERMJO1mFPQv8/Q+h5Ke72dV+Y5v33kcR2ppLFkJ5NH2O2e0HNQrtTQWXiVBW+9W6
	 LRrSJo72IPZDwpAOLsOpAdC5e9OHHR0eA1W4KelX1MK6CB84yBD29Wmb/flSUb5iYRZzy
	 ZKzZuNOmwV65w41eS7s/62XxlO4JCrsDDIJx60zGU6LgFUbO1cCW+iKGOmfqOQ6HosQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ENKZyDjS;
	arc=none smtp.remote-ip=115.124.28.221
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372160A2606
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C372160A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ENKZyDjS
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794275803; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=YnpkvqWeyaPYdDUZznKdg2ofw9x2azkTUDp58GQdboo=;
	b=ENKZyDjSpch1nH+BEgzGYQorCtZW960466Gg5WrCMUl9lzeNGaGOsB9dxUCaLrTJGoI1GGnZ0K/xqIeQeat5ruQNv+UKeDnSEEWeZLYv1/c7kowOgi7xGKbV2V81BIW3qICLwK2Yj9xtk/tdiMTVNt3+ZTVeBNxna969/1f/Fd8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07715703|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0144926-0.000314442-0.985193;FP=6375533643885053944|2|1|3|0|-1|-1|-1;HT=maildocker-contentspam033037034138;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.k-TYj4r_1794275802;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k-TYj4r_1794275802 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:56:42 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.10.y v2] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Tue, 10 Nov 2026 09:56:42 +0800
Message-ID: <20261110015642.469487-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109030622.419531-1-zhugl3@xiaopeng.com>
References: <20261109030622.419531-1-zhugl3@xiaopeng.com>
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
[ Adapted for 5.10.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; this tree has no pr_warn_ratelimited_client(), so the warning is dropped. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v2: drop the extra indentation level on the added if-block
    and clarify the adaptation note, per review.

 fs/ceph/addr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4e247e6..bb9f13a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1717,6 +1717,9 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 	dout("fill_inline_data %p %llx.%llx len %zu locked_page %p\n",
 	     inode, ceph_vinop(inode), len, locked_page);
 
+	if (len > PAGE_SIZE)
+		len = PAGE_SIZE;
+
 	if (len > 0) {
 		void *kaddr = kmap_atomic(page);
 		memcpy(kaddr, data, len);
-- 
2.43.0

