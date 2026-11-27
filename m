Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795763705;
	b=XKzsdJIg7bf6Wsg4kqHMK+RO/K+ISfNBD+Jil2ecc8XBri7Yjz84wgHpxrRMN+FWn1Hs
	 TepXvohdCjw8dYJEQW0zVibgNkByqsAAqSPOjJKZ4d8AWTa7vEGL0uX97rkAcExFspL7B
	 YLLEPpMAE6fkrXFQLtfHsqelo0YITrwc1osDrXcAY1hKO8BuZdq70aykvRnR2NhUg3yaq
	 aTIWq6JFsPDdWLjAU0/fMLKjYEMkvsXXDL3mNlHS7RQfZlBZtGC6jwqj9C0nSDyutjC7g
	 hp90BagDgtCvOTdpx3S3k0xawh5GDPu3rjqAQcdiVy4N6cEE3WUfKSrVpvyJxDv2xVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763705;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=3eIOEhxcWvtndKWJeehNeph5ty9/sMNyztCMs1CgwKs=;
	b=CyVw4TxHLyAiz+AnvRsQ/eVHpS2xsus0YmL5FIAx7UXELHzqoU3dgwv+c/RRTTzzO7/+
	 GqW/RxcNx65G+vY52dlGTdBq6stlPqJGG+JJN+zY7ESyYjwWa160Ygu9fj0W2NpOoxsNO
	 hyd+y8dduynsei/sWplBceL17sIFvZf4AJTMumLh6L47N32CWxWt3B8RBcsKNh7b/MUQl
	 TSLe+KTcooNDtWthqRINjjxLYDXxyp6xiB1tqUK1wtU14QF3ba1ClUzHCAAdd5F1NCHC/
	 O64Jqp4mYld7fC4MFAVk6QYQyA/oSrpWUXVak/Mzqxp7NRKrRwG8gJHpRuzL2T+ZzRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQaL75C1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD49606A329;
	Fri, 27 Nov 2026 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQaL75C1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795763705;
	b=TCyARde5+IiAns8oCWlG2MdVOZC3SXLiWTfbMyYesCGL6+AJGD+ILXO5qOrgsSL5pXoE
	 qvpH5a7tz/Cah20GLSfu4xYsIkDBpa9yQcGtXwK1izK/9R5HQzjVu7suxqMujNnv+0LBx
	 A+j0+a4veNJ9oexMaqYfogf/WoEK+mPmD+g/E1ObG+WCMfeDuvxzF6jzFHKKNJJwFejEY
	 zX8qFBUVQLf7+cmRt18IR3t8TTn6i01A2B+WzCow5M9U9Mrfny4hk7/out6CzYt5Zq3Zg
	 tGFXzffibEg3eOFHfvpjbvdFN9xkHxsQOSqe1FOFc/wSusKpzkRAsi6JS84gOSjcFtQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795763705;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=3eIOEhxcWvtndKWJeehNeph5ty9/sMNyztCMs1CgwKs=;
	b=S90p26Uq1x4W+UUSjcMqlztqZnH0PkqZ08wY+asgUEmwDnEQO6cQHEqig+muq01HPsR8
	 v0QHd9MTNCI0fkYI+ZBWTnXEp5uFby1wXoyes9AubyVNxpKcdAX7aFw3p5y0hrLoMKM42
	 oG4lSDDS2gJHpm3mFwV4BcMgqgmT9eBd9gii3li6YQJwnAEhF/yQl4qy76cKBW2+PMWPL
	 C3jvII7PwKJSpDAKI4Tnt0VHd98K91Vh07tW1RHvJhHn24oixCynOCRhqPZsxMNZjLuLU
	 r7AGpWqKXGDIh+KR+V2dPARHpWeoj0eb25PYbReLJKKNckfFaZvPs/x6zHUootqQQXA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0EA5F1F00898;
	Fri, 27 Nov 2026 07:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795763705;
	bh=3eIOEhxcWvtndKWJeehNeph5ty9/sMNyztCMs1CgwKs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=mQaL75C1RBB4KzkKmzaQctOSJpeoUbsKxtenhj7YWeJl+/8X6r+gXnPFGLItM5fmo
	 vxXyLHSUlRWsh87lK2Yv8EnBEQdH2HHtTV2ZiCp1LP5UguAD9WkZfz4x41IUNlx8Ld
	 nRFL4hPcDnxhwZHywZOIKlImJs24AAD3oBb10Vf9J6yeytmWBg8dR/yRuTD8j8qnUB
	 R07pRAhM2g5pRIeDPaGW0vc8UnSaZ4TkGe5HGHQ7lval2yO6mcQv7kbgtishxNPbK1
	 Xg8UatX0ClUefyu2VBiBUMto5RNnEIbUGxM7gvQl84n7+x3SBymjFFLInkDXQ3cBnQ
	 AeF2FQZA/p1ow==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 95CB34B5F5;
	Fri, 27 Nov 2026 07:15:00 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 07:12:14 +0000
