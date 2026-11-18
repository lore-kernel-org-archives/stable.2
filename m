Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026940;
	b=FIl7QJTptEsHy2uY1qkcXpOqPu8PPe2GCnoRVNmAibFvL14vaNlJf6dOue59RpZZNfJk
	 QDDkoYEWFwWU/IJ0Ci0W0mtGcCRuBHZRmeFNg1zQclHoPUZKFJYfYN+VP+4fJN5t8inEs
	 ApQtBX2CXqcNn1zgrLZmIV6260qy9yfyt67Z7bHDT0tEYRM2VqOKlOAG480wK/MWOZdXT
	 BHBwhAUrl83Bmrg8UX5uzA0GqM6gXFLCF/iIDTCyAmBYFQvJZI4kIZ6nUETSskhHGKohT
	 4J/GzllN+lS+DbjU5IwxPkN7kKITa6Ifh2mIPGvd3lTIBJixKFwwR7sPPgN4k8Buteg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=L5wbkUZYtMNXPJXdaccMgVd27DQ+KICM3eePhOc5nqU=;
	b=H4sJypsUFeiBCY2BRBssCcp7YeQ/2z/M1VqwKA2h4xRqcQ9O5UdtfhsA74vfjtSJ2GoB
	 61U3uCnbHsS2WVXmgXMXFl7or6eCqOpg7g7BipdtbsMXzEg72xVF7N7oI19u31r5TJCtq
	 J74Gkko9nrLxF0UUqEhM8tVYBaf2/yg6iAPnGCWdgpF+KH5kO8r1RW1Yr3XCu/6Lmp2u8
	 zIlepHg8MbAZgWyEYEWle3upXkbtqkpU0DzfVsTBmTPM7+TCJdUAQmyhIW0t80WZ/GNVq
	 XmwkXvQoKz7U01kAOxHnWRoaLXTm1N2TAu7hG2FZJ7WYS2dtt0S2HP15apCMHmT1SHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owPzAo5C;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BC4606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06BC4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owPzAo5C
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1965025eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795026939; x=1795631739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L5wbkUZYtMNXPJXdaccMgVd27DQ+KICM3eePhOc5nqU=;
        b=owPzAo5Cg0da6pCBa733ICnomz11iMfsff7eGNc8Eisr8s6IdYXTrGUM3bfW+dZ4lM
         UqXDChlXfUlvUtAf62HTR+6ncUKr/qBFoBYP0nkdHXjXjEZMbZlVfT5+T9AcRrODbjG9
         EoUNb9yqsDIFLHJTFByntpYJ8xTknG+QjnU3Z1L2NW+9ROpqVKZ5J9RKiF/ypswAO3u3
         rgb9641P84uBfjfbHb0ZQ9wsaFY/qNo8gUq4taChL/Gd5lUae9LylZeL7IorzcvEkrhH
         ZSIdOMqn624WMxXwxlkSGvAi5WHzVkY6Ks8Q+q7xMRcWsUxDd+nX5CarADj2HMOHpxVM
         eNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795026939; x=1795631739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L5wbkUZYtMNXPJXdaccMgVd27DQ+KICM3eePhOc5nqU=;
        b=YgQmquUHeQECoYomWA00YbwRJJu4QWt4ABcneL4DUZBbsTogJ2Kmf2C7pyqBAMsdSg
         MLq/vQySLrwqEt6bf/VOaB6YLFyoAQO7qDyzZNYaybAQ0QlYSd24UNedR6Ml8zEi4Hq2
         dm/8MQ8ih7GomrxMYCllW31qKCN5JHZzKfoERzJxOsKQQWxnqqVD5T5s4Dqplw/YxfPy
         KMbGX5V/GUiZvl0vyp03mwI8iSHzUkrOqbb0147Rkj3ykvCu1NRpRdBtEkxUzcPxYEV0
         0bl7ySvqFo5nCrfCVYcZ3IqsKyaBHd33Z0b1py5Az38I0yAWIcFURWzF/b7dwjU+sZQT
         NWUA==
