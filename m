Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D873CF20A
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844661; cv=none; b=e3Rtb7rvDUSKv8oByBo/ozoL9Meshp4eubzdNdMv/kLXLUFHXIjBC5qophD+hh6OuF7qM1iV2FucsXZqKYTaOw2wF53KOjODMG9AsLJb5P5G9KVosM+kEqG1Fz3gSHwXVUoS+Q0Yu2fBx/4vkpwgLPudMFESKdZz52EObfcPik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844661; c=relaxed/simple;
	bh=C2Zn4CbY0hbSGyEmBt2MEmF1iqU58U4gSfRk9aHfces=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/BHuCxqb44Mho4CeQWb/6djmIUh8dV5KGX9b/r92vEflGzg6va1qXwqV7W9PfHY401fi4FRvVUMOyBGbFv0ysSJaW/3h4KAeTdskujDZq1roOvJDekFziEP1kUvN9gxS2OYyBWMwKrSLsWLIpk42FmGKxM3Nxion2UkY1nPYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRsAf77j; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRsAf77j"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1c24ec9525so175254966b.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784844658; x=1785449458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n3sImDHanXm/nP3OwyjC3fU83vihxLVlwyFoNqtWFgU=;
        b=ZRsAf77jzBdCVplXum1b+cqawbil6autyF44PDzTpfxcIe1nkfTYLz5n/vWqYQt0lF
         XiMeTdt2C5EXt/bGzvdurxs5MK396TXhMBjB4LcIg0XdIDjyOztUBsJnC6hVJG7AoCIV
         qFa5jWwcqFCoGu0yMnIX0PFXpXpLrZ9VgpwvuQtiMdnfaIz7Es6OXO2coX52KLlC+JFG
         425kYAeRgYV54CgCkk0nvEP+IfiHJLsZTqeaahCqHamBkluvzqiBSLZa2JvQuP3uUhhD
         60WH3/xrnJv5ffELmbtALODgc9eNeA98bu3a6NaF/UZV7p3vfxsJHLzicfKCUPkCmvKK
         MI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784844658; x=1785449458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n3sImDHanXm/nP3OwyjC3fU83vihxLVlwyFoNqtWFgU=;
        b=pvA8jbD5Pkd1mwnani01QLaoJh999YXK4mSrmSzUs4XC4OkYBxWDKUsaJA28GiEfAp
         PIVu4oB/kbplSoyoRam7eHFlsA1TMQ3Jl/fU8HLh1iEoldeEdKTe85V0gRrtw7rPS9iY
         1BLVkNQmUv41QgXi0GF+l0yeAgCKd0DL5dfXTxH9IpT2lAcPGlG5nQZ0zdm2y1FX3bjU
         kXlp+HzJ5MuZPVCqcI8bXj4iFvbd8eSKZGqNudVLXkMDP+xHcIWzhqX6ZkK1hlmGHEvS
         s0tPunlPzx3a2kfvP9m3M5N73MsAC0SlSIfNtlck1ZCiM/4iyrtVT2RevGQ4FE3Eg1L0
         rbGg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+yZetLG596p08gQrDhPuhHKMzCJySPjzVpr1ssOXj5ZRegzh+yiTIdyW0WSVEVe/KyAKzAs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1tE6HmO4aQah1xXfYom3t/7BlU1EP1Y/tBYdinGh2a9EhPHkx
	8FfPlehM87fuNj9Y4w5PrkAkZj+PtMbRbbFYBsC1iUNLxQghMQCu5M19uh6oEg8c0eo=
