Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389705;
	b=z8D/3t3xdDVIXIKXUsgOWEmhhnSK/tDxLE8x6mE70UWExt1m5BKyst3QkqoT7bDLFWAI
	 Jf/35donQ55rEl2aEOO8IAuy8IaJtdW/pZMd6B08KWsRsMTVpoqHPxWg4p2bdxNPVjGJw
	 zSQz6OLE4RnncQ6o0fl1ZPBGMikRw/q9HAzPYMp5tTpEp+PVoEXB+SZwDz4hqkvwW3bpe
	 Q6K9hET9dHAWfjCTaTv4q5NYWQ0EFemY2a7yPwvj/diZDvPZWMAmvT5JbHoJA9iqjzltL
	 KeNGao4kQ1aue0AsZHCYucOPI/vEiPo5M9buElvvGkpV3MrDnebKFQsw35hLHp5XV2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7/ak2wJxgQz/GEeeix3feX0c94ZhF3VpppiIw7196jw=;
	b=nUIaodwt98pR6IaESYNKiwF7riCYDbgxZBRKPGLAXeAaN12mUk3GQt9zDyN7kRnse3Fy
	 +dRQDoKiqqdQH1BJQHOEo2L6oCqaH9jm/kdTM6VZ3r+YXKllhijUBKx+p0FOL1UggoHIr
	 z8hsvlkSVmhEGRyuH8Y0v7GCOKy8LLK0yZS/bG7OEQHXW23apFtQkkBxtiJ59BRKdhh/T
	 eq+pLDRWvWTAkPipJ95DQBHa5PEZ96POE58gkTqIUag1Vk4l9r9C905tu+WCEKW+3/+c0
	 hJGOFKKcvybFTeUgZPf3ldnOvHXts+eTgKzaIuZ48JZottd19O1z+eew5FJ7BZAnSUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l9FLmy1L;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1323B606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1323B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l9FLmy1L
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so2880636eec.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794389704; x=1794994504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/ak2wJxgQz/GEeeix3feX0c94ZhF3VpppiIw7196jw=;
        b=l9FLmy1LIuNJsn6YZZr/Jt0hy7PbuSSPwBSnGzgLvX2eVGphu8bnFNGiEiMv8xiOVW
         oSZgjLYLDfua/V0qgvNHVoZUFdmH+4zaRSNUM3rlwP4tSLBgucoswNDIZ6RMpLYmvZgc
         +VH4aFwf2/z2V608s7MXRvqyUl77L/Ev+NLVzT3jwvwsj/glo087iVHd46CDT2siZyN8
         bJV9K6rZg8U52HPXIKYJUTt6bHmcq6JTnDElUmyoExgULd9HLYwr8LapaOkKOz3wAjHE
         scOV/j7tz5DyA/C96wX9ty3kSAs0qXg5IIg8bovl7ndGAXiq92mREETbj2IidFIlaEHh
         Me6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389704; x=1794994504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/ak2wJxgQz/GEeeix3feX0c94ZhF3VpppiIw7196jw=;
        b=IqKBvgLM1eCG4freRu0x2ub6VmVYnzxD7qIs38JTPDqwxVxv1zIsYrYIvzr1v+gZ4D
         9lxnGWDklOh/c7iFzDIQMR/RpKI+eLDwSoMQjN22sL3n5wUiESjjnYN+YWRUyEGEHiV+
         AltTl6hY3+17lUegTgI+a5M4BXsV6c9NkiJxmqmvlTrVoB/C1AEMYgzLn3DGUvKg7DIi
         LXqe4vCM87vTm8SVXv/Ix8vq2HgnJyR5xsgBTdyBs0BcUS3IUkx0qBnlMumS6ST15mQs
         hdhETTtd2zXC34uWUm2LhTtzbH0n6Y1w7iidJY9wQ7n0qBjf3AceQioX7v6T8cEoAEyp
         Z63g==
X-Forwarded-Encrypted: i=1; AL+hErEcD3qy1WOl5tOgM81RInuTnbO4+qCauCtUWffytcKwNz9TLM7gWZjh0gsg/0KsIxvLuV5YsNo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8K9b7qkZBhpQnRVZRvbNLs4jmmTmgXyui4IXosGsXgXXst5ZXc
	xnt4UaWAERMysk/cTYLXrNZeRWMJ2sT1kfx8T72VBFEXsX7IdekCWGDc
