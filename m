Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048021;
	b=ymTsLkZcu67daQlqa40ruogiqT6VQN/As6vs8gGZThdbPcC5lYwuoTdsooZcFRt0e1vM
	 zjExe91k2N2Eag+0wUfhPHdrE9Zr6/dcImVD+PvJn1t8k+XO7EfI4gbUGTjKP9Nv9vYFp
	 dHcHImgrRnGViSlQfkvlo30DOVVjTxi7NlsSqdmt+o0+kGxZE4CObNvjaUjTqi4FnktXc
	 GQwZEEGw2AlOjyFkYRdB5gphH4TNdy6rJ83x4SJ8T4bwp9d+UW3Uc/SkEYMJ2pa5LlVf9
	 YglWtdXh/rAqO7FOJo+QKpRBf2YjGDXF+DJKuyQjAOfQJvF83CTLXvXeXIXZ08ZQS7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ywjiSJmEa05kM5K0nfT96lNRgUSTD32nI0DreIBabqM=;
	b=naAjcifTclI0vF33816Z+MPpyYXl4J3bkn/4bEvi2fsjXBeET5Lj6SioBPfQwBfjB3sT
	 NYCgicGFPbY0lrVlBaQdb4RsRFRImOEPrmJp9z3oQOaL12S1Zlo5cp1Mj8s8N199oFMoa
	 cg2HoTsY9yN4QCnAcolsvbEvAbf5Ytv+8KkXQzWJFgfqdOfULB5zRo2oxvJQ84IOOYD/x
	 GUnBnCcX2vo+QLDYaEoLVxmjxczHpV/SJq8vWERYY6fbprOuUWnrNdLvVbe68umadWg7p
	 Gd+WaI9C7j19A7Q4O97ubkWTe2NWRlEgo5KGyPSTs+HBZtLydXLs8AYtSAE3rTMRsLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtvRJIyr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF8606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtvRJIyr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AE01F0089F;
	Sat,  7 Nov 2026 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048021;
	bh=ywjiSJmEa05kM5K0nfT96lNRgUSTD32nI0DreIBabqM=;
	h=From:To:Cc:Subject:Date;
	b=gtvRJIyrufSZb7gNHr7oRcOlB7iq24cCjiEZwny5O+/OCRVE5jN14DXJXeJIQGt4h
	 AX2tjv6uJFEAFKKMylp3esBdDSkV0d14f2g9/TL4u2mwmychE7QUFZytR+eMzRdC+E
	 cqFDBE8/yNXvfmx+dxCl6NkdNmFB4xEBM+Fexmx0NDNfNB7/bz0zMuxDEmSbeuaM+2
	 3cvdMkauZXNYZyMW9HvGqUAh06Td1PgKnflEuIVpncaqohjWDqn+P42S/p31Roc4rP
	 rGDy1UTW1E/+c0xrwj4/Tp1k1iIP12ziCgDshkypxfqkzlWJ2d5zO9gJBY2rvyX3ip
	 6XjxzMW61P93Q==
From: Sasha Levin <sashal@kernel.org>
To: syjcnss@gmail.com,
	almaz.alexandrovich@paragon-software.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs/ntfs3: validate the EA value length in ntfs_read_ea()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:40:19 -0500
Message-ID: <20261107054019-failed-6.6-351817226fbf@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 351817226fbf0031c4c63d1f5d7f15c3172312eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054019-failed-6.6-351817226fbf@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 351817226fbf0031c4c63d1f5d7f15c3172312eb Mon Sep 17 00:00:00 2001
From: Yuejie Shi <syjcnss@gmail.com>
Date: Mon, 3 Aug 2026 12:34:32 +0800
Subject: [PATCH] fs/ntfs3: validate the EA value length in ntfs_read_ea()

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
---
 fs/ntfs3/xattr.c | 45 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index d6ad06415318d..e1fa58aa03611 100644
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




