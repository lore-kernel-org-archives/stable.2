Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032549;
	b=e/OaIhuNcoq5V8HQCfq+S2ras2djMJIIytryYeHIt7BVgWuP5R6T9sdK22LeVo71dXbu
	 dEC7+PGu9v+9LXMDLa6jCB15k2B6cEwbgbXCavpeBGDegef5A1efmzFo1bUphNiZhJKux
	 L6YBJ0FW8vGr/bhJ3IF2QMGVZP3zWvyrvIBAAJXgok4q0xte9Y07CjxkVR5DSussL3TZs
	 v625j4FrW9AyEaZ16+r+Wzq8H4zo7cab8/Csppu3uCVllov+jP85eNqqCaETfnlCKczAV
	 z+hFfENguLs8nWXlFcszfFiG3FMPcEbT9iwqIxR+QQaMKxEy1jRfSrbb8HVPhlVZTtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/RRjWL641RBXdzvfFkW2sLfC2on1rvjj7bWT9M3oy9g=;
	b=j6GosTyrIEZQNc/821FDUC6oaUgDF7cGZQS3w63E14Wx4wtCGLhtAo2xPm4W8cMUaUkL
	 OY58EkfwD2JRwyouZlYJmvXvAezP23qSEKp7HmqnaWDKiE7gLvSblJHC5YpjIpU+DkQ47
	 pv1pHzz52P/JrFfe1w1crjLrKT5hop8gAgUFZS3PhvbGHBgVsDHvSOMHVfoRs7XYcpDwZ
	 eXqj2vuss+Myr/UDwa9c7+VVQwIWNEpxZX3gvNby09NdcOWrhiPGTW2twEAWiiBCfNNs1
	 lpTq1We3jawcas2aKX/vaAi8zts8EGAqQkkPmPMUrrK98pQ6AJZmUtj00dVHkTL640g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xkiKwyBP;
	arc=none smtp.remote-ip=74.125.231.74
Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6960A2604
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 20:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D6960A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xkiKwyBP
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-4b5cae8da04so467412fac.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795032547; x=1795637347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RRjWL641RBXdzvfFkW2sLfC2on1rvjj7bWT9M3oy9g=;
        b=xkiKwyBPVGawK7J/tlzEx1mo0Ay4q4b9GywizrlXAJ5/stojHBAIFVgccMIdIu391+
         DhKtTcdHCXoH2U7I3tyo0p9ZgQ2pnkYzk2IbL7GMMnF8vl2y1snphwmJVXpLm9Cf3FEi
         u23N2ko+MKkgXuaCkJK6tgNfHb1u0B57ALpLSoJ16FCqlvQoYK750kiHuNwYxK0L7Sls
         w6uJ+GcuVFVFEbsrPO/BHOoY7z1Nl6K8ZXmMpYENAy+fvp624SUlDiKJj1WC5FttG7Xk
         CG806FoLmN2QLgQBxnJelLiRZwlwWGMT7Rq5BEWK9M7l2n6NTCriOWAoBV3AsUh6gPt+
         /V0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032547; x=1795637347;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RRjWL641RBXdzvfFkW2sLfC2on1rvjj7bWT9M3oy9g=;
        b=xyw9LRWofC2eyY197pPODU8Cx4GJB6BlnSOBUwxzcYVbHalLqunnp7U2blD8MEpgBh
         bu489SmxEnVZV4Zap3Kc6HvXzbSrbu13gY0mx2kZODfvTMX3fOfch08eeiK0K+4a6jzm
         QeHxKUloF08P4g3TC6AP8xmhTkReqnyNVm5LM1DjGMZzYk49PhQq6b0IvZwAinSQv4AC
         gYXNKCE3+Ox0KGunoJelSC1g9+ul78v+rXfBDrrxpvqrLqehtzkmVB7GpY2ZKLWXI+x2
         /JPWun1N3ajkxe6IAGySOWVbbgH3F4QCuwlw60CL+iQ8xRhMR8FIAzi/SyqrtN4i7HoY
         Wk5w==
