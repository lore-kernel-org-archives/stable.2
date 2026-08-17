Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608602475E3
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969675; cv=none; b=LTs82CO6fCNwBbWlRewPSm2d29l5JIhMnnGlAGUIWNRECclVJCao8tJY1sfDuf/Z9ODXpYzuhN9127CJdZ+13EQuhb5XUIjX5IrSMO8Dc7pcGkLOWTGf1yfvw5Y4vUGJ0X+qPtol9qJ2SipAUsMSJd1YM1Xlq0jkwgla79I1ZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969675; c=relaxed/simple;
	bh=wUVqf9wIwXz+ZErQcvo35IjBt3TLF/FEGng08wgZEt8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uUkz39N+cUnY0ZvOBrnbL79+8WtF+szocgR78oH/c/OnFjsf0+vrv9ZbhJl4TQJusuTu//aJ+TTl6wQTiENnVVzwliFqWMopPYDJNOqIXSvr4wSpC7sQ2FQ6qfG6qFsRE0jN96MsvE9n4bi57nM7rwb9EHme3g+btV2Ly//HAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H8eLyY1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H8eLyY1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA971F000E9;
	Mon, 17 Aug 2026 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786969661;
	bh=07PQxaCuVk1jW85CArV1iL/OAkEpH0znpPk34LqhyWY=;
	h=Subject:To:Cc:From:Date;
	b=H8eLyY1KA7MnUbII/HRwJTkMlFsqcmbgwabcKrPQOVfZ1Ic1B01J4/BrzYS04nLOi
	 kjyUbCS3EfDFOBxbzWWu7+OO2yxR9Iqfj7E1faOL8dI9u7kf5biSsGQrK9f8LTBIZH
	 KR12tuC8i9NAtXbTFr3AsrHsyzckXuDwDbRA8FY0=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix OOB read in WMM_param_handler()" failed to apply to 5.10-stable tree
To: meatuni001@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:27:37 +0200
Message-ID: <2026081737-disdain-penny-60b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ae21407350151bddfd4fea7aa39bd0643c0ca9d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081737-disdain-penny-60b3@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ae21407350151bddfd4fea7aa39bd0643c0ca9d3 Mon Sep 17 00:00:00 2001
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Sun, 19 Jul 2026 09:15:09 +0500
Subject: [PATCH] staging: rtl8723bs: fix OOB read in WMM_param_handler()

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

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index a4de538722b5..c614c0b4c792 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -666,6 +666,9 @@ int WMM_param_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 		return false;
 	}
 
+	if (pIE->length != WLAN_WMM_LEN)
+		return false;
+
 	if (!memcmp(&(pmlmeinfo->WMM_param), (pIE->data + 6), sizeof(struct WMM_para_element)))
 		return false;
 

