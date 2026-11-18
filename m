Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026948;
	b=j9FiRJB8tdTIgMUNHk1VnYEmyeB1nrNcUZzImQ4iy7CCAZlxYRBL3sJTq10W90NGYZcm
	 6XyFDLDDoHJOA2efqcGzHvV61r4gdlXcUDJiVAY8DlPHxXdkLXs5fRRRnph+rPAUq7u7z
	 IHNIMN+sZND5kcX4utMdJlWRrmeSdBMavY+dQdQ+jrKQRYFvIPuHJ9jkKedQwc3YG5zK9
	 +uoCCWmosuAA3ha0IzU0AO3cDcXZ1CdAgv9gPnzZBtfgoWaqtvBdZo0yM/XxUtv8Hscu6
	 29U0NDZILxdoyfdBH1qiA7AEQ3HPzZ+/Zg+WA8NNSB+P0pyyFntifSQ7BAZJlr/yplQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AMr/kZW4+kvAE0nS8oXztOJCwRpyD037PL8XekrkuT0=;
	b=fwF5hfICtX5xxMC/54NdLWqg76jpfS43xwfZzC6HTgndUTnGy02nQU90z32oYWpqfzPb
	 49ss0J+m3ah8JdlPRthreXMOEroaB9QarX8xwmCDwTldMYrDOLVurb4zU2OEAkpTxx4bW
	 D/djx8Cr5XUJgda1lO86ZRIuSt2dDlmry8483wdIoVVUdhN9nw4LqWf5eIhRQ1JsDGn9q
	 sjGOgm0ae2n8RzSxcPSyAcWhnExDjKnTnAuZ1MUIXzFrL0l1zqLGNyG9PAbrLX6T5HRTX
	 sN3ZZhKzM0uiKqVl807mAOc8dFfYY2cEAByzkaT3iUhr/E2CGg8EkHGhfdaa44ySbLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iOXXHkg+;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF2606A330
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80AF2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iOXXHkg+
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38318d69173so1198142eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795026948; x=1795631748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AMr/kZW4+kvAE0nS8oXztOJCwRpyD037PL8XekrkuT0=;
        b=iOXXHkg+n/ce/O717VOf0Xpv9u+HmYUoznTml1fkw1ailXngV+JSSmjuiecNPvXkYI
         +kwzAjzb1lwmb9b61E/RI3iJTyrP45yIPuMI5j8hZ5FaLrM8KAAYH2BFhha89xo6K2B7
         O+prREh2tD8Nos7PPpAqytEVof0geSzpzC+9QKUXy7d7rUJaPX0/cCrHkNtr2p5eAaTl
         8xUwdPwm+iok4h8tAqKD5uUEO2rUD1EaNGaIxJAFFgAj8N41PgxbOgYJAmZuKo0/ZK+F
         InGKJfSFI8/PY2LwRsby7+zz1bpIWOL2ubwiMiaHQZ3Id3lIKc+R1ohAvxqSAob2xVVr
         IP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795026948; x=1795631748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AMr/kZW4+kvAE0nS8oXztOJCwRpyD037PL8XekrkuT0=;
        b=RHyZrUjoHDEL8BhX9JkruWD/6QCBQTNyrZWTsD+KTok23HUb9645saz8DST6VgNPIn
         +wpp5/kq/iH95uW0Tly/9e8Uy/BsC90zJby6toYB8FevV9m6QVAT2h4MerPCV1hPQbEu
         hzANWNFva7MFZlb40Cw0gDFM9kb3BDwiEQxrsSLDe+wLjzctApb5blg7BlR1cf4gHjYT
         mzZ7etIybBd/eGZNq10a+d4DBMTCpmXrRPDRSMbifqAxCEuiwjXIHY2T8Vv2XwV3DS97
         O+VSTG3OON07YW+Grt6vYPo45/vRwyYjy937sYtsAVcFLCxTt0kyMJ8jcM0X2w/Amzo4
         +sNA==
