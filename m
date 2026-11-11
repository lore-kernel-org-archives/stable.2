Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794360660;
	b=ZlQAJPUojevyBRQd5EGSoqcqp29kwpHolTepjIQR433vChJj2kNsPqplmKGlVtF9oWed
	 Q8cQEZefV/nwfrgXo5XWYFxaTtx/4fi3ufU+wv9cINNhNsjvAKMXqDlOzUOE2mUHV+3NF
	 3V7Zcgrhu5vTx1QYlTOy24M9SM97Fg/owwbU3oTzMKyKdtMe16pLSCxKRhmMiqGaH6oJ9
	 Gv5ERZBIkPHG0QQap8G+BUnpCoYZ87jqwxOvcT92Z4SoXz4g2pFyqhSkzNTt3BDtr1fql
	 TJf3w1rNbeXLIVR6zygcGQ6pg81VVVeKoKjOfYLpG/AhCs3+E8IQ0jpMJeGN9Qq2MmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794360660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=geMT4ymeyJQhvfQ9uXh22vOyUA7a2/mHSJXaBINRmoU=;
	b=nJmrABVtaM+lNOxf5M12rfNkg3rsPtvEbpSQ/dpkmACz7G7QpSUfBg9c8RFJa8DefsjE
	 B1j50vQz8DroYvY8QBKYJ6J6g6FVYmUQ0GfIpDGp8O52OruagmFtsRWCSRgyazKvYc/qV
	 p5+1IxLyPCwEvwp7V+mOsmbbOCDCXPnHnnoMujBO/3S6wU56SWbvVSJTz2XPHnXNqrI6L
	 vGB4KEP/K03ZuwAOENV/snz42JGrh9LEquM3qrfePeW/UQYj3EjiVs2U/Pg1v7V/AdOrS
	 UwX7G3Vzj4xExovlC7+wm3A1304JgD/SqgmVH4j2o2HcIwot4WNy24g4aZO2iC6kuew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnb4wA9H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C944606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnb4wA9H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52A01F0089F;
	Wed, 11 Nov 2026 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794360660;
	bh=geMT4ymeyJQhvfQ9uXh22vOyUA7a2/mHSJXaBINRmoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bnb4wA9HtvfGjTKuDXX6OHKzX9Gqk0uGs8qVd/31avE3G2oa/QxYjLeIAZygjqBmX
	 e5kTLYTnk4cvms+QgcW780O/Xv7Qya+ww7/8Fy0MtmgUMraV28EAB+0+xMB6aImXFg
	 qpmEY04bwToVa1xai7XJB+BPxEmg+1Drd2i2HiaRXYbNPWuiM5gjsDokXpEv7NSoXk
	 So/iYf451KI3cNHQ5V0IfaZM6szD+mpNn8rxHQzqRY8KumfY4UvWTmZIEZIkv2lUkR
	 JZbzF2f0dg2LJ8cy4foIGpM2GLa0ES2JNAh4BmBakhBA//aOyIqLZmvqm/nNr/Bylj
	 uhtD01qqilcxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuejie Shi <syjcnss@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] fs/ntfs3: validate the EA value length in ntfs_read_ea()
Date: Tue, 10 Nov 2026 20:30:56 -0500
Message-ID: <20261111013025.390312-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111013025.390312-1-sashal@kernel.org>
References: <20261107051533-failed-6.18-351817226fbf@kernel.org>
 <20261111013025.390312-1-sashal@kernel.org>
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

From: Yuejie Shi <syjcnss@gmail.com>

[ Upstream commit 351817226fbf0031c4c63d1f5d7f15c3172312eb ]

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
[almaz.alexandrovich@paragon-software.com: applied as-is, logic is the same but the code is cleaner]
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 45 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 0bd1de7cf0362..03006ff6a296c 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -146,49 +146,32 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 	for (off = 0; off < size; off += ea_size) {
 		const struct EA_FULL *ef = Add2Ptr(ea_p, off);
 		u32 bytes = size - off;
-		size_t need;
-
-		/* Check if we can use field ea->size. */
-		if (bytes < sizeof(ef->size))
-			goto out1;
+		u32 packed_size;
 
 		/* Check if we can use fields ef->name_len and ef->elength. */
 		if (bytes < offsetof(struct EA_FULL, name))
 			goto out1;
 
-		/* Size needed to hold this record's name and value. */
-		need = struct_size(ef, name,
-				   1 + ef->name_len + le16_to_cpu(ef->elength));
+		/*
+		 * The name and the value have to fit in the entry whether or
+		 * not ef->size is set, because ntfs_get_ea() copies elength
+		 * bytes out of this buffer and checks them only against the
+		 * caller supplied buffer size.
+		 */
+		packed_size =
+			ALIGN(struct_size(ef, name,
+					  1 + ef->name_len +
+						  le16_to_cpu(ef->elength)),
+			      4);
 
 		if (ef->size) {
 			ea_size = le32_to_cpu(ef->size);
-			/* ef->size must fit the list and cover the record. */
-			if (ea_size > bytes || ea_size < need)
-				goto out1;
-			if (bytes < offsetof(struct EA_FULL, name))
-				goto out1;
-
-			/* Check if we can use fields ef->name_len and ef->elength. */
-			if (bytes < offsetof(struct EA_FULL, name))
-				goto out1;
-
-			/*
-			 * The declared entry size (ef->size) must be large
-			 * enough to hold the name and value.  Otherwise a later
-			 * reader such as ntfs_get_ea() copies ef->elength bytes
-			 * starting past the entry, reading out of bounds of the
-			 * ea buffer and leaking adjacent heap memory to
-			 * userspace via getxattr().
-			 */
-			if (struct_size(ef, name,
-					1 + ef->name_len +
-						le16_to_cpu(ef->elength)) >
-			    ea_size)
+			if (ea_size > bytes || packed_size > ea_size)
 				goto out1;
 			continue;
 		}
 
-		ea_size = ALIGN(need, 4);
+		ea_size = packed_size;
 		if (ea_size > bytes)
 			goto out1;
 	}
-- 
2.53.0

