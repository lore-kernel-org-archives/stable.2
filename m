Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D23859F7
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950300; cv=none; b=CJn5gnV68Dw1eepcgkuAaz6DxKk7kvjuzDcfJAjlMQjnQBCs1cXuFgYZQlPuCVOrjg9PMVjXeHwDTqOArBaw6AJLSo6Kej0aCdNLDq0h+nxAnQG6361CxTwXuKXHSBWcc8yZwgFTOaQsDqF3hSDhgESgjQ/6XHkClhjcBmUklKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950300; c=relaxed/simple;
	bh=53utSgjXwuW76fPPcbr5zJFm3FaxyiUul0RIhfdWteo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W00q7COt5A8gIi7+ePSJgEo/zSCSdcFLOmoQFwmpoQlpCQDcD3260it8HgqliYuRyTVg8rQtZGJiYV8o/60azzQV9IEqBYbMXSax2Dlbu52zzb5br0XZWPBw/U3pLmN9WGsg7MgfXrvDVWlW0gI+yNQJ9oDso3TW9ZKzhQn9VX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mjl1D9k/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mjl1D9k/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292CB1F000E9;
	Mon, 13 Jul 2026 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950299;
	bh=e8wdQ0nb/hVgwFKjyCFrXwXM5d9VQP+VJI0OavqbIyI=;
	h=Subject:To:Cc:From:Date;
	b=Mjl1D9k/qsvVc+Pj51K2BxUXbW6oZaaqawGFHYJCsfxA7HSP/Ua3SBqyhRNCYlCvq
	 7Ye3vNeWvzuBpng8SXgN/dHenRO9G0j2O6mHv6n10qDGwl7V0Ky4VJHpYg+Q8OAjS6
	 g2mCfwVLhnoDV72pszvEz492200QY/0Ek7WyBnXQ=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix heap buffer overflow in" failed to apply to 5.15-stable tree
To: hossu.alexandru@gmail.com,gregkh@linuxfoundation.org,luka.gejak@linux.dev,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:32:35 +0200
Message-ID: <2026071335-spindle-refutable-39c3@gregkh>
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
git cherry-pick -x 5a752a616e756844388a1a45404db9fc29fec655
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071335-spindle-refutable-39c3@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a752a616e756844388a1a45404db9fc29fec655 Mon Sep 17 00:00:00 2001
From: Alexandru Hossu <hossu.alexandru@gmail.com>
Date: Fri, 22 May 2026 02:45:27 +0200
Subject: [PATCH] staging: rtl8723bs: fix heap buffer overflow in
 rtw_cfg80211_set_wpa_ie()

supplicant_ie is a 256-byte array in struct security_priv. The WPA and
WPA2 IE copy paths use:

    memcpy(padapter->securitypriv.supplicant_ie, &pwpa[0], wpa_ielen + 2);

where wpa_ielen is the raw IE length field (u8, 0-255). When a local user
supplies a connect request via nl80211 with a crafted WPA IE of length 255,
wpa_ielen + 2 equals 257, overflowing the 256-byte buffer by one byte into
the adjacent last_mic_err_time field.

rtw_parse_wpa_ie() does not prevent this: its length consistency check
compares *(wpa_ie+1) against (u8)(wpa_ie_len-2), which is (u8)(255) == 255
when wpa_ie_len = 257, so the check passes silently.

Add explicit bounds checks for both the WPA and WPA2 paths before the
memcpy, rejecting any IE whose total size (wpa_ielen + 2) exceeds the
supplicant_ie buffer.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Link: https://patch.msgid.link/20260522004531.1038924-4-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 1484336d7551..6a97afd89dc7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1446,6 +1446,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa = rtw_get_wpa_ie(buf, &wpa_ielen, ielen);
 	if (pwpa && wpa_ielen > 0) {
+		if (wpa_ielen + 2 > sizeof(padapter->securitypriv.supplicant_ie)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		if (rtw_parse_wpa_ie(pwpa, wpa_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
@@ -1455,6 +1459,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa2 = rtw_get_wpa2_ie(buf, &wpa2_ielen, ielen);
 	if (pwpa2 && wpa2_ielen > 0) {
+		if (wpa2_ielen + 2 > sizeof(padapter->securitypriv.supplicant_ie)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		if (rtw_parse_wpa2_ie(pwpa2, wpa2_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK;

