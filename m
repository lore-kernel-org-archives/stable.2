Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846377;
	b=xViZ6sh/dbHDz8qMwtdgK6ThFdXuqGdMJtPc/DA9UtaAHxOBgN1l5V8xy0cQxXcqtwMt
	 w5z+EjbqZUORltz1a1NediVIsFJBVRmmX5iPtT9prOiAoyOroh3VlzvAI2NuxHumG1feK
	 aNLQ0XK7T9pJ3Xs01lTtee2s9e8HiaMgOVNfAAqse4jmQKepLZm+Y/zScfaLy3LMdeF2A
	 WpiqFPQjjkdiYyWwtkcYc2dpG//R6sVmaRPcjG7U6d6DQwP6r2wpAhwce16OECeu5ktVg
	 OjvEMYNND44lJ978TGL5GCsAmvA9q/dBCVFpE2ne1Gwa5wFNTJxPjncnEkL6j+SriWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846377;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
	b=TEcaSyHFJyVLkSOGDb0KI0y1N/dubfKMdmXG42ALrlmB1zyglQ09Kxhw7RRgWT4xE0PI
	 8y0iB7i7jKaoGpjf0731ITTnUYq3SMmX0y7B+WOE48iaSHATA/oEKAa/VPtVjbS1uWti2
	 rTQX3ohvWhA0xM+X7/TbMUPNSvoEbwjK5mBlL2cR2uQgbHhqk+7xS/ggpWbrWw7qI0/eP
	 qlBkFcD0W+RPqCMuL5Xm0b52UnMdHv2t73Xq4oZV2sM0w4trNgXSjyrLvSvWqrK1ZF6bY
	 MkVo3Jm0EwgAtpwZ1wz3eO0Yizgb7h3kWCI2wKssanS8JFLLifrfdYghITrYkXu2ovw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YvGST+pt;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E6606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660E6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YvGST+pt
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso697583a91.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793846377; x=1794451177;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=LnrIwe3DINWpDTty3lO7Hj1A60STaTHYrpqDhnKrbEMFlYRE9mWd2769x8JaKSUlCJ
         izonTaDP8oFy06t8lCz+4IbSSkJSmdMPtR6VQipqtVG/gk5fbiTlPyPBAq00K20OT5Fx
         g+GKCFiWwpBdf+DtT+H934TMHSe5YaMDw+CY/GdlAKHsXqAkGb1owfQ2vURlu4dZ9CVR
         vvlKq0oC8CsbhQttEqZNPZEXsf8snURJSE7GeMuIzUePlEKF2moIDyKTwHoLK27ceey/
         bld7EnDZOSH58807WaEm5b1EtofssyjWytdF/fD3+WcdFYXDXXVZf22U5C5+idpoLElk
         BOjg==
X-Forwarded-Encrypted: i=1; AKwUvBzIPwi2I3lqmZShpILKyWaOgvqdmRfpNbcjH9OMYBwHI9PJfft+WkTrzroMIx0Cl+/EnCdWpEU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fIXLIo3Lissb2xCpVyfyWf0sdMgIgS6TkW+U7k/TCF+B5b/bc
	QpSjv4qnaXhL/KsamrimQnb/T5AzWcbRRmA9LzGhInxihk4/yKwDUPZJGwzVo/DEfnDAIvmTv6H
	c6kHSuPV5ZSxzI3y0C9EUXD+kB11BpPYx2NnKOrdpL6i5vKdXl7fGu73VW1g3LnaiWQgR/qqqtl
	YuMfvh+hcYv3SPB9E1fkP6z3vgqFiE+96XpxCgjqI1FWphOr1s5u0nKkJKrRn85f3QCnCnW6Nz3
	Wa+cT57H+dLvgFE
X-Gm-Gg: AYBFou0/L4yT2mO8s1bMiSzHyvqdG4ccNDXUqLltYV4yxZGeGolpeAZ9LwgeyYk+nM0
	z67sT4zbO5NnVyLOFZGe3qAzxf78XXuOoU2+BIIYMp7yMg8i+bl9ESstlKvBOz2VVpI8Q5S/gAs
	7xsBYh8RmkWitNIt8QmJMAyGI0mo/9Jlrox7d4SIekFjYk8QE+2D46bGDgUptDewJGOw/D+izyu
	Sze4Gczakv2aIIWWoLg1sycdc+B/DJP7YHzen6ZupzSKaz3f8L2UKtoPnskogibw1eDuu7lwASx
	S21lUMNZzk2Ihsa+xSATMWDIOOXMg6klTjciTf7frQGu4Hsj+kykn+NO88ktzu91dmkeXCN1SqW
	Lh0XIV2QG6h3p+ny21yFrhon5Qxkbcw+HbBsURxoAL+bF+mKNFAQGS+/AJgzTI7arTKOLbumBhX
	vQCbXrRsNuQQGMnfioMLYktic/KpnSvdJw2Xa1rKC1
X-Received: by 2002:a17:90b:4a41:b0:3b0:b03b:699f with SMTP id 98e67ed59e1d1-3b0b03b73c1mr1260046a91.1.1793846376452;
        Wed, 04 Nov 2026 18:39:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b3195213sm922552a91.3.2026.11.04.18.39.36
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:39:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36d1353fdcdso3898885eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793846375; x=1794451175; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=YvGST+ptJe6F39Eq5rGJtNWw7Q1p9uAmMClUEYCFQ0iuFShkKj6z/nzOvMa4aI2I8u
         1pOmvy7f9IMHjKtX0btqL+ibPZJdPIggYUdxdtAx+8u+oMflTjZjCtGDR/2cndUWlC1G
         HFeNd6lnZAglmtf/GLNci4Qaf4ITkHdb/Djqs=
X-Forwarded-Encrypted: i=1; AKwUvBxxIUIjH1t0rCjzASRfjsQzO8P5MCK1IDYyBWnVpZ2a5aBmEOUeoPyFecZDoTrP11QDSCMYrB0=@vger.kernel.org
X-Received: by 2002:a05:693c:41ca:b0:36d:2b50:4eb9 with SMTP id 5a478bee46e88-36d2b5050femr3978955eec.25.1793846374824;
        Wed, 04 Nov 2026 18:39:34 -0800 (PST)
X-Received: by 2002:a05:693c:41ca:b0:36d:2b50:4eb9 with SMTP id 5a478bee46e88-36d2b5050femr3978910eec.25.1793846373963;
        Wed, 04 Nov 2026 18:39:33 -0800 (PST)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36db94376b1sm4756075eec.10.2026.11.04.18.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:39:33 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:40:54 -0800
Message-Id: <DMMXHWJXBCKN.1OOHPUSW1BS7A@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 4/6] drm/vmwgfx: reserve dumb buffers while detaching
 their surfaces
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-5-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-5-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

