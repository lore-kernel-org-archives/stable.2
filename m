Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8EC3890E0
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784918884; cv=none; b=W1FDKBIqfjO4GDqVBxt3ikOX7d/NUdYAZW4yvouTDsPE1rU9ddRl+mx9UaEINMFM9sK+0EOKgIFGrfiqO/wpfS3WR989cCKNj57KMTROEzaEzzyU9YcC4t0dhzhUTiaXxOl3u/qc75X7wlqbg7Us/4ZoUkwEBDDl6dAqr/nsf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784918884; c=relaxed/simple;
	bh=MB1ARuhcLDoc0HU7f9faKdME0mb9QLxkn3iQ00IjaLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dw2tlq/K3Cogo5q0og098MtmZVALvObEUzp6OpzLPn9RIsesTFZD6UvnsXBET5dYNmNUEwzKXdyw2WNM3j8jurwG4RC434xLBe1l/5/w1PfsctC43JTJ4p3Hbs1PBXF62pEJ06pwu4jPhHRpDtkTdAIuOPj/4+ZuUOqQ6R1AJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RB9Izh/F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJtGQkNE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RB9Izh/F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJtGQkNE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784918879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N406NhHNRarOiCpmNzhvLrYTVW7/Nzu87dD/ueM2CnA=;
	b=RB9Izh/FtxLBCoGQxnURmk2uDeQD4jyhhN0OjZIAFtj4WpWpBl8rqb56aJksiKEtfDNLm5
	l/OkEb8ywZbvpixcXoQ3r9YjiBqSEbsRz5DJGbCz5bxbZq50xFEd5aDZnKMBnOdocNcZ23
	6juKRxLKbZJZO8UfOfKL5Ktnpz79BF0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-VdUchDdrPNagC-KkWlEboA-1; Fri, 24 Jul 2026 14:47:58 -0400
X-MC-Unique: VdUchDdrPNagC-KkWlEboA-1
X-Mimecast-MFC-AGG-ID: VdUchDdrPNagC-KkWlEboA_1784918878
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6b5976d74so706578a34.3
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784918878; x=1785523678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N406NhHNRarOiCpmNzhvLrYTVW7/Nzu87dD/ueM2CnA=;
        b=GJtGQkNEa4foKT5lv+ulJ9PfjWCAd99qQxjT5ANl2rI1dacAQnBd0Ne5KoUoJyGGjw
         lZsjpLlG7zhGTSllVAbOmUVd+RmclGMLiFustzyjvRKG10k9Olg+eUaST7joHFyQB6Dz
         oz4RYTyk/kljYIl9J1c0wnZhlkONaPgGKleLz9UeTHMM1RPAkcABukNbHtcQZkRRHObB
         cDbkn0Rp0b3mCYu35U/Gze1zXnZf8LSo0GZPr0dpYiqEN/VRQODbbZSF2rBEQL9WqjPB
         5tcr7wCR33r96uYWHeyZhv8fYU4kuy70ZUjxk4eRcxco3UjeO8ce5pYGLVdCX9WRI/kV
         sULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784918878; x=1785523678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N406NhHNRarOiCpmNzhvLrYTVW7/Nzu87dD/ueM2CnA=;
        b=n177Z8hKgbLc9bWj1C6YatCNROdXAgoxEVYf3PKt/BaCaHBisd8J0WvQr4vqseGsdD
         dyttlbnbpTN4f7i1Wm73IpAaTn12xZDLytg0Z8w39ldQP0QtN5hkOeITxd+9hfedaM9v
         0dphqmIeeE65B72uk9r1L5BWuVVTElwiVcplnD5h/flo4qCCkvPLDFUnZMfAo2DRPkaz
         xNMRuO1VWxPMIu6PD4mvmQpVVQvM5Yp3BDKQs6hTCsJqabOiP0wFRZ//mwUrhdDunBTt
         IUhkNy29vuK5g576mCJmlRJC/l5V5jisOFJJjVz69ZnE5SbfrmBxxVpWibrVtYS5LefW
         OuRA==
