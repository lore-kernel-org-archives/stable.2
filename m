Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795640666;
	b=2hCHXkFFseEsO2dDj1ZA+1GsdgkFnE2nta+i1TI+kR/c9AW83zEYiU2C6+pTevuTzhYT
	 f1CxDHbBocq4mLay7ooyuOD9CDG5+v0JhDi6afRiM/tsnjlpqqmWUS2iVyqfL8Nax/CK4
	 8SYuKbudZjmIBLx/TGA0qXRVED2qrRB6k27hNN4vhLSGP7yBFHnKNON0hTKv6+XzWnaAe
	 7dcKQorwv+OgmFcpcjzMdzqQKpdRIW5SZcRWCoY9Bk0ozlaVjwdUbLB72GF/88dpzRVDY
	 3d4qD9NuE8Kb7rTud56CAZN3k2W+g38ZvWhfs8rGw0VIpxZJFm/MDTUpOw43j0nwKAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jAVSepPFXDVnDs0KIr6D847y94ZRdB5eQ9a+FnzieW4=;
	b=WhcuvWb7gM5qo/FHCnMewweZalFMDzD7V72pBdxMsVvvTyz9F6IMoOKhexBbAagqI/FB
	 lAcYiqe/st8t33+fqh6aEBI6UcElKXx6POwxkheHGDHQOZ//tLkNvBepE9SnjtFqIAGVf
	 6mbh17WsCzjGd5V9UwJZDXpm1fbhMQiUNyb2RjG02XwZoPe/KFLIswSawkCarw78vScOT
	 vvyv7Vu1EgFui97QqtZE1DcMZwBZqYaae8oxqKJyuxMmay348csZMNM0qw/pLKXuB7Ifz
	 uiQCnLDFzdxWRAFFKgsuy9i5v4vyq2MtAMOdDQ/ikAnd3IosYcDPSyn6oMiV7aAg6LA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tCCn15NC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD1606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37DD1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tCCn15NC
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b8a1f59d5eso8258187a12.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:04:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795640664; cv=none;
        d=google.com; s=arc-20260327;
        b=LLkIfd5B72O73mqLG46+WHNSmk4MZm3ydtWrBBvi2GuUL9niS6oEL7vzO/f8tuRadY
         RAESzcskuyq3aqYSXHm0VPPijy/7B6AW5o88Old25TW7oG6ovx9O4ftvtmiJNFpK+0ZS
         BsV79K+7W11lpyF5W51nMFrwBoIoX5OYrAtehK8k+CpVvDSfDRck65MoQcG+pn3+DsCb
         AZAjY8DKXd7SNcKcJ1nVQ2RTg5KCra8s41G9nGhrbofnDTH73jzbwzm1Qu7ed/nwi4OF
         CkYhczBbwI60bMhrbhjFg14qipnyllZ76JM31sanm2hn83jkWjnnYpv8o6zxqcFqwzVv
         RmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jAVSepPFXDVnDs0KIr6D847y94ZRdB5eQ9a+FnzieW4=;
        fh=0PmyvCsaZYmWUN2vdh27G7kf0WpRsayhPtt2U4Y/v4s=;
        b=FqIoZLcj5FvvrZ9voZS+DM3f3g3SEvusvKnImnQ242aiuMMqyzcQ+uxBuMTBS05LrM
         3jFLU4ney/xe/0GI4wXC1vdEaEnUTSICo3cKQ9q7pBE62NgiXhgmtyHkWEU0Lbr/FVVT
         Sxu3ujPT2IJFiMZVq4vJqKwH0X4Dl2wqcabMMolkGdNpQHlMKnxmRQdP/D6XMLENsqFd
         avBk04k3F+nK9ecLT6gLUUiFDKp5ZmfEtZlr1zT9HeXALQ5qzZeyGpmeajFF45Em0+pU
         Dk4ny5Q1VrQOQBf945Mtn7YogDbEVXTNloE3z5jAK+nGQFmusZe8sAp0IZvJZ+welMk2
         UeIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795640664; x=1796245464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jAVSepPFXDVnDs0KIr6D847y94ZRdB5eQ9a+FnzieW4=;
        b=tCCn15NCr6B2s9h+dyEIhTKGSEflko+n1w04t5bIriAO1IiieN2gSHg4HV/WEl8n/n
         skh/ncZgrssBgOFYKeg6/d1gqPkQ+VBgVEG/t2TuVmvnrdFK80K40DCRzylsB0yBptCm
         V0MKB1Dme+IWbdkFs3CtcbbOj20PlcP3As7bsHwvAQD9goiLsN53yAcBR+OscqGBBrTj
         8qeE+Zqh/Nqhm1nMzruqVFpfGBAp5IBQLBIbqiV2731/Ihk1h93G0CVEpeVMmljB/1xX
         TYB0fIb5FrlJVeTKex+6oDGPwnRB9RWtA5t3Vs0ATeF0EMW0RKniAXkORt6y9Vz3uezV
         iYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640664; x=1796245464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jAVSepPFXDVnDs0KIr6D847y94ZRdB5eQ9a+FnzieW4=;
        b=oxJq6G3oGp/uSufeiJ//PUqKqL1lFnUI47HNddh42tZw7QOI/dK8Je/jnRhttziePZ
         8WpaQpjA+b+8BGpwEoWxF12LcDrAihdnTB9tNwwpPM5U28OISssdW4Rwo+UG+NHr4Hj7
         8NucpJ5O/F8FK39x+moM5lUPB7Pv6JW8eAYpMwUCwTCRNpzFkjwYdj+guGSycy6rlKuS
         nBpgjhdLjwj9U+AhovGBwL7zqrmDmlhirCChhRWUX56gZLqq6f7Lv9YdwQWHzOVZdik6
         AJi8FNi7TIcw2wUYKRgcCpWfB2nXxpqr0llCKwG0ETXwCe/XMJ4vXH3aGvjnQDwOTFtf
         B97A==
