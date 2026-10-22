Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709166;
	b=uv+N5ZEqutBPodosu0r0FXgErz7A7b3ThM6ipRfpQa4VtC/HeOz3ndee/Jtydz++7xa/
	 WmLKZ4BvgKnB7qKZTef3pl3HZxlJeZYtrOuyCbrib4fwEWZhStx6eRX+RbVUqyuO5zErx
	 lw5BhktIhF32buqCn1S2HQNu+Y/9O7f/8VNotFOFnQrIV1Lm3rfE5uORK9ZFvHS2cYB6N
	 JSUsTzDVPl561X1mM+mKNSdzu98zhhSJBbQjdPMnc+uVze/2rK3Mo7plq+MlIUi/ygxZd
	 dxmTN3+E4682IvvkUjnxk/M9bIEIlOP8SgV0WMnXiinbz9P5wBtrdRiZRpDXISQYf4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709166;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nVbSUJ5UVW8Ol0Olu+NWKy++agyoaq9EJBHO+L/Hg5Q=;
	b=z6QFJ5towuHpdACPrgtEMGxWODWNWHgnuSNvIWYmcaV5nP76/Shzpg/k3rLfzWKW6BQb
	 nZiaWNfPbinZgyVQsQsuLn4h/tsmbmBJTixIXxO+LCKN++V826RGmUPR62vNBdZBEQIbM
	 pyNUh5lnG+6A8Py6rMFsoL24wM24yojisi59oelfkQrsDsWKm8XzV2nUl7Xmj0EqQOqk9
	 G6463ezh0RgqYtAnu4jwGMz6fG+hRmKe3OSrJks7uaHuXTjN3L37x+rHhjIm1YmXbqvTG
	 OvLECsoOlHqFUaWuxSVid7u/rDeZ7tTYovPGmgLcMylmOzgvNTZPgO3J3dRporISYhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJgvKJou;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBBA606A321
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJgvKJou
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7316C1F031E0;
	Thu, 22 Oct 2026 22:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709166;
	bh=nVbSUJ5UVW8Ol0Olu+NWKy++agyoaq9EJBHO+L/Hg5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AJgvKJouFDXm0T2iK1oF6r/MKUC5QyQ6UYppc/5zlkDuUBM5eilCLuueL3ngDEqFE
	 3lSwp7wiN5yKurI4LCU/smpm1DBLOuaZ1GjGesm791Y+QDBY1T+dKHdQp7ZdpJzjR0
	 j27mH/c0zo8Xxe5BCdaMNkRCkDURKMCBIt6VETCqj3C8zCQ9Guau0rD8AIENRSmuxO
	 +bb1PGAJgdC8mcI7Bb2xOr6Kgf9+mPMv91GQM1tcKzcLtPS1Qn6Hbvs9/TWDLhuIQz
	 4dUbCWddXhQsoOc9sKl0C0muTJM8On9cchYyDce3lQKdc0UeWkBPJ06yykEIIb1kn5
	 VK+449V/SXj8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongling Zeng <zenghongling@kylinos.cn>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/3] ntfs: fix memmove overlap in ntfs_new_attr_flags
Date: Thu, 22 Oct 2026 18:46:02 -0400
Message-ID: <20261022224435.2159674-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022224435.2159674-1-sashal@kernel.org>
References: <2026102234-sector-enjoyably-8d59@gregkh>
 <20261022224435.2159674-1-sashal@kernel.org>
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

From: Hongling Zeng <zenghongling@kylinos.cn>

[ Upstream commit acb1095fd2db884b417cb70808c886e4b615ff05 ]

When the record shrinks while the payload offsets increase (e.g., enabling
compression reduces padding, making arec_size < old_arec_size, but the header
grows by 8 bytes), moving the name first can overwrite the old mapping_pairs
before they are copied. Move mapping_pairs first in this case.

Since mp_ofs is derived from name_ofs, they always change in the same
direction. Checking name_ofs alone is sufficient.

Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs/ea.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index dc0a70041d788..6cc0b6cfee920 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -729,15 +729,36 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 	old_arec_size = le32_to_cpu(a->length);
 
 	/*
-	 * Move payloads before shrinking the record.  Otherwise resizing moves
+	 * Move payloads before shrinking the record. Otherwise resizing moves
 	 * the following attribute over the old payload before it can be copied.
+	 *
+	 * When offsets increase, move mapping_pairs first to avoid name
+	 * overwriting the start of mapping_pairs.
 	 */
 	if (arec_size < old_arec_size) {
-		if (a->name_length && name_ofs != old_name_ofs)
-			memmove((u8 *)a + name_ofs, (u8 *)a + old_name_ofs,
-				a->name_length * sizeof(__le16));
-		if (mp_ofs != old_mp_ofs)
-			memmove((u8 *)a + mp_ofs, (u8 *)a + old_mp_ofs, mp_size);
+		if (name_ofs > old_name_ofs) {
+			/* Payload offsets increased: move mapping pairs first. */
+			if (mp_ofs != old_mp_ofs)
+				memmove((u8 *)a + mp_ofs,
+						(u8 *)a + old_mp_ofs,
+						mp_size);
+			if (a->name_length && name_ofs != old_name_ofs)
+				memmove((u8 *)a + name_ofs,
+						(u8 *)a + old_name_ofs,
+						a->name_length *
+							sizeof(__le16));
+		} else {
+			/* Payload offsets decreased or unchanged: move name first. */
+			if (a->name_length && name_ofs != old_name_ofs)
+				memmove((u8 *)a + name_ofs,
+						(u8 *)a + old_name_ofs,
+						a->name_length *
+							sizeof(__le16));
+			if (mp_ofs != old_mp_ofs)
+				memmove((u8 *)a + mp_ofs,
+						(u8 *)a + old_mp_ofs,
+						mp_size);
+		}
 	}
 
 	err = ntfs_attr_record_resize(ctx->mrec, a, arec_size);
-- 
2.53.0

