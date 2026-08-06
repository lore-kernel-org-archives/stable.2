Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212B431A30
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059802; cv=none; b=k43bKvp4DCfDUUHzvsBrwQ/gVj69vSVITVBkQHaVpV6Iu1RxvJjXPNj5R70cLTfbZFFcUMBrZknmoapW3BBL3VvoigfUn8PTHSFvV+5MWxUfuD20/FCAH1ed7LwPMJHLaQJOel5eJ0g5A9e1CbLGayFlKr07Vr2SxnjM4pNUdrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059802; c=relaxed/simple;
	bh=ApiNRPTD0e/dpTH4sE6IKJC4jWIcl81cNwAEZuckU0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu4D8Z09M9yrNLqSxwGzVFlts7mP3Q+uEy6h8Vmp5vR5mCSN71M5+NRyDUJDxV9PHEOdlH4VqT6WH/+NpEBxmBs7gFQomenWV33VU9noQtPnQYAC3gxSfDGnp08ZQCWoWI7klG9lPCbcpDpoXEbuYh+YukLU86NZJYEoIKg4wB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5UOcuuq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XK9xuBf8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5UOcuuq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK9xuBf8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786059799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1iFUSkJJxaXDGQzVMDBfKr25aoR61PK4Uc+XTa9ttM=;
	b=M5UOcuuqMw38MkpZ2iblxPEC3yS4iicFgCclWz8moZ2EkR0bs+C8scYxkBFRJUMnDCRYVC
	J5Kd2XHvn30w3J1u2nERBvY3+7YAjqMsiDnySiOQ7EU+bJCRxRaoaspDK1VF9ZCpszR8m0
	7w1H7jZZujRo2qMnaQ5a7gA5CMpBGws=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-mfLMd9mXOQWv7gwPyDWTLw-1; Thu, 06 Aug 2026 19:43:15 -0400
X-MC-Unique: mfLMd9mXOQWv7gwPyDWTLw-1
X-Mimecast-MFC-AGG-ID: mfLMd9mXOQWv7gwPyDWTLw_1786059795
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930f5da3467so282363885a.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 16:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786059795; x=1786664595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e1iFUSkJJxaXDGQzVMDBfKr25aoR61PK4Uc+XTa9ttM=;
        b=XK9xuBf8+sw1njC98oAv19mWDWw2y04lj6chq12VrqHLp4S+199Ixghxoru78SGj+4
         4XJ4+LnjiX8LxuRKBoTnB9avqulhxWJUGsZMBAKVlmv5oU7LZcyQZOAgTDZHNe7dFB2R
         hIYRVSvL1kwmnEnhRWSktL+rBii8D13KHNIaFVgyUV/xklGiyAP9o5h2//Tw+jrpe+XW
         PrvdieOMZJenaST8badzFqvGZSMC7ela5eVJsSdx/Vkq60aFOI8deae+xftDZP/o920X
         K8L/TiGPkshhaAOD7qFB2cmU2ZI4cBdm2ugAHKf/EzfpjAgCm9+RgwReMtICXCI62y0g
         phbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059795; x=1786664595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e1iFUSkJJxaXDGQzVMDBfKr25aoR61PK4Uc+XTa9ttM=;
        b=oq1WoYqQXqMb3uNmCg4kYjcnZw/Wk7gLMg3SowiNiBQWO6U7fQ7MtUO4GxqQv+elRz
         uv7cD7b/pv5UYzxdhs2R1UMts/obSdgzqXvclc3GFNT93FEp3hCte2gQeWpyPN5JUcQT
         Met9HNh7fegQv0xQYqh+NlBDssG7pOUtV52xnhHJ2VSFyyReTkjIxsIZeymoREQZF3Ey
         9s2oVeTWqeZE67Y1KnW700cSnWpx+j8GyrKusM4sr/Mw6MvWDEiPH6gekHvJ9nWfs1Iu
         qIRp54Bsjyo2ksp8o2js2SF7VthB3XUMD6+zP1GOUjXdQVwTsA5Rr7aNVfwZjc4Mvcex
         dWKg==
X-Gm-Message-State: AOJu0Yw1yB7FAvMkm6pWCrdMXgGzuK7GOsGzjvG/RSROw5Vl+v1qJe9g
	tEWLU7p4tORpmNi6F7xWimD3TJz8RSVJba+aBhvMSlC5oGzLPqDevQRmPgGypxqAP/GtwmJ8PZs
	0qn3GyujuUF4INZM+Dg5V4EeuaFS0fHIbbiGg+JJj9fKKxoHgNSvMxYVevA==
X-Gm-Gg: AR+sD12oTpGUl+RI2G2LNWtqmM7iMIRWpgGU14bySU1eqhi+ipYqyNryH5lBqz7Iuzl
	czpF0hlDQZBaU7fsjGzemzrxEJihhtZBfYRKqB/npr9q18omHsG++r0JtXUWrOq+v5CA8basYWC
	LJFEwWAj0UD1cQsk+2Bp1LV+X9gApcEOYI9mXGqVjOm3fSwBjFmF/1nCTFDils4E7cbRLIANFAz
	P8rlXqJADNfExU7BpJvumodjLepJsrsBn7Nst+145jQmLCRog5veqYYPYAsfkGgbJZ2g14qXuvc
	WxnaisWgXxalNfo7QrPzODnGpyNGNB0c1IEV8c0dF3f4tUvHM0JtAvISmErnoAHfKQDnv17iDFI
	miURW7rdsy/gRR/m/r7r5txAKqd95KT0Y1ubuyFx7Bh8543Cex5h7WQphLyXZl4FYRQ==
X-Received: by 2002:a05:620a:ac1a:b0:915:e9c3:f1a0 with SMTP id af79cd13be357-936490e5be0mr1663850285a.12.1786059794875;
        Thu, 06 Aug 2026 16:43:14 -0700 (PDT)
X-Received: by 2002:a05:620a:ac1a:b0:915:e9c3:f1a0 with SMTP id af79cd13be357-936490e5be0mr1663847085a.12.1786059794312;
        Thu, 06 Aug 2026 16:43:14 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03f05bsm26891485a.2.2026.08.06.16.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:43:13 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	stfrench@microsoft.com,
	pc@manguebit.org
Cc: stable@vger.kernel.org
Subject: [PATCH 3/3] cifs: fix loff_t underflow in cifs_remap_file_range() when len == 0
Date: Thu,  6 Aug 2026 18:43:06 -0500
Message-ID: <20260806234306.3662175-4-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806234306.3662175-1-sorenson@redhat.com>
References: <20260806234306.3662175-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cifs_remap_file_range() is called with len == 0 (the clone-to-EOF
semantic), it computes the effective length as:

    len = src_inode->i_size - off;

If off >= src_inode->i_size, this produces a negative loff_t that
corrupts all downstream arithmetic: filemap_write_and_wait_range() is
called with a wrapped range, and the ByteCount in the
FSCTL_DUPLICATE_EXTENTS_TO_FILE buffer receives a huge value, potentially
causing the server to attempt a multi-terabyte clone.

There is already a check for off >= src_inode->i_size at the point
where -EOPNOTSUPP is remapped to -EINVAL, but that is reached only
after the ioctl has already been sent with the corrupted length.

lock_two_nondirectories() is held at this point (i_rwsem write on both
inodes), so i_size_read() is stable.  Add an early bounds check inside
the len == 0 branch and return -EINVAL via the unlock path if off is at
or beyond EOF.

Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/cifsfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2073b29ff969..bd4936711ced 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1413,8 +1413,13 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	 */
 	lock_two_nondirectories(target_inode, src_inode);
 
-	if (len == 0)
+	if (len == 0) {
+		if (off >= i_size_read(src_inode)) {
+			rc = -EINVAL;
+			goto unlock;
+		}
 		len = src_inode->i_size - off;
+	}
 
 	cifs_dbg(FYI, "clone range\n");
 
-- 
2.55.0

