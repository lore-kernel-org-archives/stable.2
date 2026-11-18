Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026957;
	b=YvcuusYoADQxWdwOVhcNACKcVYM4xVvQtk7AMKbigkKljBUJHvXEFKsgkpu9ID5sKM7A
	 xpe4ywQdzsasmmPwiIvwPGHluu6dDtvMpwHPoBJKMjrmTU9PxC2e8e2sSQzefIoJgtXID
	 kZGIjnnypfNAOdupwpK2W2oZr70E32Rcb70R1sNrmMH3TME/TD3u3tXHGIoQxASw+Yixa
	 dIv5PtCkR2ihOhEAM4+cceMmUg7RrRI9fYcXEx0vljEn9HgaEiHgQogpX7svUfpjR/2Am
	 XyJmCAgExb/L78JI6C4+prs03vqgtR4Q925YvvVMAn3oloBYJUbexQzNiOemStdeEtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mP54NqX1yA2UP7uMr6LAS3zfC46Nx8rGJsFCoNbtzuw=;
	b=V/ci+nQNscrLJYFlsgzxsw5FjkAy0enbaERkMS/oilqhgOD59Eqr3zHAYVPLWpb1eQmw
	 GGr/2IpNNdjr5/3ad9+AEinK77sEBNTIA/NB5NfS7LeAUNLwrBYj12pV0w+nXlgmQR6dA
	 6T6YrgXi2Prcpi/O7GEJShRzqqoH1AYiCXWqEeTSQKg8g+4NeW/+FAQHBXeH28hIX1kZW
	 slESqZpfy4r9Ktm3HDltLUQq5c+yIswUNimNhnb/jh/9Ety+OMboblpCNdsiR0Z3QUsSt
	 vYcQH43F4S0DxDHs9Wepu2PpFEUC6Tgv5fJ4r7gSf/nyKAYhdXxA9ZgsfIEm9tmSSsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mrU3nHra;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13C606A33B
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D13C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mrU3nHra
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-380b40312e2so3706744eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795026955; x=1795631755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mP54NqX1yA2UP7uMr6LAS3zfC46Nx8rGJsFCoNbtzuw=;
        b=mrU3nHratFm0M6YIukvWG4ZZBjASiv/7L+CzXozQ2wp7IyNP9SAxTgKwovudjdkiIS
         /NvxfzZrLyQyBBBGc/QvtTALhIM7Czf3e6361Lbt3Mk7UbeO06E1yJMgsVOldHBlicFm
         APBCJzbNEykJILVtaRMYFCKHWhXPjNaCUVNgkQA0T3+R+7V1EZHcQIPC6emfgbGa2rz6
         reqCiGOiGVspEtlqzmgvctm6IHZ5BYTfLuYcq4z6674W5DnC7obQqBrh2a4TNPaV6qHO
         2ac2e5v6m6+WLYHwrOJ5EIo9KYYAIq9TIDAzwPhUKtCAdyDVwnqF9Bi5nhiBz+Q+durH
         DV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795026955; x=1795631755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mP54NqX1yA2UP7uMr6LAS3zfC46Nx8rGJsFCoNbtzuw=;
        b=YwGSuZAlf2EPvGCsN3PbQPdS7cp2RXPWLtzght7oGSEY0uxbmlq/Z0XTxZA9Z6kVne
         cjHafJd0my1y8iP4XrtxptynwzH00BEKCE8+q5/w/e6GRPVLuhWZJXTTmO6nOhCtDfrm
         W2Sdyn584ouk8kWPaHdFcJWFiD4hDL70GdCWOlLgyau1xJWLDip/jHUBh6S7XVfI4HnK
         Tci5dVonOY+BhRHBW2p7MrbSB7p7tMyGREtjHhoVBIyQp4Td6rEFIGz7nCQ/1Rsheof8
         ZbCQ04GPGbaZ5gvfGmnlp1iecH4yWi83znh7EvfOjwoGRAsEy6SuRqVsrjRxHmjxuqLd
         GR2Q==
X-Forwarded-Encrypted: i=1; AL+hErGMb7OHTJjtL6BQeur/LIhm+XDoo2D8YJPdR/UvmIvRb5VbeDKfLAj1SrI6ycQ7GkdbLBcjTOE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tzK/KFhuFDI4IPiG9WUrz9ASzpEfaIIac4T5mwde8AwHwYt5z
	2oFtZtb7zgUBsGOapPXpVvjOrWphWJYk7wCAHl1i9xMSMFh0wOc1RSDJ
