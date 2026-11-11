Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362249;
	b=5FbcujVYrcOWdiLw4yg2MMYzo0cJXUbnjisymFF/k+8Unwye2pihbtnt9S0Ozw6wNNvL
	 fBxfKzPCG8aaHcPReTfWOby2eNJLlNftAOYMnn0sQYxCzlQKxE4M+uxJ2giX7RXml18+a
	 5aRdWFwK8Pc17HgAQIZT/u/rVEQVkqqLIeRcqfTpE2JosB9frqaIh+J6MfE5W35pqwm3c
	 kFeF3GYXPSG6syFS1J91KXjUDgCfF73XAtUU2qcjwqo5E4a0jlxx5CMkT6sTygBa22n1V
	 PKgCWEgybMdEqWlVg3rqZv3gehEfaFXRZH09hS4M/INSPZvCug00a251arLVmVjlUEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362249;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JjNNQnwXb8qSpFmbkOTAc3bWBtRqSwyO7vWdpjQMJbE=;
	b=AUO1euo908vGF12NEnIXxidznsY50g2XZIe5UCwhM9fNgPXKVqlAgl2xRqxUMTsLz42x
	 w0chvgK5n6JR1kcOF4KoB9agql2J8X543+xlKXrrnUCJb8yJRjHEG3R5s2K6qR040gjbY
	 MAs3HshI3uOgJqE5ZHV7FDc9ThwTpSCQQScCm5K0JFGnKJHLnkMRCWaOcK0h0IyPsFd6J
	 AHQBemTOSaXHyJINgifrcHROI9XmKJjOSjnAlc40Wp2+9mQUzB88s29r/KuinIWW1qwo+
	 x6J/r1wGYDKAJQ6uKMtzY/H5AWPQoDXLEgHAhPD8wayy8XGG5vQsEVF58Z5lPVeQGAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkPtLOIM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DB606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkPtLOIM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E901F0093D;
	Wed, 11 Nov 2026 01:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362248;
	bh=JjNNQnwXb8qSpFmbkOTAc3bWBtRqSwyO7vWdpjQMJbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OkPtLOIMo+VIjdlQfPwVGmz9FOmcR9Qh2f42dS4Yv44//q0uyGRLgRTEPvRf3RJ2a
	 1Z6hhBss4RYnIRH64KBg0fZ6Dwe9MdtI+8atGCsTRwkUXweKLUBtzPseCi4f3bfBlu
	 Z1KcAXR11WezN+g/I9wTKWBH6qFnwnBMyDUJKog++VrYDX+pxw0MbyZOqJ8CwoZj4z
	 WC2qoDwmqcKMmprT/ZjnqBTEG3++zoGCy76dL52mx3QxHE4BB/AXqH4eBPXz/prxIY
	 q+UeAa6d5UGfbHhMLJBjiEQQF7krhI8YR7TASPeBx23upWFCMwND8RyK/nyyxaGpJU
	 GnHiWbQke7lSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] fs/ntfs3: validate that EA entry size covers its name and value
Date: Tue, 10 Nov 2026 20:57:24 -0500
Message-ID: <20261111015355.444686-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111015355.444686-1-sashal@kernel.org>
References: <20261107061313-failed-5.15-351817226fbf@kernel.org>
 <20261111015355.444686-1-sashal@kernel.org>
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

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

[ Upstream commit 60bd50014cc9a97c5e34a8bddd2bad4d2dc5acb7 ]

ntfs_read_ea() walks the on-disk $EA attribute and checks each EA_FULL
entry for consistency.  For an entry with a non-zero ef->size (the
offset to the next entry) the loop only verifies that this stride fits
in the remaining buffer, and then continues:

	if (ef->size) {
		ea_size = le32_to_cpu(ef->size);
		if (ea_size > bytes)
			goto out1;
		continue;
	}

It never verifies that the entry's own name (ef->name_len) and value
(ef->elength) actually fit inside ef->size.  A later reader trusts
ef->elength unconditionally; ntfs_get_ea() does:

	len = le16_to_cpu(ea->elength);		/* up to 0xffff */
	...
	if (len > size)				/* size is the user buffer */
		return -ERANGE;
	memcpy(buffer, ea->name + ea->name_len + 1, len);

A crafted image with a small but valid ef->size (e.g. 24) and
ef->elength == 0xffff therefore passes validation, and a getxattr()
with a large enough user buffer copies up to 64 KiB starting just past
the short entry -- an out-of-bounds read of the ea_all allocation that
leaks adjacent kernel heap memory to userspace.

  BUG: KASAN: slab-out-of-bounds in ntfs_get_ea+0x2b8/0x3f0
  Read of size 65535 ...
   ntfs_get_ea -> ntfs_getxattr -> vfs_getxattr -> do_getxattr

The zero-ef->size branch already computes the same struct_size() to
derive the stride; mirror that in the non-zero branch and reject the
entry when its declared size cannot hold the name and value.

Fixes: 0e8235d28f3a ("fs/ntfs3: Check fields while reading")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 351817226fbf ("fs/ntfs3: validate the EA value length in ntfs_read_ea()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index e05fd36cdd89a..ee2f38b912d23 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -166,6 +166,24 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 				goto out1;
 			if (bytes < offsetof(struct EA_FULL, name))
 				goto out1;
+
+			/* Check if we can use fields ef->name_len and ef->elength. */
+			if (bytes < offsetof(struct EA_FULL, name))
+				goto out1;
+
+			/*
+			 * The declared entry size (ef->size) must be large
+			 * enough to hold the name and value.  Otherwise a later
+			 * reader such as ntfs_get_ea() copies ef->elength bytes
+			 * starting past the entry, reading out of bounds of the
+			 * ea buffer and leaking adjacent heap memory to
+			 * userspace via getxattr().
+			 */
+			if (struct_size(ef, name,
+					1 + ef->name_len +
+						le16_to_cpu(ef->elength)) >
+			    ea_size)
+				goto out1;
 			continue;
 		}
 
-- 
2.53.0

