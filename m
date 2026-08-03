Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6801535F180
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727465; cv=none; b=J/UpfJu1mt3sLNkmmuwhu4HDHXhkkwpqKxEP8P7/S4fMk66uiGM45Qd7bBPPxJpB1kjXfcKR8j1pYc2NPMCDx8rPCUC9/GJJN86PC6nyT/ZrdFqKZZ6sqmVFjPF+kk9TDni3oDfgLKbrAOWBkx1b8UGiunpFTp3yhPD5SMb0kU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727465; c=relaxed/simple;
	bh=wTc44godCBr41Yhnl0GW4Deb5PBNJIsdunnCbNZcFuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CC6eb6d+yBMtCuc/LcWFZO/2Y2M9U77l9iIoG1LmPIa6AH6UZY6GUDn4WTSkp1yqhdQMJqq6mRwRyH00aoC3H4F74i9dvSAvReHuZVru94xaBn/xKxf+tHqr3MWbTZHzL+8gO8ccsv6S7X0EpSUPwy3oVFm5uk5Z/gpYliTcII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X12SJ6H+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X12SJ6H+"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1508102a12.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 20:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785727463; x=1786332263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVl4klP6LA6NmRLyJQ/HKUqjSsam4An2swpmX35+Bek=;
        b=X12SJ6H+8YqRJjsGQiC3GXUcyfPM/0xZ/Ohyw0G6RFm1N7Rr0qx9Wd4XH+7iSdUTbg
         Z8cpiRQhklT/h/ritOWlUlwZnXbvmce18iUIsSb5HpugNLbPHjaGM1hHIEFuPA3tsM0N
         uPKm3FrQKjzExKfn8YTexUiKdli5kMfwSjgB9GAZX47TyGTcgZ2e1NpAtLtIt5dspOlN
         /pA6/Hqz9LAUyl4mG6z062IKMEedkxFFg6OMbtaoy0Ev8m4aahVyksn5wWDhOjrlwUR3
         PvXn2QD9JDdnt2lR9ZW2n/ezgEbNEmv5N2SjPgyPYC75Hny5+5nTv2PrCMVshti7NMcX
         dTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785727463; x=1786332263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVl4klP6LA6NmRLyJQ/HKUqjSsam4An2swpmX35+Bek=;
        b=ch1674RwgzXcDmqjmiG3Lb3hdxbmXICTs+zTDXQ5jndMnfH9h/YL+XK1pZxc9QE9FG
         FhNKrriU4fsG9TcwwBchV1SgL+J17lCGwiaL06QwikaRIkGOdUBqpGLBdkBzxuc17kpO
         ElKtkD1NaoG4u8yIwjN+tBymrPsIn9ahMj9PM+bVcxA5cfhgKwOZPGYtsYwMhZcRPTbY
         eEbeo+MZ/84R8X4CIz8ydWoXPQ+3ORdZ6oDXlzWg98F75UIu47BEDJjU4ktY6qWdZS+V
         YVZcyWAUvwdQ+MI0U3sYDc05/Opgil9o6sJgz2HCC/z68BiOMFxD97FPtKt5qqLCcJQV
         OnQw==
X-Forwarded-Encrypted: i=1; AHgh+RpADvGD5sYoCGnhS4UHkIrDQV//Tv3BkbF7leWfeqjAPjhHC0RGz++HJKhimSdascnTwlB0yEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTNafHH8wLftQNPvkMATmPxT3uKd3GF2OOhEYXZpWCm6fEWj4g
	OA5qvBDQcuR8frPm6zkBc63OrxLTzXOIujQEj4SKJYHFnsAHOYZNkj5f
X-Gm-Gg: AR+sD12QvD7imocW7OGOEkZzvgMvr14AiRfpHL3adfLvEURGaS4ywSym5XD6SKoC1Mf
	hbrhBQrQlKnRKaw33XArC3xvGuXdRiRVGFY0nYmpR+bSg30Hsg6uAvp925qnIi3XD4wKIZc3mTn
	w/DQXI+9hzYmC4cCv2hAt77xa8Qqb6Y5ferZY9oNDnZiYynuSWMx4pdilKenQGceUeJQ/Snd018
	ZK5kcPSMRc6TINY4c26nbtHoNLpwTBuGxH65fWomqOP+OhokFHNsHBMvY1J4+EnGfAyeKYJ1g43
	0fZIX0yUAFKRnMed2pilXfRrLSde+l7WuKGWHC/fgyGI84iNOj9ew8uBL0dku8EWYb8+Ba+s0T6
	maGQFO19yszJavLMMVaZPGJmfGCLt/F3YC50FhRbPWHG3IGRBVKc8FmEqA2M8MC9Hl2/AJUu8Hi
	Bda0RWejxQa2RNv3Vq1+C41dxnJbmfdGe6IgrdirL4/pp8YmEa7ST7eThdyO9o1aNecpXT6L4zQ
	jh3vePD1mIIPQ==
X-Received: by 2002:a05:6a21:4516:b0:3bf:6c04:a813 with SMTP id adf61e73a8af0-3c92a88e655mr8196887637.52.1785727462675;
        Sun, 02 Aug 2026 20:24:22 -0700 (PDT)
