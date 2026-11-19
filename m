Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081888;
	b=s/I4peWH36KufJRnRQwutItAojhtpWyW91MDDx30hXaUNVjnIsKdD4ZQ8455EQPlI5R8
	 bgaHiA1vfjGwlmHKXUj6xQ129iJfc1STbvjkOwiDhGchwcqBAqBSCey3nZGTUAUrhx5L8
	 ofk4eao89Db39Vj6CwI9fCszGNi7ngNdatVI0mlcUPC97y7KcZGrATVvKDv6U9yZw7yiO
	 EZa9hADjwveulWIjuJgtcRLjxocpEloBvmD3ykqk60YlLk2gT+x8ue9VOXFTFkALkQS7n
	 aki4uZu/bljRwIK0vDVrmBb+HKzvujpr//kPVItUod6btU2Y3t0FZyH9aImjtgpB4Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=miRDDdwyAGE8kK5Ez7Kp3L+1oDitSC4QAxpqcs7Tz2Y=;
	b=pdelfSnRG/A0r9WtN3qj6FiARNrRt5IBK6VT2MXdsG/tYd0VvAKZpMymgIzbnonHzzeO
	 6LqS5uHITLXRkxw6PMsqDPX249g4H9UcXSTqaZqiIwraKW+FLyHY9L80tC+MAvOi+CYLx
	 iFlCMyx+Vl9+5z9UJOv1tPIE0eB1D5XKbFZJ/sVgwQ8bkqHd4INmBgl7+hoiGOCZYKYi5
	 8R1CXgJcZsqiWMBji5TgkXQdJs3+XeRxy91puHaDyVWftBH86AcVFWLSgYozdz/ga2I38
	 5lbagngL2nFUh2asAxrLLJeYFoiW1RXY8pJQolyXrWf1nD50UxicY3TnwSoH8cFY5WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=l7wB9BRn;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB1606A330
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88CB1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=l7wB9BRn
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso352675866b.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 01:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795081885; x=1795686685; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=miRDDdwyAGE8kK5Ez7Kp3L+1oDitSC4QAxpqcs7Tz2Y=;
        b=l7wB9BRnTpdVrHTtVNpulXaVzZZHz6U0HuTknPXZVuTgOLrpMZpuTfeBxyjqSwb0tI
         GNjAkko0T7ZxjVCK5YCtczM2UtvTiM4s7l+wjN8k6ILeocUzluTGQ6P3rtBgwSqggYuX
         gDevutH0FgjNuV2e8KrvSlKjh51cAH2D3jhc9ESCA1Zv6tkmPdBtuMRbzGb5sipFfzFA
         evq/DPfcVTz6zaLU3IUoWffhlZMdiFIGzQ9MigleadceW5hoHZZXkNSUpAIygk+HccUu
         2vJ+aS8wrqPL5OASX02/0RmXn/OyzrgfAVw2F96Trtr6UVe+l5W4VEuH04ypy1pMzWg7
         aL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081885; x=1795686685;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=miRDDdwyAGE8kK5Ez7Kp3L+1oDitSC4QAxpqcs7Tz2Y=;
        b=W9xE1BYvUwuqtmklDME5Y4XO8rpCVD7ZMgKcl/8NAH0kmYyqhOnJWnAo4FvmcwGPaB
         tA7qJkOwzV4sclG17ssiBrhr6bnZxLjCHtAoK32IsODr52+rKOCAEM2nnHKi/NzvhBwU
         j8w4x2d1yxr7RW90CBYWLHjbKPM4+0TttoI/czgKXIGBTSE8+AdSDrV8nO7jmnqKnkoE
         SAdqUMQUwd1qcR23e5sjhiefwUFomx4DoX6RhIYsp0jU1lYZThaePikE8TyHXd3yzLtj
         jHQBBfV2GZ5ztZpo9OmSLQM88oenwX/NLVF2ADiGewbr2BBrmshl48ROdzmQOKqPcXzv
         FQBw==
X-Forwarded-Encrypted: i=1; AL+hErFDWFc9eHp3hEWqg0eDPebiDkRxVrmiY4++n55fk5jDtHITDk02gDls7JDKUglBHGa917YUPgM=@vger.kernel.org
X-Gm-Message-State: APuU4Z85VPim7rZh3p+zUYRgSfS4A29Vcdi+0uTO2XSgeccq4L0jcrXb
	vXT+xaY01+2G256Q+mUWRIOYrsBHnIDJ6h6SulpdmPmmKJv5GbTR2i4IB8lgvv6kEjA=
