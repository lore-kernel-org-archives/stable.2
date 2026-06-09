Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757C3B5851
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780977143; cv=none; b=I30Pk7jqtNHkMbzbIEFZieUKmsDjPcNUf0bJpb+QhcORC3o9TdQgtBlUzc3oC8hUwfU8YJFISlQEor609y2S5zMt5Lgv9LKk+LxAYutcpV4j+rMUyenvIrdn16uvfx98AEFsTwWzTDs2hiF7/wc+V+l5wY+zEJSv81Spe1RIBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780977143; c=relaxed/simple;
	bh=jwRa4RnwyG3Cv9znRhhMCZKS+ZL4NjyMCvlAlRL/6AA=;
	h=From:Date:Content-Type:Subject:In-Reply-To:References:To:Cc:
	 Mime-Version:Message-Id; b=Vchjas8IKw/uigYodu6N5RZFjnwlfGdFhslHokxd/tQu/briYYWmNUfa9AE6PZpYm8BiVjESJZU0fie3gmIUz0EPKF7N67KsPwspg0XnobqmTptvtommXyZoIIfgQxuVQ7fu7qtF5Nqq2VBv/rl5dmD9oOw7XhthKcIHaJERxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VP1sH01n; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VP1sH01n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780977136; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=q9OYAFf2Ae+rU9oAk/sAlQn0Ky5uPs8iCnag0ySFlgo=;
 b=VP1sH01n3sW9yZt7V47IXxsOlkku3RGsykMmZLqbYb49wOeRhR2TflgDM6rA1zVzMbq6WW
 dpPFh0A8cwrl8uYvQ/ZXFvykptKZ1xjxxHLD3gatSGoZ3JalG+EmQC4AyBklH+uwAwqGuH
 vkHkUwaf4+SaNrP98L2qg1qyQPvXmDBhGEP1GNRkxNm+EIEpCn8CbtajLBp7flKBNUzLqD
 db7UQ0OyHmRkUgTwPdhbo42FUINeNEc8sUyOPYTetKqAKX7IIao5EfQhed92ozosjpPGf1
 NNoABx9LWepMHvMWS+KfMGn9KPIXHecC2pJa+1Bqca/qVXe+es+PEJkqu+7/MQ==
From: "Jia Zhu" <zhujia.zj@bytedance.com>
Date: Tue,  9 Jun 2026 11:52:02 +0800
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v3 2/2] ext4: avoid tail write_begin walk for uptodate folios
In-Reply-To: <20260609035202.90669-1-zhujia.zj@bytedance.com>
References: <20260609035202.90669-1-zhujia.zj@bytedance.com>
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>
X-Lms-Return-Path: <lba+26a278dee+9f9149+vger.kernel.org+zhujia.zj@bytedance.com>
To: "Theodore Ts'o" <tytso@mit.edu>, 
	"Andreas Dilger" <adilger.kernel@dilger.ca>
Cc: "Matthew Wilcox" <willy@infradead.org>, 
	"Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, 
	"Baokun Li" <libaokun@linux.alibaba.com>, 
	"Ojaswin Mujoo" <ojaswin@linux.ibm.com>, 
	"Ritesh Harjani" <ritesh.list@gmail.com>, 
	"Zhang Yi" <yi.zhang@huawei.com>, <linux-ext4@vger.kernel.org>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Jia Zhu" <zhujia.zj@bytedance.com>, <stable@vger.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <20260609035202.90669-3-zhujia.zj@bytedance.com>
Content-Transfer-Encoding: 7bit

Ext4 buffered writes into large folios also pay a full buffer_head
walk in ext4_block_write_begin().  For a small overwrite of an existing
cached folio, the folio is already uptodate and the write only needs to
prepare the buffers through the written range.  Walking the suffix still
makes the write_begin cost proportional to the folio size.

Before ext4 enabled large folios for regular files, the same loop was
bounded by a single page of buffers.  That commit made the existing
full-folio walk visible as a regression for cached small overwrites.

The suffix walk is needed for non-uptodate folios, where ext4 may have
to submit reads for partial blocks, preserve new-buffer cleanup, and run
error zeroing.  Keep those folios on the old full walk.

For already-uptodate folios, keep the walk starting at the first buffer
rather than seeking directly to from.  This preserves the existing prefix
buffer state handling.  Stop once block_start reaches the end of the
write range, because the skipped suffix would only repeat the
outside-range uptodate handling for buffers beyond @to.

On current master, the libMicro ext4 large-folio overwrite test shows
the following full-series result.  Results are median usecs/call over 10
runs, lower is better:

case        nofix     this series   improvement
write_u1k   1.418     0.3405        76.0%
write_u10k  1.887     0.4175        77.9%
pwrite_u1k  1.6775    0.3390        79.8%
pwrite_u10k 1.9035    0.4130        78.3%

Fixes: 7ac67301e82f0 ("ext4: enable large folio for regular file")
Cc: stable@vger.kernel.org # v6.16+
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/ext4/inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c2c2d6ac7f3d1..0fccb8f6a2116 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1182,6 +1182,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 	int nr_wait = 0;
 	int i;
 	bool should_journal_data = ext4_should_journal_data(inode);
+	bool folio_uptodate = folio_test_uptodate(folio);
 
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(to > folio_size(folio));
@@ -1193,13 +1194,13 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 		head = create_empty_buffers(folio, blocksize, 0);
 	block = EXT4_PG_TO_LBLK(inode, folio->index);
 
-	for (bh = head, block_start = 0; bh != head || !block_start;
+	for (bh = head, block_start = 0;
+	     block_start < to || (!folio_uptodate && bh != head);
 	    block++, block_start = block_end, bh = bh->b_this_page) {
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
-			if (folio_test_uptodate(folio)) {
+			if (folio_uptodate)
 				set_buffer_uptodate(bh);
-			}
 			continue;
 		}
 		if (WARN_ON_ONCE(buffer_new(bh)))
@@ -1220,7 +1221,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 				if (should_journal_data)
 					do_journal_get_write_access(handle,
 								    inode, bh);
-				if (folio_test_uptodate(folio)) {
+				if (folio_uptodate) {
 					/*
 					 * Unlike __block_write_begin() we leave
 					 * dirtying of new uptodate buffers to
@@ -1237,7 +1238,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 				continue;
 			}
 		}
-		if (folio_test_uptodate(folio)) {
+		if (folio_uptodate) {
 			set_buffer_uptodate(bh);
 			continue;
 		}
-- 
2.20.1
