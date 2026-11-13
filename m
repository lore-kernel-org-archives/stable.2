Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794555964;
	b=G1nluYSNVsM22M+PRYqHH/on8B72Lz8v0OZstHJDKkeWlNabXRuVOWeCADbk0hanahyJ
	 oyF3KM2iXMlmZsruM4oTj3fcQgB4hrBCEksurVorsDtb9Y4fIgLQ0BzNwtibOSwPDvmAd
	 O/xZYQDHMvGNYw6LkOx/PPYqNWNb32OAloq9lVGBYIDuCQkW1gdWOfESBjQbG1EuWQSdu
	 00jI9EnkVJEbcUN2YpwyDuLfZStJ3r2CtCFSyHe5uRmHOxRdS14xSvEFhAnuFbW77nZa7
	 tPxOBsV2JOhSo/JIoYd4MpGDLJTs3DyyXuduiLeLDbV7mkS+IPhRFlk4Ji6hvVMrEAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=tvPQQMwBZ/Lg3SekknzYW0QsE4BK2jGjRwomhq4ONEc=;
	b=SaziN6AiJ/g7yo+iHL/9SkJsqXvKg8D9Ro0gOrj0LxpDF5b91P1gVHXeNqovKC6gFC0n
	 /utE5dWlqVKbk6pbg8GOuPAtTJgi+nQAx9XZrGY5S6JUrG7LIatnP/EzZPJD9m2yxXjfJ
	 SUft5zSmJpLDA7TbgwnJo4bPBd6WZTRLF8sVoQMsYLYphrO16ys0aekRDcQJrG9fZW8hK
	 JJcDjXOLk86/552ElRJkTuiSD8ZeGyPSiAHwF1Q/15I23coXSUQzE/D5fx9T5/KMC74mF
	 ADN6PvTXHJQVT90QDndhIts3pbQ/WCybiEWi8NuG0CFLdwWr/jQnzTrFAuubiIVu2ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DlV5pE4W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8D606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50E8D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DlV5pE4W
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c09e2ed679so59239e87.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:46:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794555962; cv=none;
        d=google.com; s=arc-20260327;
        b=j3bKoCZKKWcDpildCmqN9PrfuqRow9dDpqxHSIefXCm2vw2ttxJ1t0P66E6JGPHybZ
         obKNb0Yu4DKv5QEXo79STJacOGmyyinOOx0vi7dzYPdqOIia6eZt7chix77keI2X+i6m
         gCqS+u2zv9DUgdTLQbCL405LIzsh8mDNuVHMUaiLbS8py/kSSYrEbVWVz92nX/G2ME/S
         cUxVu3XFq03GMBsKAfpO2gw/hTgZsLsx1f8ZLfhnjR3MwnuC3O9HchhSQW18QyBj5fOp
         U8dedAH02ibkIxJj7S5ncZOHuQ+1WaGsjT6jFOMKrLRoMLQGz36y2jfZcX8kTLKUdiiN
         6DMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tvPQQMwBZ/Lg3SekknzYW0QsE4BK2jGjRwomhq4ONEc=;
        fh=FtfvOBvcnIE5LSliBNPMVtDkSE52Bh8P6YMh5SpOrrA=;
        b=P5CFgF/vgVEzFNbH6IcFfU2k1NriUR5GpiJDBiADWzxbz9Lvgd5RZNFcPwhG0OQmpa
         lLuXWom9sM+V8XYesT0u2anil6oKxiaJ6EBV5Nfvv8w9M2N6l6pHeSL/TExxvwFRmA6W
         fiIDawDTlBf9OnVglzUhXIS1Ud8HMU38gRFJIYisVEfMkQkAAOYxgOXZ9DY4vXQofUJK
         XiBd0EUvbcvFy/VqyMkZR8NeJegAN8Yk6d8RM9xe3oP8kO3sqfwCeW+GqhJORTbuv/6b
         94SmN/k6VW6x6oZY0QnDiBg/FBIGWwW1/UBZlta78xW6fi1/rXkp4ExRlyZ/uxiktZ9D
         dVbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794555962; x=1795160762; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tvPQQMwBZ/Lg3SekknzYW0QsE4BK2jGjRwomhq4ONEc=;
        b=DlV5pE4WyozKzf3B5GLFZflBg69H+ArJqhA1q9Onj5Rac+wqD0MqfXqqkk6+0utQfH
         oHo7TIF5iYCLL7Fc2hNjSjO3vs05ewSsUTy9mcDMZCSmSpieIyKszHgDUvZML6v9noul
         NBHlUnHbzeMPl1O+MFM2IVK/LfZVMzJ5t5d5ScnWJwJenfTp9A4CFmtbZAsuZ05M5+Dw
         YUEvm6L2v/VttYbRFz8v8XDWJU72wdYRJeCsDQHfd6j4exyXF1vggZDlf9+JBqbO979/
         cnJbwKnqRKkZa/GSdZ2NGD5cp/idJe3tUyaEJ9aF2nraqyFZYntKX8truvnL9g55l841
         Qoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555962; x=1795160762;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tvPQQMwBZ/Lg3SekknzYW0QsE4BK2jGjRwomhq4ONEc=;
        b=X0OOfc6okxsw7AD+mY5yIr4CVAfYhQtUsFZpjbWsKG4NF2reXHNFlHHsCvSlpdvzc+
         jM5UPCTrnaEgrOsOJoqSD7JioNmG2QPVGEOiX9haH3zuKWXYpvoAGSJpbESpLmqKlV11
         5nUiDxisz3aqEaHgbxv6qSJse3CInQCRErka3QJfu36/ku5+dKLZwbx/l0hv1nFOoGFl
         DayfvqPGUCW2SmtkD/xDyc3hOwno8XlCg3xnl4AxopymwRLYBqLaWaT2UvBfBDrAs/Dn
         9Riux4jJiapxFgHElviExZelh6ff1KQj7WRjuaMUDOCfW7vp/ZNBcDezXDon9je4TWqz
         RrHw==
