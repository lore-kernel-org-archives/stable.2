Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439454;
	b=DR51YN2GTFCBjt6pqNy5YqaUV9GZE7RzRcR1MshfZpADprW2HHoyjrE7o9neVRKfkAII
	 iLSEyUfPmnEmyr6d8liiYViraXFT4NmHzLoSoLvDD45nE4YYMvodkQRrMAcDcMxPOKQMR
	 skhT+oHCQZj1Bh5LuzTo4+sKwD4M9eVNuV1ZiElA7ZlmMOIeUYGyB/mAzRF7JwRfzeUga
	 k9L0FoselLeRSR7a0ND8yAvS/C+v/K1ONre4hlo37idkPFRiLQZVmDUOPS4ZAxPi91MHe
	 tBwgZIKWWRRd4+YzZOR9fTKnjbgVZcPG/5JtPmpYm5h3/dXLq4Lz6MwtyFeWFdiKiWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7dSUYZEgNCLN4peeDNcu8u/0Z/HyiOcYEuA7oi+4CJg=;
	b=NBMBPK6ODHQ1rkIXWYrJNQohAPfp9OisE8jCCClZniI+syk0yMRsmCgma66pXYMs9p+M
	 52V/XPx8K082/TH+lTg3yRo0cA09ig0nklZhSnIO3BjgoSHsLf/PDmIC5ZcrB9OfkV71J
	 al0eb04GkiiQEdFs/l99UbWg1agvoCUIimsu26xbvBQfoJ6BECihhKj/L1+pCo6iu/1YF
	 7pxZ8+mrOjhfP0oNFU1jzRtnEMSzSoKRUne5QrAEbTJRvqGg0a6sFDcdOCo40qAHDbiu7
	 8GwRzRQ5vbGxjTv67S2WAryGEIHbJ9qizaIhFcNFTvT7eNZc99BtEFCTqWh8rl9jGQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qpg7mrlE;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB8E606A337
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB8E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qpg7mrlE
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so31794445e9.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795439452; x=1796044252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7dSUYZEgNCLN4peeDNcu8u/0Z/HyiOcYEuA7oi+4CJg=;
        b=qpg7mrlE4nx9XMuqFOY5eJZKNJ/e2FFVQF44i1PR0LIdAWJot+5EKNuzCEMHKDDoZM
         3x/PA+x9v70n7md58LQRfkW3JxPqmYL5RerRnSEe90ukVisxYXuN7b3im7TrMRxR+tKK
         y04w3vOyY2kHGHPMObdgCo6aZtAijmoZGoKAg0tIarIVw9kpRFaTMJtNgxxBI5unpcTz
         QlSxo0EqHTAeWXnLvLcVpGZm1N3npH3kU8LZUg2xS1uqB3xU6OuJROrZafzsizwq5xMg
         UfZNlQqPULlRWv866+OkKKAZNlDNWPXfwV8B7qLh7fOWj5FfHazQqoeX8sS+lihCriAb
         C87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439452; x=1796044252;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7dSUYZEgNCLN4peeDNcu8u/0Z/HyiOcYEuA7oi+4CJg=;
        b=WkfePwk4w7bWSL6E3lCNzkf40+FOqcFJ1eAu1I2hQdozJ5rCs9ncGXz3vNfpdHzs1r
         ZLXxo4ieTBVPwfEyCAB18tTJtdGfe3RhKKi0pJrbayQUgI7UtLFbzGBb+NUz0IppoSW7
         sr+Eu8JV8C9vGB+oy5R38GuquzYXdboKlKDZecanhkGReWdKXcWzYyy4opY0VMDk/neL
         sh7mIxvtCREQvT0fzBUfdSuhkzcXTeY+E8U2wMyyxepBQOaCNrx4zNgvZK7bJy7AJiHi
         h0FAVApqvgRKTheLDrutfKhA219XjfrQtxQ2/zJfCcLtRa7Id46mFatmohC7nV0NW/IK
         S77A==
