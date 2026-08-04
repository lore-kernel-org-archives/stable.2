Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6A1E1DF0
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785819219; cv=none; b=rSzndj5KTWnMw/haRp6xrx9MOpmyTs18xFcFR1P6+lRelfHOKwTo0kWqfcjZATiYzN/nPhPOLRGg4JjB7Vm7pKWDF/UQFtGJ12GmeVX77L02jZiPbB+eQpDL6yBynDaS9g+pAQNSuVZTNFeSPrsam+NcyDC84/e4Nx9fb7CJ3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785819219; c=relaxed/simple;
	bh=nNrXpTS5p3MeaHobweXT5nADo9ur62gwlp1t4Onq0Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iei2wPwYEawHO/gzXFYDlzLORXt3lwY8ziM9Ukxri9pKP3A1n4SgXwxmNqpixzlKrO73mK5TKVrLqz23hMupK33jIhJsWjNhAuN3PsTlpc9+VJ6Tb8kGpO7IVCpEHeMWUEMWugoMhrZqy+t7sjefcODSg4L1jRgm0WTLsJ1gXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/u4ikFp; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/u4ikFp"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-451fe9bf738so472271fac.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 21:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785819215; x=1786424015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ePP/FGrYS9KwAO8eWsNAP5nnVVIQOzeomHwBJLzdcl0=;
        b=N/u4ikFpw9hMmYa/VlrF2Wb4szgW8bEccUZ7e9U9yejQtrkkNaGC8VtrNzqtCruZuc
         QyFP0rU5Wjc8RdGKHxzQzjkloKYZMQ92VVy/Kg5ZjAiQmN2zuWZcCcbKTMLS3D9DcKcW
         rFc4Y7w6BY1H5yUKKP2a3Gj27hagFZ4iiVlIqlFFt9Xj9bJ6cbAA6ZfpkSbuJ5h1coe1
         +sQPYyvGXHuWj58SUlALAxs6GrBZTqZbPQItOLzS4CDHY3306Yv8sQftVrt82MfWJkrT
         XLExprCO2t6QjmYudnrFrlNykN9I8lXrUjseGRaPBGg5vFEq25YZTqMyVQapc5fL76Wm
         FHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785819215; x=1786424015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ePP/FGrYS9KwAO8eWsNAP5nnVVIQOzeomHwBJLzdcl0=;
        b=diI2hmjkUm22RJoEioMBi1YWQV32m5CJLle9zVMIcO1T9uXMznfdgMsS3R6Im43HRK
         AyPdq2GWz3YVIRuXpdJQzhQ7iHXoeYscxCWA49+POvC+BTVIbNWFSrAlndTG9r2+2mfy
         uRBMAPUKWiTM1CE+l7UsAUVoURMbehArD8ZLkkBvFev095ql5C/YgChv+5whTRp6Roge
         tAXRf/QcbF6VmzUYzu1ZXX0pRGyYaCskQoe2Hro8WlRXcPbWhepQ+1eixljiHf59TXdK
         jvWPZyOAAwGpLnbLHv7XrKeOsKSiGWOdahJ3kaUOVS0Kwj8MK9Lfo1lKrEi9SB5kya+J
         G0uA==
X-Forwarded-Encrypted: i=1; AHgh+RoPMY+NOq8+AHX+FAKE8YxmHSotJtFa1qxhgf8etqw7zXjrc0DYPznRDHzVkL1x28r2BOpJ6M0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iUjWu1YakBKOg96a3U8S7tPwGU5oY//vw1ZMPc+2/rGMg1/4
	0TaDHBRoe8geHsRbzeT9Jx7Tie4FjFrmm+w1wlalCuTfGoHkAnOwGzk8
X-Gm-Gg: AR+sD13jrwbaHRL7avCY8wHneUK0nk62rRpKcTmf3NrE25+3X5763gTMObps1fcMe6S
	kuFNE3CuDUtsAGjaVRXPbbm+1GPqfQoQsAiVDGTNBZLetddCi9/BNuFkEt7uReaYA7pDJukgS60
	yqst+GcGV6k+XhKR0JAhzcCKT1ir5akMvxlGl+I8mWfaprnPteyT6GAN0HdyBb3TUG7c/tjlgyD
	mG26z1Z8Ou0+ZhE09+kXN57IRyQ84KhCbrkbUL6EAGrDRKS+jK8MrxXFyJdeaIjwJxt3tZnp66l
	4znfB555UvcTVzmAe97hKkdwtlr5Tc479CGfsi/l4osblCyS9gLwGFbvNCfbIwiHz+Inxw4aniO
	zSG/N0eiZHof2cZg+RWG64wdB0sSM/gU1n1OKnfielv3hFmzc3j3RPbbresOxpBZ7yU+l+vZJrO
	u5COZoS+r3fXcHSDTD0JbwvkupeRZB8BgohGLnQ8iJiuI0eGGjIyRs8dzY6oTGfu2H8jdbup7tJ
	a02782G6SCRDZvpM7kQdI41GPaIyqc+XlpM5W5NfYCOhSH3+Fpfn1Qhc/9EMJk=
X-Received: by 2002:a05:6830:6a93:b0:7e9:e16c:d3d1 with SMTP id 46e09a7af769-7f196ef5898mr12750388a34.2.1785819215381;
        Mon, 03 Aug 2026 21:53:35 -0700 (PDT)
Received: from antares ([149.88.25.215])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3e926sm9058333a34.1.2026.08.03.21.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:53:34 -0700 (PDT)
From: Bogdan Nicolae <bogdan.nicolae@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] wifi: brcmfmac: cyw: pass PMKID to firmware if present
Date: Mon,  3 Aug 2026 23:47:08 -0500
Message-ID: <20260804044708.402133-1-bogdan.nicolae@gmail.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Bogdan Nicolae <bogdan.nicolae@gmail.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
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
+			memcpy(auth_status.pmkid, params->pmkid, WLAN_PMKID_LEN);
	auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_SUCCESS);
    } else {
	bphy_err(drvr, "External authentication failed: status=%d\n",
--
2.55.0
