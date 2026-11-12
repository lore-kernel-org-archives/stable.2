Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475961;
	b=RhdCOoit9EG/b6nkiPnZHsJDW/d5ylOMGvV8vUghNqxVp7oqpKiPoBSzwFjGMj7y6bQU
	 RU660YWCtDv7Uf/49wEkxCsCj7iZ1HxTm160IJ6iEFaCpC6+R/on5jaLmQBYgZ96ozaSW
	 c3epTVMVDwqSe6Wty4T8/9yAe/SGEosVYsWZQOKWuxsR6BXrn/K+xg7re+ptOSyeoRsTT
	 ZFFdKwmodxjDEXhesaeSEKYkkt0xzyY+zkMJXx/JPpzKFd3XZYpRHdvIFn4dCyRwFFSJL
	 PYSyYh3Jii9XxLGPriLIGsOFOalC4dgHDfx5otHB1YISB1lcnyYHt6SY5sj5yu0ZLyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/ULzW8QvK/EALUnGSLdjbhj8msZl7UoNbmnKkjE1SLk=;
	b=iTK2uD78fX0xSneyg47PujC/tZFZFEK3HjhaeAMvH5GteA1WQh7Va2l5lv+m4vbVUDRd
	 wczMbsaI+u0SgS7gf5MG7aSjPjJNppj9ngXckReVsEj+Vx3kCi82mzedIyQbZZ37NxcPS
	 TYep2L0girEygcwO707D+AcDV2k17qiNMC2Wovb0ZI73Y4IchY+HPQ9mLmwvoKwqMK55M
	 s7RFjieDXndv4Ju+dV3OpvDM468ox8wg5RX0r+KIkvlxAUOCqUje9lgAUd0ZetNd83/6w
	 RQI5Ux5okwjvhpSNFuxLp2kO32bTCX0PjqhO1EbWIZ61pyytyVPECD02odk39ksPR6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lit0Km8m;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23105606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23105606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lit0Km8m
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso8652397eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794475959; x=1795080759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ULzW8QvK/EALUnGSLdjbhj8msZl7UoNbmnKkjE1SLk=;
        b=lit0Km8mvglgymTRvaRLszRSu5Xws6AsI+wO6OwqZNtSKLDnyLrjFShCFZh0jttFgr
         8GWqcFsh86QJnqCvBXs6qiC/a0qvAbQiSGiAdUxaJ7KYr6wNRrVOtL/FK4ss1QgWpkDP
         gnPWP92wapYaDxAGLpt5zJ3MvPKVnkJmR200ONNFXSDF0ix6y5zunPVUeydck8obyFGA
         5ggOqyy5aURLmNbNemvbgVl4l1+qbtUnsJMao7gwkdFs4YAcMMleNiFAtifiwI/EfeXK
         63f6xvelUsyNroVw3jC62FZdVTXAtSs8ikTcfQZpA/JUTCEN3xCLSvll015vUQDC0Fam
         iDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794475959; x=1795080759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ULzW8QvK/EALUnGSLdjbhj8msZl7UoNbmnKkjE1SLk=;
        b=1D0mjSzmX/m4OXJ1/kArz9rtCdufHR42LL2PF6AtA4VOQDNxjUQhDobL25+iNdLU56
         E8BYLZCvdJ5JXZJi69a/hXafCLlUAZlDD4FM7jzFwVQqSh1Q3l0yiWRpuPIe2kLPU2ZQ
         C/JjqL9s1xwXUQsD2aJhJ9csecCrTpZ35re3fTHJ8FXm4AxBFcd6PWskQx7fYitjHHZ2
         HBk4g6jcZnd4YYXZrTiCgFIYoyeLhmcY1ql+ownh7ZOTihcMz1X+usenjCX8WWm4uRti
         vHKQyQFUJ7r+aTdqK75vlSZ2bHH+oKnBziH2RXfn9lGCDk2ONBswYGuz6qntmVmVM3G4
         PejQ==
X-Forwarded-Encrypted: i=1; AL+hErEgLuy0FXTZrHWn/IS7zZk6VfHGgv1BQg6SEnWs1J3+QE0zQ6ZRQiAxEyNITQ9CF5MjCl41DWQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uls35ZySwHsNMKEF8qfc7oBU7Q4Al19jNHVuFdhfn9JEy6/W3
	YRGqpC+Bw5C5Nc8BQESqThQDzpBMxTL8skel/Br407lwCPe45PTw8v3O
