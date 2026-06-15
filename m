Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50433FBB68
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534633; cv=none; b=DT4c++LsvixaCrJhKtyAAiYe7VyZqTpRvVy4JYwbdistBUX7XN8RDvphUpE7yFoZ8vjfIfQndC+h1WnMmjPhisR1dEnAy+0JxnhQmRl+5J+tU9WDLtIyiEXIbJC+AYEYQL85Zo9FiXm2Q7XgkdlDaRMu8wOFTFPGSQy9ysd8m3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534633; c=relaxed/simple;
	bh=/n5PrA4K7kjAzV3Wy0oJznkuHlyzNMqz4g05YpRvPAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HJ2ZBmO1w9kWMdZtbHb7IW/JI2caxR7F/dWeA9a2+2oahfaLRMIO9ks5rf3GI2ZK/wpdzH8XHzuJO1ERLsriuFV52/FqapPGuoD0LeeN7qQ5FR53DQaSgmYe+mKM7xuYiFEJl9VTEFFCb0DcFfPw4pETPox9O7r8DD7RrTT78jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CqmpbGCX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CqmpbGCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B8F1F000E9;
	Mon, 15 Jun 2026 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534632;
	bh=z6rVH/M+XMvrmp45O+POIabGa5/Rndg8vsHSNRYkoP0=;
	h=Subject:To:Cc:From:Date;
	b=CqmpbGCXEz4s6XE6JzmF4wfvbVOrL8VaHftx6NrGkWj6XGzO/oPlFi9jp9YSNcN9K
	 16KIi7bPHAkhjjWkonkhe5I3EGYwNxKxJY/tYYAclC0h0/tpgK/kKGWpOuJ7mmmcqP
	 UwNmY3lH4VNjbUXRUZP9brVHEvgwMBoTc6IZUrRI=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix buffer over-read in" failed to apply to 6.12-stable tree
To: me@cipherat.com,gregkh@linuxfoundation.org,luka.gejak@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:30:01 +0200
Message-ID: <2026061501-overheat-caution-dc20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 514ab98364595007d4557ecc85d7e5f012c504d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061501-overheat-caution-dc20@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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

