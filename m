Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604747;
	b=zgdmdIiDYb2UGLcSOpl4F3IWpZPEBYC29tYnGFe/4PtFdjaEkrkCgc4bty+ke1MvTPeQ
	 TD4ZiU3GSVCVa151jREBirwzS9dcMwz+vmSB2k6oTANzfDNT2niha/INusjyBQj8LKVTh
	 SBiF0ocZ6hrlEfmKYlV/+feE6TJ24vf878B2Tcdw2pVZYQ8R5ERIs5Z3UP9MmHkZ786bM
	 ujo5eJfP2czh+dnThFeTBiWqAjlk3EXvu+y/P/TX5wTRzK7g/7T0av4k1ccemSD0p3edw
	 O0XnyXyGRG+P1Gb/aZ2/13OViKZR9Hdjt52Nx4JjNESOg8sCUDKuD6srDXDAqKR9hAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qMSnAmvn+xg6zpwC7JmIegT9TgfMe039TBaNzlGjfQg=;
	b=HEhT9wBkcuJ8DFjvbGEhenuTUBgXaN8h2OgerI89ixsjkPKO7lXOGJgrOQhf0rivGcZl
	 za02w6L2ZByq7ZJ1Lk5NiWNmqfKrzn1u94VSc9llG40CT1assmDTkV1L+4B866uYU2EMv
	 fa9Q4nnNBslPRzDmjlYG80lOj7n8M+Tp83gj5saA0y1kZqQxcqZdRnTfnVfp2Ozjjzatz
	 Vhn3H0qXNtqFEnox43CSDPqVmBdBcr/fchkC4ZSeda8KT63OjeN2IRAfDI2UkqalCHPVj
	 00hhNX4Nw0jgMFrpGnwgOfkiOF07CbdCe0z0ad4X2AY354O6GcYC2GvZ1MCkFfoG3tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=E4K0X3i8;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C01606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7C01606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=E4K0X3i8
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ab38a051aaso10193817b3.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792604746; x=1793209546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qMSnAmvn+xg6zpwC7JmIegT9TgfMe039TBaNzlGjfQg=;
        b=E4K0X3i8r+6CaMc7vAJpCu7jS+wDCnhpEaPPLdQvVZCLJD37G+UJgN38uvC4T8dzwr
         NOfzj9+2eIomAlkoy02RfEzQG6qRQAhSVRjTdMvDG+rn1IW9pThm8Zqz/2dKsf1gIsmk
         ZRTF66Ylj9OO0YQxDgt2uNJCVrMbUuVzKZy3NrjoQwf31cJ8d5szD90Rm+QWb7Rb+DYs
         bRUTIH8nvFu/pqvIKTJhTz9gkdpR7+EpTOWmaB4k8JGZHf5tsS4ZbU8ueDmBuLQzm0z7
         rVsGvLeT1cvTkdC41gXIHWzZ1zH8Mwtu1NverGxQJ1vrt7j2o3kdnqX/BhGPFAVSol9Z
         wRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604746; x=1793209546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qMSnAmvn+xg6zpwC7JmIegT9TgfMe039TBaNzlGjfQg=;
        b=UqDyeu2auPQ5+r4PZkPj2diSJ0ZEmV0Ix+gczgq9VEsCy7gPdHN66dZUhsJK7Fr2Wd
         V2PhBMyEzMesKltYpy/BYolKHNHIY4hFQ6Tuolls9E6gppC2yfbZjMXbNc0bxIk2HzMm
         lmroq222w7xs7PH30X/+1tHuAMTRQe84PReJjqDx2jeXnkHWbRPRgFJPRB1WFPEhB5D7
         /gtlmuu2ZXF1tkpiViK4nXo7x3imOYN8zHAM3ArOjxXlllFqGj+IrZQtH7dZhHVIpLkv
         EzmfQUf9gfUXr4AD8oN1iXi9g6/sYa5HRVn9tnQoKrp0qkwOQbT4VQ2nkR84TNK8V5cw
         Q1RQ==
X-Forwarded-Encrypted: i=1; AKwUvByPyPz8RwW+zI/ReH608394nPE1mhJnUL8Lp6kO5pS5xDBzdw6lX/emscYISqcwOxJgKIRcw50=@vger.kernel.org
X-Gm-Message-State: AFq9FYKt9e2MWdw5Vu+LlK++BPuhY8af+yjx2s3ii+m1k3Zv1kIIcjrR
	GJsmIYyb470rrAGCZKJoSnVfNEqcVgmUZOKQ/pvBVsrgEwKv0/lUQKAc8UXUFFYCEw==
