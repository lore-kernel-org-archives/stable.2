Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013C448CED
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544285; cv=none; b=JKSBl81Gy89wB9vbngviTf5I8NJ+eXP2HeY+4ttQyC48qK9lh/frz6E5SY6hAR39s8DxsTeZ73bCff1ZaffbpIF6sMmH2wQQOkh9q+m53PIgSEiX012j8+MZkbaumgYXdBp/R1p/SAHDQtg3CvJoEwyIc6bX96eqBZJFkRntrIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544285; c=relaxed/simple;
	bh=j7jgslCWBYoA2+D+WAWshoZXYUkf/W7ampu9ziB7JwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUf9kZFM5+bH7NkxAX0JZqIhXFlb8AB1yzEtycJE/xQT1xg/VZZaaU6AiODqmE+JhoPX935trMzzxzhCC0yJwyi8LpxVRaTLfw4V5o65y3u8gUv+KI5RJ78ksp/N8Q+/fw6eYoCWNKVJ1yiN6682vqChlt//0PMRQmDPYlaQWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLpccVq0; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLpccVq0"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc50b9e8a45so426952a12.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 00:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789544266; x=1790149066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4H2HhVJ8R9paQExr1TkyHeGUkf1dKuUDiaC/9DA+VGI=;
        b=nLpccVq0hHtlZbNAs98Jgt+76CGfUX68Ln80oDkeQBlYy7JFmmicRJ6k5gf7n2hv5V
         Ry1oRlg8QjBtsoAfC+ya83R+2uJtl7axr/P2VPBSNmxesoYqY8EWax0pXo3e6tD4t0J1
         lpRIt4KrttDtGEOKLOD4E7mgRhsDkGoUtZRATaGdqxmJNtC4lMKPF0D+PKLwgTEN1+ME
         /kTVJl63FBlC5rREfmacX0EIE/FcrCyX1sTO9cKTWKaY58n6sgeIazAaSXWf8AZbXOrL
         yO/EaWBYSYj6Px1lEVCI/N98hFD0z5eB4cjgpU3Cvhv+UQvd4G/CODofaGxRuGbUQF+x
         uqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789544266; x=1790149066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4H2HhVJ8R9paQExr1TkyHeGUkf1dKuUDiaC/9DA+VGI=;
        b=Y7S0LexAPoh6bbDfwjkW+CMVy5CL8ouQ2cuo0FNX0ueWGZoMZy2MnLhBBvVN01t5He
         YqIOyvLz/G1fJsiQkytuAFfpBgjdzbhhVnMVUVlOZvP/FltdJ36Fochu1Q1B+I4eR3fg
         lAltRXebLRui9a8IKYILS4XfHhlnQSsZ4zQoXXawJfzVqJmfxkcLwJcKNKHrdQnbzyNp
         t7udZCZld940fQUUWIixz+mRpqP9gfn19rgCsHv/sWMPagtFiEOXIhcnAWMg/3G/QN2S
         oeixDUCdRi+OgnU+WywlQfU/mEIxPY2heszp1oMbzcTCWtO2YoJ+UT/2wJks9CuHZeQ8
         suSg==
X-Forwarded-Encrypted: i=1; AKwUvBzahPt36ShB10ZYIO13S1QjEZzgKSsVqmVWWlhNDeMdkBc5NE3F+6IzePWn/AIw39bBbWK5gMg=@vger.kernel.org
X-Gm-Message-State: AFuF++lX8SdcfOkNMH0UcoRN6vEcFlZpHCjD4ri4O98UYZC9iLCPzD43
	cOKebJRCsiXhz1XZECis2GBpnsOGhi1qy2sFyYSO+yPs798CQsq8U2LW
X-Gm-Gg: AYBFou1/Eoi7dreBUMJQZLjMKE/mp1n7XfGWWRpOXzWg+u8ixXtJxHzgv+cfWlCjscd
	LHlqzP1/41RIlQIezfD67mTUUOg2WD8UPB6eIoHUiHbVVWXAQGi+b1CUejtqBbFtaIyY4DIw5K7
	ic9dL9MbZrgDJdMPqW160plJ6wAvHGtge8491v7EJmmvjL17MmWALkVvxWer/nndhV0oDY7/0lc
	wOsacfWrCXsozxyRR1rP5VF9nqQdhHD90a9CK4f8TfNSjrhG8Oze0jqpmJwyoPPtcXmcnf0j4g5
	vYoJh/DIL4Kr6XwSBhesd5fyW65oDubv+L3AY7iySSeVMUDNUcZdeVrntoNAAAMkfD76ouuAuPp
	L7nEZ2ZXtLM0VgxLPmMO7e4rFKBffFbOV1vPl57OpNOOOMHk+QlsAd0hGQ45whDWKrIHvtS0HMV
	f/cATYtOh12HNqSy38Kl4IycbLiBgVsh60lmvSmeLaeKaEf6T2Xa5Txg==
X-Received: by 2002:a17:90b:3b91:b0:398:a486:81ec with SMTP id 98e67ed59e1d1-39e1e380e12mr3888761a91.11.1789544266209;
        Wed, 16 Sep 2026 00:37:46 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1c337e97sm897181a91.2.2026.09.16.00.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:37:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Stanislaw Gruszka <stf_xl@wp.pl>,
	"John W. Linville" <linville@tuxdriver.com>,
	Ron Rindjunsky <ron.rindjunsky@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: iwlegacy: 3945: free EEPROM data on remove
Date: Wed, 16 Sep 2026 15:37:36 +0800
Message-ID: <20260916073736.2952028-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

il3945_pci_probe() calls il_eeprom_init(), which allocates memory for
the EEPROM data. The probe failure paths release this allocation with
il_eeprom_free(), but the remove path does not free it after a
successful probe.

As a result, the EEPROM data is leaked when the PCI device is removed.

Free the EEPROM data in il3945_pci_remove() before releasing the
mac80211 hardware structure.

This issue was found by manual code inspection.

Fixes: 073d3f5f1b3b ("iwlwifi: changing EEPROM layout handling")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index cbaf250626c5..f7ca182d1494 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3807,6 +3807,7 @@ il3945_pci_remove(struct pci_dev *pdev)
 
 	il_free_channel_map(il);
 	il_free_geos(il);
+	il_eeprom_free(il);
 	kfree(il->scan_cmd);
 	dev_kfree_skb(il->beacon_skb);
 	ieee80211_free_hw(il->hw);
-- 
2.43.0

