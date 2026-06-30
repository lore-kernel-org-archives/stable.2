Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3411DDC37
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854280; cv=none; b=dXAwi5VjS/mAUUitYR25u6D2zyN6o46tewOEzuOl6qw9Pg4Jw48Jj99n8DxxlD8YeKYerfENm6I2cZvYGz4iy01HwI6DGcwxwl+EORNuAQ94zV1G/PVOgM5u0CRUZQApFb3BfhrMylosQIgguYZMOCCwXorhQ8tIv8tWYbR5eMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854280; c=relaxed/simple;
	bh=1gfTG8r17InAvWVOuauyVqtQhqiNXbc6nH97XNyOiec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sqysz8Ll7kO4B9aGmfzoylfCpRstydyeTUAB4mQUsev77NKsA8fJf1jxRvt0G8RTH3CSPuMJVFBted4ybYBY7MAcO61hrnMphke5gwIsoxyLq+FQz3G/l7Xzp1Kx8ZP3I4kE8AVEEwBnd/dL3JOIS5C0fuiwv9DftBEHHwtxGXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1AIU53+; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1AIU53+"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7ff05e5d009so37142117b3.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782854278; x=1783459078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPhVhhlEs/4/VupytmipRMbVj77VuW2OuCbqLDIFyug=;
        b=I1AIU53+mkXf8gnACaus9jvVWmHmjdaEkyG/XjqRUT1WVL2mD4vxtt1vkdoTM23Rx4
         Xw8gFRpDNn3nKgWe2i4zy1TiavG7ml2LFPPlrfuYz5czT+ex2r7CaOeh63EJNCqH9teT
         o5vYhOXR0Lg3QR+zfN4ridCdy5NtMAy3+bmEqhxASiuLJeky8i+dIDQYYXBIOxWRbYJ+
         6rg0PzOMUCjx6F0zHJZIqoiZOrECaFA0Ch3xQwRodL5svuS2fcANzFIkK7xxnqrg68hX
         rpH/lGRgq7Xsc7kZfDzgbYA4MRuB5JgyWk5OhshK2RdHzzdnb7iwFFx4mFyh0Ts4qR31
         eDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854278; x=1783459078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPhVhhlEs/4/VupytmipRMbVj77VuW2OuCbqLDIFyug=;
        b=UNZMyLQaN/lM5qmTELrL07WYyIThXjfqlYr9zp1Ik/FX2eaHC2E7MFQylgXgEJqulI
         IIPgPJPXl8FDVLMykBmqdtRihQkpZFOLDqrYmwj4g/bmoe5dGi4qSj1Q30VlbewlYE8M
         ekhLgFsmHxBvNiz/dha0jrFeZk44nu9b50vMzQiRqpEwqSKwW2zXBSRNWLMl06vVRwRe
         FbJMEzWpVZuwIcweLcPvo9gYUnHRi1LhmjdjaMOVaT+GL+pkaGac2+ujjvsU3FK0f1+e
         LDay7Ze+phtb31QuJY6MBj0YBILQU0vg/5pTehdh3pCg/X1QVXsDU/OhsvoRHbFg4Qyh
         RNNA==
X-Forwarded-Encrypted: i=1; AHgh+Rpgtw2Bc81WcYcA+wqixzQZ/jCXHFJQZcjwYqYhbpBRdoupPIyDb5Ac6wlsEgylhk+XZIPjKHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytNyiRIEnvgei8fbaYnaJxlkxF9OVTRJIyWqzYhIqd9nIdpTB2
	6axswZEXEO/g9nbEWmisKMN3t5A3MROSkyhp/XiuNwxOir9dbWtZOzNQ
X-Gm-Gg: AfdE7cnQEiUx2h6AEtIsfHYlAUInS5SIRd219hEf3KZ83KRyF+kQhENUWuloNtg9CfQ
	Sl82jCQ6NoWlJ6Oh9Yg1crS6XByM0uB5jlHM9i3tLV2scrpVQuWgd+M1MN2PQTv4GOflin+E8K3
	2wPYGs1Y9Tydai9fdWY2ztVnzbTZGFtcQpoG7d6i2S4n/fVeHBz6XrnJ7YClwTWjw0rq18QM8HN
	+9CCxw5P/y9pUY01Dz0/T1xM+iAJ8MVQosnbW8A9nEqJxQbyfN+DWcWKR2nGvUN5Y1Bj3nm+vwN
	jO2inBCeHY/fnQANe1zikAyBaESbjvvqwVCS0eAl93LxjXQWRDhnr5rRih5Ar/v+nqtPo8gDBpm
	oIU/BvuhwJlRYcYcI8Sm0H9+DoVexH0/q8vd857uKWUpRw43dzUWDvQuz/PQwXjDAdgPFlYpeb6
	zFEekSf84SN1Dc/+//4Omil1xgy07TqRAKNCJt
X-Received: by 2002:a05:690c:670f:b0:80c:85b6:765f with SMTP id 00721157ae682-810da90d417mr63206517b3.68.1782854277959;
        Tue, 30 Jun 2026 14:17:57 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8128d450908sm13827b3.36.2026.06.30.14.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:17:57 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+4b4ec878e25fafefa70f@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] ntfs3: reject empty iomap before reading its LCN
Date: Tue, 30 Jun 2026 23:17:43 +0200
Message-ID: <20260630211743.50400-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

attr_data_get_block() can return success with a zero run length when no
cached or on-disk mapping covers a read VCN. In that case it does not
initialize the LCN output.

Check the returned length before comparing the LCN against the special
mapping values. This preserves the existing -EINVAL result for an empty
mapping without passing an uninitialized LCN to the comparisons.

Fixes: ecbb433f9a8e ("fs/ntfs3: fold file size handling into ntfs_set_size()")
Reported-by: syzbot+4b4ec878e25fafefa70f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4b4ec878e25fafefa70f
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 fs/ntfs3/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index c43101cc064d..a428f03a695d 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -777,6 +777,8 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (err) {
 		return err;
 	}
+	if (!clen)
+		return -EINVAL;
 
 	if (lcn == EOF_LCN) {
 		/* request out of file. */
@@ -811,11 +813,6 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return 0;
 	}
 
-	if (!clen) {
-		/* broken file? */
-		return -EINVAL;
-	}
-
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->offset = offset;
 	iomap->length = ((loff_t)clen << cluster_bits) - off;
-- 
2.55.0

