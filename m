Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD9306756
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151861; cv=none; b=ZDgWbdCyZNewoo2xpr2bOP2L9JhQS4ZldsXj/0Q1BRGM+ja0u6Zgg6w/t9RvEH9J3u8uDLII9igQM0Uswr2HFGAVwHaV0Dnis8lMDVkZcY9aQD55E2nitPUQ1DlhrXLVnMaUqpRdD6IKewNrRvnDiGpj/xukOFBpgtHrxHsPXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151861; c=relaxed/simple;
	bh=noKHNorEGl2scw1Q11FJ5RB9RAYi5DT8oD2eTzvL7w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dk/0YXPha+fdz7ma20L58Ibi5+REgVzqBZcZARZibkwbm2xBCL89o+SQQWzxgFUhP9j1Jtfg/c8eF2YL+GhXxmpp5ny5VmNMLicF02XkTvLRH+Dv/VzoLL7ouTWh5gMaO68O/3yqcRup8UvlGS4n/i28qHXsdHglNpRZvOTNZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKhOaR0y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKhOaR0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D3D1F00898;
	Sat, 30 May 2026 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780151860;
	bh=ZiezSk7IecnWcsbiCfIyf5dB6zLHosYzXaLREN+ENaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IKhOaR0yw3bDdyjq/cVXx+PaCMy2dIqg42TESEmTby2Cizrhj71+Md69W0bXvDI28
	 zKut31E4tWSCZ0PsTsSi2LGfTtJpla4BFjOfCIQwUnQjKb2bNbzSHEVB/B9if7+FRb
	 7sl3gvlQbjMq4z7ZK0eqerJe1mQzZo7qPesMqaLe5HRH3PHvlT+WNO826R6+uTqEEc
	 7j1o1OO2+7s6gtIk+cBlbQLzhHUnIj3hYfOgXPlpAblOBB5zYxUOrFO0rfwAQpegyZ
	 aoX5fKl7fZF77jZdMC2qauQXMWsQzTlodVPrX/EdzZgluBX+peIFhKVZAOF3fIqx2Q
	 2ruEDVwEdGqKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] octeontx2-af: replace deprecated strncpy with strscpy
Date: Sat, 30 May 2026 10:37:37 -0400
Message-ID: <20260530143738.2474980-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052831-chair-shed-69f0@gregkh>
References: <2026052831-chair-shed-69f0@gregkh>
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
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 0dc802cd851d2..0d8954f934b42 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1228,8 +1228,6 @@ static inline void link_status_user_format(u64 lstat,
 					   struct cgx_link_user_info *linfo,
 					   struct cgx *cgx, u8 lmac_id)
 {
-	const char *lmac_string;
-
 	linfo->link_up = FIELD_GET(RESP_LINKSTAT_UP, lstat);
 	linfo->full_duplex = FIELD_GET(RESP_LINKSTAT_FDUPLEX, lstat);
 	linfo->speed = cgx_speed_mbps[FIELD_GET(RESP_LINKSTAT_SPEED, lstat)];
@@ -1240,12 +1238,12 @@ static inline void link_status_user_format(u64 lstat,
 	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
 		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
 			linfo->lmac_type_id, cgx->cgx_id, lmac_id);
-		strncpy(linfo->lmac_type, "Unknown", LMACTYPE_STR_LEN - 1);
+		strscpy(linfo->lmac_type, "Unknown", sizeof(linfo->lmac_type));
 		return;
 	}
 
-	lmac_string = cgx_lmactype_string[linfo->lmac_type_id];
-	strncpy(linfo->lmac_type, lmac_string, LMACTYPE_STR_LEN - 1);
+	strscpy(linfo->lmac_type, cgx_lmactype_string[linfo->lmac_type_id],
+		sizeof(linfo->lmac_type));
 }
 
 /* Hardware event handlers */
-- 
2.53.0

