Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275810;
	b=Mss55KZV5wT983+3CNofOFxuekJGPiL5rYTJWbdN64zfkxTac1DkEhUIHoUm526/GlO9
	 kzGDvbGKzVDzBLeRFKKjQmyau14OY0/mZuK9+EGp+xcOTtnB+/8QfbbJvMHOtGMcXc+UJ
	 zhaD6BjRDClnBZtjFzd1jGlUYk1SwBs0msdGloAE8mS5gbX70esfZKJa0vmIaV0eZYlSr
	 bJGyK5wT6E6sm6rf5BUhuWuigHtS/G3wNhEjjCY0LrsDBDHkkPKFMjf8qShBfrrQ1FA9y
	 YNHf5FwrRRZP9uO2pSQUHJ9I9DY9ZKvz/DZrL3ZOpcdyvaNfvq23DLiz4LuLGWTHlTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275810;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=OpaMTdVlcWiTJkzha674msolX8Dr0jiVpCgmnUH8AJM=;
	b=Unq7ajNLPOXV7jAQdbUCHSP/Dh/s1hLtCY6iVXMDXj2w+0J/uj7vmgJjWbVdrvu5AiYC
	 3HZf4bNYzFsSl75aiCLDhrOd1y6c/NdFhgC57LxQj8NclY6gjPOxJJlB0DNtyIwMJNjeG
	 jzeK2LNJCBlpV6MGuSHI4CshtADi+uYG/C5JeaM35+TuI49FLVkX2Q2Dw2CNj9HQ7hsAq
	 Z5IJesvvAE8zCj9zjpZm0QwjBDJurcuIPfVnrIyJRLtoSJcls3twej10WP9x2AZ2pUJ6h
	 u2brFGs3ncyZvtui5jwMFN3udPoSuE0lC0/eXvaLQkP9PV7uLnw/68uUU9SWmJy1l2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=WAlT3dWb;
	arc=none smtp.remote-ip=115.124.28.193
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89391606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89391606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=WAlT3dWb
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794275800; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=OpaMTdVlcWiTJkzha674msolX8Dr0jiVpCgmnUH8AJM=;
	b=WAlT3dWbEw0o7steBfeia2lnPHMOFkQZU5BZJfqvRf7mwvNwaUDCB3RPK92ZtNuCXakpwkKn1sxYq195MB2avwSfOIGQvJuJej0QG5xNlEjHWSDpUpRcfAr+Q4c7KEcXbN/ecDTUznXnaJZwgZzEvmGOHdzvhLP5fCezPP9lM5s=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07519609|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.142357-0.000670672-0.856973;FP=6645749621510768568|2|1|3|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.k-WyEID_1794275799;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k-WyEID_1794275799 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:56:40 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.12.y v2] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Tue, 10 Nov 2026 09:56:39 +0800
Message-ID: <20261110015639.469422-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109030614.419384-1-zhugl3@xiaopeng.com>
References: <20261109030614.419384-1-zhugl3@xiaopeng.com>
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
[ Adapted for 6.12.y: folio_size()/memcpy_to_folio() → PAGE_SIZE and the page API; the trees with pr_warn_ratelimited_client() keep the warning (7.3, 6.18, 6.12, 6.6) and the trees without it (6.1, 5.15, 5.10) drop it. ]
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
index 5e0f83a..6d4f98d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2162,6 +2162,12 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
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

