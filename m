Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793565539;
	b=ShPs1NpTOCJnC3VttvpZtu+ZMY9E0madJBRdNR4f5RF7T0viHHS288M+fVwaOfEzMDVV
	 PEPWoObfKy58NO/uushqKIMIs74Fn3uERpagsUCas1iqws8Z8/hPE1AnJST3zHKqtXtXe
	 RNzF4ZA+elQdjOKtYwnYWlKTsPfU0Gnf6oEXU6Njz+mszqP5Wl34ERTNTl+zZV0irWaXT
	 LGy1DiGnetR4uxME5Ugc14KeprsQUM9wdY85ZblB3pjYr8vb3DiMwWMDvjrTOoahGi461
	 mbbUrFNU8WMcEBC+ianPhRk/5Jr/FdqoEkurkpMRptITyYFx8xTINEgP6HwDHPXjrwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793565539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6hl0fNtq+sxlcvosR7FGpeyB7ZdHbe6gYUJth++4euU=;
	b=TTTDzG5a6x3qJe4YUTnCWxg7r4zhs/OehhHoTXNBAjwDcRwdC6MenicR4EgJpyV3reh/
	 3Ehi4TK2EWSRnNCRTE+/DOM7nhRANktkeYPvkFwZklwmZ7kJgp/fr31sfy+7q3a61zlAZ
	 B99hPfHpwhRnXyVkNmIZ401QMUaZVIfNuNM4FLw2eBMZpdqXovBf7c9Z4UX3MLINcu/jR
	 2xpl7W/vVt352CoKFQ/WW0tqVhMwqLn8kyd6pcs8ddG9PsDgGjiVIkwh07Uo0pcPLTEqU
	 Qbl6XqExE9neCsIhixIeL1tKqYbk6k0ETQ6gLmVstiehDySkRiPW205H6/Vv9SsSwKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zawl8bA8;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCD4606A32D
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 20:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BCD4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zawl8bA8
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so18666305e9.3
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 12:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793565537; x=1794170337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hl0fNtq+sxlcvosR7FGpeyB7ZdHbe6gYUJth++4euU=;
        b=Zawl8bA8mEBCo25eMwIaKTA+je7HDjOAzL4rLuozmQDn8Onl3+pP0iI+PKyo+L6UY4
         f9JKAZgkeCmGajXPgFb35LQEC6FIgqhuTXQqGtOv2rGco3noPz6qPIQziFIMNcv1Co2z
         f9nQm3l6ZjMl8wMDBDJaTEEbWy9CnWE1wmTlhgxfAfnnvsYCNB/7X4lyZ/8AMipSZbEI
         L+uuU7WgbrhTzqWfC6xKDPyn3UnhzWOHPNGtyKCZqh12C3QUU8kh2uMWwMsrgr15JVyf
         FBvFdq13Wwol/V6EqBSb6OloGVsfpBF0oIWA+DEPXZMq5D3lWEwa0zDnHmOYsMe4X5Tj
         sV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793565537; x=1794170337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hl0fNtq+sxlcvosR7FGpeyB7ZdHbe6gYUJth++4euU=;
        b=zx6DFeEYPhtuYcj3raHOSsZ4RcJvAiw9Nm5xpvysSSl1DjvjBNwHZDo2Mwb8VCJ8vz
         /EfazIujXj6H0CKoVU8i9iX1yAXv2EZU9L8kEFeh+ju8rzPyhxeQVcAdePmYenbkRJP4
         Jp9IwCcC2TflgwfHHxq5d47a0R8j/WK6jJdYPIXc2ZWEpMS44LunJhuYwb5DlVsFX5BF
         ptQnh8DuHjVcSqcpF64Bid1nfLAv68+3ycAxscLUwgiP7XX3vw+5fdJE+P+71l2fKx/x
         nsJUAaMX+NBxJNnRDWyQ7OjkGFi3xOzp2EINBe0HMPHNdFpwAvNvnAWZe8nWNautuc/a
         G90w==
X-Forwarded-Encrypted: i=1; AKwUvBz+e8+TSg+1GzMfEZwUNun409IIZiBC3iQPklR/v3ERf786ur7hDMoDGQsOznMJGBq0/OM9elM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK53cZz5igXbp8Glm9GD9EBBnJTx7/9gJz+HOBQni9qZaTdOfnr
	a8laFdt9GsTKZinPQawJWbxQatBO/g0okogBAWDpLgqN22UoAxNPvmvxrJEM
X-Gm-Gg: AYBFou0wsWLwnD0iHX9GJ8QZ/uqJddMisoqUH2YB2GD1kqrB2Ydv6I8d4ZidhpWjuXJ
	69/U0sSYK01i+wc9QwCMvdBK+LlULV7aC6+++rAy4gYfxOZ3kRenfcxvP1pE8ardefxSxbOBc16
	XSPUaVIXK4/8pFJeBmKZcJETkawZFUkYhe400Yd/duvpIK/s/kJQMBZueYJ/W+Fjwh2OQitx676
	lVD1xHHTOD/b+OEN6k5a/ZtUfsKJAXthpr9z1CuT3EXJarSg2qgIPZL34HcJZIJN2CL/n3VcMdI
	LwlTRughYs7jl/zsgU8hyzrshhO1EMGuBCMky2BShx0VRwgJIagTOvc9w9p5UdQYJwdegnOfjDm
	wu+cc1fh3MHTZzMISUiIc6jRFF4HcxKkZZGnXCCRmjlcHVXk88Hn5p/IvWHl7AYOIkgp8KD2ZI9
	w+v3pMFnsng2CXMMhpX/ikQLVTfp1A2Kz/J+PMhwFPoSZhW5DC03pXdF+8TfLwVym/bg/98On6J
	08GlGiq5tvZdhL1cUCuXpHpuFN2+LAqs1xMmtRoeXR/PHLWZMr06PPBbM6lz/dwf/dVGhrZB5Jl
	FdJ1E65ngZMI
X-Received: by 2002:a05:600c:c16a:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4ac16fa352emr197300015e9.7.1793565537319;
        Sun, 01 Nov 2026 12:38:57 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b72715sm15502295f8f.18.2026.11.01.12.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:38:56 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 2/2] wifi: wilc1000: validate header fields in wilc_wlan_handle_rx_buff()
Date: Sun,  1 Nov 2026 20:38:49 +0000
Message-ID: <20261101203849.2807553-3-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101203849.2807553-1-tristan@talencesecurity.com>
References: <20261101203849.2807553-1-tristan@talencesecurity.com>
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

The pkt_len, tp_len, and pkt_offset fields are extracted from
firmware-supplied headers but only checked for zero. A firmware
frame with tp_len exceeding the remaining buffer causes an
out-of-bounds read from the 96 KB receive buffer, and pkt_len
larger than tp_len leads to processing data beyond the current
packet boundary.

Add bounds validation to ensure tp_len does not exceed the
remaining buffer size and pkt_len does not exceed tp_len.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 55a77a2e32887b..e7e1e5a7960eca 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1123,6 +1123,9 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc, u8 *buffer, int size)
 		if (pkt_len == 0 || tp_len == 0)
 			break;
 
+		if (offset + tp_len > size || pkt_len > tp_len)
+			break;
+
 		if (pkt_offset & IS_MANAGMEMENT) {
 			buff_ptr += HOST_HDR_OFFSET;
 			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len,
-- 
2.47.3