X-Gm-Gg: AYBFou0hs4IiqRJqwTdi0e6GyXhlWI6wctxFMGemb56fIf1iMthpOg8G2le80xdig/l
	cMsi1HV1pC5YZu0sRqMDoFKna1OZ232OoQuZulIGQ4voqipEd0e5fP5yr9qcV6V3ktMdG2rFP2D
	Wsrx8e7IIx1mhk14jgo1Ud6gOW5eKU7LlDUt+nPkbuP7RWfl+FJUK8oOE6x0n1sOKR0HCLWmUmv
	AIEfxPi4+QCOFxoLsX4mWqdQTp9cjWuBHnz47lXsGizamoXGJOir6cR+hXGi3CiiS5pdvsnPM3Y
	XrFwAsA4zZ1sbcCHAqfcaXoCxVGK407F+X4SuE0bIVcgkPcDXQHu5Nu/zBOjKiDWgeXpxv71WTJ
	Esv8/jvBX++VZYqshM5mgPD+bQF51Qii7WDaRZwKmLHPFTsZUVOYqGqCSh+pkpw6UHHYZ7+oOkW
	2ghcomHnWpw8tjOEXGb2SEFnhyHLe4gmeF0HpvrHAPP/3gPlmNiuQj+TiiMMvw//EPifXvQNrtW
	mZmZZaCGjfdAfwMaE+MnrwjfxJi84FTI6UjheimTEoW/IJX+EePHLbzovAC/vTbc1wGTk88xoz/
	9viiWtXxCPq34ZwetSgWVAFUC7ZLkuH8xm8lVDIDbkdraGC3LyM0XGplcCstZOCvjAk=
X-Received: by 2002:a05:7300:1899:b0:376:b957:c01 with SMTP id 5a478bee46e88-376b9570fd3mr6726823eec.16.1794475959004;
        Thu, 12 Nov 2026 01:32:39 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm45498133eec.18.2026.11.12.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:32:38 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: liubaolin12138@163.com,
	ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH v3] ntfs: trim the sizes after a short write
Date: Thu, 12 Nov 2026 17:32:33 +0800
Message-ID: <20261112093233.1118469-1-zhanxusheng1024@gmail.com>
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
A short copy that ends inside a block can also leave the rest of that
block, and of the block holding pos + count, cached as read from disk,
so clear the page cache from the new initialized size to EOF before
shrinking it.

Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v3: clear the cache up to EOF, not up to the extended initialized
size, which left the rest of the block holding pos + count (Baolin).
v2: also clear the cached tail of the last block, which v1 left in
place when the write stayed inside the old data size (Baolin).

v2: https://lore.kernel.org/all/20261112030815.982026-1-zhanxusheng1024@gmail.com/
v1: https://lore.kernel.org/all/20261111093459.660484-1-zhanxusheng1024@gmail.com/

Tested in a VM on ntfs-next b025f526c5d0, with all free space filled
with a known pattern first.  Short buffered writes of 4M, old data
readable after drop_caches and after remount, 3 runs each:

                                    unfixed    v1     v2     v3
  fallocated, ends block-aligned    3137536    0      0      0
  fallocated, ends inside a block   3141332    212    0      0
  fallocated, unaligned start       3137536    412    0      0
  same, pos + count in that page    -          -      436    0
  append                            3137536    0      0      0

A short write 1M past EOF, O_DIRECT, resident and compressed files and
full writes give the same results with v3 as with v1.
---
 fs/ntfs/file.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 3213a0c9f96b..aa58afd729d0 100644
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
@@ -940,13 +951,23 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		filemap_invalidate_lock(vi->i_mapping);
 
 		/* ntfs_attr_set_initialized_size() rejects a resident one. */
-		if (ni->initialized_size != old_init_size &&
+		if (ni->initialized_size != new_init_size &&
 		    NInoNonResident(ni)) {
 			struct ntfs_inode *mrec_ni = ntfs_base_inode(ni);
 
+			/*
+			 * A short copy can leave the rest of a block read
+			 * from disk in the cache, also past the temporarily
+			 * extended initialized size.  Clear everything that
+			 * is no longer initialized, as
+			 * __ntfs_extend_initialized_size() does.
+			 */
+			truncate_pagecache_range(vi, new_init_size,
+					max_t(loff_t, i_size_read(vi),
+					      ni->initialized_size) - 1);
 			mutex_lock(&mrec_ni->mrec_lock);
 			init_err = ntfs_attr_set_initialized_size(ni,
-					old_init_size);
+					new_init_size);
 			mutex_unlock(&mrec_ni->mrec_lock);
 		}
 		/*
@@ -955,13 +976,13 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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