X-Gm-Message-State: AOJu0Yye79WqjZNiEPzE7keE/7o6tiHNKi9Vmj12R4USVe5A1mI+IePi
	ZSFsJSQqN4xzJI48oKzZ7NX0a21AQ5gzzHfBFIRZoStNrwm4yjgMFOxQD08V99SBmt4dlAHc5YH
	2KUG3f+q28bWCRGcDZOOH2OKZHOovkGRN4cxe0yVjgR470onWeQcneOGljA==
X-Gm-Gg: AR+sD13EPa8Zckdy0MVmmu5aULf6AzCeOv3SMH8Zur/IFJmq9j9rhbZIB/ZPPiJKObD
	/zC303c8WNXUcXBvAE1ZSA5w0S1ttSWn4LgFCegQwAzvetlr0lzMeRYP1o5/Qtk/oxR0PbYoTVN
	yVfh7dkeEBhS57GeP7q3HJ3PvRoozfjfV14yJliR0+3u1xniz95rDxmhFAsNRdX3pI6y20hckTR
	ziZZ6QjNntilB8rZgaD5kF7Vy03oYqsHyXUXGkunvaxzlgANUpg1DgwcOxAR+bQW9lCaO7Ol3Cq
	wsMyBtxhgI0ChNn9r4G8ymrkejtP9xNSh/+JlebZlbivhG4eYCwytX43CM1uAkxi3CB8khHfLsd
	SDybxGNmcSUWOL8gUsWYu6hSF0U/YjykeAJtsbVzzJmqSGdThAPRutWGPyn82
X-Received: by 2002:a05:6808:3506:b0:496:2b3:ae70 with SMTP id 5614622812f47-4ab35466e19mr5221903b6e.25.1784918877733;
        Fri, 24 Jul 2026 11:47:57 -0700 (PDT)
X-Received: by 2002:a05:6808:3506:b0:496:2b3:ae70 with SMTP id 5614622812f47-4ab35466e19mr5221878b6e.25.1784918877274;
        Fri, 24 Jul 2026 11:47:57 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab3cc35415sm3580396b6e.6.2026.07.24.11.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 11:47:56 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org,
	stfrench@microsoft.com
Cc: stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH] cifs: fix missing fscache_resize_cookie() call on truncate
Date: Fri, 24 Jul 2026 13:47:55 -0500
Message-ID: <20260724184755.2708212-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 70431bfd825d ("cifs: Support fscache indexing rewrite") intended
to resize the fscache cookie when file size changes via truncate, adding
fscache_resize_cookie() calls in cifs_setattr_unix() and
cifs_setattr_nounix().  However, both calls were placed in the dead
block guarded by:

    if ((attrs->ia_valid & ATTR_SIZE) &&
        attrs->ia_size != i_size_read(inode))

This guard is never true on the success path: the truncation function
already calls cifs_setsize() at its set_size_out label, which calls
i_size_write(), so attrs->ia_size == i_size_read(inode) always holds by
the time this guard is evaluated.  On the failure path, execution jumps
to out/cifs_setattr_exit before reaching the block.
fscache_resize_cookie() has therefore never been called on successful
truncation.

Fix this by adding the call to cifs_file_set_size() at set_size_out,
where the size change is committed to the VFS inode and page cache.

Fixes: 70431bfd825d ("cifs: Support fscache indexing rewrite")
Cc: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 808085eb0cdc..e4ca82c52e7b 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3127,6 +3127,7 @@ int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
 	if (rc == 0) {
 		netfs_resize_file(&cifsInode->netfs, size, true);
 		cifs_setsize(inode, size);
+		fscache_resize_cookie(cifs_inode_cookie(inode), size);
 	}
 
 	return rc;
-- 
2.55.0

