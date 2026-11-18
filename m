Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987888;
	b=EOCEZdjjVGQjNHvAbzCeLN30xz54P4JszM7d4QuXB2v2qUhwA3FUpdumghEBYkwFn43c
	 JMODLnIJbSzyT1jcoauVM5Wp2OUkz/omF6Vr8hH4zeMDqol0GAHLbvQLX1Ci/rbYgCdu6
	 Hrc4EmONXF9oE4YBvi0QRwW7TeBjBzu+VwVWQBiewFpwlEhbyBztb1mcpT8WcWjcxdUwO
	 Uzdm8QICBn33ehph6hBlNkLAiNS6ohY7IQYQA/FT8AAIXYOLs7qzh59ypWNpbDoVxae2F
	 EZCUicKPqxTSmonSYq4DJzowaJj19mslk9H5acyFU6FeXKFqcZ54KD0zIK/EgLpqlnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6PGhhjEgvqZ65gHKlryLhyRpAAf9R8lJRaIz/grErgQ=;
	b=t+JslL56ozUMTQFADk56W5HRGjpEagAWeNYGUbmRoJxkwRjy+TiQzdhahq/jGB47PlMS
	 oh+oncZyb1ncTg7U3MfE/IsGDk+vo2E5kOpLBA0Hm0o26aASEPpYoiWi32sPSaG+ckiLC
	 frm3x9cYZg9PrqmAMXuA90ox2oR767po64AXvYqJtwIOxLsdVMSlKZFnxCfVHdVtNXJXW
	 QSO2EnisFEgo2oDDQaFWmrNDzc8TWCzowZFC1F8326aWmMxkJHI4IWLR1ycCX/sWN3XHG
	 Li2ngULEi98QIHXUa6qPnPbeVnFMn0smqBGSVWkb/n/124YWPlkCFATvjEdXBB4u6jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=quora.org;
	spf=pass smtp.mailfrom=quora.org;
	dkim=pass header.d=quora.org header.i=@quora.org header.a=rsa-sha256 header.s=google header.b=jO4u+vVH;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D6F606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67D6F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.a=rsa-sha256 header.s=google header.b=jO4u+vVH
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e977109392so3928945ad.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1794987887; x=1795592687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6PGhhjEgvqZ65gHKlryLhyRpAAf9R8lJRaIz/grErgQ=;
        b=jO4u+vVHbKfydjhXAgKGqbmmiaqz5waZr82t4jcefYRuztKgvoKYZbtIwkEB2lBpSj
         t75qZhQox2VBo5S+opH7xbCckEx3lv0fomGg/xhSOIUPVO1nDXeyTX+ykS3yTaWxbv+F
         JsRVg78nEb063msGH2HQPjPOZRAfbQRT2R9IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794987887; x=1795592687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PGhhjEgvqZ65gHKlryLhyRpAAf9R8lJRaIz/grErgQ=;
        b=AeUcjJZzR5iwcZT19ZcnZoAtlPD7UoRhoY0n87p7KgbRYBvCLFYF3xo3APbNE845JS
         2nVva3xqdJnM3LZkrY2z7FtqwEqr6J/vCNhuNMqLz319Dt+7F9+6OeyHxSbVm1LtxipJ
         w6P/2n2yfiRLjNkpCR/tFXCM+Q32ZWxRPis5/u7EjzJwhjw5nKSsvMcCo9wQ4jub7orV
         GGGkaQBv0MIMB5Xi70ljns+ZASdvR4g7zJK+rnKmiR5DGYcytVHsO/lthR9Sa8ud4tZC
         8/aOL15+2ziYf09TheL30jJs/oystto3q22hEFX2w4FBI0nhZDxEn+gVhPZ/rmnpJoS4
         mBLA==
X-Forwarded-Encrypted: i=1; AL+hErFuHm2o8Fc+5iypPoQUoV8GPU07DIyQ/NKf2Xcus4Iz0Ll/kLYdomhIsq1xJIqPhqSBKi+ng9k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lexT4VkMz7ZdpL0qQWFZs1+ubgXvEe9WKfHXBcVMssRxdhEB7
	PKEI32cq9nO4xDvFAAYT8GWsvpXkIzcO71lc7galXNPWodck/Y5D2HsTaOE2rjBLmg8=