Subject: [PATCH 5.10.y] hfsplus: fix slab-out-of-bounds read in
 hfsplus_uni2asc()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-so5-hfsplus-510-v1-1-7bce0139b35d@certik.com>
X-B4-Tracking: v=1; b=H4sIAE0tCWsC/12NwQ6CMBBEf4Xs2UXaSKv8ivHQlq3UkJZ0wWgI/
 y7Vm8d5mXmzAlMOxNBVK2R6Bg4p7kEcKnCDiXfC0O8ZZCOVEFIjpxYHz9O4MLaiwV65k1Rea30
 5w76aMvnw+hqv0Naiqd9w+3Fe7IPcXHSlaQ0T2myiGwpiiv2c0oiFH/9uYNs+imkmB6sAAAA=
X-Change-ID: 20261127-so5-hfsplus-510-d6c426f77798
To: stable@vger.kernel.org
Cc: Kang Chen <k.chen@smail.nju.edu.cn>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795763533; l=8506;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=r08xme+LJmtE2virVQX+u476Saf7nmCbrMz6FfBhGhY=;
 b=VcZVh6DfYRoi3iYcb1JrS8XrSPEgA4lAfooUmwbF3a+1EM3HG6Z2OS1T7JwPtEJkurc/wAwqO
 BrZRpXr5iaQB32DjfyhjzfFa4N3GbAwo699My5D4JHCGXtd4FhUtds0
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Kang Chen <k.chen@smail.nju.edu.cn>

commit bea3e1d4467bcf292c8e54f080353d556d355e26 upstream.

BUG: KASAN: slab-out-of-bounds in hfsplus_uni2asc+0xa71/0xb90 fs/hfsplus/unicode.c:186
Read of size 2 at addr ffff8880289ef218 by task syz.6.248/14290

CPU: 0 UID: 0 PID: 14290 Comm: syz.6.248 Not tainted 6.16.4 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x5f0 mm/kasan/report.c:482
 kasan_report+0xca/0x100 mm/kasan/report.c:595
 hfsplus_uni2asc+0xa71/0xb90 fs/hfsplus/unicode.c:186
 hfsplus_listxattr+0x5b6/0xbd0 fs/hfsplus/xattr.c:738
 vfs_listxattr+0xbe/0x140 fs/xattr.c:493
 listxattr+0xee/0x190 fs/xattr.c:924
 filename_listxattr fs/xattr.c:958 [inline]
 path_listxattrat+0x143/0x360 fs/xattr.c:988
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcb/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe0e9fae16d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe0eae67f98 EFLAGS: 00000246 ORIG_RAX: 00000000000000c3
RAX: ffffffffffffffda RBX: 00007fe0ea205fa0 RCX: 00007fe0e9fae16d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000000
RBP: 00007fe0ea0480f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe0ea206038 R14: 00007fe0ea205fa0 R15: 00007fe0eae48000
 </TASK>

Allocated by task 14290:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4333 [inline]
 __kmalloc_noprof+0x219/0x540 mm/slub.c:4345
 kmalloc_noprof include/linux/slab.h:909 [inline]
 hfsplus_find_init+0x95/0x1f0 fs/hfsplus/bfind.c:21
 hfsplus_listxattr+0x331/0xbd0 fs/hfsplus/xattr.c:697
 vfs_listxattr+0xbe/0x140 fs/xattr.c:493
 listxattr+0xee/0x190 fs/xattr.c:924
 filename_listxattr fs/xattr.c:958 [inline]
 path_listxattrat+0x143/0x360 fs/xattr.c:988
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcb/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

When hfsplus_uni2asc is called from hfsplus_listxattr,
it actually passes in a struct hfsplus_attr_unistr*.
The size of the corresponding structure is different from that of hfsplus_unistr,
so the previous fix (94458781aee6) is insufficient.
The pointer on the unicode buffer is still going beyond the allocated memory.

This patch introduces two warpper functions hfsplus_uni2asc_xattr_str and
hfsplus_uni2asc_str to process two unicode buffers,
struct hfsplus_attr_unistr* and struct hfsplus_unistr* respectively.
When ustrlen value is bigger than the allocated memory size,
the ustrlen value is limited to an safe size.

