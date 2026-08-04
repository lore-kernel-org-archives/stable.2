Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62E40DB5A
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823952; cv=none; b=jG4H+XNRwyInK7mMl5INHV0wL771W9DhDfPuy9zJmvEew+EjsrIuw0a+Cv/R4QXYM7OtuyPGz3StGoNzemSM0rfylu8a9d3m2KsiP5UVPfxovjrOVU6D8+tU6WxKOgDlxFdASbHmk0CFQ97qWhUkpwg37KsabksMqIeg83mG3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823952; c=relaxed/simple;
	bh=K5Ph9XcyqOYkIasx02lR7AFxCwUH0dmM/cCvoQIHRKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+1pN0Y0S0zJ8Dr7TrUzgne2YNMJhSDc42l185IspqyQK+/71T12o4e05w3XvRmIVmTDVlR+7HAogsF1fnC/fyebRQxxyYy9qdUNvizO0ZOeOwboB5x1hL3Cq4IqZzHkTfZ309qkq3r1xAmN+TlPF26d6wX38j6bay3WFaDckY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT4p7sUZ; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT4p7sUZ"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-49da0c3a1d9so510589b6e.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 23:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785823950; x=1786428750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lLnrl7cvfXhXnP0TWy+i62c7ISWemwc6cOZstir8oEI=;
        b=gT4p7sUZvuSsh9OotrRHNVX2EjaglX+SdQVFp0IVMq6A0q4T0j0ZrMrHSYg425g4MG
         Z2qAERqDZMbFvk4TFCCuIC4Tk8x13jp8iZPAbsQPy0tvdhtszjgWHBS8hz6Od3e56V4R
         wB17X5EpOPF4pcl10QmBK3VVUgfWZS6M4YJe+k5gRSUHUA4gxUVj9xB5XvAi8Os1n002
         ClfygzJmaG5heyKftdIqQWqWSfaoPprNx8+fHLLgPZ7Z3SqrSOqLpa6poZhLs5pkXDP3
         ULPUHfXJfck02dQ9UfeJUtPmk+A0NO80uFc50ywPevTrODBwGvtapeWeRKBHfk0IsDjv
         6kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823950; x=1786428750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lLnrl7cvfXhXnP0TWy+i62c7ISWemwc6cOZstir8oEI=;
        b=g1tGOASWQmnkzX1nwu6DYNc8Q5LBV8DSuatSN8OsA3bOcV0aruDuoBT0LKvXWkc8OF
         0G3+FpIMP3qHJavwpLA143qZ/5RREnECZxSDFC3gS82+YeVmbykmQmIZ+GfMXWZSYWHd
         tZRcF4RYYYJj1XXbYKS5zIY9d+iF4fZ803QP33xcnaJ9+u41UQJkseqWoNohBg4bhxj4
         bFUOkWaaoZMSaDdlKS8s18tUrn2LDmQsahRHxN5oYipwXRbs7LucD3lVs/i7A0/GrEvJ
         oM56biStADbNtxIpka9/P6r5/1RbkATzMvrJuVuTQO8tiWKctjxyiYX/DOrV+Cx8esBH
         Kfrg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9v5NadxIhOHr9WqfwlWHEdsuKXjGk7/ZVdS78lz58mutT8FplN45oAGehZHkkwy530hrFg+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAj0IZuohZHNdsB8T9x9uRJlwl4ZIhkRFk+uk9FsTXG4eBsj61
	lkD5hP2nLzuZNLCw4U5CXHDFbjGXWmWwT4RV/biTPrMAt1sS1wexT519
X-Gm-Gg: AR+sD13cOuzqoB8unOr55ZhhZDlSo1G3d+Uc8DhHi19227JAInSYRYNNnlILbqrW9ww
	p+YCKQzaUG9iOCHQi57johmJp9cgLKIp68kl1mMtFSfgdST2pgtlzUgwfbaecT9Yicmogp72zgu
	PApoEskFMRSMEbEgaD3vj4q+EOlHIdFPt4PsamDcYD+7IIdEMKHTVDzIHGQwsNVUeZ+n9TTKuJH
	nBGmoez/sBf0rhYP583fStUgujmZhcEJcbgmyDuaZkFlZAG9+NFhfkamc4f6P4n3N9eWtCzVujq
	/W0d6nqn7pBw9e0g82HV1xxOrKi9wFf+Gt1yL17G2nbD1XF5X76SHmsNJp8VR28noBC89BdD5iN
	luCkUo4dIvVP+Z+BszkpvxCFeLNCW+5V16okGFsr/ixjWDV0CvnwTTqvKp9wWfWNo5WtYSkDA7m
	+nD7wEWobqxlxaHjVQl0kBQptfYuKEhDtCHrcpvIIK/8e5ro6W2QGjDsqJ/jItNjZJLgAkfH6sD
	JK0LUUhVGo7jv4q+l6xEIFacYImdZLk38TER6EiO+XOHxKl695HrFsZs8f2DRw=
X-Received: by 2002:a05:6808:1387:b0:495:ac16:7afa with SMTP id 5614622812f47-4af5e3740eamr13419377b6e.4.1785823949634;
        Mon, 03 Aug 2026 23:12:29 -0700 (PDT)
Received: from antares ([149.88.25.215])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58d11372sm7918032b6e.7.2026.08.03.23.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 23:12:27 -0700 (PDT)
From: Bogdan Nicolae <bogdan.nicolae@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] wifi: brcmfmac: cyw: pass PMKID to firmware if present
Date: Tue,  4 Aug 2026 01:08:59 -0500
Message-ID: <20260804060859.412348-1-bogdan.nicolae@gmail.com>
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
+			memcpy(auth_status.pmkid, params->pmkid, WLAN_PMKID_LEN);
 		auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_SUCCESS);
 	} else {
 		bphy_err(drvr, "External authentication failed: status=%d\n",
-- 
2.55.0
