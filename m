Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889C218845
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780860665; cv=none; b=b/ozY9BUeqhfo8y9khAwaipPprRGdER6CBjPkroIluujKPPbpFJPDds4Y8X1oK2xWy/XXRoRvI0m8gpJjPbWt5mgFaFpG0gehZ5YbQy4AYsaep0HZt6JAljgOY2WimOF6JEtpVpkYGGf3sUzBzAo1B8/mCyNdYTIaUaW6MRPXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780860665; c=relaxed/simple;
	bh=UqBn+YJY7M+u065RMcQHz1GgsUI7JWcXHJmj8EfdyBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D8QhWFqKitgtUz/Fb9jUnAM/bC2AOgYrwqCLqMiytRocKb2vtz24t0bFhabWTcAVMsEOWTanRhy4/3J8AmmuHvGnGShU7CRFTS3FIpFPmQLoDVCopavGliIr0vUwchkNaq5aci7WkiB2E+bii3mmqeC52S1tTgDLpHPP7kpr5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh5enM3B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh5enM3B"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso31862635ad.1
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780860663; x=1781465463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Js68PLPyN3XjWqEU0fIOqcPtf+mTXJxmFseuifo/CDY=;
        b=Lh5enM3BZ9aNrJWeUNtyQMjlswsGR2q0v+ChADDSaNo0XB2Qbw20fhhDh5TTuvIjcA
         tUhxhmPGM9zeuk/rJzbY5bP/+BgmM+aV3moO+qLFGxgTW9/0Bb/SX0LEDLWoYj7dVphD
         2JHTv3YjLX9xqGGGP3aimhD4Q419CIvMOMKjiuvZLeURnBvxZk2O5JgNCqsG9nb2nixJ
         BGCppcSfhzdtmXOEgFWRu9iVOYPUMQKlrRqk9d9V78bBs/mKOrpe5+Euwq+/IGbMP2zm
         Q921z8jtEfpVGEbLmaHvtuGolvXT1rfCf99KR/LP36btnzm3qNa1yEG4PeeCv9E8rypx
         mPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780860663; x=1781465463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js68PLPyN3XjWqEU0fIOqcPtf+mTXJxmFseuifo/CDY=;
        b=LJgKHSqCKwfJh/Sn1dUvhJk3WWJOjkOCXcqlxyqGqAQjv3JaWjOd7I83Cf+gpPMQoY
         e8pYKX2PW63qBZBDmG5OKGp6WyBa9RxPvWRTYxVDEf5qttTzJXstiAsFf2A1+u0fjPmX
         PBLUUMervBJ1XFEGNerum6jyFNtOOvdXtUbt79lH3la3q8fGswR7Eqotu6qTPFGI8gRa
         JAJ6ZhUfanpm7i1NG4PXHmqSF1M/znt+kXTZOfGRJUsfPIYi6yYn10OAqwpd3b9BExHZ
         E2FlFHef4EgCLLe4/qOFlPjuGVW0M8Nvl/caD4CoU5pR45aurpUXCDlA1iWWEjPT9aBg
         /4cw==
X-Forwarded-Encrypted: i=1; AFNElJ/C8FcMUDE6m1xAJtG3oTSoOYV7C5qRzUVion9EVBkAGxHn9afZCKyK95u7WHLtgXecvvfA5jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ7eC9QL/5MG7XygV0ATp7J7pYsfh2SuR0ozHyCO/e6QBXYb19
	JKlCEaHrnRe9na/yqFf7yAZ8ypxTiUmeE7b1BcqHV5KNKKtcrp89ml0t
X-Gm-Gg: Acq92OEPf1nChv+UvRz/SgIkfnFx8eOQ7JIIAOSajYWDA0Tv4pp6218FHtvv3M1F48q
	tx4TNoQ2GRVSSHEZDfPWEzL7WRumZgm0/e9IRsCyzNVE1P4wQDe+ullEfo+3IqrEjhxmE+C55H1
	mN/2ipdhJGFukEvfx/OYSWV/pduH0AiXtgryFCvYAnOZ/G/97XbLHKyB/0znsqF1CWfgXVo78Je
	KzScID7siiFXf2Qy9MgQ6m8GWc8pWUcCEmyt7RXdVVDWBqdHyNM3Tg/B43X8YuKRFYtb+6UiZ7i
	YbxQHtNp6K4nja0wYqgW7xLJf9U/tOTjICBpOgxe4AQXDmcwJAzEP7X5ATTtjAVdf1hZFzkl0hU
	fVtLFTjppTcYUpDc4hSr86Y06J2yILUzsUJaDN3n3fLPhcTJs//ePBxLKyOJ9YprNdWdG+6mZD8
	L43+msdUpQk0IdJgUlrEhsZVzujbvjEvyHsEjojM8oSQZpyuSfcM8T5kgYXEKBINrLYPw9soJ+
X-Received: by 2002:a17:902:c94c:b0:2c2:33a4:aa8f with SMTP id d9443c01a7336-2c233a4ade9mr63422735ad.13.1780860662802;
        Sun, 07 Jun 2026 12:31:02 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d55esm157971855ad.63.2026.06.07.12.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 12:31:02 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Wells Lu <wellslutw@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net] net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove
Date: Mon,  8 Jun 2026 01:00:29 +0530
Message-Id: <20260607193029.589736-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mac->phy_node is acquired via of_parse_phandle() in spl2sw_probe() and
stored in the mac private data, transferring ownership of the
device_node reference to mac. On driver removal, spl2sw_phy_remove()
disconnects the PHY but never drops that reference, so each
probe-then-remove cycle leaks one of_node refcount per port permanently.

Drop the reference after phy_disconnect(). While at it, remove the
redundant inner "if (ndev)" check; comm->ndev[i] was just verified
non-NULL on the line above.

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Cc: stable@vger.kernel.org
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ethernet/sunplus/spl2sw_phy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_phy.c b/drivers/net/ethernet/sunplus/spl2sw_phy.c
index 6f899e48f51d..a4889c52e00e 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_phy.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_phy.c
@@ -79,12 +79,14 @@ int spl2sw_phy_connect(struct spl2sw_common *comm)
 void spl2sw_phy_remove(struct spl2sw_common *comm)
 {
 	struct net_device *ndev;
+	struct spl2sw_mac *mac;
 	int i;
 
 	for (i = 0; i < MAX_NETDEV_NUM; i++)
 		if (comm->ndev[i]) {
 			ndev = comm->ndev[i];
-			if (ndev)
-				phy_disconnect(ndev->phydev);
+			mac = netdev_priv(ndev);
+			phy_disconnect(ndev->phydev);
+			of_node_put(mac->phy_node);
 		}
 }
-- 
2.25.1

