Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798714;
	b=QdZLxza+djakRKCADleeooCXlDkKh+Pc4n0Ui65pYPtBZPsce2Molxpv/4NOhbzF7jU7
	 /O2/pRQg+0aFQjRetaQ21V+uunyTt4pvM2+jjX29kOQbauWnqt5ZiGhaJbeFvNIMBZ1xu
	 IPkOOLSUQfGIpUZ2FJX2ZhlIrgBu/NOYgR58uT9eA1Cu6cCHOTvjhC2c3VX0z5gYWrc5N
	 b6/+hmbFEUoTwe+BrlExVBC69lLjjTpC609+7/PKANvQlMmt7n9kOcpzCoKj7zy5d0aUQ
	 uYtosb3462Z5QDsXNJzBvEfrjGe5icjZeAZy8hwnEtr/WAaXwImMkibGXhnO4RIvFcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Yi+Mby52IcSMxw6Bb+wKdKUkb+i4YW8eVg++kxowvr0=;
	b=S0W2qKEEP+AS+VNdo3TnEFN+uTzjHEVnZbxguVRegJrbvU2rZFUzUmyh0Iqsdz4r/sxX
	 EenHIK4YLwcm4QMHvdWXCJGV43wyFAFuixQblKTZmeZ+bgM8bhXy8vHBjIZ8pPRsKa1KX
	 uh8ZZQFhqdp5IUm0i7twkXQVWGWN1MrIYjSzMNTjJad0nvfRHiy1bULE1TjBzO8c6MVnZ
	 kz1pS7Ad21RkoBDI7B6XgUBOgyYJQRrLNOcJz+v+uT4X2iPSgA05lARTBOKqNn3/WLOkx
	 dnUGyI5qm9Snwi6VLw3xEiqJTZrDAwxbOP50xvYZoyBhz1+C4HirpQosiZNUBVV+qWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P4UAn0Ic;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FD606A326
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 23:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B39FD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P4UAn0Ic
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4f55a53898cso645868b6e.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 16:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792798713; x=1793403513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yi+Mby52IcSMxw6Bb+wKdKUkb+i4YW8eVg++kxowvr0=;
        b=P4UAn0IcmbG4TKPL5B7PSEMxE/hzhWK30fdwhR1zlTmj50+x2j5tC0kkR1xTzVhsZ3
         cDnNBiO+Oy3rkR/NwqgWSQoV0UHc8YPQk6eNsaEQh6J4UMEtastpUQE1Vu/ylyOS2N6G
         dteJ1UBlzz5Xfuktw3yReIkvPi6sFZ8zvUaoTfVBjoAopXYHAN87/HHzryk/yWJO7X9Q
         MFMF+lArsuCIivGt/trPKNkb5fItEgvfH4ehlrNNdTQmWFDA3WH8lcOKQDMvrQaMuuYR
         kKETWRd+LOdkb4qaOKlOWrVc6so7NJz7nNePTuHLlqMF8T+l9GeviN6pN2y0ewcDb5Ws
         T+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792798713; x=1793403513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yi+Mby52IcSMxw6Bb+wKdKUkb+i4YW8eVg++kxowvr0=;
        b=qdVw3JVG+GTtbmXM8anGmOunmcHKop7CrCA4b25KRUjp8u2geVmFnJqI6zoIcXzq21
         LQr9Q2kYgy/X1koVGF9xdGXEmCnn+l4yihKgAJInVTnl3cy06G485946bGwTcN/ZAepl
         J8PovkqoTcaMuyYQhqoeNDln45aenoGO3GUBgw2DUlVymHthoe4OIfEo3epIXP2+zOeQ
         LIlTB8HpOGbgnkrgcmL10KvIv0uGHLqPvNQgeZ4+ifoY8cDKNQ8N6BGDrn3eEbeGpz8c
         K63t8+Ui38qhzHh+/lpmpHncpy2XseEdSvlNPXXa6h2/qKUjgJG18Im+zuUs1GcLTjrz
         xiTA==
X-Forwarded-Encrypted: i=1; AKwUvByyD1XhKTfTmk0vrDUzjhOgizq2IKu2mWFq8e6shCwA8J7ag932TyaIWMmK+xSvwVKDKgj2pBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOvXu1v8Ez9pRd1gxY6KBqPRhZv2HZJYzkak+2Q4AkGf42nKO2
	Eqdr2mQhhWt7KrBNIPQkxrrOHePoGs1BkVFDOGtTBrf5o4jIJURn1Tbzv6dMD8+v
