Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026965;
	b=hpYjRI0pDzKehITMla9HGBPF5yqxbSEBh2dv7qawwWyzZaU3XEieK+O8nra7a+oAh7S4
	 +JFTdQKQS56UOLO/Uw/XQxbjrM9DfH1gZcrZcMjp2sfV0TXhCx7z7tQGbaEuHMyGJ0r71
	 TdXfR55FQQv8dgVyoj2g3eAknSXPZ7m/6vyVAj7LjWrY7UlX48+sgo1UAT1dBj2tNxKMs
	 UyI9/+yV89jkhkH+EkyCLBXs/gHkicbfdEttZsNqKTAkgl1ShGtpMIF3pvrH2OTGdrU5i
	 B4tNxf1KP6muifJuDoEjnk5XcuG38JzdsjD7VUl3l7x8Yz0fhouxegClRXNRU0k7kyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8RDyAIx6GdPyur2p4krhRfb/lrH/VMCLoWVTsANEHhI=;
	b=fkUgIIdMXNcaQtAQ2Wq/QynriV14JS7oSF798sf1aIv9/6fSwDpG6/HfhBBMGKtYfseC
	 27i6mWQTjoGagdBli/cj8PhbGf1OG107WFnsSLZZTG32mdDoZuZAbbincffU4OKC4eXUD
	 4wAQu9Rj9P2f3bKNdBXFHQd3DCdd3+1nWcQufAxGiKU4MspM+hKG357Sf0Wh6Jr0fcoNK
	 NeDjbVsNGfKZhoFqtkQDUGO471A+bky1E//F12AKPn+6FeURp0s5N/78eU1gRJ8LzvUjC
	 u+0/4EyKTvUhEpuKZ3apWqFdIkAvGk5WV2gshFg0DMYV310CYBH9+oUslr8CTyyLEfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kmAcvJnL;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C70606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6C70606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kmAcvJnL
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15ea896ddc8so2340490c88.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795026964; x=1795631764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RDyAIx6GdPyur2p4krhRfb/lrH/VMCLoWVTsANEHhI=;
        b=kmAcvJnL0+eiYXsyN8IMK9D8KwnlkRZHRuuD9sBxVGn5t2mob9W8a/IaGyCKBnoPXo
         Vd+TDCxJ7g5FKRfitt4LhgaQYVaYShyMWk7KrCzqg0gNLr3+tArJDgRuyYbrZk/Y9IDC
         ghCHM6Agc+jSakuk3SRYN53xY27OzB6ErohGLrGTYKtqp1c64tQLONvhveiUtiSjih5X
         h3xwBeRiQlOVpLqaLA5JxJiBAsmBx8E4R93y7TqFHbZ18gvvQUSGpC3gdZ9ptWMIwG0X
         EZ7JvNQqIpAfbPLC/lgL0HQqcCdE8Hc6GepMhdP9SYzv62xf5tkTQZQbkxW72NbHHLjl
         kBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795026964; x=1795631764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8RDyAIx6GdPyur2p4krhRfb/lrH/VMCLoWVTsANEHhI=;
        b=mbYGRi/a/TYz+BEY/NCbB8noDGirim+Vl4uWMoJP06uJhIaHi4j368yD3WesZEx7xj
         AbGa21qYdPdFMH9jIHNTDh1XD37dzpy7bYBxUvSyeciS4a3kLtE+cluL6dMUAUJxTaBm
         PbM7S22Q1C09Gkbfmcl8yy0CSq2VXXyW64RJRDMnUPPhWHT2UEB49HpvF2knm7BF4dK9
         Y26T6w4Bb4/inLLJncLyuppwZfFeeqjpmadHgFYxTOcUhkzFuBhPaR8tKMCZcOM6ttaY
         GCbW8erQyMdbOcO2boqJrx13YiPoNcVJmajwia2fdWKLwVDts8qa2lkIwLmWl7ukcF5e
         +pFA==
X-Forwarded-Encrypted: i=1; AL+hErE1SUdj+aXwJ/NWl1lGm/l1NXIS8lHg7A+akcES753ME0OvH+0R/dgVDGsQxRtG/R/8GGbJhdo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qMcMxEhsD30Ky4IQLlXtquvUrltjBE2IO9Uau+0NFlizU1l20
	b23A9BSSnRXcc1ujnpRh8AmauV44iZ8kPoLjI3MPEeKYv0RsZzXafPxJ
