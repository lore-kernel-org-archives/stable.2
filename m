Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E1376BD1
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973094; cv=none; b=YbBB6qLDzo+/cZozC9G3IWjbkYqHbkMcgDIhslY0+cBrFwAJKEN1lWpBcVVeLNT2S2b9JM3lEf6N3KV+ccFqUAbPdDQAzofeyg+5fGFjtf5F+4AO5rbq/flqI+6IIVMycCu/saLFTr6/iR0TArj/tZv7OEyLkgbnULgsF5J+hGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973094; c=relaxed/simple;
	bh=XSFkE8mVMpsGAbHslX853y+B//61MCpL5id2RmrrSJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGaR8sdXOHqpAvseBVX98wW8vGk4Yuso9BlWVExR/oIijsppOHUXsCa5PFEYOK4sKYK0HcykpydPIye/qoTDk0Zz/SvWdDzgd6BD7XazIp2QJsv32gFu0EVSKWmM8nvpMIv3UdzdB5kPUCXai5buTO4Tfmm3BfSeYW7aiXLa/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1O2xa/V; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1O2xa/V"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f05ffdso18571175ad.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789973092; x=1790577892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TQGYbXqTzHr6KkUOA7rF3/5Lk+/QMh068xsZKavW1ho=;
        b=F1O2xa/V0rteBWGQXt+72AXvwXNpKm8ezw5aB5wIYLLITrfH9XdktwwlVwahOEYcc3
         V9OjpKCdZm2GEOK52PeF9+PByjFv1EK9F/Dr/nwHjwrvf58oqJAjrX9rD5wRoIWl9TnT
         P2509UERBDaLxX/VUs5otqrDofIXWLaZdX0TGI/RgxAxM/rY96cHqcZnWNzDAoWjcJyN
         4Gxbqit89jxNjI/CJWpT/Q1IekopEBc5S0VQCABJKzPmvRnDQEJQ+0ahH5NPohg2C/JI
         nFDq7PWR89FdmQeWtETCzQG01O0B/HK/Y0UmQedK5Xojp0YhLz8xpnvTGnYSxSRIQlK9
         ozlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789973092; x=1790577892;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQGYbXqTzHr6KkUOA7rF3/5Lk+/QMh068xsZKavW1ho=;
        b=LwZ5jGZ6co2SstSosVaZ5eDJrQt4gXUrowqdUNTWnkGi+gFvWrAuTKZatg68YkRYz9
         QeE+s7JzZt7TeFhzMXkpdR4udUvMijC+/3SR8KM1qU2uKHI1/7eeswE16MnlBcLMHC6Y
         oVuoAOlZQth0PgY0ZGd8B8VqTg+tkwl2jzdufTdcetaSNgPz4s7vqdgW/4Vk/eNBBe7Y
         rd3FHJJGvw1auXpIPt0JtCElf330K4PLEm4gkqIqCZIe+E/7CDq/L+N/HjDYk9gLexI7
         BVZYYYXpQ90HmSItDpgfBe3r/m64+nDq+i1HMbGhWigPZg7g3SIsU1ub51HSIIz+KPMJ
         qhlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzyRJJ02wVRTEAFyYbULfP+sk8XhHwXfKe8p+O3h75jjWK0ozZ7rPylUSN4wC+HV7BLCjRLiaE=@vger.kernel.org
X-Gm-Message-State: AFuF++nMoEAt+Z8ZN0W83TBwMF/eAQDlnn+uk+QehypGxCBWytsWclji
	rLyDwczf6xL3BfsJfOGGPXPC3WSfj8ZLiYw6j6gz4+XlyzaimpfYYNmJ
X-Gm-Gg: AYBFou3kuVfikIsr+cEKqPaJ0n3QEx3YYfX2xr4ydQoh4NCpvvBj0IGxNopseBkbeLN
	3kgpn89TlaMfiAEi+bJg9MuwCsThJgFdd+mo3CYl5oFwCwwp4Ep0Cn+132e/Dynx3LEyYVbfj6z
	dwMorGU3ai0Quq9FlL2YTour58amlVmqgd6EHvk41Ulu2L+byUZt2MchqS48hxAtZGJf7s2RxDI
	9JeVGj6CIKZjopRgf4hDGY5QUOrQKaETToaQZetTOvV5VlZQ/NFGMdaj6K7amqM5KH4BaXmARJP
	/3s0s1P0bsjGGCHJ3udaRmJno3PlENjlaGcRx35a4nRPox3FvaaR1A6BokXb+h+cu5ryb/8uU10
	Lw/k0/g+eKwUHIhldpB3tHOvn4FURsygziuxJdpAQigl9+quwx81wDkE+qc0P1F5nHQ5ySuhhr2
	QSnJmEHGrdM4LMrjPw6sdOYEU7pUqPCu3rA+du2r1NJ99prlezsnrCy7SXltoM1hdpzV7D9Lalu
	amkXBbf01daAN0y
X-Received: by 2002:a17:902:fc45:b0:2dd:c100:80b1 with SMTP id d9443c01a7336-2ddc100811dmr93111495ad.44.1789973091889;
        Sun, 20 Sep 2026 23:44:51 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc180395fsm28097345ad.81.2026.09.20.23.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:44:51 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v6 09/10] ntfs: trigger page_mkwrite for native 4Kn size extension
