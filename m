Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597585;
	b=gcPWJAXrhDKYS2RJ40xISWShuB9fb5SZKRtYs6jGoGZz8s+AaCJpZXWCq36fIx5d5R+u
	 dptJ0fpkr6uR4HaVol0LgBv48m6U72aP0V2pBYtzzZkc/YnfsZeVmnNLP+lhEqNdqHvUO
	 cqbhoe9SwHLwle2og7W9qXfLo8wtkw42HyfTkeq8y0clECmSFwlSRchJstzXky0ipzC/U
	 GZM9nUqAiWtudm7c/GSqRUBnt78agghPAMBNmZdSa9jYKRUrv4f/aYvVJRaG0xx5Llo4I
	 7VI/lUh9mPf+FhTvtfQI7L7n0VAK9NzcEW1gagwgJlB8p/Yv0lDlq3N2WN8258RMS3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4LMXwRmfFOK9uVD3FtaSaYbnUZEWWNH1s5i6mBQwiM8=;
	b=r7t7z4rRBIMdIwFC4Dd8EUF9xj5Il3hE4V6xhOtrlpwmgEU6EVkcPO1T458LXW3c/4eP
	 iMD9b4WuNjQ9kKgA/yu8SjpmP1UYoEClvTw04ZF2bfA5a1V2OuB0hCkWn8RUi59VGbN+7
	 +8rvEX89xRwNhsWZ+T4xDFgx1MB4mXXVlpK6//bMtaOOHtnhWfyQy+0yxdKNL1btYNm9L
	 ezARn+DZj7aDPwArsWPYmF5fwL63NAINBPnJXeSmWIs51tuCuN8TmAA73fqW1fM83ApZb
	 v+jfncODWtUHocfG4hkwVC+agm6atWPjy5D8bee7CkEce725pn6RLcuYrmQK97FjaTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s6AHOlWg;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7A606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B7A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s6AHOlWg
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so3595527b3a.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597584; x=1796202384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4LMXwRmfFOK9uVD3FtaSaYbnUZEWWNH1s5i6mBQwiM8=;
        b=s6AHOlWg2deWPUzAakdw2WBvpzEOnyC6kV1RVAXCpfRiplizozLW0AemyEbz2q87Px
         K3ZJbR8X+UVugfncmx7+v3bQZb0458Ma0CokgggfClzEQdZ5F36+KZvnv6jO8RtLB79q
         05EI6CvXj/KWNnYm7BbjriU7sbs/ebB9UglBFMBK9YNnjIzNFTsoHWfzDjQhcsEsOmiA
         vZhBijjCrT/dNni8aHWh/9K1iZ2kIspcGPev+0yVLUd47Sw2kbP9ODjzTMvXqs0sMB9t
         BxSsyJ5UHOgSrtcf4TnLbf/WGXOELhN7a42y7fVKfG2rQ2qHY7OfjPkH4E48lpkycLu8
         rKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597584; x=1796202384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4LMXwRmfFOK9uVD3FtaSaYbnUZEWWNH1s5i6mBQwiM8=;
        b=V1DnBQE0Q/ptwOdv3qa3A8aLj/esFTbNNgbPM73bjpa0FWhNUvFZiObHOSkqRfNL0q
         pgH0JfmzcmC9vx2+OVRw4nP+lDJSXDDlIOyd/YXQmdxgEVwxsrzMJb6ZjEMTc+9eXzJf
         OnwRJjmypOv6au5KTv3165IP4OTMUCw7e/zQZyXdeoCoslprg9PxgoHs616q59KSdKH2
         yXjnSou5mlcuY2bkeSm5P7QNbbfmPtvJ+DLeqNqfIf/lYlSHK7wMn2bXdIUYBdR5TrGF
         sN4/l+teRpOfkb4qjDRK94s8t5Tow4CU9VY9fVg7D+swa+rpgNJrikDOADkxB5LzM+vF
         wSeg==