X-Gm-Gg: AZFdTZcQ8HD5/7JhrmDDguXKWXdeGWqPQwlUIiinN/isTkq0Z4EVw3PAlh53fl0fpUf
	1KtTYdSDaXzbLpYlOFk62V1u7K9nBpmdEpAW1jwVOzW6TfAiv577vOk2wiaHDmgCkqVpS0aSbSP
	Hj3mSSBhPhf9AF9sbnw9x4uyxvBAWBP2pGMfWOeUzJgO7O7vevnE4qfCg35NRY+wzmQgChPmMND
	MX5tG7CTHlvHA2vgxf+WwfvD2pusK10i705YFGtLRqgzfSbt1MMbqIaDIBdC6Whdcc7jC9+Ra9E
	MhPlDwMcWHqYa0QXsm8iiTkET3Mw90dAjyQ1k5fPVhpJChpyUPLbO/Riuq/ijl+/QW0v7T3xlcl
	awZqrB/FWDVmWtWqh1uKFJC2JU5vHjNeUI+CygnneWc+nB4Bzrk+S28dyyNLBRyeKRh+kL8iUqE
	EmIVmurnA8iU3uUuzOkoOLnuE7tHJI+/Xd0eJoLkB7eICk85bRATs0WKDFHVVgZ1k2F4IVgtVfX
	k7AGJZbJyEvMxg4r+uLGtReuBK8ZAzoQRf2+e8XZXoyOVcP+ISD/omFvabT3rbhNDarFAhW8A/r
	GB/dRYjIpDx38Ag+fQffUTVbkO4mvZHtBCriNeIxBscRR3jdZg==
X-Received: by 2002:a05:7301:190a:b0:36a:1e9e:ae61 with SMTP id 5a478bee46e88-38281bfa917mr3311876eec.38.1795026963313;
        Wed, 18 Nov 2026 10:36:03 -0800 (PST)
Received: from G7XWH7K1F3 ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45274aesm10450189eec.2.2026.11.18.10.35.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 10:36:03 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Jeff Chen <jeff.chen_1@oss.nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Linmao Li <lilinmao@kylinos.cn>,
	Kees Cook <kees+treewide@kernel.org>,
	Rosen Penev <rosenp@gmail.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH wireless v2 4/4] wifi: nxpwifi: stop AP when delayed channel switch fails
Date: Thu, 19 Nov 2026 02:35:06 +0800
Message-ID: <20261118183506.45749-5-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118183506.45749-1-enderaoelyther@gmail.com>
References: <20261118183506.45749-1-enderaoelyther@gmail.com>
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

The delayed channel-switch work can fail while stopping the BSS, setting
the beacon or restarting the AP. It then returns without telling
cfg80211, and TX stays enabled over the stopped BSS unless the request
set block_tx.

On each failure, stop the carrier and TX queues, clear uap_stop_tx and
request interface shutdown, then free the beacon update as on success.

Found by code review. Compile-tested with W=1.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
No new W=1, sparse or smatch warnings.

AI assistance was used.

 drivers/net/wireless/nxp/nxpwifi/11h.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
index a6c87dfad9ee..d83f36b1c8a5 100644
--- a/drivers/net/wireless/nxp/nxpwifi/11h.c
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -300,22 +300,22 @@ void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
 	bss_cfg = &priv->bss_cfg;
 	if (!bss_cfg->beacon_period) {
 		nxpwifi_dbg(adapter, ERROR,
-			    "channel switch: AP already stopped\n");
-		goto out;
+			    "channel switch: AP configuration is missing\n");
+		goto stop_iface;
 	}
 
 	if (nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_STOP,
 			     HOST_ACT_GEN_SET, 0, NULL, true)) {
 		nxpwifi_dbg(adapter, ERROR,
 			    "channel switch: Failed to stop the BSS\n");
-		goto out;
+		goto stop_iface;
 	}
 
 	if (nxpwifi_cfg80211_change_beacon(adapter->wiphy, priv->netdev,
 					   priv->ap_update_info)) {
 		nxpwifi_dbg(adapter, ERROR,
 			    "channel switch: Failed to set beacon\n");
-		goto out;
+		goto stop_iface;
 	}
 
 	nxpwifi_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
@@ -323,7 +323,7 @@ void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
 	if (nxpwifi_config_start_uap(priv, bss_cfg)) {
 		nxpwifi_dbg(adapter, ERROR,
 			    "Failed to start AP after channel switch\n");
-		goto out;
+		goto stop_iface;
 	}
 
 	nxpwifi_dbg(adapter, MSG,
@@ -337,6 +337,13 @@ void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
 		priv->uap_stop_tx = false;
 	}
 
+	goto out;
+
+stop_iface:
+	netif_carrier_off(priv->netdev);
+	nxpwifi_stop_net_dev_queue(priv->netdev, adapter);
+	priv->uap_stop_tx = false;
+	cfg80211_stop_iface(wiphy, &priv->wdev, GFP_KERNEL);
 out:
 	kfree(priv->ap_update_info);
 	priv->ap_update_info = NULL;
-- 
2.56.1

