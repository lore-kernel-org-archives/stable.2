Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794360421;
	b=gUee18LGNrnBiUHmLbfz4OFfcDXyLaQHEYb9adOcN6f6clFgF1jVfNnmhIUHlovz4up7
	 WBWhwZU1YL6HTSINHMji4uw53APIhIxmx7lZ41q6TFkBzQlebezCtyvXzMS+13YICF7x3
	 NYz5Y2RyzOW3cZdoiTmy9V097gyZ0XXc4gjCSG159//zIX8Z6R/lTew93ys8u4Ha2gMw3
	 Un+/SLqa5Ad8Cq9ZkL94lCmivChB+BTjzNu42ei9kEFc9AkNrw70OJEwa5ZZ04g1JyvO3
	 xPtVyIXjGcU4zrTA3oa5WOdLolnm0FMBriH4OzH8FP410g1iCtePcEYmgGfdKz/qs/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794360421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4t1DDpg8M3V1Sq1rF9IRDbVPzccGy4Z9+OQZ2rUnjCo=;
	b=kDUGEEsAkdvzxJ46vwcq9AQWUQr9pDA1k71166yHrISB8H7J9JkyUep8F+wD62xnsoRo
	 yzEViEHEnUwbBell9ziiESzt4Md9HFlx+OTPSzsxN694I8rlbeDgxzfj6es6hEy6hCpvB
	 cEwcHDFGJbekLnh6S/xmppAqfou2E55ZuoyHfKfUYEt/eqWjnQeUrM9z3rH6aaFcTymn4
	 v8o+AZ5/p9MseQgj/LbGUi6jqLzEJ6JdMknTf0LBT2ysXqgSztJ1T5uEmQcldjlEUy0Wg
	 cRQ9M4iArzG9w+vAGq4dNuRfA9FHRU48iHcxSMMszpBG1eoy+w9xTHRlepV0zLkQnFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRKlvGal;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218A606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRKlvGal
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F391F0089F;
	Wed, 11 Nov 2026 01:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794360421;
	bh=4t1DDpg8M3V1Sq1rF9IRDbVPzccGy4Z9+OQZ2rUnjCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kRKlvGaliKpLWJ8FktSuUfpVKh+iYImWelMOc4GooFn2KbkMKy2gj8x2oD6/dENYL
	 SHW0d9iogTv8u1nwmtufCJEsBQXiHvLKzOQt6gqRa43vOzavIeO4TtNJVDbuNg7BN/
	 6EoNuFKHtA11Jj0xY3muXKfsdK5Up/sJI8UvfNmlta2xvQ3HOMKJd41ZQN44ii2VJ9
	 Acoq0xzxIJjakJ1w8l7ucE0XKKtTXD6mvtTt7EQIut0FbgQEH0fwKrzpVPrEwo1rvL
	 SUgpqfFGPRpN0KV90CbIpg9OcYLmIwe6CXIwFvcV8KHVJzMM3WZ315ouIMPEbSdABa
	 wtEGzzY/J/fgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuejie Shi <syjcnss@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 3/3] fs/ntfs3: validate the EA value length in ntfs_read_ea()
Date: Tue, 10 Nov 2026 20:26:58 -0500
Message-ID: <20261111012627.383224-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111012627.383224-1-sashal@kernel.org>
References: <20261107050557-failed-7.3-351817226fbf@kernel.org>
 <20261111012627.383224-1-sashal@kernel.org>
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
index b5cb13ebd5ec9..fb7276d4a4285 100644
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

