Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795836975;
	b=qbYVzuDsqcjncC9Kl56zf8zgfCudlgwbeUi/uD7GigskWY2GqmimJAfTDuUZwNtRSGpl
	 m5JKBdKet0LarwpDyWO3hYkKkpXtDO6N1wWb28EfST6HKefjzELFCM6D2a6gvWWnESVVw
	 DIEwU1fSfHEF+yWRbMr20qOb7tl8NNz/CA+ydq71HbLu74QJn7Hj0MxiFcAC7lwvaQu9l
	 NVyMcGv59pKK3qEwbu9fWGU7xxSkT9nEKvsyxe9Y+9z4NcST0QJGcuGjzDvhJ9t9eofzg
	 yO2uJRkpJ8CEQn2SRvNuQnGmE2NMkmdfmJFRVoXKsKNloh8LeJNZqxuugv77pm3vYnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795836975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zpen4d1kkqo7HxjfJn3mlnlDWjSkeh8lYu4nl7L7jCU=;
	b=exs7x+QasnYAXW+wjwz82GK9NeEetfTNtVSQ/BqLWqiGLCXxswkRUtuoF2x1CExaTjWP
	 1e8PKfgY+T2qUjNk4LVe6tmZrd2ZQEb6vQfaHMkSiD1PPOIa0xqJ2idjOvLIwdjTr687A
	 gmUOnGUB/zuOpRDkm6RcGUaPbezFJipuXNQtGcF9fR3evMgrLH836pUFzBrQ9ZBja/LjK
	 WkR2QhgrWpn6hZPSZbU6/Wqe2T0L6hPy21P2YtD6EMxnSmSxmHL4hJp5swiz91RJ5umS0
	 UAVaHBx1FYEfjkaYV5kwDKR/2C4DveYCZQwBv3qUnNwPBYshmdcXJo0f1yzwcGHenpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grJoWkjR;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C58606A31E
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 03:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C58606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grJoWkjR
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b546061d58so20369766c88.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 19:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795836974; x=1796441774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zpen4d1kkqo7HxjfJn3mlnlDWjSkeh8lYu4nl7L7jCU=;
        b=grJoWkjROdHFwhnP7DYe2eHRpWDyKsyWAmEBV4wgSBiy/r6+1wUx4M9gHG4uG+KDlY
         62vdweFhtIafSHfPS8Z4TZIHcNK/GHkoGW0fvOS/oqln/2czexKSGtN7rGTtqAMW4XRX
         8bpTFjwECr2h+cE+ZkaNuAgA4KQmTJCLAv4w311b8XHsmtfuMLfTDu8ly3xrrXoSIxeZ
         4GVckzkrRBaOI/f5T8+ht8TpHDISkCQiK6BGj3/AmN2V522lrQK8y2QJ1JgEV58ucfxH
         UlEdm5Tc/VXol4FGpLOb74YHBDO4xdEBDrQjY3p/NW4O3cRpuMB7OKc2D/4Nz9TcynqG
         8WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795836974; x=1796441774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zpen4d1kkqo7HxjfJn3mlnlDWjSkeh8lYu4nl7L7jCU=;
        b=vEYznQCOxxa9F0hBCe15ml2HLuncjKyYDa5NDVqS6cfp20nSyDjE0P/FZXPgZ0bV03
         M45mjkAlA2Fr8Y0ijewVio+am+dnWGOg365VFSDXZzcvYc/pi6Bt4IiSg11V58cDEr6j
         N2WEauoIiU6ZRhV0yUIfUk4gJrWEXKRs1DARMv3BEYuPttPW+CwrdsI0ESP6D04eOZ6p
         LkwX+D8YRmEmwts/yYwy4WsmxWrZlDHJEGPPlr8YDSe+aWziM2/4pTK5jUaoArS8wyL2
         54gOAKTEnDrnEDEKUWk6xzqgjTaOJf5B93rQt23WE7CxA/hfgoxeuWG5TnsR9EKii236
         tLQA==
X-Forwarded-Encrypted: i=1; AL+hErEHe8JV9qBLMpGCzc2qsiwHbU8jxEWPsJ/j8Tv0g35n7Mr17Y1dzuamLSMpFuAnpbCZoTE946c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/x+BI+5+p/qduDSpnAY3RD44OHAQc1vwKV0iMVnBkRkSQ7uKVW
	MOigkNYNY2jQxtLguRsG7v4CaO51pg576ypDIKpxJd2+mEPnlSCATTTE
X-Gm-Gg: AZFdTZfVSjLBytci2ysaf/ydFG+B/zqVJxqQt25Y/e7QG+YzyqBIisP5xJR0O5rqNNF
	dbOplTjtiSnjD9ENmKZYfoW4uRqUfG2SdOfctH1rIHx3e1UkCrWrWytvbH1LkZSzMPgeZJSedcM
	zcWynboUORgnq4IAP2yx39AYhKhGCRdDrucT9wZscACGgCEF+fWVhOXzel3Aj266dQx4EMzum/+
	BKTFhQLmkXzxtflUSqVOEfL0DavTHC/9ChWKBtTlhPmCKFssUSKf/9ZUamB06KkPHPfsmW/We7R
	RrRFy635x3fwOXONQfJb7oIzynFAzlvhtjwgDGxiPf8n8tPEmmXIHKfRnMulgsU+vVYhctONqM5
	JxSS5xFM0mUz6g8YERR2QCKKlGQqz/MTW7xHUvv+vs6WilbtrBC/xioZJI83AFs2ANpl6mSYlsB
	vLJZ/yVqDzeCEVFHsiyirdI2n7qpT/5mrnmyf1P7oWN0bnJWlUrgDy69WNyGdSRlbICMHUAWGae
	ko5UY0/+duvUtXKSZQ/vOUcq9s0yyKUPX+TIeHXnKm8O7DyK2dcvplyBooPNWoBPBC1QUnJnz2A
	sIQ0OIDYPbgP+LC4f+mdnY5NmjfQW75GmjmKnnn4ZzEF4B8DBbqhkKfmxIGFdwKnPKE8qNx+4qG
	Ngd5i0dgnAFZp4Z1fzPswoNOtcQfKBoHC/U29DhFhFAhRKZIlzg==
