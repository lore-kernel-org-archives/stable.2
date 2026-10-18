Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDBE43DEAB
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304679; cv=none; b=YuT5iGFpuQh4mhYtZv9948zlE+rVjEgw+lL2BhZhZ53kwbWmZnr2h42+aOlP/nGjsdak2O4rcV2GNYjLbRwWHjj3nL3TmxO4KPR/Q3cATyayvA1/hUW3LJFG2vGxZG7cEDvY6TjzsgRJMPCNHbQy7bu9ySlLkpAgzyBIJxSTwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304679; c=relaxed/simple;
	bh=fBON41rkWJm+Nr5IP0+q0DD6zo5hPQEiHIFcCKvNNZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iou/suiMXgHyG1UNjteULUfIqoD0Sn99vcgy5m/e+vZYXZYUaJCpbQtPF+vd4apEB49b8UMR8ZDCJ1hWK2R7wt9hZ7W+yfjBl+fH8li8teRQ+ertkpo56gEJHgediBuLoPMtVivKWm2/PfzV8ht+WMZRa6j/R4Wyh/9tX2NneyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=oVd0RvdH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="oVd0RvdH"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a706146559so923117a91.2
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792304675; x=1792909475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
        b=oVd0RvdHSq64KyeFs1iLG4eTFH8OLdu4gWJ5w8y+79BPq+xg1l9KZvzlj/PrNzfnfb
         zvFjmCi3gPHUIjVenkw+vveiB289G/mOD567chisUkm9/8uvM5yUOrhCdOYLC2MLhq+0
         NuyapCx/jcvcIRdUi3CetNdmDeVeZnEtiTH0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792304675; x=1792909475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
        b=hnpqqqNNkKTwKY/QKoDP4OYrbnnemzmOmNp/1hESzN9J6Z9SqT+ZuxMJDP8r9y3vga
         cuJ3BW8pJZ7XIzcQ9McJO+KVDvkXq+X6ztTNQcMpodvbqscCRTbbeZiCPLCRMFHAE6Iw
         jiGJOzYYg81PVJUZ77Cx8nHShl1xg7r29Q6VttdwfEKCiBluzZLfzYblwGcd+G7i6nzb
         UY9TTJqRSwUGmYSyfWiMpqommVFEy1hFFQTFgnFRGvoqmcTvQ/Cyh75cFbF+6NPWttyT
         5DC7jp4yoaPKBcbRRVoHCTjM0ZNF2/dK+ai6KD8rGMmlzCWoIo8RKQl0tErGGzo22NBv
         qY8A==
X-Forwarded-Encrypted: i=1; AKwUvBwKopj4TkOMrOkaCTSmj0mT0jkLVHnEAXULbRCvrmEoWHjxVW7t4c8DNJvw0guJNeHx5HSUSl4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI28DS6TVjQdbAw1UuNRhkhPg2zsFJsqaN7ZokxkN7AuubzZ5Fl
	+mqWQNXxlfHYwlZ/Frr+lRThrjlKf7VAZoXNvigEwIXMgm9a8/t0wxk4UaxKohOBcpQ=
X-Gm-Gg: AYBFou3KWmt4pl+On8JeoFsWdTVnD5aXpVYfkHlIIG0kRwlRzJTqovsHLpaOueQIhVZ
	IRUAHzBBMXC3eOKuKu8nLlLFHDejAbrh/mI3FLMmWyvqUQF1NtHVp8UdFzXyezAVHwq96OKSmgm
	xeA0ezYTB1NqwJ7elkJr2pg8ehXDxnYaZOcO95cdYkNSBFqIdsZDTzNnjdyiFkQMVf5Z5LPi2e2
	f5p+zvfPTFTWp6tDELzIbx0IEErWNKlBYD4u8sk6gfkBkBEgFuvhj5sdu+DWRxo97SDyByzGRiJ
	pCK/xfRBGK5MrJPlF9eF1o+IbeFprqq708gRNw8wvsJPlESZ6EgcZIHcxpyaTgYxXsICx0CCvzy
	zeVLlsI4+HYQc9f8KIUPaqbtHQAEP3RVlJhrXWn1x7+locLBwl8Uk15LT0oJA0cMPPTjGeH5ove
	F5boy9RJRZP+DgCU2iLp2LpLGO7IuPm1gGwMZG3ly1NfEQpiw1wGagZ76YSOax/pgkzeldiqnX3
	EJAeJsXW19OShXFe5qOXLFFYdktlNejDCZ1jMCmC+OukmSrvON3iEkGcFNpPbw6oQ==
X-Received: by 2002:a17:90b:4cd0:b0:3ac:a203:e0a5 with SMTP id 98e67ed59e1d1-3acef104296mr3845305a91.11.1792304675254;
        Sat, 17 Oct 2026 23:24:35 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ee274sm10513293a91.4.2026.10.17.23.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:24:34 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] net: usb: lan78xx: do not update statistics after a failed read
Date: Sun, 18 Oct 2026 14:24:18 +0800
Message-ID: <20261018062419.21921-2-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018062419.21921-1-law.wei.jie@gt.tech.gov.sg>
References: <20261018062419.21921-1-law.wei.jie@gt.tech.gov.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan78xx_update_stats() reads the hardware counters into an on-stack
struct lan78xx_statstage. If lan78xx_read_stats() fails, only the
rollover check is skipped: the counters are still recomputed from the
uninitialized stack buffer and stored in dev->stats.curr_stat, which is
then reported to user space by ethtool -S.

Keep the previous values when the read fails.

Found by code review with LLM assistance. Tested together with the next
patch, which makes short reads fail: with an emulated device, ethtool -S
then keeps reporting the previous counters.

Fixes: 20ff55655a93 ("lan78xx: handle statistics counter rollover")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---
 drivers/net/usb/lan78xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..cb8204371f5c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -789,11 +789,13 @@ static void lan78xx_update_stats(struct lan78xx_net *dev)
 
 	mutex_lock(&dev->stats.access_lock);
 
-	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0)
+	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0) {
 		lan78xx_check_stat_rollover(dev, &lan78xx_stats);
 
-	for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
-		data[i] = (u64)p[i] + ((u64)count[i] * ((u64)max[i] + 1));
+		for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
+			data[i] = (u64)p[i] +
+				  ((u64)count[i] * ((u64)max[i] + 1));
+	}
 
 	mutex_unlock(&dev->stats.access_lock);
 
-- 
2.43.0