X-Forwarded-Encrypted: i=1; AL+hErH8LrzL10FokE2PymAXRwhamwbegP+wYFAABpQs459DUpWiE4ICJudYlGyJdKd/RPew9NS6bWM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0FXZRaZra29GBXyUE2eAUByV7QGJHYCbqe6CJ3ADcKgVLbZNi
	z489mClDhvAhe+/Y3RYGbC1G5eSa1yQCeD682hCW0gzS9w1+9rOwsNIC
X-Gm-Gg: AYBFou3Hj+VcLynozxqST2NQcFP3hDyjlY9i2fJRzVFGpenRz7s9xt1KxtzbKsus7t7
	PsmSS9LIkMq+GcBK+FRqqBowqVUmQCa20hr44Ecd8Xzq6vVXdROlSQBBipEEDcBRwlGh6pUJ5bg
	nNk56y+nxOnRNeJgIAX/68C0/jfTdVDIHIuOb59GKsHyX18KZ0vy/RRIlvEOzUih56i8h49J0Oz
	WKuFxWn8oRy/MAVTW9dj3P9AT+aXTXP4Sz8sfinWndjUv1gemeCqQZeoGMOwqUcMGFi80lfL0AJ
	A2I+e0z2ZcVgZeBlrcB1XugRX2jIzb5aNMycDd2h3RKiCp59KRGcCluxisYLedUI05VHsByUkz4
	/M+HaHufOk4grX0Bovvo91mpfX4P9JNgptEHU0KlX+4y9W1mjZqBitbWDkm4zS6Yi+B7u3b3ZGZ
	arGGpNYdckOIsg5rguiKDEoPtYxPqFJTFaiYLlKIDppm7EbmBeclePw36P0olCZ4GCaHqk6KOck
	CjeWmLAijiFvPKUyGsK3f9e+1cEc2Gr/fUvVO2AUTHm+IYlzgTwH6WPwCHkVXD5x6Yi/IOlJsVv
	6dPWpzvYI7ElVpqURp7zRbmN3CLenqMB2zeqC4hqB6pYiNhhZA==
X-Received: by 2002:a05:7301:d816:10b0:380:fd90:e660 with SMTP id 5a478bee46e88-382815240efmr3105334eec.14.1795026938437;
        Wed, 18 Nov 2026 10:35:38 -0800 (PST)
Received: from G7XWH7K1F3 ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45274aesm10450189eec.2.2026.11.18.10.35.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 10:35:37 -0800 (PST)
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
Subject: [PATCH wireless v2 1/4] wifi: nxpwifi: cancel channel switch work on teardown
Date: Thu, 19 Nov 2026 02:35:03 +0800
Message-ID: <20261118183506.45749-2-enderaoelyther@gmail.com>
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

Stopping an AP while channel-switch work is pending leaves the delayed
work armed, and the callback later runs on an AP that is gone, or on
freed driver state after removal.

Cancel the work when the AP stops, and clear uap_stop_tx, which a
pending switch with block_tx has set. Interface deletion, type changes
and driver removal all stop a running AP first.

Found by code review. Compile-tested with W=1.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
No new W=1, sparse or smatch warnings.

AI assistance was used.

 drivers/net/wireless/nxp/nxpwifi/cfg80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfg80211.c b/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
index ba54078b082c..5b8fb37c3f3d 100644
--- a/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
+++ b/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
@@ -1639,6 +1639,8 @@ static int nxpwifi_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
 	int ret;
 
+	wiphy_delayed_work_cancel(wiphy, &priv->dfs_chan_sw_work);
+	priv->uap_stop_tx = false;
 	nxpwifi_abort_cac(priv);
 
 	if (nxpwifi_del_mgmt_ies(priv))
-- 
2.56.1

