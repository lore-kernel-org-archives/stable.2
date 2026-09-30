Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86D3D7D94
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801253; cv=none; b=Ny/6d6kD4WAtzVYqnwVRn0r6kGEa5iA3oSizWqvtT8zSPITa9k98diD5LbSALiEKF7bEphDImvTLgpoY02MjdxeLN89ia0ARFiqF+9RXT9gC6ERF+ixQv9h0HVY4zTvRGAjqPBBXB6UA20xST9jL53ijsYgGBoYqDilgcvvxXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801253; c=relaxed/simple;
	bh=qQrzRo/rm72frvt0GFSzQdpNFSAmGF3L2cNdOsx5Qq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6gAqPyo66gpT4Y3/UIoiur79Lp1FDM+EEMKuEfQzJMMW6wvtGo7XR3y4+kBBSAsWcMmsfUzwI9nEek+wD8QSaXilL5kwniPflvgExMshy4OK1HrJmoMms/aQpSaaWeVGeEDFNF/6434IVNxCO7lCOrK13pf0dmjdUtRgErUAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyNLowyE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZYgEvRH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyNLowyE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZYgEvRH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790801250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+uA/cnv4x1TihM4U0TJtTPq5/hth5IOPncilpl/ZYVs=;
	b=XyNLowyEGWcheirBgwV6Pj4bFvxGTDB42fiZqMqdCv+WqmvdtIeXXte3Rz39Ji1x0TsbK/
	/u36+fPC4mXojETPqkn1CNnllPUGSZpepmZXlYJUEd3Q78tLtPKZVs0j7IbAtFAULq6+t0
	ts+loMKbzJ6yCsPIpglM0KoFwFmAn6c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-PAv_p8EvO--yyGYepcRGMw-1; Wed, 30 Sep 2026 16:47:29 -0400
X-MC-Unique: PAv_p8EvO--yyGYepcRGMw-1
X-Mimecast-MFC-AGG-ID: PAv_p8EvO--yyGYepcRGMw_1790801249
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934963b2bc0so1503743385a.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790801248; x=1791406048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+uA/cnv4x1TihM4U0TJtTPq5/hth5IOPncilpl/ZYVs=;
        b=ZZYgEvRHIGfwal9XHFePW5fJ7NvuuboYH5fSrt4lVH8Y1J5u/50qO1H/68rnONrl5G
         d/HPcCyN2x30LytI/V7sbWYowLzZGlG/5iFLDXUPDJVCPXkW6hqUZXJpoI0xTey6fT0X
         2gqxDKpvLsfVEgWNMlPdlpSyDehM3LjteH+K9KPUjv98zIZUZ9NZx9XOM2GHLwnpCycp
         NeruuRah5kb9U9YXBIb4qnPJqujZlK+yRU1k8RS+fIGmSv2i87dwCY8nmtJ8zq4y37Bs
         D27y4FDXHjctPhNjpJfTsx5UKsr1fBBI3pVkFfOyOh55lgrwbMjjAkhdxE9tA7CELjpN
         8x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790801248; x=1791406048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+uA/cnv4x1TihM4U0TJtTPq5/hth5IOPncilpl/ZYVs=;
        b=eML2RJP280vTwXFzJxoQVCSdPwGO3rAHMl1mZRarQ5Hr2alpD80GjBZakiScHbjnHe
         FXXKvD3q29wKUDbFMn+3PMWhuvQiugn64cJYdtsmFJ7LWcka/d9GQ2sqtgz2gInR/yFU
         fW1H3YApYQhpokbZ6rYFk+ylHhGr/U/0aaBFql5z3Kvf7cdu7esTI3rg2wZPxmeRrLTB
         hCFPwCRNYoJfTNFxQRr1b64C7keP6MUbgEeMB1CjTb3Sly7hUE1IrvedUHiNXP6RhJgg
         ZmKMvBzKe0bxEFLvCst+vL6lQ9uyN+rPC+QlOvzLsjS9AiCQj3H+BKpjjTEGvxOrWQoi
         k5Jg==
