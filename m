Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030986;
	b=EjYUeir+Z35uq6lbr7GuF6yNopK1U62FQVFiYW/HqM+y+/gXsSA+nS2V36obj3l7Z+Kg
	 Fn0trdy49KJVwqHvcbP6ytXOaEazeUc1PZbqJX5mj4J540M0X5BK82PzY7xpWZioUb7XT
	 gKoErIh5YPQJv6SkVl9nkl/Zah5xUcvDbujHYTM6gnVWTLSSBMw5lAkKz0YwSuPqxflJM
	 B/b3y8b2ALWFM3CGLTR0dYm26JKlBbQPqx2yK6PYp2YzzB2UlXo/BTB7Hnd1OZidr6mnV
	 OlksVRYyB5XRb3GSEjeLqbOtVTF+5rbp9uvm55KsxRpGsldL2kzNjMOIVt9Dw+Aqubw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=yg3SAu7bcjA+P3cd0pQQnqKAc/f2yjYRUKnerwKE1Pk=;
	b=by2SOgi7WUWjCkl6l/vu6DLB0+HQ8+XCkwfLmBpm+fZG5V+34rT0S7UGgxhTC09u7uOv
	 1u5gfTZOpyeOue45gMJOyv5fv3oocFPs/dqbkf6xCZnK7nKlobeQYXvBmVGWV1czN0kUm
	 ZL6TzzR5zngZkBp0w8YpOkMG5Fre63I98d+5oLPMUtxYZf3GzPhiTGyk8+VACHseHMxnc
	 xY5Y/uYLgg9rBkXzBlBeT5ZLztftCQ1J5fL7w2vBI18Ik7WfR9OWLfA5J4GAMHWj9uf8o
	 G6iCNRFtTrrdN1wjnxuS94wfSpOuboCNPcJrL/TXrt2XznDuYlgKlPlcSWGg/GorhgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VanedlGZ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45608606A31F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45608606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VanedlGZ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so267825e9.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793030985; x=1793635785; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yg3SAu7bcjA+P3cd0pQQnqKAc/f2yjYRUKnerwKE1Pk=;
        b=VanedlGZOu5ndUlScCLSxlKNzB5QUBvJHOy7xAvY+y80EAJmk/V9xxksuf8NQwaU8P
         CE9ZNZ5I4maGFZZBUtr12or2LPxp/2FL8+VneSbVf5rkar8wljOEfTGIs8TO1HH/r4LR
         az6MJXoQYmFFLWv4hMzLFxDhabjVMSfzwN7Qa9+LMqNUhNI8xC4lzBoManTpVANSlari
         bBjs9b+DDHRzGGulw9/AIgtEixrr6DS4UqLJXmlGSO+GGs75pLqAvk0DyQI/Wg8KMGRG
         PJw7oflt3vrLO05Gsgx5K4XRgx222bHpxgjMJjEQoYksQNS1QMXHMq2Fvea5H/udQ/AO
         hCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030985; x=1793635785;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yg3SAu7bcjA+P3cd0pQQnqKAc/f2yjYRUKnerwKE1Pk=;
        b=Wf6nv/tYGAfsAPT+cjfILiQhxueWUGr8Arab1B/BfLWwBqyHHUecx0D6cD/nWeB6t0
         uL2mwhep1ORJQ1zHBc8f/JFqcvd1WZxKM1zADmy4yzGMNIGP3n/WQj7qrjQu6RXE2T8P
         O0bKS52ceuU3XIq4MHc5FQPFlHA6NIT/JsW9PVkGgnPEJUpjPBR+n7K8hL8kDURdNWdJ
         eYW6QCPN5qjfEw1qaqiUdKr7rdd7N7xyGiKgkGulR80AJ2mY86KXbU6zUI4Qx0lzheSx
         Jkbit7JYxFkkhqU8PvUP2XV9UQ4nsh8wSvMzBd8I6bhYSL00UWKPWQEjW1hgc3rExjjT
         xf2g==
X-Gm-Message-State: AFq9FYLZoRxYMITNi6BS6AQusXhuOGVHN3j0tEK0wwugm90GEmoZXqTd
	LeWNRXj7Vb5ciQOycAuDS8aFDchgVxd1O/ANbxBf2o5OofTvJVfSD+Da
