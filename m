Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6C42EED8
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950312; cv=none; b=rKy9avprSsb8T9S3nmxbI7AHu2P3v2LohXEfWuKzEQRaCi/tAAc9FvoBPDa+LMpltPIrFvEEjCArukDw6wcsLQD37Kr+SdMcI3RmWKKSk2I/xKPKpC6A5pXoA5LgGVySz/nC8jrsilu1TKmPx2oX5VBUlpxjX21QKTtGN1KIIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950312; c=relaxed/simple;
	bh=KDKvhbAk2Ugvzr1arlo3ZMiU2lh6oKw+/z4XfSLFZ5w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kitvFSPTYow/7gryhDyX6QZ301CyK+ckxBmlEncuacWcKhfFsLu5SL1BjHKANdtzQj1j82ciXBegorDFNLyE3vrre9kjU/rdNYMkdavWo2/IC3ingCSDJEO2nqKxfgNUbXA7+/cw8PHRpSlwpri9zWcCb04q4wRy3w9fLcNNTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LOMZNaCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LOMZNaCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1E21F000E9;
	Mon, 13 Jul 2026 13:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950310;
	bh=1juTBW49maZFa3pFdUQuAxyB/dwOsMl3j4Uj0gD1QvY=;
	h=Subject:To:Cc:From:Date;
	b=LOMZNaCVe0D7bw3mHLlQX5Mxe8ffRGYqT7H2o5uutYkSwSqDrsAEWGdMTTD/bB11Z
	 Fan1V/WyjLSJm1v341lrS7ta8DRRuFhRK7kTXjtThygsJZxai0oZaqAOF61uEJJ5s7
	 m7pX6Ni9hRIe3eSe1pcMJmF8wuXoBvEEar1T7KoM=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix OOB read in update_beacon_info() IE" failed to apply to 5.10-stable tree
To: hossu.alexandru@gmail.com,gregkh@linuxfoundation.org,luka.gejak@linux.dev,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:33:16 +0200
Message-ID: <2026071316-urchin-unenvied-752f@gregkh>
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
git cherry-pick -x ed51de4a86e173c3b0ef78e039c2e49e08b11f16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071316-urchin-unenvied-752f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed51de4a86e173c3b0ef78e039c2e49e08b11f16 Mon Sep 17 00:00:00 2001
From: Alexandru Hossu <hossu.alexandru@gmail.com>
Date: Fri, 22 May 2026 02:45:25 +0200
Subject: [PATCH] staging: rtl8723bs: fix OOB read in update_beacon_info() IE
 loop

The IE parsing loop in update_beacon_info() advances by
(pIE->length + 2) each iteration but only guards on i < len.
When a malicious AP sends a Beacon whose last IE has only one byte
remaining in the frame (the element_id byte lands at len-1), the loop
reads pIE->length from one byte past the allocated receive buffer.

Additionally, even when the header bytes are in bounds, pIE->length
itself can extend the data window beyond len, passing a truncated IE
to the handler functions.

Add two guards at the top of the loop body:
  1. Break if fewer than sizeof(*pIE) bytes remain (can't read header).
  2. Break if the IE's declared data extends past len.

Also replace i += (pIE->length + 2) with i += sizeof(*pIE) + pIE->length
for consistency with the sizeof(*pIE) guards added above.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Link: https://patch.msgid.link/20260522004531.1038924-2-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 1d37c2d5b10d..b355d8a3ceab 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1262,7 +1262,11 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 	len = pkt_len - (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN);
 
 	for (i = 0; i < len;) {
+		if (i + sizeof(*pIE) > len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN) + i);
+		if (i + sizeof(*pIE) + pIE->length > len)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
@@ -1287,7 +1291,7 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 			break;
 		}
 
-		i += (pIE->length + 2);
+		i += sizeof(*pIE) + pIE->length;
 	}
 }
 

