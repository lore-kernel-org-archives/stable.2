Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B84ADD8B
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716183; cv=none; b=bTKBP2R5IV+qLbiV6GlkAP4QiBVHUWYHldY5oH898iD2nhV1YlMNQEaB0bPO5+FXdk7LMbXmiMAaB6gaoE1shoq83+cxZTtPl1p7Y8492f/0qOD223H7JW7YW+CMFLeeZuc2s36la/sRkpyryCT1r/0mUbKjIoCkm6EA4FS0q9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716183; c=relaxed/simple;
	bh=JUnSab4D4cmQCvYGqezRnjMRf9ULW+i5vXU/rQB8eJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmiIDxT+7+HLek9lgVN80sN44GiH8Nj+rw0aAJ2F1NvWdYzf8V4YzIt55q1+srtQRxD6jdo23EbNzcye7EuRphFBinOk+5ek/qPaPex5m1BeDXuazorBDuAQLo5erB8aJByOZPqRhhh48heOo+jlRDPLMKftNIpoxh1Gt/Pk60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptTuMt4V; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptTuMt4V"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4908b92904fso74737775e9.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781716178; x=1782320978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUnSab4D4cmQCvYGqezRnjMRf9ULW+i5vXU/rQB8eJA=;
        b=ptTuMt4Vkw1EMRKYUqFHwFf5/qhBXY5iQ5LKEAYiJbWk0GD7qGhvyvyJSJOliZFqyU
         F+Z7DuljMp0YP3PuApUnzVLc1viEzi3SkvIAel7P76oM/OJJhnk6moDfcrCW61JbyjtF
         SMse/2GAsbzR9B8cbfScsKQZgPhQdGg9dLFhYq3BnfRnFGnnWcZ6OSbWr10hxSYatBUO
         gvuN7nmU6i8XdeMfTzCx3/djVKHxEg49W2eamDoMh+RivzH5JQ1957bwVYLZGjRb+Cfn
         q4d43YGw71k5smtgECna2PAtgWAXGsJ+Jd/n0Wsj9GHsuU/mDH3/kS4lK0ZmZnJ76yfj
         BOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716178; x=1782320978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUnSab4D4cmQCvYGqezRnjMRf9ULW+i5vXU/rQB8eJA=;
        b=iOYqiOi95zNGW4BFrmC/wh1lt9F1X6bKtmpR16FwOo8GZZ2GmDhVi9H5aBhkJwYEBD
         p43lGf/VRY9zqJfzo4QgZUE6zPDZouZDFiYQOJT+kija275XOh4u9fEdykm8d04iCtGE
         q6m2txFut9irVoCXWVR5wJeApPHumxgCYBMg5+Mn65CJdcsb/AhtIh8T7GNdCT/9FNF6
         XdfLS60jHSz6KpkY5tQSDpbYZqWQZ8szvYecEIJKWAFTrNSJ1J0qQLKTC9RDAs87vFdl
         U8IfBUX7XjKVo+6FfyNe5A3s515ICslj5U96NgQSUj/f6XrAqgnU2HIlJSFzYL3QGcgW
         PIMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dqSgUIowGuoum3Blkll2U8+vgnVipR0QxK9FKh2uq8Dp4mDDDMGJON0ZaQAfSX+vQ/h2qhy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfSRDMmXFoAtU/y6rSDpn0mXHZKOe+fqO1g/aOsXGSbYlUnwA
	ljCiqQcvEAcgH4KntR25E2IOmWvIyATHlOkk6Q8cW6nH6FIPaRJtSVJ54mD5lg==
X-Gm-Gg: Acq92OH5EKo6fdwYcHkF/ns3x/f95unb/ACSef9QcjQHpH9fJGRjKPfyC73x9bmS0uv
	qPLGFuKIWfyUQaB9eambQHquljK2jKYkLCEnohvA2ajZ5Ftzd7ZrIPyaSR4AHj3DxcoVfgSj5Tb
	Cj8hnb2BT4KC1Knd4ALrPggMK23M5m7IvgbrdU5CYbksBoljMfbvC8hxHIe7Do6BFqn+NRTt6jI
	B889oNRhc1Z4qdk3a4mjUDFKFTKYmP5m3DCUZ0QpxipiFpPqenpbXVtVodguyyST3oAMZIeqBSy
	bO2uBp/cZim2UFRxvJwuY9vG1ZV1JIyXH0Sj20UX5kxjAyh4sKcjfmhYGKEzayAXq8x9lTJ6N/T
	Gn+cxRp1xoBrRyqGWxt1PwBteSfsLmsx1iFm5+ZJZ2RWOmQH0Zno3peAZ3XQhgSss3KA5EYGvro
	YmjezU3o1BKkOjIckWK19JiFzDoo0nd/LBiuxr+tq1HnFhGRuM49riAOxcyhSO+bL29ZDy/y9Zw
	O5E4R1hL1DyOwUKVIZ9N4dW2w==
X-Received: by 2002:a05:600c:3541:b0:48f:d5a0:284e with SMTP id 5b1f17b1804b1-49234132005mr69613935e9.28.1781716178292;
        Wed, 17 Jun 2026 10:09:38 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-122-99-120-gprs.simobil.net. [46.122.99.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49236860482sm19462305e9.0.2026.06.17.10.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:09:37 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: p.zabel@pengutronix.de, wens@kernel.org,
 Zhao Dongdong <winter91@foxmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Zhao Dongdong <zhaodongdong@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] reset: sunxi: fix memory region leak on ioremap failure
Date: Wed, 17 Jun 2026 19:09:34 +0200
Message-ID: <BoFIpAKHR22rGns4zmN6vA@gmail.com>
In-Reply-To: <tencent_2C7697B076D53BBE62D99B7CD15E77A20C07@qq.com>
References: <tencent_2C7697B076D53BBE62D99B7CD15E77A20C07@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 17. junij 2026 ob 05:16:27 Srednjeevropski poletni =C4=8Das je Z=
hao Dongdong napisal(a):
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
>=20
> In sunxi_reset_init(), when ioremap() fails, the memory region obtained
> via request_mem_region() is not released, leading to a resource leak.
>=20
> Add an err_mem_region label to properly release the memory region before
> freeing the data structure.
>=20
> Fixes: 8f1ae77f4666 ("reset: Add Allwinner SoCs Reset Controller Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