X-Gm-Gg: AZFdTZequEaKPl/r7/Xcsutyc8ac73F+PigdP6Ee04h+XNPTxqlWErhCSiKiWV6Ec8r
	wUSRZEoxuLZb8gN/gBVKE0zsqVNqvpoGQ/WUzykduocorbktyKUc8wMQnrrHPrVn8WRUHgUv39X
	71RpdqEj33lbn5UtGi8I1En7jcz2EPXtrM4WP8hgc1FHo1sl986Xq6njskm4qvk4Fcgj6Xiun9c
	EF0HBvu6dz8RqyEy0T6ggAfIzuHAmfKivRTw0RheGdy3JUuADM/8ZzzD04JA6IbzAeFlfo/5eph
	mpKkw0ogTpL4b9KcMlnU9IIw3jcy9iNiLnFVYjjdDilZZpkhedBhectvy762rYcpRQsdrg2qdOe
	JMih+xUXScFogVCFSf9ZnamjrYeTMCTFTrDECHX67S4QQUbOIlbMNo4fJKxBKTpkwqk/J+yFVMQ
	CitB3Kek5rSwCpqXAWgUkGbTsmq4wynKqoskYMNHKO9JPvz4cW806lopV/lBBzUZ1NqM8gulwPM
	GW3ZrFD2Kn2hfaFEZAtuiLvv0QLMDRVkPLG46TkfoXW3l2BSZvH/05ZmOcSLFaDgJPNclhT+jbq
	RD2rlvB1IX3AZGmrLS1/Q2nw0kbSItbGHvRNXgiB3mWBu82V4gRBQcN0y80wS4ofKHchCi6jOp+
	2kEgj94ivAXSa3othV1kzTjNgjX9Ru9xq2w7Ex075txdAbT++gzo2lcONteVtCTm72C0hweLw+o
	ipYen2oVESw28tOd6HeYyTHqDK0LeNFWatimlPtYwcYzca4xEkp0ZorrevDDr59loPbpo3DF6Ac
	scQupnd9xjKqMse
X-Received: by 2002:a17:902:d4c1:b0:2ed:2e3a:1fa4 with SMTP id d9443c01a7336-2eff76a9fdemr20403605ad.62.1794987886252;
        Tue, 17 Nov 2026 23:44:46 -0800 (PST)
Received: from localhost.localdomain ([2001:fd8:4d04:f800:62d7:4d2f:7b52:ebdc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff61162dcsm8861185ad.18.2026.11.17.23.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:44:45 -0800 (PST)
From: Daniel J Blueman <daniel@quora.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>
Subject: [PATCH] wifi: mac80211: remove NO_VIRTUAL_MONITOR monitor interfaces on suspend
Date: Wed, 18 Nov 2026 15:29:47 +0800
Message-ID: <20261118072949.14222-1-daniel@quora.org>
X-Mailer: git-send-email 2.55.0
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

When suspending with an ath12k interface with the NO_VIRTUAL_MONITOR
hardware flag and monitor mode set, the driver skips removing the
interface. This results in a firmware failure and unusable interface,
triggering:

WARNING: net/mac80211/pm.c:173 at __ieee80211_suspend+0x44c/0x530 [mac80211], CPU#11: kworker/u73:11/20379
...
 ieee80211_suspend+0x24/0x50
 wiphy_suspend+0x2c0/0x420
 dpm_run_callback+0x60/0x2a0
 device_suspend+0x268/0x7f0
 async_suspend+0x28/0x58
 async_run_entry_fn+0x3c/0x190
 process_one_work+0x1bc/0x4f0
 worker_thread+0x18c/0x320
 kthread+0x128/0x150
 ret_from_fork+0x10/0x20

Fix this by also removing interfaces with the NO_VIRTUAL_MONITOR hardware
flag in monitor mode.

Failure analysis and fix development was assisted by Claude Fable under my
 instruction. Validated on my ASUS Zenbook A16 (Snapdragon X2 Extreme) and
QCC2072.

Fixes: 9d40f7e32774 ("wifi: mac80211: add flag to opt out of virtual monitor support")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 net/mac80211/pm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index f63676c44853..503c24cd2e85 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -151,8 +151,12 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan,
 			continue;
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_AP_VLAN:
-		case NL80211_IFTYPE_MONITOR:
 			continue;
+		case NL80211_IFTYPE_MONITOR:
+			if (!ieee80211_hw_check(hw, NO_VIRTUAL_MONITOR))
+				continue;
+			ieee80211_link_release_channel(&sdata->deflink);
+			break;
 		case NL80211_IFTYPE_STATION:
 			ieee80211_mgd_quiesce(sdata);
 			break;
-- 
2.55.0

