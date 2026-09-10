Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500FB3546F4
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003576; cv=none; b=hlfsXR6AWa45Zd0VaOhzfu44NV6jgSCvq34a6nLCzOQSKXDiRLJOo/6eXOB+xIIKR4MfIJqR2UFDZ0xVYBtDOXOmotnQeukzbLp1lw7U2/OHG/47TxGHelu/Cf+DbGooZg+yyGjg5yFL0qC6D8xiY8SHtZu21ElyYXqESuu9jWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003576; c=relaxed/simple;
	bh=zfO2b0uqkNFsHhSFBTRYCikor7k9swZKKtU6VEjuoDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfPv26SWDuPBkgn4xxRuNQjW/wxAA8H7qNxAAw13KNIs401SYlAyyiOqpmrIUGmJas/M8ahUQNHRw2SeDyYTnubTu2XD82JW59GSFDqSJMnbg03MsSJxUyFrp6A/J7M5Dbei24LXkub9wjMBuzamWW+XOApjM1XgikqFLHVIVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FenfbCik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FenfbCik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6641F000FF;
	Thu, 10 Sep 2026 01:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003575;
	bh=5OpQreAgXcWdX6jXWOaB+foX2uIAJpyimt9Vx1ePUv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FenfbCikfIi1U68a6Xi17dipXutNLe1K++ePKeqmwQRr4+EnIWmehqnsFQzYfFYE/
	 FlnxVuICigQTH7BfGuIbr7cfb7ETDwId1R57xX+7zQ7nQLQUI0IaQty83GMy7sQX+T
	 eiCwxnC5pbf5ki2YzpQYpzmA1tczZAVxTj8D1m7s0jR4dzhBlRl6WdAzZgcP0Uy72l
	 yunomMBAHRf7N/oPNIg3Ivk7FODyKEPeJjJQfDbHW310/NfaCQfzX5dNsF/R7bDI+0
	 yKGc8PPtj7Cp/xa3/0ElIC/636ZBSpdF+WSmQUqNlUNfBhpRXTI4+MUTsxQrln9Nt8
	 R7upW5Y7aHH7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?HE=20WEI=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89?= <skyexpoc@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()
Date: Wed,  9 Sep 2026 21:26:10 -0400
Message-ID: <20260910012610.3866859-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910012610.3866859-1-sashal@kernel.org>
References: <2026090803-refract-segment-1a96@gregkh>
 <20260910012610.3866859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: HE WEI（ギカク） <skyexpoc@gmail.com>

[ Upstream commit 7c4841e2a62794a3bab7c1ff0540580f387e377f ]

ni_create_attr_list() allocates a fixed buffer of al_aligned(record_size)
(== record_size) bytes and then walks every attribute of the primary MFT
record, writing one ATTR_LIST_ENTRY per attribute and advancing the cursor
by le_size(name_len), with no check against the end of the buffer; the
total size is only computed after the loop.

A minimum-size resident attribute occupies SIZEOF_RESIDENT (0x18 = 24)
bytes on disk, but an unnamed attribute expands to le_size(0) (0x20 = 32)
bytes in the list.  Because the number of attributes in a record is not
bounded (mi_enum_attr() accepts arbitrarily many equal-type, nameless
minimum-size attributes), a crafted record packed with such attributes
produces a list larger than record_size and overflows the heap buffer.

This is reachable from a crafted, loop-mounted NTFS image: opening the file
and adding an attribute (e.g. via setxattr) drives ntfs_set_ea() ->
ni_insert_resident() -> ni_insert_attr() -> ni_ins_attr_ext() ->
ni_create_attr_list().

  BUG: KASAN: slab-out-of-bounds in ni_create_attr_list+0xc48/0x1058
  Write of size 4 at addr ffff000008984c00 by task setfattr/345
   ni_create_attr_list+0xc48/0x1058
   ni_ins_attr_ext+0x510/0x7c0
   ni_insert_attr+0x3f8/0x70c
   ni_insert_resident+0xc8/0x3b0
   ntfs_set_ea+0x66c/0xd28
   ntfs_setxattr+0x4d8/0x5b0
   __arm64_sys_setxattr+0xa4/0x124
  Allocated by task 345:
   ni_create_attr_list+0x188/0x1058
  The buggy address belongs to the cache kmalloc-1k of size 1024
  (the write lands at object+1024).

Size the buffer from the actual attributes instead of assuming a single
record_size is always enough.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Reported-by: HE WEI（ギカク） <skyexpoc@gmail.com>
Signed-off-by: HE WEI（ギカク） <skyexpoc@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 162a6c038000e..45e8d73d38f8f 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -823,10 +823,23 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	rs = sbi->record_size;
 
 	/*
-	 * Skip estimating exact memory requirement.
-	 * Looks like one record_size is always enough.
+	 * Compute the exact size of the attribute list.  Each attribute in the
+	 * record yields one ATTR_LIST_ENTRY of le_size(name_len) bytes.  The
+	 * minimum on-disk attribute is SIZEOF_RESIDENT (0x18) bytes, but an
+	 * unnamed one expands to le_size(0) (0x20) here, so a record crafted
+	 * with many such attributes needs more than a single record_size; the
+	 * previous fixed kzalloc(record_size) could therefore be overflowed by
+	 * an attacker-controlled record.
 	 */
-	le = kzalloc(al_aligned(rs), GFP_NOFS);
+	lsize = 0;
+	attr = NULL;
+	while ((attr = mi_enum_attr(ni, &ni->mi, attr)))
+		lsize += le_size(attr->name_len);
+
+	if (!lsize)
+		return -EINVAL;
+
+	le = kzalloc(al_aligned(lsize), GFP_NOFS);
 	if (!le)
 		return -ENOMEM;
 
@@ -836,7 +849,6 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	attr = NULL;
 	nb = 0;
 	free_b = 0;
-	attr = NULL;
 
 	for (; (attr = mi_enum_attr(ni, &ni->mi, attr)); le = Add2Ptr(le, sz)) {
 		sz = le_size(attr->name_len);
-- 
2.53.0

