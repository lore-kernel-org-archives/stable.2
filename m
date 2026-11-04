Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819559;
	b=Qo7LnCQqH/xZkZy11qvLD80h9/1xIr1lPETbNOiqwvObsbmvruSRSyMvtQqHI4DCTq+k
	 d/YddnXIkZAPfUG0PlhnANj4i/9jwHImZTj9rwmYotSalWSxY0grnAnFAfU/JAliyVNmC
	 euZCwTbsNpZw/LfCJuj1V89Z/SwxkXcAunheMwquC5f+MePyHYGEMShu64pyvtyd/pe1X
	 cuT2wlpACKbvYa0X1Y66WwnjD99uL/4uWSswyPuo6ToAc4u9GRIv65z80Bm4ua38yUo79
	 cToXRGqnzrPFBztw+VKkuI06eYRR0QfcdO79CwtYqwCGEkIbquus54IHvwkml8FNsYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2eBasa7agXmVq6bqhWG9P4J2rj64c5jg7X5XSFiq59I=;
	b=qoX/SuKjychtvHNwdDK06GNM/49QLV9PWgMmJ1gRsxqQivkMR/iPu6ZST60u8tGDhBsn
	 J+wZv3jG2YwAdKy6wZwzj6WcLGX7XihKIMvV9ZZy8qzOSpsdC7CVTKSqc1orndOyObdMb
	 xGnoigset6Uf9QnfcdGfIY1gnLFo+gUQcqD1VauhCvZtRZEeIvOQDr6WnI7+eTkegrdeF
	 rAfnkaUJC/exr8uBiIYBos6ODHlQs84BGcyJ11POsvcYVHnLdmPxFVx+apwMOG0vIexen
	 2LbDZp8gU9dqf5ineQOLuztUEdPKhh8jWFvrt83L8iH8EHcdpXExr4/GVq6ZRcSSmVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eqj5Og8j;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD5606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85FD5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eqj5Og8j
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso492975eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793819559; x=1794424359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2eBasa7agXmVq6bqhWG9P4J2rj64c5jg7X5XSFiq59I=;
        b=Eqj5Og8j+BJqXcySMWz1SZiTErQxINNNlbsUZj31hS7lGoG6Gq9yCzn7VNE6Om5jkB
         kOR/Wp5R7NWosG0U9+7d8IAIP1sv4mt+75u/LDEIaa20TqtV4Ul83r/2HgwP0B10j0+V
         pvaOhvJEZbZ5eAGpy9LPLKRGp40zyGTb3678OrokeIryxlwDK3f5uUw2nAEFNFjZWazt
         wGwi+9gouE314rfJTQmK3m8GFxdq+kOnUNcIQoNk8YQeF7zg1n5UXZXWtIbtFAjfsKUo
         g57vlJFrdxiyU5wSrlEijhSz1DSvlhKvPoHNLF/BG/9+9zLelsLukMg0MYJi7JMpGp9L
         Gfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819559; x=1794424359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2eBasa7agXmVq6bqhWG9P4J2rj64c5jg7X5XSFiq59I=;
        b=PMOhcDYCyGzoS9NRxJw/Y5c6pX8Fu1dOHhlcJQJgzYPxWlAQG5ZbNNx2whkq4JiNTD
         Y2kJ/K5P+Jp6Ilp+ZN8YxUdDx3mSxAR1JzkJAU5nP8C5B5cuA9gzRp4Pe0XZ1E5gpLo+
         q4FGjP249La6naY2Eu+YReVNykj+li33H8kVpELG5zIFRHENgiYryG0yCE74g9Qqc1R+
         iutpxNtjynG3UD6wvPNB47/EVWo0bpOO2+VRGJW7XD3ScS90q6n+/0L9A+pHxPEkfK3a
         tqFYTFs3T6LCzYbW0Kf/7XHYG3DCsPXcAki+sFYum8ODDdGvjL9VlXJz1FY2pCH2GH5P
         Nr8A==
X-Forwarded-Encrypted: i=1; AKwUvBxyu0u3uiBsYVmIBbJhWxMq+g9mD0oOgGixFPTVGqH2ComGZbDwH04aXsXzlBmO9OOX1tVjAXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kKYG5z6zDDXf2bx02brRiX3RwqOxjVi7IABSRwZN/ACShbcHl
	576WpJUsIMSOlVR0rNlphqfLpX3/OVLMgSvwJplCfxcK6PfTzAUXfeMn
