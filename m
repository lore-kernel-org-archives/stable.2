Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1152338F253
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330486; cv=none; b=INQeVxS4aBmsOilSKt9KsUftewB0/vN3avjYokphj+TcfgUsugZqSpEmUoxyatK4suyWWO2R86LpRvWYtdJ+cRIQqB98OB7dcF2Qyhv4D/CZz34NT46i2m8Du99fPZn1iu/rRws1QYqLv/Ch18N28DMVbJV7JLxoKFelS3Heeb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330486; c=relaxed/simple;
	bh=wO1uBOk3qLdcxrnBEwR7ZE9FkWyOFTxr0CXENG+Ndpo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BaL53NMSj4ac3nDnCC1Mi8NqDBfu138eTGI1Kq66tyqwZiwry426up4XpaLeT50xMdx8QkwEahZHqteGP8lFgChtUQyXrKDRfHgLE2wthoMFk1uIeXjDcJOkcO2APIngghx5YO++Fs+iyGL8WdP/Ky0J4xoTiXt9SEah+Wy49g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FZwutvxz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FZwutvxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD0D1F000E9;
	Wed, 29 Jul 2026 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330484;
	bh=Zz+JUrv+9CgP0LRP58dOkjO9SqoZuMnwQrfo5qsEUHg=;
	h=Subject:To:Cc:From:Date;
	b=FZwutvxzneoU8KXYiPS9s0+KJkgY+CmbPBqkisafa2B0ldbZnTxH7PP4pVpxdP6Wd
	 kD9MEgRFpmDmbCp2Fk6ps7+8HdQEx3xvkF5EVqYqoQRar+PeT0xrUz01ehuOWWKx9a
	 xw/PP1YJKKF/OeJWwDF1poivcnbTX8lKJ6vhHj3M=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()" failed to apply to 5.10-stable tree
To: mokshpanicker.7@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:07:51 +0200
Message-ID: <2026072951-bonding-juvenile-6ea0@gregkh>
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
git cherry-pick -x 0e95ff792ae0aa6fbad9455943e9e1e4062670e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072951-bonding-juvenile-6ea0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e95ff792ae0aa6fbad9455943e9e1e4062670e9 Mon Sep 17 00:00:00 2001
From: Moksh Panicker <mokshpanicker.7@gmail.com>
Date: Thu, 25 Jun 2026 20:29:11 +0000
Subject: [PATCH] staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()

rtw_get_wps_ie() iterates over IE data from network frames without
validating that the IE header and payload fit within the remaining
buffer before reading them. Specifically:

- in_ie[cnt + 1] is read without checking cnt + 1 < in_len
- memcmp(&in_ie[cnt + 2], ...) accesses cnt + 2 without bounds check
- in_ie[cnt + 1] is used as length without verifying payload fits

Add bounds checks at the top of the loop body to break early if fewer
than 2 bytes remain for the IE header, or if the declared payload
extends past the end of the buffer. Also require at least 4 bytes of
payload before comparing the WPS OUI.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
Link: https://patch.msgid.link/20260625202911.26782-1-mokshpanicker.7@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 54f805a6b5ce..863ddf846218 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -670,7 +670,14 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 	while (cnt < in_len) {
 		eid = in_ie[cnt];
 
-		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
+		if (cnt + 2 > in_len)
+			break;
+
+		if (in_ie[cnt + 1] + 2 > in_len - cnt)
+			break;
+
+		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (in_ie[cnt + 1] >= 4) &&
+		    (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
 			wpsie_ptr = &in_ie[cnt];
 
 			if (wps_ie)

