Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974333590AE
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826835; cv=none; b=LE1Dd2sxqkuDHbAI2kp+v7cLTzim8bfZWD5xjN9MwQP4SJAcitgmo2KIM/JROpjTxdrYuUtuMBARJf5Kudm0SpUfBVFlBkUllQcr0dJ1cpSlvdb29cDE0EQOs+/XBxNb1VGZpFy1Ae5LM7btfgo/1g+T2bIg3re1To7rvVLUpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826835; c=relaxed/simple;
	bh=ZTJIGvbRJzAFEfe9lGsFwo490/TE8Ds9sbtsjVe8Mr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQ3udPXCsgOYECA7VHYdX8EJxrXOmpDSG3zIjwQ7gd+GK4i9q8Yfgr6qeqhSn52Hf2SjavAjYSdssP9Z95aVDcnDwJ2JZc9CuedKrNFqtFmmnTC9iVgNuT3V5hM/DCzDK882suN9OIRvqekNqCxxD06msm0/HjHDnNuQowDXmWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=MxiMMnoi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="MxiMMnoi"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceaf8a1265so51199115ad.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 00:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785826828; x=1786431628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/S+1PBjrGBEUu7nxCeFZRReMl5493FNSk6+JZoIwyAE=;
        b=MxiMMnoiPtK8yb3v6kavbMuJvmTAcZDjnK++DRT27jrvJ57q05E5+v+EMR+DSfc7At
         im+Jlk+wkVDBGxOg69sqs79JLZIgPIOG0Q3pGn088U0dfNnibyH0I/2c+sEm15azl1Ak
         9cyRR/Rfsco+5r605jyG6eQ7uPa+XgBPSp6vvJmMYV4Gqer2xYjbftZf3bftPYHEQFLI
         +zvm0LXNnHBFf2EmyfDngvFrXagdcJRhHwuJDaAaYcoKkGF0EfKBzMzB45p5Zm+FRmLg
         lt7TL87iauE5VRmfA+xMTmfWHzyJxGNE4DR6/tHrjE0V9krJD4GbuUFpxOVOiHBNjEuS
         h/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785826828; x=1786431628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/S+1PBjrGBEUu7nxCeFZRReMl5493FNSk6+JZoIwyAE=;
        b=KYrQEd+3nHNV1J/CZJHDzaD+61t/FcZBzxNoZexybW2yt5teoGJ/SqX2142I7Vo7lh
         kbDccdk+scky0vvMkLQXfmOO45rXCXleKcQCdEqOUDpY408Ft93NFJ3qkeXvOg+qkOaT
         VkGDWYqsntRjugixakcA01pn/AJgzAHyJXp7RWiAl8RJ6+5A6OrA5EMyiofW+4Qvdhhs
         1b0XdNGFHkvNoBw5oKmzt2lnzJk+8vgNdaodXVJfQe3A4uIMcRgqCWp1gPgRToYrzw6q
         g4p88jKhm6wkv3gUXmKfl/6IrGD987wjwx1BdMAC8uUUJv+sy8PHDJOg6KCOVo/dNel3
         n5Mg==
X-Forwarded-Encrypted: i=1; AHgh+RqXOCaQD9pxNyCbW5YHhnBZ25dyX6Pfw3lBTCMD8cLlfeG3dSG1rCCkF3Cg3uFvw7QBRhyOlJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxt+lUERZ3VlMind6Bog5Nr7ctFRospEtZ5nGJoCpeTD7hkf7
	fCCQW1br6tEEWNKg7FlO/7HGUfQHSDVTUj6rv2nFWQcwIwxtvlXPTkn+Zl3lKzqcvgU=
X-Gm-Gg: AR+sD11MZA8lBgC/Wpn+RUxHorh89RixScMUC0Lw5ZsWc58ThAX95RHcUSOdahCSeZZ
	Mw7BBBY9ahbCV7TF+YUKK6lrV6hP6itPLiUstmxS5kssS4ZCEqyMdP11Y35xnjM77MIttcOunrf
	9USEcZSI3wwT7Rw2JbUeRWp81vGlrSVs7hcLu7iFZTpTX6AOJ14Ck0ittfSA+jJnWKDyeZRcDWp
	p4ffb3HUpX7iA34tMdM/K6HrOnU+J1UYJ/i4NOeFh6vFY0UqBuqXawy2Oi69XsKWfOxjR0jekI5
	Nhdvlw66LabtUVCKLj1AhE5XOWY8LewFmv006wYUxbbODo/DT1Y/YlCWtIcmZY9WbijB/DhcIQv
	9jxCSKuGAM24euOJDrnBxxQlb2gIOZLbfkN9h2RPAQ1YUxvI6BXni4XJawbna3MCK5VzOJXIgwG
	/mQkdA45TpFNF/z00SAjccDwI6oL5o4rD2aKrjjMhVgHG3uBK0QXWkirlOPxnSPCHIbB1eggSc2
	I+lJfub8KL8jg2UOY1cWWm4C1UMBjYiuNxOARhe
