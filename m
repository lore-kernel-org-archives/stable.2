Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193583;
	b=X0NhPHxmzRi5uBPOsp0iFSxFRhr4lFgUNyfWoQHfWVzQrqIyKg++yjlDRHgl80hJuCYO
	 uZ3yh29VZEIMj824dprOB4NQo1mvqWPpq8EKhHlGYTSxbr5KY6Ycr2IKxkZWM2n0MToXM
	 E1pSVpcdwW/JmU/QSJf+msTx9FQUByAVOjyDJD+YJIyJdw7ZhB7HIOHsC3fFCHG1pzPPZ
	 kKFwD8HvRTPfefpxGzBy7ROEWc3IhQi61ohSBv/shSaoC042HjyoKgbzocHwckVYtZeoW
	 Q7AfcynDfrQjNTlhOFVYOLlGNJhTuxbJ0VbYL3kvpU8JyPwJ+M1nPlRpwMs3J0lDgQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193583;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=4EH8DPnTC/nD0J6kSWqJw2miLXiK7D6aYBaY29VTsD4=;
	b=TdBEzufimOyYcpCegf8v7KTKwx+hLOITFcrb8h0b/GlJiA7FeQ3riGVyzLuV5Q6tqn8b
	 WoKLyNHMCVGax2NPSHD4oJYqZ34XXRNh8YJ7P6cpA9+hvFz/uxfQEUGSqhKhenjZoX1Mv
	 /PnNi72NcGnwzCuamBx6o+JN769aEJaV80UWt1bIZzN/2Qiaqxgy5gKj2pl+RUfzanegU
	 D5KdLdpDNBO78wcnRGTHu+21fAujhLG1hysSkXm9CjuDRsUlU13aI6SJCIpAM5bk5ZLer
	 HNraMzpC54MRtMS6hcG1EqQgCbuaP91b8V+imYStqHmGaUIE5lRdag4qXSrMNA6k9Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ZBCkQrrT;
	arc=none smtp.remote-ip=115.124.28.217
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE684606A326
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE684606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ZBCkQrrT
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193573; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=4EH8DPnTC/nD0J6kSWqJw2miLXiK7D6aYBaY29VTsD4=;
	b=ZBCkQrrT5z//KL0+YM+n9Ce1rGXzAmDrSOil+IzQ6WaPX/LfuUOqHeozjMfnGKQhPzl64jz6UZXzbcSbdjRg+Q0H7RwrY59POqAnzncl5T6BdnHbATiy6a0qoCARY+iIqA3jM80g2FST84Wb4QFndC88tlbb3z3SI6lSMmziD1M=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07769377|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0114968-0.000187869-0.988315;FP=6348512046129481656|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jzgGvV0_1794193572;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jzgGvV0_1794193572 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:12 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 7.3.y] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Mon,  9 Nov 2026 11:06:11 +0800
Message-ID: <20261109030611.419331-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107050541-failed-7.3-9c1d14d3b66b@kernel.org>
References: <20261107050541-failed-7.3-9c1d14d3b66b@kernel.org>
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
[ Adapted for 7.3.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; dropped the client warning on trees without it. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 fs/ceph/addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e598b2d..92603e9 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2209,6 +2209,12 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
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

