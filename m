Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3F126C02
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784400914; cv=none; b=avr4gz6ol/Qadg1xHW5Ut3dXUU9isaO+kW9iHWYotDWUn/0C55nHEDueKgKJe3r4jqyKbbeN9oNMo2oZTdnlHLHLnagPBTj35unMyR1AIUTxu5dT7VyCX9SF0rh5ugXYt7dwKaZpKir2k5wo9urSSUeLmgvMfEToVIWvf9jjhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784400914; c=relaxed/simple;
	bh=RLvJyyzbDkW2Bin4M8qjdgs0Tl2RzHC+PCd/ZUhXgUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXZvE3R5r4l1yohk5+HFtY1hUTDTLyfgRC+kDKvzLARY2g2W/QtpUsWcrG4iO1kWE/Y8z+0O9FvZdyaZZhYj8s7BFwtFBTx3akh+AljhxEoEuBaBUGDxNr/4nFJHmQPzWFO0DLteGjU1mHUBpQ6HE2/XVKXKc+brSnpNvpyqbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhjSLUVY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhjSLUVY"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15d5468673so587318766b.0
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784400911; x=1785005711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EQeflTmYd4L1dkaVapCLSilHj8J3mnfUi8LPwpSpNOc=;
        b=VhjSLUVYWlyrSFgx/tU7nLe6Qa1fJP9bD7nFJHtpa4GlOdyQE4qV1iZhfckeld6nwV
         XITQgZq9ppVzwjpw1ne0vItqr3fFIfFNqR40QNstq39YJ7ygZe8o2Ss73Sff9hZNBjF5
         FX5U46gn5wQvYPj1Ea3/o2K4jDWYNSWVGSSWbiWx2m/CspiDHVPPnq2aRkxQoyNSInG1
         o6cFDR0BGTDrbX7YdoluL39cOM+/ZcwL1IaFb4z+XSKe5LRBMU27CygZo+6ssXt3YhlN
         Kyv4rVRAJWHx0XgnjH6hHa8PZeeuLM6bfX5DcAKpkaOyDX+B/9hZxpUFELSyD429YCnm
         JRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784400911; x=1785005711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EQeflTmYd4L1dkaVapCLSilHj8J3mnfUi8LPwpSpNOc=;
        b=oosIsqDhvRHTs1noNwtl3foG7xmgBenaeaRkVFRIYBhnFA30O1hr4F/oB6JWWxrAWk
         PNbYwIBY+ViYSokCQYhu4rbcLzfpKacvXL+IV9M/AePiSC/q1GqpWjPBA7i3rOOlAWVq
         JgMfzJIA7kfY871AdQ8wPJ6tGUDbLaDzOkYP1I+Z8yr7AiokF35Fxs41bIbRF0POY2e1
         umqGPeAwO1ILnXdC4TtPHkTdcRE5r3N1tR99RXmp52MaacFPBwasNpFwKuKeYKspg4WR
         RhEObg4f9LkAN+iUsTjoAGkMhE7rBSue/iUCgew6Sk91H4XfkWEhUbbnWV+Z9UCe0nk3
         PgOw==
X-Forwarded-Encrypted: i=1; AHgh+RoHIwbYrGSLnDjxyYqxj2ZEn8K8TgHAAQpDgDj3mOkgDi4f/a7LeHzB0BbhBNV8KpXhsw+vdrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztYiWyIxcl8EmezpMpi8PP8l1YwGwPBCv2WBHByphA+9KESZbP
	hDFQuGZuIMFdewAqFryo58uzouLOu1ob2tqtChz+ZVMiuwmwuhsWFUKR
X-Gm-Gg: AfdE7cmSQjk1VzyVlFxvbUcbFcgZ58wnjubiK5D2MElx+o4WXAU3nQuMW+cntwnh3VV
	eqvokNb8vgABJs86i2b+DglDM8tCfyARC4c2njYclFeqjfgOKHj28khTQnmHDkhZe23DHX5BbPt
	r6WbdaMyGfwqqS30wlHE4jWG7WfVcWp2PSfHenttROl9tIbhuyII7+K+bF4bCNMJTAMWQV5ECrj
	RZl5kRCkd4HO7M1nHxKlN0NjH5qKpFXs+y35UncnUmAX+rDQRrOtLRdQaPpoKFHviNXcekMZBof
	Qd3zjwGRPPjoS1OM9ZiCwt1FteHADQG6oJOJzy4oH7pLRZCf0DY9a4ifvPm5TsfbD459zV6uyZV
	hQzqdOciqcSuLOXpZA0ZoNGAiIhdNpj2p1Vfw1uyZPhRFmQfUXr26H/WLjUT1TEZtKAbNQmI933
	j4Wj3AEdHCvmJWIS59URUv4FHXvCQhw5O9kx2LQri8G6JMQXXrnUoihZU=
X-Received: by 2002:a17:907:3f86:b0:c16:12c:9aa7 with SMTP id a640c23a62f3a-c16b4886e8dmr351971766b.40.1784400911266;
        Sat, 18 Jul 2026 11:55:11 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1712a5f837sm249151866b.32.2026.07.18.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 11:55:10 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 0/5] staging: rtl8723bs: fix multiple OOB reads in IE and frame parsing
Date: Sat, 18 Jul 2026 23:54:40 +0500
Message-ID: <20260718185445.63070-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes five out-of-bounds read and buffer overflow bugs
in the rtl8723bs staging driver where length or offset fields from
untrusted wireless frames are used without validating that enough
bytes remain in the buffer.

Patches 1-4 are reachable remotely through crafted management frames
(beacons, probe responses, scan results). Patch 5 is reachable
locally via raw frame injection on a monitor-mode interface.

Impact:

  1/5  OOB read of IE length byte and OUI data in rtw_get_wps_ie()
  2/5  OOB read plus stack buffer overflow via attacker-controlled
       memcpy length in rtw_get_wps_attr()
  3/5  OOB read of action frame category and action bytes
  4/5  OOB read of next-IE length in the non-matching fallthrough path
  5/5  skb->len underflow after unchecked skb_pull in monitor TX path

All fixes are single-hunk bounds checks following the same pattern
already used in the sibling functions in these files.

Tested: CONFIG_RTL8723BS=m with CONFIG_KASAN=y, checkpatch clean.

Muhammad Bilal (5):
  staging: rtl8723bs: fix OOB read in rtw_get_wps_ie()
  staging: rtl8723bs: fix OOB read / stack overflow in
    rtw_get_wps_attr()
  staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()
  staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
  staging: rtl8723bs: fix skb->len underflow in monitor TX path

 drivers/staging/rtl8723bs/core/rtw_ieee80211.c    | 15 ++++++++++++++-
 drivers/staging/rtl8723bs/core/rtw_mlme.c         |  3 +++
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 13 ++++++++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.55.0

