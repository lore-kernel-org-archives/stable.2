Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE571714AA
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079254; cv=none; b=pUG2z+F/xyCOLt8EYm/FYPckbECX6pxpPbKp5Lmr2ZaS5LleLK/E5tNfLy2hBeINaLjFpjFFDjIJhnRXN+aEt2bVx//ocSD0F7QXiVgn7nvDB5qtFi3LSVxAFSnpC/AjfI+NMpUboAKWJG+yRrpvuMPjwT0s4E/TtMNkmPPD1wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079254; c=relaxed/simple;
	bh=LSzP9Vw5mx3+vEfP0TG1ehGXDMf0/0RzsiB3HwUoA0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdEmGWqUQ9dgzk672Lbirb4KGCpHHOorFfthyZY5By+ycwNO4NTSeVfbysZDVc9zTwssNdung840q0teB7jS4laxw7v12Gd7xlB6+rCLQrjKuk28fmMB3Nv+s3n3a0+xLsBwNTPYVjGdV1kRuBgd8VUEHqm62/YFiQijG7khHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/sGxYMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/sGxYMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C518D1F00A3E;
	Wed, 15 Jul 2026 01:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079253;
	bh=RKR4qgIMRUkZ74CmtyczQxeDiYGrnVFP9k4uS4W7BlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/sGxYMnFOVTv+i24BJu8FsmNeqOYF1hQrPA25Rk2q6RVzObO+dlByIJ99A4TpNXA
	 BhppLoeGZcEQORkCgYSO5vWBbrlrdvtOHHAxZYaPKMHiwfoRlKEzPn2UivOMZzDUXc
	 KKvRv+S9gq75hWVbmVUUZAwnw53xUcNsb8Ezx37HyyZQs3wIGRMMuSXfdjUgfMBlvn
	 oBcyfZohWtO7qkkyNRpeMf4euHoIjJFP7P62F7al97CQZzUhs6NzH2x7Zydh8C3UyV
	 oFR0LoVtRND+XjUPaRIljIhvqpgmELx6cvG5/iNVq8+sGSEiU+LE7zvSYpRfbKBELK
	 G9Xl65CzitmJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()
Date: Tue, 14 Jul 2026 21:34:08 -0400
Message-ID: <20260715013408.4110029-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715013408.4110029-1-sashal@kernel.org>
References: <2026071359-gecko-previous-ef42@gregkh>
 <20260715013408.4110029-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandru Hossu <hossu.alexandru@gmail.com>

[ Upstream commit 1463ca3ec6601cbb097d8d87dbf5dcf1cb86a344 ]

Three IE/attribute parsing functions have missing bounds checks.

rtw_get_sec_ie() and rtw_get_wapi_ie() iterate over a raw IE buffer
without verifying that the header bytes (tag + length) are within the
remaining buffer before reading them.  Additionally, rtw_get_sec_ie()
compares the 4-byte WPA OUI at cnt+2 without checking that at least
6 bytes remain, and rtw_get_wapi_ie() compares a 4-byte WAPI OUI at
cnt+6 without checking that at least 10 bytes remain.

rtw_get_wps_attr() reads wps_ie[0] and wps_ie+2 unconditionally at
entry, before verifying that wps_ielen is large enough to contain
the 6-byte WPS IE header (element_id + length + 4-byte OUI).  Inside
the attribute loop, get_unaligned_be16() is called on attr_ptr and
attr_ptr+2 without checking that 4 bytes remain in the buffer.

Add a cnt+2 bounds check before each loop body in rtw_get_sec_ie()
and rtw_get_wapi_ie(), guard each multi-byte comparison with a minimum
IE length requirement, add a wps_ielen < 6 early return in
rtw_get_wps_attr(), and add a 4-byte bounds check in its inner loop.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Link: https://patch.msgid.link/20260522004531.1038924-8-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 053adf376d44b0..18c0a6bc8049ad 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -583,9 +583,14 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
 	while (cnt < in_len) {
+		if (cnt + 2 > in_len)
+			break;
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
 		authmode = in_ie[cnt];
 
 		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY &&
+		    in_ie[cnt + 1] >= 8 &&
 		    (!memcmp(&in_ie[cnt + 6], wapi_oui1, 4) ||
 		     !memcmp(&in_ie[cnt + 6], wapi_oui2, 4))) {
 			if (wapi_ie)
@@ -618,9 +623,14 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
 	while (cnt < in_len) {
+		if (cnt + 2 > in_len)
+			break;
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
 		authmode = in_ie[cnt];
 
 		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) &&
+		    in_ie[cnt + 1] >= 4 &&
 		    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
 			if (wpa_ie)
 				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
@@ -722,6 +732,9 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 	if (len_attr)
 		*len_attr = 0;
 
+	if (wps_ielen < 6)
+		return attr_ptr;
+
 	if ((wps_ie[0] != WLAN_EID_VENDOR_SPECIFIC) ||
 		(memcmp(wps_ie + 2, wps_oui, 4))) {
 		return attr_ptr;
@@ -732,6 +745,8 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 
 	while (attr_ptr - wps_ie < wps_ielen) {
 		/*  4 = 2(Attribute ID) + 2(Length) */
+		if (attr_ptr + 4 > wps_ie + wps_ielen)
+			break;
 		u16 attr_id = get_unaligned_be16(attr_ptr);
 		u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
 		u16 attr_len = attr_data_len + 4;
-- 
2.53.0

