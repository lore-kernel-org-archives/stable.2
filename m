Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193589;
	b=vS+Ci3+FYSS+XHLigCI+lrr4M+K4V/GwnlGi5/pdrf2+QybvftQ75/RExtIV63/NaKj/
	 6oQm9Z8lDbru+76+M5N4OjvNlRMSspVCOF3FJoQHJt7Q9DBO5hGtjAh74cykOQ5WgyoHL
	 kmtu1OybhAt+GSIMoSwPiOHWQd7JPT8z1Jeb0ok0dpAzllkC+lC0F0JQt6h1/yL3kDcs+
	 Plo8AvmYf62H0gMF7lKCxS+O2iFovyGRse9smo5DH6ViYeL6LXBXImXtSer/WiYrzr59I
	 gx72ID90/RGutGr9mTpG2yLJuXOuVKoU2HTShL2Knu7ogLP9A6nF6Zv4jx1A5S0dSFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193589;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hOtfJ6199Jb0YALZy3Eb/EgmbHuB6jkFD329DhBpmjw=;
	b=kvqtfSs6Ypuii1ek8CKesK3wgAXMCmf5nLJAzL2ReWFkBDfZ7o2BMXvVgqoIiMRI67Yd
	 IyNw6vhil/M/DbqK1fk0f2PU38g85jyQYPwsFhJqDzWRrR8ciUH2ZfcIaRpo6lIpo1fLv
	 RLrttWIIxZ3gqjHGCnU6CsEZ5j+Z6h38jFxD8cWmKe5RUow4+JIBFqU75OoBL8XXNodrn
	 bvxwD7R5ZTjQKsQdffVifZ4lvmjUIR3JWzthL3UuT/YmB4l7Iop3uyszWASoUBJSk18tL
	 7YpqreLP4je95pBX2J7wd/mek3hhDyl0UjzRg+BJp3tVXDlNRhb6l4ufzzlpMXLrTAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=UMKfh3YF;
	arc=none smtp.remote-ip=115.124.28.74
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F29606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0F29606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=UMKfh3YF
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193581; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=hOtfJ6199Jb0YALZy3Eb/EgmbHuB6jkFD329DhBpmjw=;
	b=UMKfh3YFsdjRX+6hPK+DKjVedLowKMSrdJ1P4MsaKngN3qLasA5cD8kWufkFQdH66eU23BdZ8hbZwzXPSa8Ie/OyoLocsIA2SAgU2NAGrI1Axfj1aljszsLkUgDto+B1/zpcz2LbFn9OO3tqSz+t6zBgkGOziA0epLuUAqR/WXo=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07773912|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00751169-0.00029031-0.992198;FP=6663763951325939704|1|1|3|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jzkMU7s_1794193580;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jzkMU7s_1794193580 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:20 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.15.y] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Mon,  9 Nov 2026 11:06:19 +0800
Message-ID: <20261109030619.419499-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107061204-failed-5.15-9c1d14d3b66b@kernel.org>
References: <20261107061204-failed-5.15-9c1d14d3b66b@kernel.org>
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
[ Adapted for 5.15.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; dropped the client warning on trees without it. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 fs/ceph/addr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 618ef36..0ccaf88 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1572,6 +1572,9 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
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

