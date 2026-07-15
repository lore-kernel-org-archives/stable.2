Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B513777E
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083554; cv=none; b=axpASOAMMnZzMiwV6MDxwpN2SlzUBd6RA22AUIaCH0DuJ2B1vWjKI1HBDJrRZdW3KD7VzSHYYO7Kaq286gR7JmlLNcAaKL6HDtI19FPqfbQm97qJdzTo5My+Wg0WM+WF1bbeWW6Zoi4ggHCFQlep0V3+kVngHs9UL721Fa5rrZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083554; c=relaxed/simple;
	bh=OisSsJtLn0sRyNfzBRk2+VPrAo651aV5bFlxFX8Yy74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGIy95wfk54QvUzSztHWuQvw692cXicxJ4dMpwsVGJJqvNdyX6y0xCKddoCYZbNlHlMG4DTyyZvmT80ipS36g5VOC/orsgLt9+doOvTm3aMzotYy7id7v0Qu4DGVlMJdRjFUabt+ej8WobsWxrNLo6nnFbtnVunkUv4BFm2DlMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4difj7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4difj7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A781F000E9;
	Wed, 15 Jul 2026 02:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083553;
	bh=wTBUvH6xoGmH1QgeZ5vL6+6hSDNyC4WCsSF2dU2PusY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m4difj7C2HYd6Oi7ZiPYgJaLA0DI5X+uw/dbM0UsAviKSwyq9ZGaZw5LoG6ogoZLM
	 GA8RwqdP/QU0jfFsrl16CspfgMItbhEYsCqTfdimoDRPhrD0ge9DYfsUTvJ8aYyemF
	 efqojBNibJzFqhwxFOy/Y4yNtg9k9eYAWNghrAxcms0reNDLDRoLqpCahymy061SMN
	 QuuyTZM4VQDXUUQkFP+MKokzFx3Piepx9fCLJBUcna9stJCb+YSXG3KPiLfUBKGvnG
	 joZvclSMl16hfxobohHxbmagYVIHCt2YumCs9FwitFnCivrq+kBCADmmYriuE5jm4F
	 vt/LCpHLMkgaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable <stable@kernel.org>,
	Luka Gejak <luka.gejak@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 10/10] staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop
Date: Tue, 14 Jul 2026 22:45:43 -0400
Message-ID: <20260715024543.105642-10-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715024543.105642-1-sashal@kernel.org>
References: <2026071316-urchin-unenvied-752f@gregkh>
 <20260715024543.105642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandru Hossu <hossu.alexandru@gmail.com>

[ Upstream commit ed51de4a86e173c3b0ef78e039c2e49e08b11f16 ]

The IE parsing loop in update_beacon_info() advances by
(pIE->length + 2) each iteration but only guards on i < len.
When a malicious AP sends a Beacon whose last IE has only one byte
remaining in the frame (the element_id byte lands at len-1), the loop
reads pIE->length from one byte past the allocated receive buffer.

Additionally, even when the header bytes are in bounds, pIE->length
itself can extend the data window beyond len, passing a truncated IE
to the handler functions.

Add two guards at the top of the loop body:
  1. Break if fewer than sizeof(*pIE) bytes remain (can't read header).
  2. Break if the IE's declared data extends past len.

Also replace i += (pIE->length + 2) with i += sizeof(*pIE) + pIE->length
for consistency with the sizeof(*pIE) guards added above.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Link: https://patch.msgid.link/20260522004531.1038924-2-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index aa02881f4efe59..7d5fe15379dc83 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1389,7 +1389,11 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 	len = pkt_len - (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN);
 
 	for (i = 0; i < len;) {
+		if (i + sizeof(*pIE) > len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN) + i);
+		if (i + sizeof(*pIE) + pIE->length > len)
+			break;
 
 		switch (pIE->element_id) {
 		case _VENDOR_SPECIFIC_IE_:
@@ -1414,7 +1418,7 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 			break;
 		}
 
-		i += (pIE->length + 2);
+		i += sizeof(*pIE) + pIE->length;
 	}
 }
 
-- 
2.53.0

