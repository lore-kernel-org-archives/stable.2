Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7F47427A
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120672; cv=none; b=i6y0ZitnZkWhGAAvrvj+M1YdgOYJwNvtVYw8waLSP+TsV2zPRKnOASu2b4jCP6xeA302jwS806z4kX6lix7BjM9t15njgWg30BK+mdPuLzf2oiWfete6N5jcJReum8rOrKSfvgbOyyqdvPDQ3s91GUUfnNIDhdGsLPQ8200vNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120672; c=relaxed/simple;
	bh=W2vPaAvbBFaEnI5PS+wWp9fGPFM0lRF90ZCyeiQzTGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4uYo8YAe0jQRJlQk40MiY9WE/fFpx1M4PR7KxOCTjPM0TkuWBQE7T+kNNO8gb/zxJa54iI5iUcSN280P7Rio2BpKxSa5DVVg/VzgkHKjSsHhTOe3rIProgj6s4fk2kkBp92y8xVSOYMoRF97Hkc0Q229slA1GHKvjk4p706oY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHt8Ax+q; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHt8Ax+q"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4a475bd9ff7so482288b6e.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786120668; x=1786725468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RYnU/CjNnSldiurArBMef+rqNUycTmCsidAIhbgMp9k=;
        b=DHt8Ax+qYqOHOoWvUdhpnMRIVBkxqKnIdxQ7tdmDFFySm92vEYggSVFloJb/tidux3
         ihfnuTzADaYMF8ARHfD7yLJQc/zGABeW9XSe3wqDRjJYcNWtxc0sg2YOl/NIeQXQX//j
         xpL5dtDkGx30iuT1TqxEBqSBC7BmTHNaUssGxVHSGdgEArDQmwxPWSXvwkFI1iXwkExX
         46imgyIpN6Ydo4Qcl5JGxO1kYfg4wqkU5tivfMIvvaUj1/R9lgBKiv6Acc/sfwY0v1Dz
         FxJQV3pioqK1KMH1eQaV1WaNp6oDUD55dxqSYz5njHMeZfzpr7JsdjxwH4owbGWpiT4w
         Jdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786120668; x=1786725468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RYnU/CjNnSldiurArBMef+rqNUycTmCsidAIhbgMp9k=;
        b=ESR1D6XsJo1SDWNGwHixQjxw86yAM5bBI8pz9cp/nc7dulbN6HM/AQuueNSOH60zd7
         urcyTkMsD/4LrrT3Kb2rbQymLNJCkR+r2Nx0wFF0jioqxFWQCcbu/4a0+hw3NmvvqDFW
         ufvNUwVs7dKdMwirHbHrtOW//IvPCCsVwDUYObasuY9/rGrRcEVF6XCuUoh+oKqRrOdG
         ybqZyDinkcZx1a1Bkok8bL/M5NFe2QmGJmnzZb9UCMHTx3nLwMKXTzzorsMU/mDwzSbH
         wWFhv/EorCcSTG0zG/o2QlWd8gCkDgnCiAE8KH0ysyRJkAM3dPmQg8wKpXXqX2tiK6+l
         NAfg==
X-Forwarded-Encrypted: i=1; AHgh+RppuTzt2bLqZ13OcPPyiEj4ONp+H2sgN6s+M11vA8Ngy+rE8eLYzd6rMGEUIHMkDzdyBOl4cZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0B/bw3W/ESK2o83ldNytX3zh7dvfOqPZ/ejWl1FA5juB/lvg
	0mjX+pJZ+S5pypzGuKgV2cqXuX7mSfYOpF3IkqbS3j3MlEju0PDgblo/
X-Gm-Gg: AR+sD13656XmwNf4OYTR6Xz1XnnOMs2tUWJmxT1i/SwrJqqgl+/KBqZF12WOPy/QFdJ
	nb0nky7BOgN9TnAsWM/e1TrkA5/r15ydGeimb0dUr347366dNs4mD/5fJD2l9WqMq3Zm9Zzuym6
	+uPfyWFwVWpgd9cc5KNwXkJ8AP2o7TgeIkQXVGcIquYZhFusdGyyQ1HpQ21uYCeiybZjJfSLdjn
	ReU+lq7l8msGHr40YnFXSlc3vGoXbpBs1F+twBWYxTVcV+cQ41gnWm1kTrUMUTCfKTwDrjCAbrC
	GUh91PezKl0RhIgwA28MhtcSMqizgkmyhCIFIUrBSJE0EA5xpq/kzopBA/QICuIj7KQAkQ6q4Tj
	JEPQrBMjB+MjRpfiUCwqUa+W+FdWjPrWEcWlBlcdH6u2TGzcQlfwRDoArSn2sGmdUHesTf/pwPY
	cJR1kQMmmzCKSj9MUjbXqRRGGqF8dBheufNQkfBYHtx2x4Q3dj+Up4R1AdokrGu2pDF6HMhANgf
	STW/DsA/8TmaEphSx4vw0yritLIBDFX3eL/NzwV1lZDYVuXnS4MtodcejgxWm8=
X-Received: by 2002:a05:6808:13c2:b0:495:d9fc:238a with SMTP id 5614622812f47-4afae30e48cmr8312577b6e.3.1786120667910;
        Fri, 07 Aug 2026 09:37:47 -0700 (PDT)
Received: from antares ([149.88.25.215])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae769393sm7731773b6e.16.2026.08.07.09.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:37:47 -0700 (PDT)
From: Bogdan Nicolae <bogdan.nicolae@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6] wifi: brcmfmac: cyw: pass PMKID to firmware if present
Date: Fri,  7 Aug 2026 11:34:18 -0500
Message-ID: <20260807163418.487508-1-bogdan.nicolae@gmail.com>
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
v6: Fixed diff line number
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
@@ -208,6 +208,9 @@ brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
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
