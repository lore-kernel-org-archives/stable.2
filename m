Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275810;
	b=u4QH0rGwy5kKl7PiZhxuY4ub+Nj/lwX8R3yRN0NMsqkCqsWWB2EDCe8PSX+/p8G7F1Xt
	 F4kBvKoLnTJogubRvDVHXcNGABaMCgIViMUH0DXeyTvJQPJTeNoOduL9Gl3BkRHBWHLU7
	 NQoZU3iGTfovuqsHziUm7S92Pud9Eme+yAEVMWQVBUxbO39eH1KZm3p9/vy8zjqPzVjft
	 AJ02A7xdKQWcf07qXcdE/KMlN0MoAHlDJ1PrRkvCsFFM7hYR/tBb4L/FbrrgZijtUOgqp
	 xbpnLq8UUpL/ViaXHUmNEmKIH+VbkDGMza4IsKTTzFJQgLBUmAsPEBm5BYzmcNFvh+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275810;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=nbm0B6s0ILwujbwbqsBKLWcQ4QZdx0YYUTEt0rq0knU=;
	b=rosRpI4jtp8DMYZbYvn50XWUpndnLxT2BGP7c+0mOtnopM7N0YDnS1THdQ6WpYMf05Am
	 QFG5xq17Sbbenx1ueHQbgx+1gGdLcYRzBC1ZyAzWERDcryBM25/uR6XgsEE4VyHtzU42k
	 QhXBu1vi0LmQvl0wNnOinuRzDmB1Ydp0xXtuS8bTljOxlNQmr10cJw0IP1V9hKjanS2sr
	 EQtm5Pa34qMteKLiboeXZT2n5zaFMzK9vsmcO1/eH2O3vNTQKH3Iro3xR3Os45V/9UlNh
	 VxAQgYksJo0/3kmyasWQgqxGDEzojojeQEgJEXG30smTBa7T3shtmPr/fPeZiwrgz/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=seBVqzsg;
	arc=none smtp.remote-ip=115.124.28.220
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB133606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB133606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=seBVqzsg
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794275801; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=nbm0B6s0ILwujbwbqsBKLWcQ4QZdx0YYUTEt0rq0knU=;
	b=seBVqzsgePbf3dNliJFrXxQ0M36J46garKtNg2s8KgrQ78PKB5g6n2M4CTsppfIsZj/QFQa31y6wJITSHStLvpbDeBPUROZ3GEY4FpuFrajTG8TOkQkv0+bso8Aj2V5hbKVtG9CcNhT3bxI/0eaycyNKXTVPNstU480f2rgoScE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07827262|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0183983-0.00029053-0.981311;FP=6663764020037027832|3|1|3|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.k-WboFj_1794275801;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k-WboFj_1794275801 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:56:41 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.1.y v2] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Tue, 10 Nov 2026 09:56:40 +0800
Message-ID: <20261110015640.469461-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109030618.419473-1-zhugl3@xiaopeng.com>
References: <20261109030618.419473-1-zhugl3@xiaopeng.com>
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
[ Adapted for 6.1.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; this tree has no pr_warn_ratelimited_client(), so the warning is dropped. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v2: drop the extra indentation level on the added if-block
    and clarify the adaptation note, per review.

 fs/ceph/addr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 9f664a9..bf57b09 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1678,6 +1678,9 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
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

