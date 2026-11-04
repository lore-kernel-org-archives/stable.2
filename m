Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810732;
	b=g9TJC3QNXY2HUPtZM4wcBjYXHi7qUh/RIWqkhDR522Vlsfs+7ZXzIe7n++Viwtc34+l7
	 uklXoqFGSuQ5JLkezvP3bhE3iJ5KO6CExTg+Y0a9K4nOnrKhM/JJiJiZkdytWYbu1WVbk
	 gvmA/7BR+uOtnDa6ie6H+If0EI/frhIaLOpuO1rBrDELxmckvKWiXytH3kNvcRXRoB4PB
	 wSzVqCHh89G18x6DsiUqIZevoYiUCvhBXO1ROTH7yxWAWuOfiLpmQW1BSf+fkXpbPRh25
	 Ite9+iAlTd4MhSQWj4Ghc+pUCnG46qvIc/4HV19hE6fidb6D4sc0NJX4baHdlltAFOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a/9ygPAkTkEPoEGsinPiA3vfqnT3GrgOWJ1i5yM5FwM=;
	b=5WY/B5RUF8pJ7G4s2QCkrkL+V/80SgGY3ddWOeMN0LSY61FiJ1faUog6J73V1qk9vBxr
	 aRE7AzC3L3t23gQpYemQ9/ni7mW29Xin+15OrtV28orr+XCt7TyLB/qZ/uM8vAMR3eakB
	 qbmskrkIqIW+1S+ZsFloQkxR2iAsZNxbjO4c+dhPKaix9kc4kdGQd3632fIdPbI70UPog
	 1FeHkv0RRxtA4yJkEnXHievQ8i0d2jZvtBdcwlwYtCrPAQvMV6/xa++Skk2G3TtdNZHVh
	 nfJ0uq3HPJXOL9thKWnPpKIbY1StAF4BqHTdczsH4vjxoHuvK6pY0DDhrZAnEjUG4IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bn/OceYF";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F3606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E3F3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bn/OceYF
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36d6765756fso713723eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 08:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810731; x=1794415531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/9ygPAkTkEPoEGsinPiA3vfqnT3GrgOWJ1i5yM5FwM=;
        b=bn/OceYFwArPyDFSPPPx6F7fxbevCxKT8R7FeB0p2fbvIf+7OBijoe08vy0rwYc+5G
         /QZBWvJuKv/UYxDHvFcwLo1G5AofW5PO7IZT2FC4GT2O6VrxOvu2JcN1jB7k5hdV/kYN
         fS38yTExWUTJGvZc8YTuWCR+sxiYYi1vChhUP2aaBrFUuS7OpBt8gd/X4hXLV1RRI5mO
         ChyQV/5HOvlWE8Kuu1Qu8f1m4wzI2Nu/JhSro6UmNEX+Pux9AKYWt89R04k4H1B1tg0q
         BH8kBQIYND/ACmTt+ZaioNGqcPPB4bwc0yDq1hYXQKG2B83ZPSN2qQsgFmuGLfJUj+QH
         xj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810731; x=1794415531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/9ygPAkTkEPoEGsinPiA3vfqnT3GrgOWJ1i5yM5FwM=;
        b=X38VpPuGDXZvbBlviDKSuiS5QnIxpY4h6TRWYF/LrnoOU4RoIs5j9muodCmxA/Z6dp
         1lb8MB6odOamUsvXu2rlZTmpgw03l3tMJuvPlzp1S1Q4VCU/xWewAEIDDhjyUSfcxJEb
         0GBEx4dh2draBbY0JHPUzJjc/M0k5TpIX74AIGCs9EtlVFyhdWiLVnJW+3ulJdNfWeyJ
         viUgEBXjummB/Bdr7JLbcSxsXvG8yC6u9YcfuEomuqxxRhb6OsJlNe7TujCPfFAmt07f
         mDP2vdydmafwc1iXodA+ndEctpHh0RWWx88+vF7RSe+l/CmsI+rLEv1epSoE29kR0WqB
         IyWg==
