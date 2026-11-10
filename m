Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275807;
	b=Fqm8reuyrJAVvJVeT6eLwNPVz02DDYf/aym2x5hud5oXo4mXVZ7KF3ER7pQikybCUAyy
	 WvLTM5HILJN8ATorsFBHSFDWYTyJF5Sz3oSLClvbu6cFH7hwnSqkz2T9rUcd/Xoa2V6VO
	 vNh2bsZ7vJD4wAPzhMcMTCBYyeMr3pVqoCXS2Hh9xtjUuvom2rBHc+v+lWq65pVEocNth
	 EkhAtWQIueQY7rS10dC4v6i3fBCPN8lpJhdB7PVNxy4ITCr+c+aMoyLXJSwbdG/vtdoF9
	 sSDdZTdU+xjO5BkVWD9eJnL+tW0GMp4fMI8tfmEMlALw+1PaPg2QwNqAwSpapcUNKZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275807;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=frJ8Iryj5Q06ECioOPVewntvLSkUnaIeXAxS4yWvF4A=;
	b=2o3UvbIaG8pegNgIMlRr3QCIGpWPkPrvmDorzVy/ZHFjOgMdbUrb5odiwQYyCM7yGd40
	 bB8hG3aXL8hVqT2AGmezQRIkxuQtC76419XU7icvRGamcWXy+CKke8Urw/rs66oKN89x2
	 qaCULX7hMEgn4hieaK0YthrsbrWMt1XD4bHtgW2ZIKrQPj0weAXGRpMr4fXocwYSu6dWo
	 Zm4X8XTuqFSj44JIL2HSUv0+VihVYI8QqEYTYbo82W8f9y2kzxFHkNOsUsHr/2nRG6117
	 mW4AkIQVo2ZDB9bzjGerV10AsxTQCtcxGQq3+5VovrTi+0pNS+/NFBqbDLlGqe0pVhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=pqjPCYyk;
	arc=none smtp.remote-ip=115.124.28.145
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ECE606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30ECE606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=pqjPCYyk
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794275802; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=frJ8Iryj5Q06ECioOPVewntvLSkUnaIeXAxS4yWvF4A=;
	b=pqjPCYykJBypAREKKnddy67a4k/cS7zTNUz6k6EHN+9ctam+93TCDug/pQOe0m7If/ZsedX/aW5t8cppxUws68l+avcUoanyFIC05eSwoljpiDVkR8/X+Xh3Go5Cd0ZVGSs5ifUYav0KIk00ObOmqRx6p2CR4OECiqF1LsaeAYE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07769714|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0146064-0.000325806-0.985068;FP=6663764020037031928|1|1|3|0|-1|-1|-1;HT=maildocker-contentspam033037034138;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.k-ThS2i_1794275801;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k-ThS2i_1794275801 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:56:41 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.15.y v2] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Tue, 10 Nov 2026 09:56:41 +0800
Message-ID: <20261110015641.469474-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109030619.419499-1-zhugl3@xiaopeng.com>
References: <20261109030619.419499-1-zhugl3@xiaopeng.com>
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
[ Adapted for 5.15.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; this tree has no pr_warn_ratelimited_client(), so the warning is dropped. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v2: drop the extra indentation level on the added if-block
    and clarify the adaptation note, per review.

 fs/ceph/addr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 618ef36..0fb3fdf 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1572,6 +1572,9 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
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

