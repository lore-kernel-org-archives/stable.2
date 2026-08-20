Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA934779BE
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240103; cv=none; b=hc91k9pDU1Cq/0LjYtuXNljBkMsQ7MlWmXKMR4QacmKZ0ZtE0vm74PUcUjWPEH+aeHuME8M1+7KGr9HDYMiwsnH1UPf622cMjJLZKxTQuS4jddhS4OmdMfy4dbr/NJGvljhGuji/Hys4ZNRwH7+m2SYrHQr8Amjt/YvpP04KW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240103; c=relaxed/simple;
	bh=cf3tMQIhx/b1Pl0pzzCsHZlzq+YyI5MoC8tLP/a2PiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQpHZj8XzXiypQ0B4xyl5tvYc3Xa4CWdxSSYObaUErsPVbBh7mNG0IM1zicWnzYSwCADSsBV0jvdhXCwUBzMrsT/dTpdPbksZbjX9o5nikMsYfh3IQc0J+WQdlCJviha9S/JE3WOK/7q0kAs70OJZRDb7ZRxcagu/pGICHPmlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6GVG2fs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6GVG2fs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0895D1F000E9;
	Thu, 20 Aug 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787240101;
	bh=1cVoI2GgFv82FW5KVKpfozY230gtIfgBHQB0o/IudEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6GVG2fss0/jPQzFo+7w7T3WVVBWcmmPpXsp8lyaAe0c+WJJCmfNI98ogujQfbloS
	 3dHnJ9g6KNWAGj+pRhAOnn0TNiQ02/4OQhTi+7fkQbpy6JH53t106CO2RvQUOQOEhe
	 0MBK4P+0qnDe2dCUbSrfoEIif/6SAugHjd7QuBGk7YeWorNBC534ouF8r4DaPuCPZv
	 vFxjmJCYe07KqMSE5jUoYEtakickgOrVxP6hzEO0BmErvwtJlkdk69nk9aSyMzZqoC
	 Pw+wD2yuntsfvzZYmEcKC5m48oB+1hbcIDO6w9zEo+HfD9Oop0r1wDR60IzHdAtT6C
	 M9nb1w0GdyAww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] staging: rtl8723bs: fix OOB read in WMM_param_handler()
Date: Thu, 20 Aug 2026 11:34:59 -0400
Message-ID: <20260820153459.2079857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081737-disdain-penny-60b3@gregkh>
References: <2026081737-disdain-penny-60b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Bilal <meatuni001@gmail.com>

[ Upstream commit ae21407350151bddfd4fea7aa39bd0643c0ca9d3 ]

WMM_param_handler() copies a fixed-size WMM parameter element out of a
received information element without checking that the element is long
enough, causing an out-of-bounds read for a short WMM IE.

The handler reads sizeof(struct WMM_para_element) (18) bytes at
pIE->data + 6, so it requires pIE->length to be at least 24
(WLAN_WMM_LEN), but it never validates the length. Two of its three
callers reach it after matching only the WMM OUI: OnAssocRsp() in
rtw_mlme_ext.c matches a 6-byte OUI, and join_cmd_hdl() matches a
4-byte OUI, before calling the handler. A vendor-specific IE carrying
the WMM OUI but a length between 6 and 23, placed in an association
response or in the IE blob handed to join_cmd_hdl(), passes the OUI
check and then makes the memcmp() and memcpy() at pIE->data + 6 read
past the end of the element. OnAssocRsp() parses a frame received from
the AP, so this is reachable from a remote peer.

The remaining caller in rtw_wlan_util.c already guards the handler with
"pIE->length == WLAN_WMM_LEN". Move the equivalent check into the
handler itself so every caller is covered; the sibling IE handlers in
the same parsing loop (HT_caps_handler(), HT_info_handler(),
ERP_IE_handler()) likewise bound their accesses by pIE->length.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260719041509.97894-1-meatuni001@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ changed `pIE->length` to `pIE->Length` due to pre-5.15 CamelCase field name in `struct ndis_80211_var_ie` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 7db28f5853809..4881adf930ab2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -771,6 +771,9 @@ int WMM_param_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 		return false;
 	}
 
+	if (pIE->Length != WLAN_WMM_LEN)
+		return false;
+
 	if (!memcmp(&(pmlmeinfo->WMM_param), (pIE->data + 6), sizeof(struct WMM_para_element)))
 		return false;
 	else
-- 
2.53.0