X-Gm-Gg: AYBFou2RBHEZ0Oj8JN4ZXE13IsQWnGB4QQDpWWeiBmyKV2oCbr+PWw072y8Z63MSFvg
	EsYUfQ1/WBmWyPVov7lwECoM7w4z9+vfWyWaKhmnFoFxEIVOGkKBc1PuF9q+xmIylXKE7v9QLgh
	6/C2JDdNkW9PVEonq/J37kXcQnNoLSb0xEe3CrL92Rt/P5YWQzS1VSjkAdT8mEeJlTyh4rkKzuu
	+ufDwTrJ81dteZBsboiYY/jEhgAcL45a5szqjW7RiNCRmtK8boS5w0cU8mb3yHZGV/C/iR808M4
	2xVKJsnZqmdLvn2EZmP7GclLzRuxJVdFfGp6wQNpSfQVhsilJBibWJ6jxdcxcyt2KDrDlJTdIBo
	UQdICSEPJjLoV+SQdBpPussF8AmRN3eVNcEszEjv0ww8C86B5+r/2ndtLHXJFo0P1NadeZTtest
	wemqxcSCgDIhloICaxEfl1MxH6mdz/pIds2XUWXdB23aFQYoGChtQ6i0qc5oa9aDpojZluVnhb4
	GPUZXFquP6vo4aLQugwwaFWQnm0Xmcnlp8rP+n9KuyhdGYzQEpqbo/8ZGHrvw/U9qIc/guUWHHq
	aVU=
X-Received: by 2002:a05:690c:e251:20b0:8b1:901:b9ee with SMTP id 00721157ae682-8b133e48cc2mr11819357b3.13.1792604745668;
        Wed, 21 Oct 2026 10:45:45 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300f3cfesm14789647b3.27.2026.10.21.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:45:45 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] hfsplus: preserve FinderInfo when listing extended attributes
Date: Wed, 21 Oct 2026 13:45:34 -0400
Message-ID: <20261021174534.482192-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit aef507847129 ("hfsplus: fix generic/062 xfstests failure") made
hfsplus_listxattr() return zero when the inode has no records in the
attributes B-tree.

However, osx.com.apple.FinderInfo is stored in the catalog record, and
hfsplus_listxattr() has already added it to the result at that point.
Setting the result to zero drops it. As of now, a file whose only
extended attribute is FinderInfo gets an empty list on a volume with
an attributes B-tree, which mkfs.hfsplus creates by default. getxattr()
still returns the value.

The issue can be reproduced with:

    truncate -s 64M hfs.img
    mkfs.hfsplus hfs.img
    mount -o loop hfs.img /mnt
    touch /mnt/file
    v=0x54455854$(printf %056d 0)
    setfattr -n osx.com.apple.FinderInfo -v $v /mnt/file
    getfattr -m - /mnt/file

Without this patch, getfattr prints nothing. With this patch, it lists
the FinderInfo entry.

This patch keeps the result of hfsplus_listxattr_finder_info() when no
attributes B-tree records are found, as is already done when the
volume has no attributes B-tree. A file without extended attributes
still gets an empty list.

Fixes: aef507847129 ("hfsplus: fix generic/062 xfstests failure")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested in KVM with KASAN on a804c5742bff, without and with this patch:
- The commands above, and a C test of listxattr() sizes and buffer
  lengths: a file with only FinderInfo gives 0 without the patch and
  25 with it; a file without extended attributes gives 0 on both.
- generic/062: 10/10 passed on both kernels.
- Full fstests (805 generic tests): 186 passed, 11 failed and 608 not
  run on both kernels, with the same failing tests. fsck.hfsplus -fn
  reported no new errors.

With this patch, getfattr above prints "osx.com.apple.FinderInf". The
last character is lost by a separate bug in copy_name(), which Maurycy
Pawlowski-Wieronski's patch fixes:
https://lore.kernel.org/all/20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f378c@maurycy.com/

 fs/hfsplus/xattr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 71364e093fa7..c74c81966f12 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -838,7 +838,6 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	err = hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL, &fd);
 	if (err) {
 		if (err == -ENOENT || err == -ENODATA) {
-			res = 0;
 			goto end_listxattr;
 		} else {
 			res = err;

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.53.0

