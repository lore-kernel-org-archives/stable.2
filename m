Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795821516;
	b=rvTUy3use84WzAW6Pbb5tvdoDuRNxhbFqCPhKECLpzUrlFF/glfcdsq7JFkqT62VTbhk
	 +whycn65g8kzpWpDTKx58qoEU+BVvWJ0VG6/Ma8qwlhxcuN2s16BTntHkmAoXARj6p3yx
	 2Zq3PWx+C77vVbQY7Xr7wgMhZ2+gIX2bmNuD2nIkBWGrm/UB9xo9tfUMHYRD1DqTqzPsF
	 w+6/l7K6JpMoQo3u8g8By7ad0HPutp7cvdAlzMB0BTE61sOoPLQ3HI9q6ylwM/4LH1vAj
	 QNL3Si6bUwQHLB/yDqb4iIsfSvx5FhSOUq80pzFgFt4GVX70G5JCYY4uYvH4CsA7A4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795821516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=L68NfkLh2sSnkPajUSfsYj9MfFaavbba0O0y/vWyU0c=;
	b=GPE8XCe/R/Y71WBLD+RbCCtY+aKLabS9Ga7rc82OTnZ4DFeOH3N++2AoWejT1+lURbmm
	 Ynfd4gyhOi9q2bj+8tGfDij+c0WW5Iukd1SGKgb22JWai7BYt+YkZ+qNov6UXuEkNtl6a
	 9+rgX00dq7rbgWfWvjO2PVkZ+IpXFvk92Qo9sMzW05/MTOKfsPCStIuPUeZSnkUPLNrjc
	 gpFPtBiIR03KUNcoACdi+rg05fcBzj/FMBHwA/ukHA0p3zjhmAO4YVERizP81CGNPRPIM
	 KtqHjL+gh30imbCKpshCPUqSoF5d5LkEZRfjL/iXCvPaQIfAXfJiAsSAmMfphHqdWPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gE2gqa1H;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91426606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 23:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91426606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gE2gqa1H
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-491971ac844so7552647f8f.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 15:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795821514; x=1796426314; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L68NfkLh2sSnkPajUSfsYj9MfFaavbba0O0y/vWyU0c=;
        b=gE2gqa1HASDlw4HLZWgBBQWSdvUizr9GH8J6QVL8nNPedx6uB61BV+HUrF6Wuyw/BB
         PcA6z+0Uj48zloEWvjEtcqzJ6IyjLWGQdrBFlb9TfOIALwBJmsi9FopHkiOS+kS0Zkuq
         lXR9jkjMff8XjBdzfe9l+t1Ajy7tytED3MNkSNa5U+qORRIxgJl/MZxYtBhsyHaL+hu2
         rfA67xg5fPpRqOtfSCJbWRjoq1vy3/2eACqpJWjP/ndPBC0iOXPGzPDFNi+qvLOYCeIM
         TnX4kg0P9GQQjDzUxH9rCeI2O8r7iWh5FFSvfJ2RcZf1Az9ApjNXvlcgLK5AyXr+P9B/
         WR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795821514; x=1796426314;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L68NfkLh2sSnkPajUSfsYj9MfFaavbba0O0y/vWyU0c=;
        b=pDiH79s/zYCUBYN83n/ch/SPSDhoGEyOHpaZq1LidbFKomnlHQuBsKt+WFor92kzas
         FvfurFH9+Uw138WMA24mS96dJVIr5LgPZB0HiNfUrFb+d1NxBPRGsXX6eykZRqJH0SDc
         FE4gWh4p4DBUmqKYdVuSaGhdokmEFrxzFBvH3yLni+kYwxajpB0dHht3U2VL+YUAIfed
         4yX50Yv1EO8isyR0NQ5f93neR/mVaobvv3Z+SwtgZ+VfBwSuf9Rsm7Exqrk/9ZtWBtlg
         DhxU9c+0pIC3TKYL510W9MVoTDijLQ3/VWNHJyRV3A+rG/Rdcnyr54lPKXtJaJb4fLuy
         HgXA==
X-Forwarded-Encrypted: i=1; AL+hErEFxeRkrJL52cfFAiCsQvoQIIqRiR8413h4DrDRsSu1CsU2Us9ce22Gk/BYI2q3jkgMzrrbkOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DoKi2OegxDJbq49ZZRBYeSzBkhnkEN17416yjtR/V1FXHtdGV
	3c8X6lsNU6x3vssGH5fqcJuvMwMpXwmNpRbVCEzKOLqhu7bFlEkTr9KUZV4PMOgsCdE=
