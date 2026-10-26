Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792979794;
	b=vfD5xkvMhNTVwPAnzvbDsctY8i7I78p2MMra6X6g8HXZLsaeh8YjFPbAuCREwKUNekov
	 6orN1Ly0RaKN50HEE8rIG1irnC6RQFY8vHj11T9Tsebsi7elB/t4wOSdCD2ZhHD1al7N1
	 lItl8w+dFiRNvwoZJf8iZ9D8RfLzIW3mpZRbWQFZUH4hNoZczts0fb3C0y2UdmUZg9ovb
	 Tr7PcunWQhUm6eBlORg7kYAu1nQAAb+hkiSSeQ2EtHL6BDdvKZQyaSrWpfjduTUkqMPJ8
	 MIx4AQmxugbs/6KbePnGr+OauiKqsrwOuGXnQ5G9IcUKlTpEeJRfofCxPL28D+qsXSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792979794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FmarotRNBTJapESQa6reZSmrXE0VRisYQBm/EcrfnMU=;
	b=AU1B2GCNpOA7RthpUdwFnPX7coN+JeQIBZ+PIjEb05FRmJtAMj/fC+gnD1shkbVql6F8
	 hxTI/EX4jQM6F0chkfO6/NTxzGKMV8B7zqVtyUM/2bTLxbcK58imY6oFuCjbooMmJgfjA
	 HNFYdxGdJppPxPF1UtpIB7YiZ1Xz4MuVHAfiM0959yt9BJUo15hHLoXx8K0a5jrWomPzn
	 sy/T0OXdJS0oHr6XpkCrBNRe0bxsb9o6JZOkjbwhV3BExr+eS6FTOArOJZNDCVNbqZ8Nd
	 8O3/C5MQi15BNEgGyz+mEAWW0g5pMRqRFDd4vi833owIa8M7Ywf2Le0PRZUVrLP2Lsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eVWbVFWr;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657E606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 01:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D657E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eVWbVFWr
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06b436dffso1104890b3a.3
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792979793; x=1793584593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FmarotRNBTJapESQa6reZSmrXE0VRisYQBm/EcrfnMU=;
        b=eVWbVFWrBqwjiBVB86JZo9uS4OjM3pHvFHJaWHd+q+5tXD7jWIgKXfdaRszUv6ae3u
         R5wy/0iAQzC/pKhupVKoR6ORQaYBwdAp4dwUhV+ehxci4bENfptwg+Bu87Ts2nqOK1FF
         k0AtOdovDDM904AdDBUNlk1gcxpeDNaAvUdrvu7ODTvxSs9iNYlByDVGUDN23giaX9xF
         rIBz+gl4RKid4AfxixT0oFPbWgOZM/qhTttzvrTV/+bb7ntk3XLfaX3pOvf6O+FVDxr5
         q3J02SNQT36V4eBSqj1jNSA0bL87CM4JYrdx0gY3MtH47tpnBFgRQPt+heVr2/dvBNk+
         S9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792979793; x=1793584593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FmarotRNBTJapESQa6reZSmrXE0VRisYQBm/EcrfnMU=;
        b=mhMrbY67VvyZav08vyOKrCtjvXvUKWYF6DF52HsW/g2PqtIC5fmZz5tOI9mvt9VSIe
         BAmVd8IaP+nh6xLi2rmMcL5KgpesOmQ4b0iugClYBF7g2mmOSIYE0c7ebyT3js/Yuf0D
         YapO+oEyiYdMFb8e51i5FfnuZV0IZAmsHnA28rvCn7qJsW7WYZxWp+jBq4B/53KXQQrN
         mgt637h4hL+ZLMPfOQ8DWCRQUugNLFOFjggVPdCID7ES7ZHsiG2ZaQ4dDzBnO/+YAUku
         f3B5tZBGMKlYQ4rMW6lISc+fJgRiKI2BHKh+ahtsOFbQyGfzfgFp6aDhMRrSmBqOsMOq
         GBpg==
X-Gm-Message-State: AFq9FYK44x1W0PyJbPOiCENtxnL0AxZOTkIqqR4VsaDdR2B1TwI2ChX2
	lotOGS8Z50Qbf/9enmFu8ObZAbolfkyHA8WstVVExMPgTaXRfQjVJFxQohxp40FA
