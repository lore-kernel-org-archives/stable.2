Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193591;
	b=IYKqp+fMZ3wp1GSXncgVm0UPBeDef7KDOjJQ5L8IMEQMhDZBbzzUg0Pl4WFB6nWcBlag
	 1ZAeOMOdo8boghknuPThA0YeqjzhPAYe8kgBLQQny9dqBcNhzKCYev4MQnd8Cn6pkxPz6
	 gCliYVtvcWsawtcebab7kfqXP2CYCCVMFrQld7UQcAi8FSuG+3uBAIfUNJMgY5TrR3lhy
	 MfUG9ime81zuD9ptlpzf2DsyQqUmoVZbojSL/iJ5LmvHLB+gALhscvDWqDn5wgjXiemQf
	 O99bHhhsXx+ImzKYp45qUsbQDeZjKWeI90gDFC9czq4DXCrrQXEKnMO9/pIy0ihippw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193591;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=grxHAINc6waGg9qbkLReMHHfvZmbDHLONMoroDeoijM=;
	b=NB/47mt77uWFkU3jEDs4PI44eX6KZAdQv3FZcYILN6LOktSzyH4whZPXKmktlpU7cyg6
	 X/IBe8B7U2jUN6nI6BItyYefoKTrdqVA3YwcZuwp4bEkhFcCGSCsVdUhczNXCfwfVeE8O
	 WQo6zG+ig/QhGU8x8DuMY1VEncc0JaYiBiHlyQxEhLk22M9LjGTJLHNm81RMB+RU8myJN
	 4h0oSX8WuXnajyUJ38nP8SHKAPmrVNKaEWOoAdbBS25fyB4P+2Bt2oON2NxkxEIOnFmw4
	 zCw0jMMwFjgz+YlEwlWwKMJHeXmcuO+FqDQhEL6D/2/Rg9yxl2pYjCT266bgndiykOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=rRTYzL1v;
	arc=none smtp.remote-ip=115.124.28.74
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B6606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 913B6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=rRTYzL1v
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193583; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=grxHAINc6waGg9qbkLReMHHfvZmbDHLONMoroDeoijM=;
	b=rRTYzL1vqSbjU/doUTIQikGX/xffcvffDYjeviz2xRRDwa6fNEsLLB0DgjaGPvS0LRamTO16i2PMMBjPw4DQD0j7fi27xMcvpNiLuIan5BPjQ5KH44vj6DGsXLliLD70I9oCCQesx/Wt8LODuH14s5cFQ/ylu+bJQz6az/TqsF4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07726011|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00746929-0.000278459-0.992252;FP=6366526444630575032|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jzk1BHn_1794193582;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jzk1BHn_1794193582 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:22 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.10.y] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Mon,  9 Nov 2026 11:06:22 +0800
Message-ID: <20261109030622.419531-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107062903-failed-5.10-9c1d14d3b66b@kernel.org>
References: <20261107062903-failed-5.10-9c1d14d3b66b@kernel.org>
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
[ Adapted for 5.10.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; dropped the client warning on trees without it. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 fs/ceph/addr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4e247e6..334ed44 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1717,6 +1717,9 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
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

