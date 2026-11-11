Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368875;
	b=L8wbkaO77110q8o+q+mEcZ5BKToAmOyq+hTZUghBv3aF3gdkFSDydbsVQ3l2k29/44rM
	 SWuC5Viqhyj9B/0wBWz8KRCBHK0xTGl4IllQ72WULV0LpF/ZytNl+u+TKqaHObvq/bNOK
	 7MMFuNpPld7S/qD9qKbvnsJk334Rlkxnjqxak3ZpCeYwnXDShFbMdkj6mMxnmV5DW/HWL
	 Ix9OrUOPGqobPh2alxviSbFRs8HTOnzZTP57QjFlOPfLr+DseNR20bKUCXum5OdKiYLAC
	 JfW7NqyWMy3HLtuGf60Vb4pAYroPjqJRNOwNf0PxYG85TIMIfvbIAb+HQ7dKnqilWPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368875;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CvifF9IqaFvqqpYZx+TpWw5r5slnWHeV6l3LdpR9Y6U=;
	b=EP9WSx+NAMqthoE61iFv+T+UCnTGYBHhZTJOg3E3VXmSzXQAGhjrk6gOTAsx4ZKhFuvY
	 zhGyZ3u7ZUFP9ZS/BYmJw1IWAZUkFu4s6ivJCHg8LLCzkgbcW//vdrU3D9F9m/OnrbCbL
	 VHcw6etlYhvwrq9UQVKXwd5YbfCXpiDp0P4G5vgOrFPW568J6iPVcuwIsEFLLO+Zff9fS
	 Kf81H92rdntVmu+PIRAXmoKzPW88MCPsJq9+xzw/LcUqJI9JO6j2Mn9rlGiZdfYLYDpzu
	 K1A0xUFgndarldTbWVFT7SXHeuIfd1Kwt0JJPf/F5OLsNLs93x9Rytz9eaVu9Ym6ZPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDvS8BL4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821FE606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDvS8BL4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC231F0093C;
	Wed, 11 Nov 2026 03:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368875;
	bh=CvifF9IqaFvqqpYZx+TpWw5r5slnWHeV6l3LdpR9Y6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZDvS8BL4A4zmZyAY2VH8W4Rb68h25+BmBjBgE+12ORqRS5uUM3SAiVNPiZ4WtfyEZ
	 GwycdhfIApvH0zGd4K/37B+8zi4ZORxyAYKGTn4Ce+ubyIxDCXDtxoqT4FSQrDsI4W
	 1TFF/Ffkw35Edjrtlw3KwUoEFwoPWqEduYb69+78kCzPEbip7ROkyjLhL4FDmyOOB8
	 jBBnc1kr7Ojq8pnTS6ICcBUo6r1jHgz8z0935wQ3j7gUw9662YWeNpFFEzlO7YP2UF
	 Is+gZLNJzNca349CQMhhM3RxDMf2rBYVfMsPkrlQcDiVfHDoArPnJCwOofr1NCQXQv
	 fVp57M3ZfizxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henning Schild <henning.schild@siemens.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] leds: simatic-ipc-leds-gpio: Add terminating entries to gpio tables
Date: Tue, 10 Nov 2026 22:47:50 -0500
Message-ID: <20261111034412.921658-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054744-failed-6.1-9523698252fd@kernel.org>
References: <20261107054744-failed-6.1-9523698252fd@kernel.org>
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

From: Henning Schild <henning.schild@siemens.com>

[ Upstream commit 8aee49eb939daeedab96a9a38e956ff9c81d4f08 ]

The entries do not seem to be stricly needed when the number of entries
is given via the number of LEDs. But adding them is a safeguard should
anyone ever iterate over the tables to their end, it also gets us in
line with other drivers that register "leds-gpio" tables.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230524124628.32295-2-henning.schild@siemens.com
Stable-dep-of: 9523698252fd ("platform/x86: simatic-ipc: fix platform device leak on registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index e8d329b5a68c3..1a1cfdad62185 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -28,6 +28,7 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
 	},
 };
 
@@ -42,6 +43,7 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
 	}
 };
 
-- 
2.53.0

