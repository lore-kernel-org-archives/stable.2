Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BEC3F0AB8
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534658; cv=none; b=kd9C8LXbrNJ20/RRjDKqnHoleBxAmY2MxuGZTsnsgyYJfMETzxB9zv4mZ+qiAWtsIuPyhHYhu3Bo1xWkVKU8Vs+ptcG9hibqrnYDTiBEO4rmrbDKXDTjr1XhLEGXuOwiEDAlWKdD0mDj6VL3jz4n8iCsWl2oCtiC3g2nq7KtxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534658; c=relaxed/simple;
	bh=RB6aHeL5g7P7Zs3omZW7th++8s5jiBwaoaL2UcXtTCQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kXxjjIhl34OifFwG4rHk7Fbu6GBxX+zRDkNOHY5QjDNOCjKY87gciwFJMYIE6ThVe4DlZIDQd2YGwMc0ugfNSu/zHWruXsjazLbLt0y/3TWKRvc3y9ipUEI1QbQkXDjTVuWhvZ1SbK/lVhxymCEkYG3CazNHv91j5u6GsXSsYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jcP8822I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jcP8822I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1803C1F000E9;
	Mon, 15 Jun 2026 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534656;
	bh=DCPxMquLcP4QsjlV4k6RvJU23kf2G7iVJ5exB9c9gyM=;
	h=Subject:To:Cc:From:Date;
	b=jcP8822I1e2oCcxCx+HZY9RWlfMNYuvWSW6XxKam9mdD4w0Sg3tU05B/qzK7RYwrz
	 AAanO8f3+X0fZ3MPtqx6o4G4RvF2/Kp7g2vDRxHSADgZJqyybZ0WSh2YN+QFQ9kqkK
	 qWoO7N6mrzk/6Jzx2wD17idt5ufmv5pvPJVrfLPc=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix buffer over-read in" failed to apply to 5.15-stable tree
To: me@cipherat.com,gregkh@linuxfoundation.org,luka.gejak@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:30:23 +0200
Message-ID: <2026061523-neutron-hazily-f98d@gregkh>
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
git cherry-pick -x 514ab98364595007d4557ecc85d7e5f012c504d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061523-neutron-hazily-f98d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 514ab98364595007d4557ecc85d7e5f012c504d3 Mon Sep 17 00:00:00 2001
From: Salman Alghamdi <me@cipherat.com>
Date: Sat, 9 May 2026 01:26:14 +0300
Subject: [PATCH] staging: rtl8723bs: fix buffer over-read in
 rtw_update_protection

rtw_update_protection() is called with a pointer offset into the
ies buffer but the full ie_length is passed, causing a potential
buffer over-read.

Fixes: e945c43df60b ("Staging: rtl8723bs: Delete dead code from update_current_network()")
Fixes: d3fcee1b78a5 ("staging: rtl8723bs: fix camel case in struct wlan_bssid_ex")
Reported-by: Luka Gejak <luka.gejak@linux.dev>
Closes: https://lore.kernel.org/linux-staging/DI2H39EAAFBZ.3KI5NWN02AQ2S@linux.dev
Cc: stable@vger.kernel.org
Signed-off-by: Salman Alghamdi <me@cipherat.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Link: https://patch.msgid.link/20260508222649.23989-1-me@cipherat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ddfc56f0253d..268f294528e6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -464,8 +464,11 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED) && (is_same_network(&pmlmepriv->cur_network.network, pnetwork, 0))) {
 		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
+		if (pmlmepriv->cur_network.network.ie_length < sizeof(struct ndis_802_11_fix_ie))
+			return;
+
 		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
-								pmlmepriv->cur_network.network.ie_length);
+								pmlmepriv->cur_network.network.ie_length - sizeof(struct ndis_802_11_fix_ie));
 	}
 }
 
@@ -1072,8 +1075,11 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 			break;
 	}
 
+	if (cur_network->network.ie_length < sizeof(struct ndis_802_11_fix_ie))
+		return;
+
 	rtw_update_protection(padapter, (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
-									(cur_network->network.ie_length));
+									(cur_network->network.ie_length - sizeof(struct ndis_802_11_fix_ie)));
 
 	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.ds_config);
 }

