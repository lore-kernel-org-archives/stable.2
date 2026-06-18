Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73F548EE
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771845; cv=none; b=XlBRVIHchRW0FoIKzMr4CqxaugG0TEzxoX76S1ybOlFDydRvwyRclpZmP78+NKNRDClZBG0k/DCpszF9uHov+TfubsWblnQIe9OSsWeGJeJJeGUP0uT+2UFlAzhYO6LPQ8+Llu9+DUEi+ruVvsRIxlBlv1BA9+1Gje4J5eG4nHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771845; c=relaxed/simple;
	bh=UplzPm21o1txOIp6An/0DELClqRkTlgQ428lKTxQj6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SKHIfnVUWFZM23KPLIB/HUA5b6rE0XTU3BdhcGXucDhVMd606rlAWRuXO7c0Ui40Dfeu7HOlJefx/DLxvFAOp5dSW99NPhkdr2OFPhyfdBwcU/c/a3iq8/ONWWidXVtc6FE4Opssx7LQMvLYJf8BtWZSL6WvcpjQiXy0ZTwHbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sf55AFj3; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sf55AFj3"
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-96392241154so509957241.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781771843; x=1782376643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeJxbhN0Ht9jvhVm/ZNGkhtjcsRPRqpGEyUnibfRpak=;
        b=RbYyEO98mn/gxF2b3g/WpGwJ2wSC9keDxSXaNU/PS2NvqRuIQmxuMFxJDTbbO5MnJ1
         qouiQfcYXNNVm8anJ/Xej+KDeRBVkZSoylUpx8u0fK1JCOGo721WkN3mVQpBb0s4dcOP
         /JoJrX/FbvurWeYsJO7IUr47ymA0Gm8I2nzVD1ZAFb0C8lX/Pm+3aYFZXzAjGSoW6+H6
         C/Ugiw8huOzIk0lREAjYyc+8YiF4nCGxxPxFNebRHsnR5nVIgzE45F6+Um/G/Sb8cyj3
         8USjUqTANLqvoa0TP5iRwubCqTD4fKqEzv5gVAdq9JY0xCxtce++FD8yJqsCCRBdeUlw
         Kurg==
X-Gm-Message-State: AOJu0YwZJn7R0R0Aac0ZgZljK3kZSgvdOnLCfukATpqkhE/EVjU8juPD
	jsLewVOLrQnrl9JbRuq4ThgNQIEL1XSFCKx14pt8qvR0ZBUWCmgCFW1QHczLQkBfzn2jSlMs5AF
	PC+APAlNxDkuzdw/vsGMxkTBTMq3afabQBr2hRlA37gcvB6LURcW8GllTHutIWrqd/oUxnKJOgg
	/VA9ZJredekVny1sIqTaT6Z5DmEpZC8RRF8449TAGJuHhm3OWepAS0chzeQLyOFrH2ewihbQFZ8
	p1skbfKRuljAkg+RQ==
X-Gm-Gg: AfdE7ckJ8xKtDChGnvnBEfkQXC0OH05poJLXCmZE494OYfFYXSnrpukkCEIaymADUU1
	xV/DtKPWomSV1uR8A4CCmCE9n9UJbCAGkGz9cQ7TmK6ch/LNAk/ZzvfyJGwvYhBZK7+U5gjyOAQ
	maRKnBD7tCHcq3YNOtbXxRkMyAf1PSLd7Mn5hTS9f9mhZ0CQlvaucm1QEQUcdHBWH97lUoWGbQS
	nZyuZVHtUkMuncHz+cAD+2MO1lPD7f37vsKtgzfyYl22fKBcub1w0JQlyuZpI1VhPDDEG6zZ9cf
	d/clCI5jobmvbWdJn2tZ2VHSzJb2VUpfpsqw8JVN4uWMF1eZaxDJmgna0eizn0H3e3/ydDUKgWf
	Hi8whMF0BxLim5l14iQmzgQhICHCXoLC55FE8JqKub+beKHKVm1qwn5C3s+0ZZelzcIqzaPOfT/
	e4LyBdwbn52fWHmlHZh0vpevueM1/q1ATsbRVuskySLzql0LI3/A==
X-Received: by 2002:a05:6102:534a:b0:631:37cb:1e64 with SMTP id ada2fe7eead31-7245cfe81a7mr4373655137.4.1781771843192;
        Thu, 18 Jun 2026 01:37:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-966d7981ba9sm367012241.2.2026.06.18.01.37.22
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:37:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bccca5620so778725eec.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781771841; x=1782376641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VeJxbhN0Ht9jvhVm/ZNGkhtjcsRPRqpGEyUnibfRpak=;
        b=Sf55AFj3jHVyUjOxJ1MUAZOe3d4FF+RvfjWztEAjQwigkZ1TEkdvWB1GqtxD3y0Ib5
         UoD/so3X5cE/pJ7IHAoLEBKZZD7RuiQVQcPZIBHTOIMxy4d8fHSuQ6UmkEbNVW0O/QKo
         sGNLWMf/3+5ts+A7W/hTGX2F7Y1uUbS8Uoicw=
X-Received: by 2002:a05:693c:3942:b0:2d8:7302:d3d with SMTP id 5a478bee46e88-30bc998fb73mr4625544eec.8.1781771841664;
        Thu, 18 Jun 2026 01:37:21 -0700 (PDT)
X-Received: by 2002:a05:693c:3942:b0:2d8:7302:d3d with SMTP id 5a478bee46e88-30bc998fb73mr4625503eec.8.1781771840833;
        Thu, 18 Jun 2026 01:37:20 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm27475037eec.4.2026.06.18.01.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:37:20 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaosuo@gmail.com,
	iri@resnulli.us,
	jhs@mojatatu.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10 0/2] Fix CVE-2026-23204
Date: Thu, 18 Jun 2026 01:08:05 -0700
Message-Id: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

To fix CVE-2026-23204, commit cabd1a976375 is required; however,
it depends on commit 13e00fdc9236. Therefore, both patches
have been backported to v5.10.

Eric Dumazet (2):
  net: add skb_header_pointer_careful() helper
  net/sched: cls_u32: use skb_header_pointer_careful()

 include/linux/skbuff.h | 12 ++++++++++++
 net/sched/cls_u32.c    | 13 ++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.53.0