X-Gm-Gg: AYBFou03VkIZoVuVrwSeun59kI/Ovqsp5gsv9ZX2Z+RcjAEej1DJp62nDtxxU2QdwmL
	GUqfU+DNTKgRax7a2P08bHwXCADiQjwUt91KZxjUaWKYbJ6PNa+5YbbdjzBXDV/9ta83eiMMt4l
	zxKrsZ6TntjPjuya8d7pJ71NizBKNCa6Xka7Tktwr98UI/JR4da4VU9MK3RzxgJBZO8rhnm0N0I
	en7kFNNxAFb+2haUILbdrJIyy3EQNtleiXJm9+krY+nFuKj0gYhx+XEnkza4qnhEZRIYGc/0HZp
	NGSJaiH5f+gcHXNVYZdVNNE+1xfSqtZ4IL/XWbK34Y4NHGvCedO4oZ4gQEJIbGNM0Z+izEbJXg6
	hyK6Tgtt5AYJP3UqbtMfejl8tpD6biBaCrUe8QViVJC646s+0zxmPKS3DNTRRopn3ZVKmjXxq+7
	FfUYBNJyaGTtX9y8w/nM808KAVmFGbXx3f2BFqBgY3lJQcYVJP2y4i06F6ARGXWq2uZd+9ROJJC
	3rzh/kDN7XdRHXXVPgcJ5WuP4eGf08ji+d06fiTh5ZSe5Wv5pzVg5kFXTfKGQmiesljXVi6QsrB
	QpMCpDFun4ZkZeo6KwvkxTe6PytyG8asNoMhmqweAonAmQsNIB11cQGopIsXf70nXpIzwXr22B4
	A3EU8uzzlYN/wuBFZj2OYgZ+WFB8BYvlwKRn4Og==
X-Received: by 2002:a05:7301:6189:20b0:358:ec5c:bef1 with SMTP id 5a478bee46e88-36a42425486mr23614256eec.39.1793819558461;
        Wed, 04 Nov 2026 11:12:38 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36dad72dc52sm1916864eec.0.2026.11.04.11.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:12:38 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: richard@nod.at
Cc: chengzhihao1@huawei.com,
	lin.nan@h3c.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] ubifs: account for short copies in ubifs_write_end
Date: Wed,  4 Nov 2026 19:11:31 +0000
Message-ID: <20261104191132.89515-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ubifs_write_end() updates i_size and ui_size to pos + len even when
fewer bytes were copied. A one-byte write at EOF from an unreadable
buffer can fail with EFAULT while extending the file by one byte.
Partial writes can also extend the file past the last byte copied.

Use pos + copied for size updates and cancel the budget when no data
was copied. Keep the appending decision based on the requested length
to match the inode budgeting and ui_mutex locking in ubifs_write_begin().
If a short copy ends within the old size, release any unused inode budget
without reducing the size, and still unlock ui_mutex.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Link: https://lore.kernel.org/linux-mtd/20261027061226.3506517-1-lin.nan@h3c.com/
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/ubifs/file.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 99dd52715ee..8ebd3f4cddf 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -523,8 +523,8 @@ static int ubifs_write_end(const struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
-	loff_t end_pos = pos + len;
-	int appending = !!(end_pos > inode->i_size);
+	loff_t end_pos = pos + copied;
+	int appending = !!(pos + len > inode->i_size);
 
 	dbg_gen("ino %llu, pos %llu, pg %lu, len %u, copied %d, i_size %lld",
 		inode->i_ino, pos, folio->index, len, copied, inode->i_size);
@@ -552,6 +552,11 @@ static int ubifs_write_end(const struct kiocb *iocb,
 		goto out;
 	}
 
+	if (unlikely(!copied)) {
+		cancel_budget(c, folio, ui, appending);
+		goto out;
+	}
+
 	if (len == folio_size(folio))
 		folio_mark_uptodate(folio);
 
@@ -562,14 +567,18 @@ static int ubifs_write_end(const struct kiocb *iocb,
 	}
 
 	if (appending) {
-		i_size_write(inode, end_pos);
-		ui->ui_size = end_pos;
-		/*
-		 * We do not set @I_DIRTY_PAGES (which means that
-		 * the inode has dirty pages), this was done in
-		 * filemap_dirty_folio().
-		 */
-		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
+		if (end_pos > inode->i_size) {
+			i_size_write(inode, end_pos);
+			ui->ui_size = end_pos;
+			/*
+			 * We do not set @I_DIRTY_PAGES (which means that
+			 * the inode has dirty pages), this was done in
+			 * filemap_dirty_folio().
+			 */
+			__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
+		} else if (!ui->dirty) {
+			ubifs_release_dirty_inode_budget(c, ui);
+		}
 		ubifs_assert(c, mutex_is_locked(&ui->ui_mutex));
 		mutex_unlock(&ui->ui_mutex);
 	}

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.50.1 (Apple Git-155)