X-Received: by 2002:a17:903:1105:b0:2d0:87ee:560 with SMTP id d9443c01a7336-2d087ee0569mr27933385ad.41.1785826827320;
        Tue, 04 Aug 2026 00:00:27 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa492c7fsm961835ad.43.2026.08.04.00.00.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 00:00:26 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2] freevxfs: fix off-page reads in the directory walkers
Date: Tue,  4 Aug 2026 16:00:23 +0900
Message-ID: <20260804070023.29682-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726062514.43756-1-baul.lee@xbow.com>
References: <20260726062514.43756-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxfs_readdir() and vxfs_find_entry() walk a directory page with an
intra-page offset, pg_ofs, and dereference kaddr + pg_ofs without bounding
it.  Nothing validates the page first: vxfs_check_page() was never
implemented, only a commented out call survives in vxfs_get_page().  Three
on-disk values steer the walk unchecked.

VXFS_DIRBLKOV(), 2 * d_nhash + 4, is added at a dirblock boundary and the
entry is dereferenced right after; the enclosing while (pg_ofs < PAGE_SIZE
&& pos < limit) only gates the next iteration.  d_nhash can move the
dereference 32 pages from the start of the page.

d_reclen is added at the end of each iteration.  There the loop condition
does run, but it only proves that pg_ofs is inside the page, not that an
entry header is: pg_ofs of PAGE_SIZE - 2 passes it, and d_reclen at offset
4 of the next entry is off the page.

d_namelen is never compared to its record.  vxfs_readdir() passes it to
dir_emit() as the length of d_name, which starts at offset 10 of the entry.
filldir64() rejects PATH_MAX and above, but only after verify_dirent_name()
has run memchr() over the name, and shorter names are copied out - up to
4095 bytes past the page.  vxfs_find_entry() memcmp()s up to 256.

A crafted image reaches all three, vxfs_readdir() from getdents64(2) and
vxfs_find_entry() from a path walk.  KASAN reports a 2-byte read past the
page in vxfs_readdir(), a read in memchr() below filldir64(), and a read in
memcmp() below vxfs_lookup().

Bound them: leave the page if the overhead moved pg_ofs out of it, require
the entry header and then the whole record to fit in the page, and skip an
entry whose name does not fit in its record.  A record shorter than its own
header is refused too, so a free entry cannot slide the next one by less
than an entry.  Where the page is abandoned, advance pos to its end so the
outer loop keeps making progress.

vxfs_readdir() also ended the walk on a page that emitted nothing, its
per-page rc conflating a full buffer with an empty page, and the new checks
add another way to reach that; track the full buffer directly.

Valid images are unaffected: a record holds its own name and does not cross
its dirblock, dirblocks do not cross a block, and sb_set_blocksize() has
already refused a block size larger than a page.

Found by XBOW.

Fixes: 12495ea3ac47 ("freevxfs: refactor readdir and lookup code")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
v2, in reply to the Sashiko review Christian pointed at.  Its three points
are right.

v1 checked pg_ofs only after the dirblock overhead, which does not cover
the dereference: pg_ofs of PAGE_SIZE - 2 passes that check too, and
d_reclen alone reaches it.  A kernel carrying v1 still reports both reads.
The d_namelen one is the worse of the two and predates the 2016 refactor,
hence the second Fixes tag.  The premature end of the walk is real but is
not memory safety; it is in here because the new checks add a way to reach
it, and I can split it out if you prefer.

Not taken: 4 byte alignment for d_reclen.  It cannot be established from
d_reclen alone - VXFS_DIRBLKOV() is 2 * d_nhash + 4, so an odd d_nhash
already starts a dirblock's entries two bytes off, and such an image mounts
and lists fine before and after this patch.  A short record is refused,
which is the half that needs no guess.  The rest belongs with an
implementation of vxfs_check_page().

Verified on 7.2.0-rc5 with KASAN, on crafted images built from the driver's
own headers: before the patch getdents64() and stat() produce the three
reports above, after it none, and well-formed images list unchanged.

Review: https://sashiko.dev/#/patchset/20260726062514.43756-1-baul.lee%40xbow.com
v1: https://lore.kernel.org/linux-fsdevel/20260726062514.43756-1-baul.lee@xbow.com/

 fs/freevxfs/vxfs_lookup.c | 69 +++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