X-Forwarded-Encrypted: i=1; AL+hErGM3HVPQ0+HhFqjDFMTV/VLPVkVsCj1bStcaDQuVkCckpKFj/U2Rl4rlHgfwmJsP+HNp8xYukQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FjrJx3BkcBOD4Tubt6yZfFHmnzlOSTdaB+XQFo7Iwar6WbYNl
	c8pk5GQyYKPGu+219oPPZvBfWgUqccjyhF/B9XPZv3IfLdAN5WHg6fwz4uFwHyWYkr29JQ==
X-Gm-Gg: AYBFou3I8Vn6OlEPPvzSeeE0yC6Fweq169ukcDys89HJaGbwfwe6l12hRqOS9IMOOlc
	Xgu3jsa5Uyao1dke0ooHorKQ3Nh2ehgX5aSJEkI9Wz+e+FhjGN0D0As0DC1I6MnzsaTv1z3Wy/h
	l0d3KIobEkSOl8k2vCQkDrnXsWOr5e3sA80OXCcaqW2ZT9DU+3UeMwlJPB5K5diN9l0rIld/QVU
	qoV6hhCQVk8+K3IW9qlpB/jd0E/z2pNNFM9E8hX3B+z72OPfXlDHCW/dpTwKLSk7IvXW3Uc4tqx
	V9AvGUg18QH9coSk8eFjs741GaEqFYc9bP1d7F+dsmHnvt9nysZYLs9bLvS+inzCBHelycx2o/3
	U+90YOV1VbLD4EBCqW4RI0YwvDZdMq4w9RHZdVBOOu1OPOPz0Pw5e+QlDBrLJ6HwBGn6n74/JZI
	u90F1yOz6nvJv99ZDPC2jnzyFzpwTfMRe4bDkodcPcKXguFVG0cO3XZfvMhD1d+S11HiFlRMeRN
	9+nU8BApOGbbisemnqiWxb3Y8HOIsnMlITChmHdjRyoQoZEpTBp195/cNv4BWGWh4uXoF4VuhFy
	EH8t5/6n44teS6F9nVAlKeuXNno2Q1ZVyTn1Obe6cco88o52VOIeZxZldoX3nmhUCe1qVVVKEfg
	YQdeF/1NnGh01O+0PcmdOyJz0qJ0lnABIsq0F/Fxi
X-Received: by 2002:a05:6871:5311:b0:49d:e1d3:e6e5 with SMTP id 586e51a60fabf-4b75d550969mr3282678fac.43.1795032546658;
        Wed, 18 Nov 2026 12:09:06 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b7437258efsm3148235fac.5.2026.11.18.12.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 12:09:06 -0800 (PST)
Message-ID: <b662ae67-94a2-4e71-9578-d380ba19938d@gmail.com>
Date: Wed, 18 Nov 2026 14:09:03 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rva333@protonmail.com
Cc: airlied@gmail.com, angelogioacchino.delregno@collabora.com,
 bisson.gary@gmail.com, chunkuang.hu@kernel.org, ck.hu@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, simona@ffwll.ch,
 stable@vger.kernel.org
References: <20261117-6768-dsi-fix-v2-1-6654a072884e@protonmail.com>
Subject: Re: [PATCH v2] drm/mediatek: mtk_dsi: do not enable HS clock in
 pre-enable for LPM panels
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261117-6768-dsi-fix-v2-1-6654a072884e@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On Tue, Nov 17, 2026, Roman Vivchar wrote:
 > Only enable the HS clock in mtk_dsi_bridge_atomic_pre_enable(), when
 > MIPI_DSI_MODE_LPM is not set, and restore mtk_dsi_clk_hs_mode(dsi, 1) in
 > mtk_output_dsi_enable(). This is a no-op for non-LPM bridges.

Tested on MT8173 (Amazon Fire HD 10 2017). The Novatek NT51021 panel on 
this device sets MIPI_DSI_MODE_LPM, on v7.4-rc3. Tested with repeating 
blank/unblank cycles, and verified the init commands complete and the 
link ends up in HS video mode as before.

Tested-by: Ryan Brue <ryanbrue.dev@gmail.com> # MT8173, NT51021