X-Forwarded-Encrypted: i=1; AKwUvByCLAbtLjDyYhjcPUFMnN1zFHbkmlwYxTjK4oKpJ3UBoQgeSoy1X8Zg63T5RtSKv2eQBkhVGdk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BBzMM0q6CZoT9nnVnZ2PpAL9vXEArectARMgHsCm4XHVWhJz1
	YC/9KSO8v6uhKjkQpPjBStKawOoL2jtNIahhIlRxQ7N+AJKErInkuFmf
X-Gm-Gg: AYBFou2t8ncpjVaWYMZVWE3MlasqUTv3vXFZ5nqRPxG9DzKp/D5WDj7r07OwjvL2F+w
	0bcG+ChJ/TlAo/LtKi2pM5PpPzMJ941+cXbjWhbjm5kXcUEevPf0x/misnJDwKXbJENzUjMQOzc
	YqG2gyGpLHV+EGWPwNARm/ODnoDRFAO4BiZATQtXIPg7/wU5udjAxIsDi7rG0qljiCmXAJwfDCt
	0X4tf7M4OLrUM9D/zUBGtheRnTxo1P0PaYDaszu+KZ1lebU+0d7YwmLMVnDgIEy52W3EbWws2pt
	YuDRFyPJkLJ78rKjOzQYOAXrHnblmTwHUbjInj61ZEUQ2OWcJXqk0TTBA5K5liZpJ3fbRAv7Lbw
	yyQeOBzvz7QvGw15Eg4HsmT8YVVoiuYtlUKLRGpHEymbYkfiaYwgNt9uTaxqEbNZcPpr84Z2oE+
	+dojssnKHKnXh6pcR84qks5iQyktWEuFuQWwmdEsHbOUmR/TsMwNzmW7lNQSXf7Ur2ytuLIOfMX
	eq5tzj6LPZ3z7nB0j4eSDQZAj8hkJvd8BYsVH6zgfviRUN8T7NJgJIG50M0uSqR1AYxrQxsBoXQ
	m58gAWiSkHMVmSyv7/siIbx1ru52O8mfVgDR3wmhVK3xyMykEyDybZ+HUJKUafNqE/+e5Y7NKr1
	FJ9iDaTMW/2IJFCO0z0Z3U16/hBxTuXjqFglpj+O5vNzt+VCNSkZNL76YxWqWlbZ+gW6ZQ+uBRJ
	35EYMPZtp22LNkPHLD0S2OtZ67q/RFowqtfc8VOrofRQ==
X-Received: by 2002:a05:693c:4154:10b0:369:f4d7:19fc with SMTP id 5a478bee46e88-36a424988abmr28669874eec.41.1793810730934;
        Wed, 04 Nov 2026 08:45:30 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d36a1sm10368825eec.12.2026.11.04.08.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:45:30 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Salih Erim <salih.erim@amd.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: xlnx,zynqmp-ams: limit external channels to 30-50
Date: Wed,  4 Nov 2026 22:15:00 +0530
Message-ID: <20261104164510.105359-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104164510.105359-1-kapoorarnav43@gmail.com>
References: <20261104164510.105359-1-kapoorarnav43@gmail.com>
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

Channels 20 to 29 of the PL-SYSMON block are its fixed channels (PL
temperature to VCCADC), which the driver always provides. Only channels
30 to 50 (the differential input, VUser0-3 and VAux0-15) are external
channels that can be described as "channel@N" child nodes, yet the
binding accepts any N from 20 to 50. Listing one of the fixed channels
there only makes the driver add it a second time.

Limit the child nodes to channels 30 to 50.

Fixes: 39dd2d1e251d ("dt-bindings: iio: adc: Add Xilinx AMS binding documentation")
Suggested-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 .../devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml       | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
index 3ae1a0bab38f..0872f5f314c1 100644
--- a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
@@ -160,17 +160,18 @@ properties:
         const: 0
 
     patternProperties:
-      "^channel@([2-4][0-9]|50)$":
+      "^channel@([34][0-9]|50)$":
         type: object
         description:
-          Describes the external channels connected.
+          Describes the external channels connected. Channels 20 to 29 are
+          always available and are not listed here.
 
         properties:
           reg:
             description:
               Pair of pins the channel is connected to. This value is
               same as Channel Number for a particular channel.
-            minimum: 20
+            minimum: 30
             maximum: 50
 
           xlnx,bipolar:
-- 
2.53.0