X-Forwarded-Encrypted: i=1; AL+hErGlThgjxRtcxkqMWcJ+pK76Z4clglUELaQ2JWOGzBUYInScSrYTjz1bHAEG9MOuRBN/gxSmR7g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VA/14yIKSJvoumMAIDmkhLvat4JnakN8dkpoPsrQ2/HLmIsx1
	/5CXi3dVOVuAJua/+RY/SaCvjCqlUXq2rGZYhhwl86lifemamhJPXfyzhy+Vi20=
X-Gm-Gg: AZFdTZd8o6axPQKZUFOeRzeuO2N1IY7uJ/Gzk1SeYnlBzouT+s7RL0eH/atkFhw+YDC
	zDFqFxnKqLgE59AEDM3GyhgDv6CFoBoUnpk13mBi727u+wiEGnXUZBY9i5AaQ8wXXSO6HKcCz55
	DCTciNWi7iK05hscUpDP5DAgvJYowdxG8yLK7rMh3VNwqm9fG/lTNqw4z3Ly9ykdM9Duhio0Bcm
	9vGpGS+n4XzIXLP2wF4l9zyl0NwaAQ5apHComdXQlmu0yYIpUr8diMHvO2vKTwr3LqBg6Lpnh92
	Qdt5hPZuKI7w386gc/lkxTmGsZ/bswkXKnjluTba/D8K8UusMfg7NN4fn7O8ltgev6irlSV8biD
	OYtPmFA3VUBl96nFP8/0ciVp/pXZyOp7iKZhi37XoCgajWJuzsTlNWHu1ihjnTobHW+ldt+Tqit
	zqlzJEhF0VaQzOgpG/RQVj9Ut7+hKr6UapeBHPIsNtbwVnsWHM8EZ8vft4TEKFwyJzsJjaqi+M1
	v+7ECxB6L6mc3Ph+bbrri7THy50rVQsLLLxTcq6bn0ZY7yvUBCdl3xsXx611s+7jnv61VvLpVDZ
	NmsSltGtnpdod4m9x3jsB31mq41scjp5xIHKvcmGd5dwN/x+iK9MRnlApXcgMXByaDSj
X-Received: by 2002:a05:6a00:2295:b0:881:b7d0:8dd5 with SMTP id d2e1a72fcca58-8c87bfa5502mr14791566b3a.32.1795597584300;
        Wed, 25 Nov 2026 01:06:24 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:44a2:4377:d176:9ad1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c228sm8468090b3a.10.2026.11.25.01.06.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 01:06:23 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wil6210: fix BSS reference leak on unsupported EDMG config
Date: Wed, 25 Nov 2026 17:06:18 +0800
Message-ID: <rc-b1-20261110-vc-35-5e6ef2ea7917@gmail.com>
X-Mailer: git-send-email 2.50.1
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

wil_cfg80211_connect() takes a reference on the target BSS with
cfg80211_get_bss() and drops it with cfg80211_put_bss() at the out
label. Every error path after the lookup jumps there, except the one
for wil_get_wmi_edmg_channel(): when the requested EDMG bandwidth
configuration or channel bitmap is not supported, the function returns
directly and the BSS reference is never dropped.

Each such connect request leaks one reference, so the BSS entry is
never freed, even after it expires from the scan list.

Jump to the out label instead, like the other error paths.

Fixes: 9abe3e306ecc ("wil6210: Add EDMG channel support")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_WIL6210=m, CONFIG_CFG80211=m, CONFIG_COMPILE_TEST=y; baseline and patched cfg80211.o, no new warnings.
No hardware or runtime test was performed.
AI assistance was used for analysis and patch preparation.

The path needs a connect request (CAP_NET_ADMIN) with an EDMG config the driver rejects, to a BSS already in the scan table.

 drivers/net/wireless/ath/wil6210/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index bf060281c9a2..0d256f313511 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1356,7 +1356,7 @@ static int wil_cfg80211_connect(struct wiphy *wiphy,
 	rc = wil_get_wmi_edmg_channel(wil, sme->edmg.bw_config,
 				      sme->edmg.channels, &conn.edmg_channel);
 	if (rc < 0)
-		return rc;
+		goto out;
 
 	ether_addr_copy(conn.bssid, bss->bssid);
 	ether_addr_copy(conn.dst_mac, bss->bssid);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.50.1 (Apple Git-155)

