Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531753E3141
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933716; cv=none; b=Mn3VJ0q5KcgpRsN7KvfM+hm2aQkukg1pLL5VFPq0oYro3QVAexuj82v8Ehb3xRs2GpQAt79ncijVmHHKOZAibSCOY9Xdte65m6Vx5avquwNmRi+bZ4yz80ZUr+K3J1RjsukkhF4RPKCo9z0eJuCA8iIjYFbPTjY4bmlr4Hhh9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933716; c=relaxed/simple;
	bh=kYxAmL4+vDGixpRhm9WSeoPiYPjYqdH+eJ1grKcucW4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mBeKZh/t549NP3M/uif94C2LZ7wpSGswVAoUgG3C/iOTviaizE0+plBIHigsqX446MzTZag/95pv7Mt+1YyAZo9i5Lo+M9LzXuR14n+NltMpjU8ye9TkrKm93u/+EAMbFZ2S9GPX7CO/hAU1Yb8kLFdacfnPCZzof2K1SSAOKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HopDi3g6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HopDi3g6"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1048637f8f.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782933711; x=1783538511; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vjlz6Sou4oUC6PMziaJquaQPB+bVCyS4KogfPbQtE34=;
        b=HopDi3g68BqktaKrumWYz3PfJNvbPMOoJLZREfhSV7jtSCrP5xJLIGIIb9DNQShK0Y
         S2kWGPyI2ROTg5EXfwwycLEyjy/YSfWCt59hZIhijkLGv2CGfS1zyJoPLPSKbFhff3K7
         tSzncI6Q32+WJNcrsi6yFKdFLf9QJSS7PNhO8uJ2fHsl/gS1+aPpjKeM+6z2L+5jAhnT
         Ed5wn8/+4e7ErkFpDUcifERD8uGpEHB/DSp53X96FzO6k+Bp90j0M4LtRc30c8IAkaIh
         RLLGhttNvuiJa0k3Ri6/dwGafwt0VcOR7+Coyz4mFrv82hTh1GFXvRjEInOLvibl9dPv
         uaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933711; x=1783538511;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vjlz6Sou4oUC6PMziaJquaQPB+bVCyS4KogfPbQtE34=;
        b=oZwo5mzJGyzUa23tUK2Gql0ppowuZLuP5LDW/X7jcrPBqH5b2Ml9Iw6r8SbE+Q1Y/k
         7zB+1XKBI3GN91Uj91kk38MNUA1jiQ0X7FQ8Tw8qNFIgczfy2wxMzbNsPftwZvb8ZZJ4
         ESe4BXl+a8Dl3RRkIvoHbHvmKHSVpU2M6DwXJh6KuGlvenx4+GqMjMGSiiMVZJG8etZw
         8468kslqctnc+jKfFLXm2xEUKniy1Cpmx5B/NdHsi2fscvz6KisvfSvR14CHcMQWTwgO
         4jht3hRUDBQ2fXigtzMYZPEl/CpwDwx7gR25jlXNk/M0JDa73blJpHIMzP4gFxekqNx/
         jguA==
X-Forwarded-Encrypted: i=1; AHgh+RrU0GTdvXklKLVhhXvgo8wsvWI1HcIWqV8TUZoMiSOBT+9Z2wua3Bj686k2/ztKg2t2MYLd/WM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8SJBz7kTG7Q11+RlRUM9emXrFnaXU6Z8st+r/g+T7kT/PEo6u
	R5B3vYjYADZwTReobhS3JRVdru85mv5OI/9/pfKd8EYaYBoMs7791apD
