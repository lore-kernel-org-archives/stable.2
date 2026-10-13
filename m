Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FA1C695
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849732; cv=none; b=QH+IoP2LF0C5G6z6GNme1V0yNu+xTcHtztKY9rgmGb3VmIy8Icil4mAQcR8PZzuRlqtb772iz+iet+M9B07lDeTcJYl5FrFY5UkFpoTV5ap8gay0Wfcsnm9Y7qi51IYxXyq+6EFGKukh0qJlQy0J8cKiCtOM9K5N+fNZ7/IREWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849732; c=relaxed/simple;
	bh=3a+AMT0v6khTMsbtA0dy9SfSCDaJ+qcU//hG18aCDQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulb4NmMAobEgqxpq/bDhEYb8IsEzIspD/mTUgeTaBZIoHF0zGCUlaeH8cP6Ejo60gGdPeB93LJC/XsdcCCGJXZNKCRK3q7BVGZoaIx5BGgf49a9ncuylvKN8rzAxk0PAKYfwVplSgr0J8KLDb97XMeYZv70twT2vOtCqL5arsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5nbRKKD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5nbRKKD"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c33bb2f3e6cso277583566b.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791849729; x=1792454529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tXW/owfqKGVcmAOIQp0k47hmuuHXvmL9jkkhytfXhXc=;
        b=r5nbRKKDNq5v+ZWfYRrdBoBKY30R/fHAhWbb1u5IG4TErLVR8C/Osq4gGk4UkbKV0I
         e6hTr5lglrkv8Yw9J103C1bC5M6on71GHbJc65tqOC7Jew+4+ZMKfzr86x0HDGco9eS9
         45c7zBN9ot2wnl8OqHKwhdnBLUjHa0/C7S1MXPt36qt4k6l2PnOG4y/qakH2FJ0pcDBf
         5zizgmgfsMtIEoqxnhLBYrN0Zis2w7XWrG3YtUjg/TRItQVwtA3M16aTFDI6ojvAzYA7
         vQjyt4bGhc8xEY4tR4uCJlO+RnokYTkfiU8y6/2oEjC99GzVIb9GhoQJrtIYPWT+NvvY
         7IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791849729; x=1792454529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tXW/owfqKGVcmAOIQp0k47hmuuHXvmL9jkkhytfXhXc=;
        b=YqfQ6yNMeWTFMQv3oQOaPCT6OAtrwgxAvVWK/6lpMknd2EtP9bp+xX8BmXd28oAuO4
         g1zMM5Yr+qeudjKop3y09/Y66JmTcQ9eL+6zYyb+SQibYkqfcW+z80WHJMrvVRuCKvBe
         UAzF7xNeFMmRMQ034g0QZpY8xt8ppv74s15diBH6feE8bXr3z+RaxbvJ9t56NJXQ6yCs
         VBPIuaQtQ4vyNt+GJ6vQnRhlvdjvHyhHigM28D+urofFJYg8s2JcPd3dGKdzecsxwYll
         3Smg94WMMX8MvckItgUpygPqcYDDxviATLlPzXfHw43+R6SHa0dEhj3jHVU4W4SZc7q8
         j7Zw==
X-Forwarded-Encrypted: i=1; AKwUvBzwCGfLjtuIUTHef8t13xXzTD7oMWdJVegyWUh/2t/RTnLA0+pCieIMeQcQ/FgvPoWdbKMB7G4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgVwf3drz1kjxIqp+rk+58w9VKGum6PRZUs1ljKJoeuo00p8gj
	FNWDS8p+NB7svR4uEgPXC4gYtDGujxBmNZOVLgtIX7cBe0OMHNpt9iKu
