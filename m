Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923429992A
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 04:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785731679; cv=none; b=Ut4KCfUgiIztVlc+TLQD3oCzF9oRa6nErwNNFbetmafuQdMksVWXuVVu4TFE6Ur4+ajc3KLOM/1h6/zivn62tNU03XbgYgakJrqcXm8zvqvDlWYdgMoGWYLuM82/teuf+8IP5rA6RC+e37OnqVC3C1+UcxFa951pOIpBZ+tI5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785731679; c=relaxed/simple;
	bh=6MaiF08US6EBABB8rzhXICVg0DKE/Axy9oSPVxG0dZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCaVwL2ISKpIUGxLu21G8NFHdpRVwRZsF4zWiuV+LS2Ua/l4WD2w4UV3v2tMJ7YsxCPcG17oCE+I5lXhm5djMNftMlSNii4qGvtS2fRFw74py3HzU9kGlIyvdW3iigyZpdy11hmAUo2u6e6xut7fIm0+ANJIA+aLi5wkknlenH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY5//RFJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY5//RFJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceab75934dso33118015ad.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 21:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785731678; x=1786336478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yhmhEpINn+raFaWrTltRP0P5bFP6jSqRDnD8vpTuVFs=;
        b=JY5//RFJbYDZVe/0PTXvz7WYZ/1o/gynEUqyaUSVaAIPlbRKkYeThujtyNRjeT6ehe
         yYfzghuLG8fh37/adRaV0J9sl2Gh7JDpvbtt4BWngSAddWh4hy8mb7vqGn/s50YVwjN8
         if/gA7opnZKiRh4ePGmCS71s1e5L8MQl1d6MkH54TcbOgTW5unsG4iRJ5V9O8D5weDuZ
         6F8GWlQCv4zhmcoqgX2cTzKJxnbnWA0+mOK6QNoeRPoIYrAy437XFs67RxnIBI57aRIU
         lWFzV5phb5IxvdqPy2yfI0gXlynmDfO3nvK2khiVR7VM4AUFzSpS70SqQorbsyQSPX42
         SMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785731678; x=1786336478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yhmhEpINn+raFaWrTltRP0P5bFP6jSqRDnD8vpTuVFs=;
        b=duPmbND9J1EuhklwCxOv/xN6VtuFw99UnEJB91dVvG/PUtNDhnO5BVLvXeexoqvaVH
         ptLmRYMEW8iz8wADbgV+PkB+rj0iBpHdmpGza8L8PCBdN72ZSDB9F2Jp97sJr6AYjpLk
         4MAviig3ix7KYMRHT9riOYyLdMphsbOehqh88rPto63jnBELx8NKyB/TcRz1FGVVI1ms
         ZkMgjPN4a2Pn5h+8BW1KVHbyR6ztdHIDiyRxYTAPeKAFni47BoCLip6zEZC72J+kyrlW
         Pw2nu7TXTczbW0+MvWxfYL6o88EePwcgHEFhaQFh7dokjIogkyb8gOqWGUOOhTH3d4WV
         VRJw==
X-Forwarded-Encrypted: i=1; AHgh+RoyFEXi6Mb9DRf8hg2SaqF7WdQZBUBNvMBHeq2I92CqFKXydbF2vKmfEMaJXiWSH3oFzWzwy3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1aR02Q9i1zN/hTikJ5i6O1d8YkMhIOJobDBfdTyRmXRiZuqxJ
	iKnoz4kLXYTgr+M2JJSWmiLJsFigVYNhdffD9g/bpkzN3/XPNMs389/iPHso+greQD8=
X-Gm-Gg: AR+sD11Fgrto6M/UpxvttWhWKW+PD6T7jbU1tNDAoq1ErzI2/fAIe9i7d85/1tOPxpi
	aeD9+XPvOD2vGO9yrw027ylb+E2+MmjcU/3SgWlPpX6zzDN8AGx8CN/zdRffgWQPy/voyaW4gO1
	TN7OUkctq+iwqrVcfCM5WDQwt/28YeSbdycZXnRJAr4P/sHhlDK8vNm07JUnZp99JIezNV8Td2Z
	itXlO8Q5ZinqoMfPLVU8zUroeK8oyz44XrR9hIr83w2XWluonmItaFzILjsWSpdniG38uQyrbdH
	HqOvVxnMvlgCr0fuMQwl1C2sqWJeULnKB8uiSMQwgGwiRoKQRDMx+Pk9MR5Zq5HCEObRZnF9F/0
	URes37VinuRQYCCKS43XeeZtbHoApjn8MYuK2Jc/ufRYU1X8HubiFHhf67QL9uzgOmk+JogCO0N
	nGBTZi6V5zd6Wpn3zbCvG7yHaPlr98Sb7MPvG2+VAPO+grVSAKKdUemQBXs29HfgHryxscQv+Ba
	jctFLCO4N2CjQ==
X-Received: by 2002:a17:902:f60a:b0:2c8:2808:3ec4 with SMTP id d9443c01a7336-2d05246ee7cmr89005425ad.24.1785731677604;
        Sun, 02 Aug 2026 21:34:37 -0700 (PDT)
