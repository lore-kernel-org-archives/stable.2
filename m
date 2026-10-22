Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662069;
	b=csBSPdHT5WgvEk3DcpGQw36SsnTxxFHTp8HmqmkL8qYTjfL9SUh4SV675eFGLYtQwg+j
	 NlaTEgM+VjkUl/zUw9G1yF3N1LJ6xVGmZDKelv4SUg6UxjwWRWdZsIzFkvGttfaavy8zj
	 cZmbtHbbw/+P3WSpuSKwsxJmdIn7KW815CTPL1cnD6tDSSyNs39JTbGHsXxneQ6SnV6yN
	 aEc+21hj6ec1/8H3qQJ2aeul3E6tdI9hNZJf30pSuv36Fz3fwRWlBKnQ/UcX+FEUpnB6q
	 osZFrqxlAMpv2jieXxyu+Pwv1+9fehEdQVYukoMeV27j7P+S8WsGAZCS4zsY0dWeLrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XIEdpK6uoY0VcAn4RMjuLM3ziGKUkenXplth+Lt8Y7A=;
	b=LPdwyswSZKk2mGKEl6EG6Upy30rzOtugFiwivUC24oASviQa2YxJVEvRNmO9Vrf/yxet
	 PBQbDkoUiagl6Ilv+pMHhKNP+78IA/aiKb5WYjeadNgilapM8LRZpeTqI8/6h0bIn4W0t
	 PJrLXAHWGCA/i09pCpA5e/FNL3keaO4pewI23NzwgnxCLtFZuKvwnPtNFLiGOOFCDIECM
	 Mh4U/K0kpPrAAZMGhgIU/OIoR2J0/3vJV1Ytzh4GFf+gA31BBXSyf9NbMPv7eWK//bTp/
	 jLV0ZdqBdJCr/H62JZA0GAGeeaogOYknwObH6K+O9pk6Jw0AJ0td0fjnJP1hKNWQayg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=kz3Vg9pv;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A49606A33B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05A49606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=kz3Vg9pv
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b55859245so22301806d6.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792662067; x=1793266867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIEdpK6uoY0VcAn4RMjuLM3ziGKUkenXplth+Lt8Y7A=;
        b=kz3Vg9pvKqAJ2lSpLZ/iAeT6tIlkg/q/lJDA65XliRZtEb1BP2h5McqrqUuHNE0A+Q
         T9EOQwdqdK6yfwIGeUo6xoq2dQwQitTjYraLMBqq26QrO/IDS5sd4VHYo4z6/M1MoOyB
         ZKc2iW9QbX2tDjW8lwIRHk4+AqR/joJ9OOmVHtvbiihqQbvYOCmvsop/a4capa5jPt5f
         lMym/OyK57LJd+Wjf/8q1yUDG6hb62kEKbpIea7mKtrydASLGKyYE1ov/CCJsT2oDsi3
         wisSn5UqPg+vcp1ZStL7L4Ctr/iQVO3K4ePRJlvpeODN7rNvki9IB7eSvRLerO8/ayfR
         bGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662067; x=1793266867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIEdpK6uoY0VcAn4RMjuLM3ziGKUkenXplth+Lt8Y7A=;
        b=YhxuMpHsp/kIgRG0hUxwZzogeIk3GZuCJ8EbGBzNsmFStT5CFoBPthDP4eH1Z9LuJE
         2yWhluwqFy39L6Adu0VXjPiAVo9ojUZoIozWKeVKwp+FthFekF5wiW3dvtERHkD37OTC
         XXjQNMTUgsHfZzJv3ZM9q98jyWbIINMRcDo3kcJE7yRxtYS5+aPWDtersPqiTfLr98Bn
         aLsNdMXt1zaitefti0nDtmS4J75IGRRU1Bj1m5YdZNrJw4xVjZiTGu2uD5v/QpXl4FQ0
         6RM/BsQIVuQGlqluIvHe1ioavHglT+pVXjPc74iHLIiw4+eqjH1uQP0izyYtFxNZ+hFm
         cQmg==
