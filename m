Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804943A7E7
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233134; cv=none; b=PpxQdVJlNiJwo/rPdJRAFgOlpgeYcb4ZUBLUpt1K9nupSLmMpqD3QLT1OlDGSbUFi3L/pCyBxQ4fHetAKUB9R5e5xcZA3ybRJ/mc2PdCVO8nAgIcIUKj0jJ7SZSu5UJzVEatc0zz+xRK7xgt8v8cm8XlRZu/g7Ha2XuOLAos1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233134; c=relaxed/simple;
	bh=0udDt59MpBhkl1PfoDwulOFVVwnC/G5KphRMorcHheU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4XN6+m5yA87Y0zFyOo1biK3fr6YZARcLJbsakhYtHPEUEoC0u+Z+WivbX9tGG+cXkGukfaZYCR0UXGQSF0prY8HNmsjXIYuckLlacZQ4jx0FeXK/GLV4qCv68067iEjop25oy0OyuvRHp7UmGkHDFa4gUg9kuss9RIQu5BuQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGOnhn4N; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGOnhn4N"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso1382173f8f.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233127; x=1790837927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0udDt59MpBhkl1PfoDwulOFVVwnC/G5KphRMorcHheU=;
        b=YGOnhn4N90wa/GdEq792XaKn9/RwfFLbvYYhaDFzmacDRfMLflPvAF3TOa+p5LGTKL
         pJc6w0x24SiikWUV7njX4ffrIrTsP4qfRBh1mX+3c0OW9ytT4IAqEcns3mVmFor3Epbe
         HYk1XqICQnreXHJlkvreq5+xK1Q85JELWmiD2Ma90q4EPYMeB8wwFMpuJDNaOsWX2R5E
         6IVtNVfoxLfmXgenYREPg1WC2ZsHBWxiCtx7r3R3ulPv/dd0cHfWrTF7tz0dQ064M1il
         GuUvk6HfP91ge+R+Mw1UF4cos95L37/sQxJ36jOzp2A701je+PBEEyBR1c7Dg4bK9bDJ
         DEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233127; x=1790837927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0udDt59MpBhkl1PfoDwulOFVVwnC/G5KphRMorcHheU=;
        b=sUtxwJWnx7NiNxgh2O+V7xLafKA4vLil7w9qmd6vDus1eUd5KFrybrgqwZcdiErdFy
         dME0hkkKlFWwnCnBMoKrdZ0cFOGLsAloWEcc/PmW0m0U44ERUxpv1AGL7cM6UtmMFno0
         ya0j1y9/p+vxuPYyGYXy1bj87hLPjjKrj7LKsyHF6vjcSK7bKkCy1FtbuCMSkr5RhvTG
         I2pXZCf6s2cTEOM2ziKcy5NORHLABtlkhQTZEqUOh0DOCPghLn0KaIRHBvP3lbW74/Pw
         /4IVu4VjMIcqMJsPyZkwjA6bLQinwBV7n2l6b0XcbyIFnoHiZq4D0kU1EMkCebERFjyl
         i/Lw==
X-Forwarded-Encrypted: i=1; AKwUvByq7UVCpHkSBYgwzL33m+FFsERncYOizKEiikz3MShurYyCnTa0omvHBpHJpjCNMy0VR6RVRbg=@vger.kernel.org
X-Gm-Message-State: AFuF++l5AknYFJY10yZm15uXFpFsA/Sq6ghoUy18VGgzG3qfMm0vIjcq
	AbIJRt5yurhSKzdh/3ZTIMYRuTNdU7Y84p6LV5VJ0ucRN+1brkssnS9p
X-Gm-Gg: AYBFou31GxaUb7rQQGwj+fdtajvBglsXwaBDYaMZdVTa5zqreE4BCVXtL1/lvtHSlas
	ZBBwRmEFsgRvmC8T9wIruQygoTjGQLLz9hQAW4nrusWZm48ZIS1DSWjhWadHiB4D8jgETfUlifE
	e03oAYe+lIL5s7qfq1S/h/HT75Og7nzEBOFZ3x+4VFTvUcS/9B986TdMKZgMbXvxvDp9/hOxUZw
	kEk1xUD3fhH/tr5D9qtyQDhKLC5s0K8kqXifLAx1Lf0ahyTiKANE7yZQ8q+FKbKMedMHA747b4y
	PLd2/HVXYKRriqOnvY/OSlxhfwiqiSaEOLCHtDtK3PLRdSji65UMRhTs9QAuMU53+O9hsyNlzhc
	IWHcm5ihu3oCOnUGiiWiGo+p2GZG/gDyd2KOSNWS2qdh1iHA/uRpt/Ltllvjq/OgKK/lX+k6RJj
	VpNrpqqb6+5hSPnS95vbs3Bv6UPifbpU95bE0fiRBK+yWAWfjbUf3DMn+GRfXsJrKxIuvsGe9gv
	VUsEigHcq4FYylEOLY6+ls6uyogM21W0VAtaXLLURHsi6Swci1Ehk/AppiUnxvzubIHYzFD5TSy
	axRxOm0gjDJoxqPQOrqnnF6+umQPAESLRI2W+AWsBxMxafYU7fBBUj8IAay+gVf/usqwpGVv64M
	zO1iTeJj/g5R+
X-Received: by 2002:a05:6000:703:b0:486:fb08:2353 with SMTP id ffacd0b85a97d-48872abc9e4mr1788836f8f.31.1790233126966;
        Wed, 23 Sep 2026 23:58:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-adbf-6901-6c54-85ea-c6d5-a48d.310.pool.telefonica.de. [2a02:3100:adbf:6901:6c54:85ea:c6d5:a48d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889376sm9893819f8f.33.2026.09.23.23.58.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 23:58:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Justin Chen <justin.chen@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.18 129/398] net: bcmgenet: convert RX path to page_pool
Date: Thu, 24 Sep 2026 08:58:39 +0200
Message-Id: <20260924065839.56793-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260923140646.783275824@linuxfoundation.org>
References: <20260923140643.441954610@linuxfoundation.org> <20260923140646.783275824@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a small objection to taking patch 129 into 6.18.y only as a
dependency for patch 130.

My LLM agent helped me running these tests.

On a 64 KiB arm64 kernel in a custom QEMU Pi 400 model with functional
GENET v5 DMA, patch 129 increased the socket receive-memory charge per
512-byte UDP datagram from 2,752 to 65,792 bytes.

With the same 512 KiB socket receive-buffer limit, this reduced the number
of queued datagrams from 190 to 7 and increased socket receive-buffer drops
from 810 to 993 per 1,000 datagrams. I obtained the same result in five
bursts.

The page-pool conversion otherwise worked in this test, and physical Pi 400
testing with 4 KiB pages found no correctness failure. However, patch 130
was also verified on the Pi 400 to work without patch 129 after a small
contextual adaptation.

I would appreciate the BCMGENET maintainers' view on whether this page-pool
conversion is appropriate for 6.18.y.

Please consider omitting patch 129 from 6.18.y and applying that adapted
version of patch 130 directly.

Full test details and logs are available if useful.

Thanks,
Karl
