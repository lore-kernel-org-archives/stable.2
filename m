Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2444DB62
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625323; cv=none; b=Cv4Y+rEkDH+66m+7UNVPMFdf46cq2efaEmPFnio6YBs/9hubjzvDlkaaRXmkDRmkhmsB+YJ3RQsPKYATAplW3dTAy0tQYz/qGRbkTtUidszXgtIqll+wOKSHREEnbd4W+yH9g3IrNs7iuXVCtu2Xvyo+mhHzDEfuFIpSuxHt/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625323; c=relaxed/simple;
	bh=IIYESV4Jd8wPDviCiLsynfXTewWsfiOnRjQzfydbVa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbrK2UXT1rGkYGfkq+QN0t/yQKdfIXpfa8m9CrF/jwP5zSQIKL55jV5BgXI42Por9DkD1GCIfHDYVHvqcioyVnAwkPK9DvCNOlUKm2SLRcu1gx3jxuQwT5bVsgoeLUaSo1ArP+tHEhbkPabHddDHSQC8+iAM+cfgKjGh+wYQlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKDFVych; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKDFVych"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03CE1F000E9;
	Tue, 16 Jun 2026 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625322;
	bh=qlQXlBsHQbS15KuGoMocJqDC6olMMamHpXmLAA18KuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKDFVychmKEOUADHcDfgoxFFg2a9lC/ofuib1LSN7JPDFLK9edbrb2gQn8AtdPpKq
	 BhFPiN9NcWAmq1T7N1nhQcDior3X7QLPB3MzRD8TCGgnSWArX5h97DRFjOHndlqhit
	 ZRfjhlrnWgqKVxcvYeCKY3akngN5uRJQ11NnSiUFCJaaq9teCMnfQo1Cs+mD2D58Q7
	 uIncBO8RLDZpmQgTiv00551k8jmOJQgOYb70fG1TxxfPNGIdXr9fTAk7AlvoVfIN8d
	 6vetbKwUp252EqrbFAAREO4xc8R8NRUCX6mvF3TgW8MYiid7u0ATJIhSxNyoGXl3+0
	 DTJoGyYCO29kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Salman Alghamdi <me@cipherat.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] staging: rtl8723bs: fix buffer over-read in rtw_update_protection
Date: Tue, 16 Jun 2026 11:55:20 -0400
Message-ID: <20260616155520.3322698-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061501-overheat-caution-dc20@gregkh>
References: <2026061501-overheat-caution-dc20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Salman Alghamdi <me@cipherat.com>

[ Upstream commit 514ab98364595007d4557ecc85d7e5f012c504d3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 3563017acc3136..d4b6e748f11fc2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -449,8 +449,11 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) && (is_same_network(&(pmlmepriv->cur_network.network), pnetwork, 0))) {
 		update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
+		if (pmlmepriv->cur_network.network.ie_length < sizeof(struct ndis_802_11_fix_ie))
+			return;
+
 		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
-								pmlmepriv->cur_network.network.ie_length);
+								pmlmepriv->cur_network.network.ie_length - sizeof(struct ndis_802_11_fix_ie));
 	}
 }
 
@@ -1070,8 +1073,11 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
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
-- 
2.53.0

