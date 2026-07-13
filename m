Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31D4189A9
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947966; cv=none; b=AObonN46lbi+HH+j5gnraTCZQWYeLUAsUa6WZmY35DhSXTC29sLdvvDvMNIcWQ0Z47q5Jo1lfZzPv8tgdEj1gCzrGOoyyOE/yGLNOf1Awy0tQiPp9LxrAXxQ7kRcB6PAZRFW6SbRigXj2Tti4DGSTcVXjfn5Ja7d+aDt3CYAZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947966; c=relaxed/simple;
	bh=yIpwaIQ3XL+j837k7sGNNcyGvaBkKgpHdoGUX8DP3aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MV2byj+WoHNzIs/4Xfa+12HV1tjviDANe9kgUCkVFzOBFMhem/er1WtEKgfZVjFn4IwgueJU3iarkve7B6TrqYTnpn2A4n8/NZECEdbWTWCq6Z/al6KbCAQBClu2zROdef/PxL0FxmWNPhTslIFQFjTpOTQN5APfoccU2nIq5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZsZlPld2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZsZlPld2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b77b150aso26169125e9.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1783947963; x=1784552763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0uLPM+01Tsv/yEFxBZFkTxOO3Vsml2pOVlgqkzc7WeY=;
        b=ZsZlPld2fZQbL5X/Sj/cgypz+q8pDLxHFM4dd4BU93jBdtU41UuHTcHBcqt7LEcyst
         8k2B2snI1Knl6mtmNNM1I5dbPCYNIAIw4zt3VJpgQZ8Fztl1GB1XzU6VIVWmPYcUOe/w
         qD6V8jgyAAeRRHfN6+0VTrw7tP16L8PP/yDJC8dLyBDJMtpLG3oK4qePQMjB6fvTYl4g
         Az1s1k5XJ/Qlexjh9Pc3XTiyKMQpxBaJ66zYDYQeX7s1aFgoUjWLmD5TlAUEQIb4TkQH
         JCbOTK+P7iuD6eVEgrv1UJgdt2VqZyijoHzI3G64r+NJw9h6OHGW9C0egbtIbK6gls0j
         Px2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947963; x=1784552763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0uLPM+01Tsv/yEFxBZFkTxOO3Vsml2pOVlgqkzc7WeY=;
        b=AWo4odsrPwgzv6jFEcYHCJ1NVpRiI7X8xoMwzPRh0xOfkWi1zl70Swf6QHql3cnGUy
         1yrjlzR/+ZTx3rjUP9p/hpYOaBdTdoX7utD4KOSUq7B8ddqBXX5fyt9oaaIQyansQ0nM
         HmmZTo1s4HKPBgItxh9JFSx1U4B82hfAt4jzklLjo38zZmbYru7GbrRr5hbpCnM5nAgI
         weghrZX41UTqmw+L7KJpSAh4SFIBOHyFBz7YtheJ+LMtGKb/5eS0pe+mHh/zD4AuZyau
         mhudb42or5srR4CAcJDdU/Yj4UBrPVA8+znKBbRwR1ukoeSfQ1qbuPAUct5qTPQgTGLG
         tTgA==
X-Forwarded-Encrypted: i=1; AHgh+RpMuPwCxzFiLTwq2uKXiZ5LxEuTrfKwa0iK2uHj9XVaNm8W7kyo6bzVrG1VQnE11r6riMwcZE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVuKb73sPK/LsTV62Z8UFaYso4B/RdGMfP/nLbPZ+3LjpIvAH
	khADEJbZ+Ninr3VUl+Ysht0tUxO3Y2W1aZDwDE6YHT7betY/o0G6wXVYsi8gOdunn2OI+rCUnux
	DqogE
X-Gm-Gg: AfdE7clr7fK16fPlpAhjvKHAiSKWvJSKxnY89+m1mt3TzCHP/LWNnfpHvTEDeRlDs5b
	oUjveKbm6E01AKgnM2lveGqzK3AGHakwbnyy9TGxIGRFgYx9L24AAgWo11oygtSk95yWVxsyWo9
	8LdsnK2D8MMwOLqN2JLw7e/dEuM+2kFqxKGfz7bWb1ns8V+HH1fx2KG0Vk85sx/VM7v3V26VudL
	Hy/qKidp5pjIumCknsz/Cpf2WVnwHZ8qZpRrF1HDJHMJ/fXZEx1OKN4DitMElME63jE5l8VXgCJ
	0aYkjJxwqHb9M4N1e0NSRrRW1kLFZXQu9PWDkv7C3hGFYXeM1bqgsJfqr5HUQocr3CojfW+If72
	jsooZ9x97WaQZ1StfKHBedrkfbmLJrodToy5eDQMvphD9q+UWbuMF5vpG0dIfCDFhZSNUxgPocy
	XAmzUilwmtt2JI6ii/exXa+jIJvviymbAgX9mDKCj45Iqn/YogAVmzZV63Q3VQwfZ1lp1qN9o=
X-Received: by 2002:a05:600c:a40c:b0:493:ee4d:5c5d with SMTP id 5b1f17b1804b1-493f882cb8cmr64144385e9.31.1783947963058;
        Mon, 13 Jul 2026 06:06:03 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6402:500:e91e:fe5e:857b:d0c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f273195d9sm25321609f8f.3.2026.07.13.06.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:06:02 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 08/17] i3c: renesas: Fix out-of-bounds access for newdevs mask
Date: Mon, 13 Jul 2026 16:05:36 +0300
Message-ID: <20260713130545.568657-9-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

When software initiates DAA (Dynamic Address Assignment), the controller
reports the result via the NRSPQP (Normal Response Queue Port Register).
The data length field of the response descriptor, which is accessible
through the NRSPQP register, indicates the number of devices remaining
after DAA. Consequently, when the bus is empty, this field contains the
maximum number of devices supported by the controller (8 for the Renesas
I3C controller).

Adjust the condition that computes the newly discovered devices bitmask
to prevent an out-of-bounds when the I3C bus is empty.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none; this patch is new

 drivers/i3c/master/renesas-i3c.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index b9784d238f61..c459e40fd5ff 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -703,7 +703,11 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
 
 	renesas_i3c_wait_xfer(i3c, xfer);
 
-	newdevs = GENMASK(i3c->maxdevs - cmd->rx_count - 1, 0);
+	if (cmd->rx_count >= i3c->maxdevs)
+		newdevs = 0;
+	else
+		newdevs = GENMASK(i3c->maxdevs - cmd->rx_count - 1, 0);
+
 	newdevs &= ~olddevs;
 
 	for (pos = 0; pos < i3c->maxdevs; pos++) {
-- 
2.43.0

