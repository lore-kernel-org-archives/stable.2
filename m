Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361627;
	b=sSXoTb+T09FfXSXcZo96UopU3hfTO6lHanXKLeAsloUfxPF5CuCC5DY8/rUa08gpgfCI
	 7kZk/TscDvjYgnsvIvS/0kqYqt0VfFGMxPYDT+UnFboblbIl0CzmUDvWLkYXQTOMzA8WQ
	 Deb+1G1MPvDaEpXCYCjh5r3nDqLDOzPeJTcb2AfH4/vWZIc9hsn1/81Obmrm7BEyjDHcm
	 fIp621k+9/jtzw2mhVsegXRk/+Rv1RaCOSJ4DKOzpdAFW0dTUVhnmeoT8owzmTc3xD5J/
	 Wwv7qH0E5/0nkzoKAXFouRrQOpWtQvyrmNmd6CRmDx9r81SzIf/0+CJpGn8LYzah2aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361627;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Eehx40RUUiUtuilnAj/pdAHN8hD7t4yr9yrJrJ/97ik=;
	b=FnyXqDqc/Tx0DjjjANMG3qx84JsbWPXNrRIjl4DKMFn3JLdHJegyQurc6RM9QUiH1m1a
	 xADisGLZNveu7I42eZ+j9eNcyMgGG6mvJ4Y/wHE3Lxd8R4zh1q4Nbj7oNc4qvoc0MVXOK
	 YRfqfWWfKbjFOxUWfUVxqy9YSZYdP+dKZ677qG1UoNwgjNCJobcBaRp1BY6yMW9gYsgCH
	 KdsugYoDNcfCffY+8ybAZcGvZEJjPLk4YRORMsflmFM94TKm/xrYl9eVOOZkxaz7GVNll
	 HKWJ+FCCwo9U2k75omdaGb+6EvlzMFTgvpW5/fzgwa9bEbPMGThh1VQ2MNplasYIrDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gf49yoC6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72096606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gf49yoC6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB9A1F0093D;
	Wed, 11 Nov 2026 01:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361627;
	bh=Eehx40RUUiUtuilnAj/pdAHN8hD7t4yr9yrJrJ/97ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gf49yoC6PyxVAfGAspuQG4rlwhU8bOxWTa1vtMQhvZ98VGDKy/YIJHdne0KtRarA0
	 MPd21NkBN1nTEe8mcllXO4s42xaOBsky6XLTQ8rtiZFdb7jxLGZEcL0uX570LmcJjp
	 P6o2thYHX3xIHoT8KnOrpylMP+2h3LRPrEgvY7Fi4AFpBurJ1o7HpEht6KRaUs3J0b
	 SmBt89lOC7nSPvNTpNcv1N3IuFA+qobQempERHIzJYN9axV+HTq2voUHSgr6MBWicc
	 pN/jIE2PZ+wT8FJyQEvI2FJbsUP5YgRJM0TGZedkHbm00JBIxjU9nBnmIpN+CAznC6
	 PBsHS68wXMNdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] fs/ntfs3: validate that EA entry size covers its name and value
Date: Tue, 10 Nov 2026 20:47:03 -0500
Message-ID: <20261111014422.420984-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111014422.420984-1-sashal@kernel.org>
References: <20261107055620-failed-6.1-351817226fbf@kernel.org>
 <20261111014422.420984-1-sashal@kernel.org>
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
index b3b07322db990..086a926dfdfc0 100644
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

