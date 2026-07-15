Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34642BC44
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074650; cv=none; b=cKpPFke+tshFkc2B4DCfaN1aVGRPggCuuZw9hDZHO5bDXbhhaLSRi7n6JraJf+3HmUiYGB67j3MkP+6fjjOSop0ZUqS+zPW8xoLGhRq1VMmBiQ67i1yCivX5WO20Y0y9w2la4xT/ciS+7X4Elh+egiFtEiFWMDCTOkMCARv8MU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074650; c=relaxed/simple;
	bh=KSvrivpBarYWWxoSjyA70K/dwgHoK/ygnuSj/v3EwwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN+QVWempZgLg50c685b07PAPsXFoDcpdwrnFFwX84QqOyokS6ImcLQUzlEAp1x57aH43pT0Ycs0zyrfOjP4rIYfXqnvd+QESfARiyRtxH6ivqVUIm4xbwO/+GfKcrOZcaIMWwlDiJOVIC3cCCdBMTaehUZrQXhRSKWiID15d4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrjB6bDb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrjB6bDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052981F000E9;
	Wed, 15 Jul 2026 00:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074648;
	bh=pkSEGisrVkbXpogFgin9Ccui3P8zxwklx7x64YrxBB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PrjB6bDb5/X7HwRJzuiMFz2D5y9xhvEjTxlRiuUIpg9inGaGZTWFuvErjzjr3C7y8
	 UKNCoI79t1Vseb8qSKbmCgqw9evyNqAixe8RjIcDP3zGQHZz8hDIgq6Hapfjp1qrWh
	 6u2U2VxRnsE/Ro/GkFoyT5dKY9C/xxOtTy1p0W6YVHGGHbooNJLdiqH2Ip0OWfwLxx
	 FSi2SBT49aD2Zi/yoNYiNomJt2uMch/HwWH7QSod6ONqdEwsEh7lcQUhX0dHxZPV2I
	 aqVAnCZHRLNJlJmR6OK1m9x4yDQbCQdgNZZXIeY/fSFN2YZmSI0M/JDmyDSCLVV0nb
	 wz1/fosnt8JeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable <stable@kernel.org>,
	Luka Gejak <luka.gejak@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and join_cmd_hdl()
Date: Tue, 14 Jul 2026 20:17:26 -0400
Message-ID: <20260715001726.3782263-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071333-pacify-morbidly-5ced@gregkh>
References: <2026071333-pacify-morbidly-5ced@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandru Hossu <hossu.alexandru@gmail.com>

[ Upstream commit ef61d628dfad38fead1fd2e08979ae9126d011d5 ]

Two IE parsing loops are missing the header bounds checks before they
dereference pIE->length:

 - issue_assocreq() walks pmlmeinfo->network.ies to build the
   association request. If the stored IE data ends with only an
   element_id byte and no length byte, pIE->length is read one byte
   past the end of the buffer.

 - join_cmd_hdl() walks pnetwork->ies during station join and has
   the same problem under the same conditions.

Both buffers are filled from AP beacon and probe-response frames, so a
malicious AP that sends a truncated final IE can trigger the issue.

Apply the two-guard pattern established in update_beacon_info():
  1. Break if fewer than sizeof(*pIE) bytes remain.
  2. Break if the IE's declared data extends past the buffer end.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Link: https://patch.msgid.link/20260522004531.1038924-3-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ replaced sizeof(*pIE) with literal 2 (5.10's ndis_80211_var_ie still has data[1]) and used pre-rename field names IELength/IEs/ElementID/Length ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 1144749b4f585d..1fd47d6155e77a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3352,7 +3352,11 @@ void issue_assocreq(struct adapter *padapter)
 
 	/* vendor specific IE, such as WPA, WMM, WPS */
 	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.IELength;) {
+		if (i + 2 > pmlmeinfo->network.IELength)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.IEs + i);
+		if (i + 2 + pIE->Length > pmlmeinfo->network.IELength)
+			break;
 
 		switch (pIE->ElementID) {
 		case _VENDOR_SPECIFIC_IE_:
@@ -6175,7 +6179,11 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 	/* sizeof(struct ndis_802_11_fix_ie) */
 	for (i = _FIXED_IE_LENGTH_; i < pnetwork->IELength;) {
+		if (i + 2 > pnetwork->IELength)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pnetwork->IEs + i);
+		if (i + 2 + pIE->Length > pnetwork->IELength)
+			break;
 
 		switch (pIE->ElementID) {
 		case _VENDOR_SPECIFIC_IE_:/* Get WMM IE. */
-- 
2.53.0

