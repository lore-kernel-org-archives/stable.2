Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874547;
	b=txC5r5U9gFk7UR8oS2VTAKp4Jae4nKGudGUS9cmWVAY0i/POWDmXHEnOc6AsmHt8Y7JQ
	 tNGdquvBg5g4hnnsb9japNIVVEkioi+9zon8gurugCDjfisAnBwpErZhzI3bJ2cOzlYaS
	 T9SNImwkXmQ9nWHDo0EAKPW7jQmWBU8k2jEedW7DBjVmLCnP+AizjVsiH8NGD9FOv7BoZ
	 p+Z3iNL5RobpuSl6asdDkJ0vHTpr65FdYZbDwOb4DxZ8HweGZVCS87lu83aT48RatVE0F
	 liOAW3IHQitJ+/JhutH6eDkHX1liS+rJ5GX6nMiBh1tf7zdLy8ESK3JQ4sj5CwbGnZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=lzDU21F2EHLB7rOP/VYbDq+2X8MhT5hkKO20Bmq0VFU=;
	b=QFrR0hOj1dpr68V3r7IyBUkwDqAweN17v3Y1qtDkzzZRBsiO66UJVukNZCICep/pJ8M5
	 RerOP2J6CFa8/3COgUptZuQysCsyh8M2S4FIDMT4iM9PSpS94o4RHyQE1J7ujbuwZhR/Z
	 HjWcI0d9QoL993VGaoVr5w90vt9jR/5E5Q/L1f4bcp/1enazHdFNUEjX90TXlb5+8L438
	 sFLUZ6mblp2Lg6RdGdThzBJURHrbStFZBf2IJ+m1M0YX7rqFDKzdWizoJWy5UkHPYWK3D
	 KKt52duxT6H98EIskbyBC4uc9JZX4qIKazC832usMrnV1P3AVJG9NmjrLczx+8WjKeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b="a/6um+d0";
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F7C606EE8D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 10:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8F7C606EE8D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=a/6um+d0
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b4f7d3cd98so1991871a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 02:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1793874545; x=1794479345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lzDU21F2EHLB7rOP/VYbDq+2X8MhT5hkKO20Bmq0VFU=;
        b=a/6um+d0uQTISqAYWjTSS9HtqKug8rg9E2rLH1wkEJ1y4a735hhrmhCOCiwFHxJ3nq
         A6zcqbb/g9Cvv42ERK/gzGNhSpFHNnP3IaxS8FusHfvgiVP5qUxfyDvsmsyN2dl8Wefu
         VckCYwBXoSy9paRds05qrzde8Csv1gyyZSxsRpcSxK9cAn0AAWc2SNpBRxBIuckufczm
         UqU4cZODqkx7b33OgQ6E/1hs7Blozqhb7/xi3/1GtZ9I8dS4qe8Z7m2EHgUxSLW4O6xA
         iqTHsyrS3gW5/HJxkGiV8JwkUV46y1WBvhA4S3tjiqgwztJPNW39oEQZKY0s7NRUH+rn
         Gs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874545; x=1794479345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lzDU21F2EHLB7rOP/VYbDq+2X8MhT5hkKO20Bmq0VFU=;
        b=Nr8S6c9AIzsjKaZODtngZip4O+q10Ee982yNMLgWTPlLZp4njHs1bdlGSvOel8lIVV
         xABpG6HaHm5gt4ismDwFcUm06dZUAVo6BbEJwENDKgTHnJ6EasFUr8JqxG3ymISBw2D/
         Z990+Ru8aa8ARFrHGedeIEF0hkQu/s0ZbAQaV7swhnXYIigubJNT0RqIKjTtDN0udxHs
         2+7v0LqJdz/+oiOtfF26tQdAYmG0dZRa5xPvRrxNASqu4LW5A/Ryn8vkKxFxlAt5uk09
         Vh1EtGG+vne7g8xQFfYxLqoRliPYGQH9T+HwjprujGcQIyKiGqvAbv1ZJ9Hmo+BIhRCH
         lcfA==
