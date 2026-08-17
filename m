Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCAA2652B2
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969593; cv=none; b=BZ05IDHPOo8WUw1zPoTeu5Xk90y8u+lrl5sHg0agv+9KH7gSpaJLY3N7gPbiiQ8lhi4TsOyNhCJ+W8j+hLpr8HUqVnclN4xijeZnoVQZEH+aJgIWXd58sfQrxS50hPO/UjPDfo03c5W4gv7UvPseWMqv/Dr553gLCTJ3YQwBBhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969593; c=relaxed/simple;
	bh=NQDVs+fbZvXuCYF1XfX4ftzfgbmsc1kv6Jr6kP5NlHo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U9wtuVApLt0xhIQxLBIjP3GQeRJD3x+LVK7sqbWLR1EsjB/w0/6KCcOFE2m1A6rnHLxI8Oxnd2j8HqqMvSlJOx7ff0Mm3wpNK5PUTBsn+m3FxW1mWTJrmkl5JciUW0PQlMqfBD2Nh5NJP/0M4hNyH0AQUARdm/BWs/j3SGZi4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D204Vt4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D204Vt4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223FE1F000E9;
	Mon, 17 Aug 2026 12:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786969592;
	bh=ATGOeRZd/w4KA6XqbwfVYREL6mSPdoLo1rUe8tOfE1g=;
	h=Subject:To:Cc:From:Date;
	b=D204Vt4EG7yhBTTonYLofpmhd/kKEq3xNsVG8gDMHB5fX2lOiLnyHPktM73SylLQG
	 5Z9kwJTqRTcCc/egnp9jWsEJ1Pz7PED/proW1JNJwzp4FMStVEmVEIWnAj3sbx+r5D
	 2rXpLBy9Zvq0OSUCcEykAUMiY/lbCluVxZGczpqc=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix missing shared-key auth challenge" failed to apply to 5.10-stable tree
To: npetrakopoulos2003@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:26:27 +0200
Message-ID: <2026081727-aroma-surging-c7f8@gregkh>
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
git cherry-pick -x 2c56ef658ac8c6bca36bc5574715e8f717207c6c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081727-aroma-surging-c7f8@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c56ef658ac8c6bca36bc5574715e8f717207c6c Mon Sep 17 00:00:00 2001
From: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
Date: Mon, 20 Jul 2026 11:24:09 +0300
Subject: [PATCH] staging: rtl8723bs: fix missing shared-key auth challenge
 length check

The WEP shared-key authentication handler uses the challenge-text
element's attacker-controlled length without checking it against the
fixed 128-byte chg_txt buffer.

In OnAuthClient() the length from rtw_get_ie() - up to 255 - is used
to perform memcpy() into the 128-byte pmlmeinfo->chg_txt, so a
malicious AP sending a malformed WLAN_EID_CHALLENGE element can
overflow/underfill chg_txt by up to 127 bytes. It is reachable over the
air, before association, during shared-key authentication. In the case
of an overflow, the driver can write out of bounds. In the case of an
underfill, the driver can echo stale buffer memory.

The challenge text is defined to be exactly 128 octets, which is
already provided as the WLAN_AUTH_CHALLENGE_LEN define; require the
element to be exactly that length before use.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
Link: https://patch.msgid.link/20260720082409.168379-1-npetrakopoulos2003@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a443b3530fb9..a9382dc1294b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -879,7 +879,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (!p)
+			if (!p || len != WLAN_AUTH_CHALLENGE_LEN)
 				goto authclnt_fail;
 
 			memcpy(pmlmeinfo->chg_txt, p + 2, len);

