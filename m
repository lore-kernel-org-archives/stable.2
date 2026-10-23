Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.133.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753154;
	b=rIfbj6r9qUMm+B1s8TtLyLFv/EPiCRogaAlTcKP+4lOXnqq60OBf+NyO2AeqFl0I1JVH
	 lsXzoVckltwg2KLbmjLClP0bosNJRM4JFkoR/JF7nvnIJiKnGdL5tJ514qcIZYg+50q5e
	 L7XLf7BOLITuK7glfaA6fh93DUrR5HGksQPeY7P28e64YpDLvZEQWj/i34nXcz7cnzMGr
	 Chkou2B1ypMrCVf4X28kuUFNui6QSmCfaHOMn80katbFk6Ctoht4V1QGM8+HvNgw1iEgr
	 kSMdsLaOCgxZz8t3EFcTnaef6EbFVtKV/N+Edj2S0hPc8NS5TwZNJsR+NDeQ/D915Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753154;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Authenticated-Id;
	bh=Mezb3aebBAwDE/PfLG1U4xa+UrorOgEthSWjT47v5Vg=;
	b=IKy1ymRTb2MtlPQE4qEsNA8ehRo1mq+/u7Idd7k4Jj6hkYs/p7pgFmUVdn1TIxyuxpo0
	 dJiS54iYTyHQVPw/GRwfp7U028PUp4Wktwd3uSLGl+IRz+/wC9/4kKWWwopk1oB3hKW8+
	 lQFT6lZXxedLeVGIjyxIcfsuEFKKhn3vXWpMLRLAv0roC+H3pfa/gDi9FXDctwBtE8RzG
	 /RJSem05Vb8Kk39v+NtHViOJHgtrJ0VzyVm3S9WWkzDnHUeDu3ZpXTRc7wI6xrFz3Iezj
	 oNGeCAycygZGFCcGqk3ldbrzkDlXJORJ3C4hOmmc9rJO66yd5qWwxBSgSQP08iqjQQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kubik.pl;
	spf=pass smtp.mailfrom=kubik.pl;
	arc=none smtp.remote-ip=213.239.133.37
Received: from mail-e842.seohost-mail.eu (mail-e842.seohost-mail.eu [213.239.133.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A37606A31A;
	Fri, 23 Oct 2026 10:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07A37606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kubik.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubik.pl
Received: from static-46-238-236-132.awacom.net ([46.238.236.132] helo=localhost)
	by h84.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <piotr@kubik.pl>)
	id 1xKCzP-00000007gNm-0m8a;
	Fri, 23 Oct 2026 12:59:11 +0200
From: Piotr Kubik <piotr@kubik.pl>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
	Muna Sinada <muna.sinada@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr Kubik <piotr@kubik.pl>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2 1/2] wifi: mac80211: change the links of an AP_VLAN station through its AP
Date: Fri, 23 Oct 2026 12:58:43 +0200
Message-ID: <20261023105844.1117460-2-piotr@kubik.pl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023105844.1117460-1-piotr@kubik.pl>
References: <20261023105844.1117460-1-piotr@kubik.pl>
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
 net/mac80211/driver-ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 49753b73aba2..823317b2f691 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -593,6 +593,7 @@ int drv_change_sta_links(struct ieee80211_local *local,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
-- 
2.55.0