X-Forwarded-Encrypted: i=1; AL+hErGpnXPO+LxvC1aEYZqIZVrOy5X9zEQ8Wxl7+goWinYXeG4Ug3MeR3vEwNaQnqkXq4YTxcknK8o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8v2tWgh0C/JxdGCHygILu+DBg+zIBwkl7/NjhVn2LKZYs5hm5a
	OSiqVKwujCd6S94JFeyd1wInYM3EEbzCqwI38EQ5dvWiTtTGyA4JUk38gPdowjSAbs0FIqt0oZo
	n1RMYpyhn7h17A19o4ZTS5tmV1ZT1ApRFwmErjhpJoA==
X-Gm-Gg: AZFdTZdgNYVqcum2ED5VNwOHABZl3cnhXpjB5Xj2COgqj6hZWwKnk2HrNV+uue+YO1H
	sG9DLmQVgO6WFobVnicueDdH/u7CV5gTSaUQPfsawzuSH8q4VGwoQomOjo2+bKKNY4kpd2tIYc5
	V4eai5bk7G53rn46Hw0I/EOSN8S+qf92I0tBCwObOSl9ss6ahfenzedSOmBAcoD09doFhkY95Bq
	92GkJL3SEyB0flUsIITbMa05wg6cBWURddP9SbRaiLphsI/5r89LQYkj7pgTlXQOMuFSJ2XRybM
	O97XUOFnx1m7T9QfP87RGVR6ox/hM5tLH6g6yM5e6z1w4BSzdFxMqW6JP5GC6N7uIT85GNswbs5
	dyAcHRIDtUqzlIB7Yjdj0pVdvejLsQGxz1JrxvdJkNhqBdATpY2jGLM4z5M6xUDAKnxbBt20=
X-Received: by 2002:aa7:c0d0:0:b0:6ba:144f:ae43 with SMTP id
 4fb4d7f45d1cf-6ba37c7b138mr10360793a12.6.1795640663702; Wed, 25 Nov 2026
 13:04:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-gs101-usb-phy-orientation-v2-0-3361fa5f7543@linaro.org> <20261123-gs101-usb-phy-orientation-v2-2-3361fa5f7543@linaro.org>
In-Reply-To: <20261123-gs101-usb-phy-orientation-v2-2-3361fa5f7543@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 25 Nov 2026 21:04:11 +0000
X-Gm-Features: Aa3M54oVBZq5tOYyeoj6arLLradCyxNln2xhQ16gdyoLzIDJohPkD6NVk6Xh8SE
Message-ID: <CADrjBPpE+2n1Y=02Ayz8i8guJ58XBzdG5zVdLJW5ZhQQKiNmNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] phy: exynos5-usbdrd: apply gs101 postlock tuning
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, RD Babiera <rdbabiera@google.com>, 
	Juan Yescas <jyescas@google.com>, kernel-team@android.com, phone-devel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Nov 2026 at 14:25, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Phy tunings to be applied after lock are never applied on gs101.
>
> On gs101, gs101_tunes_pipe3_postlock[] disables the high-speed squelch
> detector when in P3 / U3 to save some power. In U3 (USB3 suspend) there
> is no SuperSpeed data traffic to detect, and link wakeup uses LFPS
> through a separate low-frequency detector. Disabling the high-speed RX
> squelch detector in U3 avoids keeping it powered while the link is
> suspended.
>
> Apply PTS_PIPE3_POSTLOCK once the PLL and the CDR have locked.
>
> Fixes: 32267c29bc7d ("phy: exynos5-usbdrd: support Exynos USBDRD 3.1 comb=
o phy (HS & SS)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsu=
ng/phy-exynos5-usbdrd.c
> index ccaf0f27c4c8..f647688c3bfb 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -1745,6 +1745,8 @@ static int exynos5_usbdrd_gs101_pipe3_init(struct e=
xynos5_usbdrd_phy *phy_drd)
>         if (ret)
>                 return ret;
>
> +       exynos5_usbdrd_apply_phy_tunes(phy_drd, PTS_PIPE3_POSTLOCK);
> +
>         /*
>          * Set this while still holding phy_mutex, so that the orientatio=
n
>          * switch callback can't miss an orientation change.
>
> --
> 2.56.1.750.gf70dc682cf-goog
>