index 138e08de976e..50c428c63126 100644
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -78,6 +78,7 @@ vxfs_find_entry(struct inode *ip, struct dentry *dp, struct page **ppp)
 
 		while (pg_ofs < PAGE_SIZE && pos < limit) {
 			struct vxfs_direct *de;
+			int reclen, nlen;
 
 			if ((pos & (bsize - 1)) < 4) {
 				struct vxfs_dirblk *dbp =
@@ -87,6 +88,14 @@ vxfs_find_entry(struct inode *ip, struct dentry *dp, struct page **ppp)
 
 				pos += overhead;
 				pg_ofs += overhead;
+				if (pg_ofs >= PAGE_SIZE)
+					break;
+			}
+
+			/* the entry header must fit in the page */
+			if (pg_ofs + VXFS_NAMEMIN > PAGE_SIZE) {
+				pos += PAGE_SIZE - pg_ofs;
+				break;
 			}
 			de = (struct vxfs_direct *)(kaddr + pg_ofs);
 
@@ -96,12 +105,25 @@ vxfs_find_entry(struct inode *ip, struct dentry *dp, struct page **ppp)
 				break;
 			}
 
-			pg_ofs += fs16_to_cpu(sbi, de->d_reclen);
-			pos += fs16_to_cpu(sbi, de->d_reclen);
+			/* and so must the whole record, header included */
+			reclen = fs16_to_cpu(sbi, de->d_reclen);
+			if (reclen < VXFS_NAMEMIN ||
+			    pg_ofs + reclen > PAGE_SIZE) {
+				pos += PAGE_SIZE - pg_ofs;
+				break;
+			}
+
+			pg_ofs += reclen;
+			pos += reclen;
 			if (!de->d_ino)
 				continue;
 
-			if (namelen != fs16_to_cpu(sbi, de->d_namelen))
+			/* the name must fit in the record */
+			nlen = fs16_to_cpu(sbi, de->d_namelen);
+			if (VXFS_NAMEMIN + nlen > reclen)
+				continue;
+
+			if (namelen != nlen)
 				continue;
 			if (!memcmp(name, de->d_name, namelen)) {
 				*ppp = pp;
@@ -218,7 +240,7 @@ vxfs_readdir(struct file *fp, struct dir_context *ctx)
 		struct page *pp;
 		char *kaddr;
 		int pg_ofs = pos & ~PAGE_MASK;
-		int rc = 0;
+		bool full = false;
 
 		pp = vxfs_get_page(ip->i_mapping, pos >> PAGE_SHIFT);
 		if (IS_ERR(pp))
@@ -228,6 +250,7 @@ vxfs_readdir(struct file *fp, struct dir_context *ctx)
 
 		while (pg_ofs < PAGE_SIZE && pos < limit) {
 			struct vxfs_direct *de;
+			int reclen, nlen;
 
 			if ((pos & (bsize - 1)) < 4) {
 				struct vxfs_dirblk *dbp =
@@ -237,6 +260,14 @@ vxfs_readdir(struct file *fp, struct dir_context *ctx)
 
 				pos += overhead;
 				pg_ofs += overhead;
+				if (pg_ofs >= PAGE_SIZE)
+					break;
+			}
+
+			/* the entry header must fit in the page */
+			if (pg_ofs + VXFS_NAMEMIN > PAGE_SIZE) {
+				pos += PAGE_SIZE - pg_ofs;
+				break;
 			}
 			de = (struct vxfs_direct *)(kaddr + pg_ofs);
 
@@ -246,23 +277,35 @@ vxfs_readdir(struct file *fp, struct dir_context *ctx)
 				break;
 			}
 
-			pg_ofs += fs16_to_cpu(sbi, de->d_reclen);
-			pos += fs16_to_cpu(sbi, de->d_reclen);
+			/* and so must the whole record, header included */
+			reclen = fs16_to_cpu(sbi, de->d_reclen);
+			if (reclen < VXFS_NAMEMIN ||
+			    pg_ofs + reclen > PAGE_SIZE) {
+				pos += PAGE_SIZE - pg_ofs;
+				break;
+			}
+
+			pg_ofs += reclen;
+			pos += reclen;
 			if (!de->d_ino)
 				continue;
 
-			rc = dir_emit(ctx, de->d_name,
-					fs16_to_cpu(sbi, de->d_namelen),
-					fs32_to_cpu(sbi, de->d_ino),
-					DT_UNKNOWN);
-			if (!rc) {
+			/* the name must fit in the record */
+			nlen = fs16_to_cpu(sbi, de->d_namelen);
+			if (VXFS_NAMEMIN + nlen > reclen)
+				continue;
+
+			if (!dir_emit(ctx, de->d_name, nlen,
+				      fs32_to_cpu(sbi, de->d_ino),
+				      DT_UNKNOWN)) {
 				/* the dir entry was not read, fix pos. */
-				pos -= fs16_to_cpu(sbi, de->d_reclen);
+				pos -= reclen;
+				full = true;
 				break;
 			}
 		}
 		vxfs_put_page(pp);
-		if (!rc)
+		if (full)
 			break;
 	}
 
-- 
2.53.0

