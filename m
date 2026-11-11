Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794360420;
	b=Z3Y0fYBx6okY665l+aw73vdg1q483leZODC32/qQn18WgI8NaH9cTcfHcxUwUk3YQQpk
	 mmPEf+oSqV1rAq3owS6Xr6WHtIkxhghAdhjIjXqY17Z4ELNT3bx+tZOEUgUgn9E3G4yJV
	 fU44DmJpeXJRe7D2+Xv7tNWEQBjXi72DCkszQs91dj5BX+QtLngA9FhS/2PzooX7rT2w9
	 +Cy4dbFmlOiwdjLWuIck7drlGIvUAmrZ4OBRjQ5J3ucTvXR/C1H/dbxsCxTwoU3W9gSKl
	 UotEJDGNaaou4s0fjxVgbUNrHYbknCu9VKF8cnVclt/1fjIwkp9aj1NdZru2kO0b34A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794360420;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aNU2G/XvErmcNAq1uiJ/SV77TmX5aSpV8YKGUjbTO74=;
	b=pwkRq3yvZSOpgxBRlLEwYSvy24sfURoBvzTBo9b8ttJRvb5Ui9pGLay7MnZbhYK1AFg5
	 yoJpmFY95OAsF3QBF4Yngros/R5cZfqdtlFsvLoAmKhP/htwqU38beNGAbWn5GuRiqpyt
	 Cuv79mlGTaAl1UpMLPJi/kclhlvDV3JepXep2gdmfeVZbb2Y1N3q2TKg/p4s2pT7J5QJ6
	 z1lQoJO7h941y6rACg7B/VughA5t19PpMewM0WiGwjKyONf161dgHgKCN2PJpL7YKhwIS
	 y0ngkSEer1Wi/WfBXs/5jKriI3kvXwhAWhXKoMNUprmSyIj1Xf+E2qcpioHtUiObjtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYkGwCCs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE618606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYkGwCCs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377721F0093C;
	Wed, 11 Nov 2026 01:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794360420;
	bh=aNU2G/XvErmcNAq1uiJ/SV77TmX5aSpV8YKGUjbTO74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DYkGwCCsEi45KiuB0LUIuQHzuo9sbpVkZjEWUATiYqaepys8gqIKVOh5TQGCHqflL
	 2pTwowG9zgoO6hiz7MPxISgBULbgDhHHxAOVKlC+UHHU+LIOu8IPSgwMhZ9SpKq+0W
	 vIoDW2Wr+uTwXnVTAWKXhN9MkrFfOpt79FZXeKVyX3lbF6b0wGtiq9w9XEoZtMiEBq
	 zXdWbdqAtXd+8CN20weJbcSbPN4qM0yTiz8wN9uLE3aXtWGqkLpa/KcuS7m269vQJ/
	 7Ye4Owk04Zdj61LQepl6TRoobPzRXYsEGw25VH5P23QhPY8TzMr8188OWYiQiyRYOG
	 ESmvfGfw7HB6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/3] fs/ntfs3: validate that EA entry size covers its name and value
Date: Tue, 10 Nov 2026 20:26:57 -0500
Message-ID: <20261111012627.383224-2-sashal@kernel.org>
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
index 9eccd95a718cb..b5cb13ebd5ec9 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -167,6 +167,24 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
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