X-Gm-Gg: AYBFou2t8JL1JGK6OKSRzfJlRBBbUZilbD3ueQ/O5Zkg2Duq3T3ADxVCFjGviuP7HY8
	vEJLqXe7d5D8gD9OYRCpnFDr3xpVj3y+YV50f8PeQdtiJ2Jqn5hV8s/zxfm7QPu3v++MzJV+sJR
	DVkUxppMTE7qtI9ck6Ui8ixlvMRDCfC+Vk1pzWTUFtRgbz/Hf0QiKFW75vEge/FTpIVKKm10/LZ
	D0rbWwWsI7Nw3ytdzm4Fd1N9If6NMDuO+d5noCIm/SZm4Udhm3tH5skaa0xpQB02tLOkFpkHYgZ
	HAES5WwYM0oHy+UCS0JdcX62+UK30arsnfL84eBSfXIMarTMkJsLTlZV5Tvoc1ozHFRqTzksUww
	pttuTvnW5s+38P1a1q1dWeIiWTsFbGxx690pY3dL2hnHo7x67zNCHirnLvTpFePRrobet1pU4D+
	QJeJtJWYy1p/eSHsm+8vMfTSDx82YD0mF5W7mYedAFW8oNkW1zRtVfQPhzpYO9lHZKrR8ytC6ZU
	E/Fjg2yzXUIhcHAQN2EEfSWi9H+pFEXtL3MKapqDfUG89MEoG3OUh1p7Q0nfNBCaANpQMNZU51g
	SDu9GZRVDhOYLniBdmDM0s6OAbBeSoaakPmp/57/DItF9u6075Wlrt461Mtj2UnoqjYGBWln1h4
	dmi6AMcOonxoT7H0=
X-Received: by 2002:a17:907:7243:b0:c26:19de:9138 with SMTP id a640c23a62f3a-c31aa0c3392mr1079230966b.43.1791849728967;
        Mon, 12 Oct 2026 17:02:08 -0700 (PDT)
Received: from zwetschge.tail45b538.ts.net ([2a02:810d:a1:6000:a55c:f7b9:d145:2469])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c31a9ac924dsm527221166b.70.2026.10.12.17.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 17:02:06 -0700 (PDT)
From: Andreas Wendleder <gonsolo@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	Andreas Wendleder <gonsolo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: b43: fix use-after-free in b43_bcma_remove()
Date: Tue, 13 Oct 2026 02:01:24 +0200
Message-ID: <20261013000124.48605-1-gonsolo@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

b43_one_core_detach() frees the struct b43_wldev it is given the bus
device of. b43_bcma_remove() then reads wldev->dev again to free the bus
device, which is a read of freed memory.

b43_ssb_remove() does not have the problem: it takes a copy of wldev->dev
at the start. Do the same here.

Fixes: 96838d61102a ("b43: Fix memory leaks in b43_bus_dev_ssb_init and b43_bus_dev_bcma_init")
Cc: stable@vger.kernel.org
Signed-off-by: Andreas Wendleder <gonsolo@gmail.com>
---
 drivers/net/wireless/broadcom/b43/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 817448e..3825b6a 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -5677,6 +5677,7 @@ static void b43_bcma_remove(struct bcma_device *core)
 {
 	struct b43_wldev *wldev = bcma_get_drvdata(core);
 	struct b43_wl *wl = wldev->wl;
+	struct b43_bus_dev *dev = wldev->dev;
 
 	/* We must cancel any work here before unregistering from ieee80211,
 	 * as the ieee80211 unreg will destroy the workqueue. */
@@ -5691,14 +5692,14 @@ static void b43_bcma_remove(struct bcma_device *core)
 		ieee80211_unregister_hw(wl->hw);
 	}
 
-	b43_one_core_detach(wldev->dev);
+	b43_one_core_detach(dev);
 
 	/* Unregister HW RNG driver */
 	b43_rng_exit(wl);
 
 	b43_leds_unregister(wl);
 	ieee80211_free_hw(wl->hw);
-	kfree(wldev->dev);
+	kfree(dev);
 }
 
 static struct bcma_driver b43_bcma_driver = {
-- 
2.54.0