Date: Mon, 21 Sep 2026 15:44:11 +0900
Message-ID: <20260921-topic-4kn-lkml-v6-9-75069f590b22@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921-topic-4kn-lkml-v6-0-75069f590b22@gmail.com>
References: <20260921-topic-4kn-lkml-v6-0-75069f590b22@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3499; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=XSFkE8mVMpsGAbHslX853y+B//61MCpL5id2RmrrSJc=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqsNIMwuec8xw3spo0jaTO4iltcVmp/VcV6QiVv
 ExBZc/DB6uJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCarDSDAAKCRA08jD6945I
 04ZxD/4pFo9e+gguZPNc29P3TMxImjS2F6ENWlpS8r0R30DgyGvuuBnH1CPh6JUlZNDoLqDBqmH
 ABzJfqVcHxLGeX0xCbvLw+x1707rTFhJqpXyHM9g4GtbCivPGWTeXzW99IIly2eun/HRV1z15Qi
 q2smKLp1lxpZAdJq8Pz1hRVPYq/RK4FUIL+A7M4Q1zgOLYxJeRxccvD+B0kPGPLZwgq/B5fbGY3
 3GKzOk3a3aChw/9Wr5IATNAt5ZJHcbk3QcVNXkxJO251Iq96WPHT/Ux/NrimI2clR7MH33PK/4r
 /NXwmoh/t6JmesuxoUBA/wfrjLZk6AbqXSQY6okueHJrDhxP5XBpBeIKjlaBE4Daw+/UyUsCIwB
 B9ezVS0EAt/gUtRE2T7d6D7++OxD/S1ybDuI4Ho9QZNMJmXC2SXdxwgZ0hSg4Q1IXlEMxfV5Thc
 OxRkBROr52YLmxcexlBabXQopoC7EAiche9EBukb9D/fv2AMfmCv4flEqvw7lZW8Rc706fjXr/w
 OxHm/F2UyJwAOic4fH0BRQmLhZ5BlOIG805i7oXOtyG64LAyLWFX6cth8NoG/b41x5v69jN7z3z
 ZrSH/ctQ49+58DrLhxBHBw+XJXWFE1PxvCkSNBUqTJ/P/xZeIYxv7M0AgSvM0lKHnKTmWygugQq KDdJE+UnMlp86xA==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

On native 4Kn volumes, pagecache_isize_extended() can leave a writable
mapping for a partial old-EOF page. A subsequent shared mmap write can
then bypass ntfs_filemap_page_mkwrite(), leaving NTFS initialized_size at
the old EOF.

Invalidate the partial old-EOF page after size extension, independent of
the filesystem block size, so the next mmap write enters the NTFS
page_mkwrite path. Apply the same helper to zero-fill fallocate
extensions and compare the actual new size after the operation so
extensions overlapping the old EOF are handled as well.

Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/file.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 99a2c7a5cf81..e290616be07d 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -252,6 +252,22 @@ static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	return ret;
 }
 
+static void ntfs_pagecache_extend(struct inode *vi, loff_t from, loff_t to)
+{
+	pagecache_isize_extended(vi, from, to);
+
+	/*
+	 * NTFS initialized_size is byte-granular, so a partial old-EOF page
+	 * must stay write-protected until page_mkwrite() updates it. The
+	 * generic helper skips this when the block size is at least a page,
+	 * the extension ends before the rounded block boundary, or that
+	 * boundary is page-aligned.
+	 */
+	if (from < to && from & (PAGE_SIZE - 1))
+		unmap_mapping_range(vi->i_mapping, round_down(from, PAGE_SIZE),
+				    PAGE_SIZE, 0);
+}
+
 static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
@@ -281,7 +297,7 @@ static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 	if (attr->ia_size > old_size) {
 		truncate_pagecache(vi, old_size);
 		i_size_write(vi, attr->ia_size);
-		pagecache_isize_extended(vi, old_size, attr->ia_size);
+		ntfs_pagecache_extend(vi, old_size, attr->ia_size);
 	} else {
 		truncate_setsize(vi, attr->ia_size);
 	}
@@ -1136,7 +1152,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	struct ntfs_inode *ni = NTFS_I(vi);
 	struct ntfs_volume *vol = ni->vol;
 	int err = 0;
-	loff_t old_size;
+	loff_t old_size, new_size;
 
 	if (mode & ~(NTFS_FALLOC_FL_SUPPORTED))
 		return -EOPNOTSUPP;
@@ -1162,13 +1178,12 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	if (err)
 		return err;
 
-	old_size = i_size_read(vi);
-
 	inode_lock(vi);
 	if (NInoCompressed(ni) || NInoEncrypted(ni) || NInoWofCompressed(ni)) {
 		inode_unlock(vi);
 		return -EOPNOTSUPP;
 	}
+	old_size = i_size_read(vi);
 
 	inode_dio_wait(vi);
 	/* Take invalidate_lock for all fallocate operations to prevent races */
@@ -1197,10 +1212,12 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 
 	err = file_modified(file);
 out:
-	if (!err && mode == 0 && NInoNonResident(ni) &&
-	    offset > old_size) {
-		truncate_pagecache(vi, old_size);
-		pagecache_isize_extended(vi, old_size, offset);
+	if (!err && mode == 0 && NInoNonResident(ni)) {
+		new_size = i_size_read(vi);
+		if (new_size > old_size) {
+			truncate_pagecache(vi, old_size);
+			ntfs_pagecache_extend(vi, old_size, new_size);
+		}
 	}
 
 	filemap_invalidate_unlock(vi->i_mapping);

-- 
2.43.0

