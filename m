Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91DF3F825F
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534699; cv=none; b=sDO3yvQneKCBk7ICO8il3BO4oMFpsi/4rnkCrgFmAij/uta8FkiY3MisC7xWVZlzvNrQdHRhsJnCHnvDVHTtz02jMjNNc5TAPLvFC0b4OR5/eICXeVW5QnMc6g35RyGJfUqa1Djrm9AU75ExtpoG2GWaYNCVrg0xgUzbqqvb+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534699; c=relaxed/simple;
	bh=Vi6s8X/q/XzgGdVvh5EXFxftOIgRm/Vs89kDmIoRmlc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qVw41uHzPBMk5WKKCsSRmgCzzl48VoAJPoMNndaDfTeW8au8ir2od7i51pmsq0UE9S0Zef6coDlYmhd+mj/XFadjybFQL8d/oiDSjGxD/agOj3PABFVxnHNkwWUYY2Sni8k3ACh/rte7gTbQo9g3w4XGVqFeGiU1S43qaBX9xJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PY3JGxpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PY3JGxpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27771F000E9;
	Mon, 15 Jun 2026 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534698;
	bh=Ibq6Kay+XkkitxGXn2HgJbTUFZAeYOi24VNjy+jqnq8=;
	h=Subject:To:Cc:From:Date;
	b=PY3JGxpAIyoyZzNP81Az5eaGHe4olJlgLB4FNoRjIkbYfVo6Ri/DKS/1B29gbKh9d
	 ZvzT6HNBk4Bh++Ggo5kH+5KB5ESPTGRPwOSNM3wdKOWojHELsuCfOUgKor0/95zy/8
	 XzqKShHJLmOYdAW+7ku7LU3byVBzWFbGJJAFIXQ4=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: rtw_mlme: add bounds checks before" failed to apply to 5.15-stable tree
To: me@cipherat.com,gregkh@linuxfoundation.org,luka.gejak@linux.dev,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:30:56 +0200
Message-ID: <2026061556-unlovable-moonlight-0cab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 88e994c57a79f62d5338231d8d37ee8dd98baffe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061556-unlovable-moonlight-0cab@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 88e994c57a79f62d5338231d8d37ee8dd98baffe Mon Sep 17 00:00:00 2001
From: Salman Alghamdi <me@cipherat.com>
Date: Wed, 13 May 2026 23:34:40 +0300
Subject: [PATCH] staging: rtl8723bs: rtw_mlme: add bounds checks before
 ie_length subtraction

Add guards to ensure ie_length is large enough before subtracting
fixed IE offsets to prevent unsigned integer underflow.

Fixes: 2038fe84b8bd ("staging: rtl8723bs: fix spacing around operators")
Fixes: d3fcee1b78a5 ("staging: rtl8723bs: fix camel case in struct wlan_bssid_ex")
Closes: https://lore.kernel.org/linux-staging/DI2H39EAAFBZ.3KI5NWN02AQ2S@linux.dev/
Cc: stable <stable@kernel.org>
Signed-off-by: Salman Alghamdi <me@cipherat.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Link: https://patch.msgid.link/20260513203455.31792-1-me@cipherat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 268f294528e6..9f21a2226dbd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -604,6 +604,8 @@ static bool rtw_is_desired_network(struct adapter *adapter, struct wlan_network
 	privacy = pnetwork->network.privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
+		if (pnetwork->network.ie_length < _FIXED_IE_LENGTH_)
+			return false;
 		if (rtw_get_wps_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, pnetwork->network.ie_length - _FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
@@ -617,11 +619,15 @@ static bool rtw_is_desired_network(struct adapter *adapter, struct wlan_network
 			bselected = false;
 
 		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
-			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
-			if (p && ie_len > 0)
-				bselected = true;
-			else
+			if (pnetwork->network.ie_length < _BEACON_IE_OFFSET_) {
 				bselected = false;
+			} else {
+				p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
+				if (p && ie_len > 0)
+					bselected = true;
+				else
+					bselected = false;
+			}
 		}
 	}
 

