Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B5D33ADB0
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435236; cv=none; b=HmIbZeudN+g3haJQ2Sh0n4liNEZ3X7hR8OJH5IokjrIsEy5v1IfHGCPgU/jAjtPwtjtSjxQNP3Mmk+R1dnfgWGnTizIbp4rLZ+4dxekGQLfhmF4t7Z7EelxghGn6j+MoDxIECjYiuRbUhNxBvqgo3FUP18hf3ydbveM3B1OayEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435236; c=relaxed/simple;
	bh=CLoTbPNnFD7Nf/FWMZIj87k9uF5C+XkJTmib7IEKVno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIfjWXM8vIaqA31jjYcyU4uXdCiw2n5X+X1rsNvurZYeyxHMxMkhRqclodcIvFCrKjDFbW3v4lIQY2RMD3XEgeGP7moA22/tlEGs4vFdkeEt35JYkLwkt1YErB8CzvQ0/iIMhgnZfdPfEEJHVPT6Yg1nyc0neaobkfT1mmvxv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlKJnuek; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlKJnuek"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91219376dd6so33218926d6.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789435230; x=1790040030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qFEVv4dcy08X3Ik3HgrSf1qU8ho0jjZ5Mt4Ngu5dZIw=;
        b=LlKJnuekpTYOvLF203ixtRfg2YfTgXIfAJ6c8MOe/6akF3oOyTPXLxOpd5LPDdUTzD
         kbed14k/V33uMFqHASt5oScMev/oITKYdfuHSWSf04LhAOmUEQpdqIEtyW2gtvpYN2f6
         0LLakiEQ6lWm4wQ27wV5KLYEZ11Z40lw4wuedXBpL3x29ilDR1Rz2DGbwqBnvR992XsY
         ETEg8e80fKMs8qZAd443y06Km0AHqyiGbjofe1hPcBMaD3FMbG0wYXRSiznBMT4nH/Xc
         f7ZnEN9MtNHwIK5ZqNmcdTRKFW1u+gQhBdG7sUMYPgqEQ1MU5lME+Hx3LhtZ2VIvhkyw
         SudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789435230; x=1790040030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qFEVv4dcy08X3Ik3HgrSf1qU8ho0jjZ5Mt4Ngu5dZIw=;
        b=re93y/hdiXxn4WlC+crwgRLDxMHMppiFkQZD7TTqb9lRemCA4ETEiEiCExSqZWXFfM
         5tYNOHafpy1ekkEGx/ZnFRbT9Jg9UGb32eDtMJIHUq6mMrRoK4/KKMwHpW+hGN+1RsOX
         odOEFObJ19C+x/FJhi9SKgEtTXQX4fFteV+rwOi+YPlYJpLWiQdKwxfTeG6XtD7JwP3A
         pPjPBsSFsesMyWtfjbevQ+5elR7XXkqyLF5L6HYchNzpBW3OkjDE2ByVFlIDHUUZ8yk8
         AFXPJp4VaZwTCfq9Bf4t+4flzGhcmiNUQY1N+Hmk8QJP/iX+HKYm2s85mmPjkQlqiXAj
         JxAg==
X-Forwarded-Encrypted: i=1; AKwUvByEVxwwCxjHOAlOiSEGMSqdV/KKCRqxI2xqQkl5Y7/J5Vx6WtmnueUDfsCsUuvUseoqK0sjbis=@vger.kernel.org
X-Gm-Message-State: AFuF++lIB4U82FOMdNipuXqPDCI7gY2sVqtV33g16HAjam7aJNqZcS8I
	O1mOGlyaI9ToYv2ORSgbgN3E//RrSzQoEZ7MltpMLu6YquGUoagvWG0=
X-Gm-Gg: AYBFou237IzmP9jAvJnMfRO+1FjlbjpU0lPWlyMaHSzbrxj6eFoxzmCDLcILYnFyHD+
	8MJeNPVOh+2iI9mJSMgX1+FbuX1WyKoWN/JxDRZZyj9sqFMpZwEm446jz3vRXWhsta+8L5D8iak
	KO4omGEUbjtH93GJJho9DIi3QTcY/d6LQBbt04Ahhdq5y8gZchXCKYrdiUt+pIvNl090edcEeq7
	j38FHzCNFTeRKnb76RSHqq7f3oAsJAGmvrDsYWsSGZRoVsVVXv8JPhJs/jRifiq6vMjJEFhXESt
	IqjSL8Pxu8u79doawo55VyiNv8PsXpgwdwQWi3tuXbGu2E02xjgKQIundRARZPAWql6Tbbycc+M
	Qboj61ZQfe8cgI17uBicC/buZdQHnwBWNopJ05aFUineLH1WrfXjcm7gIDvCwKglCZTF2EjIIzj
	bvt4hyq2kDlQYapEoz9iY+dSZTS3e/fpZKOj1K9rTgB2rnInpLKiISlsg/X6lXMPeFDQ7m97YkG
	CybYNLmLDtQ9+pLBY28ZVcutVtgSH4kdYeAQmZRiAfL+zP4Rp9NrrXNCtL7oRpvSTnzsp4doypQ
	gTsQJp4aM3iAvFPMSr3J42bGobdm/yhOuJn0vMDT22g2QUikpCKobNkPrXCZ3ZZcb2JS3Q==
X-Received: by 2002:a05:622a:1bab:b0:531:164:fa73 with SMTP id d75a77b69052e-5310d0005camr81499831cf.32.1789435230101;
        Mon, 14 Sep 2026 18:20:30 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9121a62b783sm91141946d6.23.2026.09.14.18.20.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:20:24 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] usb: ohci-spear: disable controller wakeup on removal
Date: Mon, 14 Sep 2026 21:20:10 -0400
Message-ID: <20260915012011.61874-4-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260915012011.61874-1-mhun512@gmail.com>
References: <20260915012011.61874-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probe enables controller wakeup after the OHCI core marks controllers with
RemoteWakeupConnected as wakeup-capable. Removal does not undo this, so the
wakeup source can remain attached after driver unbind.

Disable controller wakeup after removing the HCD.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: a6eeeb9f45b5 ("USB: Update USB default wakeup settings")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/host/ohci-spear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -103,6 +103,7 @@
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
