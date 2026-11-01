Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793565534;
	b=UVW6+uj7VgvhuCwbghRInURfebgt70OPRP7XNpcN7jhJrZq12YayAtVy2FHegbeBRvWK
	 uexH4zXy9MCUug8zhdu0hk0sLdPyyoojA51SBjkHNGmXr2+/QqE4llNKLAM4462xAXrzg
	 /yGfhNy3UHVvCazGHnv/suP+qF+RqGm5wm+WVAk6P7JJnEXeYqY5gMNQX3UNq8xo3eDUR
	 Y9vnV2uGDqZlsXAhuX782jM1BW2XsyFpJMlhp8MP3RAMC386ghDZhRpKjo/YWTmpP469R
	 x4hahUNIXuD/xDUHA2myOnamadAJ4kKRtqDrOJzK4OsuJ70b8yFiWfxKYbI1+FRIs1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793565534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uj5wOkKpVCiJDyEwPq73Wu031Kkj39ttXowWhA0DbaM=;
	b=Zfc8yaWAdcI0QTHn4cOTtMOAe9Hf38JSgcSMalPhTk/yS73D0vencGeJU4W0vYhyKOEx
	 ZiPp5Tr/QMGNMk4wUxc/8HY7YmTPwtaZblUdkX6WfrQ6yqm7b4DaRH54eYVTua9CVYuhw
	 ozowN7gIqvhAFKLPSSW/Oie2NiAAye2hmRibNcj2D5/i+9a1flkIT6aA5U3FxLGsnIcE+
	 /nmNZRdPPjY1byEjFdr/igCZpdKToe00QIyoBY7bg2eyxWqoCZjAYZUdfbE+PrD5i+8Zf
	 +qSCQ+JRqEDBWomB7jwn3ym3h8K4YO/212ej8mVvFhLXMVJ4cpZkoxMsew44VgyzYQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ESowRg6A;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034C606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 20:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B034C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ESowRg6A
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e47347279so1325877f8f.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 12:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793565532; x=1794170332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uj5wOkKpVCiJDyEwPq73Wu031Kkj39ttXowWhA0DbaM=;
        b=ESowRg6A+lK/gIIWPVk5lGgZ0HFExod/PFYaI7SBMeVe+Gut9yRl3BF9HoKBQw1gXp
         Hap/sQdqMWQRgVoUDVr/hiEiNnpAuH6E5KLo4CNV4t9dJivb5eBMZa2KKob7Af474+ai
         EigZOH89m+hBHyrRnxewhR/TsCrdpgFD/5GW93SLB5gtrFFePPIm4CSFyOTNFf8EPPDR
         80zHSL+ppR9HXSLditBy/wlsQDJA/7F0Khim93QtMg6qeSFlfsiwIdMC0G/JXAo3zQD4
         VOE09/SBq+6/tFvQDY8pXYvmcGs6x6ExJLuSKMFwtmCg2eEyQDMJEazY8t7k6mKKylxp
         ep3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793565532; x=1794170332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uj5wOkKpVCiJDyEwPq73Wu031Kkj39ttXowWhA0DbaM=;
        b=FfnUm1w81I0VKKOBlzhH9d4UjrdOOtxbm12Wu4wuISlxN5Ij5vCVCe2h/+uKCXubjG
         BYFUXhJeEHhtA3Q5AnvSCtx2RTAtg824OMpolAJCMp3gHhaIDdlVeTjZLaoPdYilLbzK
         kAVvcB2Jsj7k5d23iFAfyLjI0fRd1RSKsi+6XrukXk1G8FXckVkTraBK4Yw6juVihpQP
         i0qahyuej4JAvub0FR9AHJNPbIHhEtbcQ8++vR1Juk8S6epEewSLn+MMYj5TMaEJJlJ+
         nxk+EXpW8fMQNU3KYNSQyXDY26Ew1T5eFS/ofGP6WhqigEZilxVkE+X9van+ZjwGRVM2
         CTyg==
X-Forwarded-Encrypted: i=1; AKwUvBzsp+uN65hs2pVsgMEbVrLGi6v1Ul5WTR14aRoyWkRgP0cRViiWzLKobdZSnxlOdcB8cX3OzP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bhkqQ2JV29Y7824VnphtGEyghPsM+1dE7XrWYWq75LEwTiuaf
	nJxoJo9nLb1P62FExpMY/Ag5wV+4GKb0OyBJ0rElQ7zbKOPAQ+G1JSg=
X-Gm-Gg: AYBFou0DGLrDsByY+Hp+Yb/e6JM2F4cCT7yhBYLNlRJaQDHitOgyKDnRgsDS2f7aq4F
	/FGjEDdwnl2bHvWVBu+7QtJ8QpT0AV4mcn5gPK/q9VHdZjdj7TnzrxPFS2IReI/H5q/pd1YlK+4
	tffahojrF/IjgqjhF+5YcbH6Sg8utkflRe4BAGCNe453t7OnMN7qA+ebm1BQjIP0JaXu3i9bYT4
	kkCPfHU1or2NrY0LclfaCdFTGxwVYzx1DVKRbiRninwtCczzN9bmVPT3fLf2/yP8yhfsne1FU0l
	DnBEOaFAZJwLRwZSED1aUiwLv8Htno7mAxpbmQHBlzC0rGKjx6a+AAjWElRc5kDzAwaMUJoEHl2
	VaI2ZwsfVuCZJPvPzhG7DoQFQgkXu0wCA0G01C6JjBUlEQZfa5r13uJCySlRjiUwdiF8UEoFnKy
	UgGfNYFI0yudUKsnAIMvF+AxDLEGCqM6687N8xcVJAj+XKKgsRUQ/PR1oauBkdIPHL6hCSAWMPo
	6nZLSUWrHOoZOyqPKSF8sK1LB/rbnaVDdvS/S5ktQNB+0Ejy6kqsF7wyyElUhfSkWWssCc0l0C5
	IZbtW3wLO9QX7DnAhsdb/7ApQMnwnH4u
X-Received: by 2002:a05:6000:2085:b0:48e:7a41:d78e with SMTP id ffacd0b85a97d-48e7a41d798mr8820852f8f.19.1793565532007;
        Sun, 01 Nov 2026 12:38:52 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b72715sm15502295f8f.18.2026.11.01.12.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:38:50 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 0/2] wifi: wilc1000: add bounds checking for firmware-supplied fields
Date: Sun,  1 Nov 2026 20:38:47 +0000
Message-ID: <20261101203849.2807553-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

Two functions in the wilc1000 driver use length fields from
firmware-supplied buffers without sufficient validation. This
series adds bounds checks to prevent out-of-bounds reads when
the firmware provides unexpected values.

Tristan Madani (2):
  wifi: wilc1000: validate frame length in wilc_network_info_received()
  wifi: wilc1000: validate header fields in wilc_wlan_handle_rx_buff()

 drivers/net/wireless/microchip/wilc1000/hif.c  | 9 ++++++++-
 drivers/net/wireless/microchip/wilc1000/wlan.c | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.47.3
