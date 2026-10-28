Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197133;
	b=IXZCp/O+p6LO/xOITIPLDThnfFttqj9zYzl+E4ObCJN+6MolnpF4dzW6+WNjbn3HTHLg
	 QWY5TeL7zryTDgNM4Wyo+4+bd3qBkHnpTcSz34FSxDn0jQVze8BDdWh1jN4G4ir4wdzvK
	 ou3F7LZPGhXBxgkdOiGSXGk6AZH8puj1zuIasFxrUjp5Ju1En8bCc9H04fGLD2hz3bRKZ
	 +CNLII+o2SmBp689+8sHRaHk10V2hbYz7MToLOE+OXIEryrrr6KT29yYLkl5bFtXN/gCO
	 0XFE1Bw5CiZ69kjCsNx8rG4bG62kD1HAuyO/GRouf/onwbHfgxA3STBVdnIWdu0baTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nFEfZnQ59TpCZnJvhgBJzEp+yfYh6wGlCUPMkB3MYBc=;
	b=3I0OZTZDW52INDGaZjEqn3BqzOpaaF/VBhbeLiCxYgrkSbNqYPRPY30W1m83gzlqv1My
	 069R+S5gjqwmxUGRONRF6/0BkLYVs4azv0zJUrf4YSwL6PTZUjmqOWQwOk1KTpBmBCxrD
	 jlyKjJ4OhijTUpEqvgA7xHRJU6bkppPtWIO3wPwrr/Ojj7mfQVbnoEspQkdqQtyIVnDtq
	 BhjbczdO958xVRmtDbdVNHneXzOcNQyYsEl6cA7XJxUOHiyLAXrhMQERa7kDw4dpnevuq
	 ZncNSChHAwu5khpw8JP93BsSzfPmIgYb7sPW2EH5ohhLskjmeBe3gxCTDIQymSvKc/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RjLQz0ze;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0CD606A333
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D0CD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RjLQz0ze
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso485694a12.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197132; x=1793801932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nFEfZnQ59TpCZnJvhgBJzEp+yfYh6wGlCUPMkB3MYBc=;
        b=RjLQz0zek60zgNWMOUzt+E2a1xXdBEOiVCxWA/FFoRh3FoUS4+hOiT2HP3gcy8Kvux
         PrLGVghaH9/X5IesZxXXelQwMBw23TpKdfAm5H5CNTED6rtMXS+MDaFBoWDcEriTyU3X
         421a2sdHC6BR37TyAyTU1M26ctJlzFHYvxKFbVxnoaER08bJLunZh9kh3b/UY+IjdsFU
         DmrPpA2BejTH1SQtFJYaUTx43Wre9yYyVqDjcLyp3PH58lMGu1ve46GKjhzXVXJg9pGj
         PuhME+NL8nnXJW/SI/NbjncgvmKw4C3+eKf9NogEbuvwpeYA430D9zLKqfjca6lcV5AW
         mAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197132; x=1793801932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nFEfZnQ59TpCZnJvhgBJzEp+yfYh6wGlCUPMkB3MYBc=;
        b=Nz+NB42k9+hqTIZxyK5VtcI2D29gwKOp5nUJ5UF1t8x/Dwb77pGUg184X2BhNit1F4
         ENlcDb66shFDNea/iSq+23t13S9tIcvNKWvsvHhx5laC+8ULh3+1ODJH6LheGhCKrOXZ
         tENS/ytk1jm8dzAkysbkhnRoUK5uwrNrpYNyw15T7gO97vfsERIjbbqvCFTvGAsOhPTE
         xnB+pbqkZp92rFWX9wFvznCZe/EDslf8oe4TRbJ5PPNGMSNzaUTl3oPIX1BaGEDFk7Ks
         pNOsiGr4hh1CSisX8Miqv+tvvIHOFy7z8AUCpGqhxiU7a8BQuiQ4WWm7UmlEYLDx96Of
         K16Q==
X-Forwarded-Encrypted: i=1; AKwUvBz9GIwQ9r0MtGA27C350HCzuW/6xcn5/Uk39avegr/2NoGosrrxGzEuO0/UXlQiA8JiDdanUnU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0ixJQ3I6d4JRFH0BAueOWJuYFixa15pT4ZeYe2YifzoyreNHT
	Q+rpCbXeKyRfK0c1ITtyqAGfgNRK+xw+iAu5LzvTS+W1FLqFlVwWtNYv
