Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2232B126
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 02:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170757; cv=none; b=HZQLtL4tz6zDGXivWiGlsEAUmxKIj6+98tV/ql8ZcNBiFSmXs6X5r/F5NkZ/GYvdqTTaOzsFnhbyiI1C+9nKdvqt8NrEWizrZMDCTEsmn9tigPPTERgVQ65yYJCNX3zQjKIJeE2zYk6TcGbjIWCOtFoNN+/Il4C0f2XtxQL+4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170757; c=relaxed/simple;
	bh=xJQVBstrpp90gUhqAaKJVzjTXXjMLAJp5c7rkABifvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRJQ2r4VFNp6ZyDoI72j0C2kZzttm/nDAgVJ6AyQl1RL3HNmFXgNUAQrKsQUjZqfEpTfmrdOBsUdXCG5kP+Nbz/oacUEmm8g6OMx5na7j0/DYNhnGXJCaAkx7UdteyhjnbrSY+GmjyooecVxac995WvoH0v3BBTWPLk8fPgalIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz+hrCiv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz+hrCiv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cace91f112so57959975ad.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 19:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784170756; x=1784775556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sea8lelRxE+zBLv16TImL7g/EOZ5/pZo8t/0pWuCD78=;
        b=Mz+hrCivQTA+Dyu7lCgP7XlvSSjUO5sWVenyydJG0aM0T82oIAqYxCEYNT1eJWXHyi
         OEhN+xZAs2lrXH8z2Z+O80kLgU6ppDLDAXjsqy1/WAP5GVeqTD7Z6TGZvaNQk7vWa6ih
         ywFXtOtMCTngzYegBQ+pSKi5rbgcZi6lQ1AWGqP/XJTDQZ4BHi0hh2Q2KXaubpuwVM6q
         c4JIV4vwi4FYaVUUDQUVnxhVHF//rDlXi5KUzURU7jslQxSP/llh1oLGptJ+YMllHSf/
         U/uTJAR+R0UXAvJCpyPHBVPcndEJ8zefchpCQjJ3WtP8IfgdPA/pJFSoY9lmntM5us8j
         p2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784170756; x=1784775556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sea8lelRxE+zBLv16TImL7g/EOZ5/pZo8t/0pWuCD78=;
        b=LYUmFzlSnUcWHg2dw79hRASoFH0AhcVubFvgBnqIA9nOnWHXVbbrel3k33pDo78MqH
         nbPWkEGkzNzWanTwprIgvl6leqSZx9HST0ZMpx5jFlGMXnCQWeQe/2d+i/SwNavOJkVh
         Vf6SIjpKedFwPalkkp+IPXx6+yvOm0rYMuvx81xpPvy6CvrowOL85Fgk2VaHogkbTrSd
         Yina+hpt/OnJyML8hOFqMKBfhM3JWn5Rs+Y5cAiPCu34UgE211V3GgiU5BYPBuZH+3y5
         Itk4uYniBYTUM40ocDJST+LwpKwmml6H4CQRd65Al3fILbjjKbhscLg0vTQxMDakAtId
         Pryg==
X-Forwarded-Encrypted: i=1; AHgh+RoJtZliYeDxLT5O4R/vgMko4OHIpT6VeoJliL684hjiy+FIjvbIpDgmarCgHRvyEtWWeK6pxfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMmiLBjLLanaiRmwh8Gpzk2e5JwCEIxc8sEXCSgintZleNd9e
	DixduVSLbqRSqz+SOEWDWLnmIYnasOyNAtEx8cM0hXun7HRAncG0ET/+
X-Gm-Gg: AfdE7clCBAzlyODXhQTCDQjJRB+tF2qARqLnRsTtK8nO5yc0C7Wa/b7IcL7QPHVgV2p
	7+PnyINeddAL4Ay+jJbZoCZI7jS1oG1fdm0Pm32vWkCMj/Hf1lQV6/ls36QvHs4OYh7JIPfwAjx
	jriSw2RYHSZRrTnGcyhq4mhlt8Fe5MlpmyL744NMPFFqU8ScuKTxNO87A3XypfDTgvM+fFwsAfS
	u82+WJSVFfYhmaDa4OPdf3lo+92f5oSaHwpDCAUqcDzDxJKMroPM8nhHlja8q7VI08tRItffKJe
	1GhphSzQVN2wq9tSv19PvrZJpxKl9zy1eNTDyo4+dDLd0MCucqkrkV+CfwNSpsFlK4kqmAXmI0J
	v/V/YBf9PHySaM1W8pxqwMGo1y/fbeJGax++ummrVT9p7/XJPOf9Q7J+pd7e5VFBBYTBmXq+tEe
	jJlW0zLz7xQ5dx4Q==
X-Received: by 2002:a17:903:1a84:b0:2c9:d8c6:1dc3 with SMTP id d9443c01a7336-2cf03aee8cdmr48274875ad.0.1784170755668;
        Wed, 15 Jul 2026 19:59:15 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf10731540sm11688685ad.81.2026.07.15.19.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 19:59:14 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Jan Kara <jack@suse.cz>,
	linux-f2fs-devel@lists.sourceforge.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
Date: Thu, 16 Jul 2026 10:59:08 +0800
Message-ID: <20260716025908.608098-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_xattr_advise_set() calls inode_owner_or_capable() with &nop_mnt_idmap
before allowing the "system.advise" xattr to be set, instead of the idmap
that the VFS passes to the ->set() handler.

f2fs supports idmapped mounts, so on such a mount this checks the caller's
fsuid against the unmapped on-disk owner rather than the mapped owner: the
actual owner can be wrongly denied with -EPERM and an unrelated caller
wrongly allowed.  Pass the handler's idmap instead.

Fixes: 01beba7957a2 ("fs: port inode_owner_or_capable() to mnt_idmap")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/f2fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ed33e5110f2a..6728d1488cad 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -119,7 +119,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 	unsigned char old_advise = F2FS_I(inode)->i_advise;
 	unsigned char new_advise;
 
-	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 	if (value == NULL)
 		return -EINVAL;
-- 
2.43.0