X-Gm-Gg: AfdE7cm/1s2/rDcV41R6YJdk3ZWOvNrsi3tHvC9yrWDnbiibq5mAGwOsAqZN1T6P4Za
	VFTtQ1emWP26TUFcoMzF+bGGtaFYXNNrlQScIMg8RT1IlQXJ9BIaFoCiqozTgwdJrhTP9kKNLKj
	5lvhg/Izp3PwrVP8yhuaavJ93zcJlq0pCVHlF4YElpKHn1Xc63ZL7xAwzgOn7/JsfNd/pGWpydz
	fw1zk8Z3RwQE/qfz5D+3/G+7wGwiDTQjZSlaFipvTa77v6abXiUYsl5n+Y95960uL6XzpKN+pqL
	iAo+a2UJa0SLRwNI2ImE8WPNTfxcP46+dkJqRPYzW5e4efr5hHtW4MDceMQtDtee59TqouwR67J
	GOGWJgMj+ju3Wr6Hq9Fx50LLjeHMEsuS7WcSmToCBIms4Df+GYYYWvsgTkHWE02mzF44VRVWaN8
	Jou6s68CzS6ZIFcvUUj3z9d/qLZbYWr5UODNaMpbqEIpR9oEsnU2eULqWcSanTn6kzPRzJkcdDU
	xaO9VmennMGjUKvhxqVe3H/TY1fDEiKJpM0jSzJk/miauGecu54jDgRDQkOKmsPBef6L5lEDP7P
	+9dOY+5/DP1ysqOpMU11hpf8EbnI7dvzmi8dkTTXFWdQBWEV68rTOfQ=
X-Received: by 2002:a05:6000:46c7:b0:470:2fb1:3db5 with SMTP id ffacd0b85a97d-477b52962ebmr2062536f8f.30.1782933710433;
        Wed, 01 Jul 2026 12:21:50 -0700 (PDT)
Received: from [192.168.71.52] (cst2-160-240.cust.vodafone.cz. [31.30.160.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dbe617b1sm2081838f8f.16.2026.07.01.12.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 12:21:50 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/2] iio: adc: add missing 'select IIO_TRIGGERED_BUFFER' to
 Kconfig entries
Date: Wed, 01 Jul 2026 21:21:45 +0200
Message-Id: <20260701-add-adc-kconfig-deps-v1-0-b9708d74f426@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkElKvtKdLB1qyVQUYgg+nvSY
 Q5zmHmgcBYuMDUPZL6kSAxVdNsAHS7sjOKrg1GmV4PS6LyvEJ4UwyY7ek4FV0PU2dWOnR6gpin
 zJve/nZf3/QDp050TZgAAAA==
X-Change-ID: 20260701-add-adc-kconfig-deps-b2cc49b98417
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jonathan Santos <Jonathan.Santos@analog.com>, 
 Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782933709; l=946;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=kYxAmL4+vDGixpRhm9WSeoPiYPjYqdH+eJ1grKcucW4=;
 b=7Hp7kdzo835EdJpfYEgRCDYqTK+drpskGXpaCMlOpriAVTX5iBgNRymcYDlzC0P33rhOS6+5v
 1ebYip9vb4PA0CquY3PcaRhqjTqjDEulzW3Cwi1lqqRhtM3TJQ3ZK+1
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The AD4130 and AD7779 entries are missing 'select IIO_TRIGGERED_BUFFER'
entries, causing potential build failures.

Steps to reproduce:
1. Run `make allnoconfig`
2. Run `make menuconfig` and select any afformentioned driver and
   modules it depends on.
3. Run `make .` and the build will fail due to missing triggered
   buffer definitions etc.

I seem to have stumbled upon a lot of drivers which have incomplete
Kconfigs, expect more patch series per sensor type.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Joshua Crofts (2):
      iio: adc: ad4130: add missing `select IIO_TRIGGERED_BUFFER` to Kconfig
      iio: adc: ad7779: add missing 'select IIO_TRIGGERED_BUFFER' to Kconfig

 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)
---
base-commit: 022cc99d5d1cdc76b09b424a769c3cfea3812378
change-id: 20260701-add-adc-kconfig-deps-b2cc49b98417

Best regards,
-- 
Kind regards

CJD

