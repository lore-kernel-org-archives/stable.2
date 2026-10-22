Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674820;
	b=mDAgyKSXSH9tv+veo48u8i5Db+Jk2b4vxrPfxDmXAZj4lKD0lZQG5na57di20PgLGu2c
	 E5A7J0PrrLL6gHoJ69/xdnMiVuHAP9ZMvc0p92ILjbHXU2sJvjt6lgnsb4ogGAbkTgqmk
	 qpk0ZxT7adALBkmOynSNZC4I3DfhEcNpPI5vXbDY7s/f9vcFRnKz+qaj+NqP41rJ4KPdx
	 UuADvE3MLGV4gIURdqpQ4R10pnQ+K3em1UnwOyFmVQHt54/9YPSxkITvdTJQltU/rZVI3
	 aEhPdtdgxJFQgksCXOc9MdZPjUMT1ruXTJ6S2v+L0rkey+/ve/s6WpaFxJi5RJvncRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674820;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZqK41XcJqoPwWSgDwgYTmN9U6FkQXP6soPgbhZW2HaU=;
	b=Wza7wTBsy2zMo3vaty40R6L39gxRgOHVu0BDn7hoMwgOFIE8N08chVpCPm8lz1mZG6c0
	 7smYTk1EXWKyLg0hZIuBb349nv4fIBMLhHZNkk1JRCNBy0iPJt0Vnmus33aMRSu2yYuYX
	 rexkahKcCIg30Hnxpa819kldiGa+An+1MCaW+CPcbVyk1oTORtFIgbRoLCBUKIK+N3De6
	 zIYCGPr2EXPZ8wX833clxJqQHHgCNPym3c7AgDtIfdSBIrn9kHYFSBZp1WcXgo2Va2SFT
	 fKQEQbFQff0wUgyiyOwbVYQEg/A/65GIWf6SySC7T7X36+VK4hKp2MjtMD5wss5KB2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yTifZceT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6E606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yTifZceT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FC81F000C1;
	Thu, 22 Oct 2026 13:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792674820;
	bh=ZqK41XcJqoPwWSgDwgYTmN9U6FkQXP6soPgbhZW2HaU=;
	h=Subject:To:Cc:From:Date;
	b=yTifZceTV/oe3rhK2rf2VUv/v/GdUgPM7wqLf0SehYLoHy90OUQ9w6/QwpD/b56xB
	 oVfdcZv3Q4LwNrYhY9GBYquEvkMCfgDSO3gY+hmdgFVnpeXcn/NfFqgpg1jRsKOIUp
	 tPTH7idGECggtcbYu214Ks+EZjPhJ134fuvVkYTs=
Subject: FAILED: patch "[PATCH] ntfs: fix memmove overlap in ntfs_new_attr_flags" failed to apply to 7.2-stable tree
To: zenghongling@kylinos.cn,hyc.lee@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2026 15:12:34 +0200
Message-ID: <2026102234-sector-enjoyably-8d59@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x acb1095fd2db884b417cb70808c886e4b615ff05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102234-sector-enjoyably-8d59@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From acb1095fd2db884b417cb70808c886e4b615ff05 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Mon, 24 Aug 2026 15:59:35 +0800
Subject: [PATCH] ntfs: fix memmove overlap in ntfs_new_attr_flags

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

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 9f0222c172d9..0bc29bf1f050 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -753,15 +753,36 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
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