X-Gm-Gg: AYBFou2tbt3lBDmGMkhYUyxkTnyLfJfmixR9LqN7eT01xhOwvyOEX2XyQvPqCbr/UDK
	U8SYFeWZeY/dQw1RvBxILfUj3Kfs8X+j81WDYkNUzvtzIfyNgX5rqM06VKitwNQhNSsh/vYdg3r
	c+VuakwCfO8yMahQlYotYaCRCi3oewVFOr1djXUiQgWF+I2AJKUV/Qfs8lQUKuzfzImbWVxNT8B
	LSZt/A2y6KurSk1IXyI7YvZMfHJlC4WAF1v3uypdkfj17tzhRBXCAiwup6uVVhcg6isZTz+qp9W
	BaWKj7B//nlnrtabb58RQx1ZuB2J7qIRwtrRm5tFvc05Q6QwstzRlh4Glp2qpPMZdM8hRi5eVe5
	qE2UIBJfLmju1cxXywu+0nuwcM8f1ygVnS4xvtG5Ar5lFsIxElB/xwboloPM6RIPH9c5CdkwtfG
	/jWm84WCD0FtZXal+seCRypPKbnQ90GCIocZkDuepcxK3k+S/rteagIbR+AV0lj6ZuSCeQNb+Ot
	A+0cJGZMMlAAE+T1S8YoL3bxhOH/fu4BOhJglIKi5SVg7eIRV+BSYWhiRM2HA==
X-Received: by 2002:a17:90b:3a48:b0:3ad:6ec8:35cf with SMTP id 98e67ed59e1d1-3adeae70722mr4713682a91.51.1792979793060;
        Sun, 25 Oct 2026 18:56:33 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb8240b5sm5115612a91.0.2026.10.25.18.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 18:56:32 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	hyc.lee@gmail.com,
	linkinjeon@kernel.org,
	liubaolin@kylinos.cn,
	zenghongling@kylinos.cn,
	ntfs@lists.linux.dev
Subject: [PATCH 7.2.y 2/2] ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()
Date: Mon, 26 Oct 2026 10:55:33 +0900
Message-ID: <20261026015533.1124816-2-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026015533.1124816-1-hyc.lee@gmail.com>
References: <2026102240-impending-elusive-74a7@gregkh>
 <20261026015533.1124816-1-hyc.lee@gmail.com>
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

[ Upstream commit 0fecc393f2060e6bc25138df32cb923ec7071c6b ]

ntfs_filemap_page_mkwrite() calls iomap_page_mkwrite() without holding
mapping->invalidate_lock, so a concurrent truncate or fallocate can be in
the middle of invalidating pagecache and rewriting the runlist while the write
fault maps blocks and dirties the folio. This races with ntfs_attr_fallocate(),
which merges clusters into the in-memory runlist, drops the runlist lock, and
only afterwards zeroes the newly allocated clusters on disk; and with the
punch-hole/insert/collapse paths that free clusters after truncating the cache.

Per Documentation/filesystems/locking.rst, ->page_mkwrite() must ensure there
are no truncate/invalidate races, "usually mapping->invalidate_lock is suitable
for proper serialization". xfs takes its mmaplock (= the invalidate_lock
rwsem) shared in exactly this path.

Take invalidate_lock shared around iomap_page_mkwrite(). The read-only fault
path is already covered because filemap_fault() itself grabs invalidate_lock
shared on instantiation/read paths; only page_mkwrite was bypassing it in this
driver.

Fixes: 9c87959601e8 ("ntfs: update file operations")
Cc: stable@vger.kernel.org
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Co-developed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 317bb249150f..8515560e2a4b 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -620,12 +620,20 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct address_space *mapping = inode->i_mapping;
 	vm_fault_t ret;
 
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
+	/*
+	 * Serialize against truncate/fallocate which hold the lock
+	 * exclusively while invalidating pagecache and changing extents.
+	 */
+	filemap_invalidate_lock_shared(mapping);
 	ret = iomap_page_mkwrite(vmf, &ntfs_page_mkwrite_iomap_ops, NULL);
+	filemap_invalidate_unlock_shared(mapping);
+
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 }
@@ -1119,13 +1127,13 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 
 	err = file_modified(file);
 out:
+	if (!err && mode == 0 && NInoNonResident(ni) &&
+	    offset > old_size) {
+		truncate_pagecache(vi, old_size);
+		pagecache_isize_extended(vi, old_size, offset);
+	}
 	filemap_invalidate_unlock(vi->i_mapping);
 	if (!err) {
-		if (mode == 0 && NInoNonResident(ni) &&
-		    offset > old_size) {
-			truncate_pagecache(vi, old_size);
-			pagecache_isize_extended(vi, old_size, offset);
-		}
 		NInoSetFileNameDirty(ni);
 		inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
 		mark_inode_dirty(vi);
-- 
2.43.0

