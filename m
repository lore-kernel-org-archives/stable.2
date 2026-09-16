Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D53D411D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536690; cv=none; b=UoG7tgHQEX108YJX6ZGndVbDNhPFsPkMD+C4wsgIGse9DVTQzt2kaUvmk3sOl/qiGqJmkd+yXMaAgu7yhd3ZB5EUiL6YFQLIRODvBUM5lFAq3G8q6jxmh5nUcbmjuPZB0SEfBun7ZxuGSEsysK+fzZA2NBmU/tqQrzjm+JwkzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536690; c=relaxed/simple;
	bh=l4i84PKR2XfXpPetEwc9C5l680POO9YxAJH41F03t0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJwLTaBSfnw9ggwKbLt3GBXIC3c3CFvbG/izfGo6pHfJ9Bez4Hss/n6HLODnvujf4zslKKrYpwCMSQjXNZWMKO4OsUuwkZSU5j/SqLecWZuSJp/8wQgimqul/tiqoR9/zMws1ZoUmpZXonkOlH+KTyrV3w4yIrRc8YV7xKqqBVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMHGLY1s; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMHGLY1s"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc50bcf87b2so364688a12.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789536688; x=1790141488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KIE08YFw4kaft37+7mxF/frk9TC2//zqhyYMu0YvGkI=;
        b=AMHGLY1sTO1OvpAgVJo8euKs4P1A957RqR6Q+rWrU7Jh8aVBmHCFm2q4zrvEvWc/5m
         dFExyh+6hvjNQyk2bLH42ckYhgFRiG0blMWelH74ujeiy2wASffZpPmTQhXb1eDI1p/Q
         YLb7YLjbuqO2TCLinrZ73VmRXqxw99FvQJ8I6P5+AFND/92B3+HofcKgNGTYSF7maESH
         s9+6QdNATx/F37qJ3baVk8CrTu3Pw6wxa9MO54MfY8G0U9jlsplq10fe3pCQXzxAJOiA
         75SLTlisoQK+cEcMHX5qcSQ8pcY3EREgxXa7FPDegQ+6kFHt76tOYmx+TzntCZJscn38
         bpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789536688; x=1790141488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIE08YFw4kaft37+7mxF/frk9TC2//zqhyYMu0YvGkI=;
        b=l/5CTMQ2F8IuxuboIls0TIBcmzmKEVjJeAXMm/hukE3SYfs+fZvzc2lJbn9mR8vhpr
         Q0bL/3WOeleic6wVK8YIHG3sqPU7K2dzq3BGKdq2iG+hWpxH5BbCaq7ty0Mx7OeBfgvC
         E2gXEYZ0ISYv/qbSrwhUmGfXuwV20f8qkTZ8/mOQ2Fs7SamT7t9jf4JKedSqDrIz3zSv
         3puauBHk/6aIOZXnEHU+YH67exQUaihZyfP2NFXdKVp8S6aXMFAT7pDDGuKs25TSkLiU
         j1LYfCs2OlAFkMsKWLYt3SrWdXOyK4zli2OmRUyGl09fC49Nfd23ZSjGoEl312Xr28ID
         cylQ==
X-Gm-Message-State: AFuF++khPEIInHnrfqfKpaWY9+ZdsUFLM94r0tYIkm5h8U4MDMmukWI6
	fMMR0T71SWOcymydS/hOi0H3Qb08gw4VakOHt9wtswg6RfKjlOuXqonR
X-Gm-Gg: AYBFou0ZJLzb/fkWTOqqjJYQpLWijvAvOP02VowfqszgwVY0uQJVF4dTTBOyxQQSUqd
	BIQ3TNXNU6e1mw5Ng9UR7BFS3e+J+91qH4wE/xaWGecakjvspZACWoGHQHFcERTvsxlIUZf0gkH
	Al0kx0jPOGSKTBENTgweYzIp5ioBGus//x6sLWHfgbvP7glhh+XKQzty64IyRj0DcoMCedfC+M8
	rJOy470p65OqTUb2VAVKU9rwAJNO9DBS42FpL8zKS9Z6yExISQGk58A2uSAVHxyk0Sn8THB0V+Z
	WGWNCTHWwJS6UyVdRQFd4enVjSR8IQ+pnLs8UhLJNaXya3C9Zgm1hUPQYa5VLbHydJDRvCAtOp6
	6Y+Q3/6FE6OwogwQ4z1vDeRWJ/bmTH62o0BkhuzgI4AItE4tAMbPj6nvlVwZSBnwdo/SUrsk6om
	uiEjLDRfWRL3OSWGu8YXpEmAgcBcRmZFvAOHrr3y+NeQyyTTcNlSMKMg==
X-Received: by 2002:a17:90b:280a:b0:39d:f60b:8121 with SMTP id 98e67ed59e1d1-39e1e4d39damr3369964a91.17.1789536688567;
        Tue, 15 Sep 2026 22:31:28 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2504124a91.11.2026.09.15.22.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:31:28 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Shannon Nelson <sln@onemain.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] net: ionic: free VF resources on remove
Date: Wed, 16 Sep 2026 13:31:17 +0800
Message-ID: <20260916053117.2906446-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ionic_probe() allocates VF tracking data and maps a statistics buffer
for each already enabled VF with ionic_vf_alloc().

The probe failure path releases these resources with
ionic_vf_dealloc(). However, after a successful probe, ionic_remove()
tears down the LIF and device without releasing the VF resources.

This leaves the VF tracking allocation and statistics DMA mappings
behind when the PF driver is removed.

Call ionic_vf_dealloc() before deinitializing the LIF so the VF
statistics addresses can be cleared and the associated DMA mappings
and tracking data released.

This issue was found by manual code inspection.

Fixes: fbb39807e9ae ("ionic: support sr-iov operations")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 05f19489ec5c..666efe972de7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -424,6 +424,7 @@ static void ionic_remove(struct pci_dev *pdev)
 		ionic_auxbus_unregister(ionic->lif);
 		ionic_lif_unregister(ionic->lif);
 		ionic_devlink_unregister(ionic);
+		ionic_vf_dealloc(ionic);
 		ionic_lif_deinit(ionic->lif);
 		ionic_lif_free(ionic->lif);
 		ionic->lif = NULL;
-- 
2.43.0