X-Gm-Gg: AZFdTZd91CGn9tQ9O6OpOZ1BedHNKYf1EPlSHc97yWSbiav4nLeQ0Or4o/Y/LjtcrZJ
	7X3lF//tkiVpuRiLnnsKUz9EtWH+8wtGCm4D3X5ggvVLSpOHtgI1DAkqr+5FroYMXJzVoqKvtxT
	q7hFwVUbBjTHPQDI4Ydaruaf1cwojJMutAmZ+EnCrl1Qr3KyrynmOj+RNpg7rRyItCv/Cb5xT/p
	Pg55ZD3yM0X4sWc02v/sqEIO8ymQ+eHpJV0fxhoPYfrc66cRIfb14tjOTOVTxXJ+YY+IB+wX0Mk
	yn6Hecpk6yzZOYuIyZZRVk1faqMmcygATHjDaRofs58Rkh0NVnNLQsokQas+Sb8NUZX7xyA52Cf
	UWQKbxyTqpZ2nDSt5hEKIob1YjGq7hIAJMsl00cUbWuVPG3QCDZqaZ78MSUvvoAJj1/emKRul1c
	6xNhSVC1pbpc8urbTiJkokBTUlGjwoq0ImfDABH/oL8az/FHO4ZoEqcP7HZOiuJLEq1oc8QwXfV
	+HhyU4Bdo1Yzdjk/epfZeySwDIn+ZKpnVsl/YPfzr5qzQVBKC2QC5tiYYOoCGyZBtVdFl5BVFLT
	5BH1UlfRHiKuWc6GhbNTL742puM=
X-Received: by 2002:a05:6000:2b8e:b0:491:45bc:d69a with SMTP id ffacd0b85a97d-4abb3f158c5mr33838415f8f.44.1795821513578;
        Fri, 27 Nov 2026 15:18:33 -0800 (PST)
Received: from [127.0.1.1] ([151.42.79.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2052c8sm49822762f8f.41.2026.11.27.15.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 15:18:33 -0800 (PST)
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
Subject: Re: [PATCH 04/13] mmc: meson-gx: Fail request when descriptor
 chain DMA mapping fails
From: Valerio Setti <vsetti@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, linux-mmc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261123191703.179283-5-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
 <20261123191703.179283-5-lee@kernel.org>
Date: Sat, 28 Nov 2026 00:18:21 +0100
Message-Id: <179582150150.1958718.8445295799895434689.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=vsetti@baylibre.com;
 h=from:subject:message-id; bh=8BHON/4l5h6q1xjm/WKKH4SM6biaPJLVHJzVeZlzOuU=;
 b=owGbwMvMwCV2z3ty7kUrRgbG02pJDNlc/Ef1ln9ojoqOfGmv63j0Za3rE67Ytoe1i3aea+zbk
 Xl4U/HOjlIWBjEuBlkxRRaW6fd+F5SqPTROOFkAM4eVCWQIAxenAEykKpHhv/skRnH3ZWsKxTbM
 FxcprJMXFZi7cAO3n97ixSuES+q0PzAyPN0r92Wbun/44eYT/FZf7qt8Piy7m+G/VFx8vqJM/Qc
 PNgA=
X-Developer-Key: i=vsetti@baylibre.com; a=openpgp;
 fpr=0497DEFB707526E13360C970DE4B936DD13A0100

On Mon, 23 Nov 2026 19:15:48 +0000, Lee Jones <lee@kernel.org> wrote:
> meson_mmc_pre_req() flags eligible transfers with
> SD_EMMC_DESC_CHAIN_MODE before mapping the scatterlist with
> dma_map_sg().  If dma_map_sg() fails and returns 0, meson_mmc_pre_req()
> logs an error but leaves SD_EMMC_DESC_CHAIN_MODE set with
> data->sg_count equal to 0.  When meson_mmc_request() subsequently
> dispatches the transfer to meson_mmc_desc_chain_transfer(), the
> for_each_sg() loop executes zero iterations and
> desc[data->sg_count - 1].cmd_cfg writes to desc[-1], corrupting memory
> immediately preceding the coherent descriptor buffer before starting the
> DMA engine.
> 
> [...]

Reviewed-by: Valerio Setti <vsetti@baylibre.com>

-- 
Valerio Setti <vsetti@baylibre.com>