X-Forwarded-Encrypted: i=1; AKwUvBxckPBzxkba5HXpiWlAecL8tOETZ52RxGTRbDgw54tvOHK6qYulu5+oAPtvkcmOLrFGhJFqtdE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0b/xj5MWdTAENxX78meAHgs+O7ni/6R4wRFTneM+Ar6hS3Ilr
	eJO4QMrZLy6ohsLLBqXUm6OPCkPRu8cV85V1446KCMxWJDwIC1lWg0B2DgtMZTtDpgk=
X-Gm-Gg: AYBFou24hKWb3s6NRAe04QyJWCO9QpUeSGRUPOUt/Nh0N/37LBldMn1TER1ufLOCAN1
	fV1Y04zWMzUArVXEgDZ9bK2Sn90IkRku7Pxj9+kMmfRGcj0wM/BnESR2s8IzXaRlwLsk55jEsc6
	Bmbbm+/7EwyN58iZzu3//WG90ZUH/OYjl4nHTewmhqQp6iz+TOR5gJZSub6v77x51Ck2SaNr8my
	mwMCzLmEzy8XSG6fHE/jSev/8mXUBmt59YwlDLVMeDnKuViQTYec/GkYPHA5drw6Zu78HEjc3m+
	ZW5aW79++70yPCMIvqC6PxXxcftndIHesoVXP8an1qHdxJwxIFWVEgmOtp5XwJFUipKBVAFJc1U
	ZMNo+S77eJZDM8ut1fkdM7pxB+DrIvuJAb/AfvHXvU1uXBSy9Lq8t3DQC4V8kup0u1rcYzB8uvu
	5CSNB7d0u1NIe/MGjsbMEFRy28/pjTCWzN2TYbER0rza05c8Qu6fGwpJhN5hvz10GA2hYAZnLZ0
	8Oc0RQ7MDzhBRRS6ifd93mB7782k0Vo7aK2apxS2dY+kaFR4zuheA5m6ZqNIYsO6bUDROOInkhi
	KuBosPVXKkBFVpTc8ogT6Ue+5DvAhUb6VCBhFJSqNonBQvyH96pCT7nkcdroN4wolhkUbixL1vJ
	DaLkF/6QHyFA=
X-Received: by 2002:a05:6402:2b96:b0:6b3:bca6:b480 with SMTP id 4fb4d7f45d1cf-6b4d65a8fb5mr13928684a12.44.1793874543883;
        Thu, 05 Nov 2026 02:29:03 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5864a87c1sm278665a12.2.2026.11.05.02.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:29:03 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 05 Nov 2026 11:29:02 +0100
Subject: [PATCH v3 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Fix
 DW9800K support
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
Message-Id: <20261105-b4-dw9800k_cleanup-v3-3-6850ee6a5a5a@fairphone.com>
References: <20261105-b4-dw9800k_cleanup-v3-0-6850ee6a5a5a@fairphone.com>
In-Reply-To: <20261105-b4-dw9800k_cleanup-v3-0-6850ee6a5a5a@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793874541; l=1266;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=mcLSV3KKUJrX2Vt1xs2+yh4YAv9r2QOuUzb8TrvhqBU=;
 b=ijW9VPm7EHX86RDK200oj2lBmSMCAHlv42lvi+mFyiDqBGXFEZsOlxeuP2TZN1evalrtRLzuc
 zQ50VXLhpNbBVipwIcRAQN4VF/7J7Tb8Z9rXnYHls9BF6UrdAHwp2sx
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Update the node for the DW9800K for correctness.

Now we correctly select SAC3 mode and enable timing-control with the newly
updated device tree bindings.

This is a breaking change for a part that was previously functioning,
but only due to manual register writes in the driver. Now that we have
the correct documentation we are able to update everything to ensure
functionality with other devices using this part.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index f41ad446a39e2308abaea68a6b31a7e387881bf2..a657a5dcba9cdf750fab2478ca319f3a592ea295 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -665,8 +665,9 @@ camera_imx858_dw9800k: actuator@e {
 		reg = <0x0e>;
 		vdd-supply = <&vreg_afvdd_2p8>;
 
-		dongwoon,sac-mode = <1>;
-		dongwoon,vcm-prescale = <16>;
+		dongwoon,sac-mode = <3>;
+		dongwoon,vcm-prescale = <0>;
+		dongwoon,timing-control = <16>;
 	};
 
 	/* IMX858 @ 29 */

-- 
2.43.0