X-Received: by 2002:a05:701b:4308:b0:165:aced:1fde with SMTP id a92af1059eb24-1b56f87a910mr17234011c88.0.1795836973825;
        Fri, 27 Nov 2026 19:36:13 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:5070:1d3d:1d30:e241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm62036381c88.10.2026.11.27.19.36.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 19:36:13 -0800 (PST)
From: Ozgun Kultekin <ozgunkultekin@gmail.com>
To: colyli@fygo.io,
	kent.overstreet@linux.dev
Cc: linux-bcache@vger.kernel.org,
	Ozgun Kultekin <ozgunkultekin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bcache: don't read more than the buffer holds for a btree node or the uuids
Date: Fri, 27 Nov 2026 19:36:09 -0800
Message-ID: <20261128033609.42213-1-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bch_btree_node_read() sets the bio size to KEY_SIZE(&b->key) << 9 and
maps it onto the node buffer, which is PAGE_SIZE << b->keys.page_order
bytes.  page_order is ilog2(KEY_SIZE / PAGE_SECTORS), so it rounds
down, and nothing checks that the key fits in the buffer.  For example
a 1023 sector btree pointer in a 1024 sector bucket passes
__bch_btree_ptr_invalid(), gets a 256 KiB buffer, and the read runs
past the end of it.

__ptr_invalid() also skips the bucket_size check for pointers whose
device index is >= MAX_CACHES_PER_SET, while bch_submit_bbio() always
reads from c->cache.  Such a key can be up to 65535 sectors, which is
larger than both the node buffer and the bvecs of the bbio.

uuid_io() has the same shape: it reads KEY_SIZE(k) << 9 bytes of
jset->uuid_bucket into c->uuids, which is one meta bucket.

The btree root and uuid keys are read from the journal, so a corrupted
on-disk key makes these reads overrun their buffers before any node
checksum is checked.

Reject a btree pointer larger than a bucket regardless of its device
index, fail a node read whose key is larger than the node buffer or
the bbio, and reject a uuid pointer larger than a meta bucket.  Keys
that bcache writes itself are btree_pages * PAGE_SECTORS and
meta_bucket_pages() * PAGE_SECTORS sectors on device 0, so they are
not affected.

Fixes: cafe56359144 ("bcache: A block layer cache")
Cc: stable@vger.kernel.org
Signed-off-by: Ozgun Kultekin <ozgunkultekin@gmail.com>
---
 drivers/md/bcache/btree.c   | 13 +++++++++++++
 drivers/md/bcache/extents.c |  7 +++++++
 drivers/md/bcache/super.c   |  4 +++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 27a129d47d0a..bbff98661494 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -248,6 +248,19 @@ static void bch_btree_node_read(struct btree *b)
 
 	trace_bcache_btree_read(b);
 
+	/*
+	 * KEY_SIZE() comes from disk.  Don't read more than the node buffer
+	 * holds, or than a bbio has bvecs for.
+	 */
+	if (KEY_SIZE(&b->key) > PAGE_SECTORS << b->keys.page_order ||
+	    KEY_SIZE(&b->key) > meta_bucket_pages(&b->c->cache->sb) * PAGE_SECTORS) {
+		set_btree_node_io_error(b);
+		bch_cache_set_error(b->c, "btree node too big at bucket %zu: %llu sectors",
+				    PTR_BUCKET_NR(b->c, &b->key, 0),
+				    KEY_SIZE(&b->key));
+		return;
+	}
+
 	closure_init_stack(&cl);
 
 	bio = bch_bbio_alloc(b->c);
diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
index d626ffcbecb9..9ddc90049623 100644
--- a/drivers/md/bcache/extents.c
+++ b/drivers/md/bcache/extents.c
@@ -153,6 +153,13 @@ bool __bch_btree_ptr_invalid(struct cache_set *c, const struct bkey *k)
 	if (!KEY_PTRS(k) || !KEY_SIZE(k) || KEY_DIRTY(k))
 		goto bad;
 
+	/*
+	 * __ptr_invalid() skips pointers to a device index >= MAX_CACHES_PER_SET,
+	 * but btree nodes and uuids are always read from c->cache.
+	 */
+	if (KEY_SIZE(k) > c->cache->sb.bucket_size)
+		goto bad;
+
 	if (__ptr_invalid(c, k))
 		goto bad;
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 97d9adb0bf96..fd35e4b76fca 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -458,7 +458,9 @@ static char *uuid_read(struct cache_set *c, struct jset *j, struct closure *cl)
 {
 	struct bkey *k = &j->uuid_bucket;
 
-	if (__bch_btree_ptr_invalid(c, k))
+	/* c->uuids and the bbio hold one meta bucket */
+	if (__bch_btree_ptr_invalid(c, k) ||
+	    KEY_SIZE(k) > meta_bucket_pages(&c->cache->sb) * PAGE_SECTORS)
 		return "bad uuid pointer";
 
 	bkey_copy(&c->uuid_bucket, k);
-- 
2.39.5

