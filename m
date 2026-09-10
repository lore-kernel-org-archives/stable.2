Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E446D2BA
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038554; cv=none; b=CqFrkyJL+WsUBwkdz2ZwMd5ucmubVdmD7zJ7qlKUf2n02bTvKKYG7iIHprbUzKjD7fLJLYQtE8yQfOqtl/IuZbb048YfW+C3U3eR9mX2vYayLLZi3NeeEGNmOoGvkXm6gJ+tDaLw418brN/F6HrFpw+1u9wlYjWcGEiTQYbcLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038554; c=relaxed/simple;
	bh=wqlMBmPWQTBH12Xcv6OAV88xBy32FA8MTMOFm7df63A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTL7KmKzV4A5jiCS/CoKnZxzBeJYAVelYoFRYgFU+fbtsAiwGkF6QG5OE0Viqrl6GUC2NW72UVfwXp/FJ2PVvlVX6L6X1FTVyPAc4IF7whexkiOfGjohCvvT5lQXJpZgonTMmj3wT8geX9EvHwPg4YD+4MO7/6TxxYhLRQVeQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7dB/kac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7dB/kac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A5D1F00893;
	Thu, 10 Sep 2026 11:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038552;
	bh=E3EBTL7AcRynd5zfFDoTb9IG7zb1mTWu26Ppm8aUgno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R7dB/kacuiEyr1qLOEpxwIsrcHgDvtCIzN4zhijMwakbO37eAt4decAsqJJfNfvc1
	 JlGe7fhZxJ7AQDEAJeZ/gh7s9jc87gjG21V2Jzu7BWlQv3BOBhU/frHAog96QHwifF
	 yOUaSXZZPFishk/2r019EfqG0WK61WXLLfFVR53DqT/PpBAz7HDElQdWmpjniZGMNT
	 OnkHNCRRmYOY8y7PUEVAZuNymTSty4ki8XdrIV/GRGv3lbx80iMELn2EUEvZcslt7z
	 ciPVNG7rsD1q4f9aWHayDDlNjYig5r8h7i9hr84/aFmPYIN4u1gmsTBxCsKpqOihD5
	 YPekJHATjBg+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
Date: Thu, 10 Sep 2026 07:09:10 -0400
Message-ID: <20260910110910.4148201-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910110910.4148201-1-sashal@kernel.org>
References: <2026090820-skid-bronchial-d83e@gregkh>
 <20260910110910.4148201-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Bilal <meatuni001@gmail.com>

[ Upstream commit 28a289beaf226b30b1e6e7d7b1a2946fe2d6e852 ]

rtw_restruct_wmm_ie() scans in_ie for a WMM IE with:

	while (i < in_len) {
		...
		if (i + 5 < in_len && in_ie[i] == 0xDD && ...) {
			...
			break;
		}
		i += (in_ie[i + 1] + 2); /* to the next IE element */
	}

When the "i + 5 < in_len" match check fails simply because i is
within 5 bytes of the end of the buffer (i.e. no WMM IE was found
near the tail of in_ie), execution falls through to
"i += (in_ie[i + 1] + 2)", which reads in_ie[i + 1]. If i == in_len
- 1 at that point, this is a 1-byte out-of-bounds read of an
attacker-influenced IE buffer built from association/scan data.

Commit a75281626fc8f ("staging: rtl8723bs: fix potential
out-of-bounds read in rtw_restruct_wmm_ie") added the "i + 5 <
in_len" guard to the match condition itself, but did not add an
equivalent guard before the fallthrough advance, so the same class
of OOB read remained reachable through the non-matching path.

Add an explicit bounds check before advancing to the next IE.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260728125456.32359-4-meatuni001@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b124194c291f3..28cdeed06a8e9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2029,6 +2029,9 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
+		if (i + 1 >= in_len)
+			break;
+
 		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
-- 
2.53.0