X-Gm-Gg: AYBFou3itnW26VPfOFcKW0JhAxusQWSsSx5F50ofVp59WqxgFHvyoTJCsFbxlDhqZWJ
	xv5y1DaZ2F3FHCQkijVpBmTMeqqRYYibcEmi01J5kFaPCdfzJWOpD7dTMU3szcVjQYGTdkr7u1o
	bxpbddIh6EltARn3JcrnBsni5vplzw8ytcHHM6MZuH6HRscsrZs3/Q/C+V2WFG9OcmJkJtaNPUY
	mEM8F7ALApPVRABMozWPCmj+W9i3sTwkGCJC1wu47/8fBG1uFJv4/Ur0SV4+uaeaE3JiuaaCMVI
	dPrsBACozqkRnYkMLatsMuufLQGq4uxuA+XfO5aJZuUU8HtKTtvLKMZUwVQhS6aSFO7eWdBidkl
	I/NqzYxhaobYp07sEDOy/41f5irreeReV1vlYFhWAPZ4S6ypfDN7g8amZLILQtRUrpwyE9TbHIC
	VV+K2pOygRDatD93lgcFUx0ykpbkbQBLkgpn9Dg2k3ZGNbkHmQ4LLesicpahEUGNzvyzCh5pYt1
	ZDnavw32cdidgYXzbhH9NIoOhx0DrFMW5XpdgBWbCidV8Q84jPp09pNbXiDIU+cT1ofvcImHrB1
	w8IWgxLtOlCh37f6y1N3NlFWRDhZDnbcDgHz6SJXsvs85A==
X-Received: by 2002:a05:7301:2424:b0:36a:21b8:b6c4 with SMTP id 5a478bee46e88-376851ce3acmr2539201eec.8.1794389703938;
        Wed, 11 Nov 2026 01:35:03 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe3261csm12625718eec.4.2026.11.11.01.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:35:03 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: trim the sizes after a short write
Date: Wed, 11 Nov 2026 17:34:59 +0800
Message-ID: <20261111093459.660484-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

ntfs_file_write_iter() moves the data size and, for a non-resident
uncompressed file, the initialized size to pos + count before the copy.
__ntfs_extend_initialized_size() only zeroes [old initialized size, pos),
so the range [pos, pos + count) is initialized only by the copy itself.
When iomap_file_buffered_write() copies less than count, it returns a
positive short count and the error rollback at out: does not run.  The
file keeps the size pos + count, and [pos + ret, pos + count) reads back
whatever the freed clusters held before, also after a remount.  A local
user can read the old contents of freed clusters this way.

Run the existing rollback for a short write as well, and roll the two
sizes back to the end of what was written instead of to the old sizes.

Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
A reproducer is available on request.

Tested in a VM on mainline b3dfbde62cf1, with the free space filled
with a known pattern first.  Short append of 4M that stops after
1056768 bytes:

                     write()   size grows by   old data readable
  before             1056768   4194304         3137536 bytes
  after              1056768   1056768         0

A short write 1M past EOF gives the same results.  Full writes and
compressed files are unchanged.
---
 fs/ntfs/file.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 3213a0c9f96b..98bb3d5d420e 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -928,10 +928,21 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ret = iomap_file_buffered_write(iocb, from, &ntfs_write_iomap_ops,
 				&ntfs_iomap_folio_ops, NULL);
 out:
-	if (ret < 0 && ret != -EIOCBQUEUED) {
+	/*
+	 * Both sizes were moved to end before the copy, so a short write,
+	 * like a failed one, must take back what it did not write.
+	 */
+	if (ret < count && ret != -EIOCBQUEUED) {
+		loff_t new_init_size = old_init_size;
+		loff_t new_data_size = old_data_size;
 		int init_err = 0;
 		int data_err = 0;
 
+		if (ret > 0) {
+			new_init_size = max(old_init_size, pos + ret);
+			new_data_size = max(old_data_size, pos + ret);
+		}
+
 		/*
 		 * Like ntfs_setattr_size(): __ntfs_attr_truncate_vfs()
 		 * expects the invalidate lock held across the size
@@ -940,13 +951,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		filemap_invalidate_lock(vi->i_mapping);
 
 		/* ntfs_attr_set_initialized_size() rejects a resident one. */
-		if (ni->initialized_size != old_init_size &&
+		if (ni->initialized_size != new_init_size &&
 		    NInoNonResident(ni)) {
 			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 
 			mutex_lock(&mrec_ni->mrec_lock);
 			init_err = ntfs_attr_set_initialized_size(ni,
-					old_init_size);
+					new_init_size);
 			mutex_unlock(&mrec_ni->mrec_lock);
 		}
 		/*
@@ -955,13 +966,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * the uninitialized tail, so skip it unless the rollback
 		 * above restored that size.
 		 */
-		if (ni->data_size != old_data_size && !init_err) {
+		if (ni->data_size != new_data_size && !init_err) {
 			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 
-			truncate_setsize(vi, old_data_size);
+			truncate_setsize(vi, new_data_size);
 			mutex_lock(&mrec_ni->mrec_lock);
-			data_err = __ntfs_attr_truncate_vfs(ni, old_data_size,
-					old_data_size);
+			data_err = __ntfs_attr_truncate_vfs(ni, new_data_size,
+					new_data_size);
 			mutex_unlock(&mrec_ni->mrec_lock);
 			/* Like ntfs_setattr_size(): stay on the durable size. */
 			if (data_err)

base-commit: b025f526c5d04929212c9d5fb7ffc96608f3eacc
-- 
2.43.0