Received: from localhost.localdomain ([113.23.46.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddda5d9sm39302243eec.13.2026.08.02.21.34.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 21:34:36 -0700 (PDT)
From: Yuejie Shi <syjcnss@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: validate the EA value length in ntfs_read_ea()
Date: Mon,  3 Aug 2026 12:34:32 +0800
Message-ID: <20260803043432.94886-1-syjcnss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_read_ea() checks the $EA list for consistency, but it only
recomputes the packed size of an entry when the entry's own size field is
zero:

	for (off = 0; off < size; off += ea_size) {
		const struct EA_FULL *ef = Add2Ptr(ea_p, off);
		u32 bytes = size - off;
		...
		if (ef->size) {
			ea_size = le32_to_cpu(ef->size);
			if (ea_size > bytes)
				goto out1;
			continue;              /* <- elength never checked */
		}
		...
		ea_size = ALIGN(struct_size(ef, name,
					    1 + ef->name_len +
						    le16_to_cpu(ef->elength)),
				4);
		if (ea_size > bytes)
			goto out1;
	}

ef->size is non-zero for every entry except the last one, and it is what
ntfs3 itself writes (ntfs_set_ea() stores exactly that aligned packed
size), so in practice elength is not validated at all.  find_ea() then
uses unpacked_ea_size(), which also prefers ea->size when it is set, so
it agrees and hands the entry back.

ntfs_get_ea() copies elength bytes with no further bound of its own:

	len = le16_to_cpu(ea->elength);
	...
	if (len > size) {              /* size is the *caller's* buffer */
		err = -ERANGE;
		...
	}
	memcpy(buffer, ea->name + ea->name_len + 1, len);

so a caller that supplies a large enough buffer receives up to 64 KiB of
whatever follows the small $EA allocation -- straight to userspace via
getxattr(2).

Compute the packed size unconditionally and require it to fit in the
entry.  Hoist the "bytes < offsetof(struct EA_FULL, name)" test above the
ef->size branch as well: name_len and elength were being read there
without it, which is itself a small over-read of the kmalloc'd buffer
when fewer than 8 bytes are left.  The old "bytes < sizeof(ef->size)"
test is subsumed by it.

  # mkntfs image; create /mnt/ntfs/poc with user.ntfs6 set, then rewrite
  # that EA_FULL's elength from 0xf to 0xff00 on the raw device
  mount -t ntfs3 -o ro /dev/vda /mnt/ntfs
  getxattr("/mnt/ntfs/poc", "user.ntfs6", buf, 128 * 1024);

  BUG: KASAN: slab-out-of-bounds in ntfs_get_ea+0x294/0x3e0
  Read of size 65280 at addr ffff0000cca53acf by task xattr_probe/142
   __asan_memcpy+0x3c/0xa0
   ntfs_get_ea+0x294/0x3e0
   ntfs_getxattr+0x284/0x318
   __vfs_getxattr+0x104/0x160
   vfs_getxattr+0x1b4/0x1e0
   do_getxattr+0xcc/0x230
   path_getxattrat+0x184/0x270
   __arm64_sys_getxattr+0x64/0x80
  Allocated by task 142:
   __kmalloc_noprof+0x294/0x668
   ntfs_read_ea+0x1e4/0x420
   ntfs_get_ea+0x2c8/0x3e0
  The buggy address belongs to the object at ffff0000cca53a80
   which belongs to the cache kmalloc-96 of size 96

The object being over-read is the one ntfs_read_ea() just allocated, and
it is 96 bytes.

Entries written by ntfs3 and by Windows set size to the aligned packed
size, so the new test does not reject anything a working filesystem
produces.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Yuejie Shi <syjcnss@gmail.com>
---
 fs/ntfs3/xattr.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 04814dd29375..e67a1100d0cd 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -146,26 +146,31 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct 
 	for (off = 0; off < size; off += ea_size) {
 		const struct EA_FULL *ef = Add2Ptr(ea_p, off);
 		u32 bytes = size - off;
+		u32 packed_size;
 
-		/* Check if we can use field ea->size. */
-		if (bytes < sizeof(ef->size))
+		/* Check if we can use fields ef->name_len and ef->elength. */
+		if (bytes < offsetof(struct EA_FULL, name))
 			goto out1;
 
+		/*
+		 * The name and the value have to fit in the entry whether or
+		 * not ef->size is set, because ntfs_get_ea() copies elength
+		 * bytes out of this buffer and checks them only against the
+		 * caller supplied buffer size.
+		 */
+		packed_size = ALIGN(struct_size(ef, name,
+						1 + ef->name_len +
+							le16_to_cpu(ef->elength)),
+				    4);
+
 		if (ef->size) {
 			ea_size = le32_to_cpu(ef->size);
-			if (ea_size > bytes)
+			if (ea_size > bytes || packed_size > ea_size)
 				goto out1;
 			continue;
 		}
 
-		/* Check if we can use fields ef->name_len and ef->elength. */
-		if (bytes < offsetof(struct EA_FULL, name))
-			goto out1;
-
-		ea_size = ALIGN(struct_size(ef, name,
-					    1 + ef->name_len +
-						    le16_to_cpu(ef->elength)),
-				4);
+		ea_size = packed_size;
 		if (ea_size > bytes)
 			goto out1;
 	}
--
2.51.0
