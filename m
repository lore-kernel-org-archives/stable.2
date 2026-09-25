Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BD4AE13E
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346766; cv=none; b=PVkUVG5JK7+ZflsPrR+iqricLryGPzjb393KsT5AYdGs0JiKzNF3J1jV0uG1x1SCEhwKRLFLTgvQjCAGMxoq0zg7HX7JuD+Shf8FmYGeMRuNyBK+AaUbUKN5cO3fx2usUsoODQ7ADlZTxpqedzqSioyZJH7EWihpq0KLsaK/HII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346766; c=relaxed/simple;
	bh=JfjNdOkV6czIA57rgjyzP2vkzS7QeX8zyexGClAHNV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahjKfsWlMv80yxaV1hK8o22HgYdP1rE5nW8aTEpYBXf36UTgQxfd4ifObdh8KZ/fCL4K0rd8j/2pjD2uxsdJw/91ccs+UNTEWXbbBxNnw7ZEHPCCbV+MVzapAz1i2k++5IDAx4u4cqCJ7bRFWjN4EoDkltiwoN1YWRbzqCMDrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR6z2bMD; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR6z2bMD"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so5646665e9.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790346754; x=1790951554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/6G1/nB52qdf+pNA4653UiqYpDMxleEfU1TnV94wJwE=;
        b=hR6z2bMDq0jmYglEjbKA6Xre+kvsAjX8/IzpTm1EJ6QgiwpvJCih0EXAlrxlJz2W3A
         wJZ1JOw9THj8GCx47p+kfz36Y/OzHfp2zob0r2RoDe884ozVMZ5HbVVJ1ia61z70EGMe
         PHefQOn4mO0HWamibHpSI2VrdReQecoqKdUrQFB33grsv5u6DfeHyCJDBrIN90u3oY3j
         N0O1lKaMOfm3rLwF9lZDOMBfXLfVbrDaSnrCGejig34YxvmBEYnumAZ51grxe0aj63nl
         ScL4wKQ5r5UD4OM1EBiOmvSQb+IAXAoVltLnaKAFjsQRIGBbbHNED7YxycdxVDtqWsoS
         Yriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790346754; x=1790951554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/6G1/nB52qdf+pNA4653UiqYpDMxleEfU1TnV94wJwE=;
        b=iRdNst/vDRH4uuyWFvg52HZr+YfJr+rxsBZlqoi+B5DVA7Q8hGrLFxOKyTCbEWFfrZ
         DyHzoA1UqjVNWGCzuG4T/Xeedrs7nIA2P/GnDLZXs9ZrtOq3CaTgm51ZnYNf5C4ioFdZ
         GmObTTTxG/s2U9G9p1ns4t/0vcx8QbS9+4UXhIv/tmAXGsnva4bkNskDJf13uw7PQ8a3
         X/57XaR4vbOgoVm5wfaSO6UZYQWDO4mn3GzNx49caIKp61FIrEIjTe9Kb8oWd/yxq0/Q
         RJW+N+9X48D6fq8dnv68lZbwlIDS4gHY7nuOCyF/j7ApvAG1sSV2MZFy8mwgVgNM/C+E
         GE9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzc7o4OGe3Eb2z9Zgs9kjFaNu1ubSTntVoDynIC1qykTt7Vog0T301rDNVLfVN/4TcRFP4OEVE=@vger.kernel.org
X-Gm-Message-State: AFuF++nZuqFj7BB9KFP3hQyzTGY8XAB4Yx4JCtWa1VxMmdOpjvhTrRAm
	+WSkXKgbhWUXBJqLtVLlR2FFVli/pScl3l4HNApqfeMXzQ/QG26GvKgJ8jY690ng
X-Gm-Gg: AYBFou3NXdG0XU4lApRBvJrqUMxmvQa3oq0muufkileYRa8cZWYIyeXCta0UI2mnO/N
	3pujs5dDwGLSLhj+zXNrFq67Ab46kOg3Y0kDzyls46QOv+W1GivvjAj0Kv/YRPmYbqZMzKXkbNR
	2gWrhUYfQF07pQ7/hWcSz54uBjZSp0rnLmYMPDVSRg9oZxDsvAMTVZN5a3wcqT2VdwK0khqTjGL
	S9o6SgHe7sILYIK42MUaWgbg9lrtYQPPakZ3/VbnYXMLmzX/zDn2xEPtwQUDzxxRlOtyo8DaANE
	2FiDawyzSr9RyD7G/7dJsSneD8iM1TqlDwhIzz8YPMuGfmgNYjcuFS6XqFhfQ5UTWfp6AlwFFhg
	Fv6zOggGJPRxefGAKzvMchl6RmAp6NGpO2OObmkrxN2qpbXL31zzVHOT/CBo1F2Qq00RsgdR94V
	7MYCfZ2VWPE81Ca1nzPcIMWj5pEYr8A9ChAh4JYqOTjMmLumJMxKb6gZ1MuI2cm7HM43oOrp1cy
	9gI/K+kQrTWXEXyAe0fRyaCYzRRgpKGxp82UmvDIMzcK5S0G1zS
X-Received: by 2002:a05:600c:4f47:b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-49ff06ed9c1mr51897165e9.28.1790346754282;
        Fri, 25 Sep 2026 07:32:34 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs197761.centertel.pl. [46.134.111.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a746c57sm7034706f8f.35.2026.09.25.07.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:32:33 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Jie Luo <jie.luo@oss.qualcomm.com>,
	Georg Seema <georgseema@gmail.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Brian Masney <bmasney@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks enabled
Date: Fri, 25 Sep 2026 16:32:28 +0200
Message-ID: <20260925143228.386299-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813093351.178419-1-kuncy7@gmail.com>
References: <20260813093351.178419-1-kuncy7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please drop this patch.

Gabor's fix for the same hang has been applied:

  33f9cb56cc28 ("clk: qcom: gcc-ipq5018: mark 'gpll0_main' clock as critical")

It addresses the platform-level cause: 'gpll0_main' feeds the CPUs
through GPLL0 during early boot, before the APCS clock is registered
and CCF can see that consumer, so the first driver to drop a runtime PM
reference on a GCC clock under it takes the CPUs down with it. The
ipq-cmn-pll probe was only the first driver to do so on the AX55 v1; I
had verified on that board that Gabor's change alone gives a reliable
boot with this patch absent, and OpenWrt has since replaced this patch
with his in its tree.

That also answers the two open questions here. Jie's suggestion of
making the GCC a consumer of the CMN PLL outputs is no longer needed
for this hang, and Konrad's question about crashdump mode I cannot
answer: I never captured that state, and with the fix in place I have
nothing left that reproduces it.

Thank you all for the review, and Gabor for finding the actual cause.

Best regards,
Stanislaw
