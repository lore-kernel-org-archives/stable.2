Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.133.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500304;
	b=cqusIZ7r6QV39/hFhfPbiKSc8sZgMRzm4nNO8+riOYU3fA6QGjswP2KNm2TLG8ISV0NE
	 dj75RalXsmNs+AogQF49QIK+m6gw331qqZs+/6iHLsUv4JcZ0xbp7j5uWI/baWmxMU4fL
	 DNEvzGRdpSOOalARVuLuYtN8Gb88na7b+OTLsrpBrOZGNMKHp9cgr9Fg4hwq5kPnhNt1q
	 toB1oNfrDNmyxZmtPt+idh1eQIOdAV+KkUJ7iLAT0015h73oNdGi42wc3sIK2NU28FS3c
	 sAWnbCcN6slYBhOEuqovDLQ5hsUWIfY3+ETk1QpCnRhmf6sjtUDnaa8tTV1G/irMPLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500304;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Authenticated-Id;
	bh=D27nMcM5IZRFAaSEfdIPzVC4z9j7x8tdc7WtT58eyFM=;
	b=p80ffcKtYTNniTJagVTZA6zh7Sl9no3zlCl7oxO2eucCzh+D9jNxjbFEKvt/WDa96Ng4
	 hF/67r3y1dt4BXnvXCP3FiCfVkuzAnjnO0FcUFreBoIHMsc8ngm0+NFZSxNMHbiyG1ZvN
	 xAlY54cyDst5KyVa9pcwlTFZEg32mN7x756frTkbZel6JQ9IKA6EWaTDn1/SUC6JAD7WP
	 fIbOEbzyYLq/HVK6wGthzUAmJ/2rRMj50SHAyvvLHF6yl1XZsrDzyitcUFluE7slpnwIH
	 vOzZ2vSuU0cNclefNGn6RTNBUjCdISIJ493h9CuoOJWZPwhmkPsY3cvM8oRQOK+b2Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kubik.pl;
	spf=pass smtp.mailfrom=kubik.pl;
	arc=none smtp.remote-ip=213.239.133.36
Received: from mail-e681.seohost-mail.eu (mail-e681.seohost-mail.eu [213.239.133.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4CF606A320;
	Tue, 20 Oct 2026 12:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A4CF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kubik.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubik.pl
Received: from static-46-238-236-132.awacom.net ([46.238.236.132] helo=localhost)
	by h84.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <piotr@kubik.pl>)
	id 1xJ9D3-00000004hAP-3Gb2;
	Tue, 20 Oct 2026 14:44:53 +0200
From: Piotr Kubik <piotr@kubik.pl>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
	Muna Sinada <muna.sinada@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr Kubik <piotr@kubik.pl>,
	stable@vger.kernel.org
Subject: [PATCH wireless 1/2] wifi: mac80211: change the links of an AP_VLAN station through its AP
Date: Tue, 20 Oct 2026 14:44:45 +0200
Message-ID: <20261020124446.188739-2-piotr@kubik.pl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020124446.188739-1-piotr@kubik.pl>
References: <20261020124446.188739-1-piotr@kubik.pl>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: piotr@kubik.pl

A 4-address station of an AP MLD moves to an AP_VLAN interface, so its
sta->sdata is the AP_VLAN. The AP_VLAN is never added to the driver,
so check_sdata_in_driver() in drv_change_sta_links() warns and returns
-EIO for every link change of such a station. Adding a link fails, and
removing a link leaves it in the driver, because
ieee80211_sta_remove_link() ignores the error.

Map the AP_VLAN to its AP first, as drv_sta_state() does.

Fixes: 469d5d5a3b7a ("wifi: mac80211: synchronize valid links for WDS AP_VLAN interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Piotr Kubik <piotr@kubik.pl>
---
  net/mac80211/driver-ops.c |    1 +
  1 file changed, 1 insertion(+)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -593,6 +593,7 @@ int drv_change_sta_links(struct ieee8021
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
