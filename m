Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874545;
	b=ntezZ9WGaqJbEg/1NtJAcMhkyv5VnZZK05ChZWTpgxo1keH+K8jftarUAoN2Ba3tPs87
	 OMUV5w0UPTpxCl8r0zxWLwY4kYuA5ZG5y3T85OIvRCtzbtw70T+xoadT2Tb0YEXgWbH8a
	 9wenkevVeqi2zUA/DT+v1K9iZ/WUMR4lSbY0759ykn2oy8y/2+AzVS/kuhZ0gDPOZLZO5
	 5JIm0h4WWv4MjWbgLghMCWJK9yVkxmKhD0BJJh9Z+RDBmit1nznZB8cNU13M+BBBuxqf1
	 HDHM0vC3LX/KyF2jSxtrkA99MCYn/kKazYl4y9i1CJYHVTweOya+Wd6beP0WGZ9LoOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ajLIzQVCgaI7n9OILj8/6lpTK+AiVXchsMOmXAlkCEA=;
	b=4xGnGW03A9pd2Ygauiua4eNGfXUlVA14R5yYsUJEyUK9CrimpNR6aExYrq8Rko2ny+62
	 sz1iKWh3M9Tee+JxMAvvgyKB4x5A0TBxB8pj08dCTcKLenobKThAyrLiTDbjdURrbVGUb
	 YkSSXDSuuZonDcCgKV9XHmjYoeUlUgVeIx+fEBLMK1iNcEHa2159/4V3XMXjCZFo3BScD
	 3Vw3io1R7vBzCaR23aV8FaLYydvUph1KCSvQFeX/jREzt2I15PVjAuwBWVYJ+26KkCdi0
	 uegvEUhO3pzwcumtUWigAE8Bx+yLYJVOWheh2uHutAxxdBT/Q00kuZzVW2TchI2A1SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=uGKlzRZe;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC70606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 10:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC70606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=uGKlzRZe
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so1180979a12.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 02:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1793874542; x=1794479342; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ajLIzQVCgaI7n9OILj8/6lpTK+AiVXchsMOmXAlkCEA=;
        b=uGKlzRZeKSBB7pbWNgXhCMnH9fIP+HhOcCeqRDYbF6gB1fzwZDQM11K0HHL13OoMdV
         IGZV5O8TUCjILvLNde50AKTfCEans1P9/TwPZmsR/VDfB4NdNmgk112k/F4/tuh5ung+
         Vw+BZNNhY/FE0qOH+R7fI9lo4i/gy4J01CjnfEBB46iZBuTmGNrQDyJnMLgS0GcVRdPv
         bzsOyxOyqVlDrIVXxYjBK2wKMPAMvsH3q3d9R5jbi4xhDSsHsQKVA/HCAPRiMP/3dQjO
         FZ/yiaMR9Pz6QKYTfLlu/Xg0/MrmZURk4B6CzDcGtlvTbVUL7qA4xZQ/QNE72quwZiNb
         pWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874542; x=1794479342;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ajLIzQVCgaI7n9OILj8/6lpTK+AiVXchsMOmXAlkCEA=;
        b=WFB4SKfpJ9I5l97+uoD+vY5F7KbkY9JeM3Q+oEkbToRTa9WmG2Pfg15EQUdf/3xoaX
         GK5D/TALPZYYx16FAyJz9B6W/uxYuuiPA1tMfvOgBb/u1+Pr4SmqrKpn0A+NReezq8aL
         Y4hClrzLgV3v0r0kuzGQ9h+yIB+6eCaRxiFlG49auHHAadfnyEq1d5R4nNfLqrQsagqd
         saT2iwvh41LRD9nkIdgDb+WWzCo3BND8YMG4fbcGD+i8g1HouL9d0zZkvRvKcHg7+Sds
         wDTNm07prx/2eepiohu1D47BV2RZAC2TkAclflnxcQqrx4TRbhUosFv3ricV42myu5uy
         KBPA==
