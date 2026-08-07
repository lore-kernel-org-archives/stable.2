Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02829325495
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073142; cv=none; b=C7gvaH7QpLs7t+c7Q/t/13amU7z2owCGF4iImPBFhgvGyco5UINRaun2siyIG+eXJHbatbwSlNJP0UKnJCYVJ7fgWGDq0qTQLPf5/Cztd8i9DWKSmmb2ZQtdtdCh5n7qTlypEfyE1Lq018FAJlYZy5Lf1Cp4xzbasoWZ6BURlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073142; c=relaxed/simple;
	bh=5DWHTyV/pH+3MdDwtmbB7rkHS/t6yPLT6Xj+jVdd9cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qpJhGW9jf6FunCaLZoWfijMYUZl5seIOGohprXG1UYIjeLwDZWHIq4GB/G53GCIu/17LbjmkKvs8L9Dd9iWwgWStC2j5qa9ykSSTw/WuFZngLHWCSTt1sS+AzMRaMsAZWJsffknLdxdnHuW0kFiA7htdRSiZg3FU5Z6c9VCjm70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmlVLwZn; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmlVLwZn"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ec6815f0f8so436488a34.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 20:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786073140; x=1786677940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1+6XE7Yc3wed4LEk38MwpLFA21L8FO91QUtlY5oe2OY=;
        b=XmlVLwZnH3GVLX7Qa71gCGaXQGrasc2svQM5rm07SFiO7TmbuoaA+FSl992Lx8DYuE
         DQdY6JGm66x0MkxNJ7iJoJyM+njYCuGaEYcXuzejPhh+nhXwWb+oX+pQ1IuEN+gzua61
         EATV4NHjC4tSc4kr1YPveYGRO1xus6kfWKbeZYkIV9s2CvSa08zP8XuI1Au557P7okS6
         4w+88GRSLztxXrQYupvLu2YabXUgVW70OZyl22bcsTGc1mtBVhiBFKlAwZ4L7/H2wHw9
         XVBoBCgx1kKrWdn/5IdusxCSFFy1Jj1qYJPFuA/FhVhfpxp4aW/keQDoew8u24mXEF9A
         tZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786073140; x=1786677940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1+6XE7Yc3wed4LEk38MwpLFA21L8FO91QUtlY5oe2OY=;
        b=oQUh8rZtcmW3tSCBN2Drrk3wkBc/hj/GrABYDlZBfTpwxV0dWgwJtpr6S1PTGDexi6
         cCI+7DUhGa2262BOjLOmZpup1nPQyikVsetKeXMdQvSSgwvsJchNG7toh7iu4BFdZy0U
         qM2wSQoc9SwUc+FrwP66kf1TPw+nZPHm5n5jVALdgbK1wR7DxPiYs22q4H++EYAPiF1j
         LuyqrUAqhWOVE0v9dCA84ekMWlb8TtrmiEgOkCTVlCGU7fR73Byln4Yo4E4nD8tLXZb7
         Xn1SfgesYhZnluS/zCyQx+KXlMbbBFdN5DOHTt/2FXld+agBbQEeydrqdUL/xgNwu+5k
         SmBA==
X-Forwarded-Encrypted: i=1; AHgh+RrHtf7HWhhoNEe/ogetCe2uwEE1J10fc3rg5Spml+cmHzt6vB62PrhAiK5/VABwPXOMnLPZdw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4iOB76WXvldTQgawMCC3b/CGUJ2H/Jwbi0vzB3xpgpQ3k/Xy4
	xJt3s1Oqq1M2herdX7s56jAkHC8wHj5Ids5pW6t7cE720WhFG+gCcK74
X-Gm-Gg: AR+sD11NRoOFtZDYchEzwrdg0UG5BDh7wl3Z53npiPP0+j2JAJZeA0KYqG3RhieGIVM
	hYosh++nyVfde3cZqj2PLdubf245rSvaAHhrU3cG9eJWszDzZbh962mOxmjj0avpLDi8XoPeaKH
	KEovcwQhlf9x0+CyhGtxYnMP59L0eO5kJ+SfloixroGV3eFjCIs4WNk+Hn9IpNHxwrzZm0w5PAk
	zAQK1/2If+9ICbzRsXRKfSfCh594hWzBEoCNrdFOui2c2eLSxCwpJczdTqZss+Xj7K+bQNbujsW
	9HkIenxr4JrWl7UUJHAeJiFynce2WjlosmP1XnUQ8UwUveHJJtoeFioXP6TEKco/DwnHkB1gNVn
	lsCQLsJHer2aZj4Paa3XNPk/Wkiee5LTTr/6I4GQI14VMlPbThaZvOZ6HXRbB85iqv/ZMxjmv0l
	UIouqgqoSRMGFQcOe+SKnbwl91g4Llgj7QVV1J06RHxCd8kt1UyKlQHxg0pm2RgVUh+ng2y6sc0
	xeAmTCB/X5eCr8Ar8XPESSny54YciOqbrmmarWQOrNOtbJYgEmVFtUgYYvFfZZdfesyU/8hrQ==
X-Received: by 2002:a05:6830:8d1:b0:7dc:d6b1:48b7 with SMTP id 46e09a7af769-7f1e5c6e96amr7295657a34.1.1786073139763;
        Thu, 06 Aug 2026 20:25:39 -0700 (PDT)
Received: from antares ([149.88.25.215])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b563b04sm405786a34.6.2026.08.06.20.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:25:39 -0700 (PDT)
From: Bogdan Nicolae <bogdan.nicolae@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5] wifi: brcmfmac: cyw: pass PMKID to firmware if present
Date: Thu,  6 Aug 2026 22:22:09 -0500
Message-ID: <20260807032209.447044-1-bogdan.nicolae@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zero out auth_status on initialization. Otherwise, garbage will
leak from the stack to the firmware (when ssid is less than 32 bytes
and/or when params->pmkid is set). Then, pass the params->pmkid to the
firmware (without it, the firmware caches a garbage PMKID on successful
authentication and denies a subsequent association request that includes
the PMKID).

Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
Signed-off-by: Bogdan Nicolae <bogdan.nicolae@gmail.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
v5: Fixed line length > 80 chars
v4: Fixed indentation
v3: Added Fixes, Cc: stable, and Acked-by tags
v2: Split into a separate patch

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index 873754be5..2c59b5e57 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -200,7 +200,7 @@ brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct brcmf_if *ifp;
 	struct brcmf_pub *drvr;
-	struct brcmf_auth_req_status_le auth_status;
+	struct brcmf_auth_req_status_le auth_status = {};
 	int ret = 0;
 
 	brcmf_dbg(TRACE, "Enter\n");
@@ -208,6 +208,8 @@ brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
 	ifp = netdev_priv(dev);
 	drvr = ifp->drvr;
 	if (params->status == WLAN_STATUS_SUCCESS) {
+		if (params->pmkid)
+			memcpy(auth_status.pmkid, params->pmkid,
+			       WLAN_PMKID_LEN);
 		auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_SUCCESS);
 	} else {
 		bphy_err(drvr, "External authentication failed: status=%d\n",
--
2.55.0