X-Gm-Gg: AYBFou1KyX1guDhgfnj4JVpzH2V006xG6xjzo8Kr+TW6OeLRfc6LsYhykMhyJa4PSGM
	0tX1obk79ObQH7qlCxFUQm8TsaK14GM0FhKLwjAV4XIhQMK8d5EFCJhEpe7X0rM5hhb3x2YFUDm
	zo/5i5iRq42Pd8bBMrnN3e8Lprj8W9iuESVhRE1RFuUBkZHXw4lxQiqsTUjMsW55PWfaU3QHslG
	PezTT8Hv9ChQJ9OaU4no/eCBLsTalOV4RV65EQnekuCroAcGc5pltEBgy13ZuD+hYhd1e1Sl8mT
	Vcitl2lQpkkM6zYAOTyZ3Bpb2XxhBs88zYstmVo40CHUNsIxvqPegEk3reIDXA2IgpNOwHahRIz
	LiHLP2VOuV3tIrzrpQkY4fnHISkx6KHF/raK+jkAS6Pbp6gTY5Oq2E+qWG2FhtfeWTqU23BTNhb
	Esj29Y3LvaDCbUWXoFdayyVu3jWN9N6NM+RGXdnyGmIAc9yf3ydyx0ELFHr6pDsu4JBRXhw1/zD
	iGD0ddcWSYg3pqXcxIv6VW/UgbUHqeVG3UzPh43dKUY8HP5/pwzybkCb470uaI07brS6sc2IgPY
	9CeWVEg+pzfu0+4zbq3AbqZ/7S8Orkrv6Z6NFT8y3zW9GStSXHCNpzEnTFSZXFTX9YArtseULc2
	to96bX1jpQZ9MG8Z1kkCV6hFF5JcC8r1yWAc4zDgfdu2dj3z7R2elae5fH6OkGbvhXKkSR1S8Sj
	Iy7q0=
X-Received: by 2002:a05:6808:c1b4:b0:4ea:b0ab:b753 with SMTP id 5614622812f47-55c0028c346mr545139b6e.50.1792798712613;
        Fri, 23 Oct 2026 16:38:32 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a843225d69sm284345fac.15.2026.10.23.16.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 16:38:32 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 17:38:20 -0600
Subject: [PATCH v3 1/9] dmaengine: sun6i: fix physical channel index in
 interrupt handler
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
Message-Id: <20261023-submit-sun6i-dma-lifetime-next-v1-v3-1-ef1acb0be768@gmail.com>
References: <20261023-submit-sun6i-dma-lifetime-next-v1-v3-0-ef1acb0be768@gmail.com>
In-Reply-To: <20261023-submit-sun6i-dma-lifetime-next-v1-v3-0-ef1acb0be768@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Arnd Bergmann <arnd@arndb.de>, 
 Maxime Ripard <mripard@kernel.org>, Jens Kuske <jenskuske@gmail.com>, 
 Jean-Francois Moine <moinejf@free.fr>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, 
 Chengfeng Ye <cyeaa@connect.ust.hk>, 
 Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

From: Hongling Zeng <zenghongling@kylinos.cn>

The interrupt handler iterates over register banks in the outer loop,
but the physical channel lookup uses only the inner loop index. It
therefore handles every bank as if it belonged to the first channels.

For controllers with eight channels per bank, interrupts from channels
8 and above are routed to channels 0-7. On A733, each bank covers one
channel, so every interrupt is routed to channel 0. This can falsely
complete descriptors for unrelated channels and corrupt their data.

Use the absolute channel index, calculated from the bank number and the
controller's configured number of channels per bank.

Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
[james: use the configured bank size and describe the A733 case]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/sun6i-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 8752969366ff..9d94a37fcf10 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -603,7 +603,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 		sun6i_write_irq_stat(sdev, i, status);
 
 		for (j = 0; (j < sdev->cfg->num_channels_per_reg) && status; j++) {
-			pchan = sdev->pchans + j;
+			pchan = sdev->pchans + i * sdev->cfg->num_channels_per_reg + j;
 			vchan = pchan->vchan;
 			if (vchan && (status & vchan->irq_type)) {
 				if (vchan->cyclic) {

-- 
2.53.0