X-Gm-Gg: AYBFou2JcMl8FasJspz8y8K08Bm1IrW0i/MmqvjH/S3l2mATtCI86u7NArSwKqMWKxf
	nqqJLY+qpxaaNBfqqJG/3zkvlIgMcLskC4CpCX7GFWomQRXc61Cnk2NVks5wscIG8E1Ok/EZ21K
	GH4NUBAwJAsSFEo41yRQToolfbSvgLXQOkZJeHKpfhm2Y9fxeVHn9unhmX6Zy6CJx8bD1uzCCwc
	nUsh3hVrWVyua7h0OaA4V56b0FyBK3NvBIYHQgQK1WntgJYo79GoD3fMKkEouuKz6C8HI8YDD2B
	9Q8AKPCt8bJYSxbRROLm1FvP5dpVmaFzJG7wASy4CgLEGFaBSDRFa2EGpXiN9a+c/pRrPt74/p8
	WQdAsAhk5COWHI1kUF6QTlDzk2+V8ElFz0Q28I0DhRTb57QfwxlnlJC4f9hmZvYzjO03/SUq4B4
	dqVj8MNrhEtL5tY57+rkQu/CRWutBJb6TnCzJu8dE3XzAQcbKcOu8glwt7ydrZT3fSKbu3zqsqh
	9zNiDoD7CaPPoR34cygsV4RZdscznm/vqmyTqu+wOZc/SrUQNoc+UjouyHzibl9+pRR/Ieo/+fM
	OBQlcGLARs9xvEECNEobl+Jc1Lf4XA==
X-Received: by 2002:a05:600c:3115:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a7c16c5294mr2538075e9.13.1793030984491;
        Mon, 26 Oct 2026 09:09:44 -0700 (PDT)
Received: from theSameSurfase.localdomain ([89.216.103.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa097sm224923225e9.3.2026.10.26.09.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:09:43 -0700 (PDT)
From: Artem Utkin <thesame.personal@gmail.com>
Date: Mon, 26 Oct 2026 17:09:14 +0100
Subject: [PATCH v2] ARM: dts: samsung: exynos4412-p4note: allow powering
 off the wifi card
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
Message-Id: <20261026-exynos4412-p4note-brcmfmac-v2-1-14b372972163@gmail.com>
X-B4-Tracking: v=1; b=H4sIACl732oC/43NQQ6CMBCF4auQWTuGlgrqynsYFjAMMIltSUsIh
 HB3Kydw+b3F/3aIHIQjPLMdAi8SxbsEfcmAxsYNjNIlg851qXJtkNfN+WiM0jgZ52fGNpDtbUN
 Y3rkiVRQ30/aQAlPgXtYz/q6TR4mzD9v5tajf+ld2Uaiw6PIHm0dJmqrXYBv5XMlbqI/j+AKcD
 dU7xAAAAA==
X-Change-ID: 20261024-exynos4412-p4note-brcmfmac-68e7c13354bf
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: stable@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Artem Utkin <thesame.personal@gmail.com>
X-Mailer: b4 0.16.0

sdhci_3 serving BCM4334 was missing cap-power-off-card.
On my N8000 this resulted in the following messages after sleeping:
[305.759883] PM: suspend entry (deep)
[306.514698] brcmfmac: brcmf_ops_sdio_suspend: Failed to set pm_flags 1
[306.671504] brcmfmac: brcmf_sdio_htclk: HT Avail request error: -110
[307.127267] PM: suspend exit

The regression was triggered by commit 8c3170628a9c
("wifi: brcmfmac: keep power during suspend if board requires it").
Midas already has a fix in commit 2ff147fdfa99
("ARM: dts: samsung: exynos4412-midas:
turn off SDIO WLAN chip during system suspend").
exynos4412-p4note.dtsi does not include exynos4412-midas.dtsi,
so p4note did not automatically inherit the Midas fix.

Fixes: 8c3170628a9c ("wifi: brcmfmac: keep power during suspend if board requires it")
Cc: stable@vger.kernel.org
Signed-off-by: Artem Utkin <thesame.personal@gmail.com>
---
Changes in v2:
- Drop the paragraph about exynos4210-i9100.
- Add Fixes and Cc stable trailers.
- Correct the author name to match Signed-off-by.
- Link to v1: https://patch.msgid.link/20261024-exynos4412-p4note-brcmfmac-v1-1-3d09e496c2c7@gmail.com
---
 arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
index 8d52aa13b8..03b514a82b 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
@@ -1232,6 +1232,7 @@ &sdhci_3 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	non-removable;
+	cap-power-off-card;
 	bus-width = <4>;
 	mmc-pwrseq = <&wlan_pwrseq>;
 

---
base-commit: b47faa6004d86ade16b90d24fa1e1f179e6f7230
change-id: 20261024-exynos4412-p4note-brcmfmac-68e7c13354bf

Best regards,
--  
Artem Utkin <thesame.personal@gmail.com>