X-Forwarded-Encrypted: i=1; AKwUvBy+G0d3SGv7pl/mNGYwz/MsAjyZplRh9079Hfnefw2eZ/QS9HI76IXWLiak2pAsLp6ot+Jddu0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfVKPv3GOzIqvA4wPm+4cBOEMm3/PzK6zMQiZzBemGniX/U0sy
	ZauQ7hyvIZukbjdQ4dza3ODIXYEvRA7PgojcfjY+D7jYvGt60QJUMjrc5QdumO+5ww==
X-Gm-Gg: AYBFou2O7SVZTfX2Jc6a3SPinYz3aUxk0pNAqOlFjTD4kondFMeJHsIQj/RgmNa12rJ
	yo0Amljc0VFCqKZNpT3k75NlOuzQVdeu68RLMYcK2OuQUrj4pQnTqBW6UDTPMtBFhD/hQUX9O0J
	LjKO3GCdD9URPfhJpX2B28Bdsczt7AHNKs+5PTjVYfv+tRw/WeJa3kmArZEafSmvosl7HRZ9xwg
	6qRVZVQN/cBBalH1spwCm5oHQBg+SEqucNK4h4p3ZSqkOAz3hsNDwMLS3eUXomqy3IYuCHCI85l
	KopFkLjqNtks291pK8EGHOBjXmil7NmIQnFCHh2k61xObjHjQ8J7om15ZnIMyccGyMVOGDUvdFG
	XRUkmipWpYiNd7C7wfnI+nlfda0RovzBVbGvlAMPykHropOH+hzjw7nbz10q4ieytsEhrDnTQQY
	8UuXrb3R6QhixB+UdT0uED3fu3hvd1yS2qtRJE7tbEsCW6eTUAybuTLFvJmVJpnU0TuRfFjqZul
	b4KfGsj1v0GlasVSfsIDaErYRdwnyRYNoI3bTC7XlbrQgU2y0oE/xJ2R+Re3t95uSfqiua40dcd
	qC8=
X-Received: by 2002:a05:6214:418a:b0:91b:5d39:e13f with SMTP id 6a1803df08f44-91c12f339e4mr79983386d6.52.1792662066786;
        Thu, 22 Oct 2026 02:41:06 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c0f838sm46074876d6.32.2026.10.22.02.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:41:06 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] hfsplus: preserve FinderInfo when listing extended attributes
Date: Thu, 22 Oct 2026 05:40:58 -0400
Message-ID: <20261022094058.1169039-1-hengyul@cs.unc.edu>
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
Changes in v2:
- Restructure the error check as suggested by Viacheslav Dubeyko. No
  functional change.
- v1: https://lore.kernel.org/r/20261021174534.482192-1-hengyul@cs.unc.edu

Tested in KVM with KASAN on a804c5742bff, without and with this patch:
- The commands above, and a C test of listxattr() sizes and buffer
  lengths: a file with only FinderInfo gives 0 without the patch and
  25 with it; a file without extended attributes gives 0 on both.
- generic/062: 10/10 passed on both kernels.
- Full fstests (805 generic tests, 608 not run on both kernels): 186
  passed and 11 failed without the patch, 187 and 10 with it. The only
  difference is generic/795, which fails at random on both kernels
  with fsck "Invalid volume file count" (1 of 11 runs without the
  patch, 2 of 11 with it). generic/089 and a small test that only
  creates files and unlinks them while open hit the same error on both
  kernels. This looks like a separate race: hfsplus_file_release()
  updates file_count without vh_mutex.

With this patch, getfattr above prints "osx.com.apple.FinderInf". The
last character is lost by a separate bug in copy_name(), which Maurycy
Pawlowski-Wieronski's patch fixes:
https://lore.kernel.org/all/20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f378c@maurycy.com/

 fs/hfsplus/xattr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 71364e093fa7..45571d6f3abd 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -837,13 +837,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 	err = hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL, &fd);
 	if (err) {
-		if (err == -ENOENT || err == -ENODATA) {
-			res = 0;
-			goto end_listxattr;
-		} else {
+		if (err != -ENOENT && err != -ENODATA)
 			res = err;
-			goto end_listxattr;
-		}
+		goto end_listxattr;
 	}
 
 	for (;;) {

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.53.0