X-Gm-Gg: AYBFou3PC6YQmKIBGPSBhwwtmNk10dDxWSNP3REfl7/bxUD0hDJfnMhtoVwHqqEQJH9
	ZB6lKIOfHVqRwpyAainoBEef13z8FSLjZREzbULSQ+skRvvCN7KxlfmEr9DIawgpH/v/rlhns06
	+sWlFQt1u3PzoLDXKFXuuJeEwQjONqpDIkjm49IsNojzYNKuBIZYgNT3/7HmJBvCFdg9sBxzxfQ
	fjFo8Ctbs4MoivTPnFeN6SyHXJgiXLfJWkmRO03o355fO6WoHQEHUoWslx8o409vEEAxcASqskR
	Ut/m3dYILfh7tcFJit/OsD9Rlkwc9TOVpQz9Xz+vCRTRCwi4Nhb99Em3pvgp8JEzcNN+iGIvX0C
	cKUxWndOTHoEDfY1x/8NQj+X9B4dgBg62L4EK4NiZ9CSJy3hF73V1yVnl1qgEjGwiKCHbwGvVnG
	V89ZP43T+CXx4WZoR5es6Fln6u544SzO2ihv8iRL6rQB2K4MnyFp+ZaWXl1urbt3mZYAe+S0ku/
	PfPfrkJ8QThShGxNiKvlwZni8F27ksouXkEi+qIK631IBubQ7E9uVVbNvNH8d/0ZYmxavMmqB50
	WKsQh5/WZmbP9P+aXEcKxO8FIsBE8Nk1xoEAO4LhWEL283w6jrVyKoj1A9nXZ4a7xRwu83yHkXn
	NHaerJHtOM/M=
X-Received: by 2002:a17:907:6d13:b0:c50:4983:5d8c with SMTP id a640c23a62f3a-c510e4c7dc5mr462265166b.34.1795081884916;
        Thu, 19 Nov 2026 01:51:24 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51231bc213sm95057166b.12.2026.11.19.01.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:51:24 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH v4 0/3] Dongwoon DW9800K update patchset
Date: Thu, 19 Nov 2026 10:51:22 +0100
Message-Id: <20261119-b4-dw9800k_cleanup-v4-0-df26c431595e@fairphone.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJrG/moC/22Q3W7CMAyFX6XK9YKcv5b2au+BEHKDWbNB2yVt2
 IR4dxIquEDIV0c+/o7tCwvkHQXWFBfmKbrghj4J/VEw22H/Rdztk2YSZAm1AN5qvj/Xa4CfnT0
 S9vPIoa2xQiNI6JqlwdHTwf3doZvtosPcfpOdMik7Ohemwf/fU6PMvkeAfhcQJQdeGqNkpRBRq
 c8DOj92Q08rO5xYDonqiRECzFuMypi1AaISTapXzHVZ1tPvnB4xLRewFgPx1D+5qSlitdLcW5X
 M1xuAQwriPQEAAA==
X-Change-ID: 20260910-b4-dw9800k_cleanup-0b9a7a51e149
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 stable@vger.kernel.org, Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795081884; l=1866;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=wt4hIVeK/o47k3U4oT+VKM8Utd3/8tsRODOOzKhUBVQ=;
 b=Z9r7Y/VSolQbt86bB4HMFdlXQsAfQN7L4Y900nrfMljELYc1gQAUGiXcH6vqhfusGhM0t6Fif
 uSkXV6JjcHdBe9nTaPUETQrlFLuv1Rj4mEt5uhAUjdQzAYpB1bJR6hp
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

This patchset edits the dw9800k driver and related files, to properly
match previously mismatched register writes, variables, and logic now
that we have the datasheet for the dongwoon dw98900k.

This is a breaking change, but is necessary to ensure proper bindings
and driver behavior. The previous naive approach did not ensure proper
functionality with different device tree properties.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
Changes in v4:
- Fix typo in dtb example.
- Fix build error in switch statement case
- Link to v3: https://lore.kernel.org/r/20261105-b4-dw9800k_cleanup-v3-0-6850ee6a5a5a@fairphone.com

Changes in v3:
- Added more detailed descriptions of the changes actually made
  to the driver.
- Reverted to using vcm-prescale attribute to avoid unneeded breaking
  with dtb.
- Link to v2: https://lore.kernel.org/r/20260914-b4-dw9800k_cleanup-v2-0-6553273aaa33@fairphone.com

Changes in v2:
- Expanded commit messages to be more verbose with their changes.
- Link to v1: https://lore.kernel.org/all/20260910-b4-dw9800k_cleanup-v1-0-608255ea61ab@fairphone.com

---
Griffin Kroah-Hartman (3):
      dt-bindings: media: i2c: dw9800: Redocument DW9800K
      media: i2c: dw9719: Update DW9800K driver
      arm64: dts: qcom: qcm6490-fairphone-fp5: Fix DW9800K support

 .../bindings/media/i2c/dongwoon,dw9719.yaml        |  1 -
 .../bindings/media/i2c/dongwoon,dw9800k.yaml       | 91 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |  5 +-
 drivers/media/i2c/dw9719.c                         | 68 +++++++++++++---
 4 files changed, 152 insertions(+), 13 deletions(-)
---
base-commit: 19d1b4de6d37bccecc3ad9144d279f1baa405eb1
change-id: 20260910-b4-dw9800k_cleanup-0b9a7a51e149

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