X-Gm-Gg: AZFdTZdmoFssv0lziMCJDrTLaA8EeHOMev1VqXwXhOVkjhgVSEB1CeK3zWW9altEfuq
	Bw/Dg2fqS8A7OACsX/i63tZ+AKWPcAAY6Gh968yGSiXlemeOiWiBMcGBsMJIO3cT4H5yeiRSzzc
	i4Ky/TgLj67++bPcV06IoSUT1mlmjvt3nqoJMnhVJlfqZW6u8jPcyk7IrdTzCk5wlEESVXj5iph
	aKpqIXpDT9QiO2TYC+JjAq3lO2hi3zZtJ8pQadCrQmT7/3uzduLC/ThP3b13MM/YNS3V+JrZs1V
	UPxoaZ40KLKdq3FiLTALKEsZmp6LOz1JdbUe/g59ckIjm1lEVDkrcYDcY5vVVnCbmV9FQ/KpxxR
	GGdVjegN8OCbqhjdRBXzjj6lABL8d2sEMB9Scxhi6ndZJW8PIZ3WKLz7lmJq7lFfXKM3YrsaUMU
	y/ubBFGPJAcduGDU3xj1FdbUlKUHY5hH4xAcqtmXr6pTZvJ+R3oQoeFDV3TaIIYgN+pemn0rZOV
	HGWeSTgW6jjlqWKA4RbPOfjyEH4IBGr1X049NVhDgKaGmRL5Ay5OATP4Qh/d8QoAsiJalx09oWH
	0tFhZNZe6F2E+zSTkbjr+SniG7mrFv3XOuc/an1yB22fUgsuIA==
X-Received: by 2002:a05:693c:409a:b0:382:48a5:cd53 with SMTP id 5a478bee46e88-38281217ff4mr3614000eec.31.1795026955041;
        Wed, 18 Nov 2026 10:35:55 -0800 (PST)
Received: from G7XWH7K1F3 ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45274aesm10450189eec.2.2026.11.18.10.35.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 10:35:54 -0800 (PST)
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
Subject: [PATCH wireless v2 3/4] wifi: nxpwifi: own beacon data used by channel switch work
Date: Thu, 19 Nov 2026 02:35:05 +0800
Message-ID: <20261118183506.45749-4-enderaoelyther@gmail.com>
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

The channel-switch work reads the new beacon data after the cfg80211
callback has returned, but the driver keeps only pointers into the
request, which can be freed by then. The IE parser then reads freed
memory.

Copy the beacon buffers used by nxpwifi_set_mgmt_ies() into an owned
cfg80211_ap_update. Free it when the work finishes or is canceled, and
return -EBUSY while a switch is pending.

Found by code review. Compile-tested with W=1.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
No new W=1, sparse or smatch warnings.

AI assistance was used.

 drivers/net/wireless/nxp/nxpwifi/11h.c      | 14 +++--
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c | 60 ++++++++++++++++++++-
 drivers/net/wireless/nxp/nxpwifi/main.h     |  2 +-
 3 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
index 058c319ff910..a6c87dfad9ee 100644
--- a/drivers/net/wireless/nxp/nxpwifi/11h.c
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -301,21 +301,21 @@ void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
 	if (!bss_cfg->beacon_period) {
 		nxpwifi_dbg(adapter, ERROR,
 			    "channel switch: AP already stopped\n");
-		return;
+		goto out;
 	}
 
 	if (nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_STOP,
 			     HOST_ACT_GEN_SET, 0, NULL, true)) {
 		nxpwifi_dbg(adapter, ERROR,
 			    "channel switch: Failed to stop the BSS\n");
-		return;
+		goto out;
 	}
 
 	if (nxpwifi_cfg80211_change_beacon(adapter->wiphy, priv->netdev,
-					   &priv->ap_update_info)) {
+					   priv->ap_update_info)) {
 		nxpwifi_dbg(adapter, ERROR,
 			    "channel switch: Failed to set beacon\n");
-		return;
+		goto out;
 	}
 
 	nxpwifi_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
@@ -323,7 +323,7 @@ void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
 	if (nxpwifi_config_start_uap(priv, bss_cfg)) {
 		nxpwifi_dbg(adapter, ERROR,
 			    "Failed to start AP after channel switch\n");
-		return;
+		goto out;
 	}
 
 	nxpwifi_dbg(adapter, MSG,
@@ -336,4 +336,8 @@ void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
 		nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
 		priv->uap_stop_tx = false;
 	}
+
+out:
+	kfree(priv->ap_update_info);
+	priv->ap_update_info = NULL;
 }
diff --git a/drivers/net/wireless/nxp/nxpwifi/cfg80211.c b/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
index a9cee7e602f0..e42f0f9b61dd 100644
--- a/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
+++ b/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
@@ -1641,6 +1641,8 @@ static int nxpwifi_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	wiphy_delayed_work_cancel(wiphy, &priv->dfs_chan_sw_work);
 	priv->uap_stop_tx = false;
+	kfree(priv->ap_update_info);
+	priv->ap_update_info = NULL;
 	nxpwifi_abort_cac(priv);
 
 	if (nxpwifi_del_mgmt_ies(priv))
