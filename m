Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455629;
	b=mhxw9YA3PgIxIF1naVRBlT8R6YqdicLXwvG8mC1g4vXAymMG4XEphT1A3XhVqu21wlQs
	 POQFHXE2iT0Oep6sPXHuZAThIb3t//x4OTdJAj3xEUpBJlJBj31A0mXOwJxU8PDjEEm9m
	 9/7V0Dy6wTIug7mHZSBTM9vhmtWk/hZVnLXyHZTVTJyMYyqnvM5eRQk+12HToVcihyeok
	 EnSTLtj+OeyLTyiRNeYTn1R22O6v2tTI6tHNZCvkEKh333rhmJm3cTirbEVlq1TwGkXWZ
	 w/KU8i7qJIi7sbpR1RZdpB54Z+msKQ2gpanWBJ5fxxq1L8RsbLKyNin9r8Av3N2pBWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
	b=1rH5u09gbGtyzfAR8f3CZmKpgyMyhUdcucPAGSR7htAazxzDKA3XErnY6BlNdoLgupo/
	 hPRHCHWlDOip2Vln1iIKrhQDSZIUYHVOBR1lfXlkm25UKyH/Q2FuPlT32H5NTLwKVzSsH
	 vN/cOJmtB7dmyy0ayffdHeivPIEqF8BAElWb8SwkJqzBn517dP6SzL5dyssncgkBFdBLm
	 YJS4P67z9cqRQACbOQZ68gxmwdu7x+dPlmeA+WBC++sn3UIjqOXGkSg8ei2m1jp4o13kq
	 y1v6kZ8Jqx41ouELEAW5OOu4cJsHgY/DKH4RV/irio4KsoY4XpYgVQs+EsYAod3B9MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gt.tech.gov.sg;
	spf=pass smtp.mailfrom=gt.tech.gov.sg;
	dkim=pass header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=TE84NacE;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43431606A31D
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 00:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43431606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=TE84NacE
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e987a2ba0cso22045185ad.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792455628; x=1793060428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
        b=TE84NacEl3T3mzY4W5rPDIpq+6Lfc1rNcOh90s8Y5vYh6NNcH93ogskkvSMh77tyF8
         4LgFPp6S8w3qhRfFgUZO6pLVeeEpPlMLrzo2n/BkMLZovv8DeaxJ8aK4m3wedYOi82BH
         ucyhxq8lB3pkJ7nIltsjr9LJGTBFRRQWYWF8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455628; x=1793060428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
        b=KIMKQWGPzUqAYOi3XfX0Tl34l+96UWsootTW+0EQu9RkI3Htk/P4ro/4NFceqqmke5
         ZDY0KiyUsLUDtrE+kDBCmIqzTABCKcJMJ2Jzkj+L7P+nKuqbWdYtNdVLsRXSEdDAeQYx
         hRR/fqgR1jz5nBovXLkwmc0y7DuQv7YM28kzz0Sz0YRkiHd7a/70CetERhAvCMDfO3BW
         yd6TJ5m1Pi+ygY+Tq6Np4eCHbmpn41xhsb06qhbpa66UdDqip1LmITrrvAToiIhVez7U
         1EzlqCZE8IJiBhgyZ+vKwz/Heav7cm6n4hG/OQQw3YVhdbNv1MORfQXIJ0E7vmGNh0VA
         PhYg==
X-Forwarded-Encrypted: i=1; AKwUvBz8hZAIttWbYpMwpn6OWfi7TbFnBxfiIWzaYn6AXnDlyBRfYPSIGtIdY2yEEKhsYST0OTKDhBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/g9la0nYCRZg6rg/8Hfit4/qmX1pYFW4rcfMcWk4EIr6aIIHv
	vJiz417v3U9SSdr2RyaxzeQ2EkO1AVrjctwo/puu+t+RLFunlfiLd99fdOdQ7Cruj2I=
X-Gm-Gg: AYBFou0cJmW+v+JySvcbWNtgCe1l5ESJjUQMoY76o3a/yzSBjqS4+GFeHRluxtapiud
	g+YB3dQq3WpYjUjhTQ0XUE/vj+HCFhMvF/TojH0YXBtiQT1RPjGudPS/S8wVCOrNTaER3WP1j7V
	WPkaqTOGY169a1Fzvg+Fqq5Yqm9EkmTfALBFBlpXumSJG0Vtr1DheNNBsc8aQlq3TA6mN8mmBI8
	cqVMYQMv/hkNT4eZ1Xqt5Lj7/6QpiXnYDtuXVFqsSeuZHgFTkmYvvVVXCfHHhJP1UjB+ZTJDx2t
	Js55TlZQkSGq0Z18zOmxcoxp14t3YOSp3CHXRs8mjGBcFCP7+eLeIkRE8v4mrbPElyfoQL/R2DK
	pm79EyY6/2Nv8Y4/iZZH4sQS/vO7pOdKuP/TivWg7ebcKWu50JZIdhMgVMbz1Uo0CI3n6ZUeX+O
	C9CiYYSbB1dLPeAqq7qyTSQrC9ilc+Jo4hjnVVwq9qXJUEFF7ilmnK8D3ptGTskS82xyNW3wU6s
	pPJU1v8SHaQ81Sf3X8K+5wLL/IwtfVrG3azKJdCagib2OV/Tx+aZAB2IGFRbpcw/aY0FsyDJc4b
	+EdGCY7CXb66SKrF/KQLAPN59uxFXQhq5boR
X-Received: by 2002:a17:90a:d44d:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3acef19cb63mr7592251a91.25.1792455628530;
        Mon, 19 Oct 2026 17:20:28 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d6df89fsm1694273a91.11.2026.10.19.17.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:19:20 -0700 (PDT)
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
Subject: [PATCH net v4 1/2] net: usb: lan78xx: do not update statistics after a failed read
Date: Tue, 20 Oct 2026 08:16:20 +0800
Message-ID: <20261020001621.2920-2-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020001621.2920-1-law.wei.jie@gt.tech.gov.sg>
References: <20261020001621.2920-1-law.wei.jie@gt.tech.gov.sg>
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