X-Forwarded-Encrypted: i=1; AL+hErFpp5DtxV4rr8oLyt29YwZHZCypjmeBNOeynT25BX3x1jIUTdbhzYW55qCMftSMNnX1ewt7r8M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/jPD8ts7U1BBbcGpq7fIs6nt7lj90U/1qdem/h8/UWZMOZVgV
	PBTGI8LKyRuFcyyM02ZTmjmDjT+tDnB/61lpS3QvvuUI/HonUwYa4GGu
X-Gm-Gg: AYBFou0EQlY6s/UNQyMJwakCiHMkdo2IKCLe7ajP8bkh9nRAbnI9hVbjWqWLT5egWFp
	Bttef2hO239Fnb24RCu6AqZJkULKk84QvpFvKt/ygdDBN6Pp1BD1jbxogHANwck9glilK+tXMI9
	5IV0k2KFr3prPqRgMgnHmZmua94WHg6fRLatjHLNopaErEr8EyuX451zDIVV2in0usqbNkesd+g
	V1MjyD2we8rwZol2GdAOx0fl+mPjm/vvEWt1/To+ZVqk+cnHy3ys+SkX1jueHV+kGCYubZgIttl
	K9yMZ878yB1lyaGlQxZz/VpFNoYCKctWjT8uU27PMUzKfG2Bm+w0pz07Vu15wM1CgSV7kH9hdJm
	oczU9/K1e/jMATlye+Bk+ySLBNpZGUhkoBT6VmuceQ3P7gGtrPHaGWThQJxPl+CKP89OKsg4nMa
	eXAwr9WblLiCuNgFimGUs11zywus/V7fDKt5uZ3Yhjs8wtNOed5Tz9U0sV/FvA6BVraCbM93RVw
	Dxyq4iyR5YGPWy3Bccw4EHIs5vkoKU20h7uNLN0sCtobjLRG1BCBHa6lOvDG9nqBLKvNAb7Md8J
	8dLAITu9M6v79S/hI9uxFYtI6db3lKFmRWbPWVPQZlgsuFLLtA==
X-Received: by 2002:a05:7300:c7c4:b0:36a:1d6a:596b with SMTP id 5a478bee46e88-382818137a5mr3475399eec.29.1795026947011;
        Wed, 18 Nov 2026 10:35:47 -0800 (PST)
Received: from G7XWH7K1F3 ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45274aesm10450189eec.2.2026.11.18.10.35.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 10:35:46 -0800 (PST)
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
Subject: [PATCH wireless v2 2/4] wifi: nxpwifi: stop AP TX after preparing channel switch
Date: Thu, 19 Nov 2026 02:35:04 +0800
Message-ID: <20261118183506.45749-3-enderaoelyther@gmail.com>
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

A channel switch with block_tx set disables the carrier and TX queues
before the CSA management IEs are installed. If installing them fails,
the request is rejected but TX stays stopped.

Stop TX only after the IEs are installed.

Found by code review. Compile-tested with W=1.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
No new W=1, sparse or smatch warnings.

AI assistance was used.

 drivers/net/wireless/nxp/nxpwifi/cfg80211.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfg80211.c b/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
index 5b8fb37c3f3d..a9cee7e602f0 100644
--- a/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
+++ b/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
@@ -3117,12 +3117,6 @@ nxpwifi_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				       &priv->dfs_chandef))
 		return -EINVAL;
 
-	if (params->block_tx) {
-		netif_carrier_off(priv->netdev);
-		nxpwifi_stop_net_dev_queue(priv->netdev, priv->adapter);
-		priv->uap_stop_tx = true;
-	}
-
 	ret = nxpwifi_del_mgmt_ies(priv);
 	if (ret)
 		nxpwifi_dbg(priv->adapter, ERROR,
@@ -3139,6 +3133,12 @@ nxpwifi_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(&priv->ap_update_info.beacon, &params->beacon_after,
 	       sizeof(priv->ap_update_info.beacon));
 
+	if (params->block_tx) {
+		netif_carrier_off(priv->netdev);
+		nxpwifi_stop_net_dev_queue(priv->netdev, priv->adapter);
+		priv->uap_stop_tx = true;
+	}
+
 	chsw_msec = max(params->count * priv->bss_cfg.beacon_period, 100);
 
 	nxpwifi_queue_delayed_wiphy_work(priv->adapter,
-- 
2.56.1