X-Forwarded-Encrypted: i=1; AKwUvBxJANhyJ2YH3RnQmDEEp/dPU5ov/Xawl2bmd0DS4f1pq17PgC5tDNLvZDwSdEdEZNA6XuIyeDE=@vger.kernel.org
X-Gm-Message-State: AFuF++kT934MpBzWQK9TrD3tHk6Yv8/3Nna/dRI2/KQWglKuKgNFBqOJ
	10o6GLDvxZoEp5uDtY4U8W+XWR1BOc7rju5gt8sJ3vQ5YeR8TvDqPeFMoxDPIGRPKseikCV4IQY
	sepsMAMN4bMoq5FNVGFsAXQ0/DOSMIIG5pSuh97P+KGcGN/F8Dp1NA+jMpg==
X-Gm-Gg: AYBFou2rvpLMr9eRAGRZEondnDQ/amU1/QW0NcCtmowH/SbW1EPqkyz7QLlX3mLFhxX
	CN6stz2H7q6HSjQ7+KyRIizAy5Ju2IMLl011ZYYk4QYbuXxv/2JKO0vZOyfBIbf+3S4IC+Tllcl
	GdXV0OOWtNKC5Nlt05m9BFEXjVXGhCN9KpW6dlquMQbIlRqWnyne/hm9VuLgi1YeJR3ja9KLWHv
	IagSA8iK0/2YTWKvoXpGGUT+2MPwofEUvxyKUSQhNVs4HNaoyYVtcXP580TgKqBLYRotnoAXcq8
	EjHu8N4r1iXLMlkPZUnL8ZVZq2DZYJroXhk9/JqwrDVyrFV4f9kvfHkuT9YHVvil0hjib3n1mIT
	7KO0NoUNCFOs0gYQ5/1AG6fAsYr3GDDG3t/4d64hAwz/YXsv3oYPks2mHfeJYZ2TQsg==
X-Received: by 2002:a05:620a:45a1:b0:93c:735d:692 with SMTP id af79cd13be357-93cac1367b5mr427232185a.27.1790801248519;
        Wed, 30 Sep 2026 13:47:28 -0700 (PDT)
X-Received: by 2002:a05:620a:45a1:b0:93c:735d:692 with SMTP id af79cd13be357-93cac1367b5mr427228585a.27.1790801247994;
        Wed, 30 Sep 2026 13:47:27 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cb6556ebasm52169885a.30.2026.09.30.13.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:47:26 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: split cifsFileInfo bitfields to avoid shared-byte RMW races
Date: Wed, 30 Sep 2026 15:47:15 -0500
Message-ID: <20260930204723.1555769-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The invalidHandle, swapfile, oplock_break_cancelled, offload,
and status_file_deleted fields are stored in the same bitfield byte
in struct cifsFileInfo, but are updated in different code paths that
may run simultaneously, and are protected by different locks.  Since
bitfield assignments generate byte-level read-modify-write operations,
a modification to one flag can overwrite a concurrent modification to
another flag.

To avoid these races, convert these flags from a bitfield to
separate bool fields.

Cc: stable@vger.kernel.org
Fixes: 3bc303c254335 ("cifs: convert oplock breaks to use slow_work facility (try #4)")
Fixes: 4e8aea30f7751 ("smb3: enable swap on SMB3 mounts")
Fixes: ffceb7640cbfe ("smb: client: do not defer close open handles to deleted files")
Fixes: 173217bd73365 ("smb3: retrying on failed server close")
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/cifsglob.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 79e4e84f8985..5c5b76a9e9fe 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1450,11 +1450,11 @@ struct cifsFileInfo {
 	struct dentry *dentry;
 	struct tcon_link *tlink;
 	unsigned int f_flags;
-	bool invalidHandle:1;	/* file closed via session abend */
-	bool swapfile:1;
-	bool oplock_break_cancelled:1;
-	bool status_file_deleted:1; /* file has been deleted */
-	bool offload:1; /* offload final part of _put to a wq */
+	bool invalidHandle;	/* file closed via session abend */
+	bool swapfile;
+	bool oplock_break_cancelled;
+	bool status_file_deleted; /* file has been deleted */
+	bool offload; /* offload final part of _put to a wq */
 	__u16 oplock_epoch; /* epoch from the lease break */
 	__u32 oplock_level; /* oplock/lease level from the lease break */
 	int count;
-- 
2.55.0

