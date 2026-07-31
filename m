Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967AF44AB72
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518023; cv=none; b=l5OrJOVIlSbDEqMORiYSz2PDBF7KMrwB4DvvCHJ8X0h3xwWE9zmWXNQvUUvridCzf6Y4aRMmLWtex8YFcPrOXI4/NJeiBQZGNgAAQvcvte12Gmd+3lkQSPF0+5UEYrfoNnOMNdMMr539csIHJS6K/MpDlzXfkj1JOPc5RU2Qz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518023; c=relaxed/simple;
	bh=9yjp3s39FPi+R1POVoUtgFiwrIxOIHLCwRrv9oEOrbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBduJr8mogkPthWuaWljMs2CVuRff62ghxpfHGi6+nr/DVOV1dwq6GOlegSRbtJlHmvZrnV8V3djFjY9mM4yeRGD349rhmrithvZNilOdg1BL4IRnaRj6lTW+nQl+f00GdDt2FUvJIUVRWMBNtpdDtyHu0VO474QLi57Du6ji40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPTNoi71; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxSqaPSQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPTNoi71";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxSqaPSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785518019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lblueWsjbHl23xri8KHQtjB5nLycM/C1Fy5fVuzIFyE=;
	b=FPTNoi71F61VIfQDa3zGpxlAgYJzzC+9p7jQ1ZImWWv6hThUkBKGxh78+/8azO4jw0BEXZ
	cIelqPeCG33bvNgyaFMmn+hjgrNfN3I7DTKHt4D3y3lpKSK5fSJuRHI2iCsXz6BHRNub7K
	glF/WABoIk0ayJqw7Z4uAfUvDg/rneo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-h2MIdc1NNM-8ZX_qYI9epA-1; Fri, 31 Jul 2026 13:13:35 -0400
X-MC-Unique: h2MIdc1NNM-8ZX_qYI9epA-1
X-Mimecast-MFC-AGG-ID: h2MIdc1NNM-8ZX_qYI9epA_1785518015
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-907e49dbae8so10496306d6.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785518015; x=1786122815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lblueWsjbHl23xri8KHQtjB5nLycM/C1Fy5fVuzIFyE=;
        b=ZxSqaPSQe7/jwGShMRa1amA/x4ss7cqKvbCieCSuim85TNnfR6UOw7MnPdL70M6UxA
         maDDnQQl1c34YmDjdBpiKKVBrnTK8/VgXtO2XDSvpYcRDi5XBlXVXxJiETYgFp3kdW5Q
         Yf8RfgivVdy5XiSs29jwS7vJPXMyyxviLXs+6vzdP+au7dgTThwdUaySSJYQu6YoVyHg
         2358xEQBX6tn3u66SUvn+rgq1b+ryfNGgEfNAopmv96t8imLBeyRKx3321PgApgjSrB+
         8os6jotlM6PV8nDpKhN14ah/3xPiqx/cuCV6p4YR9prLq6ujTiZlqJWm5wAPDNXnSQ6x
         7ntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518015; x=1786122815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lblueWsjbHl23xri8KHQtjB5nLycM/C1Fy5fVuzIFyE=;
        b=EZnE6VlZ8ghehXXUzastzRJikEa9BRZrPOx23xQUjHQ4g0/C+icFXbLqumypnN0V7f
         1e4IYPq3qqnYyGaWsHkWrJJmxLvIzI+EdW7jSrzJoeJISP+5L3LmqU1Sav6OlTz/SrRr
         Q6YsF7ynXLquHmMhVCAuYqOfFjGEwXL3Hbkkk1MGFN6NlW+dlKZ36f4+PK8qkI7DbJcF
         /jCdc/1HD5v+v7gs1+R7090oICV5MjshWTSA5FnpFRXuxpNZcSpbFDOGpx+B0in+lRe0
         xZMIF+5qL69BFjWmCdvskFTg5Q3h3WDYw8//RWfg5TDY5e3A6/1JutAr01WDqMOo6exa
         5q/w==
X-Gm-Message-State: AOJu0YyWvSpTEr5kVNrpBY0dp833zEgOxnPPYqv25C3/GviYVDClWGS6
	/Nh7vFz/pa8qNgSPxj2oFPtfuttiLopkCDijwMQxxk6Q34PcNewtf6+q1IbIUlEnLYUfxZG3ETZ
	v9P1G/zFZHDZzBqVawoQnVd9ZlrM11UAOO0bQHgfrkGZXsTRW2chIQEVvqQ==
X-Gm-Gg: AR+sD12kyfyc+F9FlDjim59Z6TiVc2vkhmEz5t64ZmaFLpEcZjx+H5VSv1E50IDqtyi
	s83CUwXso4WqGePNVDnpUbtoAWJ9Z3DOHTedE7O7SJrVEaEXxXyIminryjny98uP18qDnQ9siVD
	/c0R8XBgOfEt4zp3jGd4biR3xQVoHKlCfJ1/ErvhpDxpPTs/ykciWIjGJ52lsnqNjCQERmK11mh
	pOXo+IHrn5zHBTEe6Uc65xKHYlHWj5pWk9sbC4lLLdsNk1tY9v1KRipjfXYru3aMgKvS5+z3Y4k
	tUyLxxzdYtqbvOj9mFycwtRiz3iCuQ8u2NUwY0S9H1TsU4JDG5ru4FFxayPY/3lmHHcHzg0v6tR
	5cewp3kfirF+5oVqkzw+0i6NKsny0T8TJp3JckjkmLR3POBsqiuYdUwNZB7s6