@@ -3068,6 +3070,52 @@ static int nxpwifi_cfg80211_set_coalesce(struct wiphy *wiphy,
 	return nxpwifi_coalesce_cfg(priv, &coalesce_cfg);
 }
 
+/* Keep only the beacon buffers consumed by nxpwifi_set_mgmt_ies(). */
+static struct cfg80211_ap_update *
+nxpwifi_dup_csa_update(const struct cfg80211_beacon_data *beacon)
+{
+	struct cfg80211_ap_update *update;
+	struct cfg80211_beacon_data *copy;
+	size_t len;
+	u8 *pos;
+
+	/* Each length comes from a bounded netlink attribute. */
+	len = beacon->tail_len + beacon->beacon_ies_len +
+	      beacon->proberesp_ies_len + beacon->assocresp_ies_len;
+
+	update = kzalloc(sizeof(*update) + len, GFP_KERNEL);
+	if (!update)
+		return NULL;
+
+	copy = &update->beacon;
+	pos = (u8 *)(update + 1);
+	if (beacon->tail_len) {
+		copy->tail = pos;
+		copy->tail_len = beacon->tail_len;
+		memcpy(pos, beacon->tail, beacon->tail_len);
+		pos += beacon->tail_len;
+	}
+	if (beacon->beacon_ies_len) {
+		copy->beacon_ies = pos;
+		copy->beacon_ies_len = beacon->beacon_ies_len;
+		memcpy(pos, beacon->beacon_ies, beacon->beacon_ies_len);
+		pos += beacon->beacon_ies_len;
+	}
+	if (beacon->proberesp_ies_len) {
+		copy->proberesp_ies = pos;
+		copy->proberesp_ies_len = beacon->proberesp_ies_len;
+		memcpy(pos, beacon->proberesp_ies, beacon->proberesp_ies_len);
+		pos += beacon->proberesp_ies_len;
+	}
+	if (beacon->assocresp_ies_len) {
+		copy->assocresp_ies = pos;
+		copy->assocresp_ies_len = beacon->assocresp_ies_len;
+		memcpy(pos, beacon->assocresp_ies, beacon->assocresp_ies_len);
+	}
+
+	return update;
+}
+
 static int
 nxpwifi_cfg80211_uap_add_station(struct nxpwifi_private *priv, const u8 *mac,
 				 struct station_parameters *params)
@@ -3101,9 +3149,13 @@ nxpwifi_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				struct cfg80211_csa_settings *params)
 {
 	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	struct cfg80211_ap_update *update;
 	int chsw_msec;
 	int ret;
 
+	if (priv->ap_update_info)
+		return -EBUSY;
+
 	if (priv->adapter->scan_processing) {
 		nxpwifi_dbg(priv->adapter, ERROR,
 			    "radar detection: scan in process...\n");
@@ -3117,6 +3169,10 @@ nxpwifi_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				       &priv->dfs_chandef))
 		return -EINVAL;
 
+	update = nxpwifi_dup_csa_update(&params->beacon_after);
+	if (!update)
+		return -ENOMEM;
+
 	ret = nxpwifi_del_mgmt_ies(priv);
 	if (ret)
 		nxpwifi_dbg(priv->adapter, ERROR,
@@ -3126,12 +3182,12 @@ nxpwifi_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (ret) {
 		nxpwifi_dbg(priv->adapter, ERROR,
 			    "%s: setting mgmt ies failed\n", __func__);
+		kfree(update);
 		goto done;
 	}
 
 	memcpy(&priv->dfs_chandef, &params->chandef, sizeof(priv->dfs_chandef));
-	memcpy(&priv->ap_update_info.beacon, &params->beacon_after,
-	       sizeof(priv->ap_update_info.beacon));
+	priv->ap_update_info = update;
 
 	if (params->block_tx) {
 		netif_carrier_off(priv->netdev);
diff --git a/drivers/net/wireless/nxp/nxpwifi/main.h b/drivers/net/wireless/nxp/nxpwifi/main.h
index b25a6a4f2936..4d5718ed5031 100644
--- a/drivers/net/wireless/nxp/nxpwifi/main.h
+++ b/drivers/net/wireless/nxp/nxpwifi/main.h
@@ -619,7 +619,7 @@ struct nxpwifi_private {
 	struct wiphy_delayed_work dfs_cac_work;
 	struct wiphy_delayed_work dfs_chan_sw_work;
 	bool uap_stop_tx;
-	struct cfg80211_ap_update ap_update_info;
+	struct cfg80211_ap_update *ap_update_info;
 	struct nxpwifi_11h_intf_state state_11h;
 	struct nxpwifi_ds_mem_rw mem_rw;
 	struct sk_buff_head bypass_txq;
-- 
2.56.1

