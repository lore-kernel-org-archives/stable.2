Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7F037DEAD
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072056; cv=none; b=Uz7I4cZIjJY3U8oJ4Wip88oMBNU4x8tBtAWWrfkvlIVfWPKk54j3LUldnJE6Wi12MlvlR6lfBEnZ5I2UvIjx8gH6qR3liIFPv2c3zXEiacMaYwso3k0cUxXjauYCJdwunVfsO/NnivXgP/2Ekn+76OyOGc7GtK/Fyix4+My4/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072056; c=relaxed/simple;
	bh=YNY4laQhFPdmoep5u5b3CL6soZzImyFEgpfN8KAnLRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UF7k0ioplY79XyKHsZO9f5M08mDZ0tffOkGE5pXxeOzb7wIZYy3johl2D9Zks8roGllXAhYFDgMtHTHn5paG99ECWmZUe+JoRk8qwVCTV4c6YI6nbH2HVOUUhJTHLAFgIExurZU+DI+ENzW0iqDcCQBrC/pJqojuc45OX1se9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPEaEVHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPEaEVHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D821F00A3A;
	Tue, 14 Jul 2026 23:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072054;
	bh=fb1m/c1lCsqUBsAl5AycAF6WxL7U1WsQ/MfwXT3mlFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WPEaEVHzEPHY6WpUOG47Iau4HKM+4C+1HSivJKqK2JbTP2sRXQ79t+vBq7q7ojvMc
	 2/MWmXk0jcnYwYEnW7L6QR4864tgOkTFeOBH4CZsQTf4AFC+DCCTmmRURepcx2S0Rb
	 SyX9y6zhyS604lFeJjT2yNLxvOUeuojL9t+PlnfNCkNKzrF5gmG8qAdmeqjm81GGTK
	 PJOJq9mNaMFbeFETG8/HKiZufvzZ0Pg2hIG8RCQGZShqVOuxg8ZreHshm31bwoJex/
	 eIRCRuy4a0Uy7Kdm3LXXSJgH89gZwV3UcjtqSqAq1ax3iIITod+TL6n/QTnu5z/U+w
	 vKgvP5Q2/HCKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 8/8] staging: rtl8723bs: fix WEP length underflow and OOB read in OnAuth()
Date: Tue, 14 Jul 2026 19:34:07 -0400
Message-ID: <20260714233407.3591885-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714233407.3591885-1-sashal@kernel.org>
References: <2026071352-wreckage-humorless-3481@gregkh>
 <20260714233407.3591885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandru Hossu <hossu.alexandru@gmail.com>

[ Upstream commit a1fc19d61f661d47204f095b593de507884849f7 ]

OnAuth() has two bugs in the shared-key authentication path.

When the Privacy bit is set, rtw_wep_decrypt() is called without
verifying that the frame is long enough to contain a valid WEP IV and
ICV.  Inside rtw_wep_decrypt(), length is computed as:

    length = len - WLAN_HDR_A3_LEN - iv_len

and then passed as (length - 4) to crc32_le().  If len is less than
WLAN_HDR_A3_LEN + iv_len + icv_len (32 bytes), length - 4 is negative
and, after the implicit cast to size_t, causes crc32_le() to read far
beyond the frame buffer.  Add a minimum length check before accessing
the IV field and calling the decryption path.

When processing a seq=3 response, rtw_get_ie() stores the Challenge
Text IE length in ie_len, but the subsequent memcmp() always reads 128
bytes regardless of ie_len.  IEEE 802.11 mandates a challenge text of
exactly 128 bytes; reject any IE whose length field differs, matching
the check already applied to OnAuthClient().

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Link: https://patch.msgid.link/20260522004605.1039209-1-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index bd32f60152ab0b..4b1f88570d0682 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -886,6 +886,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 
 	DBG_871X("+OnAuth\n");
 
+	if (len < WLAN_HDR_A3_LEN)
+		return _FAIL;
+
 	sa = GetAddr2Ptr(pframe);
 
 	auth_mode = psecuritypriv->dot11AuthAlgrthm;
@@ -897,6 +900,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 		prxattrib->hdrlen = WLAN_HDR_A3_LEN;
 		prxattrib->encrypt = _WEP40_;
 
+		if (len < WLAN_HDR_A3_LEN + 8)
+			return _FAIL;
+
 		iv = pframe+prxattrib->hdrlen;
 		prxattrib->key_index = ((iv[3]>>6)&0x3);
 
@@ -1014,7 +1020,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
-			if (!p || ie_len <= 0) {
+			if (!p || ie_len != 128) {
 				DBG_871X("auth rejected because challenge failure!(1)\n");
 				status = _STATS_CHALLENGE_FAIL_;
 				goto auth_fail;
-- 
2.53.0