X-Gm-Gg: AR+sD12em4VGF9R8301f1K+gglE8ugBnxX/YM0CwMpMnZo0I01SLSNrmqUTjOVu0r1I
	5am9WsCqicCbvY26ssQEhhqEpVqLwTVLEKkJzk5nw8/izi+mDPWiWzacw50/5zPNfTIAp0tQH87
	SBvR8tTCqro41njL015mzEbc2xK4OTo4rdqPBDJwUlTELLuxETLHYdbdmZvsPGTkb3vPDfMsQ8t
	060mwR0PTEMbD8zBcM5ElcyhidLWPm4ldQ7SIkbgCN0AIXMO6NzKj2XGePpWV4ddHk53lHl98SU
	Mfw9qZrPPVmHIfcjRPTxFZqAYpYG/8MvVtNflQdznlstiR4bFXvfWC7dQHp72VZPuikwbq6s1RE
	E3lAQWucXz54Zx9FGB4PVsCr01ZQW0L6MPqYp4FduRmBMB783+4E5uX5ni0JCC2csLyyQ9z5DfN
	N7jwAn
X-Received: by 2002:a17:906:7304:b0:c1c:62b4:1ebf with SMTP id a640c23a62f3a-c1c62b41f9emr108510166b.60.1784844657499;
        Thu, 23 Jul 2026 15:10:57 -0700 (PDT)
Received: from beelink.. ([186.247.163.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32c90205sm280929566b.33.2026.07.23.15.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:10:57 -0700 (PDT)
From: Your Name <qwe.aldo@gmail.com>
X-Google-Original-From: Your Name <you@example.com>
To: ntfs3@lists.linux.dev
Cc: almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: validate that EA entry size covers its name and value
Date: Thu, 23 Jul 2026 19:10:45 -0300
Message-ID: <20260723221045.529665-1-you@example.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

ntfs_read_ea() walks the on-disk $EA attribute and checks each EA_FULL
entry for consistency.  For an entry with a non-zero ef->size (the
offset to the next entry) the loop only verifies that this stride fits
in the remaining buffer, and then continues:

	if (ef->size) {
		ea_size = le32_to_cpu(ef->size);
		if (ea_size > bytes)
			goto out1;
		continue;
	}

It never verifies that the entry's own name (ef->name_len) and value
(ef->elength) actually fit inside ef->size.  A later reader trusts
ef->elength unconditionally; ntfs_get_ea() does:

	len = le16_to_cpu(ea->elength);		/* up to 0xffff */
	...
	if (len > size)				/* size is the user buffer */
		return -ERANGE;
	memcpy(buffer, ea->name + ea->name_len + 1, len);

A crafted image with a small but valid ef->size (e.g. 24) and
ef->elength == 0xffff therefore passes validation, and a getxattr()
with a large enough user buffer copies up to 64 KiB starting just past
the short entry -- an out-of-bounds read of the ea_all allocation that
leaks adjacent kernel heap memory to userspace.

  BUG: KASAN: slab-out-of-bounds in ntfs_get_ea+0x2b8/0x3f0
  Read of size 65535 ...
   ntfs_get_ea -> ntfs_getxattr -> vfs_getxattr -> do_getxattr

The zero-ef->size branch already computes the same struct_size() to
derive the stride; mirror that in the non-zero branch and reject the
entry when its declared size cannot hold the name and value.

Fixes: 0e8235d28f3a ("fs/ntfs3: Check fields while reading")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 fs/ntfs3/xattr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 04814dd29375..57114fb726f7 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -155,6 +155,24 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 			ea_size = le32_to_cpu(ef->size);
 			if (ea_size > bytes)
 				goto out1;
+
+			/* Check if we can use fields ef->name_len and ef->elength. */
+			if (bytes < offsetof(struct EA_FULL, name))
+				goto out1;
+
+			/*
+			 * The declared entry size (ef->size) must be large
+			 * enough to hold the name and value.  Otherwise a later
+			 * reader such as ntfs_get_ea() copies ef->elength bytes
+			 * starting past the entry, reading out of bounds of the
+			 * ea buffer and leaking adjacent heap memory to
+			 * userspace via getxattr().
+			 */
+			if (struct_size(ef, name,
+					1 + ef->name_len +
+						le16_to_cpu(ef->elength)) >
+			    ea_size)
+				goto out1;
 			continue;
 		}
 
-- 
2.43.0

