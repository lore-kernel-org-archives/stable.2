Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF4435A91
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950822; cv=none; b=nW4bEoGyOoBqbnHYpXiVtUuI+r1Tj+VKuFHyB0ZBI1jBwmj5FX5kYiJO69cUaS5zpOYOx7PjnBQhVaeByC5cs2JdvpbOS6XZ0Ahjdfu60Anhjg9yk0kDYC7yRiR17jpHl4xRY/4ZThqm/iC7Y3Ik41UKk+NEUGwsMAECdi791kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950822; c=relaxed/simple;
	bh=0WF8/hgMrqujIFCDDBemS+PfKXJvvwGMT1vF9Q+x6CU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fuKo6dIxkJ+3nyOE8nCM1QVpj4h62OpEYe2LIx1Saylzw+FQDEONj9MxFTRSyySYSBk2Jb1+E79BqpeLQpNyAJAtU/DnOIZTLfksvqauT/3AP+hS6Vd5y9BhW6WwUq+GzwoyED0wXCw6kF4hrgcQAVWPedXThKr1QHBOQS8aWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kl5l4RVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kl5l4RVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F25C1F000E9;
	Mon, 13 Jul 2026 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950820;
	bh=RQzDMqnQtFr2ZUUwU3h0B3JHBupRyrrIc6LxKcz2G+4=;
	h=Subject:To:Cc:From:Date;
	b=Kl5l4RVz9tU/+Lvg6qTcM9UCjpMljbNyr3+J5Y4XnhiAdL9ODuLb6mK6MYTBPNup2
	 piKQTUGWa1zTT7fXSOZf9MBU36CMRZOssQZ3HvcsA29t4/lnA5dn4ugMIm2ru1DSx5
	 mXi/FgIu1esLDXhoLLgTgB5Su5aPs0tiKcI7FvsQ=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop" failed to apply to 5.10-stable tree
To: hossu.alexandru@gmail.com,gregkh@linuxfoundation.org,luka.gejak@linux.dev,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:46:29 +0200
Message-ID: <2026071329-catering-corncob-309e@gregkh>
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
git cherry-pick -x f9654207e92283e0acac5d64fe5f8835383b5a23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071329-catering-corncob-309e@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f9654207e92283e0acac5d64fe5f8835383b5a23 Mon Sep 17 00:00:00 2001
From: Alexandru Hossu <hossu.alexandru@gmail.com>
Date: Fri, 22 May 2026 02:45:29 +0200
Subject: [PATCH] staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop

The IE parsing loop in OnAssocRsp() advances by (pIE->length + 2) each
iteration but only guards on i < pkt_len. When a malicious AP sends an
AssocResponse whose last IE has only one byte remaining in the frame
(the element_id byte lands at pkt_len-1), the loop reads pIE->length
from pframe[pkt_len], which is one byte past the allocated receive buffer.

Additionally, even when the header bytes are in bounds, pIE->length
itself can extend the data window beyond pkt_len, silently passing a
truncated IE to the handler functions.

Add two guards at the top of the loop body:
  1. Break if fewer than sizeof(*pIE) bytes remain (can't read header).
  2. Break if the IE's declared data extends past pkt_len.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Link: https://patch.msgid.link/20260522004531.1038924-6-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 70e864cd530d..a443b3530fb9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1371,7 +1371,11 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	/* to handle HT, WMM, rate adaptive, update MAC reg */
 	/* for not to handle the synchronous IO in the tasklet */
 	for (i = (6 + WLAN_HDR_A3_LEN); i < pkt_len;) {
+		if (i + sizeof(*pIE) > pkt_len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + i);
+		if (i + sizeof(*pIE) + pIE->length > pkt_len)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:

