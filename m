Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209142DFF3
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950335; cv=none; b=QzmbVPlGFGnartTCGk96n8CttzWr4Lz4cuK+pCEHVoqToypbOYr7PH1sSwKcLqTT/pXni2yEdJI0k9eXx9M1ZZkoMJY1Oxhj97cuKXSNWxI21SxdGswkQdrhyiiu0fDdou2JqVl5W3TYmadBUeiys2d/UFP3DgQKkFi8w1J/iZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950335; c=relaxed/simple;
	bh=yoChBmRTqtmPY34HIxi9sI3rBwNedJGvGxYRLAaeCIQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dYma/mgHk+TlTJrktfFsTK7ng7pJbfI692EEVIf1ejYXpl4ftMlNlOFJUTGpc8C844XFQEW/h3Mu2mdDSSUU7R1PHLOfDoYdcwR9GEt5Wznx+0psZxlo0puvPDDjF822x7eBS3rRdFH6VfWjJ9CfSeY3kg5qOvlUE34Us+H6xX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=skVNruRP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="skVNruRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629681F000E9;
	Mon, 13 Jul 2026 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950333;
	bh=+FR3pAIVwmMRf0YeeEuwVlssUmAK/+7oc2x4y20l8Sg=;
	h=Subject:To:Cc:From:Date;
	b=skVNruRP5DPA6TVemseRfhqQ01yw6dFGNJNEo2OJ58hOXRSP8v2YWNP9FmICfwNc1
	 AvNnijUBelWioUNQEkZRohPRvK5Vzccvb1CclCpntx+ozUdVYpvjmKKrNPVO8Xn2gJ
	 Ofybr3rRKH/ETN+CrTcqIa74/W11vuTzG8TQIByA=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix OOB write in HT_caps_handler()" failed to apply to 5.10-stable tree
To: hossu.alexandru@gmail.com,gregkh@linuxfoundation.org,luka.gejak@linux.dev,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:34:15 +0200
Message-ID: <2026071315-imagines-cytoplasm-6bd4@gregkh>
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
git cherry-pick -x f8001e1a516ba3b495728c65b61f799cbfad6bd0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071315-imagines-cytoplasm-6bd4@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8001e1a516ba3b495728c65b61f799cbfad6bd0 Mon Sep 17 00:00:00 2001
From: Alexandru Hossu <hossu.alexandru@gmail.com>
Date: Fri, 22 May 2026 02:45:28 +0200
Subject: [PATCH] staging: rtl8723bs: fix OOB write in HT_caps_handler()

HT_caps_handler() iterates pIE->length bytes and writes into
HT_caps.u.HT_cap[], which is a fixed 26-byte array (sizeof struct
HT_caps_element). Because pIE->length is a raw u8 from an over-the-air
802.11 AssocResponse frame and is never validated, a malicious AP can
set it up to 255, causing up to 229 bytes of out-of-bounds writes into
adjacent fields of struct mlme_ext_info.

Truncate the iteration count to the size of HT_caps.u.HT_cap using
umin() so that data from a longer-than-expected IE is silently ignored
rather than written out of bounds, preserving interoperability with APs
that pad the element. An early return on oversized IEs was considered
but rejected: it would bypass the pmlmeinfo->HT_caps_enable = 1
assignment that precedes the loop, silently disabling HT mode for APs
that append extra bytes to the HT Capabilities IE.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Link: https://patch.msgid.link/20260522004531.1038924-5-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index b355d8a3ceab..4c0eb93f412e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -909,7 +909,8 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	pmlmeinfo->HT_caps_enable = 1;
 
-	for (i = 0; i < (pIE->length); i++) {
+	for (i = 0; i < umin(pIE->length,
+			     sizeof(pmlmeinfo->HT_caps.u.HT_cap)); i++) {
 		if (i != 2) {
 			/* Commented by Albert 2010/07/12 */
 			/* Got the endian issue here. */