Received: from localhost.localdomain ([113.23.46.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18d9c6sm33181125eec.30.2026.08.02.20.24.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 20:24:21 -0700 (PDT)
From: Yuejie Shi <syjcnss@gmail.com>
To: Russell King <rmk+kernel@armlinux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] adfs: bound the F+ directory entry name length
Date: Mon,  3 Aug 2026 11:24:14 +0800
Message-ID: <20260803032414.81527-1-syjcnss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adfs_fplus_getnext() copies a directory entry name into
struct object_info::name, which is a fixed char[ADFS_MAX_NAME_LEN]
(260 bytes) living on adfs_fplus_iterate()'s stack:

	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);

	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
	offset += le32_to_cpu(bde.bigdirobnameptr);

	ret = adfs_dir_copyfrom(obj->name, dir, offset, obj->name_len);

bigdirobnamelen is a raw on-disk __le32 and is not checked against
anything -- not against the 260-byte destination, not against
ADFS_FPLUS_NAME_LEN (255), not even against bigdirnamesize.
adfs_fplus_validate_header() checks bigdirnamelen, bigdirnamesize and
bigdirentries, but nothing validates the per-entry name length.

adfs_dir_copyfrom() does not save us either.  It bounds only the source,
and even that bound is incomplete: the test

	if (index + (remain < len) >= dir->nr_buffers)
		return -EINVAL;

covers at most one extra buffer, while the tail

	memcpy(dst, dir->bhs[index]->b_data + offset, len);

is not capped at the remaining size of that buffer.  So a large
bigdirobnamelen is an out-of-bounds read of the directory buffer_heads
*and* a linear out-of-bounds write of the same, attacker-chosen, 32-bit
length past object_info::name on the kernel stack.

adfs_object_fixup() then makes it slightly worse: it loops over the same
name_len, and with the "ftsuffix" mount option appends four more bytes at
obj->name[obj->name_len++], which overflows even for name_len == 260.

Reject a name length that cannot fit, and while here make
adfs_dir_copyfrom() check the whole requested range against the
directory's buffers and copy through a loop, so no single memcpy can run
off the end of a buffer_head.

Mounting a crafted image requires CAP_SYS_ADMIN in the initial user
namespace -- ADFS is FS_REQUIRES_DEV and not FS_USERNS_MOUNT -- so this
is not reachable by a plain unprivileged local user.  It matters for the
usual untrusted-media paths: automounted removable media, disk images
handed to a privileged mounting agent (container/VM image tooling), and
forensic or CI systems that mount images to inspect them.  After the
mount, the trigger is a single getdents64() on the root directory, i.e.
"ls /mnt".

  losetup /dev/loop0 adfs-w4.img          # F+ image, bigdirobnamelen=300
  mount -t adfs -o ro /dev/loop0 /mnt
  ls -la /mnt

  BUG: KASAN: stack-out-of-bounds in adfs_dir_copyfrom+0xcc/0x150
  Write of size 300 at addr ffff80008ac6799c by task ls/132
   __asan_memcpy+0x54/0xa0
   adfs_dir_copyfrom+0xcc/0x150
   adfs_fplus_getnext+0x200/0x240
   adfs_fplus_iterate+0x144/0x1b8
   adfs_iterate+0x12c/0x2c0
   iterate_dir+0x12c/0x400
   __arm64_sys_getdents64+0xf0/0x230

followed by cascading stack-out-of-bounds reports in adfs_object_fixup()
and filldir64() walking the smashed frame.  300 is only the smallest
value that demonstrates it; the field is 32 bits wide.

Valid F+ directories are unaffected: RISC OS caps an F+ object name at
ADFS_FPLUS_NAME_LEN (255) bytes, which still leaves room for the four
byte ",xyz" filetype suffix inside ADFS_MAX_NAME_LEN, and the reworked
adfs_dir_copyfrom() copies exactly the same bytes as before for any
request that was in bounds.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yuejie Shi <syjcnss@gmail.com>
---
 fs/adfs/dir.c       | 15 +++++++++------
 fs/adfs/dir_fplus.c |  2 ++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 11afa9e157aa..44953247acad 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -19,15 +19,20 @@ int adfs_dir_copyfrom(void *dst, struct adfs_dir *dir,
 		      size_t len)
 {
 	struct super_block *sb = dir->sb;
+	size_t size = (size_t)dir->nr_buffers << sb->s_blocksize_bits;
 	unsigned int index, remain;
 
+	if (offset >= size || len > size - offset)
+		return -EINVAL;
+
 	index = offset >> sb->s_blocksize_bits;
 	offset &= sb->s_blocksize - 1;
-	remain = sb->s_blocksize - offset;
-	if (index + (remain < len) >= dir->nr_buffers)
-		return -EINVAL;
 
-	if (remain < len) {
+	while (len) {
+		remain = sb->s_blocksize - offset;
+		if (remain > len)
+			remain = len;
+
 		memcpy(dst, dir->bhs[index]->b_data + offset, remain);
 		dst += remain;
 		len -= remain;
@@ -35,8 +40,6 @@ int adfs_dir_copyfrom(void *dst, struct adfs_dir *dir,
 		offset = 0;
 	}
 
-	memcpy(dst, dir->bhs[index]->b_data + offset, len);
-
 	return 0;
 }
 
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924014da..517ffcc91429 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -192,6 +192,8 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object
 	obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
+	if (obj->name_len > ADFS_FPLUS_NAME_LEN)
+		return -EIO;
 
 	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
 	offset += le32_to_cpu(bde.bigdirobnameptr);
--
2.51.0
