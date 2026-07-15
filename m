Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64137106A
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083577; cv=none; b=miW/r0UZYOg3jfQYzyKV7J0Q7I8lelh9iVWyPubTJlzF8jUoTevFNX+tL98e+RtoJHI8qmQf+zbp/hy6pORqXpSrVSX7pHLX5MqJKUJuV/U+6na+IzntFTxPJYIRMZ/ryMVr8bXJLdx8gPkkBh+XJfbIb2FeLZYDxHCKmJKRafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083577; c=relaxed/simple;
	bh=iDEhQojbXbS9UMZAFo/wwONccEu6PtBa17iYsoy6hGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRWsxZZmg6S7VGtVYfXE94FxpaTa3cnU/Z7D85zyEBeBkHDj7oG0npOkhLxnpsmfTLB7hg45/5CzDBZPtvApCJF5r8UgEhYTpnYW4PXdPqjFLbRIW71/DE0YPNYAo1bgR9FVrixUcUkma5qy8ywb8OPVvyFeIM9bJC9Y3XxTDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0q7W2th; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0q7W2th"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767591F000E9;
	Wed, 15 Jul 2026 02:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083576;
	bh=Hh7+Wr/AUjUQAuDkq8Z8ehd/TWfNRZC0aYBYzm4Zxs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0q7W2thgRs0aotsRc+tsuTFMs6z5EDTLR+YbbfP2bEq/9HclIfj0RLrssffppsGN
	 F4MUo3Fvz8TcUK95c1Bh/oUQhvjnrPF92lNWQNB2BbxS+uK+vghScwlABqq4q04ATx
	 Iq+iMoOpBnCI3C2Abb5EH5QEOSsZ6pYkSPz43PktzaH9wgZGx997ai9IkMcD8Xu5mE
	 jXTn7nhRrkIwVg4L6XqxD51KQTFQzAZ1oRl1uxf6LFLvjL0H9oLsBM5GE1EJfSGD71
	 +c5RwHj1ISS0hqYwbs0UrZxg87cQmdamer1n0i1C11STZFjysqetkFYrKO3dN92qcG
	 IOSgL5rFhTwEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 10/10] staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop
Date: Tue, 14 Jul 2026 22:46:06 -0400
Message-ID: <20260715024606.107096-10-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715024606.107096-1-sashal@kernel.org>
References: <2026071347-leotard-finlike-cc76@gregkh>
 <20260715024606.107096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandru Hossu <hossu.alexandru@gmail.com>

[ Upstream commit 3bf39f711ff27c64be8680a8938bcc5001982e81 ]

The loop in is_ap_in_tkip() iterates over IEs without verifying that
enough bytes remain before dereferencing the IE header or its payload:

- pIE->element_id and pIE->length are read without checking that
  i + sizeof(*pIE) <= ie_length, so a truncated IE at the end of the
  buffer causes an OOB read.

- For WLAN_EID_VENDOR_SPECIFIC the code compares pIE->data + 12,
  which requires pIE->length >= 16.  For WLAN_EID_RSN it compares
  pIE->data + 8, requiring pIE->length >= 12.  Neither requirement
  is checked.

Add the missing IE header and payload bounds checks and guard each
data access with an explicit pIE->length minimum, matching the
pattern established in update_beacon_info().

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Link: https://patch.msgid.link/20260522004531.1038924-7-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index aa02881f4efe59..38c9ec26ce2962 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1430,15 +1430,23 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 		for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.IELength;) {
 			pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.IEs + i);
 
+			if (i + 2 > pmlmeinfo->network.IELength)
+				break;
+			if (i + 2 + pIE->length > pmlmeinfo->network.IELength)
+				break;
+
 			switch (pIE->element_id) {
 			case _VENDOR_SPECIFIC_IE_:
-				if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
+				if (pIE->length >= 16 &&
+				    !memcmp(pIE->data, RTW_WPA_OUI, 4) &&
+				    !memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4))
 					return true;
 
 				break;
 
 			case _RSN_IE_2_:
-				if (!memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
+				if (pIE->length >= 12 &&
+				    !memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
 					return true;
 
 			default:
-- 
2.53.0