X-Forwarded-Encrypted: i=1; AKwUvBxu+FQdS+f9PeNTOLzAt+ZiZnKL/WJo22kDrZweQvbbk2FQqMj+bRQtWB+a2AJ60AAZn9z/mlk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IL5TXUX7qstqWgKo5h5yo65JLjxznAq6/vFusoQq24q48WvJ/
	owx4XA4xfzsPOUhBOmBEaOeP++FRiZj+NpafRThH5ywAqkNhx/QKSpyIc3hxncd7OzI=
X-Gm-Gg: AYBFou183ocWpimv15gJA6+g/46A+Im92WwE72y+RVl/4crfXE1FhIEHcmMssmaDM0m
	s639CvZ90THXTjG6C0IcZTijJHjlHFrPrAyLfk7nmYf0UaDbjziLWZiYkiFMnVGjvrcwnb5olrB
	B1q91tCt8h2+U55hOqZyfbPoz4GhSSdgzMkqZJ6eppHLZgG0yf8nDFXS0Ndg85An/0L05FoaOMn
	4lHow97uk4/lvNYXW/15xonRM6XibW8lqB2o/e1vyUqJdJ43E/MI9tBbaCrkojcGoNQ9VSar86T
	NTb1U+a/4Y5HtXh6bReeYbOpdQlY9QdwInt4AnRmxnqq2pI2R1Pu5GUOhSqmFmIfjdX0DJ3wZ6i
	HKn0PZJjiz1HwrSFF1HTTjHJJ4J0gJO+XoXHklgvt+gQMrMA2odwx0v2Uk493DNeBgW5oAe/cLF
	0XHBT5CCJ9iwQpkc7ESG6L0MFBEvViTPGXqm8m+w/5GwCU1DkfvUo5hTKsX/U/zPaK7xXjtHeQs
	amJUqdyj/CzCg54x4llV1v6jDRUvjyG2StHioKcfhBKpP3MLQ+wUai1EBfNLxjX92iANu1WZHJS
	hfrFQjlzKVT8f1sFjwKQ0AQYCAjQkfgGTHc3UQSPDS0fZUGeGQHbVCgI81Va4w9AggcnM86zZT8
	quw6RLwMlgtsx6JiH5lapmK/kBG3uVWlz
X-Received: by 2002:a05:6402:274d:b0:6b5:5ad6:2ff4 with SMTP id 4fb4d7f45d1cf-6b55ad63471mr4129137a12.28.1793874541906;
        Thu, 05 Nov 2026 02:29:01 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5864a87c1sm278665a12.2.2026.11.05.02.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:29:01 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH v3 0/3] Dongwoon DW9800K update patchset
Date: Thu, 05 Nov 2026 11:28:59 +0100
Message-Id: <20261105-b4-dw9800k_cleanup-v3-0-6850ee6a5a5a@fairphone.com>
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
X-B4-Tracking: v=1; b=H4sIAGta7GoC/22Pyw6CMBBFf4V0bUlpeVhW/ochZloGqcrDFlBD+
 HcLxJ3Lmzn3nsxMHFqDjuTBTCxOxpmu9UEcAqJraK9ITekz4YynTEaMqpiWL3lk7H7RD4R27Cl
 TEjJIIoxiSXyxt1iZ9zZ6LvbsRnVDPaxLK1EbN3T2s1knvnI/QfxPMHHKaJokgmcCAIQ4VWBsX
 3cthrprSLHsFovP0X8w7GqiwCH198YMeTBlYUytjjy8fAEH5U4r9gAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793874541; l=1675;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=zYExRqYQL9Fc6YcansLrZhaOHhoc55JMwPP4XAEEjC0=;
 b=NMqoBXeKooo51DzMpMUBdJJltOpoY1I5G43h9htz6lWJ4sYgqEHve0DhWTrVM/Fd8WFpF6xne
 TW7IVn8hTfiBGFbmz5R0FwOiH0rghv7/vJyqvxu2p/8pxyLngfTY2aB
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
 drivers/media/i2c/dw9719.c                         | 65 +++++++++++++---
 4 files changed, 150 insertions(+), 12 deletions(-)
---
base-commit: bc71431221f5ba8bb33918399552636e059c2c45
change-id: 20260910-b4-dw9800k_cleanup-0b9a7a51e149

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

