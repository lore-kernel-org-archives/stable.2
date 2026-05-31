Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84AB1FBEBC
	for <stable@vger.kernel.org>; Sun, 31 May 2026 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780187045; cv=none; b=nwWfpo4/3WHBHtIlsBr/kjuATT38EUBS9pZKem8SDaFfIhk6Afd24lP3YSQZbffgT0FG1rJxCYoX2mmNehskDWnkNDR9czu/Vl0cLxN+Nxz7E1wKtr3khdWW2mW0Uwn6Lrd7qOa0yRUeMBZEiP+okwSgW1oPOnpkpIjTC374Jvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780187045; c=relaxed/simple;
	bh=IUgpqIVdZYCmcjo/ZsxEi0zpb60JU8vaZKYJfFsk5Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjJFR4gYllJUQxFnGfS8momLuO6v/jsVZowKFVb441SzGx1m1O5SgogI6S/TF+ocp2ZWEpDOHuEIRAz/xQLidNbK+s6HgP28CV93l9oZStxlpGtupkiRmfxzPaQ9lKHjnQAIKy8i6biy9Gq2zQnZltYkYJKc9OuBl+xIKozQnYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gegfyZ+9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gegfyZ+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2506B1F00898;
	Sun, 31 May 2026 00:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780187044;
	bh=EYwXZnS7/5Nu9MMXhaueLOd9aXFGfDLj71g9cPkgzRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gegfyZ+9fU858boKQXgbgsPLZ739MlO9Ubo+hfwgKi8blpigHdb51ZfDAnkgdeAfT
	 tstUBoXabZYHc+EtxcTcxYGEQaOORDpCJ4Qp/6FYFZX7r2PvUyCO6cWOgj2CgfrLSs
	 G39CEWmoU7P/jxlY6akw0PYdE7QOuh9E084nO1WyHb9KLweX7Un/Z0bXlI1pqRRLBX
	 c0x8mgpp1O3/+M0PhVADFs8NxRBfiVvZfobmz1me+qxsAwwEsJ5Tr7PZLFzBA0su5Z
	 Mw7iQqcxvwhE5j7oSj4JZeGnbhvZ1YOl1FtaZvpNXBluljR52wWWIp2HciwpxZhCnB
	 11xhl+g7wEgZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] octeontx2-af: replace deprecated strncpy with strscpy
Date: Sat, 30 May 2026 20:24:00 -0400
Message-ID: <20260531002401.3659638-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531002401.3659638-1-sashal@kernel.org>
References: <2026052833-reuse-denial-9a59@gregkh>
 <20260531002401.3659638-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Justin Stitt <justinstitt@google.com>

[ Upstream commit 473f8f2d1bfe1103f20140fdc80cad406b4d68c0 ]

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We can see that linfo->lmac_type is expected to be NUL-terminated based
on the `... - 1`'s present in the current code. Presumably making room
for a NUL-byte at the end of the buffer.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also prefer the more idiomatic strscpy usage of (dest, src,
sizeof(dest)) rather than (dest, src, SOME_LEN).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-v1-1-a443e18f9de8@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c0bf0a4f3f1f ("octeontx2-af: CGX: add bounds check to cgx_speed_mbps index")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 91d607f031dfe..a0ba4e00226db 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -679,12 +679,12 @@ static inline void link_status_user_format(u64 lstat,
 	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
 		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
 			linfo->lmac_type_id, cgx->cgx_id, lmac_id);
-		strncpy(linfo->lmac_type, "Unknown", LMACTYPE_STR_LEN - 1);
+		strscpy(linfo->lmac_type, "Unknown", sizeof(linfo->lmac_type));
 		return;
 	}
 
-	strncpy(linfo->lmac_type, cgx_lmactype_string[linfo->lmac_type_id],
-		LMACTYPE_STR_LEN - 1);
+	strscpy(linfo->lmac_type, cgx_lmactype_string[linfo->lmac_type_id],
+		sizeof(linfo->lmac_type));
 }
 
 /* Hardware event handlers */
-- 
2.53.0