X-Received: by 2002:a05:6214:1bce:b0:8f2:3472:5b33 with SMTP id 6a1803df08f44-9084969236dmr12079176d6.23.1785518014839;
        Fri, 31 Jul 2026 10:13:34 -0700 (PDT)
X-Received: by 2002:a05:6214:1bce:b0:8f2:3472:5b33 with SMTP id 6a1803df08f44-9084969236dmr12078376d6.23.1785518014225;
        Fri, 31 Jul 2026 10:13:34 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908434a250csm14676316d6.13.2026.07.31.10.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 10:13:22 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org,
	stfrench@microsoft.com,
	hehuiwen@kylinos.cn
Cc: stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH v3 2/4] cifs: add cifs_resize_file_locked() to guard fscache_resize_cookie() under i_rwsem
Date: Fri, 31 Jul 2026 12:12:29 -0500
Message-ID: <20260731171231.686427-3-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731171231.686427-1-sorenson@redhat.com>
References: <20260731171231.686427-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cifs_setsize() calls fscache_resize_cookie() without holding i_rwsem.
When the fscache cookie is active (FSCACHE_COOKIE_IS_CACHING is set),
fscache_resize_cookie() performs a real resize that requires i_rwsem
held exclusively.  If another file descriptor has the same inode open,
fscache_use_cookie() was already called from that cifs_open(), making
the cookie active.  In that case, calling cifs_setsize() from
cifs_do_truncate() (invoked from cifs_open() without i_rwsem) races
against concurrent fscache I/O.

Strip fscache_resize_cookie() from cifs_setsize(), making it a pure
size/page-cache helper.  Add cifs_resize_file_locked() for callers
that already hold i_rwsem: it calls netfs_resize_file() and
cifs_setsize(), then temporarily activates the cookie with
fscache_use_cookie() to perform the resize under the lock, then
deactivates it with cifs_fscache_unuse_inode_cookie().  Using
fscache_use_cookie() before the resize ensures correctness whether or
not another fd already holds the cookie active.

Switch cifs_file_set_size(), smb2_duplicate_extents(), and both size-
extension branches of smb3_simple_falloc() to the new wrapper; those
paths already hold i_rwsem via VFS setattr, lock_two_nondirectories(),
or cifs_fallocate() respectively.  cifs_do_truncate() continues to
call cifs_setsize() followed by cifs_invalidate_cache(), since it runs
without i_rwsem.

Fixes: fa724e235cfd ("cifs: add fscache_resize_cookie() to cifs_setsize()")
Cc: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
---
 fs/smb/client/cifsfs.h  |  1 +
 fs/smb/client/inode.c   | 24 +++++++++++++++++++-----
 fs/smb/client/smb2ops.c |  9 +++------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 854e672a4e37..651670c19c2b 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -147,6 +147,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid, struct file *src_file,
 
 long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg);
 void cifs_setsize(struct inode *inode, loff_t offset);
+void cifs_resize_file_locked(struct inode *inode, loff_t offset);
 
 struct fs_context;
 struct smb3_fs_context;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 0afff761aab9..eaf27a9cf4f5 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3059,7 +3059,23 @@ void cifs_setsize(struct inode *inode, loff_t offset)
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	truncate_pagecache(inode, offset);
 	netfs_wait_for_outstanding_io(inode);
-	fscache_resize_cookie(cifs_inode_cookie(inode), offset);
+}
+
+void cifs_resize_file_locked(struct inode *inode, loff_t offset)
+{
+	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
+
+	lockdep_assert_held_write(&inode->i_rwsem);
+
+	netfs_resize_file(netfs_inode(inode), offset, true);
+	cifs_setsize(inode, offset);
+
+	if (!cookie)
+		return;
+
+	fscache_use_cookie(cookie, true);
+	fscache_resize_cookie(cookie, offset);
+	cifs_fscache_unuse_inode_cookie(inode, true);
 }
 
 int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
@@ -3125,10 +3144,8 @@ int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
 	cifs_put_tlink(tlink);
 
 set_size_out:
-	if (rc == 0) {
-		netfs_resize_file(&cifsInode->netfs, size, true);
-		cifs_setsize(inode, size);
-	}
+	if (rc == 0)
+		cifs_resize_file_locked(inode, size);
 
 	return rc;
 }
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 192649fec25d..0e872d58fae7 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2222,8 +2222,7 @@ smb2_duplicate_extents(const unsigned int xid,
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
-		netfs_resize_file(netfs_inode(inode), dest_off + len, true);
-		cifs_setsize(inode, dest_off + len);
+		cifs_resize_file_locked(inode, dest_off + len);
 	}
 	rc = SMB2_ioctl(xid, tcon, trgtfile->fid.persistent_fid,
 			trgtfile->fid.volatile_fid,
@@ -3776,8 +3775,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 			}
 
 			new_eof = off + len;
-			netfs_resize_file(&cifsi->netfs, new_eof, true);
-			cifs_setsize(inode, new_eof);
+			cifs_resize_file_locked(inode, new_eof);
 
 			qrc = SMB2_query_info(xid, tcon,
 					      cfile->fid.persistent_fid,
@@ -3825,8 +3823,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		if (rc)
 			goto out;
 
-		netfs_resize_file(&cifsi->netfs, new_eof, true);
-		cifs_setsize(inode, new_eof);
+		cifs_resize_file_locked(inode, new_eof);
 
 		qrc = SMB2_query_info(xid, tcon,
 				      cfile->fid.persistent_fid,
-- 
2.55.0

