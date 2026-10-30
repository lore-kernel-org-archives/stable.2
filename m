Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793318963;
	b=LEElhCG30WOhG8SqvQpYR0wSnwuv5Q6OiSRIEIssppR72Kz/1oM8Y51b39zJwwaIzTAZ
	 5h4q/iIjhfjRkFEebZC2Tu7SCyuBldvZEdMbORD6OBsLFQ0IjRvKiWvRjvlen11NQfYlE
	 8S/kW80jo1DU7RXpC3AyhaYSi6+j+mYht0nMML+Oeh/+ky8HroSH7s8YjMhHxgOegeYwo
	 IC2RkFO8ITJQ5LUV25vlvxVMAGR1kxj7AOn+7wcyLrd2m5tAWVHKmoGQrahHmMjKS266/
	 LMzusR0FJC5FpajqE9wMMwmFsXSlEVeS/cnRIed9RCuxX7itBbqvq2qOoHDU5Wux7nQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318963;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z/9+7z7n7OPewsmKtmYrEtV8r0qvpN8drqu/1tRb7us=;
	b=jldsIRe/knkQ5F9sz8WNJ0E7aWvWDBjIMsaj1tXT5vTA9B06ASh1Fgzzwp3KHciyJqBS
	 IUYE3MdUzgR01yDfX//hOjONbQulr1HXP2iSvM9vVuL8CIDMxJbr3+ISTIpzNb33TbxA4
	 Gs2EIrBvhDdHS4pPWN1CSxGKrej0+eYIAUqM/amVBGlXH/H7pmqXkzob/m5mzTkGnDYuZ
	 Oyn6VjjzxBx3w94kHRfadu4iI8tUcBUhWMmpwEbsjWHPpTHr5J2aa57KUWob0U53wvpwX
	 95qQnpuohvPA4bkEkG+IcZBXoXbVMUQh27ZAweZOHkvj5Du/todanCiNYHkEVMsUbeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObRc1r1f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192B606A324;
	Fri, 30 Oct 2026 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObRc1r1f
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793318962;
	b=rnTKS654JuCjpTIt/x8whOAQRsyWVUxi25mSKE5guu06633msKviR7xQbNcTmPPKo7Rk
	 Cvawkj0fZqjuFAYgqs870nqkZJTkw3QjEGyZFYdtMrHl7vc8Wr0uA/3j1lq1VlGVkx5U3
	 x3WWxOxAAW0f4ub9jwJSYVVBERVwKp+Bc7KpEKPyAAitkaGeMS0+HrnqCqMMRVHB9cECy
	 dPfScj+YeKEE10pwp8ChpCrR5k/PVtIepqsboZ0NtvI3JF9iP2s3fze1SsIj1NIj2AbWd
	 TTzDn0AfctMcE6FBcaiN4wD6PSFNgw+v1kIjTzPCv/tZtuKXGM1FsEI+zN1nUXzAnWQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793318962;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z/9+7z7n7OPewsmKtmYrEtV8r0qvpN8drqu/1tRb7us=;
	b=J0Ld0gyHo4v/gWl88b3CnFzzJ9oAetJ93WI2Y9bA63yrd6t+lVmCI/jI5Cf0u23HBwl+
	 bhksuO4oShss3Ae5d6Bsotmj3G0BzCZ+7sLpbpeMTOpuYfSEk/CUN9RA89J55b7lKnR48
	 d/T7vVeL3E+AcJqUUMndSZbVchfTjrvzb24ENscfnIvQbS5GiHIHhJh/QIEnvFi2QyN/a
	 pwKzNDXDUkRDYQs3ga34OZeH4TNBSCWD2ck1nI/maQeSk8cxeKvJqGFpM0XvQ9/Jk2hht
	 k/n7bgjExkjkKBL74VU7kmn+1f/65RAufpQFN/9APpoLtsrKfpLXq1YCfjhysoAcm1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 060B41F00A02;
	Fri, 30 Oct 2026 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793318962;
	bh=z/9+7z7n7OPewsmKtmYrEtV8r0qvpN8drqu/1tRb7us=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ObRc1r1fvbnAWcS0cGpjBECCBxEDOmlf4Eaea+9fG1+2/RTxEXlTkn45uRZzyCQbz
	 fL0sVvpz4v6ROSjRKHbr7EyMZD/S/H5UbiogsgSCNy9xuRLc4Ha73dGIgu2hheg/ZC
	 2ZEyzRoao+4iZY0d4MXeB1XJ1C3Jat1Q7txVmTSHweRQ/LrLLs9zpu4nhXnMS/RdDM
	 i2mqaXnpQKlE5dshR5w9/gCyOxrtYC3SpM5Z6vq1KGRg/nZKC51iNnXWHfVAOlteCI
	 agEztfHcWcZ+UpwNpn2PLLdqluFDKwcjQwEgaSDAFmmeVTd3N7YtMbxidDWk10tsAl
	 JNe1SKJCd6mgA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8AFD1409E8;
	Fri, 30 Oct 2026 00:09:20 +0000 (UTC)