X-Gm-Gg: AYBFou1I/V5YzZpUM5J3Usm1Kx2vYloeQX5o6y8g9ptJf0Y7Z4iWCE9Wci3exgVDC0I
	QFbxa5VqBpDCU7Q7mhsAU2kyuTroL1thFbL4BMTYMWhcxprOR2Yo7Kiah6bI+V91Ap1ItaCxmFp
	VFV6tpTZ2wAAZ+cceo9260ichuu42LIUPDXNdjofvIvKJv6iwy2N6X2S7xxkrT5tlJAvbOYQs3I
	qS1htbhz4wI3WiDkNWEtp2i4q885Ri7OQWvZ+zto8XO7JrJ6/w4e1fNLJ2DXhc8FUbv9OKSjLki
	CmFdSll/1Vf2czLLtxHVycBuJK0wPMEa8T46AjBMyfxzueenUItvH1rGwFRoCsWtIdOgmWFiOWW
	XJ0OrdOnTnOcvw10LEQ2smiU5qOBMjfZywbSBkskiYuSFVkrC8UhaJRDP21jUv+bMtfJ88ECGJG
	mRHdNGTkxf7t1+TIOXOYdz+NPJ6N5Iq7eoSSGeGXYpHA+nHWEGdrpv8S+4qpsdrNW2tqyjXY8c/
	iK9T184tKC+hAXpZiHlhepAmuMl9DTACPlLXg/qGkPsh3G7DpN8KeOtS/X+IBTcvsfCBKQSzQT8
	CdZloipFWfUxMWTyNp7F5SjreE+lWDGDf7KdnvHoxJZP7TwNjUa6xW8BlD7ThxpZ67BH
X-Received: by 2002:a17:90b:2fcd:b0:39d:efa9:cd1a with SMTP id 98e67ed59e1d1-3ae57e07d0cmr1867914a91.4.1793197132116;
        Wed, 28 Oct 2026 07:18:52 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a0482e9sm3437223a91.0.2026.10.28.07.18.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:18:51 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Linmao Li <lilinmao@kylinos.cn>,
	Kees Cook <kees+treewide@kernel.org>,
	Rosen Penev <rosenp@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] wifi: nxpwifi: stop AP TX after preparing channel switch
Date: Wed, 28 Oct 2026 22:18:17 +0800
Message-ID: <20261028141819.7556-3-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028141819.7556-1-enderaoelyther@gmail.com>
References: <20261028141819.7556-1-enderaoelyther@gmail.com>
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

A channel-switch request can leave AP traffic stopped if installing the
CSA management IEs fails or the driver's work wrapper refuses the request.
The driver disables carrier and the TX queues before programming the IEs,
and the wrapper silently drops work during removal, command timeout or
suspend.

Prepare the CSA IEs before stopping traffic. Queue the switch directly
with wiphy_delayed_work_queue(), since the driver's wrapper can silently
discard it after the IEs are installed and traffic is stopped. The wiphy
mutex serializes the callback and worker with AP-stop cancellation.

LLM assistance was used to find the bug and review.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. Not
reproduced; IW61x hardware was unavailable.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 drivers/net/wireless/nxp/nxpwifi/cfg80211.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfg80211.c b/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
index 384ba69dd058..0f7720df0304 100644
--- a/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
+++ b/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
@@ -3115,12 +3115,6 @@ nxpwifi_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
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
@@ -3137,11 +3131,16 @@ nxpwifi_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(&priv->ap_update_info.beacon, &params->beacon_after,
 	       sizeof(priv->ap_update_info.beacon));
 
+	if (params->block_tx) {
+		netif_carrier_off(priv->netdev);
+		nxpwifi_stop_net_dev_queue(priv->netdev, priv->adapter);
+		priv->uap_stop_tx = true;
+	}
+
 	chsw_msec = max(params->count * priv->bss_cfg.beacon_period, 100);
 
-	nxpwifi_queue_delayed_wiphy_work(priv->adapter,
-					 &priv->dfs_chan_sw_work,
-					 msecs_to_jiffies(chsw_msec));
+	wiphy_delayed_work_queue(wiphy, &priv->dfs_chan_sw_work,
+				 msecs_to_jiffies(chsw_msec));
 
 done:
 	return ret;
-- 
2.56.0