X-Forwarded-Encrypted: i=1; AL+hErESo3wLdt5RuYA2UN67acB8PMra9gnsU5JKrkKusETy9Ja+o/W+xkMQgxxM4AEjzCPUqfLwY/g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pqTaNm7YAsLXkKpS9VHuT6W6ie6O7RR+PLZ95pUbSHEPzmvnd
	lbiQEnVYMOgjCcD1lzy1wzE9ewWDyLia6hA9W3AxhfwpaybUUaXnQuGL
X-Gm-Gg: AZFdTZdzac0vy/teYAKjTvH/xlQ6oEFTV1RLRiWh+ZyXsg/CXp6g1NrFVbzdFFJDoXq
	3IBjOC69AoGF76m6B+yPIXDDQzEtQRJE7UKEN3YlsDonIHN/JVn4DWGxj4RbNHIrB35OuWuZBFv
	T2oB4Z9vtUlNcapYAVkabAHJa21t0eq+XLGrIYYzBL+WMmR66ucrZ+1o6UILC9KKN/YZu0cjDUd
	9vMhyRtKp7lO0tvQ8CFuTpkXBqJcDog5QMnFbv84dXvpHtINannzUmbePR6s84w0CP7rXqAJa+a
	GFyvOc59wQoWlrUI+Prrnf4L8sLHohdIu8Qxl4+ZA4AhtWPBTGlv72UWyAZVS2f9NYM56rsNQdX
	TuMm8c/VscEhJJih6S72JcRtvUOzzbMr/AlJx+TqiLWnj9NrwETLjzW4UC9Q2CZYdFDPgpQbg9e
	eRjLKQu+Q5BvOT81DIE4MhjBYH5D7sskFY6XLHZ43wa6NtnQxzOwe+QJZo+Z/afS7tcek4W6+HN
	OqZHdTaH3PhWLM9YXAuP1qlCpRUdqaBsZ1wTiJn/XImmupUI03Th1QlIg50ldnlA7xxr6b+ZTf7
	w/m86Hhtl6B6IPlv7ci93P17sBH7Rubfp2i+466ihnyMFrEVki5RYr8HGVvjszpeVGZvgFzczcN
	SVzkMVEbzoulirAioNpd7WoFZnunT0eC89eoHMQi7RwaGPGg9oySZIJweFtXHR/vvIT0Ie+NFhL
	s=
X-Received: by 2002:a05:600c:a087:b0:4bb:5c92:ce22 with SMTP id 5b1f17b1804b1-4bb887fe887mr233753995e9.8.1795439452477;
        Mon, 23 Nov 2026 05:10:52 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:f273:2c28:9387:7d5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm400714065e9.7.2026.11.23.05.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:10:52 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH net v6 4/4] net: dsa: rzn1-a5psw: Set driver data in probe
Date: Mon, 23 Nov 2026 13:08:52 +0000
Message-ID: <20261123130852.3420491-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123130852.3420491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261123130852.3420491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

a5psw_remove() and a5psw_shutdown() retrieve the driver private data
using platform_get_drvdata(), but a5psw_probe() never sets it.
Consequently, both callbacks return early without unregistering or
shutting down the DSA switch.

Set the driver data in probe to ensure the remove and shutdown
callbacks can access the private data and perform the required DSA
cleanup.

Fixes: 888cdb892b61 ("net: dsa: rzn1-a5psw: add Renesas RZ/N1 advanced 5 port switch driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Clément Léger <clement.leger@linux.dev>
---
v6:
  - Added reviewed-by tag
v5: https://lore.kernel.org/all/20261120002549.1908299-12-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/net/dsa/rzn1_a5psw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 7fc62956c5d0..4925d24ec2a3 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -1219,6 +1219,7 @@ static int a5psw_probe(struct platform_device *pdev)
 	if (!a5psw)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, a5psw);
 	a5psw->dev = dev;
 	mutex_init(&a5psw->lk_lock);
 	spin_lock_init(&a5psw->reg_lock);
-- 
2.56.1