Fixes: 94458781aee6 ("hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/20250909031316.1647094-1-k.chen@smail.nju.edu.cn
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
5.15.y and newer already have this fix. 5.10.y already has
76a4c6636a69, the backport of 94458781aee6 with the same subject; this
is its follow-up (Fixes: 94458781aee6).

Tested on v5.10.275:
- x86_64 allmodconfig W=1 build of the 21 fs/hfsplus objects, base vs
  patched, no new warnings
- booted the patched kernel under QEMU/KVM. I didn't mount an HFS+
  volume.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

fs/hfsplus/dir.c        |  2 +-
---
 fs/hfsplus/dir.c        |  2 +-
 fs/hfsplus/hfsplus_fs.h |  8 ++++++--
 fs/hfsplus/unicode.c    | 24 +++++++++++++++++++-----
 fs/hfsplus/xattr.c      |  6 +++---
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 4f3ef53b95d9..797bf045b2f7 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -212,7 +212,7 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 			fd.entrylength);
 		type = be16_to_cpu(entry.type);
 		len = NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN;
-		err = hfsplus_uni2asc(sb, &fd.key->cat.name, strbuf, &len);
+		err = hfsplus_uni2asc_str(sb, &fd.key->cat.name, strbuf, &len);
 		if (err)
 			goto out;
 		if (type == HFSPLUS_FOLDER) {
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index ae4e8f304116..b0e3e743046d 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -520,8 +520,12 @@ int hfsplus_strcasecmp(const struct hfsplus_unistr *s1,
 		       const struct hfsplus_unistr *s2);
 int hfsplus_strcmp(const struct hfsplus_unistr *s1,
 		   const struct hfsplus_unistr *s2);
-int hfsplus_uni2asc(struct super_block *sb, const struct hfsplus_unistr *ustr,
-		    char *astr, int *len_p);
+int hfsplus_uni2asc_str(struct super_block *sb,
+			const struct hfsplus_unistr *ustr, char *astr,
+			int *len_p);
+int hfsplus_uni2asc_xattr_str(struct super_block *sb,
+			      const struct hfsplus_attr_unistr *ustr,
+			      char *astr, int *len_p);
 int hfsplus_asc2uni(struct super_block *sb, struct hfsplus_unistr *ustr,
 		    int max_unistr_len, const char *astr, int len);
 int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str);
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index ebd326799f35..11e08a4a18b2 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -143,9 +143,8 @@ static u16 *hfsplus_compose_lookup(u16 *p, u16 cc)
 	return NULL;
 }
 
-int hfsplus_uni2asc(struct super_block *sb,
-		const struct hfsplus_unistr *ustr,
-		char *astr, int *len_p)
+static int hfsplus_uni2asc(struct super_block *sb, const struct hfsplus_unistr *ustr,
+		    int max_len, char *astr, int *len_p)
 {
 	const hfsplus_unichr *ip;
 	struct nls_table *nls = HFSPLUS_SB(sb)->nls;
@@ -158,8 +157,8 @@ int hfsplus_uni2asc(struct super_block *sb,
 	ip = ustr->unicode;
 
 	ustrlen = be16_to_cpu(ustr->length);
-	if (ustrlen > HFSPLUS_MAX_STRLEN) {
-		ustrlen = HFSPLUS_MAX_STRLEN;
+	if (ustrlen > max_len) {
+		ustrlen = max_len;
 		pr_err("invalid length %u has been corrected to %d\n",
 			be16_to_cpu(ustr->length), ustrlen);
 	}
@@ -280,6 +279,21 @@ int hfsplus_uni2asc(struct super_block *sb,
 	return res;
 }
 
+inline int hfsplus_uni2asc_str(struct super_block *sb,
+			       const struct hfsplus_unistr *ustr, char *astr,
+			       int *len_p)
+{
+	return hfsplus_uni2asc(sb, ustr, HFSPLUS_MAX_STRLEN, astr, len_p);
+}
+
+inline int hfsplus_uni2asc_xattr_str(struct super_block *sb,
+				     const struct hfsplus_attr_unistr *ustr,
+				     char *astr, int *len_p)
+{
+	return hfsplus_uni2asc(sb, (const struct hfsplus_unistr *)ustr,
+			       HFSPLUS_ATTR_MAX_STRLEN, astr, len_p);
+}
+
 /*
  * Convert one or more ASCII characters into a single unicode character.
  * Returns the number of ASCII characters corresponding to the unicode char.
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 2438cd759620..644b3cd5fe52 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -738,9 +738,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			goto end_listxattr;
 
 		xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN;
-		if (hfsplus_uni2asc(inode->i_sb,
-			(const struct hfsplus_unistr *)&fd.key->attr.key_name,
-					strbuf, &xattr_name_len)) {
+		if (hfsplus_uni2asc_xattr_str(inode->i_sb,
+					      &fd.key->attr.key_name, strbuf,
+					      &xattr_name_len)) {
 			pr_err("unicode conversion failed\n");
 			res = -EIO;
 			goto end_listxattr;

---
base-commit: 99112ea818e35b606397c84fbc05e6fadb6ea162
change-id: 20261127-so5-hfsplus-510-d6c426f77798

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