X-Forwarded-Encrypted: i=1; AL+hErGo1/W1y6jjGPuERDj+9Jj5XTlXUvwEOzsWIugyRWXKbntVUEKqHXKgOYuCP2ORYfGjQm1Ssi8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CpACXEc00TNWWRZ0lIJN2JIBkMfEkyeiIhusnXjkAVaXLlGhN
	vgV6w06FZyoGgOL26WX+4S67C3Hfyf+IoLGT4S+yoEfic9UXszAy3Rxui3LgiZeovcu7wIJbxAN
	F6IfuQE6ef2Wv51/sWzRNGflNoy5A8SX6loAZCucjqg==
X-Gm-Gg: AYBFou0eWPQO2cVyoMFmGFoYHZRztYwhC/vhAcrcIMvzWwW5LYM8fBue41hTpiaeYAb
	mBZoxnJrlwYa6Qjjb6kxjzOGF6bs6MLsQKWFplLBgiDHiZPWtfsgQRdiuPCiu4hlkp/t5yCfeDR
	BkG3vksuosiuIIqExCXSFvbjM6IdAvpgmArpQ/A7w4ts8Da/OHGyMucOU9EWZ6sOIo28EcfnA3P
	luQv/7dyTZIBwIzStio4NZbDn31iB0g/XoybqdoEZWjV5pjRd3QJvuJuAH1lcRhT7fSqWA+Eebx
	wkSMPz8TZrVIZ/N4BctV4dh6qIXlBPD2G1qbGq9Nwt6A0Tp6i1o6z4warSDQP6LCb74QorPJQ0s
	OxZifaA1I2OtAbtY1Q/WdHzenr/GdJjvTwN8a6n9FcY5wv0SgO/DAOXyX1gdadFUkuUlCVCE=
X-Received: by 2002:a05:6512:61a4:b0:5c0:465:3fc6 with SMTP id
 2adb3069b0e04-5c1709ce71dmr805206e87.4.1794555962280; Thu, 12 Nov 2026
 23:46:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-sun8i-emac-mux-uaf-v1-1-308ae7e6fcf2@gmail.com> <e526541c-f91a-484b-a677-4c55e4a96a7b@lunn.ch>
In-Reply-To: <e526541c-f91a-484b-a677-4c55e4a96a7b@lunn.ch>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 12 Nov 2026 23:45:50 -0800
X-Gm-Features: AclHuK-IYiE1aDGEHibGFo-Q3L4DjiCYZIfUZ-5mDw69KYbW_QlhkXjxqGYSAjo
Message-ID: <CAEy9hNX_E0riGS-TdDogDWMv3-fpAVFLAjx8F0cvq4Q_rH3REA@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-sun8i: Fix use-after-free in the
 MDIO mux error path
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Does this bother anybody? Seems more like this should be for net-next.

No user report. Sashiko found it while reviewing another patch of
mine to this driver, and I have no board with the internal PHY to hit
the error path. I'll resend it for net-next without the stable Cc.

Arun