From: Kamil Chojnowski via B4 Relay <devnull+contact.diath.net@kernel.org>
Date: Fri, 30 Oct 2026 01:08:12 +0100
Subject: [PATCH 3/6] fs/ntfs3: grow $DATA before publishing i_size in
 setattr
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
Message-Id: <20261030-ntfs3-resident-fixes-v1-3-7b6c857d4330@diath.net>
References: <20261030-ntfs3-resident-fixes-v1-0-7b6c857d4330@diath.net>
In-Reply-To: <20261030-ntfs3-resident-fixes-v1-0-7b6c857d4330@diath.net>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kamil Chojnowski <contact@diath.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793318890; l=2070;
 i=contact@diath.net; s=20261029; h=from:subject:message-id;
 bh=7HOdxVxQld0b8asqtryZkiGhGYBL8zKR9nHtG8ic/Wc=;
 b=fIuBcBrlV1myWWZUvrtOfk9qvVJK5hYoH2Gev9y2W/Q1YjRYTtg1Sr2QCUHCdODwdm5QbFbpY
 6Sm7yDTuvKbANYh5eFOplz0fS1qXfbqDQkl8qkE3tC/RWUESNWxp0kl
X-Developer-Key: i=contact@diath.net; a=ed25519;
 pk=G15RQXroUn6f8ud+bOEqlqpPdpLoCB3L3G9XVUf+YaA=
X-Endpoint-Received: by B4 Relay for contact@diath.net/20261029 with
 auth_id=1360
X-Original-From: Kamil Chojnowski <contact@diath.net>
Reply-To: contact@diath.net
Content-Transfer-Encoding: 7bit

From: Kamil Chojnowski <contact@diath.net>

ntfs_setattr() calls truncate_setsize() and then ntfs_set_size().  When
a resident file grows, i_size is updated before the resident attribute,
so a concurrent read gets an inline mapping shorter than i_size:
iomap_read_inline_data() warns and the read fails with -EIO.

  WARNING: fs/iomap/buffered-io.c:431 at iomap_read_inline_data
   iomap_read_folio_iter
   iomap_read_folio
   ntfs_read_folio
   filemap_read_folio

attr_set_size_ex() updates i_size itself once the attribute is resized.
Call truncate_setsize() first only when shrinking; when growing, resize
the attribute first and then call pagecache_isize_extended().

Reproducer: extend a small file with ftruncate(2) in 64-byte steps while
another thread reads it; it fails within seconds.

Fixes: ecbb433f9a8e ("fs/ntfs3: fold file size handling into ntfs_set_size()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Kamil Chojnowski <contact@diath.net>
---
 fs/ntfs3/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 384e61a33a84..3b91586c4630 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -755,7 +755,14 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		newsize = attr->ia_size;
 
 		if (newsize != oldsize) {
-			truncate_setsize(inode, newsize);
+			/*
+			 * Grow the attribute before i_size: read_folio maps
+			 * resident data by the attribute size and fails with
+			 * -EIO if i_size is already beyond it.  ntfs_set_size()
+			 * updates i_size.
+			 */
+			if (newsize < oldsize)
+				truncate_setsize(inode, newsize);
 
 			err = ntfs_set_size(inode, newsize);
 			if (err) {
@@ -763,6 +770,9 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				goto out;
 			}
 
+			if (newsize > oldsize)
+				pagecache_isize_extended(inode, oldsize, newsize);
+
 			ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
 			ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
 			inode_set_mtime_to_ts(inode,

-- 
2.56.0


